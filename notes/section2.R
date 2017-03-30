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

# Create backup
fin_backup <- fin


fin <- fin[!is.na(fin$Industry),]

# Reset index
rownames(fin) <- NULL

# Check missing states
fin[is.na(fin$State),]

# Set State for New York City
fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY"

# Set state for San Francisco
fin[is.na(fin$State) & fin$City == "San Francisco", "State"] <- "CA"

# Check for missing Employees Values
fin[is.na(fin$Employees),]

#------------------- MEDIAN IMPUTATION METHOD
# Check overall median
median(fin$Employees, na.rm = T)

# Check mean for comparison
mean(fin$Employees, na.rm = T)

# Calculate Retail Industry Employees median
med_ret_emp <- median(fin[fin$Industry == "Retail", "Employees"], na.rm = T)
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_ret_emp

# Calculate Financial Services Employees median
med_finserv_emp <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = T)
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_finserv_emp

fin[!complete.cases(fin),]

# ------------------------ CONSTRUCTION INDUSTRY

# imputate revenue values for Construction industry
med_con_rev <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = T)
fin[is.na(fin$Revenue) & fin$Industry == "Construction" & is.na(fin$Profit), "Revenue"] <- med_con_rev

# imputate revenue values for Construction industry
med_con_rev <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = T)
fin[is.na(fin$Revenue) & fin$Industry == "Construction" & is.na(fin$Profit), "Revenue"] <- med_con_rev

# imputate profit values for Construction industry
med_con_prof <- median(fin[fin$Industry == "Construction", "Profit"], na.rm = T)
fin[is.na(fin$Profit) & fin$Industry == "Construction" & is.na(fin$Expenses), "Profit"] <- med_con_prof

# Calculate Expenses as Revenue - Profit
fin[fin$Industry == "Construction" & is.na(fin$Expenses), "Expenses"] <- fin[fin$Industry == "Construction" & is.na(fin$Expenses), "Revenue"] - fin[fin$Industry == "Construction" & is.na(fin$Expenses), "Profit"]

# Imputate Growth for Construction Industry
fin[is.na(fin$Growth),"Growth"] <- median(fin[fin$Industry == "Construction","Growth"], na.rm = T)

# Check if any missing data is left
fin[!complete.cases(fin),]

# Only one case left to be calculated. Let's do it.
fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]

#--------------------------- VISUALIZATION
# Now that our data is cleaned up, we are ready to visualize it as requested!

