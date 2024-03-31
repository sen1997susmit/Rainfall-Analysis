# Rainfall-Analysis

<p align="center">
  <img width="600" height="500" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/map-of-australia.gif"><br>
</p>
Australia has always been a continent with diverse climate features beacause of its too diverse landscape. Here I have done detailed visualization and Exploratory study over climates of eight capital cities in Australia - 'Darwin','Sydney','Brisbane','Perth','Melbourne','Canberra','Hobart','Adelaide'. The whole analysis has been done in R-studio.

## 1. Cities on map based on rainfall 
<p align="center">
  <img src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/rain%20in%20cities%20on%20map.png"><br>
</p>
There are multiple desserts in the centre of Australia, like Gibson Desert, Tanami Desert, Simposon Desert. And the effect of this geography can be seen prominently from the plot above. We can clearly observe how the coastal cities have experienced more number of rainy days compared to the cities in the heart of australia.

## 2. How rainy are the capitals 
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/How%20rainy%20are%20the%20capitals.png"><br>
</p>
Now we shall focus only on the capitals mentioned in the beginning. Darwin gets on an average 1727.3 mm rainfall each year, where as Canberra gets 629 mm of rainfall on an average. The high rainfall in Darwin can be explained by the [El Nino-Southern Oscillation (ENSO)](https://en.wikipedia.org/wiki/El_Ni%C3%B1o#Australia_and_the_Southern_Pacific) in pacific ocean. ENSO is generally associated with a band of warm ocean water that develops in the central and east-central equatorial Pacific. Clearly Darwin being the northest city, gets affected the most during January mostly.
<img src="https://www.science.org.au/curious/sites/default/files/images/enso-la-nina-880.jpg">

## 3. How stormy are the capitals
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/How%20stormy%20are%20the%20capitals.png"><br>
</p>
Here we can see the proportion of the stormy rainy days (i.e. number of rainy days with rainfall > 100 mm divided by total number of rainy days in that city) and the proportion of drizzling rainy days (< 50 mm). As El nino is mainly originated from the low pressure zone in the pacific ocean (located in the North-east direction of Australia) , The stormy thunderheads hit directly in the Northern and Eastern coastal cities of Australia. So we can see Darwin and Brisbane both have a very high proportion of stormy days over the past 10 years.

<br> from now on we shall use the convention that the darker or lighter shade of any color denotes a city with higher number or lower number of rainy days respectively.

## 4. average humidity of capital cities
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/avg%20humid%20distribution.png"><br>
</p>
we can see the density of average humidity of the cities over past 10 years. The red dotted line denotes the mean. The right skewed curve of Darwin shows most days of Darwin have experienced humidity of 70%. an interesting thing to observe is that The density curve of Brisbane is tightly packed at near about 60% .

## 5. average temperature of capital cities
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/avg%20temp%20distribution.png"><br>
</p>
Astonishingly, Darwin has a very right skewed density curve for average temperature. So not only it experiences the most number of rainy days but also Darwin is quite hot, may be due to being the closest one to the Equador. The cities closer to the south pole (Adelaide, Hobart, Melbourne) should be much cold, and that is prominent from the lefft skewed curves.

## 6. average pressure of capital cities
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/avg%20pressure%20distribution.png"><br>
</p>
Other than Perth most of the parts of Australia experiences a low pressure belt. As we can see from the plots.
<p align="center">
  <img src="https://www.weatheronline.co.uk/images/charts/en/vorher/500px/2021/11/11/d/aupa/d_20211111_h09_aupa_en.gif?202111102100">
</p>

## 7. monthly overview of rainfall over seasons
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/rain_over_month.png"><br>
</p>
An immediate observation is that Darwin, Brisbane, Sydney all three have similar seasonal pattern over the months, and Mebourne, Adelaide, Perth all three have similar seasonal pattern and opposite to the first group of capitals. All the three cities in the first group are located in the east and north-east coastal side of Australia and the cities of the second group are located in the western coast of Australia. This opposite climate can be explained by two modes of El-Nino South Oscillation , namely El-Nion and La-Nina. Also there are other winds in effect.
<p align="center">
  <img width="400" height="400" src="https://www.researchgate.net/profile/Willem-Renema/publication/316861103/figure/fig1/AS:614297835143187@1523471425611/Map-of-Australia-and-Southeast-Asia-showing-site-locations-and-prevailing-atmospheric.png">
</p>

<br> to support the opposite wind directions in different seasons over the cities, in the next two plots we are seeing the wind directions in two cities - Darwin from North, Perth from South-West.

## 8. wind directions of Perth over seasons
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/wind%20dir%20in%20Perth.png"><br>
</p>

## 9. Wind directions of Darwin over season
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/wind%20dir%20in%20Darwin.png"><br>
</p>

## 10. yearly overview of rainfall
<p align="center">
  <img width="700" height="400" src="https://github.com/Dion11235/Rainfall-Analysis-of-Australia/blob/main/plots/rain_over_years.png"><br>
</p>
one quick thing we can see is that Perth experienced rain for 12% of the whole year 2010. Perth experienced [the second driest year ever](http://www.bom.gov.au/climate/current/annual/wa/archive/2010.perth.shtml). But on the contrary, Darwin experienced [heavy monsoon burst in 2017](https://www.abc.net.au/news/2017-02-05/deluge-of-rain-causes-havoc-on-darwin-roads-and-minor-flooding/8242452) with 200 mm of rain for 24 hours continuously.

<br><br> This was a complete visual climate analysis of Australia from 2007 to 2017. Thank you.


