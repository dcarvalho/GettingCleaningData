library(dplyr)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

features <- read.table("UCI HAR Dataset/features.txt")
feature_actitivy <- data.frame(c(0,0),c("subject","activity"))
colnames(feature_actitivy) <- c("V1", "V2")
all_features <- rbind(feature_actitivy, features)

merged_X <- rbind(X_train, X_test)
merged_y <- rbind(y_train, y_test)
merged_subject <- rbind(subject_train, subject_test)

merged <- cbind(merged_subject, merged_y, merged_X)

colnames(merged) <- all_features[,2]

index_mean_std <- grep(pattern = '(.*(mean|std)\\(\\).*|activity|subject)', x = names(merged))

merged_mean_std <- merged[, index_mean_std]

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

merged_mean_std[,2] <- factor(merged_mean_std[,2], labels = activity_labels[,2])

merged_mean_std_grouped <- group_by(subject, activity)

write.table(merged_mean_std, file = "tidy_data.txt")