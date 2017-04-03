getwd()
setwd('C:\\Users/Jan Pascal Kunkler/git/R-Programming-Advanced/')

util <- read.csv('datasets/Machine-Utilization.csv')

head(util,12)
str(util)
summary(util)

util$Utilization <- 1 - util$Percent.Idle

summary(util)
