# Load test data
dataset.test <- read.table("~/UCI HAR Dataset/test/X_test.txt")

# Add subject to dataset
dataset.tests <- read.table("~/UCI HAR Dataset/test/subject_test.txt")

# Load activity labels and rename them
dataset.testy <- read.table("~/UCI HAR Dataset/test/y_test.txt")
dataset.testy[dataset.testy=="1"] <- "WALKING"
dataset.testy[dataset.testy=="2"] <- "WALKING_UPSTAIRS"
dataset.testy[dataset.testy=="3"] <- "WALKING_DOWNSTAIRS"
dataset.testy[dataset.testy=="4"] <- "SITTING"
dataset.testy[dataset.testy=="5"] <- "STANDING"
dataset.testy[dataset.testy=="6"] <- "LAYING"

# Add activity and subject column to the test data set
dataset.test<- cbind(dataset.testy, dataset.tests, dataset.test)

# Add subject to dataset
dataset.trains <- read.table("~/UCI HAR Dataset/train/subject_train.txt")

# Load train data
dataset.train <- read.table("~/UCI HAR Dataset/train/X_train.txt")

# Read activity labels and rename them
dataset.trainy <- read.table("~/UCI HAR Dataset/train/y_train.txt")
dataset.trainy[dataset.trainy=="1"] <- "WALKING"
dataset.trainy[dataset.trainy=="2"] <- "WALKING_UPSTAIRS"
dataset.trainy[dataset.trainy=="3"] <- "WALKING_DOWNSTAIRS"
dataset.trainy[dataset.trainy=="4"] <- "SITTING"
dataset.trainy[dataset.trainy=="5"] <- "STANDING"
dataset.trainy[dataset.trainy=="6"] <- "LAYING"

# Add activity and subject column to the test data set
dataset.train<- cbind(dataset.trainy,dataset.trains, dataset.train)

# Merge the datasets. Using rbind as there are equal number of variables in both test and train datasets
dataset.merged <- rbind(dataset.test, dataset.train)

# Read in labels, append "Activity" and rename the columns in the merged dataset
dataset.variables <- read.table("~/UCI HAR Dataset/features.txt")
labels = c("Activity", "Subject", as.character(dataset.variables[,2]))
names(dataset.merged) <- labels

# Create subset of data with Activity, mean and std variables
selectedcol <- sort(c(grep("mean", labels), grep("std", labels), grep("Activity", labels), grep("Subject", labels)))
dataset.selected <- dataset.merged[,selectedcol]


# Create dataset with the average of each variable for each activity and each subject
tidy = aggregate(dataset.selected, by=list(Activity = dataset.selected$Activity, 
          Subject=dataset.selected$Subject), mean)

# Remove unnecessary columns and write to file
tidy[,3] = NULL
tidy[,3] = NULL

write.table(tidy, "tidy.txt")
