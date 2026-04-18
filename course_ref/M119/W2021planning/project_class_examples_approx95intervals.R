dist <- led_time(2100)
dist1 <- led_time(24)
dist2 <- led_time(720)
dist3 <- led_time(2201)
dist4 <- led_time(4320)

mean(dist$percent_intensity*100)-2*sd(dist$percent_intensity*100)
mean(dist$percent_intensity*100)+2*sd(dist$percent_intensity*100)
# (100.2533,102.6927)

mean(dist1$percent_intensity*100)-2*sd(dist1$percent_intensity*100)
mean(dist1$percent_intensity*100)+2*sd(dist1$percent_intensity*100)
# (99.31491,101.3705)

mean(dist2$percent_intensity*100)-2*sd(dist2$percent_intensity*100)
mean(dist2$percent_intensity*100)+2*sd(dist2$percent_intensity*100)
# (99.95945,102.1952)

mean(dist3$percent_intensity*100)-2*sd(dist3$percent_intensity*100)
mean(dist3$percent_intensity*100)+2*sd(dist3$percent_intensity*100)
# (100.2681,102.714)

mean(dist4$percent_intensity*100)-2*sd(dist4$percent_intensity*100)
mean(dist4$percent_intensity*100)+2*sd(dist4$percent_intensity*100)
# (100.0117,102.499)


### Simulating data and calculating observed probability.
#set.seed(0129)
tmp <- rgamma(5000,30,9)+98.25
length(which(tmp>100.2533 & tmp<102.6927))
length(which(tmp>100.2533 & tmp<102.6927))/5000