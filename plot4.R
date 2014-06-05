plotMe <- function( workingDirectory ){
				setwd(workingDirectory)
				data <- read.table( "household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", stringsAsFactors=FALSE)
				tidy <- data[( as.Date( data$Date, "%d/%m/%Y") == "2007-02-01" |  as.Date( data$Date, "%d/%m/%Y") == "2007-02-02"),]
				tidyAtomicColumns <- tidy
				tidy$dt <- paste(tidy$Date, tidy$Time)
				tidy$newdt <- strptime( tidy$dt, "%d/%m/%Y %H:%M:%S")
				
				library(reshape2)
				tidyAtomicColumns$dt <- paste(tidy$Date, tidy$Time)
				melted <- melt( tidyAtomicColumns, id=c("dt" ), measure.var=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
				melted$date <- strptime( melted$dt, "%d/%m/%Y %H:%M:%S")
				
				par(mfrow=c(2,2), mar=c(4,4,2,2))
				with( tidy, plot( newdt, Global_active_power, type="n"))
				with(tidy,lines( newdt, Global_active_power, type="S"))
				
				with( tidy, plot( newdt, Voltage, type="n", xlab="datatime", ylab="Voltage"))
				with(tidy, lines( newdt, Voltage, type="S"))
				
				with( melted, plot( date, value, type="n", xlab="", ylab="Energy sub metering"))
				with(subset( melted, variable=="Sub_metering_1"), lines(date, value, type="S"))
				with(subset( melted, variable=="Sub_metering_2"), lines(date, value, type="S", col="red"))
				with(subset( melted, variable=="Sub_metering_3"), lines(date, value, type="S", col="blue"))
				 
				legend("topright", col=c("black", "red", "blue"), pch="-", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
				
				with( tidy, plot( newdt, Global_reactive_power, type="n", xlab="datatime"))
				with(tidy, lines( newdt, Global_reactive_power, type="S"))

				dev.copy( png, "plot4.png", width=760, height=760)
				dev.off()
}