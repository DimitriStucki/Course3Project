
### R script to tidy data on Google smartphone accelerometers

################
## Preliminaries
setwd("./Data/")
library(plyr) # used functions: revalue()


##################################################################################################################
## Script start

## Procedure described in README.md

## 3.1.1)
X_train <- read.table("./train/X_train.txt",header=FALSE)
dim(X_train) ## 7352 observations of 561 variables

## 3.1.2)
Features <- read.table("./features.txt",header=FALSE)
dim(Features) ## 561 "observations" of 2 variables

## 3.1.3)
Subject <- read.table("./train/subject_train.txt",header=FALSE)
dim(Subject) ## 7352 "observations" of 1 variable

## 3.1.4)
names(X_train) <- as.character(Features$V2)

## 3.1.5)
Y_train <- read.table("./train/y_train.txt",header=FALSE)
dim(Y_train) ## 7352 observations of 1 variable

## 3.1.6)
TrainSet <- data.frame(activity=Y_train$V1,subject=as.factor(Subject$V1),set=factor(rep("Train",dim(Y_train)[1])),
                          X_train[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,
                                     424:429,503:504,516:517,529:530,542:543)])

## 3.1.7)
rm(Y_train,X_train)

## 3.2.1)
X_test <- read.table("./test/X_test.txt",header=FALSE)
dim(X_test) ## 2947 observations of 561 variables

## 3.2.2)
names(X_test) <- as.character(Features$V2)

## 3.2.3)
Subject <- read.table("./test/subject_test.txt",header=FALSE) ## (overwrite from previous as not needed anymore)
dim(Subject) ## 2947 "observations" of 1 variable

## 3.2.4)
Y_test <- read.table("./test/y_test.txt",header=FALSE)
dim(Y_test) ## 2947 observations of 1 variable

## 3.2.5)
TestSet <- data.frame(activity=Y_test$V1,subject=as.factor(Subject$V1),set=factor(rep("Test",dim(Y_test)[1])),
                          X_test[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,
                                     424:429,503:504,516:517,529:530,542:543)])

## 3.2.6)
rm(Y_test,X_test,Subject,Features)

## 3.2.7)
AccelerometerData <- as.data.frame(rbind(TrainSet,TestSet))

## 3.2.8)
rm(TrainSet,TestSet)

## 3.3.1)
AccelerometerData$activity <- revalue(as.factor(AccelerometerData$activity),
                                      c("1"="Walking","2"="WalkingUpstairs", "3"="WalkingDownstairs",
                                        "4"="Sitting","5"="Standing","6"="Laying"))

## 3.3.2)
names(AccelerometerData) <- gsub("mean","Mean",names(AccelerometerData))
names(AccelerometerData) <- gsub("std","Std",names(AccelerometerData))
names(AccelerometerData) <- gsub("\\.","",names(AccelerometerData))

## 3.3.3)
write.table(file="../AccelerometerData.txt",AccelerometerData,row.name=FALSE)

## 3.4.1)
AccelerometerDataMean <- t(sapply(split(AccelerometerData[,4:67],as.list(AccelerometerData[,c(1:3)]),drop=TRUE),
                                  colMeans,na.rm=TRUE))

## 3.4.2)
AccelerometerDataMean <- as.data.frame(cbind(t(as.data.frame(strsplit(rownames(AccelerometerDataMean),split="\\.")))
                                            ,AccelerometerDataMean))
rownames(AccelerometerDataMean) <- NULL
colnames(AccelerometerDataMean)[1:3] <- c("activity","subject","set")

## 3.4.3)
write.table(file="../AccelerometerDataMean.txt",AccelerometerDataMean,row.name=FALSE)

## Script end
##################################################################################################################
