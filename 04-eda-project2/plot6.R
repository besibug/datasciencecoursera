library(patchwork)

### Getting Data and Rading Data
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile = "./data/project_2.zip")
        unzip(zipfile = "./data/project_2.zip", exdir = "./data")
        
        NEI <- readRDS("./data/summarySCC_PM25.rds")
        SCC <- readRDS("./data/Source_Classification_Code.rds")

### Baltimore (=plot 5)
        
        NEI_BM <- subset(NEI, fips == "24510")
        
        mvs_BM <- grepl("Vehicle", SCC$SCC.Level.Two)
        mvs_SCC_BM <- SCC[mvs_BM,]$SCC
        mvs_NEI_BM <- NEI_BM [NEI_BM$SCC %in% mvs_SCC_BM,]

### LA
        NEI_LA <- subset(NEI, fips == "06037")
        
        mvs_LA <- grepl("Vehicle", SCC$SCC.Level.Two)
        mvs_SCC_LA <- SCC[mvs_LA,]$SCC
        mvs_NEI_LA <- NEI_LA [NEI_LA$SCC %in% mvs_SCC_LA,]


### PLotting

        png("plot6.png", width = 480, height = 480)
        par(mfrow = c(1,2))
        
        plot1 <- ggplot(mvs_NEI_BM, aes(factor(year), Emissions)) +
                geom_bar(stat="identity",fill="brown", width = 0.5) +
                theme_classic() +  guides(fill=FALSE) +
                ylim(c(0, 8000)) +
                labs(x="year", 
                     y="Total PM2.5 Emissions in Tons",
                     title= "PM2.5 Motor Vehicle Emissions, Baltimore, 1999-2008")
         
        plot2 <- ggplot(mvs_NEI_LA, aes(factor(year), Emissions)) +
                geom_bar(stat="identity",fill="darkorchid4", width = 0.5) +
                theme_classic() +  guides(fill=FALSE) +
                ylim(c(0, 8000)) +
                labs(x="year", 
                     y="Total PM2.5 Emissions in Tons",
                     title= "PM2.5 Motor Vehicle Emissions, Los Angeles, 1999-2008")   
        
        plot1 + plot2 #library(patchwork)
        
        dev.off()
        
        