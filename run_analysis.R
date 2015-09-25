library("downloader")

DOWNLOAD_URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
LOCAL_FOLDER = "./data"
DATASET_ZIP_PATH = "./dataset.zip"
#
# Step 0 - creating folder for data,
#        - downloading file into it
#        - unzipping the data

getAndUnzipData <- function() {
  print("Step 0 - creating folder and downloading data");
  if (!file.exists(LOCAL_FOLDER)) {
    dir.create(LOCAL_FOLDER);
  }
  setwd(LOCAL_FOLDER);
  download.file(DOWNLOAD_URL, DATASET_ZIP_PATH, method="auto", cacheOK = FALSE)
  unzip(DATASET_ZIP_PATH)
  print("Step 0 has been successfully finished")
}

main <- function() {
  getAndUnzipData()
}

main()