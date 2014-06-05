

plotMe <- function( workingDirectory ){
				setwd(workingDirectory)
				data <- read.table( "household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", stringsAsFactors=FALSE)
				tidy <- data[( as.Date( data$Date, "%d/%m/%Y") == "2007-02-01" |  as.Date( data$Date, "%d/%m/%Y") == "2007-02-02"),]
				tidy$dt <- paste(tidy$Date, tidy$Time)
				tidy$newdt <- strptime( tidy$dt, "%d/%m/%Y %H:%M:%S")
				with( tidy, plot( newdt, Global_active_power, type="n", xlab="", ylab="Global active power(kilowatts)"))
				with(tidy, lines( newdt, Global_active_power, type="S"))
				dev.copy( png, "plot2.png")
				dev.off()
}