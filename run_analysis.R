##Getting and Cleaning Data - Final Assignment.

## Create a directory to store the raw data.
if(!file.exists("./data")){dir.create("./data")}

## Download the raw data files from the internet
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="./data/Dataset.zip",method="curl")
dateDownloaded<-date()

## Unzip the downloaded files
zipF<-"./data/Dataset.zip"
outDir<-"./data/UnzipedData"
unzip(zipF,exdir=outDir)

## Load the libraries that we will be using
library(dplyr)

## Read the .txt files into R Studio
activitylabels<-read.table("./data/UnzipedData/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./data/UnzipedData/UCI HAR Dataset/features.txt")
subject_test<-read.table("./data/UnzipedData/UCI HAR Dataset/test/subject_test.txt")
tlabels_test<-read.table("./data/UnzipedData/UCI HAR Dataset/test/y_test.txt")
set_test<-read.table("./data/UnzipedData/UCI HAR Dataset/test/X_test.txt")
subject_train<-read.table("./data/UnzipedData/UCI HAR Dataset/train/subject_train.txt")
tlabels_train<-read.table("./data/UnzipedData/UCI HAR Dataset/train/y_train.txt")
set_train<-read.table("./data/UnzipedData/UCI HAR Dataset/train/X_train.txt")

## Start by merging the test and train tables
subject_data<-rbind(subject_test,subject_train)
label_data<-rbind(tlabels_test,tlabels_train)
set_data<-rbind(set_test,set_train)

label_data<-data.frame(lapply(label_data,function(x){gsub(1,"WALKING",x)}))
label_data<-data.frame(lapply(label_data,function(x){gsub(2,"WALKING_UPSTAIRS",x)}))
label_data<-data.frame(lapply(label_data,function(x){gsub(3,"WALKING_DOWNSTAIRS",x)}))
label_data<-data.frame(lapply(label_data,function(x){gsub(4,"SITTING",x)}))
label_data<-data.frame(lapply(label_data,function(x){gsub(5,"STANDING",x)}))
label_data<-data.frame(lapply(label_data,function(x){gsub(6,"LAYING",x)}))

## Let's name the variables in the data.frames for understanding
## Let's use the features file to create a naming vector
names<-features[,2]
colnames(set_data)<-names
colnames(subject_data)<-c("subject")
colnames(label_data)<-c("activity")

## Let's subset the set_data with a vector of "mean()" and "std()"
subset<-grepl("mean()|std()",features[,2])
sub_data<-set_data[,subset]

## Let's merge our three data.frames for our total data.table
data<-cbind(subject_data,label_data,sub_data)

## Let's order our data based on the subject (optional)
data<-arrange(data,subject)

## Group by subject/activity and summarize data means
tidy<-data %>% group_by(subject,activity) %>% summarise(across(everything(),list(mean)))

## Write the table to a new file so we have a clean standalone data set 
write.table(tidy,"./data/finaldata.txt",row.names=FALSE)

## Open the clean data set
tidydata<-read.table("./data/finaldata.txt")

## View the tidy data in a clean format
View(tidydata)
