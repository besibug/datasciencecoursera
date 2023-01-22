Code Book
================
besibug

### Base Experiment Overview

30 participants, aged between 19-48, performed six different activities
while wearing a smartphone on the waist. Using the phones inbuild motion
sensors, a training and a test data set were created to feed an ML
algorithm. A more thorough explanation of the base experiment performed
by UCI can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Files in the UCI HAR Dataset

`` `features.txt` `` Names of the 561 features. These are the
measruement parameters.

`` `activity_labels.txt` `` Names and IDs for each of the 6 activities.

`` `X_train.txt` `` Basis of the training data set. 7352 observations of
the 561 features. 21/30 participants

`` `subject_train.txt` `` vector of 7352 integers, containing the ID of
the volunteer related to each of the observations in X_train.txt

`` `y_train.txt` `` vector of 7352 integers, denoting the ID of the
activity related to each of the observations in X_train.txt.

`` `X_test.txt` `` Basis of the testing data set. 2947 observations of
the 561 features, 9/ 30 volunteers.

`` `subject_test.txt` `` vector of 2947 integers, listing volunteer-ID
related to each of the observations in X_test.txt.

`` `y_test.txt` `` vector of 2947 integers, denoting the ID of the
activity related to each of the observations in X_test.txt.

### Unused Files

`` `features_info.txt` `` contains additional explanation about the data
acquisition, but was not used for analysis. `` `Inertial Signals` ``
folder was also not needed for analysis.

### Processing Steps performed in R script

Running `` `run_analysis.R` `` does the following:

1.  Downloads and unzips the UCI HAR Dataset.
2.  Reads all relevant data files into dataframes, assigns new coloumn
    names.
3.  After merging the test and training data sets respectively, combines
    both into one big data set.
4.  Extracts only the measurement of interest (“mean” and standard
    deviation “std()”), according to the task given.
5.  Uses this to subset the combined data set
6.  Renames the numeric activity code to the descriptive terms
    (e.g. “WALKING)
7.  Takes the mean of each feature for each activity and subject and
    stores them in a new tidy dataset (.csv)

### Variables and Sets

`` `x_train` ``, `` `y_train` ``, `` `subject_train` ``, `` `x_test` ``,
`` `y_test` ``, `` `subject_test` `` : data from the downloaded files
`` `features` ``: names for the x_train and x_test dataset; used to
rename coloumns `` `activity_label` ``: names for the six activities;
used for descriptive naming `` `cmb_set` ``: Combined data set,
containing both the test and training data. `` `cmb_set_2` ``: Combined
data set, that has been subset to only contain coloumns with “mean” and
“std” `` `tidy` ``: Tidy dataset, final output as .csv files
