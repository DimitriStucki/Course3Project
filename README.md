
 # README on the R script to tidy data on Google smartphone accelerometers

 ## Some nomenclature:
 '' denotes a file
 [] denotes a data frame
 {} denotes a variable

 ## 1) The task

 1.1) Merge the training and the test sets to create one data set.<br />
 1.2) Extract only the measurements on the mean and standard deviation for each measurement.<br />
 1.3) Use descriptive activity names to name the activities in the data set<br />
 1.4) Appropriately label the data set with descriptive variable names.<br />
 1.5) From the data set in step 4, create a second, independent tidy data set with the average of each variable for
      each activity and each subject.<br />

 ## 2) Original data

 2.1) Data source
 The data was downloaded from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
 On Oktober 8, 2017

 2.2) Data content (as described in 'README.txt')
 'README.txt':<br />
 'features_info.txt': Shows information about the variables used on the feature vector.<br />
 'features.txt': List of all features.<br />
 'activity_labels.txt': Links the class labels with their activity name.<br />
 'train/X_train.txt': Training set.<br />
 'train/y_train.txt': Training labels.<br />
 'test/X_test.txt': Test set.<br />
 'test/y_test.txt': Test labels.<br />
 The following files are available for the train and test data. Their descriptions are equivalent. <br />
 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample.<br />
        Its range is from 1 to 30. <br />
 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in<br />
        standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the<br />
        'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. <br />
 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from<br />
        the total acceleration. <br />
 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window<br />
        sample. The units are radians/second. <br />

 2.3) Used files<br />
 The script uses the following files:<br />
 'features.txt' (used to extract the origial labels of the variables)<br />
 'activity_labels.txt' (manual use only, used to copy the labels of the activity levels into the R-script)<br />
 'train/X_train.txt' (source of the original variables of the training set)<br />
 'train/y_train.txt' (source of the original response (y) variable of the training set)<br />
 'train/subject_train.txt' (used to extract the subject identities for each observation in the training set)<br />
 'test/X_test.txt' (source of the original variables of the test set)<br />
 'test/y_test.txt' (source of the original response (y) variable of the test set)<br />
 'test/subject_test.txt' (used to extract the subject identities for each observation in the test set)<br />

 ## 3) Script description


 Overall description<br />
 In a first step both of the two sets (train/test) are separately reduced to the necessary variables and extended<br />
 with the y-variables and subject identifiers. In a secend step, the two new data sets are merged vertically (rbind)<br />
 with an additional variable (factor) "set" to separate between the sets. Lastly, the new data frame is tidied up,<br />
 and saved to a file.<br />
 In addition the script performs a summarizing step to calculate the mean for each variable by activity and subject<br />
 (separately for the two sets). The resulting data frame is also saved to a new file.<br />

 Script workflow<br />
 3.1.1) Read 'train/X_train.txt' -> [X_train]<br />
 3.1.2) Read 'features.txt' -> [Features]<br />
 3.1.3) Read 'train/subject_train.txt' -> [Subject]<br />
 3.1.4) Add the values in [Features] as column names to [X_train]<br />
 3.1.5) Read 'train/Y_train.txt' -> [Y_train]<br />
 3.1.6.1) Create new data.frame [TrainingSet] with [Y_train], [Subject] and the required entries from [X_train]<br />
  [Y_train]<br />
	      V1				-> activity<br />
  [subject]<br />
	      V1				-> subject<br />
  [X_train] 					-> See CodeBook_AccelerometerData.xlsx for new names<br />
            1 tBodyAcc-mean()-X<br />
            2 tBodyAcc-mean()-Y<br />
            3 tBodyAcc-mean()-Z<br />
            4 tBodyAcc-std()-X<br />
            5 tBodyAcc-std()-Y<br />
            6 tBodyAcc-std()-Z<br />
            41 tGravityAcc-mean()-X<br />
            42 tGravityAcc-mean()-Y<br />
            43 tGravityAcc-mean()-Z<br />
            44 tGravityAcc-std()-X<br />
            45 tGravityAcc-std()-Y<br />
            46 tGravityAcc-std()-Z<br />
            81 tBodyAccJerk-mean()-X<br />
            82 tBodyAccJerk-mean()-Y<br />
            83 tBodyAccJerk-mean()-Z<br />
            84 tBodyAccJerk-std()-X<br />
            85 tBodyAccJerk-std()-Y<br />
            86 tBodyAccJerk-std()-Z<br />
            121 tBodyGyro-mean()-X<br />
            122 tBodyGyro-mean()-Y<br />
            123 tBodyGyro-mean()-Z<br />
            124 tBodyGyro-std()-X<br />
            125 tBodyGyro-std()-Y<br />
            126 tBodyGyro-std()-Z<br />
            161 tBodyGyroJerk-mean()-X<br />
            162 tBodyGyroJerk-mean()-Y<br />
            163 tBodyGyroJerk-mean()-Z<br />
            164 tBodyGyroJerk-std()-X<br />
            165 tBodyGyroJerk-std()-Y<br />
            166 tBodyGyroJerk-std()-Z<br />
            201 tBodyAccMag-mean()<br />
            202 tBodyAccMag-std()<br />
            214 tGravityAccMag-mean()<br />
            215 tGravityAccMag-std()<br />
            227 tBodyAccJerkMag-mean()<br />
            228 tBodyAccJerkMag-std()<br />
            240 tBodyGyroMag-mean()<br />
            241 tBodyGyroMag-std()<br />
            253 tBodyGyroJerkMag-mean()<br />
            254 tBodyGyroJerkMag-std()<br />
            266 fBodyAcc-mean()-X<br />
            267 fBodyAcc-mean()-Y<br />
            268 fBodyAcc-mean()-Z<br />
            269 fBodyAcc-std()-X<br />
            270 fBodyAcc-std()-Y<br />
            271 fBodyAcc-std()-Z<br />
            345 fBodyAccJerk-mean()-X<br />
            346 fBodyAccJerk-mean()-Y<br />
            347 fBodyAccJerk-mean()-Z<br />
            348 fBodyAccJerk-std()-X<br />
            349 fBodyAccJerk-std()-Y<br />
            350 fBodyAccJerk-std()-Z<br />
            424 fBodyGyro-mean()-X<br />
            425 fBodyGyro-mean()-Y<br />
            426 fBodyGyro-mean()-Z<br />
            427 fBodyGyro-std()-X<br />
            428 fBodyGyro-std()-Y<br />
            429 fBodyGyro-std()-Z<br />
            503 fBodyAccMag-mean()<br />
            504 fBodyAccMag-std()<br />
            516 fBodyBodyAccJerkMag-mean()<br />
            517 fBodyBodyAccJerkMag-std()<br />
            529 fBodyBodyGyroMag-mean()<br />
            530 fBodyBodyGyroMag-std()<br />
            542 fBodyBodyGyroJerkMag-mean()<br />
            543 fBodyBodyGyroJerkMag-std()<br />
 3.1.6.2) Add a new column with a factor {set} all values set to "Train" to indicate the identity of the entries as<br />
        training data<br />
 3.1.7) Remove [Y_train] and [X_train] to save RAM<br />

 3.2.1) Read 'test/X_test.txt' -> [X_test]<br />
 3.2.2) Add the values in [Features] as column names to [X_test]<br />
 3.2.3) Read 'test/subject_test' -> [Subject] (overwrite from previous as not needed anymore)<br />
 3.2.4) Read 'test/Y_test.txt' -> [Y_test]<br />
 3.2.5.1) Create new data.frame [TestSet] with [Y_test], [Subject] and the required entries from [X_test]<br />
          (See section 3.1.6.1)) for the required entries)<br />
 3.2.5.2) Add a new column with a factor {set} all values set to "Test" to indicate the identity of the entries as<br />
          test data<br />
 3.2.6) Remove [Y_test], [X_test], [Subject] and [Features] to save RAM<br />
 3.2.7) Combine [TrainSet] and [TestSet] as new data fame [AccelerometerData] (rbind)<br />
 3.2.8) Remove [TrainSet] and [TestSet] to save RAM

 3.3.1) Rename the activity levels, rename the variable lables<br />
        activity labels: (manually copied from 'activity_labels.txt')<br />
 3.3.2) Simplify the variable names<br />
   
 3.3.3) Save the data frame [AccelerometerData] to the file 'AccelerometerData.txt'<br />

 3.4.1) Create new data frame [AccelerometerDataMean] with all values averaged by {subject}, {activity} and {set}<br />
        For this the function colMeans() is applied on a list which was split by {subject}, {activity} and {set}<br />
        Non-exisiting combinations between {subject}, {activity} and {set} are dropped to simplify the outcome<br />
 3.4.2) Tidy up the outcome by removing the rownames and correctly labeling all variables<br />
 3.4.3) Save the data frame [AccelerometerDataMean] to the file 'AccelerometerDataMean.txt'<br />