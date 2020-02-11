library(hms)
library(dplyr)


My_data<-read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",
                    sep=";",header=TRUE,
                    stringsAsFactors = FALSE) #load dataset

My_data$Date<-as.Date(My_data$Date, format='%d/%m/%Y')
ee<-mutate((My_data), date=paste(Date, Time, sep=" "))

ee$date<-as.POSIXlt(ee$date)



My_data<-filter(My_data, Date=="2007-02-01" | Date=="2007-02-02")
My_data$Time<-as_hms(My_data$Time)
My_data$Global_active_power<-as.numeric(My_data$Global_active_power)
My_data$Global_reactive_power<-as.numeric(My_data$Global_reactive_power)
My_data$Voltage<-as.numeric(My_data$Voltage)
My_data$Global_intensity<-as.numeric(My_data$Global_intensity)
My_data$Sub_metering_1<-as.numeric(My_data$Sub_metering_1)
My_data$Sub_metering_2<-as.numeric(My_data$Sub_metering_2)



hist(My_data$Global_active_power, xlab = "Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.copy(png, "plot1.png")
dev.off()


#plot(x=My_data$Time, y=My_data$Global_active_power, type="n")
#lines(x=My_data$Time, y=My_data$Global_active_power)


plot(x=ee$date, y=ee$Global_active_power, type="n", xlab =" ", ylab = "Global Active Power (kilowatts)")
lines(x=ee$date, y=ee$Global_active_power)
dev.copy(png, "plot2.png")
dev.off()

plot(x=ee$date, y=ee$Sub_metering_1, type="n", xlab =" ", ylab = "Energy sub metering")
lines(x=ee$date, y=ee$Sub_metering_1)
lines(x=ee$date, y=ee$Sub_metering_2, col="red")
lines(x=ee$date, y=ee$Sub_metering_3, col="blue")
legend("topright", lty=1,col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, "plot3.png")
dev.off()


png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(x=ee$date, y=ee$Global_active_power, type="n", xlab =" ", ylab = "Global Active Power (kilowatts)")
lines(x=ee$date, y=ee$Global_active_power)
plot(x=ee$date, y=ee$Voltage, type="n", xlab ="datatime", ylab = "Voltage")
lines(x=ee$date, y=ee$Voltage)
plot(x=ee$date, y=ee$Sub_metering_1, type="n", xlab =" ", ylab = "Energy sub metering")
lines(x=ee$date, y=ee$Sub_metering_1)
lines(x=ee$date, y=ee$Sub_metering_2, col="red")
lines(x=ee$date, y=ee$Sub_metering_3, col="blue")
legend("topright", lty=1,col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
plot(x=ee$date, y=ee$Global_reactive_power, type="n", xlab ="datetime", ylab = "Global_reactive_power")
lines(x=ee$date, y=ee$Global_reactive_power)
#dev.copy(png, "plot4.png", width=480, height=480)
dev.off()


