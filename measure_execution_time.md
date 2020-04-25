*** 분석 작업을 하다보면 분석에 소요되는 시간이 궁금할 때가 있습니다. Stata에서 특정 분석에 소요되는 시간을 계산하는 샘플 코드입니다.

두 개의 timer를 돌려서, 분석이 끝나는 각각의 timer 시간을 표시하도록 하였습니다.

```
timer clear


timer on 1

clear
sysuse auto
su
d
forv i=1/50 {
	reg price weight length
}
	
timer off 1


timer on 2

clear
sysuse auto
su
d
forv i=1/50 {
	reg price weight length
}
	
timer off 2


qui timer list

di "First time: " r(t1) _n ///
   "Second time: " r(t2)
```
