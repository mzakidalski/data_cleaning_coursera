library("downloader")
library("files")
                
DOWNLOAD_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
LOCAL_FOLDER <- "./data"
DATASET_ZIP_PATH <- "./dataset.zip"
DATASET_UNZIPPED_FOLDER <- "UCI HAR Dataset";
TEST_FOLDER <- "./test"
TRAIN_FOLDER <- "./train"
MERGED_FOLDER <- "./merged"
TEST_PATTERN  <- "test"
MERGED_PATTERN <- "merged"


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
    download.file(DOWNLOAD_URL, DATASET_ZIP_PATH, method="auto", cacheOK = FALSE)
    unzip(DATASET_ZIP_PATH)
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

mergeDataSets <- function() {
  pathToDataSet <- paste0("./", DATASET_UNZIPPED_FOLDER);
  setwd(pathToDataSet);
  
  if (!file.exists(MERGED_FOLDER)) {
    dir.create(MERGED_FOLDER)
  }
  
  fileNamePattern <- "([:alnum:]||_)+\\.txt";
  
  testDataFiles  <- list.files(path=TEST_FOLDER,  full.names= TRUE, 
                                                  recursive = TRUE, 
                                                  include.dirs = FALSE, pattern=fileNamePattern);
  
  trainDataFiles <- list.files(path=TRAIN_FOLDER, full.names= TRUE, 
                                                  recursive = TRUE, 
                                                  include.dirs = FALSE, pattern=fileNamePattern);
  
  for (i  in 0:length(testDataFiles)) {
     destFileName <- gsub(TEST_PATTERN, MERGED_PATTERN, testDataFiles[i]);
     mergeTwoFiles(destFileName,testDataFiles[i], trainDataFiles[i]);
     
     print(testDataFiles[i]);
     print(trainDataFiles[i]);
     print(" ");
  }
  
}


main <- function() {
  initialDirectory <- getwd();
  getAndUnzipData()
  mergeDataSets()
  setwd( initialDirectory);
}

main()