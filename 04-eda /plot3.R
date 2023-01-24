### Download the dataset & unzip & read data
        if(!file.exists("./eda")){dir.create("./eda")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, destfile = "./eda/project.zip")
        
        unzip(zipfile = "./eda/project.zip", exdir = "./eda")
        
        powcon <- read.table("./eda/household_power_consumption.txt",
                                        header = TRUE,
                                        sep = ";",
                                        na.strings = "?")

### Filtering data to only include dates from 2007-02-01 and 2007-02-02

        powconfeb <- subset(powcon, Date == "1/2/2007" | Date == "2/2/2007")

        powconfebtime <- strptime(paste(powconfeb$Date, powconfeb$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

### Turning Energy sub metering numeric

        ESM1 <- as.numeric(powconfeb$Sub_metering_1)
        ESM2 <- as.numeric(powconfeb$Sub_metering_2)        
        ESM3 <- as.numeric(powconfeb$Sub_metering_3)       


### Plotting
        png("plot3.png", width=480, height=480)
        
        plot(powconfebtime, ESM1, type = "l", xlab = "", ylab = "Energy sub metering")
        points(powconfebtime, ESM2, type = "l", col = "red")
        points(powconfebtime, ESM3, type = "l", col = "blue")
        legend("topright", 
               c("Sub_meterin_1", "Sub_meterin_2", "Sub_meterin_3"),
               col = c("black", "red", "blue"),
               lty=c(1,1), lwd=c(1,1))
                )
        dev.off()


