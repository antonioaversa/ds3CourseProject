library(dplyr);

localSubFolder = "UCI HAR Dataset";

if (!file.exists(localSubFolder)) {
  stop(paste(sep = "", "The working directory doesn't contain a sub folder named '", localSubFolder, "'. \n", 
             "Download and unzip the HAR Dataset in the current wd: \n",
             " - either manually\n",
             " - or by using the 'retrive_data.R' script.\n",
             "Current Working Directory: ", getwd()));
}

X_test_path = file.path(localSubFolder, "test", "X_test.txt");
y_test_path = file.path(localSubFolder, "test", "y_test.txt");
subject_test_path = file.path(localSubFolder, "test", "subject_test.txt");

X_train_path = file.path(localSubFolder, "train", "X_train.txt");
y_train_path = file.path(localSubFolder, "train", "y_train.txt");
subject_train_path = file.path(localSubFolder, "train", "subject_train.txt");

activity_labels_path = file.path(localSubFolder, "activity_labels.txt");
features_path = file.path(localSubFolder, "features.txt");

# 1. Merges the training and the test sets to create one data set.
# Remark: here 3 different merges are performed, for X, y and subject.
# The complete data set is create at the end of Step 4.
X_train_sample <- read.table(X_train_path, nrows = 1);
X_train_colClasses <- sapply(X_train_sample, class);

X_train <- read.table(X_train_path, colClasses = X_train_colClasses);
X_test <- read.table(X_test_path, colClasses = X_train_colClasses);
X_total <- rbind(X_train, X_test);

y_train <- read.table(y_train_path);
y_test <- read.table(y_test_path);
y_total <- rbind(y_train, y_test);

subject_train <- read.table(subject_train_path);
subject_test <- read.table(subject_test_path);
subject_total <- rbind(subject_train, subject_test);

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table(features_path)[2];
colnames(features) <- c("featureName");
meanAndStdFeatures <- features %>% filter(grepl("-mean\\(\\)", x = featureName) | grepl("-std\\(\\)", x = featureName));

colnames(X_total) <- as.character(features$featureName);
X_total_projected <- X_total[, as.character(meanAndStdFeatures$featureName)];

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table(activity_labels_path);
colnames(activity_labels) <- c("activity_id", "activity");

# 4. Appropriately labels the data set with descriptive variable names.
subject_label <- "subject";
colnames(subject_total) <- c(subject_label);
activity_total <- sapply(y_total$V1, function(activity_id) activity_labels$activity[activity_id]);
# COMPLETE DATA SET
dataset <- cbind(X_total_projected, activity = activity_total, subject_total);

# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
dataset_byActivityAndSubject <- 
  dataset %>% group_by(subject, activity) %>% summarise_each(funs(mean));

write.table(dataset_byActivityAndSubject, file="dataset_byActivityAndSubject.txt", row.names=FALSE);