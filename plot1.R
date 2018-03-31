
library(lubridate)
# setwd("C:/Users/Carolyn Hamilton/Desktop/Coursera/ExploratoryAnalysis/Week1Project")

powerdata <- read.csv("powerdata.csv")

png(filename = "plot1.png", width = 480, height = 480)

hist(powerdata$Global_active_power/1000, 
     main = "Global Active Power", col = "blue", 
     xlab = "Global Active Power (kilowatts)"
     )

dev.off()
