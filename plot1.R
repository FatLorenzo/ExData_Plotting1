# 
# Exploratory Data Analysis - Course Project 1
# 
# Script: plot1.R
# Author: Lars Hermes
#

# setting class names for faster import
classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
# import data with defined column classes and treating '?' as NA
data <- read.table("./household_power_consumption.txt", sep=";",header=TRUE, colClasses = classes, na.strings = c("?"))
# create filter for the valid time frame 
filter <- (as.Date(data$Date,format="%d/%m/%Y") >= as.Date("2007-02-01","%Y-%m-%d")) & (as.Date(data$Date,format="%d/%m/%Y") <= as.Date("2007-02-02","%Y-%m-%d"))
# filter valid data
data <- data[filter,]
# add new column with datatime objects
data$DateTime = strptime(paste(data$Date,data$Time," "),format = "%d/%m/%Y %H:%M:%S")
# drop colum Date and Time
data$Date <- NULL
data$Time <- NULL
# create histogram
hist(data$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
# copy plot to png file (default size for png is 480 x 480 px, so no explicit size have to be set)
dev.copy(png,"plot1.png")
dev.off()
