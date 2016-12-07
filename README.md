# GettingandCleaningDataAssignment

This repository contains code to process the UCI HAR Dataset, which available at the following link.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Information on the dataset can be found at the link below.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In this repo, you will find 3 files:

* README.md (this file)
* CodeBook.md
* run_analysis.R

The README.md file contains instructions on how to use the R scripts for data processing. The
CodeBook.md file contains details about the content of the processed data. Finally, the
run_analysis.R file is the R script that contains the function cleanData(). The function cleanData()
can be used to obtain a tidy dataset from the UCI HAR Dataset, as it returns a list of data.frames,
as explained in the file CodeBook.md. This script can be used in the following way, at the R prompt:

`> source("run_analysis.R")`
`> my_dfs <- cleanData()`
