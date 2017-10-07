d <- read.csv("D1FBSfootball.csv")
d <- subset(d, Team != "Hawai'i")

library(ggplot2)
library(ggmap)
library(mapdata)
library(maps)
library(dplyr)
library(ggrepel)

colors = c("magenta", ## ACC
           "navyblue", ## American
           "steelblue", ## Big 12
           "darkorange", ## Big Ten
           "red", ## C-USA
           "black", ## Independent
           "purple", ## MAC
           "darkred", ## Mountain West
           "green", ## Pac-12
           "forestgreen", ## SEC
           "gray30")  ## Sun Belt

states <- map_data("state")
statemap <- ggplot(states, aes(x=long, y=lat, group=group)) + 
  geom_polygon(fill = "white",color="gray50") + coord_map()
team_map <- statemap + 
  geom_point(d, mapping = aes(x=long, y=lat, group=Conference, color=Conference)) +
  theme_nothing(legend=TRUE) +
  ggtitle("NCAA Football Teams, Division I FBS") +
  geom_text_repel(mapping = aes(x=long, y=lat, 
                                group=Conference, color=Conference, label=Team), 
                  data=d, size=3) +
    scale_color_manual(values=colors) +
    theme(legend.title=element_blank(),
          legend.background=element_blank(),
          legend.text = element_text(color = "black"),
          legend.justification = "left",
          legend.position = c(0,0.1),
          legend.direction = "horizontal",
          plot.title = element_text(hjust = 0.5))