# Reading data - I have to "private" it/hide it for now, unforch.
library(tidyverse)
df3 <- read.csv("./private_data/df3.csv")

# Plotting
plot <-  ggplot() +

  ## Points
  ## ## There are probably better ways to do this.
  ## ## right now, this is basically multiplying df3 times 3, so there are "more" points as data for the plot.
  geom_point(data=bind_rows(
    bind_rows(df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random,
                       hour = hour+abs(rnorm(1))),
              df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random,
                       hour = hour+abs(rnorm(1)))),
    bind_rows(df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random,
                       hour = hour+abs(rnorm(1))),
              df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random,
                       hour = hour+abs(rnorm(1))))),

    ## Variables used for actual points.
    aes(x=Wh_random,y=hour, colour=wday),show.legend = FALSE) +


  ## Lines
  ## ## Same as above. But too scared to touch the script as is right now. It works.
  geom_line(data=bind_rows(
    bind_rows(df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random),
              df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random)),
    bind_rows(df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random),
              df3 %>% rowwise() %>%
                mutate(Wh_random = abs(rnorm(1,mean=500,sd=500)),
                       Wh = Wh+Wh_random))),

    ## Variables used for lines.
    aes(x=Wh_random,y=hour, group=wday, size=hour ),
    linetype="solid",alpha=0.3,show.legend = FALSE) +

  ## Theme reated
  scale_x_continuous(limits = c(0,500))+
  theme_void()+

  ## Changes colors for points iirc
  scale_color_viridis_d() +

  ## Theme reated
  coord_polar()

# Visualize
plot

# Export
ggsave("./plot.png",plot,
       width = 8, height =8,units="in",device = "png",dpi=300)
