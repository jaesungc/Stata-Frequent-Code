use webstar, replace

hist tmathssk
hist tmathssk, frac

kdensity tmathssk
kdensity tmathssk, g(x d)
edit x d
twoway scatter d x
twoway connected d x
twoway line d x

hist tmathssk, name(hist, replace)
kdensity tmathssk, name(kd, replace)
graph combine hist kd, col(2)

** Kernel: Epanechnikov 
twoway (function 0.75*(1-0.2*x^2)/sqrt(5), range(-2.236 2.236))
