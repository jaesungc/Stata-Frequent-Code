# playground

## Stacked Bar 그래프 그리기 for Black and White scheme (인권 기사 작업 내용)

use temp_fig, replace

collapse (count) n_article=day, by(year group)
reshape wide n_article, i(year) j(group)

graph bar n_article1 n_article2 n_article3 n_article4, ///
over(year, label(angle(90))) ///
legend(lab(1 "Chosun") lab(2 "Joongang") lab(3 "Hankyoreh") lab(4 "Kyunghang") cols(4) size(small) colfirst region(lstyle(none))) ///
stack scheme(s2mono) graphregion(color(white)) bgcolor(white)
