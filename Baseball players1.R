### Example: Do Baseball players gain weight as they age? 
#installation of package frwqparcoord it contains mlb dataset (Major League Baseball player data)

install.packages("freqparcoord")

#loads the package into R session
library(freqparcoord)

#loads the dataset
data("mlb")

#prints first few rows of dataset
head(mlb)

#Scatterplot of weight and age 
#Assigning the variables x and Y

y = mlb$Weight
x = mlb$Age

#Scatterplot of y and x
#geom_point points to the plot representing individual players
#  geom_smooth(method = 'lm') adds the Linear regression to the method 
ggplot(mlb, aes(x = Age, y = Weight))+ geom_point() +
  geom_smooth(method = 'lm')



#Inspecting correlation

#creating the subset of columns of numeric values (Age, Height, Weight)
mlb_numeric = mlb[,c(4,5,6)]

#libraray corrplot used for visualizing the correlation matrices.
library(corrplot)

#calculates the correlation matrix of numeric variables
cor(mlb_numeric)

corrplot(cor(mlb_numeric), method = 'number')



#Computing the linear regression
#stores the number of rows in mlb dataset
n = nrow(mlb)

#computes the beta1: slope of linear regression line between weight and age 
beta1 = (sum(x*y) - n*mean(x)*mean(y))/(sum(x^2) - n*mean(x)^2)
beta1

#computes the intercept of regression line using formula. 
beta0 = mean(y) - beta1*mean(x)
beta0



#Computing the slope using the correlation
#calculates the correlation between weight and age
cor_xy = cor(mlb$Weight, mlb$Age)

#computes the covariance between weight and age
cov_xy = cor_xy*sd(mlb$Weight)*sd(mlb$Age)

#calculates the beta1
cov_xy/var(mlb$Age)
beta1


#5Interpretation of parameters


#beta1: 
#X age (years): for one unit increase of y (1 year), the weight of the player
#is expected to increase by beta1

# Interpretation of beta1:
cat("Interpretation: For every additional year of age, the player's weight increases by", beta1, "units.")


# Interpretation of beta0:
cat("Interpretation: The intercept is", beta0, ", which represents the expected weight of a player when their age is 0 (though unrealistic in this context).")


#Scatterplot with added regression line
# Scatterplot with the linear regression line
ggplot(mlb, aes(x = Age, y = Weight)) +
  geom_point() +  # Plot the scatter points
  geom_smooth(method = "lm", color = "blue") +  # Add the regression line
  labs(title = "Scatterplot of Weight vs. Age with Regression Line",
       x = "Age (Years)",
       y = "Weight (Pounds)") +
  theme_minimal()




#What is the expected weight of a player aged 55?
expected_weight_55 = beta0 + beta1 * 55
expected_weight_55

expected_weight_20 = beta0 + beta1 * 20
expected_weight_20


#Bonus question: do our conclusions change depending on the position?
library(dplyr)
#mlb %>% group_by(Position): Groups the mlb dataset by player position.
mlb %>% group_by(Position) %>% summarise(cor = cor(Weight, Age))

#Calculates the correlation between Weight and Age for each group (position) of players.
ggplot(mlb, aes(x = Age, y = Weight, color=Position))+geom_point()+
  facet_wrap(~Position)

