pacman::p_load(tidyverse, lubridate, readxl, hexbin, here)

# Before we get started with ggplot, it is useful
# to spend some time on the base R function plot()
# the function plot() has the following arguments:
#  - x: the variable on the x-axis
#  - y: the variable on the y-axis
#  - type: the type of the plot (p, l, h, etc.)
#  - main: a title for the graph
#  - sub: a subtitle 
#  - xlab: a title for the x-axis
#  - ylab: a title for the y-axis
#  - col: color for the graph
plot(mpg$displ, mpg$hwy)
plot(mpg$displ, mpg$hwy, 
     col = "red",                                # add color
     main = "My first graph in R",               # title
     xlab = "Engine displacement",               # x-axis label
     ylab = "Miles per gallon")                  # y-axis label

# let's do this with ggplot
# the syntax to ggplot is quite simple
# (we will use pipe in this exercise)
# let's say you have a data frame called df
# you can create a graph by typing:
# df %>% ggplot() + geom_THE TYPE OF PLOT YOU WANT()
#                 + SOME BELLS AND WHISTLES
# 

# Our first ggplot: scatterplot
# geom_point()

mpg %>% ggplot() +
  geom_point(aes(x = displ, y = hwy))


# let's add labels to the graph
# we will add labs() to ggplot()
mpg %>% ggplot() +
  geom_point(aes(x = displ, y = hwy)) +
  labs(x = "Displacement",
       y = "Miles per gallon")


# We will talk about five different aesthetics of a ggplot:
#  - shape
#  - colour
#  - size
#  - transparency (alpha)
#  - facets


# Let's start with a problem:
# We want to plot hwy v displ
# but want each point to be coloured by the type of car
# we will add the argument called color to geom_point()

mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, 
                           y = hwy,
                           color = class)) + 
  labs(x = "Displacement",
       y = "Miles per gallon",
       title = "A graph in ggplot",
       color = "Car type")


# Let's increase the size of the points
# the argument that we will add is: size = 
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, 
                           y = hwy,
                           color = class),
             size = 5) + 
  labs(x = "Displacement",
       y = "Miles per gallon",
       title = "A graph in ggplot")

# if you want to vary the size of the points by
# another variable, you should drag the argument size
# inside aesthetics:
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ,           
                           y = hwy,
                           color = class,
                           size = cyl)) + 
  labs(x = "Displacement",
       y = "Miles per gallon",
       title = "A graph in ggplot")



# let's change the shape of the points
# we will invoke the argument called shape = 

mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, 
                           y = hwy,
                           color = class),
             size = 5,
             shape = 18) + 
  labs(x = "Displacement",
       y = "Miles per gallon",
       title = "A graph in ggplot")


# We can also customize the transparency of the points
# The argument to be used: alpha = (a number less than 1)

mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, 
                           y = hwy,
                           color = class),
             size = 5,
             shape = 18,
             alpha = 0.6) + 
  xlab("Displacement") + 
  ylab("Miles per gallon") + 
  labs(title = "A graph in ggplot")



# let's split these graphs by 
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, 
                           y = hwy)) +
  facet_grid(~class) +
  labs(x = "Displacement",
       y = "Miles per gallon",
       title = "A graph in ggplot")



# Histogram: geom_histogram()
mpg %>% ggplot() + 
  geom_histogram(aes(x = hwy),
                 binwidth = 5)


# Let's make this histogram prettier:
# we will use fill and color options
# we can also change the theme!
mpg %>% ggplot() + 
  geom_histogram(aes(x = hwy),
                 fill = "blue",
                 color = "seagreen3",
                 binwidth = 5,
                 alpha = 0.7) +
  theme_bw()


# histogram by many variables.
# we will plot the histogram for height
# by gender
mpg %>% ggplot() + 
  geom_histogram(aes(x = hwy,
                     fill = class),
                 binwidth = 5,
                 alpha = 0.7) +
  theme_bw()



# Barplot: geom_bar()
mpg %>% ggplot() +
  geom_bar(aes(x=class)) +
  theme_bw()

# You can also color each bar..
# by the same variable by using
# fill = 
mpg %>% ggplot() +
  geom_bar(aes(x=class,
               fill = class)) +
  theme_bw()


# or by some other variable:
mpg %>% ggplot() +
  geom_bar(aes(x=class,
               fill = as_factor(cyl))) +
  theme_bw()

# plot proportion instead of count
mpg %>% ggplot() + 
  geom_bar(mapping = aes(x = class,
                         y = stat(prop),
                         group = 1))

# you can also plot the statistical summary
# let's say you want to plot the min, max, and mean.
# example: plot stats for miles per gallon by car class.
mpg %>% ggplot() + 
  stat_summary(
    mapping = aes(x = class, y = hwy),
    fun.min = min,
    fun.max = max,
    fun = mean
  ) +
  theme_bw()

# stacked barplot
# plot the type of car by manufacturer
mpg %>% ggplot() + 
  geom_bar(mapping = aes(x = class, 
                         fill = manufacturer)) +
  theme_bw()

# flipped bar plot
mpg %>% ggplot() +
  geom_bar(aes(x=class,
               fill = class)) +
  coord_flip() +
  theme_bw()

# pie chart
mpg %>% ggplot() +
  geom_bar(aes(x=class,
               fill = class)) +
  coord_polar() +
  theme_bw()


# line plot
ggplot(economics, aes(date, unemploy)) +
  geom_line() +
  theme_bw()

#-----------------------------------------------#
# The rest of the code is for more advanced users
# Based on R4DS chapter 28.

# 1. changing the axis labels
#    we will use scale_y_continuous()
#    and change the argument:
#    breaks = 
mpg %>% ggplot() +
  geom_point(aes(displ, hwy)) +
  scale_y_continuous(breaks = seq(15, 40, by = 5)) +
  theme_bw()

#  suppress all the axis labels
mpg %>% ggplot() +
  geom_point(aes(displ, hwy)) +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL) +
  theme_bw()

# 2. Legend layout
base <- mpg %>% ggplot() +
  geom_point(aes(displ, hwy,
                 colour = class)) +
  theme_bw()

base + theme(legend.position = "left")
base + theme(legend.position = "top")
base + theme(legend.position = "bottom")
base + theme(legend.position = "right") # the default


# more legend cleanup
# guides
base + 
  theme(legend.position = "bottom") +
  guides(colour = guide_legend(nrow = 1, 
                               override.aes = list(size = 4)))


# 3. Replacing scale

ggplot(diamonds, aes(carat, price)) +
  geom_bin2d()

ggplot(diamonds, aes(log10(carat), log10(price))) +
  geom_bin2d()


df <- tibble(
  x = rnorm(10000),
  y = rnorm(10000)
)
ggplot(df, aes(x, y)) +
  geom_hex() +
  coord_fixed()

ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis() +
  coord_fixed()

# 4. Zooming in

ggplot(mpg, mapping = aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth() +
  coord_cartesian(xlim = c(5, 7), ylim = c(10, 30)) +
  theme_bw()

mpg %>%
  filter(displ >= 5, displ <= 7, hwy >= 10, hwy <= 30) %>%
  ggplot(aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth() +
  theme_bw()


# Load batting data
# for India [Years: 2016 - 2019]
ind.odi.bat <- readxl::read_xlsx(here("./data/odi_batting_ind.xlsx"))
# Plot Runs Scored by each batsman by each year
# Make sure that you are visualizing the data
# such that each player has a horizontal bar
# representing the number of runs scored.
# Three years must appear as separate columns
ind.odi.bat %>%
  ggplot() + 
  geom_col(aes(x = Player, y = Runs),
           fill = "#56B4E9") + 
  coord_flip() +
  facet_grid(.~Year) +
  labs(x = "",
       y = "") 
