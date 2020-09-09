help egen

** rowmean & rowtotal – very helpful in case of having missing values
clear
set obs 5
gen x=1
gen y=2
gen z=3
replace x=. in 3
gen total=x+y+z
egen rowtotal=rowtotal(x y z)
gen mean=(x+y+z)/3
egen rowmean=rowmean(x y z)


** concat – useful for making ID or 시도 & 시군구 결합
clear
set obs 2
gen x=1
gen y=2
egen xy=concat(x y)
egen xy2=concat(x y), p(_)


** gen sum vs. egen total
clear
set obs 4
edit
gen x=1
replace x=2 in 2
replace x=. in 3
replace x=4 in 4

** Create variable containing the running sum of x
gen y=sum(x)

** Create variable containing a constant equal to the overall sum of x
egen z=total(x)


** cut – grouping into several categories by its magnitude
clear
set obs 100
gen x=_n
egen group=cut(x), group(4)
tab group
egen group2=cut(x), at(0,20,50,80,101)
tab group2


** std – standardization of test scores or other variables
clear
set obs 100
gen x=runiform()
gen x100=x*100
egen x_std=std(x)
su

