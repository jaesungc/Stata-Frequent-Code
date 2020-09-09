use census_2010_edu_dist_analysis, replace


** 1. 연령대별 대학 전문대 진학 이상 학력의 비율 및 4년제 대학 졸업 이상인 비율

** 전문대 진학 이상
egen n_above_jc=rowtotal(jc uv ma phd)
gen p_above_jc=n_above_jc/n_pop

twoway (scatter p_above_jc age if gender==0) (scatter p_above_jc age if gender==1)

twoway (connected p_above_jc age if gender==0, msymbol(O)) (connected p_above_jc age if gender==1, msymbol(Oh)) 

** 4년제 대학 졸업 이상
egen n_above_uv_grad=rowtotal(uv_grad ma phd)
gen p_above_uv_grad=n_above_uv_grad/n_pop

twoway (connected p_above_uv_grad age if gender==1) /// 
(connected p_above_uv_grad age if gender==0), ///
legend(label(1 Male) label(2 Female)) ///
title(Ratio of University Graduates or Above in 2010) 
ytitle("Proportion") ///
ylabel(0 (0.1) 0.6) xlabel(20 (5) 60) 

twoway (connected p_above_uv_grad age if gender==1) /// 
(connected p_above_uv_grad age if gender==0), ///
legend(label(1 Male) label(2 Female)) ///
title(Ratio of University Graduates or Above in 2010) 
ytitle("Proportion") ///
ylabel(0 (0.1) 0.6) xlabel(20 (5) 60) ///
graphregion(color(white)) bgcolor(white)



** 2. 대표 연령을 통해 살펴본 세대별 학력비율: stacked bar graph
egen n_above_uv=rowtotal(uv ma phd)
keep if age==25 | age==30 | age==35 | age==40 | age==45 | age==50 | age==55 | age==60 
graph bar no_edu es ms hs jc n_above_uv, over(age) over(gender) stack percent
