
import delimited "D:\CSV_Output\Part2\Accumulated_Profit.csv", clear 

*duplicates drop declarationid prflsstype_desc, force

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

drop gr_lastyearbalance

drop if(missing(accumulatedprofittype_id))

rename accumulatedprofittype_val T15_R

gen code = ""
replace code = "03" if(T15_R=="اصلاح اشتباهات")
replace code = "11" if(T15_R=="افزایش سرمایه")
replace code = "12" if(T15_R=="افزایش سرمایه در جریان")
replace code = "06" if(T15_R=="انتقال از اندوخته‌ها")
replace code = "10" if(T15_R=="اندوخته قانونی")
replace code = "04" if(T15_R=="تغییر در رویه های حسابداری")
replace code = "19" if(T15_R=="جمع تخصیص سود")
replace code = "14" if(T15_R=="خرید سهام خزانه")
replace code = "18" if(T15_R=="سایر" & accumulatedprofittype_id>10)
replace code = "07" if(T15_R=="سایر" & accumulatedprofittype_id<10)
replace code = "13" if(T15_R=="سایر اندوخته‌ها")
replace code = "02" if(T15_R=="سود (زیان) انباشته ابتدای سال")
replace code = "05" if(T15_R=="سود (زیان) انباشته ابتدای سال - تعدیل شده")
replace code = "20" if(T15_R=="سود (زیان) انباشته در پایان سال")
replace code = "01" if(T15_R=="سود (زیان) بعد از کسر مالیات ")
replace code = "01" if(T15_R=="سود (زیان) بعد از کسر مالیات (نقل از جدول شماره 12)")
replace code = "16" if(T15_R=="سود (زیان) حاصل از فروش سهام خزانه")
replace code = "09" if(T15_R=="سود سهام مصوب")
replace code = "08" if(T15_R=="سود قابل تخصیص")
replace code = "15" if(T15_R=="فروش سهام خزانه")
replace code = "17" if(T15_R=="پاداش هیئت مدیره")



drop T15_R accumulatedprofittype_id

rename gr_currentyearbalance T15_R

reshape wide T15_R, i(return_id) j(code) string

merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop return_id

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear gsz_* trace_id

drop gsz_todate gsz_beforeminustaxp gsz_savedtaxp gsz_afterminustaxp gsz_firstyearp gsz_balancep gsz_firstyearbalancedp gsz_transitionfromsavedp gsz_benefitp gsz_legalsavedp gsz_etcsavedp gsz_stockbenefitp gsz_managerrewardp gsz_etcbenefitp gsz_sumbenefitp gsz_benefitendyearp

destring gsz_* trace_id, replace ignore("NULL")

rename gsz_beforeminustax T15_000
rename gsz_savedtax T15_001
rename gsz_afterminustax T15_R01
rename gsz_firstyear T15_R02
rename gsz_balance T15_002
rename gsz_firstyearbalanced T15_R05
rename gsz_transitionfromsaved T15_R06
rename gsz_benefit T15_R08
rename gsz_legalsaved T15_R10
rename gsz_etcsaved T15_R13
rename gsz_stockbenefit T15_R16
rename gsz_managerreward T15_R17
rename gsz_etcbenefit T15_R18
rename gsz_sumbenefit T15_R19
rename gsz_benefitendyear T15_R20

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear gsz_* trace_id

drop gsz_todate gsz_beforeminustaxp gsz_savedtaxp gsz_afterminustaxp gsz_firstyearp gsz_balancep gsz_firstyearbalancedp gsz_transitionfromsavedp gsz_benefitp gsz_legalsavedp gsz_etcsavedp gsz_stockbenefitp gsz_managerrewardp gsz_etcbenefitp gsz_sumbenefitp gsz_benefitendyearp

rename gsz_beforeminustax T15_000
rename gsz_savedtax T15_001
rename gsz_afterminustax T15_R01
rename gsz_firstyear T15_R02
rename gsz_balance T15_002
rename gsz_firstyearbalanced T15_R05
rename gsz_transitionfromsaved T15_R06
rename gsz_benefit T15_R08
rename gsz_legalsaved T15_R10
rename gsz_etcsaved T15_R13
rename gsz_stockbenefit T15_R16
rename gsz_managerreward T15_R17
rename gsz_etcbenefit T15_R18
rename gsz_sumbenefit T15_R19
rename gsz_benefitendyear T15_R20

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"


merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

sort actyear id
order id actyear trace_id

label var T15_000 "سود یا زیان قبل از کسر مالیات"
label var T15_001 "ذخیره مالیات ابرازی"
label var T15_R01 "سود یا زیان بعد از کسر مالیات"
label var T15_R02 "سود یا زیان انباشته ابتدای سال"
label var T15_002 "تعدیلات سنواتی"
label var T15_R05 "سود یا زبان انباشته ابتدای سال - تعدیل‌شده"
label var T15_R06 "انتقال از اندوخته‌ها"
label var T15_R08 "سود قابل تخصیص"
label var T15_R10 "اندوخته قانونی"
label var T15_R13 "سایر اندوخته‌ها"
label var T15_R16 "سود یا زبان حاصل از فروش سهام خزانه"
label var T15_R17 "پاداش هیئت مدیره"
label var T15_R18 "سایر"
label var T15_R19 "جمع تخصیص سود"
label var T15_R20 "سود یا زبان انباشته در پایان سال"
label var T15_R03 "اصلاح اشتباهات"
label var T15_R04 "تغییر در رویه‌های حسابداری"
label var T15_R07 "سایر"
label var T15_R09 "سود سهام مصوب"
label var T15_R11 "افزایش سرمایه'"
label var T15_R12 "افزایش سرمایه در جریان"
label var T15_R14 "خرید سهام خزانه"
label var T15_R15 "فروش سهام خزانه"


save "D:\Data_Output\Hoghooghi\Gardesh_Hesab.dta", replace