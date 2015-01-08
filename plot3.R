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

#Create png plot.
png("plot3.png")
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
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
