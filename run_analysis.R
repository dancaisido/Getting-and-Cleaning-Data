setwd("~/Coursera/Getting and Cleaning Data/Week4")

#Download the zipped file
library(RCurl)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="file.zip",method="libcurl")

#Unzip the downloaded file
unzip("file.zip")

#Load the Activity labels and Features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
#we will only need the 2nd column from each datasets
activityLabels[,2] <- as.character(activityLabels[,2])
features[,2] <- as.character(features[,2])

##############################################################################


##Keep only the fields needed in our datasets
###Extract only the measurements on the mean and standard deviation for each measurement.

#Find all the strings with "Mean" and "Std" from Features dataset
KeepFeatures <- grep(".*mean.*|.*std.*", features[,2])
KeepFeatures_name <- features[KeepFeatures,2]

#replace all the matches with appropriate names
KeepFeatures_name = gsub('-mean', 'Mean', KeepFeatures_name)
KeepFeatures_name = gsub('-std', 'Std', KeepFeatures_name)
KeepFeatures_name <- gsub('[-()]', '', KeepFeatures_name)


##############################################################################



##Load the datasets: for Testing
###Extracting only the set of fields that we created using Features
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")[KeepFeatures]
ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt")
#Combine all sets by appending to the next column
test<-cbind(subjecttest,ytest,xtest)
#Apply appropriate names on each of the columns
colnames(test)<-c("Subject","Activity",KeepFeatures_name)

##Load the datasets: for Training 
###Extracting only the set of fields that we created using Features
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")[KeepFeatures]
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
#Combine all sets by appending to the next column
train<-cbind(subjecttrain,ytrain,xtrain)
#Apply appropriate names on each of the columns
colnames(train)<-c("Subject","Activity",KeepFeatures_name)

#Combine Testing and Training datasets
All<-rbind(train,test)

##############################################################################

#Create another independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)

#numcolwise(mean) is a function that computes the mean of numeric columns
#ddply is a function that will apply a specific function into all its levels/factors.
All_ave = ddply(All, c("Subject","Activity"), numcolwise(mean))

#Final aggregated data
write.table(All_ave, file = "aggregated_data.txt",row.name=FALSE, quote=FALSE)