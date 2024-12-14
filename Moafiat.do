
import excel "D:\Data_Output\Cleaning_Code\Help\bakhshoodegiha.xlsx", sheet("Sheet1") firstrow clear
drop rebatecase_desc
save "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegiha.dta", replace

import excel "D:\Data_Output\Cleaning_Code\Help\exemptions.xlsx", sheet("Sheet1") firstrow clear
duplicates drop
save "D:\Data_Output\Cleaning_Code\Temp\exemptions.dta", replace

import excel "D:\Data_Output\Cleaning_Code\Help\exemption_codes.xlsx", sheet("Sheet1") firstrow clear
drop bakhshoodegi_id bakhshoodegi_description
drop if(missing(exemption_id))
save "D:\Data_Output\Cleaning_Code\Temp\exemption_codes.dta", replace

import excel "D:\Data_Output\Cleaning_Code\Help\exemption_codes.xlsx", sheet("Sheet1") firstrow clear
drop exemption_id exemption_description
drop if(missing(bakhshoodegi_id))
save "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegi_codes.dta", replace




*********************
import delimited "D:\CSV_Output\Part2\Exempted_Revenue.csv", clear 

drop if(missing(exemptactivitiesdescription))
drop if((totalincome==0 | missing(totalincome)) & (directcostexemptincome==0 | missing(directcostexemptincome)) & (sharejointexpences==0 | missing(sharejointexpences)) & (profitlossexemptincome==0 | missing(profitlossexemptincome)))

recast str exemptactivitiesdescription

merge n:1 exemptactivitiesdescription using "D:\Data_Output\Cleaning_Code\Temp\exemptions.dta", nogen

drop if(missing(declarationid))
keep if(missing(bakhshoodegi_id))
drop v9 D value bakhshoodegi_id articlekind

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop if(missing(exemptactivitiesdescription))
drop if(missing(return_id))
drop return_id
drop if(missing(id))

merge n:1 exemption_id using "D:\Data_Output\Cleaning_Code\Temp\exemption_codes.dta", nogen

drop exemptactivitiesdescription
       
rename totalincome Exempted_Revenue
rename directcostexemptincome Exempted_Cost
rename sharejointexpences Exempted_joint_Cost
rename profitlossexemptincome Exempted_Profit

sort actyear id
order id actyear exemption_description exemption_id Exempted_Profit Exempted_Revenue Exempted_Cost Exempted_joint_Cost

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace



******************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

duplicates drop id actyear, force ////// Concern

keep id actyear moaf*
drop moafincomes

destring moaf*, replace ignore("NULL")

rename moaf*income Exempted_Revenue*
rename moaf*hazinemostaghim Exempted_Cost*
rename moaf*hazinemoshtarak Exempted_joint_Cost*
rename moaf*benefit Exempted_Profit*

reshape long Exempted_Revenue Exempted_Cost Exempted_joint_Cost Exempted_Profit, i(id actyear) j(desc) string

drop if((Exempted_Revenue==0 | missing(Exempted_Revenue)) & (Exempted_Cost==0 | missing(Exempted_Cost)) & (Exempted_joint_Cost==0 | missing(Exempted_joint_Cost)) & (Exempted_Profit==0 | missing(Exempted_Profit)))

gen exemption_id = .
replace exemption_id = 28 if(desc=="daneshm3")
replace exemption_id = 29 if(desc=="daneshm9")
replace exemption_id = 30 if(desc=="m11")
replace exemption_id = 2 if(desc=="m132")
replace exemption_id = 26 if(desc=="m133")
replace exemption_id = 23 if(desc=="m134")
replace exemption_id = 32 if(desc=="m139")
replace exemption_id = 117 if(desc=="m141")
replace exemption_id = 19 if(desc=="m142")
replace exemption_id = 24 if(desc=="m143")
replace exemption_id = 25 if(desc=="m144")
replace exemption_id = 20 if(desc=="m145")
replace exemption_id = 114 if(desc=="m168")
replace exemption_id = 1 if(desc=="m81")
replace exemption_id = 22 if(desc=="manateghazad")
replace exemption_id = 35 if(desc=="mshmgh")
replace exemption_id = 37 if(desc=="sayer")
replace exemption_id = 27 if(desc=="t3m2")
replace exemption_id = 113 if(desc=="m138")
drop if(desc=="summash")
drop if(desc=="sum")
drop if(desc=="moafmash")

merge n:1 exemption_id using "D:\Data_Output\Cleaning_Code\Temp\exemption_codes.dta", nogen

drop if(missing(id))
drop if(missing(exemption_description))
drop desc

sort actyear id
order id actyear exemption_description exemption_id Exempted_Profit Exempted_Revenue Exempted_Cost Exempted_joint_Cost

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace


*************************************
forvalues i=1392(1)1397{
	import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_financial.csv", clear 
	
	keep if(actyear==`i')

	drop if(missing(actyear))
	replace nat_guid = subinstr(nat_guid,"}", "",.)
	replace nat_guid = subinstr(nat_guid,"{", "",.)
	rename nat_guid id
	
	duplicates drop id actyear, force ////// Concern

	keep id actyear moaf* v219 v327 v348 v349 v353 v354
	drop moafincomes moafsumincome moafsumhazinemostaghim moafsumhazinemoshtarak moafsumbenefit moafsayerplan5yearsdesc1 moafsayerplan5yearsincome1 moafsayerplan5yearshazinemostagh moafsayerplan5yearshazinemoshtar moafsayerplan5yearsbenefit1 moafsayerplan5yearsdesc2 moafsayerplan5yearsincome2 v348 v349 moafsayerplan5yearsbenefit2 moafsayerplan5yearsdesc3 moafsayerplan5yearsincome3 v353 v354 moafsayerplan5yearsbenefit3
	
	rename moaf*hazinemost* moaf*hmost
	rename moaf*hazinemosht* moaf*hmosh
	
	rename moafm132increaseemployeeincome moafm132incempincome
	rename moafm132increaseemployeehazinemo moafm132incemphmost
	rename v219 moafm132incemphmosh
	rename moafm132increaseemployeebenefit moafm132incempbenefit
	
	rename moafm141agriculturalexpincome moafm141agrincome
	rename moafm141agriculturalexphazinemos moafm141agrhmost
	rename v327 moafm141agrhmosh
	rename moafm141agriculturalexpbenefit moafm141agrbenefit
	
	rename moafm141rawmaterialexphazinemosh moafm141rawmaterialexphmosh
	rename moafm132industrialparkhazinemosh moafm132industrialparkhmosh
	
	rename moaf*income Exempted_R*
	rename moaf*hmost Exempted_C*
	rename moaf*hmosh Exempted_jC*
	rename moaf*benefit Exempted_P*

	reshape long Exempted_R Exempted_C Exempted_jC Exempted_P, i(id actyear) j(desc) string

	drop if((Exempted_R==0 | missing(Exempted_R)) & (Exempted_C==0 | missing(Exempted_C)) & (Exempted_jC==0 | missing(Exempted_jC)) & (Exempted_P==0 | missing(Exempted_P)))
	
	save "D:\Data_Output\Cleaning_Code\Temp\temp3_`i'.dta", replace
}


import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_financial.csv", clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id
	
duplicates drop id actyear, force ////// Concern

keep id actyear moafsayerplan5yearsdesc1 moafsayerplan5yearsincome1 moafsayerplan5yearshazinemostagh moafsayerplan5yearshazinemoshtar moafsayerplan5yearsbenefit1 moafsayerplan5yearsdesc2 moafsayerplan5yearsincome2 v348 v349 moafsayerplan5yearsbenefit2 moafsayerplan5yearsdesc3 moafsayerplan5yearsincome3 v353 v354 moafsayerplan5yearsbenefit3

rename moafsayerplan5yearsdesc1 moafsplan5yeardesc1
rename moafsayerplan5yearsincome1 moafsplan5yearincome1
rename moafsayerplan5yearshazinemostagh moafsplan5yearmost1
rename moafsayerplan5yearshazinemoshtar moafsplan5yearmosht1
rename moafsayerplan5yearsbenefit1 moafsplan5yearbenefit1

rename moafsayerplan5yearsdesc2 moafsplan5yeardesc2
rename moafsayerplan5yearsincome2 moafsplan5yearincome2
rename v348 moafsplan5yearmost2
rename v349 moafsplan5yearmosht2
rename moafsayerplan5yearsbenefit2 moafsplan5yearbenefit2
	
rename moafsayerplan5yearsdesc3 moafsplan5yeardesc3
rename moafsayerplan5yearsincome3 moafsplan5yearincome3
rename v353 moafsplan5yearmost3
rename v354 moafsplan5yearmosht3
rename moafsayerplan5yearsbenefit3 moafsplan5yearbenefit3

reshape long moafsplan5yeardesc moafsplan5yearincome moafsplan5yearmost moafsplan5yearmosht moafsplan5yearbenefit, i(id actyear) j(code)

rename moafsplan5yeardesc desc 
rename moafsplan5yearincome Exempted_Revenue
rename moafsplan5yearmost Exempted_Cost
rename moafsplan5yearmosht Exempted_joint_Cost
rename moafsplan5yearbenefit Exempted_Profit 

drop if((Exempted_Revenue==0 | missing(Exempted_Revenue)) & (Exempted_Cost==0 | missing(Exempted_Cost)) & (Exempted_joint_Cost==0 | missing(Exempted_joint_Cost)) & (Exempted_Profit==0 | missing(Exempted_Profit)))

drop code desc
gen exemption_id = 118 //// Concern

merge n:1 exemption_id using "D:\Data_Output\Cleaning_Code\Temp\exemption_codes.dta", nogen

drop if(missing(id))

save "D:\Data_Output\Cleaning_Code\Temp\temp3_tosee.dta", replace



**********************************
use "D:\Data_Output\Cleaning_Code\Temp\temp3_1392.dta", clear
forvalues i=1393(1)1397{
	append using "D:\Data_Output\Cleaning_Code\Temp\temp3_`i'.dta"
}

gen exemption_id = .
replace exemption_id = 28 if(desc=="daneshm3")
replace exemption_id = 29 if(desc=="daneshm9")
replace exemption_id = 30 if(desc=="m11")
replace exemption_id = 11 if(desc=="m132export")
replace exemption_id = 10 if(desc=="m132foriegninvest")
replace exemption_id = 4 if(desc=="m132incemp")
replace exemption_id = 5 if(desc=="m132industrialpark")
replace exemption_id = 9 if(desc=="m132invest")
replace exemption_id = 6 if(desc=="m132lessdeveloped")
replace exemption_id = 7 if(desc=="m132others")
replace exemption_id = 12 if(desc=="m132pilgrimage")
replace exemption_id = 2 if(desc=="m132tolidi")
replace exemption_id = 3 if(desc=="m132tourism")
replace exemption_id = 8 if(desc=="m132transfer")
replace exemption_id = 26 if(desc=="m133")
replace exemption_id = 23 if(desc=="m134")
replace exemption_id = 113 if(desc=="m138")
replace exemption_id = 32 if(desc=="m139")
replace exemption_id = 33 if(desc=="m139nonprofit")
replace exemption_id = 14 if(desc=="m139quran")
replace exemption_id = 16 if(desc=="m141agr")
replace exemption_id = 18 if(desc=="m141impexp")
replace exemption_id = 15 if(desc=="m141nonoilexp")
replace exemption_id = 17 if(desc=="m141rawmaterialexp")
replace exemption_id = 19 if(desc=="m142")
replace exemption_id = 24 if(desc=="m143")
replace exemption_id = 25 if(desc=="m144")
replace exemption_id = 20 if(desc=="m145")
replace exemption_id = 114 if(desc=="m168")
replace exemption_id = 1 if(desc=="m81")
replace exemption_id = 22 if(desc=="manateghazad")
replace exemption_id = 21 if(desc=="mosharekatm145")
replace exemption_id = 35 if(desc=="mshmgh")
replace exemption_id = 37 if(desc=="sayer")
replace exemption_id = 27 if(desc=="t3m2")
replace exemption_id = 31 if(desc=="taminmalim138")

merge n:1 exemption_id using "D:\Data_Output\Cleaning_Code\Temp\exemption_codes.dta", nogen

drop if(missing(id))
drop if(missing(exemption_description))
drop desc

rename Exempted_P Exempted_Profit
rename Exempted_R Exempted_Revenue
rename Exempted_C Exempted_Cost
rename Exempted_jC Exempted_joint_Cost

sort actyear id
order id actyear exemption_description exemption_id Exempted_Profit Exempted_Revenue Exempted_Cost Exempted_joint_Cost


append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp3_tosee.dta"

merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

append using "D:\Data_Output\Cleaning_Code\Temp\temp_moaf_in_bakh.dta"

drop if((Exempted_Revenue==0 | missing(Exempted_Revenue)) & (Exempted_Cost==0 | missing(Exempted_Cost)) & (Exempted_joint_Cost==0 | missing(Exempted_joint_Cost)) & (Exempted_Profit==0 | missing(Exempted_Profit)))

sort actyear id
order id actyear

encode exemption_description, gen(temp)
drop exemption_description
rename temp exemption_description

sort actyear id
order id actyear exemption_description exemption_id Exempted_Profit Exempted_Revenue Exempted_Cost Exempted_joint_Cost

save "D:\Data_Output\Hoghooghi\Moafiat.dta", replace