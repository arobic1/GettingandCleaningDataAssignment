cleanData <- function() {
  # To fit the entire values stored in the test and train samples
  options(digits = 8)
  # Download zip file from source
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Samsung_data.zip")
  # Set the extracting dir name
  outdirname <- "UCI_HAR_Dataset"
  # extract the zip acrchive files and move to the chosen dir
  unzip("Samsung_data.zip",exdir=outdirname)
  setwd(outdirname)
  # Create vector of colNames from the features.txt file
  feat <- as.vector(read.table("features.txt")$V2)
  # Read in the dataset include the subject id and the activity label in one shot
  testdf <- cbind(read.table("test/subject_test.txt"),read.table("test/y_test.txt"),read.table("test/X_test.txt"))
  # Adding the variable names info to the df
  colnames(testdf) <- c("subjectid","activity",feat)
  # Do the same for the train df
  testdf <- cbind(read.table("train/subject_train.txt"),read.table("train/y_train.txt"),read.table("train/X_train.txt"))
  colnames(traindf) <- c("subjectid","activity",feat)
  
  
}