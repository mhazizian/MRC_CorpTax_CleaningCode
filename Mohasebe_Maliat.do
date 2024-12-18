

import delimited "D:\CSV_Output\Part2\Compute_Tax.csv", clear 

duplicates drop declarationid, force

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)

rename declarationid return_id

merge 1:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop if(missing(return_id))
drop return_id

rename netprofitloss T26_R01
rename profitlossadjust T26_R02
rename adddeductprofitloss T26_R03
rename exemptrevenue T26_R04
rename netwindfallincome T26_R05
rename surplusfinancialaidpaid T26_R06
rename totaladjust T26_R07
rename lossnonexemptactivity T26_R08
rename taxableincomeafterdeduction T26_R09
rename accumulatdepreciatloss T26_R10
rename lossofart165 T26_R11
rename grosstaxableincome T26_R12
rename chamberofcommerceportion T26_R13
rename netdeclartaxableincome T26_R14
rename taxart105 T26_R15
rename taxrebate T26_R16
rename taxdiscountt7 T26_002
rename payabletax T26_R19
rename windfalltaxableincome T26_R20
rename windfallincometax T26_R21
rename taxpaid T26_R23
rename remainpayabletax T26_R25
rename increaseratio T26_001
rename havechamberofcommerceportio T26_000

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear soodzianvije tadilatsoodziansanavati plusorminus_soodzianvije moafincomes mazadkomakhayepardakhti tadilatsum ziangheirmoaf daramadmashmoolmaliat estehlakziananbashte khesaratm165 daramadmashmoolnakhales sahmotaghbazargani daramadmashmoolmaliatkhales maliatmotalegh bakhshoodegi maliatghabelpardakht pardakhtanjamshode maliatmoghararpardakhtani trace_id

destring soodzianvije tadilatsoodziansanavati plusorminus_soodzianvije moafincomes mazadkomakhayepardakhti tadilatsum ziangheirmoaf daramadmashmoolmaliat estehlakziananbashte khesaratm165 daramadmashmoolnakhales sahmotaghbazargani daramadmashmoolmaliatkhales maliatmotalegh bakhshoodegi maliatghabelpardakht pardakhtanjamshode maliatmoghararpardakhtani, replace ignore("NULL")


rename soodzianvije T26_R01
rename tadilatsoodziansanavati T26_R02
rename plusorminus_soodzianvije T26_R03
rename moafincomes T26_R04
rename mazadkomakhayepardakhti T26_R06
rename tadilatsum T26_R07
rename ziangheirmoaf T26_R08
rename daramadmashmoolmaliat T26_R09
rename estehlakziananbashte T26_R10
rename khesaratm165 T26_R11
rename daramadmashmoolnakhales T26_R12
rename sahmotaghbazargani T26_R13
rename daramadmashmoolmaliatkhales T26_R14
rename maliatmotalegh T26_R15
rename bakhshoodegi T26_R16
rename maliatghabelpardakht T26_R19
rename pardakhtanjamshode T26_R23
rename maliatmoghararpardakhtani T26_R25

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace




// import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_financial.csv", clear 
import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear soodzianvije tadilatsoodziansanavati plusorminus_soodzianvije moafincomes incidentalincome mazadkomakhayepardakhti tadilatsum ziangheirmoaf estehlakziananbashte khesaratm165 daramadmashmoolnakhales sahmotaghbazargani daramadmashmoolmaliatkhales maliatmotalegh bakhshoodegi maliatmoghararpardakhtani incidentaltaxableincome incidentaltax pardakhtanjamshode maliatghabelpardakht discountintaxm105 incomeeffectivem105 maliatmaghtoo differenceofincome trace_id

rename soodzianvije T26_R01
rename tadilatsoodziansanavati T26_R02
rename plusorminus_soodzianvije T26_R03
rename moafincomes T26_R04
rename incidentalincome T26_R05
rename mazadkomakhayepardakhti T26_R06
rename tadilatsum T26_R07
rename ziangheirmoaf T26_R08
rename estehlakziananbashte T26_R10
rename khesaratm165 T26_R11
rename daramadmashmoolnakhales T26_R12
rename sahmotaghbazargani T26_R13
rename daramadmashmoolmaliatkhales T26_R14
rename maliatmotalegh T26_R15
rename bakhshoodegi T26_R16
rename maliatmoghararpardakhtani T26_R19
rename incidentaltaxableincome T26_R20
rename incidentaltax T26_R21
rename pardakhtanjamshode T26_R23
rename maliatghabelpardakht T26_R25
rename discountintaxm105 T26_002
rename incomeeffectivem105 T26_003
rename maliatmaghtoo T26_004
rename differenceofincome T26_005

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"



preserve
keep id
duplicates drop
gen new_id = _n
replace new_id = new_id + 10000000
save "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", replace
restore

merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

sort actyear id
order id actyear

save "D:\Data_Output\Hoghooghi\Mohasebe_Maliat.dta", replace



// #### Add Tashkhisi/Ghati date
import delimited "D:\CSV_Output\part3\tashkhisi_ghati_corporate.csv", clear

rename id trace_id
drop actyear

merge 1:1 trace_id using "D:\Data_Output\Hoghooghi\Mohasebe_Maliat.dta", nogen

save "D:\Data_Output\Hoghooghi\Mohasebe_Maliat.dta", replace
