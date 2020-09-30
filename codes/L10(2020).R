#' This code covers some tips and tricks on
#' data visualization and some basics of 
#' creating pretty tables in R.
#' 

# Bar Chart Examples
pacman::p_load(tidyverse)


# Example1 : Movies database
moviesDB <- read_csv("./data/moviesDB2019.csv")
names(moviesDB)

# we are interested in top 10 movies of 2019
# the columns that we are going to work on:
#  - worldwide
#  - release_group
#  - rank

moviesDBsub <- moviesDB %>%
  select(worldwide, release_group, rank)

# ready to produce a bar chart?
# we are going to use geom_col
moviesDBsub %>% 
  slice(1:10) %>% 
  ggplot() + 
  geom_col(aes(x=rank, y=worldwide))


moviesDBsub %>% mutate(Worldwide = 
                      as.numeric(gsub("\\,","", 
                                      gsub("\\$","",worldwide)))/1000000000) %>%
  arrange(-Worldwide) %>%
  slice(1:8) %>%
  ggplot() + 
  geom_col(aes(x = reorder(release_group, -rank), 
               y = Worldwide),
           fill = "skyblue") +
  labs(x = "",
       y = "Box-office Earnings (in $ billions)",
       caption = "data source: https://www.boxofficemojo.com/year/world/2019/") + 
  coord_flip() + 
  theme(legend.position = "none",
        axis.text.y = element_text(face="bold", colour = "black"),
        axis.text.x = element_text(face = "bold", colour = "black"))

# Example2: Time Use in Indian Households
# read the article here:
# https://m.hindustantimes.com/india-news/women-do-most-of-the-heavy-lifting-in-indian-households-nso-report/story-EKQpkpQLEpXS85vFePH5NP_amp.html?__twitter_impression=true
# We are going to reproduce one of the charts from the story. 

# Chart 1
# We will do a stacked bar chart.

data1 <- read_csv("./data/TimeUse01.csv")
# let's transform this data for plotting
data1.long <- data1 %>%
  pivot_longer(2:7, names_to = "Activity", values_to = "Percent") %>%
  mutate(Gender = X.1)
# generate a bar chart
data1.long %>% 
  ggplot(aes(x = Activity, y = Percent)) + 
  geom_bar() # won't run!

# we need to add `fill =` argument
data1.long %>% 
  ggplot(aes(x = Activity, y = Percent, fill = Gender)) + 
  geom_bar() # won't run!


# we need to do the following
#  - `stat = "identity"`
# why? because by default bar charts
# in ggplot assume that there's only
# x variable to be defined, and y-axis
# is to be automatically plotted as count.
# default setting is:
# `geom_bar(stat = "bin")`
data1.long %>% 
  ggplot(aes(x = Activity, y = Percent, fill = Gender)) + 
  geom_bar(stat = "identity")

# okay, but the bars are stacked on top of each other
# let's change this by modifying the argument called
# `position` in `geom_bar()`
# we will change it to:
# `position = position_dodge()`


# Now we are going to use a different color scheme for the bars
# we will deploy: `scale_color_manual`
# which has two arguments:
#           1. `values`: where you will enter names of colours
#           2. `aesthetics`: you will tell R to add those colours
data1.long %>% 
  ggplot(aes(x = Activity, y = Percent, fill = Gender)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_color_manual(values = c("#4B0082", "skyblue"),
                     aesthetics = c("colour", "fill"))

# Now, we are almost done. Two things need fixing:
#                a) The x-axis ticks are not visible
#                b) Title?
#                c) Theme?
#                d) Numbers added to bars?

# step 1: flip axes using `coord_flip`
# step 2: remove labels using `labs`
data1.long %>% 
  ggplot(aes(x = Activity, y = Percent, fill = Gender)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_color_manual(values = c("#4B0082", "skyblue"),
                     aesthetics = c("colour", "fill")) + 
  coord_flip()+ # this will rotate the axes
  labs(x = "",
       y = "",
       fill = "",
       title = "Indian women spend eight times as much time as men in unpaid domestic and caregiving services") # Don't want labels

# step 3: add numbers right next to the bars
# we will use `geom_text`
# the arguments that will add are:
#   - `aes(label = )`: the column you want to print
#   - `colour`: text colour
#   - `position`: adjust the position of the text
#   - `hjust = 0`: alignment tricks!

data1.long %>% 
  ggplot(aes(x = Activity, y = Percent, fill = Gender)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_color_manual(values = c("#4B0082", "skyblue"),
                     aesthetics = c("colour", "fill")) + 
  coord_flip()+ # this will rotate the axes
  labs(x = "",
       y = "",
       fill = "",
       title = "Indian women spend eight times as much time as men in unpaid domestic and caregiving services")+ # Don't want labels
  geom_text(aes(label = Percent), color = "maroon",
            position = position_dodge(width=1),
            hjust = 0,
            size = 4,
            fontface = "bold")+
  theme_minimal() 

# step 4: customize theme
# remove the x-axis ticks
# remove the background grids.
data1.long %>% 
  ggplot(aes(x = Activity, y = Percent, fill = Gender)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_color_manual(values = c("#4B0082", "skyblue"),
                     aesthetics = c("colour", "fill")) + 
  coord_flip()+ # this will rotate the axes
  labs(x = "",
       y = "",
       fill = "",
       title = "Indian women spend eight times as much time as men in unpaid domestic and caregiving services")+ # Don't want labels
  geom_text(aes(label = Percent), color = "maroon",
            position = position_dodge(width=1),
            hjust = 0,
            size = 4,
            fontface = "bold")+
  theme_minimal()+
  theme(panel.grid.major = element_blank(), # remove b/g grid
      panel.grid.minor = element_blank(),   # remove b/g grid
      axis.text.x = element_blank(),        # remove x-axis ticks
      axis.text.y = element_text(face = "bold"), # bold y-axis ticks
      plot.title = element_text(size=16, hjust=1)    # large font size for title
      )

# Exercise:
# how can you recreate the exact chart in the article?
# you can start off with the code below.
# can you add percent value to each activity type
# on the bars?
ggplot(data1.long, aes(fill=factor(Activity), y=Percent, x=Gender)) + 
  geom_bar(stat="identity") +
  viridis::scale_fill_viridis(discrete = T) +
  guides(colour = guide_legend(nrow = 1)) + 
  coord_flip() +
  labs(x = "",
       y = "",
       fill = "",
       title = "Indian women spend eight times as much time as men in unpaid domestic and caregiving services")+ # Don't want labels
  theme_bw() + 
  theme(legend.position = "top") +
  theme(legend.position = "top",            # legend at the top
        panel.grid.major = element_blank(), # remove b/g grid
        panel.grid.minor = element_blank(),   # remove b/g grid
        axis.text.x = element_blank(),        # remove x-axis ticks
        axis.text.y = element_text(face = "bold"), # bold y-axis ticks
        plot.title = element_text(size=16, hjust=0.1)    # large font size for title
  )

##########################################################

# Creating tables in R 

# You have a lot of options
# - stargazer
# - kableExtra
# - gt

# In this class, we will focus on gt and kableExtra

pacman::p_load(kableExtra, gt, glue,
               here,tidyverse, data.table)


# Consider the table you created in assignment 2.
cricdata <- read_csv("assignments/IndBatRec.csv") %>%
  dplyr::rename(hundreds = `100`,
                fifties = `50`,
                ducks = `0`,
                fours = `4s`,
                sixes = `6s`)


# Max number of sixes (decadewise)

cricdata %>% 
  filter(Year >=1980) %>%
  mutate(decade = case_when(Year >= 1980 & Year < 1990 ~ "1980s",
                            Year >= 1990 & Year < 2000 ~ "1990s",
                            Year >= 2000 & Year < 2010 ~ "2000s",
                            Year >= 2010 & Year < 2020 ~ "2010s")) %>%
  group_by(decade, Player) %>%
  dplyr::summarize(sixes_tot = sum(sixes, na.rm = T)) %>%
  arrange(-sixes_tot) %>%
  slice(1) -> max_sixes


# We will create a nice table to present this output
maxSixesTbl <- max_sixes %>% gt()


# Okay this is nice, but we want the table to have a nice title
# Make a display table with the `islands_tbl`
# table; put a heading just above the column labels
maxSixesTbl <- 
  max_sixes %>%
  gt() %>%
  tab_header(
    title = "Maximum Number of Sixes by a Player",
    subtitle = "1980-2019"
  )

# Okay, how about bold title and italicised subtitle?
maxSixesTbl <- 
  max_sixes %>%
  gt() %>%
  tab_header(
    title = md("**Maximum Number of Sixes by a Player**"),
    subtitle = md("*1980-2019*")
  )

# Adding a footer
maxSixesTbl <- 
  max_sixes %>%
  gt() %>%
  tab_header(
    title = md("**Maximum Number of Sixes by a Player**"),
    subtitle = md("*1980-2019*")
  ) %>%
  tab_source_note(
    source_note = md("Source: *espncricinfo*"))

# add a note to your table
maxSixesTbl <- 
  max_sixes %>%
  gt() %>%
  tab_header(
    title = md("**Maximum Number of Sixes by a Player**"),
    subtitle = md("*1980-2019*")
  ) %>%
  tab_footnote(
    footnote = "My favourite batsman",
    locations = cells_body(
      columns = vars(Player),
      rows = 2)
  )


