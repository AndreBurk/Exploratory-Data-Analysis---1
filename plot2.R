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

# plot data
plot(Global_active_power ~ as.numeric(datasub$datetime), data = datasub, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
axis(1, at = c(min(as.numeric(datasub$datetime)), median(as.numeric(datasub$datetime)),
               max(as.numeric(datasub$datetime))),
     labels = c("Thu", "Fri", "Sat"))

# print png
dev.copy(png, file = "plot2.png")
dev.off()
