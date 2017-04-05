getwd()
setwd('C:\\Users/Jan Pascal Kunkler/git/R-Programming-Advanced/datasets/')

Chicago <- read.csv('Weather Data/Chicago-F.csv',row.names = 1)
Houston <- read.csv('Weather Data/Houston-F.csv', row.names = 1)
SanFrancisco <- read.csv('Weather Data/SanFrancisco-F.csv', row.names = 1)
NewYork <- read.csv('Weather Data/NewYork-F.csv', row.names = 1)

#Check:
Chicago
NewYork
Houston
SanFrancisco

# these are dataframes:
is.data.frame(Chicago)
#let's convert to matrices
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)
# check
is.matrix(Chicago)

#let's put all of these into a list
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco=SanFrancisco)
Weather

Weather$NewYork
Weather[[2]]

# using apply()
apply(Chicago, 1, mean)
# check if correct:
mean(Chicago["DaysWithPrecip",])

# analyze one city:
Chicago
apply(Chicago, 1, min)
apply(Chicago, 1, max)


# compare averages
apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFrancisco, 1, mean)
                      # <<< (nearly) deliv 1: but there is a faster way!

#--------------------- lapply()

# use lapply() to apply function to a list (or vector)
lapply(Weather, t) # transpose every single matrix in our list

#example 2
rbind(Chicago, NewRow=1:12) # Add a new row
lapply(Weather, rbind, NewRow=1:12)

#example 3
?rowMeans

lapply(Weather, rowMeans)
                      # <<< (nearly) deliv 1: even better, but will improve further!

# combining lapply() with [] operator
Weather[[1]][1,1]
 
lapply(Weather, "[", 1,1) # get first row first column for all items in Weather list

# get first row for every item 
lapply(Weather, "[", 1,)

# get every metric just for march
lapply(Weather, "[", ,"Mar")
lapply(Weather, "[", , 3) # all rows but only column 3("March")



# adding our own functions

lapply(Weather, function(x) x[1,]) # same as above, select first row for every item in list

lapply(Weather, function(x) round((x[1,] - x[2,]) / x[2,], 2))
                            # <<< Deliv2: temp fluctuations. Will improve!


#---------------------- sapply()
# Simplified version of lapply()

# AvgHigh_F for July
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)

# AvgHigh_F for 4th Quarter
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)

# Row Averages for all cities
round(sapply(Weather, rowMeans),2)
                        #<<<Deliv1!

# Temperature fluctuations
t(sapply(Weather, function(x) round((x[1,] - x[2,]) / x[2,], 2)))
                        #<<< Deliv2: Temp fluctuations.


# Nesting apply functions

Chicago
apply(Chicago, 1, max)

# Get row maximum for each item in Weather list
# Using own functions (LONG)
sapply(Weather, function(x) apply(x, 1, max))
sapply(Weather, function(x) apply(x, 1, min))

# SHORT VERSION: using optional parameters
sapply(Weather, apply, 1, max) #<< Deliv 3
sapply(Weather, apply, 1, min) #<< Deliv 4

