추후 분류하거나 더 살펴보고 익힐 명령어들을 임시로 모아두는 공간입니다.


### egen 활용 사례
```stata
** 1995년 2% 센서스에서 가구 id 만들기
egen hhid=group(c1 c2 c4)

** Cohort 변수 만들기
egen cohort=cut(age), at(20,30,40,50,60)
```

<br>

### 추후 살펴보고 정리할 코드
```stata
binscatter // module to generate binned scatterplots

clonevar

coefplot

fre // module to display one-way frequency table, 레이블과 원래 numeric value를 함께 볼 수 있음.

markstat

rsource

nsplit // nsplit date, digits(2 4) generate(month year)

renames

ssc whatshot, n(20)

winsor2
distinct // Report number(s) of distinct observations or values
egenmore
parmest // module to create new data set with one observation per parameter of most recent model
regsave
grstyle
getsymbols
ciplot
insheetjson
xls2dta
```

<br>

### Script를 간결하게 작성하기 위해서 익힐 명령어들 모음

```stata
keep if inlist(cohort, 1830, 1860, 1890, 1920, 1950, 1980)
keep if inrange(Birthyear, 1830, 1980)
```

<br>

### 95% 신뢰구간 함께 표시하기

```stata
twoway (scatter order est, msymbol(none))  ///
	(scatter order est )                        ///
	(rcap min95 max95 order, horizontal ),      ///
	ylabel(1/6, valuelabel angle(0)) legend(off) ytitle("") ///
	xlabel(-0.7 (0.2) 0.5) ///
	xtitle("") title( "남학생-수학") xline(0)  name(boy_mat)
```

<br>

### 엑셀에서 숫자가 변수명으로 된 자료를 Stata long-form data로 전환하기 <br>
(참고 자료 및 fertility.xlsx 데이터: [우석진 교수님 블로그](https://econbigdata.tistory.com/67?category=724580))

```stata
import excel using fertility.xlsx, clear

 foreach j of var B-T { 
 
 local name = strtoname(`j'[1]) 
 capture rename `j' `name' 
 
 } 
 
drop in 1 
 
rename A region 
rename _* fer* 
 
reshape long fer, i(region) j(year) 
destring fer, replace 
egen id = group(region) 
```

<br>

### Table로 내보낼 때 변수 선택하고 변수명 레이블하기. 

```stata
qui reg loginc i.year educyr if sex!=. & age!=. & paeducyr!=. & empstat!=.
estimate store m1

qui reg loginc i.year educyr i.sex age paeducyr if empstat!=.
estimate store m2

qui reg loginc i.year educyr i.sex age paeducyr i.empstat
estimate store m3

esttab m1 m2 m3, b(3) se(3) r2 ar2 mtitles("Model 1" "Model 2" "Model 3") drop(*year) ///
	 coeflabels(1.sex "men (ref.)" 2.sex "women" 1.empstat "std ft (ref)" 2.empstat "std pt" ///
	 3.empstat "non-std ft" 4.empstat "non-std pt" 5.empstat "self-emp")
```
