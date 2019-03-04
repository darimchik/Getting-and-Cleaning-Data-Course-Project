                           ###################CodeBook.md ###############################

                                                                  
          #DATA#

"Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset) is a dataset which resulted from the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter 
into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables stored in X_test.txt and X_train.txt files. 
- Activity labels stored in y_test.txt and y_train.txt files. 
- Participants ID numbers stored in subject_test.txt and subject_train.txt files.


The dataset includes the following files:
       
- 'README.txt': describes the experiment, the data and the files
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'Inertial Signals': folders containing files with raw data from accelerometer and gyroscope
        

         #ANALYSIS#


1. Three files were downloaded from "test" folder of the "UCI HAR Dataset":
       subject_test.txt - contains test participants' IDs     
       X_test.txt - contains a large character vector, each element of which consists of 561 features (variables), including    mean and standard deviation values used for a final dataset                    
       y_test.txt - contains activity labels 


2. Three files were downloaded from "train" folder of the "UCI HAR Dataset":
       subject_train.txt - contains training participants' IDs     
       X_train.txt - contains a large character vector, each element of which consists of 561 features (variables), including mean and standard deviation values used for a final dataset                   
       y_train.txt - contains activity labels 

3. Two dataframes "test" and "train" were created, each contains 3 columns: "participant_id", "features", "activity", similar names across the dataframes were used to facilitate merging.
       subject_test.txt = "participant_id", subject_train.txt = "participant_id"  
       X_test.txt = "features", X_train.txt = "features"
       y_test.txt = "activity", y_train.txt = "activity"
      
     
4. Dataframes "test" and "train" were merged by row, resulting in a dataframe "mergeddata" with 3 columns and 10299 rows. 
       
       
5. The values in the "activity" column of the "mergeddata" were given descriptive names according to activity_labels.txt file
   1 WALKING; 2 WALKING_UPSTAIRS; 3 WALKING_DOWNSTAIRS, 4 SITTING,  5 STANDING, 6 LAYING  


6. Means and standard deviations for each measurement were extracted from "features" column of "mergeddata" using split-apply-combine strategy.
   A column "features" of the "mergeddata" dataframe was saved as a separate object - vector t, and was split (strsplit) into a list "tsplit", each element of which is a character vector with 561 numeric values.
   Each element of the list "tsplit" was converted into a numeric vector, using lapply and strapply. A new list was named "t.num" 
   Each numeric vector of the list "t.num" was subsetted to 18 measures of means and standard deviations. The subsetted list was assigned a name "t.myvalues". 
   Since the assignment was to extract "only the measurements on the mean and standard deviation for each measurement",
   only means and standard deviations which correspond to triaxial body acceleration (tBodyAcc-XYZ), gravity acceleration (tGravityAcc-XYZ), and angular velocity (tBodyGyro-XYZ) were extracted, resulting in 18 variables.
   
  List of extracted measures from features.txt file:
  
  1 tBodyAcc-mean()-X, 2 tBodyAcc-mean()-Y, 3 tBodyAcc-mean()-Z, 4 tBodyAcc-std()-X, 5 tBodyAcc-std()-Y, 6 tBodyAcc-std()-Z                             
  41 tGravityAcc-mean()-X, 42 tGravityAcc-mean()-Y, 43 tGravityAcc-mean()-Z, 44 tGravityAcc-std()-X, 45 tGravityAcc-std()-Y, 46 tGravityAcc-std()-Z     
  121 tBodyGyro-mean()-X, 122 tBodyGyro-mean()-Y, 123 tBodyGyro-mean()-Z, 124 tBodyGyro-std()-X, 125 tBodyGyro-std()-Y,
  126 tBodyGyro-std()-Z  
 
7. The resulting list "t.myvalues" was converted into a dataframe "df". A column "features" was added to "df" in order to facilitate merging with "mergeddata" dataframe using cbind, resulting in in a final dataframe "finaldf".



8. Each of the 18 columns containing means and standard deviations was given descriptive names. 
   For example, "tBodyAccX.mean"- is a mean measure of the X-axis body acceleration measured by accelerometer, 
                 "tBodyGyroZ.sd - is a standard deviation of Z-axis angular velocity measured by gyroscope. 


9. A final dataset with a mean of each measure for each participant and activity was created using group_by and summarise_all commands from "dplyr" package.




