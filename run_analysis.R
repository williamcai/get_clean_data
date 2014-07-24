# ------------------------------------------------------------------------------
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 
# ------------------------------------------------------------------------------

dir <- c("./")

# read activity labels
act_label     <- read.table(paste(dir,"activity_labels.txt",sep = ""))

# read features
feature_label <- read.table(paste(dir,"features.txt",       sep=""),
                            stringsAsFactors = FALSE)

# read training data
train     <- read.table(paste(dir,"X_train.txt",      sep = ""))
train_act <- read.table(paste(dir,"y_train.txt",      sep = "")) 
train_sub <- read.table(paste(dir,"subject_train.txt",sep = ""))

# ------------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------
data <- merge(x = train_act, y = act_label, by.x = "V1", by.y = "V1" )

data1 <- data.frame(cbind(train, data[,2],train_sub))

# ------------------------------------------------------------------------------
# 4.Appropriately labels the data set with descriptive variable names. 
# ------------------------------------------------------------------------------
names(data1) <- c(feature_label[,2],"activity","subject")

# read test data
test      <- read.table(paste(dir,"X_test.txt",      sep = ""))
test_act  <- read.table(paste(dir,"y_test.txt",      sep = ""))
test_sub  <- read.table(paste(dir,"subject_test.txt",sep = ""))

# ------------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------
data <- merge(x = test_act, y = act_label, by.x = "V1", by.y = "V1" )
data2 <- data.frame(cbind(test, data[,2],test_sub))

# ------------------------------------------------------------------------------
# 4.Appropriately labels the data set with descriptive variable names. 
# ------------------------------------------------------------------------------
names(data2) <- c(feature_label[,2],"activity","subject")

# ------------------------------------------------------------------------------
# 1.Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------------
data <- data.frame(rbind(data1,data2))

# ------------------------------------------------------------------------------
# 2.Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
# ------------------------------------------------------------------------------
sub <- c(grep("mean",feature_label[,2]),
         grep("std",feature_label[,2]))
subsetData <- data[,sub]
subsetData$subject  <- data$subject
subsetData$activity <- data$activity

write.table(subsetData,file="tidyData.txt",sep=",",row.names = FALSE)

# ------------------------------------------------------------------------------
# 5.Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 
# ------------------------------------------------------------------------------
v_sub <- data.frame()
v_act <- data.frame()
v_col <- ncol(subsetData)-2

for (i in 1:v_col) {
  v_sub <- rbind(v_sub,tapply(subsetData[,i],subsetData$subject, mean))
  v_act <- rbind(v_act,tapply(subsetData[,i],subsetData$activity,mean))
  if (i == v_col) {
    names(v_sub) <- names(tapply(subsetData[,i],subsetData$subject, mean))
    names(v_act) <- names(tapply(subsetData[,i],subsetData$activity,mean))
  }
}
v_a <- cbind(feature=feature_label[sub,2],v_act)
v_s <- cbind(feature=feature_label[sub,2],v_sub)

tidyData <- cbind(v_a,v_s[,2:ncol(v_s)])
write.table(tidyData,file="secondTidyData.txt",sep=",",row.names = FALSE)
