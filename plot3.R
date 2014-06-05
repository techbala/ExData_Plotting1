

plotMe <- function( workingDirectory ){
				setwd(workingDirectory)
				data <- read.table( "household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", stringsAsFactors=FALSE)
				tidy <- data[( as.Date( data$Date, "%d/%m/%Y") == "2007-02-01" |  as.Date( data$Date, "%d/%m/%Y") == "2007-02-02"),]
				tidy$dt <- paste(tidy$Date, tidy$Time)
				library(reshape2)
				melted <- melt( tidy, id=c("dt" ), measure.var=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
				melted$date <- strptime( melted$dt, "%d/%m/%Y %H:%M:%S")
				
				with(melted, plot( date, value, type="n", xlab="", ylab="Energy sub metering"))
				with(subset( melted, variable=="Sub_metering_1"), lines(date, value, type="S"))
				with(subset( melted, variable=="Sub_metering_2"), lines(date, value, type="S", col="red"))
				with(subset( melted, variable=="Sub_metering_3"), lines(date, value, type="S", col="blue"))
				legend("topright", col=c("black", "red", "blue"), pch="-", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
				
				dev.copy( png, "plot3.png", width=760, height=760)
				dev.off()
}