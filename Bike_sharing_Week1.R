#Set the working directory
setwd("/D/UCD/Data analysis")

#Reading the data
bike = read.csv("bikesharing_day.csv")

#Prints the first few rows
head(bike)

#calculationg the levels of weathersit
levels(bike$weathersit)

#The number of observations for a particular category
table(bike$weathersit)


bike$weathersit = factor(bike$weathersit, 
                         levels = c(1, 2, 3),   # Replace with actual levels if necessary
                         labels = c("1:Clear", "2:Cloudy", "3:Rain/Snow"))




# Relative Frequency Proportions 
#the percentage that each category accounts for the weather  

prop.table(table(bike$weathersit))

#Plotting the Barplot for the proportions 
tab_props = prop.table(table(bike$weathersit))
barplot(tab_props, col = terrain.colors(3), ylab = 'Proportion of days')


# one numerical variable Y : the number of bikes rented in a day
#minumum , 1st quartile, Median, Mean, 3rd quartile , Max (Summary of cnt column)
summary(bike$cnt)

#gives a numeric value representing the variability or dispersion of the cnt values.
var(bike$cnt)


#only one numeric variable 

#plotting the hstogram 
hist(bike$cnt, breaks = 20, xlab = 'Number of rentals', main = 'Histogram', col = 'lightblue')

#plotting the Boxplot
boxplot(bike$cnt, main  = 'Number of rentals', col = 'lightpink')
boxplot(bike$registered, main  = 'Number of rentals', col = 'lightpink')
boxplot(bike$cnt, main = 'Boxplot of bikes rented', col = 'lightpink')
boxplot(bike$windspeed, main = 'Boxplot of normalised wind speed',col = 'lightgreen')

# One numeric and one categorical variable.
tapply(bike$cnt, bike$weathersit, summary)

#Numerical Y versus categorical X.
boxplot(bike$cnt ~ bike$weathersit, col = c("lightblue", "grey", "white"),xlab = 'Weather', ylab = 'Rentals')


#correlation between temprature and bike count 
cor(bike$temp,bike$cnt)

#correlation between windspeed and bike count 
cor(bike$windspeed,bike$cnt)




#Boxplot of rentals per working day: 

#how many times each unique value appears 
table(bike$holiday) 
table(bike$workingday)
table(bike$mnth)


#returns the data type or class 
#class() function in R is used to check the data type of a variable, such as numeric, factor, character

class(bike$holiday)
class(bike$dteday)
class(bike$temp)


#factor(): This function transforms a numeric or character variable into a factor (categorical variable),
bike$workingday = factor(bike$workingday, levels = c(0,1), labels = c("no", "yes"))

#plotting the boxplot,Violinplot.
#ggplot(data,aes())
ggplot(bike, aes(x=holiday, y = cnt, fill ='lightpink'))+geom_boxplot()+labs(title = 'Boxplots of rentals per holiday')+theme_bw()

ggplot(bike, aes(x=holiday, y = cnt, fill =holiday))+geom_violin()+labs(title = 'Histogram of rentals per holiday')+theme_bw()


ggplot(bike, aes(x=workingday, y = cnt, fill = workingday))+geom_boxplot()+labs(title = 'Boxplots of rentals per working day')+theme_bw()


#Average rentals, per working day:
tapply(bike$cnt,bike$workingday,summary)


#Calculationg Frequency of weather situation
bike$weathersit = factor(bike$weathersit, levels =c(1,2,3),
                         labels= c("1:Clear", "2:Cloudy", "3:Rain/Snow"))

ggplot(bike, aes(x = weathersit)) + 
  geom_bar() + labs(x = 'Weather', y = 'Frequency')



#Density plot: relative frequency of rentals

ggplot(bike, aes(x = cnt)) +
  geom_density(fill = "blue", alpha = 0.5) +
  labs(title = "Density Plot of Bike Rentals", 
       x = "Number of Bike Rentals", 
       y = "Density") +
  theme_minimal()


# Create density plot for the bike rentals
ggplot(bike, aes(x = registered)) +geom_density(fill = "orange", alpha = 0.5)+
  labs(title = "Density Plot of Bike Rentals", x = "Number of Bike Rentals", y = "Density") +
  theme_minimal()



#Boxplot of rentals by day of the week

library(ggplot2)


#Variability of rentals, by weekday

bike$weekday <- factor(bike$weekday, 
                       levels = c(0, 1, 2, 3, 4, 5, 6), 
                       labels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

ggplot(bike, aes(x = weekday, y = cnt, fill = weekday)) +
  geom_boxplot() +
  labs(title = "Boxplot of Bike Rentals by Weekday", 
       x = "Day of the Week", 
       y = "Number of Bike Rentals") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



#Scartterplot of rentals versus temperature, by season
#getting total seasons
table(bike$season)


bike$season = factor(bike$season, levels =c(1,2,3,4),
                     labels = c("winter", "spring", "summer", "fall"))

ggplot(bike,aes(x= temp, y= cnt, color = 'orange'))+
  geom_point()+facet_wrap(~season)



#Summary of rentals, per season

tapply(bike$cnt, bike$season, summary)

#Pairs plot
install.packages("GGally")
library(GGally)
bike_subset = bike[,c(10,12,13,14,15)]
ggpairs(bike_subset)  

#Correlation
cor(bike_subset)

library(corrplot)
corrplot(cor(bike_subset),method = 'color')


