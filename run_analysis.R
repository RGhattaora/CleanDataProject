# Load and format labels, isolate desired columns

actlabels <- read.table("activity_labels.txt")
actlabels[, 2] <- as.character(actlabels[, 2])

featurelabels <- read.table("features.txt")
featurelabels[, 2] <- as.character(featurelabels[, 2])

meancols <- grep("mean()", featurelabels[, 2])
stdcols <- grep("std()", featurelabels[, 2])
descols <- sort(c(meancols, stdcols))

labels <- featurelabels[descols, 2]

# Load test data, rename variables and headers, extract relevant data and construct feature table

setwd("test")

stest <- read.table("subject_test.txt")
colnames(stest) <- c("Subject")

ytest <- read.table("y_test.txt")
yval <- vector()
for (i in 1:nrow(ytest)) {
  yval[i] <- actlabels[ytest[i, 1], 2]
}
yval <- as.data.frame(yval)
colnames(yval) <- "Activity"

xtest <- read.table("X_test.txt")
xtest <- xtest[, descols]
colnames(xtest) <- labels

test_table <- cbind(stest, yval, xtest)

setwd("..")

# Load train data, rename variables and headers, extract relevant data and construct feature table

setwd("train")

strain <- read.table("subject_train.txt")
colnames(strain) <- c("Subject")

ytrain <- read.table("y_train.txt")
yval <- vector()
for (i in 1:nrow(ytrain)) {
  yval[i] <- actlabels[ytrain[i, 1], 2]
}
yval <- as.data.frame(yval)
colnames(yval) <- "Activity"

xtrain <- read.table("X_train.txt")
xtrain <- xtrain[, descols]
colnames(xtrain) <- labels

train_table <- cbind(strain, yval, xtrain)

setwd("..")

# Combine data sets and re-order

data_table <- rbind(test_table, train_table)
data_table <- data_table[order(data_table$Subject, data_table$Activity), ]

# Clean object list

rm(list = setdiff(ls(), "data_table"))

# Construct average table

avglabels <- unique(data_table[, c(1:2)])
subjects <- unique(avglabels[, 1])
activities <- as.character(unique(avglabels[, 2]))

avgtbl <- data_table[1:nrow(avglabels), ]
avgtbl <- avgtbl[NA, ]
avgtbl[, c(1:2)] <- avglabels[, c(1:2)]

rownum <- 1

for (i in subjects) {
  for (j in activities) {
    tmptbl <- data_table[data_table[, 1] == i, ]
    tmptbl <- tmptbl[tmptbl[, 2] == j, ]
    tmprow <- sapply(tmptbl[, -c(1:2)], mean)
    avgtbl[rownum, -c(1:2)] <- tmprow
    rownum <- rownum + 1
  }
}

rownames(avgtbl) <- c(1:nrow(avgtbl))

# Clean object list

rm(list = ls(all = TRUE)[!(ls(all = TRUE) %in% c("data_table", "avgtbl"))])
