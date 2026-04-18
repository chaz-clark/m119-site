f1 <- function(x){rep(100,length(x))}
f2 <- function(x){100-0.003*x}
f3 <- function(x){120-20*exp(-0.0004*x)}
f4 <- function(x){95 - 0.002*x + 2*log(18*x+100)}
f5 <- function(x){(100+0.007*x)*exp(-0.00005*x)}

f1z <- function(x){f1(x) - 75}
f2z <- function(x){f2(x) - 75}
f3z <- function(x){f3(x) - 75}
f4z <- function(x){f4(x) - 75}
f5z <- function(x){f5(x) - 75}

uniroot(f1z,c(-20000,60000))$root
uniroot(f2z,c(-20000,60000))$root
uniroot(f3z,c(-20000,60000))$root
uniroot(f4z,c(0,60000))$root
uniroot(f5z,c(0,60000))$root