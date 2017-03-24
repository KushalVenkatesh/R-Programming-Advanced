setwd("C:/Users/Jan Pascal Kunkler/git/R-Programming-Advanced/datasets/")
getwd()
fin <- read.csv('Future-500.csv')

# Take a first look at the data
head(fin)
str(fin)
summary(fin)

# convert columns to factor
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)

#Factor Variable Trap (FVT)
