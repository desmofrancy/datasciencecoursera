
###The attached R script (run_analysis.R) performs the following to clean up the data:

####1. Merges the training and test sets, and saves it as merged_clean_data.txt.

- train/X_train.txt with test/X_test.txt becomes a 10299 x 561 data frame X ("Number of Instances: 10299" and "Number of Attributes: 561")

- train/subject_train.txt with test/subject_test.txt becomes a 10299 x 1 data frame Subjs with subject IDs,

- train/y_train.txt with test/y_test.txt becomes a 10299 x 1 data frame y with activity IDs.

####2. Reads file features.txt and extracts only the measurements of mean and standard deviation 
The script includes the parentheses in the conditions for mean and standard deviation, to exlude meanFreq entries and avoid ambiguity (subjective choice, see below). The result is a 10299 x 66 data frame, because only 66 out of 561 attributes are measurements on the mean and standard deviation. All measurements are floating point numbers in the range (-1, 1).

As stated in David's Project FAQ: 

**_what columns are measurements on the mean and standard deviation_**

_Based on column names in the features is an open question as to is the the entries that include mean() and std() at the end, or does it include entries with mean in an earlier part of the name as well. There are no specific marking critieria on the number of columns. It is up to you to make a decision and explain what you did to the data. Make it easy for people to give you marks by explaining your reasoning)._

####3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
walking

walkingupstairs

walkingdownstairs

sitting

standing

laying

####4. Labels the data set with descriptive names: feature names and activity names are converted to lower case, underscores and brackets () are removed.

Then it merges the 10299x66 data frame containing features (X) with 10299x1 data frames containing activity labels (y) and subject IDs (Subjs).

The result is saved as merged_clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs (1 to 30), the second column activity names (see #3), and the last 66 columns are measurements. Names of the attributes are the following:

tbodyacc-mean-x   
tbodyacc-mean-y   
tbodyacc-mean-z   
tbodyacc-std-x   
tbodyacc-std-y   
tbodyacc-std-z   
tgravityacc-mean-x   
tgravityacc-mean-y   
tgravityacc-mean-z   
tgravityacc-std-x   
tgravityacc-std-y   
tgravityacc-std-z   
tbodyaccjerk-mean-x   
tbodyaccjerk-mean-y   
tbodyaccjerk-mean-z   
tbodyaccjerk-std-x   
tbodyaccjerk-std-y   
tbodyaccjerk-std-z   
tbodygyro-mean-x   
tbodygyro-mean-y   
tbodygyro-mean-z   
tbodygyro-std-x   
tbodygyro-std-y   
tbodygyro-std-z   
tbodygyrojerk-mean-x   
tbodygyrojerk-mean-y   
tbodygyrojerk-mean-z   
tbodygyrojerk-std-x   
tbodygyrojerk-std-y   
tbodygyrojerk-std-z   
tbodyaccmag-mean   
tbodyaccmag-std   
tgravityaccmag-mean   
tgravityaccmag-std   
tbodyaccjerkmag-mean   
tbodyaccjerkmag-std   
tbodygyromag-mean   
tbodygyromag-std   
tbodygyrojerkmag-mean   
tbodygyrojerkmag-std   
fbodyacc-mean-x   
fbodyacc-mean-y   
fbodyacc-mean-z   
fbodyacc-std-x   
fbodyacc-std-y   
fbodyacc-std-z   
fbodyaccjerk-mean-x   
fbodyaccjerk-mean-y   
fbodyaccjerk-mean-z   
fbodyaccjerk-std-x   
fbodyaccjerk-std-y   
fbodyaccjerk-std-z   
fbodygyro-mean-x   
fbodygyro-mean-y   
fbodygyro-mean-z   
fbodygyro-std-x   
fbodygyro-std-y   
fbodygyro-std-z   
fbodyaccmag-mean   
fbodyaccmag-std   
fbodybodyaccjerkmag-mean   
fbodybodyaccjerkmag-std   
fbodybodygyromag-mean  
fbodybodygyromag-std   
fbodybodygyrojerkmag-mean   
fbodybodygyrojerkmag-std 

####5. Creates a 2nd, independent tidy data set with the average of each measurement (66) for each activity (6) and each subject (30).
The result is saved as data_average.txt, a 180x68 data frame, where the first column contains subject IDs, the second column contains activity names, and then the averages for each of the 66 attributes are in columns from 3 to 68. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.

###Notes
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . 

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones