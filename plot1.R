library(data.table)
library(graphics)

options(warn=-1)

## read the text file into a data table and keep only the relevent records
dt <- fread("household_power_consumption.txt", header = T)
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
dt <- dt[dt$Date == "2007-02-01" | dt$Date == "2007-02-02"]
dt$datetime = as.POSIXct(paste(dt$Date, dt$Time, sep = " "), "EST")
dt$Global_active_power <- as.numeric(dt$Global_active_power)

## target png file as graphic device and set global parameters
png(filename = "plot1.png", width=480, height=480)
par(mar = c(5,5,2,2), mfrow = c(1,1))

## output to png file and flush/close the graphic device
hist(dt$Global_active_power, col = "#ff0000", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()