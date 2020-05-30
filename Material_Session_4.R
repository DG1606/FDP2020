library(dplyr)
library(ggplot2)

path <- "C:/Users/Admin/Desktop/FDP_R/Placement_Data_FDP.csv" # copy applicable path
placement <- read.csv(path, stringsAsFactors = T)
str(placement)
colnames(placement)
placement$sl_no <- NULL # remove sl.no column
# split the dataset
placementnum <- select(placement, ends_with("_p"), salary) 
placementcat <- select(placement, -(ends_with("_p")), -salary)
levels(placement$status)
unique(placement$status) # alternative
placedset <- filter(placement, status == "Placed")
placedset <- na.omit(placement) # alternative
notplacedset <- subset(placement, status == "Not Placed")

# basic exploration for NAs in the dataset
class(placement)
anyNA(placement) # check for NAs
is.na(placement)
colSums(is.na(placement))
lapply(placement, anyNA)

# summary statistics

# measures of central tendency
mean(placement$degree_p) # Describing center of the data 
placement %>% group_by(degree_t) %>% summarise(mean(degree_p))
group_by(placement, degree_t, status) %>% summarise(mean(degree_p))
aggregate(degree_p ~ status + degree_t, placement, FUN = mean) # alternative
sapply(placementnum, mean) # add na.rm if necessary
apply(placementnum, 2, mean) # other apply family function. 1 indicates rows, 2 indicates columns
lapply(placementnum, mean)
tapply(placement$degree_p,placement$gender, mean)
median(placement$salary, na.rm = T) # Dealing with missing values 
quantile(placement$salary, na.rm = T)
quantile(placement$salary, 0.25, na.rm = T) # Customized quantiles
fivenum(placement$salary, na.rm = T) # same as quantile for odd no. of observations

# The core package in R doesn't have a function for calculating the mode
lsr::modeOf(placement$salary)

# other means
colMeans(placementnum)
rowMeans(placementnum[ , -6])

# skewness and kurtosis
psych::skew(placementnum) # value close to 0 indicates data is symmetrical
colnames(placementnum)
ggplot(placementnum, aes(salary)) + geom_histogram(binwidth = 25000, na.rm = T)
ggplot(placementnum, aes(mba_p)) + geom_histogram(binwidth = 5)

psych::kurtosi(placementnum) # negative-flat, positive-pointy, zero-just enough pointy
ggplot(placementnum, aes(ssc_p)) + geom_histogram(bins = 10)
ggplot(placementnum, aes(hsc_p)) + geom_histogram(bins = 10)

# mean v/s median
mean(placement$salary, na.rm = T)
median(placement$salary, na.rm = T)
mean(placement$salary, trim = 0.10, na.rm = T) #Trimmed mean. Trimmed from each end

# measures of variation
min(placement$mba_p)
max(placement$mba_p)
range(placement$mba_p)
IQR(placement$salary, na.rm = T)
sd(placement$degree_p) # this uses denominator n-1
var(placement$degree_p) # this uses denominator n-1
mad(placement$degree_p) # median absolute deviation


# Summarizing a variable
summary(placement$mba_p)

# Summarizing a complete dataset
summary(placementnum)
summary(placement)
psych::describe(placementnum)

# Describing Categories
table(placementcat$status)
sapply(placementcat, table)
table(placementcat$specialisation, placementcat$status) # Creating a two-way table 
mytab <- with(placementcat, table(specialisation, status)) # alternative
mytab
class(mytab)
addmargins(mytab)
prop.table(mytab) # proportion based on total number
prop.table(mytab, margin = 1) # proportions over rows and columns
# visualisation
df_mytab <- as.data.frame(mytab)
df_mytab
ggplot(df_mytab, aes(x=specialisation, y = Freq)) +
  geom_bar(aes(fill = status), stat = "identity")
# Note - when heights of the bars have to represent values (freq) in the data, 
# use stat="identity" and map a value to the y aesthetic
ggplot(placement, aes(specialisation)) + geom_bar(aes(fill=status)) # directly from the file

tab3 <- xtabs(~gender+specialisation+status, placement) # 3-way crosstabs
tab3
ftable(tab3)

# Tracking correlations
cor(placement$degree_p, placement$mba_p)
ggplot(placement, aes(degree_p, mba_p)) + geom_point()
corcomplete <- cor(placementnum) # correlations for multiple variables
corcomplete
corcomplete["ssc_p", "mba_p"]
placementnum %>% cor()  # alternative
# Dealing with missing values 
cor(placement$mba_p, placement$salary, use="complete.obs") 
cor(placementnum, use = "pairwise.complete.obs")
