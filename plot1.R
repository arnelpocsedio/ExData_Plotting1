#This code creates plot1.png which is similar to the first plot 
#in the Coursera assignment (Week 1 of Exploratory Data Analysis)

#1. Get data
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

#2. Load data
list.files("./data")
mydataoverview = read.table("./data/household_power_consumption.txt", nrows = 10, sep = ";", header = TRUE)
head(mydataoverview) #look at a small part of the data

#load the dates
mydatadates = read.table("./data/household_power_consumption.txt", colClasses = c(NA, rep("NULL", 8)), 
                         sep = ";", header = TRUE)

#subset the relevant dates only
start = min(which(mydatadates=="1/2/2007"))
end = max(which(mydatadates=="2/2/2007"))

#range of the relevant rows.
start
end
end - start

#read the data including relevant rows only
#adding extra rows both in start and end to make sure to capture the relevant dates
mydata = read.table("./data/household_power_consumption.txt", skip = 66630, nrows = 2890, 
                    sep = ";", header = TRUE, stringsAsFactors = F)

#adding column labels
names(mydata) = names(mydataoverview)

head(mydata, n=10)
tail(mydata, n=10)

#final subsetting of the relevant dates
mydata = subset(mydata, Date %in%  c("1/2/2007", "2/2/2007"))
unique(mydata$Date)

#3. plotting
hist(mydata$Global_active_power, main = "Global Active Power", xlab = "Global Active power (kilowatts)",
     col = "red")

dev.copy(png, width = 480, height = 480, units = "px", file="plot1.png")
dev.off()
