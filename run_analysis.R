## This script reads in all training and test data, combines them into one dataframe
## and labels the activities appropriately, the resulting "data" dataframe only show
## the mean and standard deviation of each measurement.
## Finally a tidyed dataframe "tidy_data" is created, which shows the mean for each
## measurement from the previously created dataframe (mean and std), per activity 
## and subject.

# Read in the column Names for each of the features and clean them to be usuable in R as
# column Names
feature_labels = read.table('data/features.txt', col.names=c("id", "label"))
feature_labels = gsub("\\(\\)", "", as.character(feature_labels$label))
feature_labels = gsub("-", "_", feature_labels)

# Read in the activty labels:
activity_labels = read.table('data/activity_labels.txt', col.names=c("id", "label"),)
activity_labels = as.character(activity_labels$label)

# Read in the feature data
train_X_data = read.table('data/train/X_train.txt', col.names=feature_labels)
test_X_data = read.table('data/test/X_test.txt', col.names=feature_labels)

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

# combine all those individual data columns to one dataset
data = cbind(X_data, y_data, subject_data)

# convert and label the factor variables subject and activity
data$activity = factor(data$activity, labels = activity_labels)
data$subject = factor(data$subject)

# select only the means and std deviations from each measurement
mean_std_labels = feature_labels[(grepl("mean", feature_labels) | grepl("std", feature_labels)) 
                                 & !grepl("meanFreq", feature_labels)]

data = subset(data, select=c("activity",
                             "subject",
                             mean_std_labels))

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