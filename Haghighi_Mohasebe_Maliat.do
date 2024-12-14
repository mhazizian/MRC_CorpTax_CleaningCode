

import delimited "D:\CSV_Output\Part1\Mashaghel\Mashaghel_1390_1399_Mohasebe_Maliat.csv", clear

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)

rename nat_guid id
rename actyear actyear
rename csoodzianvije T19_R01
rename ctadilatsoodziansanavati T19_R02
rename cplusorminussoodziankhales T19_R03
rename cbenefitincomesthatpaidtax T19_R04
rename cexemptincomes T19_R05
rename cpaidhelps T19_R06
rename cdiscounts T19_R07
rename ctaxableincomeb_exempt T19_R08
rename cforfeitthisyear T19_012
rename csumexemptm137_m139_m172 T19_013
rename cexemptm101 T19_R09
rename ctaxableincomeaf_exempt T19_R10
rename cestehlakziananbashte T19_R12
rename ctaxableincomen T19_R13
rename csahmotaghbazargani T19_R14
rename csahmasnaf T19_R15
rename ctaxableincomenet T19_014
rename ctaxintaxableincomenet T19_R16
rename cpayabletaxfortaxreturn T19_015
rename cexemptsandimpunity T19_016
rename cdiscountintaxm131 T19_017
rename cpayabletax T19_R23
rename cpayments T19_R24
rename cremainingpayabletax T19_R26

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace


import delimited "D:\CSV_Output\Part2\Mashaghel\Mashaghel_1392_1395_Mohasebe_Maliat.csv", clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)

rename nat_guid id
rename actyear actyear
rename csoodzianvije T19_R01
rename ctadilatsoodziansanavati T19_R02
rename cplusorminussoodziankhales T19_R03
rename cbenefitincomesthatpaidtax T19_R04
rename cexemptincomes T19_R05
rename cpaidhelps T19_R06
rename cdiscounts T19_R07
rename ctaxableincomeb_exempt T19_R08
rename cforfeitthisyear T19_012
rename cexemptm101 T19_R09
rename ctaxableincomeaf_exempt T19_R10
rename cestehlakziananbashte T19_R12
rename ctaxableincomen T19_R13
rename csahmotaghbazargani T19_R14
rename csahmasnaf T19_R15
rename ctaxableincomenet T19_014
rename ctaxintaxableincomenet T19_R16
rename cpayabletaxfortaxreturn T19_015
rename cexemptsandimpunity T19_016
rename cpayabletax T19_R23
rename cpayments T19_R24
rename cremainingpayabletax T19_R26

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace


import delimited "D:\CSV_Output\Part1\Mashaghel\Mashaghel_1399_1401_Mohasebe_Maliat.csv", clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)

rename nat_guid id
rename actyear actyear
rename totalprofitloss T19_R01
rename profitlossadjustment T19_R02
rename adddeductprofitloss T19_R03
rename totalbenefitincomethatpaidtax T19_R04
rename totalexemptincome T19_R05
rename totalpaidhelp T19_R06
rename totaldiscount T19_R07
rename totaltaxableincomebexempt T19_R08
rename forfeitthisyear T19_012
rename exemptionm101 T19_R09
rename taxableincomeam101 T19_R10
rename forfeitdepreciate T19_R12
rename taxableincome T19_R13
rename chamberofcommercejogs T19_R14
rename guildsjogs T19_R15
rename nettaxableincome T19_014
rename tax T19_R16
rename nettax T19_R23
rename taxpaid T19_R24
rename payabletax T19_R26
rename awardonepercentm190 T19_R25
rename goodaccountm189 T19_R19
rename deductibletaxm169 T19_R22
rename paidtaxesinothercountriesm180 T19_R21
rename exemptiontourismm132 T19_R20
rename helpm172 T19_000
rename exemptionm165fortaxpartner T19_001
rename forfeitdepreciatefortaxpartner T19_002
rename exemptionm137 T19_003
rename exemptionm139 T19_004
rename othercosts T19_005
rename taxableincomebeforem101 T19_006
rename exemptionm165etc T19_007
rename exemptiondescription T19_008
rename forgivenessamountbudgetlaw T19_009
rename finaldoctordeductiontax T19_010
rename correctivepayabletax T19_011

*destring T19_008, replace ignore("NULL/-,")

drop T19_008 /// Concern

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"

/*
preserve
keep id
duplicates drop
gen new_id = _n
replace new_id = new_id + 100000000
save "D:\Data_Output\Cleaning_Code\Temp\temp_id_new_haghighi.dta", replace
restore
*/

*destring T19_*, replace ignore("NULL/-,")

save "D:\Data_Output\Cleaning_Code\Temp\temp3.dta", replace




forvalues i=11(1)42 {
    use "D:\Data_Output\Cleaning_Code\Temp\temp3.dta", clear
    gen counter = _n
	keep if(int(counter/1000000)+1 == `i' )
	merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new_haghighi.dta", nogen keep(match)
	drop id
	rename new_id id
	drop if(missing(actyear))
	drop counter
	save "D:\Data_Output\Cleaning_Code\Temp\temp_haghighi_`i'.dta", replace
}

use "D:\Data_Output\Cleaning_Code\Temp\temp_haghighi_1.dta", clear
forvalues i=2(1)42 {
    append using "D:\Data_Output\Cleaning_Code\Temp\temp_haghighi_`i'.dta"
}

sort actyear id
order id actyear

save "D:\Data_Output\Haghighi\Mohasebe_Maliat.dta", replace


forvalues i=1(1)42 {
    erase "D:\Data_Output\Cleaning_Code\Temp\temp_haghighi_`i'.dta"
}