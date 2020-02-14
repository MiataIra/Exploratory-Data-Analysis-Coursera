NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

head(NEI)
library(dplyr)


# summing emission data per year
total_emissions_Baltimore<-NEI %>%
  filter(fips=="24510") %>%
  group_by_at(vars(year)) %>%
  summarise(summen=sum(Emissions)) %>%
  as.data.frame()


# plotting
png("plot2.png")
barplot(total_emissions_Baltimore$summen, 
        names.arg=total_emissions$year, 
        xlab = "Year", ylab = "Total Emission", 
        main = "Total Emission in Baltimore per year")
dev.off()

