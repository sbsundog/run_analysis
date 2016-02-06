##  The purpose of this r script is  to meet the programming requirements for a Coursera Getting and Cleaning Data project
##  in which phsyical activity measured by a phone are processed to stated specifications for the class. 
##
## required libraries for this script
#
library(dplyr)
library(tidyr)
##  
##   Required files for this script are from UCI data depository
##            https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##   They were downloaded and unzipped into a local directory on a Windows 10 machine
##
##   Documentation for the datasets are found at 
##            http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
##    

volunteer.train.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/train/subject_train.txt")
names(volunteer.train.data)[1] <- "volunteer"  

##  Preliminary setup
##          1. Activity data is obtained and identified as factors, including the description of the activities
##             Activity data identifies the type of motion.
##          2. Vounteer data is obtained and identified as factors
##             Volunteer data identifies the individuals who performed the activities.
##          3. Features data is obtained.
##             Features data represents physical data measured by sensors on the Samsung S phone or dervied measures from them.
##             They are technical in nature, and the  feature list is employed as descriptive names for the variables rather than
##             the generic V1, V2. V3 and so on in the obtained files.


features.train.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/train/X_train.txt")
activity.train.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/train/y_train.txt")
names(activity.train.data)[1] <- "activity"     

volunteer.test.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/test/subject_test.txt")
names(volunteer.test.data)[1] <- "volunteer"    

features.test.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/test/X_test.txt")
activity.test.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/test/y_test.txt")
names(activity.test.data)[1] <- "activity" 

features.txt.data <- read.table("c:/Users/John/Documents/download/UCI HAR Dataset/features.txt")
##
#         Objective 4 is met in the following code by employing more descriptive variable names for the features variables and thereby replacing
##                   the generic V1, V2, V3 variable names with the original researchers' variable names
##                   and by employing "friendlier" names. Also, only names with std and mean are to be retained
##                   as well as eliminating '-()' from variable names.
##
colnames(features.test.data) <- features.txt.data[,2]
colnames(features.train.data) <- features.txt.data[,2]
colnames(features.test.data) = gsub('-mean', 'Mean', colnames(features.test.data))
colnames(features.test.data) = gsub('-std', 'Std',  colnames(features.test.data))
colnames(features.test.data) <- gsub('[-()]', '',  colnames(features.test.data))
colnames(features.train.data) = gsub('-mean', 'Mean', colnames(features.train.data))
colnames(features.train.data) = gsub('-std', 'Std',  colnames(features.train.data))
colnames(features.train.data) <- gsub('[-()]', '',  colnames(features.train.data))
##
##       Obective 3 states to use descriptive activity names and the following code fulfills the requirement
##                 as well as establishing volunteer and activity variables as factors for later data summarizing
##
activity.test.data$activity <- as.factor(activity.test.data$activity) 
levels(activity.test.data$activity) <- c("Walking", "Walking.Upstairs", "Walking.Downstairs", "Sitting", "standing", "Laying")
activity.train.data$activity <- as.factor(activity.train.data$activity)
levels(activity.train.data$activity) <- c("Walking", "Walking.Upstairs", "Walking.Downstairs", "Sitting", "standing", "Laying")
volunteer.test.data$volunteer <- as.factor(volunteer.test.data$volunteer)
volunteer.train.data$volunteer <- as.factor(volunteer.train.data$volunteer)

###activity.test.data$activity <- factor(activity.test.data$activity, levels= c("Walking", "Walking.Upstairs", "Walking.Downstairs", "Sitting", "standing", "Laying"))
###activity.train.data$activity <- factor(activity.train.data$activity, levels=c("Walking", "Walking.Upstairs", "Walking.Downstairs", "Sitting", "standing", "Laying"))

###
###       Objective 1 which is to merge the test and training data sets into one data set are fulfilled here
###                 but not until Objective 3 has been completed through the rbind 
###       
###
all.train.data <- cbind(volunteer.train.data, activity.train.data, features.train.data)
all.test.data <- cbind (volunteer.test.data, activity.test.data, features.test.data)
all.test.and.train.data <- rbind (all.test.data, all.train.data)
###
####   Objective 2 Eliminating the non mean and non std dev variables occurs through this code
###
all.test.and.train.data <- all.test.and.train.data[,!duplicated(colnames(all.test.and.train.data))] 
all.test.and.train.data.table <- tbl_df(all.test.and.train.data)
reduced.table.data <- select(all.test.and.train.data.table, volunteer, activity, contains("Mean"), contains("Std"), -contains("angle"), -contains("meanFreq"))
###
###   Objective 5 Creates a tidy data set and summarizes the mean for each activity and each volunteer
###             
group.volunteer.activity <- group_by(reduced.table.data, volunteer, activity)
summary.volunteer.activity <- summarize_each(group.volunteer.activity, funs(mean))
write.table(summary.volunteer.activity,"c:/Users/John/Documents/tidyrunanalysis.txt",row.name=FALSE)


