# Read the data
rawData <- read.table("household_power_consumption.txt", as.is =  TRUE, header = TRUE, sep = ";", na.strings = "?")

# Convert Date and Time columns into DateTime and add to raw data
rawData$DateTime <- strptime(with(rawData, paste(Date, Time, sep = " ")), "%d/%m/%Y %T")

# Filter out all rows for those two days and place into Data Table
library(data.table)
dataTable <- data.table(na.omit(subset(rawData, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))))

# Plot the graph, add lines, add legend, and save as png file format
png(filename="plot3.png", width=480, height=480, units="px", bg = "transparent")
with(dataTable, plot(y = Sub_metering_1, x = DateTime, ylab = "Energy sub metering", xlab = "", type = "l"))
with(dataTable, lines(y = Sub_metering_2, x = DateTime, col = "red"))
with(dataTable, lines(y = Sub_metering_3, x = DateTime, col = "blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1, 1), col=c("black", "red", "blue"))
dev.off()
