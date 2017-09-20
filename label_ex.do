** 성별
label variable gender "성별"
label define gender 0 "Girl" 1 "Boy"
label values gender gender

** 공학/별학
replace school_type="1" if school_type=="남자"
replace school_type="2" if school_type=="여자"
replace school_type="3" if school_type=="남여공학"
destring school_type, replace

label variable school_type "Gender of students in a school"
label define school_type 1 "Boys" 2 "Girls" 3 "CoEd"
label values school_type school_type

recode school_type (1 2=1) (3=0), gen(d_sss)


* 7대 광역시 변수
label define region 1 "서울" 2 "부산" 3 "대구" 4 "인천" 5 "광주" 6 "대전" 7 "울산" 8 "경기" ///
9 "강원" 10 "충북" 11 "충남" 12 "전북" 13 "전남" 14 "경북" 15 "경남" 16 "제주"

label values region region
decode region, gen(region_k)
gen d_metro=(region_k=="서울" | region_k=="광주" | region_k=="대구" | region_k=="대전" | region_k=="울산" | region_k=="인천" | region_k=="부산")

#delimit ;
label define region_eng
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

label values region region_eng
