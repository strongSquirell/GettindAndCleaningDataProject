getAndClean <- function(){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
  unzip("data.zip")
  
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = F, sep = "")
  features <- read.table("UCI HAR Dataset/features.txt", header = F, sep = "")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = F, sep = "")
  y_test  <- read.table("UCI HAR Dataset/test/y_test.txt", header = F, sep = "")
  X_test  <- read.table("UCI HAR Dataset/test/X_test.txt", header = F, sep = "")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = F, sep = "")
  y_train  <- read.table("UCI HAR Dataset/train/y_train.txt", header = F, sep = "")
  X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = F, sep = "")
  
  testdata <- cbind(subject_test, y_test, X_test)
  traindata <- cbind(subject_train, y_train, X_train)
  finalData <- rbind(testdata, traindata)
  
  names <- paste(features[,1], features[,2], sep = "_")
  names <- c("subjectID","activityNames", names)
  names(finalData) <- names
  nmth <- grep("mean",names)
  nsth <- grep("std",names)
  
  mnsddata <- finalData[,c(1,2,nsth,nmth)] 
  
  tidyData <- aggregate(mnsddata[, 3:81], by=list(mnsddata$subjectID, mnsddata$activityNames), FUN=mean)
  colnames(tidyData)[1] <- "subjectID"
  colnames(tidyData)[2] <- "activityNames"
  write.table(tidyData, file = "TidyData.txt", row.name=FALSE)
}
