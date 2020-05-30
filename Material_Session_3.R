# Installing & Loading the package
library(ggplot2)

# read the data
location4 <- "C:/Users/Admin/Desktop/FDP_R/Placement_Data_FDP.csv" # copy applicable path
placementgg <- read.csv(location4, stringsAsFactors = T)
head(placementgg)
colnames(placementgg)
str(placementgg)

# 1. Scatter Plot
base1 <- ggplot(placementgg, aes(x= degree_p, y = mba_p))
base1 + geom_point()
base1 + geom_point(shape = 22, color = "blue", fill = "red", size = 2) # Static
# https://cran.r-project.org/web/packages/ggplot2/vignettes/ggplot2-specs.html

# Dynamic - Make the aesthetics vary based on a variable
base1 + geom_point(aes(color = status))
base1 + geom_point(aes(shape = status))
base1 + geom_point(aes(size = status))
base1 + geom_point(aes(alpha = status))
# add additional varaibales with aesthetics
base1 + geom_point(aes(color = status, shape = gender))
base1 + geom_point(aes(color = status, shape = gender, size = workex))

# add labels
base1 + geom_point()
gg1 <- base1 + geom_point() +
  labs(title = "Scatterplot", x = "% in Degree", y = "% in MBA")
gg1
gg2 <- gg1 +
  theme(plot.title = element_text(face = 'bold.italic', colour = "blue", size = 12, hjust = 0.5),
        axis.title.x = element_text(face = 'bold', colour = "red", size = 10),
        axis.title.y = element_text(face = 'bold', colour = "red", size = 10))
gg2

# make the plot interactive
install.packages("plotly")
library(plotly)
ggplotly(gg2)

# flip x and y axis
gg2 + coord_flip()

# geom_smooth()
base1 + geom_point() + geom_smooth()
base1 + geom_point() + geom_smooth(method = "lm", se = F) # Don't add shaded confidence region
base1 + geom_smooth()
base1 + geom_smooth(aes(colour = status))
base1 + geom_point(aes(colour = status)) + geom_smooth(aes(colour = status))

# 2. Bar Chart
base2 <- ggplot(placementgg, aes(degree_t))
base2 + geom_bar()
base2 + geom_bar(aes(y= stat(prop), group=1))
base2 + geom_bar(aes(fill = degree_t)) # color the bar chart (use same variable)
base2 + geom_bar(aes(color = status))
base2 + geom_bar(aes(fill = status)) # the bars are stacked
base2 + geom_bar(aes(fill = status), position = "dodge") #side-by-side
base2 + geom_bar(aes(fill = status), position = "fill") # percenatge bar chart
base2 + geom_bar(fill = "yellow") + coord_flip()
# Beautifying
base2 + geom_bar(aes(fill = status)) + theme(legend.position = "bottom") +
  ggtitle("Bar Chart")
base2 + geom_bar(aes(fill = status), width = 0.75) +
  geom_text(stat = "count", aes(label=stat(count)), vjust = 1)
base2 + geom_bar(aes(fill = status)) + theme_bw() #theme function changes appearance

# 3. Dot Plot
ggplot(placementgg, aes(degree_p)) + geom_dotplot(binwidth = 1)

# 4. Histogram
base3 <- ggplot(placementgg, aes(degree_p))
base3 + geom_histogram()
base3 + geom_histogram(bins = 10)
base3 + geom_histogram(binwidth = 5, fill = "brown")
base3 + geom_freqpoly(binwidth = 5) #  frequency polygons use lines instead of bars
base3 + geom_histogram(binwidth = 5, fill = "brown") + geom_freqpoly(binwidth = 5)
base3 + geom_histogram(aes(fill = status), binwidth = 5) 
base3 + geom_histogram(aes(fill = status), binwidth = 5) +
  facet_wrap(~gender)

# 5. Density Plot
ggplot(placementgg) + geom_density(aes(etest_p), fill = "pink") + theme_classic()
ggplot(placementgg) + geom_density(aes(etest_p, fill = degree_t))
ggplot(placementgg) + geom_density(aes(etest_p, fill = degree_t), alpha = 0.5)

# 6. Box Plot
base4 <- ggplot(placementgg, aes(y = mba_p))
base4 + geom_boxplot(fill = "yellow")
base4 + geom_boxplot(aes(x = gender))
base4 + geom_boxplot(aes(fill = status))
base4 + geom_boxplot(aes(fill = status)) +
  facet_wrap(~gender)
base4 + geom_boxplot(aes(y = mba_p, fill = status)) +
  facet_grid(workex~gender)

# 7. Violin Plot
base4 + geom_violin(aes(x = status), fill = "green")

# 8. Pie Chart
piebar <- ggplot(placementgg, aes(x = " ", fill = degree_t)) + geom_bar(width = 1)
piebar
piechart <- piebar + coord_polar("y") + theme_void()
piechart
pie(table(placementgg$degree_t)) # using base graphics

# 9. Pairwise scatterplot matrix
install.packages("GGally")
library("GGally")
ggcorr(placementgg)
ggpairs(placementgg, columns = c(3,5,8,11,13)) # correlogram
ggscatmat(placementgg, columns = c(3,5,8,11,13), color = "status") # alternative

# quick plot
qplot(degree_p, mba_p, data = placementgg)
qplot(degree_p, mba_p, data = placementgg, colour = status)
qplot(degree_t, data = placementgg)
qplot(degree_p, data = placementgg)
qplot(y= degree_p, data = placementgg)

# saving a plot
setwd("C:/Users/Admin/Desktop/FDP_R") # copy applicable path
ggsave("myplot.pdf")
ggsave("myplot.png")


