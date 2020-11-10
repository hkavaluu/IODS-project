#Henna Kavaluus
#10.11.2020
#Exercise 3: Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance).

#Reads the .csv files from data folder
por<-read.csv('C:/Users/Henna/OneDrive/Asiakirjat/OPEN SCIENCE/IODS-project/data/student-por.csv',sep = ";")
math<-read.csv('C:/Users/Henna/OneDrive/Asiakirjat/OPEN SCIENCE/IODS-project/data/student-mat.csv',sep = ";")

# Explores the structure and dimensions of the data
dim(por)
str(por)
dim(math)
str(math)


# Join two dataset
# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# see the new column names
colnames(math_por)

# glimpse at the data
glimpse(math_por)
dim(math_por)
str(math_por)
# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the alc data
glimpse(alc) 
dim(alc)

#Write .csv file
write.csv(alc, 'C:/Users/Henna/OneDrive/Asiakirjat/OPEN SCIENCE/IODS-project/data/alc.csv', append = FALSE, quote = TRUE, sep = " ", eol = "\n", na = "NA", dec = ".", row.names = FALSE,col.names = TRUE, qmethod = c("escape", "double"),fileEncoding = "")

