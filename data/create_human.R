#Henna Kavaluus
#18.11.2020
#Exercise 4: 
#Technical notes to data sets:
#http://hdr.undp.org/en/content/human-development-index-hdi
#http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
  
#Reads the .csv files from data folder
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
str(gii)
dim(hd)
dim(gii)