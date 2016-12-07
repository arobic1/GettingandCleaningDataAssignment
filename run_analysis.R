require(dplyr)

# This function returns two data frames in a list. The first object is the tidy data from the UCI HAR Dataset, 
# the second object is a processed version of this tidy data, with means of variables per subjectid for each activity.
cleanData <- function() {
  # Save current location
  origin <- getwd()
  # To fit the entire values stored in the test and train samples
  options(digits = 8)
  # Download zip file from source
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Samsung_data.zip")
  # extract the zip acrchive files and move to the chosen dir
  unzip("Samsung_data.zip")
  outdirname <- grep("UCI",list.files(),value=T)
  setwd(outdirname)
  # Create vector of colNames from the features.txt file
  feat <- as.vector(read.table("features.txt")$V2)
  # Read in the dataset include the subject id and the activity label in one shot
  testdf <- cbind(read.table("test/subject_test.txt"),read.table("test/y_test.txt"),read.table("test/X_test.txt"))
  # Make the col names unique first (as they are not in features.txt)
  feat <- make.names(feat,unique=T)
  # Adding the variable names info to the df
  colnames(testdf) <- c("subjectid","activity",feat)
  # Do the same for the train df
  traindf <- cbind(read.table("train/subject_train.txt"),read.table("train/y_train.txt"),read.table("train/X_train.txt"))
  colnames(traindf) <- c("subjectid","activity",feat)
  # Merge the train and test df
  alldf <- rbind(testdf,traindf)
  sorted_alldf <- arrange(alldf,subjectid)
  # select only cols for means and stds. 
  my_subcol <- sort(c(1,2,grep("mean.",colnames(sorted_alldf),fixed=T),grep("std.",colnames(sorted_alldf),fixed=T)))
  final_alldf <- sorted_alldf %>% select(my_subcol)
  # Create activity cols and remove original activity col
  final_alldf <- mutate(final_alldf,Walking = as.logical(ifelse(activity==1,"True","False")),
         WalkingUpstairs = as.logical(ifelse(activity==2,"True","False")),
         WalkingDownstairs = as.logical(ifelse(activity==3,"True","False")),
         Sitting = as.logical(ifelse(activity==4,"True","False")),
         Standing = as.logical(ifelse(activity==5,"True","False")),
         Laying = as.logical(ifelse(activity==6,"True","False"))
         )
  final_alldf <- select(final_alldf,-activity)
  #rename columns with more descriptive names
  my_vect <- colnames(final_alldf)
  my_vect <- sub("^t","Time",my_vect)
  my_vect <- sub("^f","Frequency",my_vect)
  my_vect <- sub("Acc","Accelerometer",my_vect)
  my_vect <- sub("Gyro","Gyroscope",my_vect)
  my_vect <- sub("BodyBody","Body",my_vect)
  my_vect <- sub("Mag","Magnitude",my_vect)
  my_vect <- sub("\\.mean\\.\\.\\.(.)","\\1Mean",my_vect)
  my_vect <- sub("\\.mean\\.\\.","Mean",my_vect)
  my_vect <- sub("\\.std\\.\\.\\.(.)","\\1StandardDeviation",my_vect)
  my_vect <- sub("\\.std\\.\\.","StandardDeviation",my_vect)
  colnames(final_alldf) <- my_vect
  ########################
  # New dataset creation #
  ########################
  # Modify var names to reflect new calculation
  my_vect <- sub("Mean","MeanMeanPerSubject",my_vect)
  my_vect <- sub("Deviation","DeviationMeanPerSubject",my_vect)
  # Create new empty df
  new_df <- data.frame()
  # Select data for each subjectid and activity
  num_subjects <- max(final_alldf$subjectid)
  for (i in 1:num_subjects) {
    meancalc <- filter(final_alldf,subjectid==i,Walking==T) %>% select(starts_with("Time"),starts_with("Frequency")) %>% sapply(mean)
    if (i==1) {
      new_df <- rbind(c(i,meancalc,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE))
    } else {
      new_df <- rbind(new_df,c(i,meancalc,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE))
    }
    meancalc <- filter(final_alldf,subjectid==i,WalkingUpstairs==T) %>% select(starts_with("Time"),starts_with("Frequency")) %>% sapply(mean)
    new_df <- rbind(new_df,c(i,meancalc,FALSE,TRUE,FALSE,FALSE,FALSE,FALSE))
    meancalc <- filter(final_alldf,subjectid==i,WalkingDownstairs==T) %>% select(starts_with("Time"),starts_with("Frequency")) %>% sapply(mean)
    new_df <- rbind(new_df,c(i,meancalc,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE))
    meancalc <- filter(final_alldf,subjectid==i,Sitting==T) %>% select(starts_with("Time"),starts_with("Frequency")) %>% sapply(mean)
    new_df <- rbind(new_df,c(i,meancalc,FALSE,FALSE,FALSE,TRUE,FALSE,FALSE))
    meancalc <- filter(final_alldf,subjectid==i,Standing==T) %>% select(starts_with("Time"),starts_with("Frequency")) %>% sapply(mean)
    new_df <- rbind(new_df,c(i,meancalc,FALSE,FALSE,FALSE,FALSE,TRUE,FALSE))
    meancalc <- filter(final_alldf,subjectid==i,Laying==T) %>% select(starts_with("Time"),starts_with("Frequency")) %>% sapply(mean)
    new_df <- rbind(new_df,c(i,meancalc,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE))
  }
  # Change variable type for the activity columns
  new_df <- as.data.frame(new_df)
  colnames(new_df) <- my_vect
  new_df$subjectid <- as.integer(new_df$subjectid)
  new_df$Walking <- as.logical(new_df$Walking)
  new_df$WalkingUpstairs <- as.logical(new_df$WalkingUpstairs)
  new_df$WalkingDownstairs <- as.logical(new_df$WalkingDownstairs)
  new_df$Sitting <- as.logical(new_df$Sitting)
  new_df$Standing <- as.logical(new_df$Standing)
  new_df$Laying <- as.logical(new_df$Laying)
  # Return to our original working dir
  setwd(origin)
  # Finally, output the 2 objects
  my_list <- list("original data" = final_alldf, "processed data" = new_df)
  return(my_list)
}