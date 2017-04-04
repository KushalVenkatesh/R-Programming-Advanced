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

# Subset Machine RL1
RL1 <- util[util$Machine == "RL1",]
summary(RL1)

# To get rid of "ghost" factors, rerun factor() on Machine variable
RL1$Machine <- factor(RL1$Machine)

# Construct list:
# Character: Machine Name
# Vector: (min, mean, max) Utilization for the month (excluding unknown hours)
# Logical: Has Utilization ever fallen below 90%? TRUE/FALSE

util_stats_rl1 <- c(min(RL1$Utilization, na.rm = T), 
                    mean(RL1$Utilization, na.rm = T), 
                    max(RL1$Utilization, na.rm = T))
util_stats_rl1

util_under_90_flag <- length(which(RL1$Utilization < 0.9)) > 0
util_under_90_flag

# finally create the list
list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)

list_rl1

# Set names for list
names(list_rl1) <- c("Machine", "Stats", "LowThreshold")
list_rl1

# Check out mean of Stats
list_rl1$Stats[2]

# Another way. Like with dataframes.
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
list_rl1

# Add new item to list
list_rl1[4] <- "New Information"
list_rl1

# We will ad:
# Vector: All hours where utilization is unknown (NA)

list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]
list_rl1

# Remove a component
list_rl1[4] <- NULL

# Add another component:
# Dataframe: For this machine
list_rl1$Data <- RL1 

summary(list_rl1)

list_rl1$UnknownHours[1]

# Subsetting a list
list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine", "Stats")]
sublist_rl1
sublist_rl1$Stats[2] # Mean 

# Timeseries Plot
#install.packages("ggplot2")
library(ggplot2)

p <- ggplot(data=util)
myplot <- p + geom_line(aes(x=PosixTime, y=Utilization,
                  color=Machine), 
              size=1.1) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9, color="Gray",
             size=1.2,
             linetype=3)

# Add Plot to list
list_rl1$Plot <- myplot

# Let's look at our finisthed list
# This will be delivered to the client
list_rl1
