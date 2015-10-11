library(data.table)
library(graphics)

options(warn=-1)

## read the text file into a data table and keep only the relevent records
dt <- fread("household_power_consumption.txt", header = T)
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
dt <- dt[dt$Date == "2007-02-01" | dt$Date == "2007-02-02"]
dt$datetime = as.POSIXct(paste(dt$Date, dt$Time, sep = " "), "EST")
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

## target png file as graphic device and set global parameters
png(filename = "plot3.png", width=480, height=480)
par(mar = c(5,5,2,2), oma = c(0,0,2,0), mfrow = c(1,1), col = "#000000")

## output to png file and flush/close the graphic device
plot(dt$datetime, dt$Sub_metering_1, xlab = "", ylab = "Energy sub meeting", type="line")
lines(dt$datetime, dt$Sub_metering_2, col="#FF0000", type="line")
lines(dt$datetime, dt$Sub_metering_3, col="#0000FF", type="line")
legend("topright", lwd=1, col = c("#000000","#FF0000","#0000FF"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()