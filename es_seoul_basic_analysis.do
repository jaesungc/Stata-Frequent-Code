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
tab edu_admin
tab district
sort district school_name
by district: list school_name private



** Duplicates의 활용
use es_list_seoul_2012, replace
gen schid=_n
duplicates e district
duplicates drop edu_admin district, force



** Collapse의 활용
use es_list_seoul_2012, replace
help collapse
collapse (mean) n_stu (sd) n_tea (sum) n_stu6, by(district)



** Looping의 활용
use es_list_seoul_2012, replace
foreach i of varlist edu_admin-n_classroom {
	label var `i' ""
	}

forv i=1/6 {
	gen n_boy`i'=n_stu`i'-n_girl`i'
	order n_boy`i', after(n_girl`i')
	}

local list n_tea n_clerk
foreach i of local list {
	gen `i'_m=`i'-`i'_f
	order `i'_m, after(`i'_f)
	}

	
	
	
** Append의 활용

foreach i of numlist 2008 2009 2010 2011 2012 {
	use es_list_seoul_`i', replace
	gen year=`i'
	order year
	save es_list_seoul_`i'_append, replace
	}
	
use es_list_seoul_2008_append, replace
forv i=2009/2012 {
	append using es_list_seoul_`i'_append
	}
tab year
tab district year
save es_list_seoul_appended, replace




** Merge의 활용
set more off
forv i=2008/2012 {
	use es_list_seoul_`i', replace
	foreach j of varlist n_class1-n_classroom {
	rename `j' `j'_`i'
		}
	save es_list_seoul_`i'_merge, replace
	}
	
use es_list_seoul_2008_merge, replace
merge 1:1 district school_name using es_list_seoul_2009_merge, gen(_merge_2009)
merge 1:1 district school_name using es_list_seoul_2010_merge, gen(_merge_2010)
list school_name _merge_2010 if _merge_2010~=3 // You need to change school name to be consistent across years and keep merging data until 2012




** Reshape의 활용
use es_list_seoul_2012, replace
keep school_name  n_class? n_stu?
reshape long n_class n_stu, i(school_name) j(grade)
reshape wide n_class n_stu, i(school_name) j(grade)
