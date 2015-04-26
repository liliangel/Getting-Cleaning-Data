## Run Analysis scrip.

In order to evalute this scrip, please do the following considerations:
 1. The files were extracted to my main directory.
 2. For the step 2, the variables of mean, std  and meanFrequency values will be extracted with exception  for the   angle variables.
 3. Two packages will be called: plyr and reshape2.
<!-- -->

Using read.table() function I read my text files that I will use to prepare my data set.
After read the data I use dim() to know the size of these pieces of Data and like this I can plan my program.
I following the steps of the project description and I start to join my pieces.

1. Merges the training and the test sets to create one data set. 
     
Through  rbind() function I will join train and test results in the variable x_data.
    
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    
Using grep1() I will match the mean and standard deviation variables and will be collected in the Mean_Std_data data set.  
  
3. Uses descriptive activity names to name the activities in the data set
    
Using plyr package and the function join() to relate "y" labels data with "activities names" data,  these values will be colected in ""activities"" data frame.      
   
4. Appropriately labels the data set with descriptive variable names. 
    
According to features_info.text I will replace using gsub() function the following prefix:
t=time, f=frequency, Acc=Accelerometer, Gyro=Gyroscope, Mag=Magnitude and BodyBody=Body
I will add the "subject_data" column and the "activities_data" from step 3 to Mean_Std_data.      
    
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity.
     
I will order my data to analyse it better using melt() function 
and finally I will tidy  and summarize my data with "reshape2" package  and the dcast() function.
My final Data set will be collected in with the name Tidy_data data frame.
        
     

   



     
