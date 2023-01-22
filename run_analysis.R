### 0 Getting the data

        data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(data_url, destfile = "./programming_assignment_03/project.zip")
        unzip(zipfile = "./programming_assignment_03/project.zip", exdir = "./programming_assignment_03")

### Exploring + reading data into data frames
        
        list.files("./programming_assignment_03/UCI HAR Dataset", recursive = TRUE)

        features <- read.table("./programming_assignment_03/UCI HAR Dataset/features.txt",header = FALSE)
        str(features)
        
        activity_labels <- read.table("./programming_assignment_03/UCI HAR Dataset/activity_labels.txt",header = FALSE)
        str(activity_labels)
        
        x_test <- read.table("./programming_assignment_03/UCI HAR Dataset/test/X_test.txt",header = FALSE)
        y_test <- read.table("./programming_assignment_03/UCI HAR Dataset/test/Y_test.txt",header = FALSE)
        subject_test <- read.table("./programming_assignment_03/UCI HAR Dataset/test/subject_test.txt",header = FALSE)
        str(x_test)
        str(y_test)
        str(subject_test)
        
        x_train <- read.table("./programming_assignment_03/UCI HAR Dataset/train/X_train.txt",header = FALSE)
        y_train <- read.table("./programming_assignment_03/UCI HAR Dataset/train/Y_train.txt",header = FALSE)
        subject_train <- read.table("./programming_assignment_03/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
        str(x_train)
        str(y_train)
        str(subject_train)

### Naming the coloumns as variables
        colnames(x_test) = features[, 2]
        colnames(y_test) = "Activity_ID"
        colnames(subject_test) = "Subject_ID"        
        
        colnames(x_train) = features[, 2]
        colnames(y_train) = "Activity_ID"
        colnames(subject_train) = "Subject_ID"

### 1) Merges the training and the test sets to create one data set.

        test <- cbind(subject_test, y_test, x_test)
        train <- cbind(subject_train, y_train, x_train)
        
        cmb_set <- rbind(train, test)
        
### 2) Extracts only the measurements of the mean and standard deviation for 
###    each measurement. 
     
                ### get all measurements containing "mean" and "std" 
                ### subset combined dataset 
        
        subfeature <- features$V2[grepl("mean\\(\\)|std\\(\\)", features$V2)]
        
        cmb_set_2 <- subset(cmb_set, select = c(as.character(subfeature), "Subject_ID", "Activity_ID"))
        
### 3) Uses descriptive activity names to name the activities in the data set
        
        ### activity_label contains the 6 activities
        
        cmb_set_2$Activity_ID <- factor(cmb_set_2$Activity_ID, labels=c("Walking",
                                                                "Walking Upstairs", 
                                                                "Walking Downstairs", 
                                                                "Sitting", 
                                                                "Standing", 
                                                                "Laying"))
        
### 4) Appropriately labels the data set with descriptive variable names. 
        
        ###Already done - See Line 31
        
### 5) From the data set in step 4, creates a second, independent tidy data set 
###    with the average of each variable for each activity and each subject.
        
        tidyset <- aggregate(. ~Subject_ID + Activity_ID, cmb_set_2, mean)
        tidyset <- tidyset[order(tidy$Subject_ID,tidyset$Activity_ID),]
        write.table(tidyset, file = "tidydata.csv",row.name=FALSE)