

import delimited "D:\CSV_Output\Part2\Sold_Good_Cost.csv", clear 

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

tostring soldgoodscosttype_id, generate(code)
replace code = "0" + code if(soldgoodscosttype_id<10)
drop soldgoodscosttype_id soldgoodscosttype_val
 
rename domesticamount D_T11_R
rename foreignamount F_T11_R

reshape wide F_T11_R D_T11_R, i(return_id) j(code) string

merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop return_id

rename F_* *_F
rename D_* *_D

gen temp_1 = . 
gen temp_2 = .

forvalues i=1(1)13 {
    if(`i'<10) {
	    replace temp_1 = T11_R0`i'_D
		replace temp_1 = 0 if(missing(T11_R0`i'_D))
		replace temp_2 = T11_R0`i'_F
		replace temp_2 = 0 if(missing(T11_R0`i'_F)) 
		gen T11_R0`i' = temp_1 + temp_2
	}
	else {
	    replace temp_1 = T11_R`i'_D
		replace temp_1 = 0 if(missing(T11_R`i'_D))
		replace temp_2 = T11_R`i'_F
		replace temp_2 = 0 if(missing(T11_R`i'_F)) 
		gen T11_R`i' = temp_1 + temp_2
	}
}



drop temp_1 temp_2

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace


****************************************************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear costmaterial costfee costoverload costproduction costinvqtyduringprfcycle costinvqtyduringprecycle costproduct costinvqtyfirstcycle costbuymaterialduringcycle costprprepareforsale costinvqtyendcycle costetc costsoldproduction trace_id

destring costmaterial costfee costoverload costproduction costinvqtyduringprfcycle costinvqtyduringprecycle costproduct costinvqtyfirstcycle costbuymaterialduringcycle costprprepareforsale costinvqtyendcycle costetc costsoldproduction trace_id, replace ignore("NULL")

rename costmaterial T11_R01
rename costfee T11_R02
rename costoverload T11_R03
rename costproduction T11_R04
rename costinvqtyduringprfcycle T11_R05
rename costinvqtyduringprecycle T11_R06
rename costproduct T11_R07
rename costinvqtyfirstcycle T11_R08
rename costbuymaterialduringcycle T11_R09
rename costprprepareforsale T11_R10
rename costinvqtyendcycle T11_R11
rename costetc T11_R12
rename costsoldproduction T11_R13


save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace



**************************************************************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear costmaterial* costfee* costoverload* costproduction* costinvqtyduringprfcycle* costinvqtyduringprecycle* costproduct* costinvqtyfirstcycle* costbuymaterialduringcycle* costprprepareforsale* costinvqtyendcycle* costetc* costsoldproduction* trace_id

destring costmaterial* costfee* costoverload* costproduction* costinvqtyduringprfcycle* costinvqtyduringprecycle* costproduct* costinvqtyfirstcycle* costbuymaterialduringcycle* costprprepareforsale* costinvqtyendcycle* costetc* costsoldproduction* trace_id, replace ignore("NULL")

rename costmaterial T11_R01
rename costfee T11_R02
rename costoverload T11_R03
rename costproduction T11_R04
rename costinvqtyduringprfcycle T11_R05
rename costinvqtyduringprecycle T11_R06
rename costproduct T11_R07
rename costinvqtyfirstcycle T11_R08
rename costbuymaterialduringcycle T11_R09
rename costprprepareforsale T11_R10
rename costinvqtyendcycle T11_R11
rename costetc T11_R12
rename costsoldproduction T11_R13
rename costmaterialinternal T11_R01_D
rename costmaterialforeign T11_R01_F
rename costfeeinternal T11_R02_D
rename costfeeforeign T11_R02_F
rename costoverloadinternal T11_R03_D
rename costoverloadforeign T11_R03_F
rename costproductioninternal T11_R04_D
rename costproductionforeign T11_R04_F
rename costinvqtyduringprfcycleinternal T11_R05_D
rename costinvqtyduringprfcycleforeign T11_R05_F
rename costinvqtyduringprecycleinternal T11_R06_D
rename costinvqtyduringprecycleforeign T11_R06_F
rename costproductinternal T11_R07_D
rename costproductforeign T11_R07_F
rename costinvqtyfirstcycleinternal T11_R08_D
rename costinvqtyfirstcycleforeign T11_R08_F
rename costbuymaterialduringcycleintern T11_R09_D
rename costbuymaterialduringcycleforeig T11_R09_F
rename costprprepareforsaleinternal T11_R10_D
rename costprprepareforsaleforeign T11_R10_F
rename costinvqtyendcycleinternal T11_R11_D
rename costinvqtyendcycleforeign T11_R11_F
rename costetcinternal T11_R12_D
rename costetcforeign T11_R12_F
rename costsoldproductioninternal T11_R13_D
rename costsoldproductionforeign T11_R13_F


append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"


merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

sort actyear id
order id actyear trace_id


save "D:\Data_Output\Hoghooghi\Baha_Kala.dta", replace