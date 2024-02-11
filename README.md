==========================  
Getting and Cleaning Data  
Final Assignment  
Thomas C. MacPherson  
02-10-2024  
==========================  

Repository for the final assignment in Getting and Cleaning Data course from Johns Hopkins Data Science specialization.

This file is to outline the process of completing the final project in the "Getting and Cleaning Data" course of the "Data Science" specialization on coursera. The purpose of this project is to show proficiency in obtaining and cleaning data from the internet. 

The data set that we will be using for this assignment can be found at:   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
The description of the data can be found at:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This is a very straight forward repository with a single readme file to explain a single code file entitled "run_analysis.R". You can also find a detailed description of the r script, list of all variables, and all transformations / work performed on the raw data by referencing "CodeBook.md". All steps should be completely reproducible.

Raw Data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The expereiments were video recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. For more information continue reading the description of the data linked above. 

=============================================

There is a single step in this program:  

1) Run the script "run_analysis.R". 

This program will locate the data files online, download them into a new child directory from your current working directory. It will unzip the files and open the data into R where it can be manipulated. 

For detailed instruction on how the data is manipulated and transformed into the final tidy data set, see the "CodeBook.md" file. Here, there is a detailed discussion of the data and all of the steps taken to clean the data. 

The final output of the "run_analysis.R" file is a clean and tidy data set printed to the data folder titled "finaldata.csv", it is reimported and presented in the console using View(). The file contains the average of each variable for each activity and each subject.

=============================================

The dataset includes

- README.md  
- AssignmentOutline.Rmd  
- CodeBook.md
- run_analysis.R

=============================================

This data was used with thanks to the following:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
