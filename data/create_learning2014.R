#Henna Kavaluus
#02.11.2020
# Week2: Data wrangling
#reference to the data source(http://www.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt)


# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# This explores the data set dimensions;the first is number of rows, the second is the number of columns
dim(lrn14) 

# Explores the structure of the data
str(lrn14)
# Analysis dataset

#Varibles
gender<-lrn14$gender
age<-lrn14$Age
attitude<-lrn14$Attitude
deep<-lrn14$deep
stra<-lrn14$stra
surf<-lrn14$surf
points<-lrn14$Points



# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
attitude_questions <- c("Da","Db","Dc","Dd","De","Df","Dg","Dh","Di","Dj")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)


# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# select the columns related to attitude and create column 'attitude'
attitude_columns <- select(lrn14, one_of(attitude_questions))
lrn14$attitude <- rowMeans(attitude_columns)


# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the structure of the new dataset
str(learning2014)

# Filtering observations where the exam points variable is zero.
learning2014 <- filter(learning2014, Points != "0")
str(learning2014)

# Save the analysis dataset to the ‘data’ folder
write.csv(learning2014, 'C:/Users/Henna/OneDrive/Asiakirjat/OPEN SCIENCE/IODS-project/data/learning2014.csv', append = FALSE, quote = TRUE, sep = " ", eol = "\n", na = "NA", dec = ".", row.names = FALSE,col.names = TRUE, qmethod = c("escape", "double"),fileEncoding = "")

read.csv('C:/Users/Henna/OneDrive/Asiakirjat/OPEN SCIENCE/IODS-project/data/learning2014.csv')
