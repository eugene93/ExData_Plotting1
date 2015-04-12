dest1<-"household_power_consumption.txt"

#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

datafile <- read.csv(dest1, header=T,nrow=95800, sep=';', stringsAsFactors = F, na.strings="?")

# Change Date format
datafile$Date <- as.Date(datafile$Date, format="%d/%m/%Y")

#Subset data
subdata <- subset(datafile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
# Free memory
rm(datafile)

# combine data and time as POSIX format to create a new field "DateTime"
subdata$DateTime<- as.POSIXct(paste(subdata$Date, subdata$Time))
#Write to PNG file | Note that due to PC setting, the Weedday output is automatically set Korean (목=Thursday, 금=Friday, 토=Saturday)


png("plot4.png", width=480, height= 480)

# Set 2x2 plot 
par(mfrow=c(2,2)) 

#upper left #same as Plot 2
plot(subdata$DateTime,subdata$Global_active_power,type= "l", lwd=1, xlab="",  ylab= "Global Active Power (kilowatts)")

#upper right
plot(subdata$DateTime,subdata$Voltage,type= "l", lwd=1, xlab="datetime",  ylab= "Voltage")

#bottom left  #same as Plot 3
plot(subdata$DateTime,subdata$Sub_metering_1,type= "l", lwd=1, xlab="", ylab= "Energy sub metering")
lines(subdata$DateTime,subdata$Sub_metering_2,type= "l", lwd=1,col="red")
lines(subdata$DateTime,subdata$Sub_metering_3,type= "l", lwd=1,col="blue")
legend("topright", col=c("black", "red", "blue"), bty="n",cex=0.5, pt.cex = 1, lty=1, lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#bottom right
plot(subdata$DateTime,subdata$Global_reactive_power,type= "l", lwd=1, xlab="datetime", ylab= "Global_reactive_power")


dev.off()
rm(subdata)

