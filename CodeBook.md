## CodeBook for Final Assignment of "Getting and Cleaning Data"

### Introduction

In this assignment we will be merging datasets of 30 subjects participating in 6 different activities, multiple times, over an extended period of time. We will then be isolating the mean and standard deviation of multiple variables recorded by an athletic gyroscope in their smartphone attached to their wasteband. After isolating that data, we will be creating a clean dataset that shows the mean of each variable based on subject and activity for the duration of the experiment. 

Description of RawData:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

RawData:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Assignment completed with R Version: 4.3.2
Assignment completed with dplyr version: 1.1.4

### General Outline
Step 1) Check/Create directory to store raw data files  
  Check for existing folder or create a new one called "data"  
Step 2) Download Data files to the new directory  
  The file will be downloaded as a .zip folder  
Step 3) Unzip the files in the directory to "Unzipped" folder  
  The unzipping process pulls out multiple files and paths   
Step 4) Load the raw data files into R   
  These files include our Activity lists, Variable names, and data resulting in multiple tables  
Step 5) Merge test and training tables together  
  We first want to merge the test and training data together  
Step 6) Add descriptive names to the activity variable  
  It's easier to replace the id number with the activity while the data.frame is small  
Step 7) Appropriately name the variables of the data frames  
  Using the features table, create a naming vector and appropriately name the variables  
Step 8) Extract only the mean and standard deviation for each measurement  
  Extract out all of the relevant variables to our goal (ie. mean and std)  
Step 9) Merge subject, activity and data set for a full clean, albeit large data set  
  Combine columns from the three data frames so that we have a subject and activity for every recording  
Step 10) Create a new tidy set with average of each variable for each activity and each subject  
  Group by subject and activity, then find the mean of every variable for each grouping

### Variables

Activity labels in processing step prior:  
1 WALKING  
2 WALKING_UPSTAIRS  
3 WALKING_DOWNSTAIRS  
4 SITTING  
5 STANDING  
6 LAYING  

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-mean()-X  
tbodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X  
tBodyAccJerk-std()-Y  
tBodyAccJerk-std()-Z  
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X  
tBodyGyro-std()-Y  
tBodyGyro-std()-Z  
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X  
tBodyGyroJerk-std()-Y  
tBodyGyroJerk-std()-Z  
tBodyAccMag-mean()  
tBodyAccMag-std()  
tGravityAccMag-mean()  
tGravityAccMag-std()  
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()  
tBodyGyroMag-mean()  
tBodyGyroMag-std()  
fBodyAcc-mean()-X  
fBodyAcc-mean()-Y  
fBodyAcc-mean()-Z  
fBodyAcc-std()-X  
fBodyAcc-std()-Y  
fBodyAcc-std()-Z  
fBodyAcc-meanFreq()-X  
fBodyAcc-meanFreq()-Y  
fBodyAcc-meanFreq()-Z  
fBodyAccJerk-mean()-X  
fBodyAccJerk-mean()-Y  
fBodyAccJerk-mean()-Z  
fBodyAccJerk-std()-X  
fBodyAccJerk-std()-Y  
fBodyAccJerk-std()-Z  
fBodyAccJerk-meanFreq()-X  
fBodyAccJerk-meanFreq()-Y  
fBodyAccJerk-meanFreq()-Z  
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X  
fBodyGyro-std()-Y  
fBodyGyro-std()-Z  
fBodyGyro-meanFreq()-X  
fBodyGyro-meanFreq()-Y  
fBodyGyro-meanFreq()-Z  
fBodyAccMag-mean()  
fBodyAccMag-std()  
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()  
fBodyBodyGyroMag-mean()  
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean()  
fBodyBodyGyroJerkMag-std()  
angle(tBodyAccJerkMean),gravityMean)  
angle(tBodyGyroMean,gravityMean)  
angle(tBodyGyroJerkMean,gravityMean)  
angle(X,gravityMean)  
angle(Y,gravityMean)  
angle(Z,gravityMean)  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

There is no missing data in the data set.

### Transformations
In this section, I will describe the data transformations made while cleaning and organizing the data, as well as the reasoning behind such steps. Firstly, the data was contained in .txt formats, so simply using read.table() allowed for importing of the data to data.frames. I chose to combine the subjects files together, the activity labels file together, and the data_set files together seperatly at first, in orded to lower the burden of cleaning the data. Firstly, this allowed me to replace all of the activity_id numbers in the y_test and y_train files to the actual activities using a simple lapply with a replace function for each numerical value. I was also then able to use a logical factor to subset the data_set file for the columns that contained the word mean or std. There was not clarification on whether we should only take variables ending in mean() or std(), so I choose to include all variables that contained mean or std anywhere in the title. I figured it would be better to include them and remove them later than not to have access to them at all. This left me with three data frames, 1) subject numbers (1-30), 2) Activity type and 3) sub-setted data with mean and std values. This data had accurate "data values" for activities and I used descriptive titles for the variables (along with their description herein). Finally, I wanted to analyze every subjects mean - mean and std values for each activity. So I grouped the data by subject and activity and then created a new data.frame that summarized the mean data of all columns based on subject and activity. I then saved this data table as "finaldata.csv", so that we don't have to run the script every time we want this tidy data set. The script itself reopens the data table and pushes it to the console using the View() so we can work with it immediately. 
