NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

head(NEI)
library(dplyr)
library(ggplot2)

# summing emission data per year
total_emissions_Baltimore_type<-NEI %>%
  filter(fips=="24510") %>%
  group_by_at(vars(type, year)) %>%
  summarise(summen=sum(Emissions)) %>%
  as.data.frame()
total_emissions_Baltimore_type$year<-as.character(total_emissions_Baltimore_type$year)

# plotting
png("plot3.png")
ggplot(total_emissions_Baltimore_type, aes(fill=type, y=summen, x=year) ) + 
  geom_bar(position="dodge", stat="identity") + 
  ylab("Total Emission") + xlab("Year") + 
  ggtitle("Total Emission in Baltimore per year")
  
dev.off()

