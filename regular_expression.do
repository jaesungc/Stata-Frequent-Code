** regexm(s, re)

disp regexm("강남성형외과", "성형")

sysuse auto
list make if regexm(make, "^B") == 1
list make if regexm(make, "ck") == 1
list make if regexm(make, "[0-9]$") == 1




** regexr(s1, re, s2)

disp regexr("중앙대학교부속고등학교", "대학교", "대")
disp regexr("중앙대학교부속고등학교", "고등학교", "고")

gen make2 = make
replace make2 = regexr(make2, "^B.*[0-9][0-9][0-9][a-z]$", "found")
list make make2 if make != make2

gen make3 = make
replace make3 = regexr(make3, "[0-9]?[0-9][0-9][0-9]$", "found")
list make make3 if make != make3



** regexs(n)

clear
set obs 3

gen number=""
replace number="(123) 456-7890" in 1
replace number="(234) 234-2345" in 2
replace number="(800) STATAPC" in 3

gen str newnum = regexs(1) + "-" + regexs(2) if regexm(number, "^\(([0-9]+)\) (.*)")
gen str newnum2 = regexs(1) + regexs(2) + regexs(3) if regexm(newnum, "(^[0-9]+)-([0-9]+)-([0-9]+)")

