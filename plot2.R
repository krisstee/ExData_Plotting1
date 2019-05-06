# Author: Kristijana A.
# Exploratory Data Analysis Course Project 1
# Plot 2

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
# create a column to hold date and time
energy_set <- energy_set %>% mutate(dateTime = as.POSIXct(dmy_hms(paste(Date,Time))))

#activate png device
png("plot2.png", width=480, height=480)
with(energy_set, plot(dateTime, Global_active_power, type = "l", xlab = "",
                      ylab = "Global Active Power (kilowatts)"))
dev.off()
