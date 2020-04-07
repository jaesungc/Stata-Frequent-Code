### return list


#### Variable standardization
```stata
use bsgkorm5, replace   // TIMSS 2011 한국 학생 자료
egen math=rowmean(bsmmat0?)
su math
return list
disp r(mean)
gen math_std1=(var1-r(mean))/r(sd)
egen math_std2=std(math)
```

#### 활용 사례: 수학 성적 상위 1%와 하위 1%를 drop하고 분석하기
```stata
use bsgkorm5, replace
su bsmmat01, d
drop if bsmmat01<r(p1) | bsmmat01>r(p99)
forv i=1/5 {
	su bsmmat0`i', d
	drop if bsmmat0`i'<r(p1) | bsmmat0`i'>r(p99)
	}
```

### ereturn list

#### Regression을 돌린 후 e(N), e(F), e(r2), e(b), e(V) 등 추출 가능
```stata
clear
sysuse auto
reg price mpg weight length

ereturn list
disp e(r2)

mat list e(b)
disp _b[_cons]
disp _b[mpg]

mat list e(V)
mat cov=e(V)
mat e1=cov[2,2]
mat e2=cov[1..4,1]
mat list e1
mat list e2
```

