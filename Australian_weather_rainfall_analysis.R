####################### Analysis of rainfall in Australia ######################

##### loading the necessary packages ########################
library(dplyr)
library(ggplot2)
library(reshape)
library(sf)
library(cowplot)
library(ggridges)
library(viridis)

##### reading the data ###############################
aus <- read.csv('/home/dion/Desktop/self_study/local_projects/Stat project sem 1 - Rainfall in Australia ( solo )-20210724T030836Z-001/Stat project sem 1 - Rainfall in Australia ( solo )/Australian weather Rainfall/weatherAUS.csv')
coord <- read.csv('/home/dion/Desktop/self_study/local_projects/Stat project sem 1 - Rainfall in Australia ( solo )-20210724T030836Z-001/Stat project sem 1 - Rainfall in Australia ( solo )/Australian weather Rainfall/Cities in Australia.csv') 
AUS_STATE_shp <- read_sf("STE_2016_AUST.shp")

##### basic modification of our data ########################
aus <- aus %>% select(-c(RISK_MM,RainTomorrow))  #not enough info
names(aus) <- tolower(names(aus))
length(unique(aus$location)) 

##### Cleaning NA values ############################
sort(sapply(aus,function(x) sum(is.na(x))))

# the columns with the most number of NA values :
#  1. cloud9am
#  2. cloud3pm
#  3. evaporation
#  4. sunshine
# so, we will delete those columns.

aus1 <- aus %>% select(-c('evaporation','sunshine','cloud9am','cloud3pm'))
aus1 <- aus1 %>% filter(complete.cases(aus1))

##### Selecting the cities and more modifications ############################
cities      <- c( 'Darwin','Sydney','Brisbane','Perth',
                  'Melbourne','Canberra','Hobart','Adelaide' )
aus1$heavy_rain <- ifelse(aus1$rainfall > 100,1,0)
aus1$mild_rain <- ifelse(aus1$rainfall < 50,1,0)

aus2 <- aus1 %>% filter(aus1$location %in% cities)
aus2$raintoday <- ifelse(aus2$raintoday=='Yes',1,0)
aus2$date <- as.Date(aus2$date,'%Y-%m-%d')
aus2$month <- lapply(aus2$date,months)
aus2$month <- as.character(aus2$month)
aus2$year <- as.numeric(format(aus2$date,'%Y'))
aus2$month <- factor(aus2$month,levels=month.name)
aus2$avgtemp <- (aus2$maxtemp+aus2$mintemp)/2
aus2$avgpres <- (aus2$pressure3pm+aus2$pressure9am)/2
aus2$avghumid <- (aus2$humidity3pm+aus2$humidity9am)/2
aus2$avgwindspeed <- (aus2$windspeed3pm+aus2$windspeed9am)/2
aus2$windgustdir <- factor(aus2$windgustdir,levels=c("N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"))
aus2$winddir9am <- factor(aus2$winddir9am,levels=c("N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"))
aus2$winddir3pm <- factor(aus2$winddir3pm,levels=c("N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"))


############################ Analysis of the data ##############################

##### 1. cities on map #####
temp <- aus1 %>% filter(raintoday=='Yes') %>% group_by(location) %>% summarise(
  Freq = n(),
  rainfall_mean = mean(rainfall),
  heavy_rain_count = sum(heavy_rain)/n(),
  mild_rain_count = sum(mild_rain)/n()
)

temp$total <- aus1 %>% select(location) %>% table()
temp$density <- temp$Freq/temp$total
aus1 <- merge(aus1,coord,by='location')

raincount <- merge(temp,coord,by='location'); head(raincount)
raincount_geometry <- raincount %>% st_as_sf(coords = c("LONG", "LAT"), crs = 4326)

ggplot() + geom_sf(data=AUS_STATE_shp,fill='Tan')+geom_sf(data=raincount_geometry, size=2, aes(color = density))+
  ylim(50,0) + xlab("Longitude") +ylab("Latitude") + theme(panel.grid.major = element_line(color = grey(0.5),linetype = "dashed",size=0.5),panel.background = element_rect(fill='Gainsboro')) +
  ggtitle("Rain in different cities", 
          subtitle = 'based on No. of rainy days in 10 years')

##### 2. How rainy are the Capitals? #####
temp %>% filter(location %in% cities) %>% 
  ggplot(.,aes(x=reorder(location,density),y=density)) + geom_col(aes(fill=density)) + coord_flip() + 
  theme(legend.position = 'none') + xlab('') + ylab('Proportion of rainy days') + 
  ggtitle('How rainy are the capitals?')

aus2 <- merge(aus2,temp,by='location')
aus2$location <- reorder(aus2$location,aus2$density)

##### 3. How stormy are the capitals? #####
p1 <- temp %>% filter(location %in% cities) %>% 
  ggplot(.,aes(x=reorder(location,heavy_rain_count),y=heavy_rain_count)) + geom_col(aes(fill=heavy_rain_count)) + coord_flip() + 
  theme(legend.position = 'none') + xlab('') + ylab('Proportion of rainy days') + 
  ggtitle('How stormy are the capitals?',subtitle = 'No. of stormy rainfalls ( > 100mm)')
p2 <- temp %>% filter(location %in% cities) %>% 
  ggplot(.,aes(x=reorder(location,heavy_rain_count),y=mild_rain_count)) + geom_col(aes(fill=mild_rain_count)) + coord_flip() + 
  theme(legend.position = 'none') + xlab('') + ylab('Proportion of rainy days') + 
  ggtitle('',subtitle = 'No. of drizzling rainfalls ( < 50mm)')

plot_grid(p1,p2)

##### 4. avg humidity of capital cities ##### 
ggplot(aus2,aes(avghumid)) + geom_area(aes(fill=location),stat='bin',color='black') +
  #geom_histogram(fill='transparent',color='purple') +
  geom_vline(aes(xintercept=median(avghumid)),color='red',linetype=4)+
  facet_wrap(~location,nrow=4,scales = 'free') + scale_fill_brewer() +
  ggtitle('Average Humidity distribution') + xlab('Average Humidity (%)')+
  theme(legend.position = 'none')

##### 5. avg temperature of capital cities #####
ggplot(aus2,aes(avgtemp)) + geom_area(aes(fill=location),stat='bin',color='black') +
  facet_wrap(~location,nrow=4,scales = 'free') + scale_fill_brewer(palette= 'Reds') +
  ggtitle('Average Temperature distribution') + xlab('Average temperature (Celsius)')+
  theme(legend.position = 'none')
##### 6. avg pressure of capital cities #####
ggplot(aus2,aes(avgpres)) + geom_area(aes(fill=location),stat='bin',color='black') +
  facet_wrap(~location,nrow=4,scales = 'free') + scale_fill_brewer(palette= 'Greens') +
  ggtitle('Average pressure distribution') + xlab('Average pressure (HPa)')+
  theme(legend.position = 'none')

##### 7. monthly overview of rainfall over seasons #####
by_mon <- aus2 %>% group_by(month,location) 
by_mon_rain <- by_mon %>% summarise(
  rain=sum(raintoday)/n(),
  temp=mean(avgtemp),
  pres=mean(avgpres)
)

ggplot(by_mon_rain, aes(month, location, fill= temp)) + 
  geom_tile() + scale_fill_gradient(low = 'cyan',high = 'red',name='Temperature (Celsius)') + xlab('') + ylab('Cities') +
  ggtitle('Temperature distribution over different months') + geom_text(aes(label=round(temp,2)),size=3) + theme(legend.position = 'bottom')

ggplot(by_mon_rain, aes(month, location, fill= rain)) + 
  geom_tile() + scale_fill_gradient(low = 'yellow',high = 'blue',name='Proportion of rainy days') + xlab('') + ylab('Cities') +
  ggtitle('Rainfall distribution over different months') + geom_text(aes(label=round(rain,2)),size=3) + theme(legend.position = 'bottom')

##### 8. wind directions of Perth over seasons ##### 
p1 <- aus2 %>% filter(month %in% c('January','February','March','December')) %>% filter(location=='Perth') %>%
  ggplot(.,aes(x=winddir9am)) + geom_bar(aes(fill=..count..)) + coord_polar(start=-0.20) +
  theme(axis.title = element_blank(),axis.text.y = element_blank(),axis.ticks.y = element_blank(),panel.grid=element_line(color='grey')) +
  ggtitle('Wind Directions of Perth',subtitle = 'Summer') + labs(fill='No. of days')

p2 <- aus2 %>% filter(month %in% c('June','July','August','September')) %>% filter(location=='Perth') %>%
  ggplot(.,aes(x=winddir3pm)) + geom_bar(aes(fill=..count..)) + coord_polar(start=-0.20) +
  theme(axis.title = element_blank(),axis.text.y = element_blank(),axis.ticks.y = element_blank(),panel.grid=element_line(color='grey')) +
  ggtitle('',subtitle = 'Winter')+ labs(fill='No. of days')

plot_grid(p1,p2)

##### 9. Wind directions of Darwin over season #####
p1 <- aus2 %>% filter(month %in% c('January','February','March','December')) %>% filter(location=='Darwin') %>%
  ggplot(.,aes(x=winddir9am)) + geom_bar(aes(fill=..count..)) + coord_polar(start=-0.20) +
  theme(axis.title = element_blank(),axis.text.y = element_blank(),axis.ticks.y = element_blank(),panel.grid=element_line(color='grey')) +
  ggtitle('Wind Directions in Darwin',subtitle = 'Summer')+ labs(fill='No. of days')

p2 <- aus2 %>% filter(month %in% c('June','July','August','September')) %>% filter(location=='Darwin') %>%
  ggplot(.,aes(x=winddir9am)) + geom_bar(aes(fill=..count..)) + coord_polar(start=-0.20) +
  theme(axis.title = element_blank(),axis.text.y = element_blank(),axis.ticks.y = element_blank(),panel.grid=element_line(color='grey')) +
  ggtitle('',subtitle = 'Winter')+ labs(fill='No. of days')

plot_grid(p1,p2)


##### 10. yearly overview of rainfall #####
by_year <- aus2 %>% group_by(year,location) 
by_year_rain <- by_year %>% summarise(
  rain=sum(raintoday)/n(),
  temp=mean(avgtemp),
  pres=mean(avgpres)
)

ggplot(by_year_rain, aes(factor(year), location, fill= rain)) + 
  geom_tile() + scale_fill_gradient(low = 'yellow',high = 'blue') + xlab('') + ylab('Cities') +
  ggtitle('Rainfall distribution over different years') + geom_text(aes(label=round(rain,2)),size=3)+ labs(fill='proportion of rainy days')




##### 11. avg pressure and avg humidity - are they related? #####
ggplot(aus2,aes(avgpres,avghumid)) + geom_point(aes(color=factor(raintoday)),alpha=0.5)+ theme_dark() +
  ggtitle('Pressure vs Humidity in Capital cities of Australia') + xlab('Average Pressure (HPa)') +
  ylab('Average Humidity (%)') + facet_wrap(~location,nrow=4,scales = 'free')+scale_color_discrete(name="Did it rain?",labels=c('No','Yes'))

##### 12. avg temperature and avg humidity - are they related? #####
ggplot(aus2,aes(avgtemp,avghumid)) + geom_point(aes(color=factor(raintoday)),alpha=0.5)+theme_dark() +
  ggtitle('Temperature vs Humidity in Capital cities of Australia') + xlab('Average temperature (Celsius)') + scale_color_discrete(name='Did it rain?',labels=c('No','Yes'))+
  ylab('Average humidity (%)') + facet_wrap(~location,nrow=4,scales='free')


##### 13. avg wind speed vs avg humidity - are they related? #####
ggplot(aus2,aes(avgwindspeed,avghumid)) + geom_point(aes(color=factor(raintoday)),alpha=0.5) +theme_dark() +
  ggtitle('Windspeed vs Humidity in Capital cities of Australia') + xlab('Average windspeed (km/hr)') + scale_color_discrete(name='Did it rain?',labels=c('No','Yes'))+
  ylab('Average humidity (%)') + facet_wrap(~location,nrow=4,scales='free')


################## time series analysis ########################
library("tseries")
library(itsmr)
library(astsa)
library(lmtest)
library(forecast)
library(urca)
library(stringr)

