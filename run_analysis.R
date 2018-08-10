## Here are the data for the project:
   ## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Set working directory
filepath <- "/Users/Jana/Documents/Data Analysis/R Programming Exercises/Getting-and-cleaning-data"
setwd(filepath)
getwd()


## Download the data
fname <- "phonedata.zip"
download_if_not_exists <- function(fname, url) {
    if (!file.exists(fname)) 
        download.file(url, destfile = fname, method = "curl")  
}
download_if_not_exists(fname, "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
unzip("phonedata.zip")

## Load required packages
library(dplyr)
library(data.table)
library(tidyr)

filepath <- "/Users/Jana/Documents/Data Analysis/R Programming Exercises/Getting-and-cleaning-data/UCI HAR Dataset"

dataSubjectTrain <- tbl_df(read.table(file.path(filepath, "train", "subject_train.txt")))
dataSubjectTest  <- tbl_df(read.table(file.path(filepath, "test" , "subject_test.txt" )))

dataActivityTrain <- tbl_df(read.table(file.path(filepath, "train", "Y_train.txt")))
dataActivityTest  <- tbl_df(read.table(file.path(filepath, "test" , "Y_test.txt" )))

dataTrain <- tbl_df(read.table(file.path(filepath, "train", "X_train.txt")))
dataTest  <- tbl_df(read.table(file.path(filepath, "test" , "X_test.txt" )))


## You should create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.

## Combine Subject files
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(dataSubject, "V1", "Subject")

## Combine Activity files
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
setnames(dataActivity, "V1", "activityNumber")

## Combine Data files
data <- rbind(dataTrain, dataTest)

## Add column names into the 
dataFeatures <- tbl_df(read.table(file.path(filepath, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNumber", "featureNames"))
colnames(data) <- dataFeatures$featureNames

## Add column names to the activity labels
activityLabels <- tbl_df(read.table(file.path(filepath, "activity_labels.txt")))
setnames(activityLabels, c("activityNumber", "activityName"))

## Combine data with subject and activity
dataSubjectAndActivity <- cbind(dataSubject, dataActivity)
data <- cbind(dataSubjectAndActivity, data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)", dataFeatures$featureNames, value = TRUE)
dataFeaturesMeanStd <- union(c("Subject", "activityNumber"), dataFeaturesMeanStd)
data <- subset(data, select = dataFeaturesMeanStd)

## 3. Uses descriptive activity names to name the activities in the data set
data <- merge(activityLabels, data, by = "activityNumber", all.x = TRUE)
data$activityName <- as.character(data$activityName) 

## 4. Appropriately labels the data set with descriptive variable names.
names(data) <- gsub("std()", "SD", names(data))
names(data) <- gsub("mean()", "MEAN", names(data))
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
write.table(data, "CleanedData.txt", row.names = FALSE)
