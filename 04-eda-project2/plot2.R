### Getting Data and Rading Data
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile = "./data/project_2.zip")
        unzip(zipfile = "./data/project_2.zip", exdir = "./data")
        
        NEI <- readRDS("./data/summarySCC_PM25.rds")
        SCC <- readRDS("./data/Source_Classification_Code.rds")
        

### Subsetting the relevant data
        NEI_BM <- subset(NEI, fips == "24510")

### Aggregating BM_Emissions by Year

        NEI_BM_Y <- aggregate(Emissions~year, NEI_BM, sum)

### Plotting 
        png("plot2.png", width = 480, height = 480)
        
        barplot(NEI_BM_Y$Emissions,
                names.arg = c(1999, 2002, 2005, 2008),
                main = "Total PM2.5 Emisions in Baltimore over the Years",
                ylab = "Emissions in Tons"
                )
        
        dev.off()

