dest1<-"household_power_consumption.txt"

#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

datafile <- read.csv(dest1, header=T,nrow=95800, sep=';', stringsAsFactors = F, na.strings="?")
#tail(datafile)
# Change Date format
datafile$Date <- as.Date(datafile$Date, format="%d/%m/%Y")

#Subset data
subdata <- subset(datafile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
# Free memory
rm(datafile)

# combine data and time as POSIX format to create a new field "DateTime"
subdata$DateTime<- as.POSIXct(paste(subdata$Date, subdata$Time))
#View(subdata)
#Write to PNG file | Note that due to PC setting, the Weedday output is automatically set Korean (목=Thursday, 금=Friday, 토=Saturday)
png("plot3.png", width=480, height= 480)
plot(subdata$DateTime,subdata$Sub_metering_1,type= "l", lwd=1, xlab="", ylab= "Energy sub metering")
lines(subdata$DateTime,subdata$Sub_metering_2,type= "l", lwd=1,col="red")
lines(subdata$DateTime,subdata$Sub_metering_3,type= "l", lwd=1,col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
rm(subdata)

