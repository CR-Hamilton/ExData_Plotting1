plot.new()
powerdata <- read.csv("powerdata.csv")
# create a single Date/Time vector out of Date column and Time column
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), 
                        format = "%Y-%m-%d %H:%M:%S")
# gather the SubMeter_1,_2,_3 columns into a single variable called SubMeter
newdata <- powerdata %>% gather(key = "SubMeter", value = "watthours",
                                na.rm = TRUE, -c(Date:Global_intensity, DateTime))
# create categorical variable for multi-plotting
newdata <- transform(newdata, SubMeter = factor(SubMeter))

# create vector having names of factor levels to use in legend
legend_title <- levels(newdata$SubMeter)

# rescale $watthours to kilowatts by dividing by 1000
newdata$watthours <- newdata$watthours/1000

png(filename = "plot3.png", width = 480, height = 480)
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
          legend = legend_title, lty = 1, cex = 0.75,  inset = 0.08, bty = "n")

dev.off()
