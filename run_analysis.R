library(dplyr)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

features <- read.table("UCI HAR Dataset/features.txt")
feature_actitivy <- data.frame(0,"activity")
colnames(feature_actitivy) <- c("V1", "V2")
all_features <- rbind(feature_actitivy, features)

merged_X <- rbind(X_train, X_test)
merged_y <- rbind(y_train, y_test)

merged <- cbind(merged_y, merged_X)

colnames(merged) <- all_features[,2]

index_mean_std <- grep(pattern = '(.*(mean|std)\\(\\).*|activity)', x = names(merged))

merged_mean_std <- merged[, index_mean_std]

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

