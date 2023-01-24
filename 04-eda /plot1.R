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

        powcon$Date <- strptime(powcon$Date, format = "%d/%m/%Y")
        
        powconfeb <- subset(powcon, Date == "2007-02-01" | Date == "2007-02-02")


### Constructin Plot1: Histogramm of GAP in kW

        png("plot1.png", width = 480, height = 480)
        hist(powconfeb$Global_active_power,
             col = "red",
             xlab = "Global Active Power (kilowatts)",
             main = "Gloabl Active Power")
        dev.off()
