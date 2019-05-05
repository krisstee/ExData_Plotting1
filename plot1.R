# Author: Kristijana A.
# Exploratory Data Analysis Course Project 1

library(dplyr)

setwd("ExData_Plotting1")
data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download dataset
download.file(data_url, "electric_power.zip", method="curl")
unzip("electric_power.zip")
data_file = "household_power_consumption.txt"
energy_data <- read.table(data_file, header = TRUE, sep = ";")
#subset the data
energy_set <- subset(energy_data, Date == "1/2/2007" | Date == "2/2/2007")

#plot the histogram of Global Active Power
# convert Global_active_power to numer
energy_set$Global_active_power <- as.numeric(as.character(
                                  energy_set$Global_active_power))
# use png device
png("plot1.png", width = 480, height = 480)
with(energy_set, hist(Global_active_power, main="Global Active Power",
                      xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
