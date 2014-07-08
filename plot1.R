# Download dataset
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power.zip", method = "curl")

# unzip dataset
unzip("power.zip", exdir = ".")

# check file size
cat("File size (MB):", round(file.info("household_power_consumption.txt")$size/1024^2),"\n")

# read dataset
data = read.delim("household_power_consumption.txt", sep = ";")
data$Date = as.Date(data$Date, "%d/%m/%Y")

# subset by Date
datasub = subset(data, Date == "2007-02-01" | Date == "2007-02-02")
datasub$Global_active_power = as.numeric(as.character(datasub$Global_active_power))

# plot 1 - red histogram of "Global Active Power"
hist(datasub$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# create png file
dev.copy(png, file = "plot1.png")
dev.off()
