#get data
getdata = function(fileURL) {
        if(!file.exists("./data")){dir.create("./data")}
        
        fileURL = fileURL
        if(!file.exists("./data/dataset.zip")){
                download.file(fileURL, destfile = "./data/dataset.zip")
                unzip("./data/dataset.zip", exdir = "./data")
        }
}

fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

getdata(fileURL)

#load data
list.files("./data")
mydataoverview = read.table("./data/household_power_consumption.txt", nrows = 10, sep = ";", header = TRUE)
mydatadates = read.table("./data/household_power_consumption.txt", colClasses = c(NA, rep("NULL", 8)), 
                         sep = ";", header = TRUE)



start = min(which(mydatadates=="1/2/2007"))
end = max(which(mydatadates=="2/2/2007"))

end - start

mydata = read.table("./data/household_power_consumption.txt", skip = 66630, nrows = 2890, 
                    sep = ";", header = TRUE, stringsAsFactors = F)

names(mydata) = names(mydataoverview)

head(mydata, n=10)
tail(mydata, n=10)


mydata = subset(mydata, Date %in%  c("1/2/2007", "2/2/2007"))
unique(mydata$Date)

#date and time column
library(lubridate)
mydata$Date_Time = dmy(mydata$Date)+hms(mydata$Time)

#plotting
par(mfcol = c(2,2))
par(mar=c(2,4,2,2))

#first plot
plot(mydata$Date_Time, mydata$Global_active_power, type = "l", 
     ylab = "Global Active power", xlab="")

#second plot
plot(mydata$Date_Time, mydata$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab="")

lines(mydata$Date_Time, mydata$Sub_metering_2, col="red")
lines(mydata$Date_Time, mydata$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = "solid", col = c("black", "red", "blue"), cex = 0.75, bty = "n")

#third plot
plot(mydata$Date_Time, mydata$Voltage, type = "l", 
     ylab = "Voltage", xlab="datetime")

#last plot
plot(mydata$Date_Time, mydata$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab="datetime")


dev.copy(png, width = 480, height = 480, units = "px", file="plot4.png")
dev.off()
