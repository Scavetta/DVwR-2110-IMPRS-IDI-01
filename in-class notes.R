# Intro to ggplot2
# Rick Scavetta
# 28.10.2021
# Data Viz workshop

# load packages
library(tidyverse)

# optional:
library(RColorBrewer)
library(Hmisc)
library(munsell)

# Colors ----
display.brewer.pal(9, "Blues")
brewer.pal(9, "Blues")
# Just take specific colors; 4th, 6th and 8th:
myBlues <- brewer.pal(9, "Blues")[c(4,6,8)]
myCol <- brewer.pal(9, "Set1")[2:4]
plot_hex(myCol)


# The "hexdecimal" (16)  codes
# base 10: 0- 9
# 00 = lowest, 99 = highest

# base 16: 0 - 9, A - F
# 00 - FF (instead of 00 - 99 10^2 = 100)

# 2-digits = 16^2 = 256
# 00 = lowest
# FF
## 
256*256*256 # 16.8M colors
# RRGGBB 

plot_hex(c("#000000", # Black 
           "#5e638c",
           "#B1DA66", # From color picker
           "#FF0000", # Red
           "#00FF00", # Green
           "#FFFF00", # Yellow
           "#FFFFFF")) # White
# colors()

# Plotting challenge:
# first three layers: data, aes, geom
# If you really want to see the data in your environment run:
data(iris)
# and then click on the "<promise>" object

myCol_named <- c("versicolor" = "#377EB8",
                 "virginica" = "#4DAF4A",
                 "setosa" = "#984EA3")
myCol # Unnamed characteter vector
myCol_named # named chr vector

# Basic plot:
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(position = "jitter", alpha = 0.65, shape = 16) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = myCol_named) +
  # scale_x_continuous(limits = c(4,8), expand = c(0,0)) +
  # scale_y_continuous(limits = c(1,5), expand = c(0,0)) +
  coord_equal(xlim = c(4,8), ylim = c(1,5), expand = 0) +
  labs(title = "More Iris!", 
       subtitle = "A nice example", 
       caption = "Anderson, 1931", 
       x = "Sepal Length (cm)",
       y = "Sepal Width (cm)", 
       color = "Species") +
  theme_classic() +
  theme(rect = element_blank(),
        legend.position = c(0.8, 0.85),
        legend.background = element_rect(color = "pink")) +
  NULL

ggsave("myPlot.png", width = 15, height = 15, unit = "cm")
ggsave("myPlot.pdf", width = 15, height = 15, unit = "cm")

# Getting small multiples
# facet_*()
# Basic plot:
# "wrap" for a categorical variable with many classes (levels) 
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(position = "jitter", alpha = 0.65, shape = 16) +
  facet_wrap(~ Species, ncol = 1) +
  NULL

ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(position = "jitter", alpha = 0.65, shape = 16) +
  facet_grid(. ~ Species) +
  NULL

ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(position = "jitter", alpha = 0.65, shape = 16) +
  facet_grid(Species ~ .) +
  NULL


# Assigning color
# scale_color_brewer(palette = "Dark2") +
# scale_color_manual(values = myCol) +

# Dealing with overpotting:
# i.e. point on top of each other and we can't see the "real" distribution
# Change point size
# Change the shape = hollow
# Change the alpha = transparency
# Change the position = jittering

library(car) # See "R companion to applied regression" ("car")
glimpse(Vocab) # 30,351 obs
ggplot(Vocab, aes(education, vocabulary)) +
  geom_point()

# jitter with geom_jitter() easy and convenient
ggplot(Vocab, aes(education, vocabulary)) +
  geom_jitter(alpha = 0.15, shape = 16, size = 0.5)

# jitter with geom_jitter() easy and convenient, not flexible
ggplot(Vocab, aes(education, vocabulary)) +
  geom_point(position = "jitter", alpha = 0.15, shape = 16, size = 0.5)

# More flexible: use a function
posn_j <- position_jitter(width = 0.25, height = 0.25, seed = 136)

ggplot(Vocab, aes(education, vocabulary)) +
  geom_point(position = posn_j, alpha = 0.15, shape = 16, size = 0.5)

# overplotting because of lots of data:
ggplot(diamonds, aes(carat, price, color = clarity)) +
  geom_point()

# change size and alpha:
ggplot(diamonds, aes(carat, price, color = clarity)) +
  geom_point(alpha = 0.5,
             shape = ".")


# AESTHETICS = appear in aes(),
#            = MAPPING a variable onto a "scale" (aka axis)
# ATTRIBUTES = appear in a geom_*()
#            = SETTING how a geom "looks"
# Attributes override aesthetics!
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(color = "pink") +
  NULL











