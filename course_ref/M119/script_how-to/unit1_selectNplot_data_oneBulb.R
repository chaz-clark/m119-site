devtools::install_github('byuidatascience/data4led')
library(data4led)

head(led_study)
tail(led_study)
dim(led_study)
  #8888 x 4
ids <- unique(led_study$id)
length(ids)
  #202
dim(led_study)[1]/length(ids)
  #44
led_study$id[1:50]

plot(led_study$hours[1:10],led_study$percent_intensity[1:10])
plot(x = led_study$hours, y = led_study$percent_intensity)
plot(x = led_study$hours[1:44], y = led_study$percent_intensity[1:44], xlab = 'Time (in hours)', ylab = "Lumen Intensity (% of initial)", ylim = c(0.5,1.03), pch = 18)

bulb <- sample(ids,1)
idx <- which(led_study == bulb)
plot(x = led_study$hours[idx], y = 100*led_study$percent_intensity[idx], xlab = 'Time (in hours)', ylab = "Lumen Intensity (% of initial)", ylim = c(95,105), pch = 18)

