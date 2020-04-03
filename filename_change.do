** Stata에서 loop와 local variable을 사용해서 규칙을 가지고 생성된 파일들의 파일명을 일괄 변경하는 예제입니다.

** 2015년 PISA에 참여한 10개의 국가만을 남긴 후, 일련번호 또는 국가번호가 suffix로 사용된 파일명을 suffix가 국가명이 되도록 변경하는 코드

** 실습 Data: pisa_cnt_list.dta
** PISA 2015 자료에서 cntryid, cnt 변수만 남기고 국가별로 unique한 73개 케이스만 남김 
** (실습파일은 샘플 코드가 저장된 곳과 동일한 Github Repo에 올려져 있음 또는 여기서 다운로드 가능: 
** https://github.com/jaesungc/Stata-Frequent-Code/blob/master/pisa_cnt_list.dta)



** Test용 sample data 만들기
use pisa_cnt_list, replace
keep in 1/10
gen x=_n
gen y=rnormal()
save test, replace


*****************************************************************************
** Case 1. 그림의 파일명 뒷자리가 일련번호로 생성된 경우(fig1, fig2, fig3, ...)
*****************************************************************************
use test, replace

* 파일명의 suffix가 일련번호인 그래프 생성하기
forv i=1/10 {
	twoway (scatter y x)
	graph export "fig`i'.png", replace
	}

* 파일명의 suffix가 "일련번호"에 해당하는 행(row)에 위치한 "국가명"이 되도록 파일명의 suffix 변경하기
forv i=1/10 {
	local cnt_name=cnt[`i']
	disp "`cnt_name'"
	
	shell ren "fig`i'.png" "fig_`cnt_name'.png"
	}


*******************************************************************************
** Case 2. 그림의 파일명 뒷자리가 국가 코드로 생성된 경우(fig8, fig12, fig36, ...)
*******************************************************************************
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
	
* 파일명의 suffix가 "국가코드"인 파일들의 suffix가 "국가명"이 되도록 파일명 변경하기
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
	
	
