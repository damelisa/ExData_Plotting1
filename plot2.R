# Load libraries
library(chron)

# Read table and subset
hpc <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
data <- subset(hpc, Date %in% c("1/2/2007","2/2/2007"))

# Format time and date columns, generate new timepoint column and convert values into numeric
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- chron(times. = data$Time)
data$timepoint <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
data[,3:9] <- sapply(data[,3:9],as.numeric)

# Set weekdays from german to english
Sys.setlocale("LC_TIME", "C")
format(Sys.Date(), "%Y-%b-%d")

# Plot graph
with(data, plot(Global_active_power ~ timepoint, type = "l", ann = FALSE, lwd = 1))
title(ylab = "Global Active Power (kilowatts)")

# Write plot into png graphic device
dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
