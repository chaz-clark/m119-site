library(data4soils)
Ng <- cfbp_fpjuliet$ng



###Uniform###
#Mathematica Commands
#m1 = Integrate[x/(b - a), {x, a, b}]
#Integrate[(x - m1)^2*(1/(b - a)), {x, a, b}]
M <- mean(Ng)
V <- var(Ng)
M
V
sqrt(V)


a <- c1 - sqrt(3*c2)
#> a
#[1] -2.947476
b <- c1 + sqrt(3*c2)
#> b
#[1] 8.530756

#Integrate[1/(8.530756 - (-2.947476)), {x, 0.1, 0.3}]
#Integrate[1/(8.530756 - (-2.947476)), {x, 0.5, 8.530756}]
#Solve[Integrate[1/(8.530756 - (-2.947476)), {t, -2.947476, x}] == 0.99, x]
a+0.99*(b-a)
#[1] 8.415974

f.unif <- function(x,a,b){
  rep(1/(b-a),length(x))
}





###Normal###
#Mathematica Commands
#Integrate[x*Exp[-(x - \[Mu])^2/(2*\[Sigma]^2)]/(Sqrt[2*\[Pi]*\[Sigma]^2]), {x, -Infinity, Infinity}]
#Integrate[(x - \[Mu])^2*Exp[-(x - \[Mu])^2/(2*\[Sigma]^2)]/(Sqrt[2*\[Pi]*\[Sigma]^2]), {x, -Infinity, Infinity}]

#Integrate[Exp[-(x - 2.79164)^2/(2*10.97915)]/(Sqrt[2*\[Pi]*10.97915]), {x, 0.1, 0.3}]
#Re[Integrate[Exp[-(x - 2.79164)^2/(2*10.97915)]/(Sqrt[2*\[Pi]*10.97915]), {x, 0.5, Infinity}]]
#Solve[CDF[NormalDistribution[2.79164, 3.31348], x] == 0.99, x]
    #CDF[NormalDistribution[2.79164, 3.31348], 10.499947153676906]
    #InverseCDF[NormalDistribution[2.79164, 3.31348], 0.99]


###Gamma###
#Mathematica Commands
#Integrate[x*(\[Lambda]^r/Gamma[r])*x^(r - 1)*Exp[-\[Lambda]*x], {x, 0, Infinity}]
#Integrate[(x - r/\[Lambda])^2*(\[Lambda]^r/Gamma[r])*x^(r - 1)*Exp[-\[Lambda]*x], {x, 0, Infinity}]

r <- c1^2/c2
#> r
#[1] 0.709823
lambda <- c1/c2
#> lambda
#[1] 0.2542674

#Integrate[(0.2542674^0.709823/Gamma[0.709823])*x^(0.709823 - 1)*Exp[-0.2542674*x], {x, 0.1, 0.3}]
#Integrate[(0.2542674^0.709823/Gamma[0.709823])*x^(0.709823 - 1)*Exp[-0.2542674*x], {x, 0.5, Infinity}]
#Solve[CDF[GammaDistribution[0.709823, 1/0.2542674], x] == 0.99, x]
    #CDF[GammaDistribution[0.709823, 1/0.2542674], 15.343314225954527]
    #InverseCDF[GammaDistribution[0.709823, 1/0.2542674], 0.99]



