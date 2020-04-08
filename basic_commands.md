Stata를 처음 배우는 이들이 command window에서 한 줄 한 줄 입력하면서 Stata의 기본 기능을 살펴볼 때 유용한 코드입니다.

<br>

### 기초적인 필수 명령어들

```stata
clear

set obs 10

gen x=1
gen y=x*10

replace y=15
replace y=4 in 2
replace y=6 in 3
replace y=20 in 5
replace y=. in 8

sort y
gsort -y x

order y x

recode y (4=2) (6=3)

gen d_y10=(y==10)
gen d_y10_v2=(y==10) if y~=.

count if y==15

drop if y<=5
keep if y==15

drop d_y10
keep x

rename x x_old
```

<br>

### Data 살펴보기

```stata
use es_list_seoul_2012, replace
d
d,s
edit

sort district school_name
by district: list school_name private
bys district: tab private

su n_stu, d
su n_stu if district=="종로구"
su n_stu if district=="종로구" | district=="성북구"
```

<br>

### _n, _N, [_n-1]의 활용

```stata
use es_list_seoul_2012, replace

gen schid1=_n
bysdistrict: gen schid2=_n
bysdistrict: gen schid3=_N
order schid1 schid2 schid3

clear
set obs 4
gen x=3
replace x=5 in 2
replace x=7 in 3
replace x=9 in 4
gen y=x[_n-1]
```

<br>

### duplicates의 활용
```stata
use es_list_seoul_2012, replace
gen schid=_n
duplicates e district
duplicates drop edu_admin district, force
```

<br>

### collapse의 활용 (기초 통계를 산출할 때 매우 유용함)
```stata
help collapse
use es_list_seoul_2012, replace
collapse (mean) n_stu(sd) n_tea (sum) n_stu6, by(district)
collapse (mean) mean_stu=n_stu (sd) sd_stu=n_stu, by(district)
```

<br>

### unique의 활용
```stata
findit unique
ssc install unique
unique district
```
	
