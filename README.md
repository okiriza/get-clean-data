Getting and Cleaning Data
==============

This is a repository for "Getting and Cleaning Data" course.

It contains four files:
- **README.md**: this file
- **CookBook.md**: description of Samsung data and its cleaned versions
- **run_analysis.R**: R code for cleaning up and transforming Samsung data
- **assign.unique.name.R**: R code containing `assign.unique.name` function

run_analysis.R
====

`run_analysis.R` is the main file for cleaning up and transforming Samsung data. In order to run it requires:
- `reshape2` library
- `assign.unique.name.R` file

Along with `assign.unique.name.R`, it should be put in the main directory of Samsung data (i.e. in the same directory with `activity_labels.txt`, `features.txt`, `features_info.txt`, and `train` and `test` directories).

At the end of execution it will write the tidied up datasets to file `full.txt` and `full.averaged.txt`.
- `mean.std.txt` contains merged training and test data, but only with variables whose name contains "mean()" or "std()".
- `full.averaged.txt` contains average of all variables grouped by subject and activity (one row per each combination of subject and activity).

assign.unique.name.R
====

`assign.unique.name.R` contains the function `assign.unique.name(v)`. This function is used to assign unique names to variable names of Samsung data. In Samsung data, there are 126 variables whose name is not unique. `dcast` function in `reshape2` library needs unique variable names else it will "merge" the values of two same-name variables.

`assign.unique.name(v)` takes as input a vector of characters and outputs a vector of characters whose elements are all unique. For each element in the input that is not unique, it adds as suffix "_i", where i = 2, 3, 4, ... . For example, if there the input vector contains `abc`, `abc`, and `abc`, this function will rename the second and third `abc` to `abc_2` and `abc_3`, respectively.
