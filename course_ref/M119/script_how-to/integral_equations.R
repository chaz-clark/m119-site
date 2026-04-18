#Given pdf f(x) = k(4-x^2) for -2 \leq x \leq 2, find k.
f <- function(x) {4-x^2}
    integrate(f, lower = -2, upper = 2)
f.eq <- function(k){k*integrate(f, lower = -2, upper = 2)$value-1}
uniroot(f.eq,c(-10,10))$root


f.gamma <- function(x,r,l){
  l^r/gamma(r)*x^(r-1)*exp(-l*x)
}
  #integrate(f.gamma, lower = 0, upper = Inf)
  #Doesn't work since r and l, the parameters, are not defined.
  