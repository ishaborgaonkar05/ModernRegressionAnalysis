#Set the working directory
setwd("/Users/luizasette/Documents/UCD/MRA_PA_23/Luiza/Data analysis")

library(ggplot2)

#Reading the data
bike = read.csv("bikesharing_day.csv")

#Prints the first few rows
head(bike)

#1. Boxplot of rentals per working day: 
table(bike$holiday) 
class(bike$holiday)

bike$workingday = factor(bike$workingday, levels = c(0,1), labels = c("no", "yes"))

ggplot(bike, aes(x=workingday, y = cnt, fill = workingday))+geom_boxplot()+
  labs(title = 'Boxplots of rentals per working day')+theme_bw()

#Average rentals, per working day:
tapply(bike$cnt,bike$workingday,summary)


#2. Frequency of weather situation
bike$weathersit = factor(bike$weathersit, levels =c(1,2,3),
                         labels= c("1:Clear", "2:Cloudy", "3:Rain/Snow"))

ggplot(bike, aes(x = weathersit)) + 
  geom_bar() + labs(x = 'Weather', y = 'Frequency')



#3. Density plot: relative frequency of rentals






#4. Boxplot of rentals by day of the week


#Variability of rentals, by weekday




#4. Scartterplot of rentals versus temperature, by season
table(bike$season)

bike$season = factor(bike$season, levels =c(1,2,3,4),
                     labels = c("winter", "spring", "summer", "fall"))

ggplot(bike,aes(x= temp, y= cnt, color = season))+
  geom_point()+facet_wrap(~season)

#5. Summary of rentals, per season


#6. Pairs plot
install.packages("GGally")
library(GGally)
bike_subset = bike[,c(10,12,13,14,15)]
ggpairs(bike_subset)  

#7. Correlation
cor(bike_subset)

library(corrplot)
corrplot(cor(bike_subset),method = 'color')


