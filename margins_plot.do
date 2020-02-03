global indep i.d_male i.cohort i.c_edu i.c_hhinc i.c_marriage i.region_code_figure i.year i.d_work i.d_own_house i.c_house_type

global indep_margin r.d_male r.cohort r.c_edu r.c_hhinc r.c_marriage r.region_code_figure r.year r.d_work r.d_own_house r.c_house_type

** Predicted probability
ologit sm_self $indep
margins $indep, predict(outcome(3)) post
eststo m1_o3_pp

** Marignal effect
ologit sm_self $indep
margins $indep_margin, predict(outcome(3)) post
eststo m1_o3_margin1

** Marignal effect
ologit sm_self $indep
margins, dydx(*) predict(outcome(3)) post
eststo m1_o3_margin2

esttab * using Table_ME.csv, replace cells(b(star fmt(3))) ///
	par nomtitles ///
	star(* 0.10 ** 0.05 *** 0.01) nobaselevels plain

* esttab * using Table_ME.csv, replace cells(b(star fmt(3)) se(par fmt(2))) ///
	* par label  mtitles("case1 case2 case3") ///
* star(* 0.10 ** 0.05 *** 0.01) nobaselevels 	





* 4. Univ Type
margins r.c_univ_g5, predict(outcome(3))

marginsplot, name(f5, replace) ///
	plotopts(c(i)) ///
	ytitle("Probability") xtitle("") title("University Type") ///
	xlabel(2 "Type 2" 3 "Type 3" 4 "Type 4" 5 "Type 5") ///
	graphregion(color(white)) bgcolor(white)  ///
	legend(size(3)) ///
	ylabel(0 (0.02) 0.08) ///
	yline(0)





*** 참고: HN's happienss 코드

* forv i=1/5 {
	* oprobit happy ib3.wealth ///
				* trendXwealth1 trendXwealth2 trendXwealth3 trendXwealth4 trendXwealth5  ///
								* , link(p) cluster(year)	
	* eststo OP_trend`i': margins , dydx(*) predict(outcome(`i')) atmeans post
* }

* esttab OP_trend1 OP_trend2 OP_trend3 OP_trend4 OP_trend5  ///
	* using Table4_OP_ME.csv, replace cells(b(star fmt(2)) se(par fmt(2))) ///
	* par label  mtitles("ME_hap1 ME_hap2 ME_hap3 ME_hap4 ME_hap5") ///
* star(* 0.10 ** 0.05 *** 0.01) nobaselevels 	
