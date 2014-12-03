#Clear Workspace
rm(list=ls())
# Clear Console:
cat("\014")

# Data description:
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.



setwd("C:/Users/werner/Dropbox/Programming/Coursera/DataScience_JH_specialization/4_Exploratory_Data_Analysis/Project1")
fileurl <- "data/household_power_consumption.txt"
raw_data <- read.csv(fileurl, header = TRUE, sep = ";", stringsAsFactors = FALSE)
raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y") # capital Y for 4 digit year
raw_data$Global_active_power <- as.numeric(raw_data$Global_active_power)
raw_data$Global_reactive_power <- as.numeric(raw_data$Global_reactive_power)
raw_data$Voltage <- as.numeric(raw_data$Voltage)
raw_data$Global_intensity <- as.numeric(raw_data$Global_intensity)
raw_data$Sub_metering_1 <- as.numeric(raw_data$Sub_metering_1)
raw_data$Sub_metering_2 <- as.numeric(raw_data$Sub_metering_2)

head(raw_data)
tail(raw_data)
str(raw_data)
summary(raw_data)


# Need only data from these dates inclusive: 2007-02-01 and 2007-02-02
sub_data <- subset(raw_data, raw_data$Date >= "2007-02-01" & raw_data$Date <= "2007-02-02")

# send plot to the png device...comment this out to view on screen
png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(sub_data$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# comment this out to view on screen
dev.off()