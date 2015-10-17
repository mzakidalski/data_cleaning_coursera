library("downloader")
library("files")
library("data.table")
library("dplyr")

                
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


##
## Step 0 - creating folder for data,
##        - downloading file into it
##        - unzipping the data

getAndUnzipData <- function() {
  print(" ")
  print("Step 0 - creating folder and downloading data");
  
  if (!file.exists(LOCAL_FOLDER)) {
    dir.create(LOCAL_FOLDER);
    setwd(LOCAL_FOLDER);
    pathToDataSet <- paste0("../",DOWNLOADED_DATASET_NAME);
    if (file.exists(pathToDataSet)) {
      file.copy(pathToDataSet,".");
      file.rename(paste0("./",DOWNLOADED_DATASET_NAME), DATASET_ZIP_PATH);
    } else {
      download.file(DOWNLOAD_URL, DATASET_ZIP_PATH, method="auto", cacheOK = FALSE);
    }
    unzip(DATASET_ZIP_PATH);
  } else {
    setwd(LOCAL_FOLDER);
    print(" Folder ./data exists!");
    print(" Script did not download once again dataset.");
    print(" For redownloading data just delete the ./data folder");
  }
  
  print("Step 0 has been successfully finished")
}


##
## Step 1 - merging test and train datasets into one
##
##
##
mergeTwoFiles <- function(destFileName, sourceFileNameOne, sourceFileNameTwo) {
  if (!file.exists(destFileName)) {
    file.create(destFileName);
  }
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

filterFeatureVector <- function() {
  pathToFeatures <- paste0("./", FEATURES_FILE_NAME);
  allFeaturesList <- fread(pathToFeatures);
  
  colNames <- c("id", "feature_name");
  setnames(allFeaturesList, colNames);
  
  print(summary(allFeaturesList));
  allFeaturesList <- allFeaturesList[grep("mean\(\)", feature_name)];   
    
  print(allFeaturesList);
  
}

extractMeanStdDev <- function() {
  print("");
  print("Step 2 - extracting only the mean and std dev for each measurement");
  print(getwd());
  
  featureVector <- filterFeatureVector();
  print(" ");
  
}


main <- function() {
  initialDirectory <- getwd();
  getAndUnzipData();
  mergeDataSets();
  extractMeanStdDev();
  setwd( initialDirectory);
}

main()