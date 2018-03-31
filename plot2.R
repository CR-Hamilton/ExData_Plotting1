
library(lubridate)

# reset plotting window, just in case
plot.new()

powerdata <- read.csv("powerdata.csv")

DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), 
                       format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)
plot(DateTime, powerdata$Global_active_power/1000, type = "l",
     xlab ="", ylab = "Global Active Power (kilowatts)")
dev.off()
