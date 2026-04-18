t1 <- function(a0,a1){
  (80-a0)/a1
}
t1.zero <- function(a0,a1){
  -a0/a1
}



t2 <- function(a0,a1,a2){
  out1 <- (-a1 + sqrt(a1^2 - 4*a2*(a0-80)))/(2*a2)
  out2 <- (-a1 - sqrt(a1^2 - 4*a2*(a0-80)))/(2*a2)
  
  return (c(out1,out2))
}
t2.zero <- function(a0,a1,a2){
  out1 <- (-a1 + sqrt(a1^2 - 4*a2*a0))/(2*a2)
  out2 <- (-a1 - sqrt(a1^2 - 4*a2*a0))/(2*a2)
  
  return (c(out1,out2))
}



t3 <- function(a0,a1,a2){
  -(1/a2)*log((80 - a0)/a1)
}
t3.zero <- function(a0,a1,a2){
  -(1/a2)*log(- a0/a1)
}





f0 <- function(x,a0=1){
  rep(a0,length(x))
}
f1 <- function(x,a0=0,a1=1){
  a0 + a1*x
}
f2 <- function(x,a0=0,a1=0,a2=1){
  a0 + a1*x + a2*x^2
}
f3 <- function(x,a0=0,a1=1,a2=1){
  a0 + a1*exp(-a2*x)
}
f4 <- function(x,a0=0,a1=0.0001,a2=1){
  a0 + a1*x + a2*log(0.005*x + 1)
}
f5 <- function(x,a0=1,a1=0,a2=1){
  (a0 + a1*x)*exp(-a2*x)
}
g1 <- function(t,a0,a1){
  f1(t,a0,a1) - 80
}
g2 <- function(t,a0,a1,a2){
  f2(t,a0,a1,a2) - 80
}
g3 <- function(t,a0,a1,a2){
  f3(t,a0,a1,a2) - 80
}
g4 <- function(t,a0,a1,a2){
  f4(t,a0,a1,a2) - 80
}
g5 <- function(t,a0,a1,a2){
  f5(t,a0,a1,a2) - 80
}


