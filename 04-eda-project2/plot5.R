### Getting Data and Rading Data
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile = "./data/project_2.zip")
        unzip(zipfile = "./data/project_2.zip", exdir = "./data")
        
        NEI <- readRDS("./data/summarySCC_PM25.rds")
        SCC <- readRDS("./data/Source_Classification_Code.rds")


### Subsetting for Baltimore
        NEI_BM <- subset(NEI, fips == "24510")

### Subsetting for Motor Vehicle Sources -> Info in SCC Level Two "Vehicle"
        summary(SCC$SCC.Level.Two)

        mvs <- grepl("Vehicle", SCC$SCC.Level.Two)
        mvs_SCC <- SCC[mvs,]$SCC
        mvs_NEI <- NEI_BM [NEI_BM$SCC %in% mvs_SCC,]

### Plotting
        png("plot5.png", width = 480, height = 480)
        
        ggplot(mvs_NEI, aes(factor(year), Emissions)) +
                geom_bar(stat="identity",fill="brown") +
                theme_classic() +  guides(fill=FALSE) +
                labs(x="year", 
                     y="Total PM2.5 Emissions in Tons",
                     title= "PM2.5 Motor Vehicle Emissions, Baltimore, 1999-2008")
        
        dev.off()
        