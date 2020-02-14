NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

head(NEI)
library(dplyr)



total_emissions_Baltimore_on_road<-NEI %>%
  filter(fips=="24510", type=="ON-ROAD") %>%
  group_by_at(vars(type, year)) %>%
  summarise(summen=sum(Emissions)) %>%
  as.data.frame()
total_emissions_Baltimore_on_road$year<-as.character(total_emissions_Baltimore_on_road$year)

# plotting
png("plot5.png")
ggplot(total_emissions_Baltimore_on_road, aes(fill=type, y=summen, x=year) ) + 
  geom_bar(position="dodge", stat="identity") + 
  ylab("Total Emission") + xlab("Year") + 
  ggtitle("Total Emission in Baltimore on road per year")

dev.off()
