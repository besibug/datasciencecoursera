### Getting Data and Rading Data
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile = "./data/project_2.zip")
        unzip(zipfile = "./data/project_2.zip", exdir = "./data")
        
        NEI <- readRDS("./data/summarySCC_PM25.rds")
        SCC <- readRDS("./data/Source_Classification_Code.rds")


### Subset for coal combustion related sources
        ### Level one holds information for different types pf combustion
                summary(SCC$SCC.Level.One) 
        
        ### Level four lists emissions by source material -> Coal 
                summary(SCC$SCC.Level.Four)

        ### Subsetting

                combu <- grepl("Combustion", SCC$SCC.Level.One)
                coal <-  grepl("Coal", SCC$SCC.Level.Four)
                coalcombu <- (coal & combu)
                ccSCC <- subset(SCC, coalcombu, SCC)
                ccSCC <- SCC[coalcombu,]$SCC
                ccNEI <- NEI [NEI$SCC %in% ccSCC,]


### Plotting
        png("plot4.png", width = 480, height = 480)
        ggplot(ccNEI, aes(factor(year), Emissions)) +
                geom_bar(stat="identity",fill="lightblue") +
                theme_classic() +  guides(fill=FALSE) +
                labs(x="year", 
                     y="Total PM2.5 Emissions in Tons",
                     title= "PM2.5 Coal Combustion Source Emissions Across US from 1999-2008")
        dev.off()
