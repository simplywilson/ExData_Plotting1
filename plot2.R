# Read the data
rawData <- read.table("household_power_consumption.txt", as.is =  TRUE, header = TRUE, sep = ";", na.strings = "?")

# Convert Date and Time columns into DateTime and add to raw data
rawData$DateTime <- strptime(with(rawData, paste(Date, Time, sep = " ")), "%d/%m/%Y %T")

# Filter out all rows for those two days and place into Data Table
library(data.table)
dataTable <- data.table(na.omit(subset(rawData, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))))

# Plot the graph and save as png file format
png(filename="plot2.png", width=480, height=480, units="px", bg = "transparent")
with(dataTable, plot(y = Global_active_power, x = DateTime, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))
dev.off()
