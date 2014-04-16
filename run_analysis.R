if (!file.exists('assign.unique.name.R')) {
    stop('Oops, you need "assign.unique.name.R" to continue this code.
         Please download the file from my repo and try running this code again.
         Thanks!')
} else {
    source('assign.unique.name.R')
}
    
if (!('reshape2' %in% rownames(installed.packages()))) {
    stop('Oops, the following codes require "reshape2" library.
         Please install it to continue assessing my code. Many thanks!')
} else {
    library(reshape2)
}

# Read training data
train = read.table('train/X_train.txt', header=F, nrows=1e4, colClasses='numeric')
train.activity = read.table('train/y_train.txt', header=F, nrows=1e4, colClasses='factor')[,1]
train.subject = read.table('train/subject_train.txt', nrows=1e4, colClasses='numeric')[,1]

# Read test data
test = read.table('test/X_test.txt', header=F, nrows=5000, colClasses='numeric')
test.activity = read.table('test/y_test.txt', header=F, nrows=5000, colClasses='factor')[,1]
test.subject = read.table('test/subject_test.txt', nrows=5000, colClasses='numeric')[,1]

# Merge activity and subject number to training and test data
train$activity = train.activity
train$subject = train.subject
test$activity = test.activity
test$subject = test.subject

# Reorder so subject number is the first column
N.variable = ncol(train)
train = train[, c(N.variable, 1:(N.variable - 1))]
test = test[, c(N.variable, 1:(N.variable - 1))]

# (1) Merge training and test data
full = rbind(train, test)

# (4) Set variable names
var.names = read.table('features.txt', header=F, colClasses='character')[,2]

# Correct variable names (some have the same names)
# This is required for dcast function (for the 2nd dataset)
var.names = assign.unique.name(var.names)

# Add subject and activity to the list of variable names
var.names = c('subject', var.names, 'activity')

# (4) Set variable names
colnames(full) = var.names

# (2) Extract only variables whose name contains "mean()" or "std()"
# The 1 and N.variable in correspond to subject and activity variables, respectively
mean.std.vars = which(sapply(var.names, grepl, pattern='mean\\(\\)|std\\(\\)', ignore.case=T))
mean.std.data = full[, c(1, mean.std.vars, N.variable)]

# (3) Cast activity as factor and use descriptive names
act.labels = read.table('activity_labels.txt', colClasses='character')[, 2]
levels(full[, 'activity']) = act.labels

# (5) Use melt() and dcast() from reshape2 to get the mean for each variable,
#     per activity and per subject
full.melt = melt(full, id=c('subject', 'activity'), measure.vars=-c(1, N.variable))
full.averaged = dcast(full.melt, subject + activity ~ variable, mean)

# Write the two datasets to local files
# Also include column names
write.table(full, 'full.txt', col.names=T, row.names=F, sep='\t')
write.table(full.averaged, 'full.averaged.txt', col.names=T, row.names=F, sep='\t')