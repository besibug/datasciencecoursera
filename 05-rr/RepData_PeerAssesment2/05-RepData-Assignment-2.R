library(data.table)
library(ggplot2)

### Data Processing

### Getting the data and reading in
        if(!file.exists("./data")){dir.create("./data")}
        fileurl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
        download.file(fileurl, destfile = "./data/stormdata.csv.bz2")

        StormData <-  read.csv("./data/stormdata.csv.bz2")
        
       
### Data Overview
 str(StormData)

        ### Data Quality
                StormData$year <- as.numeric(format(as.Date(StormData$BGN_DATE, format = "%m/%d/%Y %H:%M:%S"), "%Y"))
                hist(StormData$year, breaks = 30)
                
                ### only use data starting from 1995
                
                Storm95 <- subset(StormData, year >= 1995)

        ### Coloums of interest
                
                # EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP
                
                StormCol <- Storm95[, c('EVTYPE', 'FATALITIES', 'INJURIES', 'PROPDMG', 'PROPDMGEXP', 'CROPDMG', 'CROPDMGEXP')]

str(StormCol)
summary(StormCol)
        
        ### Fatalities


StormClean <- subset(StormCol, INJURIES > 0 | FATALITIES > 0 | PROPDMG > 0 | CROPDMG > 0)

str(StormClean)



        ### Exponents
                unique(StormClean$PROPDMGEXP)
                


PropOldEx <- c("B", "M", "K", "\"\"", "+", "5", "0", "6", "4", "2", "7", "3", "H", "-")
PropNewEx <- c(10^9, 10^6, 10^3, 10^0, 10^0, 10^5, 10^0, 10^6, 10^4, 10^2, 10^7, 10^3, 10^2, 10^0)

MergePropTable <- data.frame(PropNewEx, PropOldEx)

StormPropExp <- merge(StormClean, MergePropTable, by.x = "PROPDMGEXP", by.y = "PropOldEx")

StormPropExp <- subset(StormPropExp, select = -PROPDMGEXP) 

### Exp for Crop

unique(StormClean$CROPDMGEXP)

CropOldEx <- c("M", "\"\"", "K", "B", "?", "k", "0")
CropNewEx <- c(10^6, 10^0, 10^3, 10^9, 10^0, 10^0, 10^0)

MergeCropTable <- data.frame(CropNewEx, CropOldEx)
MergeCropTable        

StormCropEx <- merge(StormPropExp, MergeCropTable, by.x = "CROPDMGEXP", by.y = "CropOldEx")
StormCropEx <- subset(StormCropEx, select = -CROPDMGEXP) 

### Rearranging the coloumns

StormAnalysis <- StormCropEx[, c(1,2,3,4,6,5,7)]
head(StormAnalysis)


        
### Question 1 :Across the United States, which types of events (as indicated 
###in the  EVTYPE EVTYPE variable) are most harmful with respect to population health?

StormHarm <- aggregate(cbind(FATALITIES, INJURIES) ~ EVTYPE , StormAnalysis, sum)


StormHarm <- StormHarm %>%
        mutate(TotalHarm = FATALITIES + INJURIES)


StormHarm <- arrange(StormHarm, -TotalHarm)
head(StormHarm)

StormPlot <- StormHarm[(1:8), ]

StormPlot <- melt(StormPlot, id.vars="EVTYPE", variable.name = "Harm")



ggplot(StormPlot, aes( x = reorder(EVTYPE, value), value)) +
        geom_bar(stat="identity", aes(fill=Harm), position="dodge") +
        ggtitle ("Storm Damage affecting Human Life in US (TOP8, 1995-2011") +
        ylab("Count") +
        xlab ("Harmfull Event") + 
        theme(legend.position = "top" ,axis.text.x = element_text(angle=30, hjust=1)) + 
        scale_fill_manual("legend", values = c("FATALITIES" = "black", "INJURIES" = "red", "TotalHarm" = "blue")) 
?ggplot2
?theme
?linetype

?geom_bar

### Question 2 :Across the United States, which types of events have the 
### greatest economic consequences?
        
head(StormAnalysis)
                
StormEcon <- StormAnalysis %>%
        mutate(PropCost = PROPDMG * PropNewEx,
               CropCost = CROPDMG * CropNewEx
        )

head(StormEcon)

StormEconAg <- aggregate(cbind(PropCost, CropCost) ~ EVTYPE , StormEcon, sum)        

StormEcoDmg <- StormEconAg %>%
        mutate(TotalDmg = PropCost + CropCost)

head(StormEcoDmg)

StormEcoDmg <- arrange(StormEcoDmg, -TotalDmg)
StormPlot2 <- StormEcoDmg[(1:8), ]

StormPlot2 <- melt(StormPlot2, id.vars="EVTYPE", variable.name = "Damage")
head(StormPlot2)

### Plot

ggplot(StormPlot2, aes( x = reorder(EVTYPE, value), value)) +
        geom_bar(stat="identity", aes(fill=Damage), position="dodge") +
        ggtitle ("Storm Damage to the Economy in US (TOP8, 1995-2011") +
        ylab("Cost(Dollars)") +
        xlab ("") + 
        theme(legend.position = "top" ,axis.text.x = element_text(angle=30, hjust=1)) + 
        scale_fill_manual("legend", values = c("CropCost" = "black", "PropCost" = "red", "TotalCost" = "blue")) 


### Results
        
        