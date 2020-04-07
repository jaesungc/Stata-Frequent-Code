# playground

## Stacked Bar 그래프 그리기 for Black and White scheme (인권 기사 작업 내용)

use temp_fig, replace

collapse (count) n_article=day, by(year group)
reshape wide n_article, i(year) j(group)

graph bar n_article1 n_article2 n_article3 n_article4, ///
over(year, label(angle(90))) ///
legend(lab(1 "Chosun") lab(2 "Joongang") lab(3 "Hankyoreh") lab(4 "Kyunghang") cols(4) size(small) colfirst region(lstyle(none))) ///
stack scheme(s2mono) graphregion(color(white)) bgcolor(white)



** 2. 대표 연령을 통해 살펴본 세대별 학력비율: stacked bar graph (Census 2010 작업했던 코드)

** 전문대 진학 이상
egen n_above_jc=rowtotal(jc uv ma phd)
gen p_above_jc=n_above_jc/n_pop
twoway (scatter p_above_jc age if gender==0) (scatter p_above_jc age if gender==1)
twoway (connected p_above_jc age if gender==0, msymbol(O)) (connected p_above_jc age if gender==1, msymbol(Oh)) 

** 4년제 대학 졸업 이상
egen n_above_uv_grad=rowtotal(uv_grad ma phd)
gen p_above_uv_grad=n_above_uv_grad/n_pop
twoway (connected p_above_uv_grad age if gender==0) (connected p_above_uv_grad age if gender==1), legend(label(1 Female) label(2 Male)) title(Ratio of University Graduation or Above)



twoway (scatter order est, msymbol(none))  ///
(scatter order est )                        ///
(rcap min95 max95 order, horizontal ),      ///
ylabel(1/6, valuelabel angle(0)) legend(off) ytitle("") ///
xlabel(-0.7 (0.2) 0.5) ///
xtitle("") title( "남학생-수학") xline(0)  name(boy_mat)
