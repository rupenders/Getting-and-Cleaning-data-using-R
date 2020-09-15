# Getting-and-Cleaning-data-using-R
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Variables

dir_ d --------------- local directory<br/>
act_lab --------------  activity lablels and index<br/>
features -------------- activity feature names and index<br/>
sample_set ------------ contain both train and test data with names<br/>
sample_set ------------ filter column for mean and std<br/>
sample_set3 ----------- assembles all activity data in single coulmn<br/>
Activity_Mean --------- Create a new table with Acitvitys with their means<br/>
