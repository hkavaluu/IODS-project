#Henna Kavaluus
#01.12.2020
# Week 6: Data wrangling
#Data sources: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt and https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)
library(ggplot2)


#Load the data

bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=TRUE)
rats<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header=TRUE)

#Names of the variables. Structures, dimensions and summaries of two data sets
names(bprs)
str(bprs)
dim(bprs)
summary(bprs)

names(rats)
str(rats)
dim(rats)
summary(rats)

# Factor treatment & subject
bprs$treatment <- factor(bprs$treatment)
bprs$subject <- factor(bprs$subject)
rats$treatment <- factor(rats$ID)
rats$subject <- factor(rats$Group)


# Convert to long form
bprsl <-  bprs %>% gather(key = weeks, value = bprs, -treatment, -subject)
ratsl <-  rats %>% gather(key = time, value = rats, -ID, -Group)



# Extract the week number
bprsl <-  bprsl %>% mutate(week = as.integer(substr(weeks,5,5)))
ratsl <-  ratsl %>% mutate(week = as.integer(substr(time,5,5)))

# Take a glimpse at the bprsl and ratsl data
glimpse(bprsl)
glimpse(ratsl)

# summaries of new data sets
names(bprsl)
str(bprsl)
dim(bprsl)
summary(bprsl)

names(ratsl)
str(ratsl)
dim(ratsl)
summary(ratsl)


# Draw the plot
ggplot(bprsl, aes(x = week, y = bprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(bprsl$bprs), max(bprsl$bprs)))

