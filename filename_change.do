** 10개의 국가만을 남겨서 일련번호 또는 국가번호가 suffix로 사용된 파일명을 suffix가 국가명이 되도록 변경하는 코드
** 2015년 PISA 자료에서 cntryid, cnt 변수만 남기고 국가별로 unique한 73개 케이스만 남긴 data를 사용.


cd "D:\Stata Project"

** Test용 sample data 만들기
use pisa_cnt_list, replace
keep in 1/10
gen x=_n
gen y=rnormal()
save test, replace


*************************************
** Case 1. 그림의 파일명 뒷자리가 국가 코드로 생성된 경우
*************************************
use test, replace

* 파일명이 일련번호인 그래프 생성하기
forv i=1/10 {
	twoway (scatter y x)
	graph export "fig`i'.png", replace
	}

* 파일명의 suffix가 일련번호에 해당하는 행(row)에 위치한 국가명이 되도록 파일명 변경하기
forv i=1/10 {
	local cnt_name=cnt[`i']
	disp "`cnt_name'"
	
	shell ren "fig`i'.png" "fig_`cnt_name'.png"
	}


*************************************
** Case 2. 그림의 파일명 뒷자리가 국가 코드로 생성된 경우
*************************************
use test, replace

* levelsof 명령어 확인
levelsof cntryid, local(mylevs)
disp "`mylevs'"

* 국가코드를 파일명의 suffix로 사용해서 그래프 저장하기
levelsof cntryid, local(mylevs)
foreach i of local mylevs {
	twoway (scatter y x)
	graph export "graph`i'.png", replace
	}
	
* 파일명의 suffix가 국가코드인 파일명을 suffix가 국가명이 되도록 파일명 변경하기
levelsof cntryid, local(mylevs)
foreach i of local mylevs {
	// 국가코드의 위치를 확인하기 위한 trick
	disp `i'
	gen long obsn = _n 
	qui: su obsn if cntryid == `i' 
	local j = `r(min)' // 여기서 local j로 저장한 숫자가 해당 국가의 code와 name을 가진 열의 위치
	
	local cnt_name=cnt[`j'] 
	disp "`cnt_name'"
	
	shell ren "graph`i'.png" "graph_`cnt_name'.png"

	drop obsn
	}
	
	
