
#1. Reading TEST data files and creating a dataframe "test"


setwd("~/Desktop/Coursera/UCI HAR Dataset/test") # setting a working directory                   
        participant_id <-read.delim("subject_test.txt", header = FALSE)      
        features <-read.delim("X_test.txt", header = FALSE, stringsAsFactors = FALSE)                     
        activity <-read.delim("y_test.txt", header = FALSE) # downloading files

                test <- cbind(participant_id, features, activity) # creating a dataframe "test"               
                colnames(test)=c("participant_id", "features", "activity") # naming the columns


#2. Reading TRAIN data files and creating a dataframe "train"
        

setwd("~/Desktop/Coursera/UCI HAR Dataset/train") # setting a working directory   
        participant_id <-read.delim("subject_train.txt", header = FALSE) # downloading files
        features <-read.delim("X_train.txt", header = FALSE, stringsAsFactors = FALSE)                     
        activity <-read.delim("y_train.txt", header = FALSE) 

                train <- cbind(participant_id, features, activity) # creating a dataframe "train"                         
                colnames(train)=c("participant_id", "features", "activity") # naming the columns
                

#3. Merging "test" and "train" dataframes
                
mergeddata <- rbind(test, train)
        
                
#4. Giving descriptive names to activities: 1 WALKING; 2 WALKING_UPSTAIRS; 3 WALKING_DOWNSTAIRS, 4 SITTING,  5 STANDING, 6 LAYING  
  
mergeddata$activity <- as.character(mergeddata$activity) # converting activity into a character vector               
                
        mergeddata$activity[mergeddata$activity=="1"] <- "walking" # giving activities descriptive names
        mergeddata$activity[mergeddata$activity=="2"] <- "walking_upstairs"
        mergeddata$activity[mergeddata$activity=="3"] <- "walking_downstairs"
        mergeddata$activity[mergeddata$activity=="4"] <- "sitting"
        mergeddata$activity[mergeddata$activity=="5"] <- "standing"
        mergeddata$activity[mergeddata$activity=="6"] <- "laying"
                
#5. Extracting measures for mean and standard deviation for each measurement and attaching them to "mergeddata"               
               
t <- mergeddata$features # t is a large character vector that we need to split before extracting the mean and standard deviation values 
        tsplit <- strsplit(t, "and") # split t into list, each element of which is a character vector with 561 measures 
                pat <- "[-+.e0-9]*\\d" # defining a pattern (any number) in a character vector to look for
                library(gsubfn) # loading gsubfn pachage to use strapply - apply a function over a string
                t.num <- lapply(tsplit, function(x) strapply(x, pat, as.numeric)[[1]]) # create list of numeric vectors, takes some time due to 
                        t.myvalues <- lapply(t.num, function(x)x[c(1:6, 41:46, 121:126)])# subsetting to needed 18 measures* of means and standard deviations 
                                df  <-  as.data.frame(t(matrix(unlist(t.myvalues), nrow=length(unlist(t.myvalues[1])))))# converting the list into a dataframe
                                         dftomerge <- cbind(df, features=mergeddata$features) # adding column "features" to facilitate merging
                                                finaldf <- merge(mergeddata, dftomerge, by="features") # merging dataframes by features
                                                
                                                
                
# * List of extracted measures from mergeddata$features:
# 1 tBodyAcc-mean()-X              41 tGravityAcc-mean()-X            121 tBodyGyro-mean()-X
# 2 tBodyAcc-mean()-Y              42 tGravityAcc-mean()-Y            122 tBodyGyro-mean()-Y         
# 3 tBodyAcc-mean()-Z              43 tGravityAcc-mean()-Z            123 tBodyGyro-mean()-Z
# 4 tBodyAcc-std()-X               44 tGravityAcc-std()-X             124 tBodyGyro-std()-X
# 5 tBodyAcc-std()-Y               45 tGravityAcc-std()-Y             125 tBodyGyro-std()-Y
# 6 tBodyAcc-std()-Z               46 tGravityAcc-std()-Z             126 tBodyGyro-std()-Z  
  
                                                
                                                                                              
#6. Giving descriptive names to variables
                                                
# tBodyAcc-XYZ - triaxial body acceleration measured by accelerometer, t denotes time
# tGravityAcc-XYZ - triaxial gravity acceleration measured by accelerometer, t denotes time
# tBodyGyro-XYZ - triaxial angular velocity measured by gyroscope, t denotes time
                                                
colnames(finaldf)[colnames(finaldf)=="V1"] <- "tBodyAccX.mean"
colnames(finaldf)[colnames(finaldf)=="V2"] <- "tBodyAccY.mean"
colnames(finaldf)[colnames(finaldf)=="V3"] <- "tBodyAccZ.mean"

        colnames(finaldf)[colnames(finaldf)=="V4"] <- "tBodyAccX.sd"
        colnames(finaldf)[colnames(finaldf)=="V5"] <- "tBodyAccY.sd"
        colnames(finaldf)[colnames(finaldf)=="V6"] <- "tBodyAccZ.sd"
        
                colnames(finaldf)[colnames(finaldf)=="V7"] <- "tGravityAccX.mean"
                colnames(finaldf)[colnames(finaldf)=="V8"] <- "tGravityAccY.mean"
                colnames(finaldf)[colnames(finaldf)=="V9"] <- "tGravityAccZ.mean"
        
                        colnames(finaldf)[colnames(finaldf)=="V10"] <- "tGravityAccX.sd"
                        colnames(finaldf)[colnames(finaldf)=="V11"] <- "tGravityAccY.sd"
                        colnames(finaldf)[colnames(finaldf)=="V12"] <- "tGravityAccZ.sd"

                                colnames(finaldf)[colnames(finaldf)=="V13"] <- "tBodyGyroX.mean"
                                colnames(finaldf)[colnames(finaldf)=="V14"] <- "tBodyGyroY.mean"   
                                colnames(finaldf)[colnames(finaldf)=="V15"] <- "tBodyGyroZ.mean"   
                                              
                                        colnames(finaldf)[colnames(finaldf)=="V16"] <- "tBodyGyroX.sd" 
                                        colnames(finaldf)[colnames(finaldf)=="V17"] <- "tBodyGyroY.sd" 
                                        colnames(finaldf)[colnames(finaldf)=="V18"] <- "tBodyGyroZ.sd" 
                                                
                                                
                                                
#7. Creating a dataset with mean of each measure for each participant and activity
library(dplyr)
        dataset <- select(finaldf, -c(features)) # dropping unnecessary columns                                       
                finaldataset <- dataset %>% group_by(participant_id, activity) %>% summarise_all(mean) # calculating mean values for each measure by each participant and each activity 

#write.table(finaldataset, "~/Desktop/Coursera/finaldataset.txt", row.names=FALSE)
#setwd("~/Desktop/Coursera")
#read.table("finaldataset.txt", header=TRUE)
                                                

                                                
                                               
                                                
                                                
                                                
                                                
                                                
                                                
                                               
                                                
                                               
                                                                                                                                                 
                                                
                                               
                                               
                                                
                                                                                                     
                
                
                
                                







                                        




                                        
