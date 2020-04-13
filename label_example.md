### 자주 사용한 레이블 관련 코드를 모아둔 공간입니다.

#### 성별
```stata
label variable d_male "남성 여부"
label define d_male 0 "여" 1 "남"
label values d_male d_male
```

```stata
label variable gender "Gender"
label define gender 0 "Female" 1 "Male"
label values gender gender
```

```stata
label variable gender "성별"
label define gender 0 "Girl" 1 "Boy"
label values gender gender
```



#### 공학/별학
```stata
replace school_type="1" if school_type=="남자"
replace school_type="2" if school_type=="여자"
replace school_type="3" if school_type=="남여공학"
destring school_type, replace

label variable school_type "Gender of students in a school"
label define school_type 1 "Boys" 2 "Girls" 3 "CoEd"
label values school_type school_type
```

#### 단성학교 더미 변수 만들기
```stata
recode school_type (1 2=1) (3=0), gen(d_sss)
```

#### 통계청이 사용하는 지역 코드를 한글 지명으로 레이블
```stata
#delimit ;
label define region_k
11 "서울" 
21 "부산" 
22 "대구" 
23 "인천" 
24 "광주" 
25 "대전" 
26 "울산"
29 "세종"
31 "경기"
32 "강원" 
33 "충북" 
34 "충남" 
35 "전북" 
36 "전남" 
37 "경북" 
38 "경남" 
39 "제주"
;
#delimit cr

label values region region_k
```

#### 일련번호로 된 지역 코드를 한글 지명으로 레이블
```stata
#delimit ;
label define region_k
1 "서울" 
2 "부산" 
3 "대구" 
4 "인천" 
5 "광주" 
6 "대전" 
7 "울산" 
8 "경기"
9 "강원" 
10 "충북" 
11 "충남" 
12 "전북" 
13 "전남" 
14 "경북" 
15 "경남" 
16 "제주"
;
#delimit cr

label values region region_k
```

#### 일련번호로 된 지역 코드를 한글 지명으로 레이블
```stata
#delimit ;
label define region_k
1 "서울" 
2 "부산" 
3 "대구" 
4 "인천" 
5 "광주" 
6 "대전" 
7 "울산" 
8 "경기"
9 "강원" 
10 "충북" 
11 "충남" 
12 "전북" 
13 "전남" 
14 "경북" 
15 "경남" 
16 "제주"
;
#delimit cr

label values region region_k
```

### 지역명을 영문으로 레이블
```stata
#delimit ;
label define region_e
1 "Gangwon"
2 "Kyungki"
3 "Kyungnam"
4 "Kyungbuk"
5 "Gwangju"
6 "Daegu"
7 "Daejeon"
8 "Busan"
9 "Seoul"
10 "Ulsan"
11 "Incheon"
12 "Geonnam"
13 "Geonbuk"
14 "Jeju"
15 "Choongnam"
16 "Choongbuk"
;
#delimit cr

label values region region_e
```

#### 대도시 지역을 나타내는 더미 변수 만들기
```stata
* region 변수가 string인 경우
decode region, gen(region_k) // 레이블 처리된 numeric 변수를 이용해서 string 변수 생성하기
gen d_metro=(region_k=="서울" | region_k=="광주" | region_k=="대구" | region_k=="대전" | region_k=="울산" | region_k=="인천" | region_k=="부산")

* region 변수가 numeric인 경우
gen d_metro=(region<30)
```


