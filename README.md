---
title: "README.MD"
author: "Marcin Zakidalski"
date: "October 24, 2015"
output: html_document
---

This README file is to describe the way the script run_analysis.R works. Reading of this script should be accompanied with reading of CodeBook. While this document covers the technicalies of the performed data clean-up, the latter one describes all variables available present in the clean output dataset.

The source dataset for this script is [Human Activity Recognition using smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) . This script was created as a homework project for ["Getting and cleaning data""](https://www.coursera.org/course/getdata) MOOC class.

Some partial results described below were saved in specified locations. Those file may not only serve for debug purposes but they may also serve as help in understanding the way the run_analysis.R script works. 

The script performs following operations:

1. **STEP 0** - creation of "data" directory  in the working directory and download of dataset into it (in case of its absence in the working directory). 

2. **STEP 1** - merge of training set and testing set into one data set - this step is executed done via concatenation of files: **(y_test.txt, y_test.txt)** and **(X_test.txt, X_train.txt)**. Result of the operation is saved in **${unzipped_dataset_folder}/merged** directory of unzipped dataset. 
Out of all available variables only those describing mean and std. deviation were chosen. In this particular case it was executed just by choosing variables containing _"mean()"_ or _"st()"_ in their names. As a result of design decision all variables representing mean frequency of some measurements (e.g. _fBodyAcc-meanFreq()-X_) were discarded during this extraction phase.

3. **STEP 3** - adding  descriptive names to the activities. Codes for activities are described in details in the CodeBook file.

4. **STEP 4** - appropriate labels for variables. Algorithm of variable name creation is described in the CodeBook file. Result of this step is saved in **${unzipped_dataset_folder}/dataset_before_groupind/data_before_grouping.txt**

5. **STEP 5** - data from the previous step is aggregated by the **(Subject_Id, Activity)** pair of columns. The columns in the output data set are replaced with the mean values of all observations from the  aggregation group. The final result is saved in **${unzipped_dataset_folder}/final_dataset/final_dataset.txt**.

All execution steps print the progress information to the console window. 



