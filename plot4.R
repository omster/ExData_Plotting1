library(data.table)
library(graphics)
library(grDevices)

options(warn=-1)

## read the text file into a data table and keep only the relevent records
dt <- fread("household_power_consumption.txt", header = T)
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
dt <- dt[dt$Date == "2007-02-01" | dt$Date == "2007-02-02"]
dt$datetime = as.POSIXct(paste(dt$Date, dt$Time, sep = " "), "EST")
dt$Global_active_power <- as.numeric(dt$Global_active_power)
dt$Voltage <- as.numeric(dt$Voltage)
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

## target png file as graphic device and set global parameters
png(filename = "plot4.png", width=480, height=480)
par(mar = c(5,5,2,2), mfrow = c(2,2), col = "#000000")

## output for chart 1,1 to png file
plot(dt$datetime, dt$Global_active_power, ylab = "Global Active Power", type = "line", xlab = "")
## output for chart 1,2 to png file
plot(dt$datetime, dt$Voltage, ylab = "Voltage", type = "line", xlab="datetime")
## output for chart 2,1 to png file
plot(dt$datetime, dt$Sub_metering_1, xlab = "", ylab = "Energy sub meeting", type="line")
lines(dt$datetime, dt$Sub_metering_2, col="#FF0000", type="line")
lines(dt$datetime, dt$Sub_metering_3, col="#0000FF", type="line")
legend("topright", lwd=1, bty="n", col = c("#000000","#FF0000","#0000FF"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## output for chart 2,2 to png file - then flush & close
plot(dt$datetime, dt$Global_reactive_power, type = "line", xlab="datetime", ylab="Global_reactive_power")
dev.off()