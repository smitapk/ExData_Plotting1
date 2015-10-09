## Download Data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  exdata <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",exdata)
  file <- unzip(exdata)
  unlink(exdata)
}

## Full dataset
path <- getwd()
path <- paste(path,"/household_power_consumption.txt",sep="")
full_data <- read.table(path, header=T, sep=";")

## Set Date format
full_data$Date <- as.Date(full_data$Date, format="%d/%m/%Y")

## Filter Data between  "2007-02-01" and "2007-02-02"
plot_data <- subset(full_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove full_data to save space
rm(full_data)

## Converting datatypes from character to datetime
plot_data$Datetime <- as.POSIXct(paste(as.Date(plot_data$Date), plot_data$Time))

## Converting datatypes from character to numeric
plot_data$Global_active_power <- as.numeric(as.character(plot_data$Global_active_power))
plot_data$Global_reactive_power <- as.numeric(as.character(plot_data$Global_reactive_power))
plot_data$Voltage <- as.numeric(as.character(plot_data$Voltage))

## Create Plot 1
hist(plot_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save plot to a file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
