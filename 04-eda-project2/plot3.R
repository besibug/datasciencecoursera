library(dplyr)
library(ggplot2)

### Getting Data and Rading Data
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile = "./data/project_2.zip")
        unzip(zipfile = "./data/project_2.zip", exdir = "./data")
        
        NEI <- readRDS("./data/summarySCC_PM25.rds")
        SCC <- readRDS("./data/Source_Classification_Code.rds")


### Subset flps for Baltimore
        NEI_BM <- subset(NEI, fips == "24510")

### Grouping by type and years

by_type_year <- NEI_BM %>% group_by(year, type) %>% summarise(sum(Emissions))

### Plotting 
        png("plot3.png", width = 480, height = 480)
        
        ggplot(by_type_year, aes(x = factor(year), y = `sum(Emissions)`, fill = type)) + 
                geom_bar(stat = "identity", position = "dodge") +
                facet_grid(.~type) +
                guides(fill = "none") +
                labs(x="Year", y = "Total Emissions in Tons", 
                     title = "PM2.5 Emissions in Baltimore 1999-2008, by Source Type")
        
        dev.off()
