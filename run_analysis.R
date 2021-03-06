> if(!file.exists("./projectData")){
+   dir.create("./projectData")
+   }
> Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> ## Check if zip has already been downloaded in projectData directory?
> if(!file.exists("./projectData/project_Dataset.zip")){
+   download.file(Url,destfile="./projectData/project_Dataset.zip",mode = "wb")
+   }
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

> if(!file.exists("./projectData/UCI HAR Dataset")){
+   unzip(zipfile="./projectData/project_Dataset.zip",exdir="./projectData")
+ }
> ## List all the files of UCI HAR Dataset folder
> path <- file.path("./projectData" , "UCI HAR Dataset")
> files<-list.files(path, recursive=TRUE)
> ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
> ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
> 
> SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
> SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
> 
> FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
> FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
> 
> 
> dataSubject <- rbind(SubjectTrain, SubjectTest)
> dataActivity<- rbind(ActivityTrain, ActivityTest)
> dataFeatures<- rbind(FeaturesTrain, FeaturesTest)
> 
> names(dataSubject)<-c("subject")
> names(dataActivity)<- c("activity")
> dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
> names(dataFeatures)<- dataFeaturesNames$V2
> 
> dataCombine <- cbind(dataSubject, dataActivity)
> Data <- cbind(dataFeatures, dataCombine)
> 
> subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
> 
> selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
> Data<-subset(Data,select=selectedNames)
> 
> activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
> 
> Data$activity<-factor(Data$activity,labels=activityLabels[,2])
> 
> head(Data$activity,30)
 [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
 [9] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
[17] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
[25] STANDING STANDING STANDING SITTING  SITTING  SITTING 
6 Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING ... LAYING
> 
> names(Data)<-gsub("^t", "time", names(Data))
> names(Data)<-gsub("^f", "frequency", names(Data))
> names(Data)<-gsub("Acc", "Accelerometer", names(Data))
> names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
> names(Data)<-gsub("Mag", "Magnitude", names(Data))
> names(Data)<-gsub("BodyBody", "Body", names(Data))
> 
> names(Data)
 [1] "timeBodyAccelerometer-mean()-X"                
 [2] "timeBodyAccelerometer-mean()-Y"                
 [3] "timeBodyAccelerometer-mean()-Z"                
 [4] "timeBodyAccelerometer-std()-X"                 
 [5] "timeBodyAccelerometer-std()-Y"                 
 [6] "timeBodyAccelerometer-std()-Z"                 
 [7] "timeGravityAccelerometer-mean()-X"             
 [8] "timeGravityAccelerometer-mean()-Y"             
 [9] "timeGravityAccelerometer-mean()-Z"             
[10] "timeGravityAccelerometer-std()-X"              
[11] "timeGravityAccelerometer-std()-Y"              
[12] "timeGravityAccelerometer-std()-Z"              
[13] "timeBodyAccelerometerJerk-mean()-X"            
[14] "timeBodyAccelerometerJerk-mean()-Y"            
[15] "timeBodyAccelerometerJerk-mean()-Z"            
[16] "timeBodyAccelerometerJerk-std()-X"             
[17] "timeBodyAccelerometerJerk-std()-Y"             
[18] "timeBodyAccelerometerJerk-std()-Z"             
[19] "timeBodyGyroscope-mean()-X"                    
[20] "timeBodyGyroscope-mean()-Y"                    
[21] "timeBodyGyroscope-mean()-Z"                    
[22] "timeBodyGyroscope-std()-X"                     
[23] "timeBodyGyroscope-std()-Y"                     
[24] "timeBodyGyroscope-std()-Z"                     
[25] "timeBodyGyroscopeJerk-mean()-X"                
[26] "timeBodyGyroscopeJerk-mean()-Y"                
[27] "timeBodyGyroscopeJerk-mean()-Z"                
[28] "timeBodyGyroscopeJerk-std()-X"                 
[29] "timeBodyGyroscopeJerk-std()-Y"                 
[30] "timeBodyGyroscopeJerk-std()-Z"                 
[31] "timeBodyAccelerometerMagnitude-mean()"         
[32] "timeBodyAccelerometerMagnitude-std()"          
[33] "timeGravityAccelerometerMagnitude-mean()"      
[34] "timeGravityAccelerometerMagnitude-std()"       
[35] "timeBodyAccelerometerJerkMagnitude-mean()"     
[36] "timeBodyAccelerometerJerkMagnitude-std()"      
[37] "timeBodyGyroscopeMagnitude-mean()"             
[38] "timeBodyGyroscopeMagnitude-std()"              
[39] "timeBodyGyroscopeJerkMagnitude-mean()"         
[40] "timeBodyGyroscopeJerkMagnitude-std()"          
[41] "frequencyBodyAccelerometer-mean()-X"           
[42] "frequencyBodyAccelerometer-mean()-Y"           
[43] "frequencyBodyAccelerometer-mean()-Z"           
[44] "frequencyBodyAccelerometer-std()-X"            
[45] "frequencyBodyAccelerometer-std()-Y"            
[46] "frequencyBodyAccelerometer-std()-Z"            
[47] "frequencyBodyAccelerometerJerk-mean()-X"       
[48] "frequencyBodyAccelerometerJerk-mean()-Y"       
[49] "frequencyBodyAccelerometerJerk-mean()-Z"       
[50] "frequencyBodyAccelerometerJerk-std()-X"        
[51] "frequencyBodyAccelerometerJerk-std()-Y"        
[52] "frequencyBodyAccelerometerJerk-std()-Z"        
[53] "frequencyBodyGyroscope-mean()-X"               
[54] "frequencyBodyGyroscope-mean()-Y"               
[55] "frequencyBodyGyroscope-mean()-Z"               
[56] "frequencyBodyGyroscope-std()-X"                
[57] "frequencyBodyGyroscope-std()-Y"                
[58] "frequencyBodyGyroscope-std()-Z"                
[59] "frequencyBodyAccelerometerMagnitude-mean()"    
[60] "frequencyBodyAccelerometerMagnitude-std()"     
[61] "frequencyBodyAccelerometerJerkMagnitude-mean()"
[62] "frequencyBodyAccelerometerJerkMagnitude-std()" 
[63] "frequencyBodyGyroscopeMagnitude-mean()"        
[64] "frequencyBodyGyroscopeMagnitude-std()"         
[65] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
[66] "frequencyBodyGyroscopeJerkMagnitude-std()"     
[67] "subject"                                       
[68] "activity"                                      
> 
> newData<-aggregate(. ~subject + activity, Data, mean)
> newData<-newData[order(newData$subject,newData$activity),]
> write.table(newData, file = "tidydata.txt",row.name=FALSE,quote = FALSE, sep = '\t')
> 
