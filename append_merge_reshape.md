### Append의 활용

```stata
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
```

<br>

### Merge의 활용

```stata
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
```

<br>

### Reshape의 활용

```stata
use es_list_seoul_2012, replace
keep school_name  n_class? n_stu?
reshape long n_class n_stu, i(school_name) j(grade)
reshape wide n_class n_stu, i(school_name) j(grade)
```
