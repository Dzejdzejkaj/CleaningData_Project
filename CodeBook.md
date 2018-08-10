---
title: "Codebook"
output: 
    html_document:
        keep_md: true
---

### Introduction

This codebook describes the process of cleaning the 'UCI HAR Dataset' that contains the activity data collected from a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured.

Original data are from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Process
1. The script for data cleaning is saved in the file 'run_analysis.R' and it includes a detailed commentary.
2. First the data were loaded into R.
3. The training and the test sets were merged to create one data set.
4. The labels of the individual measurements were added to the data set from 'features.txt'.
5. The labels of the individual activities were added to the data set from 'activity_labels.txt'.
6. For the cleaned data file, only measurements of mean and the SD were extracted.

### Variables created during the data cleaning stage
* activityLabels - data from 'activity_labels.txt': Links the class labels with their activity name.
* data - amalgamation of the variables 'dataTest' and 'dataTrain'
* dataActivity - amalgamation of the variables 'dataActivityTest' and 'dataActivityTrain'
* dataActivityTest - data from train/y_test.txt' file: Training labels
* dataActivityTrain - data from train/y_train.txt' file: Training labels
* dataFeatures - data from 'features.txt': List of all features
* dataSubject - amalgamation of the variables 'dataSubjectTest' and 'dataSubjectTrain'
* dataSubjectAndActivity - amalgamation of the variables 'dataSubject' and 'dataActivity'
* dataSubjectTest - data from 'train/subject_test.txt' file. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* dataSubjectTrain - data from 'train/subject_train.txt' file. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* dataTest - data from 'train/X_test.txt' file: Training set
* dataTrain - data from 'train/X_train.txt' file: Training set

### Variables of the cleaned data set
Cleaned dataset contains 10'299 observations of 69 variables. The first three columns contains 'Activity Number', 'Activity Name' and 'Subject ID'.

The rest of the columns contains measurements of:
* Triaxial acceleration from the accelerometer (total acceleration) in standard gravity units 'g'.  
* The estimated body acceleration obtained by subtracting the gravity from the total acceleration.
* Triaxial Angular velocity from the gyroscope. The units are radians/second.
* A 561-feature vector with time and frequency domain variables.
