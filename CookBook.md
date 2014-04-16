# CookBook.md

This file describes Samsung data (shortly) and the two cleaned versions of it.

## Samsung data

Samsung data contains a total of 10,299 observations divided into 7,352 observations in training data and 2,947 observations in test data. Each observation contains measurements of 561 variables taken from accelerometer and gyroscope attached to a human subject. While being observed, the subjects may do any of 6 activities: walking, walking upstairs, walking downstairs, standing, sitting, or laying. The information of which activity and which subject are associated to each observation is also available in separate files.

## mean.std.txt

This file contains cleaned up Samsung data based on the following instructions:

1. Observations in training and test data are merged.
2. Only measurements with name containing "mean()" or "std()" are retained.
3. Activities are assigned names ("WALKING", "WALKING UPSTAIRS", etc) instead of numbers. They are also added as a column to the merged dataset.
4. Column names are added to the dataset.
 
`mean.std.txt` can be read into R with the command `read.table('mean.std.txt', header=T)` as a data frame with 10,299 rows and 563 columns (66 measurements + subject + activity columns).

### Processes and transformations for obtaining mean.std.txt

The full code can be obtained in `run_analysis.R`.

1. First, training and test datasets are loaded into R from files `train/X_train.txt` and `test/X_test.txt`, respectively.
2. The activities and subjects are loaded from files `train/y_train.txt` and `train\subject_train.txt` and appended to the training data (similarly for test data).
3. Training and test data are then merged into one dataset (`instruction 1`).
4. Variable names are read from `features_info.txt`.
5. Note that in `features_info.txt` there are 126 variables that have non-unique names. This will be problematic with `dcast()` function for `instruction 5` as it will merge values that are from variables with the same names. Therefore, variables with non-unique names are renamed by adding suffix "_i", where i = 2, 3, 4, ... . For example, there are 3 variables with name `fBodyAcc-bandsEnergy()-1,8`, so the last two of them are renamed to `fBodyAcc-bandsEnergy()-1,8_2` and `fBodyAcc-bandsEnergy()-1,8_3`, respectively. The function to do this is contained in file `assign.unique.name.R`.
5. The corrected variable names are assigned as column names for the merged data. Here it corresponds to `instruction 4` (as this instruction is very similar to `instruction 3` I interpret it as "Appropriately labels the data with descriptive variable names".
6. Activity names are read from `activity_labels.txt` and the numeric activity variable is replaced with factor which reflects these names (`instruction 3`). For example, activity 5 becomes `STANDING`.
7. Finally, the merged data is subset by only keeping variables whose name contains "mean()" or "std()" (`instruction 2`). This is accomplished by using `sapply()` and `grepl()` functions.

## full.averaged.txt

This file contains cleaned up Samsung data based on the following instructions:

1. Create a dataset containing the average of each variable for each activity and each subject.
 
`full.averaged.txt` can be read into R with the command `read.table('full.averaged.txt', header=T)` as a data frame with 180 rows and 563 columns (561 measurements + subject + activity columns).

### Processes and transformations for obtaining full.averaged.txt

The full code can be obtained in `run_analysis.R`.

1. A data frame is constructed from the fully merged data (step 6 above) using the `melt()` function. The ID variables are subject and activities, and the remaining variables become measurement variables.
2. The melted data frame is input into `dcast()` function of library `reshape2()` with `mean()` function as the aggregator. This results in a data frame where each row contains average values of all measurement variables and each row corresponds to a specific combination of subject and activity. For example, row 1 might refer to subject 1 WALKING.
