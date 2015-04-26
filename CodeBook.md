# Code Book for Course Project of getting and cleaning data

## data processing:


1. reading in feature labels and activiy labels ("features.txt", "activity_labels.txt")
2. reading in the feature data for training and testing dataset ("X_(train/test).txt")
3. reading in the target activity values ("y_(train/test).txt")
4. reading in the subject values ("subject_(train/test).txt")

5. combine the train and test datasets individually, for features, targets, and subjects
6. combine all the data columns into one big dataframe 
7. convert the "activity" data column into a factor with the preivouslu read in labels as labels
8. subseting only the activity, subject, means and standard deviations from each accelerometer reading
9. creating a new dataframe, where we calculate the average of the means and standard deviations for each accelerometer reading per activity and subject
10. output the final frame as "tidy_data.txt"

## Description of Variables in tidy dataset ("tidy_data.txt")

* activity: labeled factor variable for the different activities the data was collected for
* subject: integer variable specifying the subject (person), performing the measurement

all other variables names are basically taken from the raw data:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals and are used in the tidy dataset are: 

mean: Mean value
std: Standard deviation

