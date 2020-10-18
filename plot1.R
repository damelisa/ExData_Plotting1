# Load libraries
library(chron)

# Read table and subset
hpc <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
data <- subset(hpc, Date %in% c("1/2/2007","2/2/2007"))

# Format time and date columns and convert values into numeric
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- chron(times. = data$Time)
data[,3:9] <- sapply(data[,3:9],as.numeric)

# Write plot into png graphic device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Plot graph
hist(data$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close graphic device
dev.off()