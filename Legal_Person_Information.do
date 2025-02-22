

import delimited "D:\CSV_Output\Part1\Hoghooghi_99_1401.csv", clear 

duplicates drop id_table, force

replace id_table = subinstr(id_table,"}", "",.)
replace id_table = subinstr(id_table,"{", "",.)
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)

drop if(missing(id_table))
drop id_table

keep taxyear declarationtype financialyeartype senddate_per fromdate_per todate_per acceptancestatus gto edarename activitytypename activitytype nat_guid nationality postalcode trace_id

rename nat_guid id
rename taxyear actyear
rename activitytypename T00_ActivityTypeName
rename activitytype T00_ActivityType
rename senddate_per T00_SendDate
rename fromdate_per T00_FromDate
rename todate_per T00_ToDate
rename gto T00_EdareCode
rename edarename T00_EdareName
rename declarationtype T00_DeclarationType
rename financialyeartype T00_FinancialYearType
rename acceptancestatus T00_AcceptanceStatus
rename nationality T00_Nationality
rename postalcode T00_PostalCode


save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

keep nat_guid actyear activitytypename activitytype exportdate isactive fromdate todate edarekolcode edarename nationalitytype workplace* staffnumber qusedworkplaceownedflag qusedworkplacerentedflag qisinbourse trace_id

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

foreach i of varlist activitytypename activitytype edarename staffnumber {
    replace `i' = "" if(`i'=="NULL")
}

replace staffnumber = "10000" if(staffnumber == "بیشتر از 10000")

destring staffnumber workplacepostcode1 workplacepostcode2 workplacepostcode3 workplacepostcode4 workplacepostcode5 workplacepostcode6 edarekolcode, replace ignore("NULL")


rename activitytypename T00_ActivityTypeName
rename activitytype T00_ActivityType
rename exportdate T00_SendDate
rename isactive T00_IsActive
rename fromdate T00_FromDate
rename todate T00_ToDate
rename edarekolcode T00_EdareCode
rename edarename T00_EdareName
rename nationalitytype T00_NationalityType
rename workplaceplacetype1 T00_WorkPlaceType1
rename workplacelegalbook1 T00_WorkPlaceLegalBook1
rename workplacepostcode1 T00_WorkPlacePostCode1
rename workplaceplacetype2 T00_WorkPlaceType2
rename workplacelegalbook2 T00_WorkPlaceLegalBook2
rename workplacepostcode2 T00_WorkPlacePostCode2
rename workplaceplacetype3 T00_WorkPlaceType3
rename workplacelegalbook3 T00_WorkPlaceLegalBook3
rename workplacepostcode3 T00_WorkPlacePostCode3
rename workplaceplacetype4 T00_WorkPlaceType4
rename workplacelegalbook4 T00_WorkPlaceLegalBook4
rename workplacepostcode4 T00_WorkPlacePostCode4
rename workplaceplacetype5 T00_WorkPlaceType5
rename workplacelegalbook5 T00_WorkPlaceLegalBook5
rename workplacepostcode5 T00_WorkPlacePostCode5
rename workplaceplacetype6 T00_WorkPlaceType6
rename workplacelegalbook6 T00_WorkPlaceLegalBook6
rename workplacepostcode6 T00_WorkPlacePostCode6
rename staffnumber T00_StaffNumber
rename qusedworkplaceownedflag T00_QUsedWorkPlaceOwnedFlag
rename qusedworkplacerentedflag T00_QUsedWorkPlaceRentedFlag
rename qisinbourse T00_QIsInBurs

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_non_financial.csv", delimiter("؛") clear  

// drop trace_id

foreach i of varlist activitytypename activitytype edarename isactive staffnumber qincreaseincome lastyearincome currentyearincome increasepercent workplacepostcode1 {
    replace `i' = "" if(`i'=="NULL")
}

replace staffnumber = "10000" if(staffnumber == "بیشتر از 10000")

destring isactive staffnumber qincreaseincome lastyearincome currentyearincome increasepercent workplacepostcode1, replace ignore("NULL-")

drop if(missing(actyear))
rename nat_guid id

rename activitytypename T00_ActivityTypeName
rename activitytype T00_ActivityType
rename exportdate T00_SendDate
rename isactive T00_IsActive
rename fromdate T00_FromDate
rename todate T00_ToDate
rename edarekolcode T00_EdareCode
rename edarename T00_EdareName
rename nationalitytype T00_NationalityType
rename workplaceplacetype1 T00_WorkPlaceType1
rename workplacelegalbook1 T00_WorkPlaceLegalBook1
rename workplacepostcode1 T00_WorkPlacePostCode1
rename staffnumber T00_StaffNumber
rename qusedworkplaceownedflag T00_QUsedWorkPlaceOwnedFlag
rename qusedworkplacerentedflag T00_QUsedWorkPlaceRentedFlag
rename qisinbourse T00_QIsInBurs
rename qincreaseincome T00_QIncreaseIncome
rename lastyearincome T00_LastYearIncome
rename currentyearincome T00_CurrentYearIncome
rename increasepercent T00_IncreasePercent

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"


merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id
  

encode T00_ActivityTypeName, gen(temp)
drop T00_ActivityTypeName
rename temp T00_ActivityTypeName

encode T00_ActivityType, gen(temp)
drop T00_ActivityType
rename temp T00_ActivityType

encode T00_EdareName, gen(temp)
drop T00_EdareName
rename temp T00_EdareName


sort actyear id
order id actyear trace_id

save "D:\Data_Output\Hoghooghi\Legal_Person_Information.dta", replace