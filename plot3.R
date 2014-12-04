# plot3.R
# Coursera Course - Exploratory Data Analysis (exdata-016)
# Project 1
# Submitted by:
# Werner Colangelo
# wernercolangelo@gmail.com

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

#Clear Workspace
rm(list=ls())
# Clear Console:
cat("\014")

setwd("C:/Users/werner/Dropbox/Programming/Coursera/DataScience_JH_specialization/4_Exploratory_Data_Analysis/Project1")
fileurl <- "data/household_power_consumption.txt"

# the script checks to see if a file exists in a subfolder called "data" off of the current working directory,
# otherwise it will download the zip file and unzip it into a temp folder
if (file.exists(fileurl))
{
  raw_data <- read.csv(fileurl, header = TRUE, sep = ";", stringsAsFactors = FALSE)
} else {
  # remote file url
  remotefileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  # create a temporary directory
  td = tempdir()
  # create the placeholder file
  tf = tempfile(tmpdir=td, fileext=".zip")
  # download into the placeholder file
  download.file(remotefileurl, tf)
  # The data has now been downloaded to a temporary file, and the full path is contained in tf.
  # The unzip() function can be used to query the contents
  # In this case, the zip file will always contain a single file in CSV format.
  
  # get the name of the first file in the zip archive
  fname = unzip(tf, list=TRUE)$Name[1]
  # unzip the file to the temporary directory
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  # fileurl is the full path to the extracted file
  fileurl = file.path(td, fname)
  raw_data <- read.csv(fileurl, header = TRUE, sep = ";", stringsAsFactors = FALSE)
}

# time to massage the data
raw_data$DateTime <- paste(raw_data$Date, raw_data$Time) # combine dates and times
raw_data$DateTime <- strptime(raw_data$DateTime, "%d/%m/%Y %H:%M:%S") # convert to date and time type, capital Y for 4 digit year
raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y") # capital Y for 4 digit year
raw_data$Global_active_power <- as.numeric(raw_data$Global_active_power)
raw_data$Global_reactive_power <- as.numeric(raw_data$Global_reactive_power)
raw_data$Voltage <- as.numeric(raw_data$Voltage)
raw_data$Global_intensity <- as.numeric(raw_data$Global_intensity)
raw_data$Sub_metering_1 <- as.numeric(raw_data$Sub_metering_1)
raw_data$Sub_metering_2 <- as.numeric(raw_data$Sub_metering_2)

# head(raw_data)
# tail(raw_data)
# str(raw_data)
# summary(raw_data)

# Need only data from these dates inclusive: 2007-02-01 and 2007-02-02
sub_data <- subset(raw_data, raw_data$Date >= "2007-02-01" & raw_data$Date <= "2007-02-02")

# send plot to the png device...comment this out to view on screen
png(filename = "plot3.png", width = 480, height = 480, units = "px")

with(sub_data, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(sub_data, points(DateTime, Sub_metering_1, col = "black", type = "l"))
with(sub_data, points(DateTime, Sub_metering_2, col = "red", type = "l"))
with(sub_data, points(DateTime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# comment this out to view on screen
dev.off()