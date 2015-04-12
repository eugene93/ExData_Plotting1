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

#Write to PNG file | Note that due to PC setting, the Weedday output is automatically set Korean (목=Thursday, 금=Friday, 토=Saturday)
png("plot2.png", width=480, height= 480)
plot(subdata$DateTime,subdata$Global_active_power,type= "l", lwd=1, xlab="", ylab= "Global Active Power (kilowatts)")
dev.off()

