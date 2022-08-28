help graph

clear
webuse nlswork

** Histogram
hist age
hist age, frac
hist age, frac bin(20)
hist age, frac width(2)

** Pie chart
graph pie, over(race)
graph pie, over(race) plabel(_all percent, format(%9.1f))

** Twoway graphs
collapse msp, by(year)
twoway scatter msp year
twoway connected msp year



** 연령대별 4년제 대학 졸업 이상의 학력을 가진 비율
** Data: census_2010_edu_dist_analysis.dta (from KOSIS)

egen n_above_uv_grad=rowtotal(uv_grad ma phd)
gen p_above_uv_grad=n_above_uv_grad/n_pop

twoway ///
	(scatter p_above_uv_grad age if gender==0) ///
	(scatter p_above_uv_grad age if gender==1)

twoway ///
	(connected p_above_uv_grad age if gender==0, msymbol(O)) ///
	(connected p_above_uv_grad age if gender==1, msymbol(Oh)) ///
	, legend(label(1 Female) label(2 Male)) ///
	title(Proportion of university graduates or above) ///
	ytitle(Proportion) xtitle(Age)

twoway (scatter p_above_uv_grad age if gender==0), name(female)
twoway (scatter p_above_uv_grad age if gender==1), name(male) 
graph combine female male
graph disp, xsize(10) ysize(6)



** Draw functions
twoway ///
	(function y=x^3+4*x^2-10, range(-4 2)) ///
	(function y=0, range(-4 2)) ///
	, legend(lab(1 "Function") lab(2 "Y=0"))

** Draw CRRA utility functions
twoway ///
	(function x^(1-0.5)/(1-0.5), range(0 100)) ///
	(function x^(1-0.8)/(1-0.8), range(0 100))
