## This script reads in all training and test data, combines them into one dataframe
## and labels the activities appropriately, the resulting "data" dataframe only show
## the mean and standard deviation of each measurement.
## Finally a tidyed dataframe "tidy_data" is created, which shows the mean for each
## measurement from the previously created dataframe (mean and std), per activity 
## and subject.

# Read in the column Names for each of the features
feature_labels = read.table('data/features.txt', col.names=c("id", "label"))
# Read in the activty labels:
activity_labels = read.table('data/activity_labels.txt', col.names=c("id", "label"))
activity_labels = as.character(activity_labels$label) 

# Read in the feature data
train_X_data = read.table('data/train/X_train.txt', col.names=feature_labels$label)
test_X_data = read.table('data/test/X_test.txt', col.names=feature_labels$label)

# Read in the two other parameters, activity, and subject
# activity:
train_y_data = read.table('data/train/y_train.txt', col.names="activity")
test_y_data = read.table('data/test/y_test.txt', col.names="activity")
# subject_data:
train_subject = read.table("data/train/subject_train.txt", col.names="subject")
test_subject = read.table("data/test/subject_test.txt", col.names="subject")

# combine all the test and training dataframes
X_data = rbind(train_X_data, test_X_data)
y_data = rbind(train_y_data, test_y_data)
subject_data = rbind(train_subject, test_subject)

# combine all those individual data rows to one dataset
data = cbind(X_data, y_data, subject_data)

# convert and label the factor variables subject and activity
data$activity = factor(data$activity, labels = activity_labels)
data$subject = factor(data$subject)

# select only the mean and std deviation from each measurement
data = subset(data, select=c("activity",
                             "subject",
                             "tBodyAcc.mean...X",
                             "tBodyAcc.mean...Y",
                             "tBodyAcc.mean...Z",
                             "tBodyAcc.std...X",
                             "tBodyAcc.std...Y",
                             "tBodyAcc.std...Z",
                             "tGravityAcc.mean...X",
                             "tGravityAcc.mean...Y",
                             "tGravityAcc.mean...Z",
                             "tGravityAcc.std...X",
                             "tGravityAcc.std...Y",
                             "tGravityAcc.std...Z",
                             "tBodyAccJerk.mean...X",
                             "tBodyAccJerk.mean...Y",
                             "tBodyAccJerk.mean...Z",
                             "tBodyAccJerk.std...X",
                             "tBodyAccJerk.std...Y",
                             "tBodyAccJerk.std...Z" ))


# now lets create the tidy dataset, which displays the mean of all the measurement per 
# subject and activity
split_data = split(data, list(data$subject, data$activity))
tidy_data = data.frame()
for(df in split_data){
    # the factor variables have to be converted to numeric for the colMeans function
    df$activity = as.numeric(df$activity)
    df$subject = as.numeric(df$subject)
    tidy_data = rbind(tidy_data, colMeans(df))
}
colnames(tidy_data) <- colnames(data)
tidy_data$activity = factor(tidy_data$activity, labels = activity_labels)
tidy_data$subject = factor(tidy_data$subject)

#output the data table
write.table(tidy_data, "tidy_data.txt", row.name=F)