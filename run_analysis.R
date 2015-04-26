###
# set the working directory that has a 'UCI HAR Dataset' directory obtained from 
# extracted source file of project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# setwd('C:\\Users\\Rinaldo\\Downloads\\The Data Science Specialization\\03 - Getting and Cleaning Data\\wd')

#
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.
#

###
# contants to define type of data
#
testData  <- "TEST"
trainData <- "TRAIN"


###################################
# Processing FEATURES file
###################################

###
# filename, labels, classes, etc.
#
featuresFile <- './UCI HAR Dataset/features.txt'
featuresColNames <- c('id','feature')
featuresColClass <- c('numeric', 'character')

###
# reading end getting only std and mean tag columns
#
featuresDataFrame <- read.table(featuresFile, sep=' ', col.names=featuresColNames, colClasses=featuresColClass)
featuresDataFrame <- featuresDataFrame[grep("std[(]|mean[(]", featuresDataFrame$feature),]


###################################
# Processing ACTIVITY file
###################################

###
# filename, labels, classes, etc.
#
activityLabelsFile <- './UCI HAR Dataset/activity_labels.txt'
activityLabelsColNames <- c('id','activity')
activityLabelsColClass <- c('numeric', 'character')

###
# reading content
#
activityLabelsDataFrame <- read.table(activityLabelsFile, sep=' ', 
                                      col.names=activityLabelsColNames, 
                                      colClasses=activityLabelsColClass)


###################################
# Processing TEST files
###################################

###
# getting subjects of test data group
#
subjectFile <- './UCI HAR Dataset/test/subject_test.txt'
subjectDataFrame <- read.table(subjectFile, col.names=c("subject"))

###
# getting data of test data group
#
testFile <- './UCI HAR Dataset/test/X_test.txt'
testDataFrame <- read.table(testFile)

###
# getting only std() and mean() columns
#
testDataFrame <- testDataFrame[,featuresDataFrame$id]
colnames(testDataFrame) <- featuresDataFrame$feature
#colnames(testDataFrame) <- featuresDataFrame$id

###
# getting activities of test data group
#
activityFile <- './UCI HAR Dataset/test/Y_test.txt'
activityDataFrame <- read.table(activityFile, col.names=c("id"))

###
# creating dataframe for test data
#
dfTest <- data.frame(type=rep(testData),
                     subject=subjectDataFrame$subject, 
                     id=activityDataFrame$id, 
                     testDataFrame,
                     check.names = FALSE)

###
# adding on test dataframe column for activity
#
dfTest <- merge(dfTest, activityLabelsDataFrame, by.x="id", by.y="id", all=TRUE, sort=FALSE)


###################################
# Processing TRAIN files
###################################

###
# getting subjects of train data group
#
subjectFile <- './UCI HAR Dataset/train/subject_train.txt'
subjectDataFrame <- read.table(subjectFile, col.names=c("subject"))

###
# getting data of train data group
#
trainFile <- './UCI HAR Dataset/train/X_train.txt'
trainDataFrame <- read.table(trainFile)

###
# getting only std() and mean() columns
#
trainDataFrame <- trainDataFrame[,featuresDataFrame$id]
colnames(trainDataFrame) <- featuresDataFrame$feature
#colnames(trainDataFrame) <- trainDataFrame$id

###
# getting activities of train data group
#
activityFile <- './UCI HAR Dataset/train/Y_train.txt'
activityDataFrame <- read.table(activityFile, col.names=c("id"))

###
# creating dataframe for train data
#
dfTrain <- data.frame(type=rep(trainData),
                     subject=subjectDataFrame$subject, 
                     id=activityDataFrame$id, 
                     trainDataFrame,
                     check.names = FALSE)

###
# adding on test dataframe column for activity
#
dfTrain <- merge(dfTrain, activityLabelsDataFrame, by.x="id", by.y="id", all=TRUE, sort=FALSE)


###################################
# Merging and Tidy data
###################################

###
# mergin data sources
#
df <- rbind(dfTest, dfTrain)

###
# creating tidy data
#
tidy <- aggregate(df, by=list(activity1 = df$activity, subject1 = df$subject), mean)

###
# refactoring columns names
#
tidy[,'subject']=NULL
tidy[,'activity']=NULL
tidy[,'id']=NULL
tidy[,'type']=NULL

names <- colnames(tidy)
names[1] = 'activity'
names[2] = 'subject'
colnames(tidy) <- names


write.table(tidy, "tiny_data.txt", sep="\t", row.name=FALSE)
