** Local variable
local a=3
local b=5
disp`a'+`b'

local name1 "Esther Duflo"
local name2 "Raj Chetty"
disp"`name1'"
disp"`name2'"

** ForvaluesApplication
forv i=1/10 {
	disp "Sequence `i'"
	}


** Foreach application
foreach i in a b c d e {
	disp"Letter `i'"
	}
	
clear
set obs 10
foreach i of numlist 1 2 3 4 5 {
	gen x`i'=`i'
	}
	
foreach j of varlist x1-x5 {
	replace `j'=`j'*10 // Multiply by 10 for each element
	}



use es_list_seoul_2012, replace

foreach i of varlist edu_admin-n_classroom {
	rename `i' `i’_2012
	}
	
	
* Generate variables for number of boys by grade level
use es_list_seoul_2012, replace
forv i=1/6 {
	gen n_boy`i'=n_stu`i'-n_girl`i'
	order n_boy`i', after(n_girl`i')
	}

* Generate variables for number of male teachers & clerks
local list n_tean_clerk
foreach i of local list {
	gen `i'_m=`i'-`i'_f
	order `i'_m, after(`i'_f)
	}

	
	
