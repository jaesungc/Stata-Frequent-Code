clear
insheet using "101_DT_1IN1004_F_2010.csv", comma

drop in 1/2

rename v1 code_district
rename v2 district
rename v3 code_gender
rename v4 gender
rename v5 code_age
rename v6 age
rename v7 year_survey
rename v8 n_pop
rename v9 es
rename v10 es_grad
rename v11 es_now
rename v12 es_drop
rename v13 ms
rename v14 ms_grad
rename v15 ms_now
rename v16 ms_drop
rename v17 hs
rename v18 hs_grad
rename v19 hs_now
rename v20 hs_drop
rename v21 jc
rename v22 jc_grad
rename v23 jc_now
rename v24 jc_comp
rename v25 jc_break
rename v26 jc_drop
rename v27 uv
rename v28 uv_grad
rename v29 uv_now
rename v30 uv_comp
rename v31 uv_break
rename v32 uv_drop
rename v33 ma
rename v34 ma_grad
rename v35 ma_now
rename v36 ma_comp
rename v37 ma_drop
rename v38 phd
rename v39 phd_grad
rename v40 phd_now
rename v41 phd_comp
rename v42 phd_drop
rename v43 no_edu

replace code_district=substr(code_district,2,.)
replace code_gender=substr(code_gender,2,.)
replace code_age=substr(code_age,2,.)

gen len_code_age=length(code_age)
order len_code_age, after(code_age)

destring *, replace

save census_2010_edu_dist, replace




use census_2010_edu_dist, replace

keep if district=="전국"
drop if len_code_age==3
drop if gender=="계"

replace age=trim(age)
replace age=subinstr(age,"세","",.) //"

replace gender="0" if gender=="여자"
replace gender="1" if gender=="남자"

destring age gender, replace

label define gender 0 "여자" 1 "남자"
label values gender gender

drop if age<21
drop if age>60

keep  district gender age n_pop es ms hs jc uv uv_grad ma phd no_edu

save census_2010_edu_dist_analysis, replace
