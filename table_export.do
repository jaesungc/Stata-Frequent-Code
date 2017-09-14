** Table Export in Stata: outreg2, xml_tab, tabout, est post

ssc install estout
ssc install outreg2
ssc install xml_tab

clear
sysuse auto

**************************
** Exporting Regression Tables
**************************

** Save results from regression estimatation
eststo clear

reg price mpg
eststo m1
reg price mpg weight
eststo m2
reg price mpg weight length
eststo m3
reg price mpg weight length foreign
eststo m4


** Summary results on the screen
est table *, b(%9.3f) star(.1 .05 .01) stats(N)


** xml_tab
xml_tab *, ///
stats(N r2) ///
save(table.xml) sh(t1) ///
replace below nolabel 

** xml_tab
xml_tab *, ///
stats(N r2) ///
save(table.xml) sh(t1) ///
append below nolabel 

** Outreg2
reg price mpg
outreg2 using table2.xls, replace
reg price mpg weight
outreg2 using table2.xls, append



*****************************
** Exporting Summary Statistics
*****************************
** Descriptive statistics
eststo clear
estpost sum price mpg weight length
esttab using summary.csv, cells("count(fmt(0)) mean(fmt(2)) sd(fmt(2)) min(fmt(1)) max(fmt(0))") nomtitle nonumber replace

eststo clear
bys foreign: eststo: estpost sum price mpg weight length
esttab using summary.csv, cells("count(fmt(0)) mean(fmt(2)) sd(fmt(2)) min(fmt(1)) max(fmt(0))") nomtitle nonumber append

** Exporting Tabulations
eststo clear
forv i=0/1 {
	eststo: estpost tab rep78 if foreign==`i'
	}
esttab using summary.csv, cells(pct(fmt(1))) noobs append
