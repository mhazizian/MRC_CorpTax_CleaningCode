clear all

global dir "D:\Data_Output\Hoghooghi"
// global dir "~\Documents\Majlis RC\data\tax_return\Hoghooghi"


use "$dir\Mohasebe_Maliat.dta", replace

keep if !missing(maghtou_taxable_income) | !missing(T26_004)

gen maghtou_income = maghtou_taxable_income
replace maghtou_income  = T26_004 if missing(maghtou_income)

keep id actyear trace_id maghtou_income

drop if maghtou_income == 0

duplicates drop

rename maghtou_income Exempted_Profit
gen exemption_id = 35
gen exemption_description = 30
gen exempt_flag = 2

tempname temp
save `temp', replace

use "$dir\Moafiat.dta", replace 

append using `temp'

label define moafiat_flag_label 2 "from mohasebe maliat table"
label values exempt_flag moafiat_flag_label

duplicates drop
duplicates tag id actyear trace_id original_description  if exemption_id == 35, gen(maghtou_dup_tag)
drop if maghtou_dup_tag >= 1 & exempt_flag == 2

drop maghtou_dup_tag
save "$dir\Moafiat.dta", replace  