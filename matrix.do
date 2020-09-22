** Generate 10 by 10 diagonal matrix (identity matrix)
clear
set obs 10
forv i=1/10 {
	gen x`i'=0
	replace x`i'=1 in `i'
	}

** Generate 10 by 10 matrix with each column has value corresponding to column location
clear
set obs 10
forv i=1/10 {
	gen x`i'=`i'
	}

clear
set obs 10
gen x1=1
forv i=2/10 {
	local j=`i'-1
	gen x`i'=x`j'+1
	}

** Generate 10 by 10 matrix filled with numbers from 1 to 100
clear
set obs 10
gen x1=(_n-1)*10+1
forv i=1/9 {
	local j=`i'+1
	gen x`j'=x`i'+1
	}
	
** Generalization
clear
local dim=100
set obs `dim'
gen x1=(_n-1)*`dim'+1
local dim2=`dim'-1
forv i=1/`dim2' {
	local j=`i'+1
	gen x`j'=x`i'+1
	}

** Generate Diagonal Matrix - Set all elements in off-diagonal equal to 0
clear
set obs 10
gen x1=(_n-1)*10+1
forv i=1/9 {
	local j=`i'+1
	gen x`j'=x`i'+1
	}
	
forv i=1/10 {
	replace x`i'=0 if x`i'~=((`i'-1)*10+`i')
	}
