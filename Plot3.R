###########################################################
#
#Programming Assignment 1 - Course 4 - Data Science Coursera.
#
############################################################

Plot3<-function(){
    ## read 2880 lines (48 hours * 60 readings/hour)
    ## start at 00:00:00 on 1/2/2007
    ## append column DateTime as DateTimeObject using Col's 1&2
    require(data.table)
    
    
    dt2=data.table(fread("household_power_consumption.txt",sep=";",
                         na.strings="?", nrows=2880, skip="1/2/2007",
                         header=FALSE, colClasses=c("as.Date", "as.Date","numeric",
                        "numeric","numeric","numeric","numeric","numeric","numeric")))
    setnames(dt2, c("Date", "Time", "Global_active_power",
                    "Global_reactive_power", "Voltage",
                    "Global_intensity","Sub_metering_1",
                    "Sub_metering_2", "Sub_metering_3"))
    ## paste(dt$Date,dt$time) to get date/time string
    ## strptime(the paste, "%d/%m/%Y %H:%M:%S") to convert to date/time obj
    ## add as new DateTimeColumn in DataTable
    dt2<-dt2[,DateTime:=data.table(strptime(paste(dt2$Date[],dt2$Time[]),
                                            "%d/%m/%Y %H:%M:%S"))]
  
    par(bg="White", cex=.65)
    with(dt2,plot(dt2$DateTime,dt2$Sub_metering_1,"n", xlab="", ylab="Energy Sub Metering"))
    with(subset(dt2), lines(DateTime,Sub_metering_1))
    with(subset(dt2), lines(DateTime,Sub_metering_2, col="red"))
    with(subset(dt2), lines(DateTime,Sub_metering_3,col="blue"))
    legend("topright",lty=1,col=c("black","red","blue"), legend=c("Sub_metering_1",
                                                "Sub_metering_2", "Sub_metering_3"))
    
    
    dev.copy(png,"Plot3.png", width=480, height=480)
    dev.off() #close png file 'device'h
}