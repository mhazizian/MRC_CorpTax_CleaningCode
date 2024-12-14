

import delimited "D:\CSV_Output\Part2\Salary_1399_1401.csv", delimiter("؛") clear

replace legaltype = "" if(legaltype=="NULL")
replace legaltype = "" if(legaltype=="...انتخاب کنید...")

gen x = 1
collapse (sum) x, by(legaltype)

encode legaltype, gen(temp)

keep legaltype temp

recast str legaltype

save "D:\Data_Output\Cleaning_Code\Temp\temp_legal_type.dta", replace



import delimited "D:\CSV_Output\Part2\Salary_1399_1401.csv", delimiter("؛") clear
replace legaltype = "" if(legaltype=="NULL")
replace legaltype = "" if(legaltype=="...انتخاب کنید...")

recast str legaltype

merge n:1 legaltype using "D:\Data_Output\Cleaning_Code\Temp\temp_legal_type.dta", nogen

drop legaltype
rename temp legaltype

rename year actyear

save "D:\Data_Output\Salary\Salary_1399_1401", replace