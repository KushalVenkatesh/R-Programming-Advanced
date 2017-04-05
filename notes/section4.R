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

# use lapply() to apply function to a list (or vector)
lapply(Weather, t) # transpose every single matrix in our list

#example 2
rbind(Chicago, NewRow=1:12) # Add a new row
lapply(Weather, rbind, NewRow=1:12)

#example 3
?rowMeans

lapply(Weather, rowMeans)
                      # <<< (nearly) deliv 1: even better, but will improve further!


 
