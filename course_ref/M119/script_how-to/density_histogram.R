x <- rnorm(30000)

ggplot(as.data.frame(x=x),aes(x))+
  geom_histogram(aes(y=..density..))