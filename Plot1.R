###########################################################
#
#Programming Assignment 1 - Course 4 - Data Science Coursera.
#
############################################################

Plot1<-function(){
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
    #plot hist to screen
    hist(dt2$Global_active_power,col="red",main="Global Active Power",
         xlab="Global Active Power (kilowatts)")
    #copy to png file
    dev.copy(png,file="Plot1.png", width=480, height=480)
    dev.off() #close png file 'device'
}