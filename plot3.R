# Download dataset
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power.zip", method = "curl")

# unzip dataset
unzip("power.zip", exdir = ".")

# check file size
cat("File size (MB):", round(file.info("household_power_consumption.txt")$size/1024^2),"\n")

# read dataset
data = read.delim("household_power_consumption.txt", sep = ";")
data$datetime = strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date, "%d/%m/%Y")

# subset by Date
datasub = subset(data, Date == "2007-02-01" | Date == "2007-02-02")
datasub$Global_active_power = as.numeric(as.character(datasub$Global_active_power))
datasub$Sub_metering_1 = as.numeric(as.character(datasub$Sub_metering_1))
datasub$Sub_metering_2 = as.numeric(as.character(datasub$Sub_metering_2))

# plot data
plot(Sub_metering_1 ~ as.numeric(datasub$datetime), data = datasub, type = "l",
     ylab = "Energy sub metering", xlab = "", xaxt = "n", cex.lab = 0.7, cex.axis = 0.8)

lines(datasub$Sub_metering_2 ~ as.numeric(datasub$datetime), col = "red")

lines(datasub$Sub_metering_3 ~ as.numeric(datasub$datetime), col = "blue")

axis(1, at = c(min(as.numeric(datasub$datetime)), median(as.numeric(datasub$datetime)),
               max(as.numeric(datasub$datetime))),
     labels = c("Thu", "Fri", "Sat"), cex.axis = 0.8)
legend("topright", lty = 1, cex = 0.75, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# print png
dev.copy(png, file = "plot3.png")
dev.off()
