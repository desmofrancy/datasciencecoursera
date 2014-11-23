#                  GETTING AND CLEANING DATA - COURSE PROJECT                 #

###############################################################################
#     1. Merges the training and the test sets to create one data set.        #
###############################################################################

# Loading and merging training and test sets.
tmp1 <- read.table("train/X_train.txt")
tmp2 <- read.table("test/X_test.txt")
X    <- rbind(tmp1, tmp2)

# Loading and merging training and test subjects information. 
# Each row identifies the subject who performed the activity.
# Its range is from 1 to 30. 
tmp1 <- read.table("train/subject_train.txt")
tmp2 <- read.table("test/subject_test.txt")
Subjs <- rbind(tmp1, tmp2)

# Loading and merging training and test labels.
tmp1 <- read.table("train/y_train.txt")
tmp2 <- read.table("test/y_test.txt")
y    <- rbind(tmp1, tmp2)

###############################################################################
#    2. Extracts only the measurements on the mean and standard deviation     #
###############################################################################

# Loading features
features <- read.table("features.txt")

# Identify mean() and std() entries (avoiding ambiguity with meanFreq entries)
# Grep recognises the parentheses by quoting them with \\
idx_mean_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])

X        <- X[, idx_mean_std]
names(X) <- features[idx_mean_std, 2]
names(X) <- gsub("\\(|\\)", "", names(X)) # Removing parentheses from names
names(X) <- tolower(names(X)) # Converting names to lowercase

###############################################################################
#  3. Uses descriptive activity names to name the activities in the data set  #
###############################################################################

# Loading activity labels
activities      <- read.table("activity_labels.txt")

# Activities name simplification and assignement
activities[, 2] <- gsub("_", "", tolower(as.character(activities[, 2])))
y[,1]           <- activities[y[,1], 2]
names(y)        <- "activity"

###############################################################################
#    4. Appropriately labels the data set with descriptive variable names.    #
###############################################################################

# Combination of subjects information, data and features, and table saving.
names(Subjs) <- "subject"
clean_table  <- cbind(Subjs, y, X)
write.table(clean_table, "merged_clean_data.txt", row.name=FALSE )

###############################################################################
#     5. Creates a 2nd, independent tidy data set with the average of each    #
#               variable for each activity and each subject.                  #
###############################################################################

uniqueSubjs   <- unique(Subjs)[,1]
numSubjs      <- length(unique(Subjs)[,1])
numActs       <- length(activities[,1])
numCols       <- dim(clean_table)[2]
average_table <- clean_table[1:(numSubjs*numActs), ]

# Set counter 
row = 1

# Loop over subjects (1:30) and activities (1:60)
for (iSubjs in 1:numSubjs) {
  for (iActs in 1:numActs) {
    
    # The first two columns will represent the subject number and the 
    # activity type respectively
    average_table[row, 1] <- uniqueSubjs[iSubjs]
    average_table[row, 2] <- activities[iActs, 2]
    
    # Find in clean_table the entries corresponding to iSubjs and iActs
    tmp <- clean_table[clean_table$subject  == iSubjs & 
                       clean_table$activity == activities[iActs, 2], ]
    
    # Calculate the mean and and save it in a new table
    average_table[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    
    # Update counter
    row = row + 1
  }
}

# Table saving
write.table(average_table, "average_data.txt", row.name=FALSE)
