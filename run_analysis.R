library("downloader")
library("files")
library("data.table")
library("dplyr")
library("plyr")
                
DOWNLOAD_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
LOCAL_FOLDER <- "./data"
DATASET_ZIP_PATH <- "./dataset.zip"
DATASET_UNZIPPED_FOLDER <- "UCI HAR Dataset";
TEST_FOLDER <- "./test"
TRAIN_FOLDER <- "./train"
MERGED_FOLDER <- "./merged"
INERTIAL_SIGNALS_FOLDER <- "./merged/Inertial Signals"
TEST_PATTERN  <- "test"
MERGED_PATTERN <- "merged"
DOWNLOADED_DATASET_NAME <- "getdata_projectfiles_UCI HAR Dataset.zip"
FEATURES_FILE_NAME <- "features.txt"
MEAN_STD_DEV_MEASURES_REGEXP <- "(mean\\(\\))|(std\\(\\))"
Y_MERGED_PATH <- "./merged/y_merged.txt"
X_MERGED_PATH <- "./merged/X_merged.txt"
SUBJECT_MERGED_PATH <- "./merged/subject_merged.txt"
ACTIVITY_LABELS_PATH <- "./activity_labels.txt"
DATASET_BEFORE_GROUPING_FOLDER <- "./dataset_before_grouping"
DATASET_BEFORE_GROUPING_FILE <-"data_before_grouping.txt"
FINAL_DATASET_FOLDER <- "./final_dataset"
FINAL_DATASET_FILE <-"final_dataset.txt"

getAndUnzipData <- function() {
  print(" ")
  print("Step 0 - creating folder and downloading data");
  
  if (!dir.exists(LOCAL_FOLDER)) {
    dir.create(LOCAL_FOLDER);
  }
  setwd(LOCAL_FOLDER);
  pathToDataSet <- paste0("../",DOWNLOADED_DATASET_NAME);
  print(getwd());
  print(pathToDataSet);
  if (file.exists(pathToDataSet)) {
    file.copy(pathToDataSet,".");
    file.rename(paste0("./",DOWNLOADED_DATASET_NAME), DATASET_ZIP_PATH);
  } else {
    download.file(DOWNLOAD_URL, DATASET_ZIP_PATH, method="auto", cacheOK = FALSE);
    file.copy(DATASET_ZIP_PATH,"..");
    file.rename(paste0("../",DATASET_ZIP_PATH), paste0("../",DOWNLOADED_DATASET_NAME));
  }
  unzip(DATASET_ZIP_PATH);
 
  print("Step 0 has been successfully finished")
}


mergeTwoFiles <- function(destFileName, sourceFileNameOne, sourceFileNameTwo) {
  if (file.exists(destFileName)) {
    file.remove(destFileName);
  } 
  file.create(destFileName);
  
  file.append(destFileName, sourceFileNameOne);
  file.append(destFileName, sourceFileNameTwo);
}

createFolderIfNecessary<- function(path) {
  if (!dir.exists(path)) {
    dir.create(path);
  }
  
}

mergeDataSets <- function() {
  print(" ")
  print("Step 1 - merging train data set and test data set into one set.");
  print("Result would be available in folder merged");
  pathToDataSet <- paste0("./", DATASET_UNZIPPED_FOLDER);
  setwd(pathToDataSet);
  
  createFolderIfNecessary(MERGED_FOLDER);
  createFolderIfNecessary(INERTIAL_SIGNALS_FOLDER);
  
  fileNamePattern <- "([:alnum:]||_)+\\.txt";
  
  testDataFiles  <- list.files(path=TEST_FOLDER,  full.names= TRUE, 
                                                  recursive = TRUE, 
                                                  include.dirs = FALSE, pattern=fileNamePattern);
  
  trainDataFiles <- list.files(path=TRAIN_FOLDER, full.names= TRUE, 
                                                  recursive = TRUE, 
                                                  include.dirs = FALSE, pattern=fileNamePattern);
  
  for (i  in 1:length(testDataFiles)) {
     destFileName <- gsub(TEST_PATTERN, MERGED_PATTERN, testDataFiles[i]);
     mergeTwoFiles(destFileName,testDataFiles[i], trainDataFiles[i]);
  }
  print("Step 1 has been successfully finished");
  
}

addValueToString<- function(result, original, regex, toAdd) {
  matchingIds <- grep(regex, original);
  for (j in matchingIds) {
    result[j] <- paste0(result[j], toAdd);
  }
  return(result);
}

transformNameToReadable<-function(x) {

  result <- vector(mode = "character", length = length(x));
  regExps <- c("^t", "^f", "mean\\(\\)",  
               "std\\(\\)",  "Mag", "Body", 
               "Gyro", "Gravity", "Acc", 
               "Jerk", "-X", "-Y", 
               "-Z");
  readables <- c("Time", "Freq", "_Mean", 
                 "_Std_Deviation", "_Magnitude", "_Body", 
                 "_Gyroscope", "_Gravity", "_Accelerometer", 
                 "_Jerk", "_X_AXIS", "_Y_AXIS", 
                 "_Z_AXIS");

  for (j in 1:length(readables)) {
    result <- addValueToString(result, x, regExps[j], readables[j]);
  }
  
  return (result);
}

getFeatureList <- function() {
  pathToFeatures <- paste0("./", FEATURES_FILE_NAME);
  featuresList <- fread(pathToFeatures);
  
  colNames <- c("id", "feature_name");
  setnames(featuresList, colNames);
  
  featuresList <- featuresList[grep(MEAN_STD_DEV_MEASURES_REGEXP, feature_name)];
  featuresList <- featuresList[,readable_name:=transformNameToReadable(feature_name)];
  return (featuresList);
}


extractMeanStdDev <- function() {
  print("");
  print("Step 2 - extracting only the mean and std dev for each measurement");
  print("part of step 4 - naming the retrieved variables exactly the same as in features.txt");
    
  featureVector <- getFeatureList();
  cols = paste("V", featureVector[,id], sep="");
    
  allFeatureData <-fread(X_MERGED_PATH);
  allFeatureData <- allFeatureData[, cols, with = FALSE];
  names(allFeatureData) <- featureVector[,readable_name];
  allFeatureData <- allFeatureData[,id:=.I];
  setkey(allFeatureData, id);
  
  print("End of Step 2");
  print("End of part of Step 4");
  return(allFeatureData);
  
}

readActivityLabels <- function() {
  result <- fread(ACTIVITY_LABELS_PATH);
  colnames(result) <- c("Key","ActivityName");
  return(result);
}

useDescriptiveActivityNames <- function() {
  print("");
  print("Step 3 - use descriptive names on to name activities in the data set");
  
  pathToActivitiesFile <- paste0("./", Y_MERGED_PATH );
  activities <- fread(pathToActivitiesFile);

  activities <- activities[,id:=.I];
  colNames <- c("Activity","id");
  setnames(activities, colNames);
  setkey(activities, id);
  
  activityLabels <- readActivityLabels();
  activities <- activities[,Activity:=as.factor(Activity)];
  levels(activities$Activity) <- activityLabels[,ActivityName];
  
  print("End of step 3");
  return(activities);
  
}

readParticipants<-function() {
  print("");
  print("second part of step 4 - appropriate labels for variables");
  print("reading participants data");
  
  participants <- fread(SUBJECT_MERGED_PATH);
  participants <- participants[,id:=.I];
  colNames <- c("Subject_Id", "id");
  setnames(participants, colNames);
  setkey(participants, id);
  
  print("end of second part of step 4");
  print("");
  return(participants);
  
}

saveDataTable<-function(dataFrame, directory, file) {
  initialFolder <- getwd();
  if (!dir.exists(directory)) {
    dir.create(directory);  
  }
  setwd(directory);
  write.table(dataFrame, file, sep=",",  row.name=FALSE );
  setwd(initialFolder);
}

mergeAllTables<-function(x,y,z) {
  
  result <- merge(x, y, by = "id");
  result <- merge(result, z, by = "id");
  return(result);
}

aggregateByActivParticip<-function(mergedTables) {
  print("Step 5 - aggregating by Subject_Id and Activity");
  print("       - replacing all other columns with their mean values");
  result <- mergedTables %>% group_by(Subject_Id,Activity) %>% summarise_each(funs(mean)) %>% select(-id);
  saveDataTable(result,FINAL_DATASET_FOLDER, FINAL_DATASET_FILE);  
  print("Step 5 finished.");
  print("Final dataset available in:");
  print(paste0(FINAL_DATASET_FOLDER,"/",FINAL_DATASET_FILE));
  print(" ");
  print(" ");
}

main <- function() {
  initialDirectory <- getwd();
  
  getAndUnzipData();
  mergeDataSets();
  selectedFeatures <- extractMeanStdDev();
  activityNames <- useDescriptiveActivityNames();
  participants <- readParticipants();
  mergedTables <- mergeAllTables(participants, activityNames, selectedFeatures);
  saveDataTable(mergedTables,DATASET_BEFORE_GROUPING_FOLDER, DATASET_BEFORE_GROUPING_FILE);
  aggregateByActivParticip(mergedTables);
  
  print("Script ended successfully.");
  setwd( initialDirectory);
}

main()