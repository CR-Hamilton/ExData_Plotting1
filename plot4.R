
library(lubridate)
#setwd("C:/Users/Carolyn Hamilton/Desktop/Coursera/ExploratoryAnalysis/Week1Project")

# reset plotting window, just in case
plot.new()

powerdata <- read_csv("powerdata.csv")
# create a single Date/Time vector out of Date column and Time column
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), 
                                 format = "%Y-%m-%d %H:%M:%S")

powerdata$Global_active_power <- powerdata$Global_active_power/1000
powerdata$Voltage <- powerdata$Voltage/1000
powerdata$Global_reactive_power <- powerdata$Global_reactive_power/1000

# gather the SubMeter_1,_2,_3 columns into a single variable called SubMeter
newdata <- powerdata %>% gather(key = "SubMeter", value = "watthours",
                                na.rm = TRUE, -c(Date:Global_intensity, DateTime))

newdata$watthours <- newdata$watthours/1000

# create categorical variable for multi-plotting
newdata <- transform(newdata, SubMeter = factor(SubMeter))
# create vector having names of factor levels to use in legend
legend_title <- levels(newdata$SubMeter)

png("plot4.png", width = 480, height = 480)
# initialize window to hold 4 plots, filling rows first
par(mfrow = c(2,2))
#1
plot(powerdata$DateTime, powerdata$Global_active_power, 
     xlab = "", ylab = "Global Active Power", typ = "l")
#2
plot(powerdata$DateTime, powerdata$Voltage, typ = "l",
     xlab = "datetime", ylab = "Voltage")
#3

# set up the blank window for holding the graphs
with(newdata, plot(DateTime, watthours,
                   xlab = "", ylab = "Energy sub metering", type = "n"))
# create a plot for each level of SubMeter
with(subset(newdata, SubMeter == "Sub_metering_1"), 
     lines(DateTime, watthours, col = "green" ))
with(subset(newdata, SubMeter == "Sub_metering_2"), 
     lines(DateTime, watthours, col = "red" ))
with(subset(newdata, SubMeter == "Sub_metering_3"), 
     lines(DateTime, watthours, col = "blue" ))


legend("topright",  col = c("green", "red", "blue"),
       legend = legend_title, lty = 1, cex =0.75,  
       bty = "n", inset = 0.1)

#4
with(powerdata, plot(DateTime, Global_reactive_power, typ = "l"))

dev.off()