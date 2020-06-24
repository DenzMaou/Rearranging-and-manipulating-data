getwd()
setwd("C:/Users/USER/Desktop")


#get the data
catfish<- read.csv ("Catfish.csv", header = TRUE)
treatment<- read.csv ("Treatment.csv", header = TRUE)

#Exercise 1: Reshaping data frames
#a)
str(catfish)
head(catfish)
str(treatment)
head(treatment)

#b)
install.packages("tidyr")
library(tidyr)

catfish_long<- gather(catfish,Months, weight, 7:8)
str(catfish_long)
head(catfish_long)

catfish_long_wide<-spread(catfish_long,Months, weight)
str(catfish_long_wide)
head(catfish_long_wide)

#Exercise 2: Adding new variables
#a)
catfish_long$sqrtweight<-sqrt(catfish_long$weight)
head(catfish_long)

#b)
install.packages("dplyr")
library(dplyr)


catfish<-unite(catfish, "Species", c(Genus, Species), sep = "_", remove = TRUE)
str(catfish)
head(catfish)

#Exercise	3: Combining	data	frames
#a)
Catfish_Treatment_inner<- inner_join(catfish_long, treatment, by = c("Tank"))
str(Catfish_Treatment_inner)

Catfish_Treatment_left<- left_join(catfish_long, treatment, by = c("Tank"))
str(Catfish_Treatment_left)

Catfish_Treatment_right<- right_join(catfish_long, treatment, by = c("Tank"))
str(Catfish_Treatment_right)

#Exercise	4: Subsetting	data
#a)
bigFemale=subset(catfish_long, weight >72 & Sex == "Female")
str(bigFemale)

#b)
Males=subset(catfish_long, weight <= 20 | weight > 70 & Sex == "Male")
str(Males)
head(Males)
tail(Males)

#c)
catfish_long.65 <- sample_frac(catfish_long, size = 0.65, replace = FALSE)

#Exercise	5: Summarsing	data with	dplyr
#a)
summarise(Catfish_Treatment_inner, mean.weight=mean(weight))
summarise(Catfish_Treatment_inner,
          mean.weight=mean(weight,
          min.weight=min(weight),
          max.weight=max(weight),
          med.weight=median(weight),
          sd.weight=sd(weight),
          var.weight=var(weight),
          n.weight=n(),)

#b)   
str(Catfish_Treatment_inner)
Catfish_Treatment_inner_food <- group_by(Catfish_Treatment_inner, Food)
str(Catfish_Treatment_inner_food$Treatment1)
head(Catfish_Treatment_inner_food)
Summary.food <- summarise(Catfish_Treatment_inner_food,
                             mean.weight=mean(weight),
                                           min.weight=min(weight),
                                           max.weight=max(weight),
                                           med.weight=median(weight),
                                           sd.weight=sd(weight),
                                           var.weight=var(weight),
                                           n.weight=n())
                          
as.data.frame(Summary.food)
