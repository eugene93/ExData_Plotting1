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

#Write to PNG file
png("plot1.png", width=480, height= 480)
hist(subdata$Global_active_power, col= "red", xlab= "Global Active Power (kilowatts)", ylab= "Frequency", main= "Global Active Power")
dev.off()

