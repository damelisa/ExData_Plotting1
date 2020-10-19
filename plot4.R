# Load libraries
library(chron)

# Read table and subset
hpc <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
data <- subset(hpc, Date %in% c("1/2/2007","2/2/2007"))

# Format time and date columns, generate new timepoint column and convert values into numeric
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- chron(times. = data$Time)
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
data[,3:9] <- sapply(data[,3:9],as.numeric)

# Set weekdays from german to english
Sys.setlocale("LC_TIME", "C")
format(Sys.Date(), "%Y-%b-%d")

# Write plot into png graphic device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Set environment of plots
par(mfrow = c(2,2))

# Plot graph 1
with(data, plot(Global_active_power ~ datetime, type = "l", ann = FALSE, lwd = 1))
title(ylab = "Global Active Power")

# Plot graph 2
with(data, plot(Voltage ~ datetime, type = "l", lwd = 1))
title(ylab = "Voltage")

# Plot graph 3
with(data, plot(Sub_metering_1 ~ datetime, type = "n", ann = FALSE))
with(data, points(Sub_metering_1 ~ datetime, type = "l"))
with(data, points(Sub_metering_2 ~ datetime, type = "l", col = "red"))
with(data, points(Sub_metering_3 ~ datetime, type = "l", col = "blue"))
title(ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Plot graph 4
with(data, plot(Global_reactive_power ~ datetime, type = "l", lwd = 1))

# Close graphic device
dev.off()