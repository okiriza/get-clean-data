Getting and Cleaning Data
==============

This is a repository for "Getting and Cleaning Data" course.

It contains four files:
- **README.md**: this file
- **CookBook.md**: description of Samsung data and its cleaned versions
- **run_analysis.R**: R code for cleaning up and transforming Samsung data
- **assign.unique.name.R**: R code containing `assign.unique.name` function

`run_analysis.R` is the main file for cleaning up and transforming Samsung data. In order to run it requires:
- `reshape2` library
- `assign.unique.name.R` file

Along with `assign.unique.name.R`, it should be put in the main directory of Samsung data (i.e. in the same directory with `activity_labels.txt`, `features.txt`, `features_info.txt`, and `train` and `test` directories).

At the end of execution it will write the tidied up datasets to file `full.txt` and `full.averaged.txt`.
- `full.txt` contains all training and test data, but only with variables whose name contains "mean()" or "std()".
- `full.averaged.txt` contains average of all variables grouped by subject and activity (one row per each combination of subject and activity).
