###############################################################################
# COURSERA - Getting and Cleaning Data
# John Hopkins Bloomberg School of Public Health
# Course Project
# 24.05.2014
###############################################################################
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 
###############################################################################
# READ SOURCES
# Test
dfx_test <-read.table("./X_test.txt")
dfy_test <-read.table("./y_test.txt")
subject_test <-read.table("./subject_test.txt")
# Train
dfx_train <-read.table("./X_train.txt")
dfy_train <-read.table("./y_train.txt")
subject_train <-read.table("./subject_train.txt")
# Features
fx <-read.table("./features.txt")
# Activity Labels
activity_labels <-read.table("./activity_labels.txt")
###############################################################################
# Merges the training and the test sets to create one data set.
# columnbind TEST
test<-cbind(subject_test,dfy_test)
test<-cbind(test,dfx_test)
# columbind TRAIN
train<-cbind(subject_train,dfy_train)
train<-cbind(train,dfx_train)
# rowbind TEST and TRAIN
test_and_train <- rbind(test,train)
###############################################################################
# Search for mean and std
features1 <-fx[grep("std",fx$V2),]
features2 <-fx[grep("mean",fx$V2),]
features <- rbind(features1,features2)

# Rename column headers (feature names)
names(test_and_train)[1] <- "subject"
names(test_and_train)[2] <- "activity"
for (i in 1:nrow(fx))
        names(test_and_train)[i+2] <- as.character(fx[i,]$V2)
meanstd <- lapply(features$V2,as.character)
# add to list
x<-c("subject","activity")
meanstd<-c(x,meanstd)
vars <- colnames(test_and_train)

# Filter for only mean and std
test_and_train <- test_and_train[, (vars %in% meanstd)]

# clean feature names
names(test_and_train) <- gsub("\\(","",names(test_and_train))
names(test_and_train) <- gsub("\\)","",names(test_and_train))
names(test_and_train) <- gsub("-","",names(test_and_train))

# set activity labels
for (i in 1:nrow(test_and_train))
{ 
        test_and_train[i,2] = as.character(activity_labels[ test_and_train[i,2] , ]$V2)       
}      
###############################################################################
# Melt and Cast 
tat_m <- melt(test_and_train,id=c("subject","activity"),measure.vars=c(names(test_and_train)[3:79]))
result<-dcast(tat_m,subject+activity~variable,mean)
###############################################################################
# Write tidy data to file
write.table(result, file = "tidy.txt",sep="\t")
###############################################################################
