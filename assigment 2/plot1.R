NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

head(NEI)
library(dplyr)

# summing emission data per year
total_emissions<-NEI %>%
  group_by(year) %>%
  summarise(summen=sum(Emissions)) %>%
  as.data.frame()


# plotting
png("plot1.png")
barplot(height=total_emissions$summen, names.arg=total_emissions$year, xlab = "Year", ylab = "Total Emission", 
        main = "Total Emission per year")
dev.off()

