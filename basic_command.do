cd "d:\data\"

** First Simple Operation in Stata
clear

set obs 10

gen x=1
gen y=x*10

replace y=4 in2
replace y=6 in 3
replace y=20 in 5
replace y=. in 8

sort y
gsort -y x

order y x

recode y (4=2)(6=3)

gen d_y10=(y==10)
gen d_y10_v2=(y==10) if y~=.

count if y==10

drop if y<=3
keep if y==10

drop d_y10
rename x x_old



** Data Examining
use es_list_seoul_2012, replace
d
d,s
edit
codebook

sort district school_name
by district: list school_nameprivate
bysdistrict: tab private

sun_stu, d
sun_stuif district=="종로구"
sun_stuif district=="종로구" | district=="성북구"



** _n, _N, [_n-1]
use es_list_seoul_2012, replace

gen schid1=_n
bysdistrict: gen schid2=_n
bysdistrict: gen schid3=_N
order schid1 schid2 schid3

clear
edit
set obs4
gen x=3
replace x=5 in 2
replace x=7 in 3
replace x=9 in 4
gen y=x[_n-1]



** Duplicates의 활용
use es_list_seoul_2012, replace
gen schid=_n
duplicates e district
duplicates drop edu_admin district, force



** Collapse의 활용
help collapse
use es_list_seoul_2012, replace
collapse (mean) n_stu(sd) n_tea(sum) n_stu6, by(district)
collapse (mean) mean_stu=n_stu(sd) sd_stu=n_stu, by(district)


** unique
findit unique
ssc install unique
unique district

	
	
