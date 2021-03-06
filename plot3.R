setwd('~/R_projects/jhuds/c4p1')

# Function used to convert date field from character to Date    
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

# Specify data types 
colClasses <- c(Date='myDate',Time='character',Global_active_power='numeric',Global_reactive_power='numeric',Voltage='numeric',Global_intensity='numeric',Sub_metering_1='numeric',Sub_metering_2='numeric',Sub_metering_3='numeric')

# Read in data from file
epc <- read.table('household_power_consumption.txt',na.strings="?",colClasses=colClasses,sep=';',header=TRUE)

# Extract data from required dates
epcg <- subset(epc, Date >= '2007-02-01' & Date <= '2007-02-02')

# Create datetime object
epcg$DateTime <- as.POSIXct(paste(epcg$Date, epcg$Time)) 

# Create plot as PNG using Cairo 
png(file = "plot3.png",type='cairo-png')
plot(epcg$DateTime, epcg$Sub_metering_1,type='l', ylab='Global Active Power (kilowatts)',xlab='',col='black')
lines(epcg$DateTime, epcg$Sub_metering_2, type='l',col='red')
lines(epcg$DateTime, epcg$Sub_metering_3, type='l',col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty=rep(1,3), col=c('black','red','blue'))
dev.off()
