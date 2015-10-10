# 
# Exploratory Data Analysis - Course Project 1
# 
# Script: plot4.R
# Author: Lars Hermes
#

# As I'm working on an German environment I've to change the time settings
Sys.setlocale(category = "LC_TIME", locale = "en_US")
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
# create plot

# general settings
par(mfrow = c(2,2))

# 1st plot
plot(data$DateTime,data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab = "")

# 2nd plot
plot(data$DateTime,data$Voltage,type="l",ylab="Voltage",xlab="datetime")

# 3rd plot
plot(data$DateTime,data$Sub_metering_1,type="n",ylab="Energy sub metering", xlab = "")
lines(data$DateTime,data$Sub_metering_1)
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
# adding legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n",cex=0.5)
# 4th plot
plot(data$DateTime,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

# copy plot to png file (default size for png is 480 x 480 px, so no explicit size have to be set)
dev.copy(png,"plot4.png")
dev.off()
