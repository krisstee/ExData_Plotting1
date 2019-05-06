# Author: Kristijana A.
# Exploratory Data Analysis Course Project 1
# Plot 4

library(lubridate)
library(dplyr)

setwd("ExData_Plotting1")
data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download dataset
download.file(data_url, "electric_power.zip", method="curl")
unzip("electric_power.zip")
data_file = "household_power_consumption.txt"
energy_data <- read.table(data_file, header = TRUE, sep = ";",
                          stringsAsFactors = FALSE, na.strings = "?")
#subset the data
energy_set <- subset(energy_data, Date == "1/2/2007" | Date == "2/2/2007")

# convert Global_active_power to numeric
energy_set$Global_active_power <- as.numeric(as.character(
                                              energy_set$Global_active_power))
# convert submetering column values to numeric
energy_set$Sub_metering_1 <- as.numeric(as.character(
                                        energy_set$Sub_metering_1))
energy_set$Sub_metering_2 <- as.numeric(as.character(
                                        energy_set$Sub_metering_2))
energy_set$Sub_metering_3 <- as.numeric(as.character(
                                        energy_set$Sub_metering_3))
#convert Voltage column values to numeric
energy_set$Voltage <- as.numeric(as.character(energy_set$Voltage))
#convert Global_reactive_power column values to numeric
energy_set$Global_reactive_power <- as.numeric(as.character(
                                              energy_set$Global_reactive_power))
# create a column to hold date and time
energy_set <- energy_set %>% mutate(dateTime = as.POSIXct(dmy_hms(paste(Date,Time))))

# activate png device
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# recreate plot from plot2
with(energy_set, plot(dateTime, Global_active_power, type = "l", xlab = "",
                      ylab = "Global Active Power"))

# create plot against voltage and time
with(energy_set, plot(dateTime, Voltage, type = "l", xlab = "datetime",
                      ylab = "Voltage"))

# recreate plot from plot3
with(energy_set, plot(dateTime, Sub_metering_1, type="n", xlab="",
                      ylab="Energy sub metering"))
with(energy_set, points(dateTime, Sub_metering_1, type="l", col="black"))
with(energy_set, points(dateTime, Sub_metering_2, type="l", col="red"))
with(energy_set, points(dateTime, Sub_metering_3, type="l", col="blue"))
with(energy_set, legend("topright", lty=1, col = c("black", "red", "blue"),
                        legend=c("Sub_metering_1", "Sub_metering_2",
                                 "Sub_metering_3"),
                        bty="n"))

# create plot against Global_reactive_power and time
with(energy_set, plot(dateTime, Global_reactive_power, type = "l",
                      col = "black", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
