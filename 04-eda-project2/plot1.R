### Getting Data and Rading Data
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile = "./data/project_2.zip")
        unzip(zipfile = "./data/project_2.zip", exdir = "./data")
        
        NEI <- readRDS("./data/summarySCC_PM25.rds")
        SCC <- readRDS("./data/Source_Classification_Code.rds")


### Subsetting relevant years
        NEI_1999 <- subset(NEI, year == 1999)
        NEI_2002 <- subset(NEI, year == 2002)
        NEI_2005 <- subset(NEI, year == 2005)
        NEI_2008 <- subset(NEI, year == 2008)

### Adding Total Emissions for years
        Tot_PM25_1999 <- sum(NEI_1999$Emissions)
        Tot_PM25_2002 <- sum(NEI_2002$Emissions)
        Tot_PM25_2005 <- sum(NEI_2005$Emissions)
        Tot_PM25_2008 <- sum(NEI_2008$Emissions)

### Creating Matrix for barplot
        Tot_PM25 <- c(Tot_PM25_1999, Tot_PM25_2002, Tot_PM25_2005, Tot_PM25_2008)

### Making sure y-axis does not change to scientific notation
        options(scipen=5)

### barplot
        png("plot1.png", width = 480, height = 480)
        barplot(Tot_PM25, 
                main = "Total PM2.5 Emission for selected years in US",
                ylim = c(0, Tot_PM25_1999),
                ylab = "PM2.5 Emissions in tons",
                names.arg = c(1999, 2002, 2005, 2008))
        
        dev.off()
