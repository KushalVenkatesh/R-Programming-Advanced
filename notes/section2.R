setwd("C:/Users/Jan Pascal Kunkler/git/R-Programming-Advanced/datasets/")
getwd()
# basic import: fin <- read.csv('Future-500.csv')
fin <- read.csv('Future-500.csv', na.strings = c(""))

# Take a first look at the data
head(fin)
str(fin)
summary(fin)

# convert columns to factor
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)

#Factor Variable Trap (FVT)

# As factor
fin$Profit <- factor(fin$Profit)

# As numeric
fin$Profit <- as.numeric(as.character(fin$Profit))

# sub() and gsub()
# used to replace characters, symbols etc in datasets
fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
fin$Expenses <- gsub(",", "", fin$Expenses)

fin$Revenue <- gsub("\\$", "", fin$Revenue)
fin$Revenue <- gsub(",", "", fin$Revenue)
head(fin)

fin$Growth <- gsub("%", "", fin$Growth)

str(fin) # <-- we see that we already have character variables
fin$Expenses <- as.numeric(fin$Expenses) 
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)

summary(fin) # <-- all 3 columns are recognized and analyzed as numeric. Success!

#----------------------- Deal with NA's

complete.cases(fin) # check for all rows which are complete <-- contain NO NA VALUES!

# subset with inversed logic
fin[!complete.cases(fin),]
