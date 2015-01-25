# Import data from test data sets
features <- read.table("features.txt", sep="")
features <- features[, 2]
activity <- read.table("activity_labels.txt", sep="")
subject_test <- read.table("subject_test.txt", sep = "")
x_test  <- read.table("X_test.txt", sep="")
names(x_test) <- features
y_test <- read.table("y_test.txt", sep="")
library(plyr)
y_test <- join(y_test, activity)
dat_test <- cbind(y_test, x_test)
dat_test <- cbind(subject_test, dat_test)
names(dat_test)[1] <- "SubjectID"
names(dat_test)[2] <- "ActivityID"
names(dat_test)[3] <- "ActivityDescription"
dat_test$Group <- "Test"

# Import data from train data sets
features <- read.table("features.txt", sep="")
features <- features[, 2]
activity <- read.table("activity_labels.txt", sep="")
subject_train <- read.table("subject_train.txt", sep = "")
x_train  <- read.table("X_train.txt", sep="")
names(x_train) <- features
y_train <- read.table("y_train.txt", sep="")
y_train <- join(y_train, activity)
dat_train <- cbind(y_train, x_train)
dat_train <- cbind(subject_train, dat_train)
names(dat_train)[1] <- "SubjectID"
names(dat_train)[2] <- "ActivityID"
names(dat_train)[3] <- "ActivityDescription"
dat_train$Group <- "Train"

# Tidy Data
dat <- rbind(dat_test, dat_train)
ind <- sort(c(grep(c("mean"), names(dat)), grep(c("Mean"), names(dat)), grep(c("std"), names(dat))))
dat <- dat[, c(1,2,3,ind)]

# Summarized Tidy Data
dat2 <- aggregate(.~ SubjectID + ActivityID, data = dat, mean)
write.table(dat2, file = "tidydata.txt", row.names=FALSE)
