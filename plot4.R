#Set working directory.
#setwd("H:\\Data Science\\course4project1\\exdata-data-household_power_consumption")

#Read in power data from file.
powerdata <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        na.strings = "?")

#Construct POSIXlt dates for each row.
datetime <- strptime(paste(as.Date(powerdata[,1], format = "%d/%m/%Y"), powerdata[,2]),
                     format = "%Y-%m-%d %T")

#Bind dates to front of dataset.
powerdata <- cbind(dates, powerdata)

#Determine start and end of time window of interest.
startwindow <- min(which(powerdata[,1] >= "2007-02-01"))
endwindow <- max(which(powerdata[,1] < "2007-02-03"))

#Prune data frame to time window of interest.
powerdata <- powerdata[startwindow:endwindow,]

#Create png plot mosaic.
png("plot4.png")
par(mfcol = c(2, 2))

#Plot 1 (upper-left)
plot(powerdata[,1], powerdata[,4],
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "n")
lines(powerdata[,1], powerdata[,4])

#Plot 2 (lower-left)
plot(powerdata[,1], powerdata[,8],
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")
lines(powerdata[,1], powerdata[,8], col = "black")
lines(powerdata[,1], powerdata[,9], col = "red")
lines(powerdata[,1], powerdata[,10], col = "blue")
legend("topright",
       lwd = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

#Plot 3 (upper-right)
plot(powerdata[,1], powerdata[,6],
     xlab = "datetime",
     ylab = "Voltage",
     type = "n")
lines(powerdata[,1], powerdata[,6], col = "black")

#Plot 4 (lower-right)
plot(powerdata[,1], powerdata[,5],
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "n")
lines(powerdata[,1], powerdata[,5], col = "black")

dev.off()
