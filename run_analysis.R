# run_analysis.R

# Getting and loading the data:
# Messy raw data is in a zip file dowloadable from 
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Data was dowloaded and all relevant files were extracted in folder called "UCIHARDataset" in the main working directory.


# Intial step: Read the relevant files from UCIHARDataset folder

test_data <- read.table("~/UCIHARDataset/test/X_test.txt", quote="\"")
test_labels <- read.table("~/UCIHARDataset/test/y_test.txt", quote="\"")
test_subject <- read.table("~/UCIHARDataset/test/subject_test.txt", quote="\"")
train_data <- read.table("~/UCIHARDataset/train/X_train.txt", quote="\"")
train_labels <- read.table("~/UCIHARDataset/train/y_train.txt", quote="\"")
train_subject <- read.table("~/UCIHARDataset/train/subject_train.txt", quote="\"")
features <- read.table("~/UCIHARDataset/features.txt", quote="\"")
activities <- read.table("~/UCIHARDataset/activity_labels.txt", quote="\"")

# step 2:Merge the train and test data files into one dataset and remove initial reads to save memory/clutter

merged_data <- rbind(train_data, test_data)
merged_labels <- rbind(train_labels, test_labels)
merged_subject <- rbind(train_subject, test_subject)
rm(test_data, test_labels, test_subject, train_data, train_labels, train_subject)

# Step 3: Subest the merged_data set with only columns with mean() or std() in their names and apply new column names.
mean_and_std_columns <- grep("-(mean|std)\\(\\)", features[, 2])
merged_data <- merged_data[, mean_and_std_columns]
names(merged_data) <- features[mean_and_std_columns, 2]

# Step 4: Rename descriptvely activities and variables in data set
merged_labels[, 1] <- activities[merged_labels[, 1], 2]
names(merged_labels) <- "activity"
names(merged_subject) <- "subject"

# Step 5: Bind the subset and renamed data in a single data set
all_data <- cbind(merged_data, merged_labels, merged_subject)

# Step 6: Using plyr package create a tidy data set with the mean of each variable for each activity and each subject

library(plyr)
tidy_data_means <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidy_data_means, "tidy_data_means.txt", row.name=FALSE)