f.1der <- function(x){exp(-x) - x*exp(-x)}
uniroot(f.1der,c(0.5,1.2))$root


g.1der <- function(x){1 - 2*x}
uniroot(g.1der,c(0,2))$root


c.1der <- function(x){3*x^2 - 1}
uniroot(c.1der,c(-1,0))$root
uniroot(c.1der,c(0,1))$root
sqrt(1/3)


b.1der <- function(x){210*x*(1-x)^13 + 105*x^2*(-13)*(1-x)^12}
uniroot(b.1der,c(0,1))$root
uniroot(b.1der,c(0.01,1))$root
uniroot(b.1der,c(0.01,0.9))$root
2/15


nleqslv(0.1,b.1der)$x
nleqslv(0.5,b.1der,control=list(ftol=1e-70,maxit=300))$x
k <- seq(-0.1,1.1,0.1)
sol <- rep(7,length(k))
for(i in 1:length(k)){
  sol[i] <- nleqslv(k[i],b.1der,control=list(ftol=1e-70,maxit=300))$x
}
sol