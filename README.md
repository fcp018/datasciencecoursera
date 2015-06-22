The run.analysis script peforms the following tasks:

Reads .csv data files from an unzipped downloaded files in UCIHARDataset folder

Merges the training and the test sets to create one data set.

Extracts/subsets only the measurements on the mean and standard deviation for each measurement

Uses descriptive activity and variable names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. 

Using plyr package function and the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
