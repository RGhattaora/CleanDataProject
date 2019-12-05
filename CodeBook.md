Raw Data Used:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Files from raw data used:

activity_labels.txt

features.txt


subject_test.txt

X_test.txt

y_test.txt


subject_test.txt

X_test.txt

y_test.txt



Intermediate analysis variables

actlabels - table of descriptive activity labels

featurelabels - table of descriptive measurement labels

meancols - table isolating the columns where mean measurements are held

stdcols - table isolating the columns where standard deviation measurements are held

descols - combined vector of desired columns, i.e. the columns containing either mean or standard deviation measurements

labels - vector containing the descriptive measurement labels for the desired columns


yval - vector of descriptive activity labels

test_table - temporary table of combined test data

test_table - temporary table of combined test data


avglabels - table of unique combinations of subjects and activity labels

subjects - vector of unique subjects

activities - vector of unique activity labels


rownum - temporary row number

tmptbl - temporary table holding measuements for a particular subject/activity label combination

tmprow - vector of average measurements for a particular subject/activity label combination


Final outputs:

data_table - full combined test and test data sets, with descriptive labels and only mean and standard deviation measurements

avgtbl - complete table of average measurments for each unique combination of subject and activity label
