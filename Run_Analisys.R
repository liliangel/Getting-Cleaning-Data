# In order to evalute this scrip, please do the following considerations:
# 1- The files were extracted to my main directory.
# 2- For the step 2, the variables of mean and std values will be extracted with exception  for the angle variables.
  
  library(plyr)
  library(reshape2)

 # Reading my text files that I will use to prepare my data set.

  x_train <- read.table("./X_train.txt")
  y_train <- read.table("./y_train.txt")
  subject_train <- read.table("./subject_train.txt")
  x_test <- read.table("./X_test.txt")
  y_test <- read.table("./y_test.txt")
  subject_test <- read.table("./subject_test.txt")
  features_data <- read.table("./features.txt")
  activities_data<-read.table("./activity_labels.txt")

 # I used dim() to know the size of these pieces of Data and plan my program.
 # So I start to join my pieces.

# 1. Merges the training and the test sets to create one data set.

    x_data <- rbind(x_train, x_test)
   
  #  I will join the variable names to x_data.
    
    names(x_data)<- features_data[,2]
 
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    
   
    Mean_Std_col <- grepl("mean|std", features_data[,2])
    Mean_Std_data <- x_data[, Mean_Std_col]
   

# 3. Uses descriptive activity names to name the activities in the data set
    
  # Using plyr package and the function join to relate "y" labels data with "activities names" data
     
     
     y_data <- rbind(y_train, y_test)
     names(y_data) <- "labels"
     names(activities_data)<- c("labels", "Activity")
     activities <-join(y_data, activities_data,type="inner") 

  # Then remove the labels column from activities data frame. In that way activities variable has only the activities names.
     activities$labels <- NULL 
      
# 4. Appropriately labels the data set with descriptive variable names. 
    
     # Acording to features_info.text I will replace the followin prefix:
     # t=time, f=frequency, Acc=Accelerometer, Gyro=Gyroscope, Mag=Magnitude and BodyBody=Body 
        
     names(Mean_Std_data)<-gsub("^t", "time", names(Mean_Std_data))
     names(Mean_Std_data)<-gsub("^f", "frequency", names(Mean_Std_data))
     names(Mean_Std_data)<-gsub("Acc", "Accelerometer", names(Mean_Std_data))
     names(Mean_Std_data)<-gsub("Gyro", "Gyroscope", names(Mean_Std_data))
     names(Mean_Std_data)<-gsub("Mag", "Magnitude", names(Mean_Std_data))
     names(Mean_Std_data)<-gsub("BodyBody", "Body", names(Mean_Std_data))
     
     # I will add the "subject_data" column and the "activities_data" from step 3 to Mean_Std_data.
      
     subject_data <- rbind(subject_train, subject_test)
     names(subject_data) <- "Subject"
     Mean_Std_data <- cbind(Mean_Std_data,subject_data)
     
     Mean_Std_data <- cbind(Mean_Std_data, activities)
     
    
  
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activi
     
     #I will order my data to analyze how to reshape and sumarize it better.
        
      narrow<-melt(Mean_Std_data, id.vars=c("Subject", "Activity"))

     #I tidy my data with "reshape2" package  and the dcast() function.

      Tidy_data<- tidied <- dcast(narrow, Subject + Activity ~ variable, mean)
      write.table(Tidy_data, "Tidy_data.txt", sep=" ", row.names = FALSE, col.names=TRUE)


      



     
