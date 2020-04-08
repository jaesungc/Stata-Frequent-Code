#### Exporting t-test results to make a table in Excel

```stata
local file_name "sum_attrition_check_0925.csv"
eststo clear
local var_list self_effi1 social1 eg_bhv1 eg_psy1 eg_cog1 kor_std1 eng_std1 mat_std1
bys d_sample: eststo: estpost sum `var_list'
esttab using `file_name', cells("count(fmt(0)) mean(fmt(2)) sd(fmt(2))") mtitles( "Leave" "Stay") nonumber replace

cap mat drop A
mat A=0
foreach i in `var_list' {
    disp
    disp "Variable `i'"
    disp
     ttest `i', by(d_sample)
    mat A=(A \ `r(p)')
    }
mat A=A[2..10,1]
mat coln A=P-Value
mat list A
mat2txt, matrix(A) saving(`file_name') append format(%6.3f %6.3f)
```

<br>

#### Calculating F-values and exporting them to make a table in Excel

```stata
foreach outcome of local varlist {
     eststo clear
     eststo: estpost tab `outcome'
     forv i=1/2 {
          eststo: estpost tab `outcome' if sex==`i'
          }
     forv i=1/2 {
          eststo: estpost tab `outcome' if cohort==`i'
          }
     forv i=1/2 {
          eststo: estpost tab `outcome' if school==`i'
          }
          esttab using `outfile', append cells(pct(fmt(1))) // nomtitle // nonumber
     }

local varlist fjq1 fjq2 fjq3 fjq4 fjq5 fjq6 fjq7 fjq8
foreach g in sex cohort school {
     cap mat drop A B
     mat A=0
     mat B=0
     foreach i of local varlist {
          tab `i' `g', chi
          mat A=(A \ `r(chi2)')
          mat B=(B \ `r(p)')
          * oneway `i' `g'
          * mat A=(A \ `r(F)')
          * mat B=(B \ Ftail(`r(df_m)',`r(df_r)',`r(F)'))
          }
     mat A=A[2..9,1]
     mat B=B[2..9,1]
     mat coln A=F-Value
     mat coln B=P-Value
     mat rown A=`varlist'
     mat rown B=`varlist'
     mat C=(A,B)
     mat list C
     mat2txt, matrix(C) saving(anova_test_first_job.csv) append format(%6.2f %6.2f) title( "Test by `g'")
     }
```

<br>

Notes: 
청소년정책연구원 보고서 작업할 때 청년패널 또는 GOMS 분석할 때 작성했던 코드로 보임. <br>
추후 데이터 확인해서 샘플 자료 탑재할 것)
