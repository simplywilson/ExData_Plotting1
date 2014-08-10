# Read the data
rawData <- read.table("household_power_consumption.txt", as.is =  TRUE, header = TRUE, sep = ";", na.strings = "?")

# Convert Date and Time columns into DateTime and add to raw data
rawData$DateTime <- strptime(with(rawData, paste(Date, Time, sep = " ")), "%d/%m/%Y %T")

# Filter out all rows for those two days and place into Data Table
library(data.table)
dataTable <- data.table(na.omit(subset(rawData, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))))

# Create PNG file
png(filename="plot4.png", width=480, height=480, units="px", bg = "transparent")

# Create a matrix of 2 x 2 plots
par(mfcol=c(2,2))

# Plot time series for Global Active Power
with(dataTable, plot(y = Global_active_power, x = DateTime, ylab = "Global Active Power", xlab = "", type = "l"))

# Plot time series for Energy sub metering
with(dataTable, plot(y = Sub_metering_1, x = DateTime, ylab = "Energy sub metering", xlab = "", type = "l"))
with(dataTable, lines(y = Sub_metering_2, x = DateTime, col = "red"))
with(dataTable, lines(y = Sub_metering_3, x = DateTime, col = "blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1, 1), col=c("black", "red", "blue"), bty = "n")

# Plot time series for Voltage
with(dataTable, plot(y = Voltage, x = DateTime, ylab = "Voltage", xlab = "datetime", type = "l"))

# Plot time series for Global reactive power
with(dataTable, plot(y = Global_reactive_power, x = DateTime, ylab = "Global_reactive_power", xlab = "datetime", type = "l"))

# Close PNG file
dev.off()