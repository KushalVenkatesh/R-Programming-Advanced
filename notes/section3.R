getwd()
setwd('C:\\Users/Jan Pascal Kunkler/git/R-Programming-Advanced/')

util <- read.csv('datasets/Machine-Utilization.csv')

head(util,12)
str(util)
summary(util)

# Derive Utilization column
util$Utilization <- 1 - util$Percent.Idle
summary(util)

# Handling date-times in R
# POSIX = Portable Operating System Interface
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
util$Timestamp <- NULL

# rearrange columns
util <- util[,c(4,1,2,3)]
