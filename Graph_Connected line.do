

local j mat_std
	twoway ///
	 (connected `j' wave if group==1, clpattern(dash)  msymbol(D)) ///
	 (connected `j' wave if group==2, lwidth(thick) msymbol(S)) ///
	 (connected `j' wave if group==3, lwidth(thick) msymbol(T)) ///
	 (connected `j' wave if group==4,  msymbol(O)) ///
	, legend(label(1 00) label(2 01) label(3 10) label(4 11) c(4)) ///
	xlabel(3(1)4) ylabel(-0.5 (0.1) 0.2) title( "여학생 - 수학") name(g_mat, replace) ytitle("") xtitle("")  // scheme(s1mono)

local j resilience
forv i=1/3 {
	twoway ///
	 (connected `j'`i' wave if group==1, clpattern(dash)  msymbol(D)) ///
	 (connected `j'`i' wave if group==2, clpattern(dot) lwidth(thick) msymbol(S)) ///
	 (connected `j'`i' wave if group==3, clpattern(longdash) lwidth(thick) msymbol(T)) ///
	 (connected `j'`i' wave if group==4,  msymbol(O)) ///
	, legend(label(1 00) label(2 01) label(3 10) label(4 11) c(4)) ///
	xlabel(3(1)4) ylabel(2.5 (0.5) 4.0) name(_g`i') ytitle("") xtitle("")  // scheme(s1mono)
}
grc1leg _g1 _g2 _g3, col(3) title( "여학생") leg(_g3) name(g탄력성, replace) // scheme(s1mono)
