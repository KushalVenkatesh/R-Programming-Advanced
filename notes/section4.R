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

