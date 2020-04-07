### 1986년 1월부터 2019년 12월까지 주택매매가격 종합지수(전국)를 Stata에서 그려보는 코드입니다.

#### 자료 출처: KB국민은행 Liiv ON 월간 KB주택가격동향
#### Stata 파일: [housing_price.dta](https://github.com/jaesungc/Stata-Frequent-Code/blob/master/data/housing_price.dta)

<br>

```
use housing_price, replace

* time series data로 선언하기 위해 데이터 구조 변경
rename jan m1
rename feb m2
rename mar m3
rename apr m4
rename may m5
rename jun m6
rename jul m7
rename aug m8
rename sep m9
rename oct m10
rename nov m11
rename dec m12

reshape long m, i(year) j(month)
rename m price

* 월 변수를 생성해서 월별 time series data 선언
gen modate=ym(year, month)
tsset modate, monthly

* 추이를 살펴볼 수 있는 간단한 그래프
graph twoway tsline price, ///
	xtitle("Period") ytitle("Housing price") xlabel(312(24)720, angle(45)) ///
	graphregion(color(white)) bgcolor(white) ///
	note("Notes: Prices shown have been standardized to 100 for Jan. 2019.")
```

위 코드를 사용해서 생성한 그림은 다음과 같습니다.

![alt 주택가격변화](/image/fig_housing_price_0407.png)
  
<br>
<br>

***

### 추후 참고 자료
 
- [Stata manual for **datetime**](https://www.stata.com/manuals13/ddatetime.pdf)
  
```stata
date td = mdy(M, D, Y)
weekly date tw = yw(Y, W)
monthly date tm = ym(Y, M)
quarterly date tq = yq(Y, Q)
 
gen eventdate = mdy(mo, da, yr)
format eventdate %td
 
display date("5-12-1998", "MDY")
*14011
  
display %td date("5-12-1998", "MDY")
*12may1998
 ```
 
- [Stata manual for **tsline**](https://www.stata.com/manuals13/tstsline.pdf)
- [UCLA - How can I graph data with dates](https://stats.idre.ucla.edu/stata/faq/how-do-i-graph-data-with-dates/)
- [Stata Blog - Adding recession **shading** to time-series graphs](https://blog.stata.com/2020/02/13/adding-recession-shading-to-time-series-graphs/)
- [Label 처리](https://www.stata.com/support/faqs/graphics/time-of-day-labels/)
- [Left and right Y-axies 두 개 표시](https://www.stata.com/manuals13/g-2graphtwowayline.pdf)
