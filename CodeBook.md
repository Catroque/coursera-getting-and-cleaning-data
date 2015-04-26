# Data source

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which
was originally made avaiable here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The files used on this processing are located on follow:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data set is split into training and test sets (70% and 30%, respectively) where each
partition is also split into three files that contain 
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject


# run_analysis.R

The script 'run_analysis.R'

- read the feature file identifying only the colums correspondent with std and mean values
- read the activity file to get the activity labels
- read the subjects for test dataset
- read test dataset and getting only the columns identified by feature
- create temporary dataframe for test data and subjects
- replaces 'activity' values in the dataset with descriptive activity names
- read the subjects for trainning dataset
- read trainning dataset and getting only the columns identified by feature
- create temporary dataframe for trainning data and subjects
- replaces 'activity' values in the dataset with descriptive activity names
- merge test and trainning dataframes
- creates a second, independent tidy dataset with an average of each variable
  for each each activity and each subject. In other words, same type of
  measurements for a particular subject and activity are averaged into one value
  and the tidy data set contains these mean values only.
- appropriately labels the columns with descriptive names.
- the processed tidy data set is also exported as txt file.


