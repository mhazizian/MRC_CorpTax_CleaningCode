

import delimited "D:\CSV_Output\Part2\Profit_and_Loss_Statements.csv", clear 

*duplicates drop declarationid prflsstype_desc, force

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

drop lastyearbalance grosssales costpurchases

drop if(missing(prflsstype_id))

rename prflsstype_desc T14_R

gen code = ""
replace code = "50" if(T14_R==" مالیات بر درآمد سال جاری")
replace code = "51" if(T14_R==" مالیات بر درآمد سال قبل")
replace code = "32" if(T14_R=="جمع هزینه‌های فروش، اداری و عمومی")
replace code = "45" if(T14_R=="خالص درآمدهای اتفاقی (نقل به ردیف 5 جدول محاسبه مالیات)")
replace code = "47" if(T14_R=="خالص سایر درآمدها و هزینه‌های غیر عملیاتی ")
replace code = "44" if(T14_R=="درآمد اجاره ")
replace code = "00" if(T14_R=="درآمد کالاهای صادراتی خام و نیمه خام")
replace code = "45" if(T14_R=="درآمدهای اتفاقی")
replace code = "21" if(T14_R=="درآمدهای عملیاتی ")
replace code = "21" if(T14_R=="درآمدهای عملیاتی (نقل از جدول 16 و 18)")
replace code = "05" if(T14_R=="زیان ناشی از تسعیر دارایی ها و بدهی های ارزی")
replace code = "01" if(T14_R=="زیان ناشی از فروش ضایعات")
replace code = "46" if(T14_R=="سایر درآمدها و هزینه‌های غیر عملیاتی ")
replace code = "33" if(T14_R=="سایر درآمدهای عملیاتی")
replace code = "34" if(T14_R=="سایر هزینه‌های عملیاتی")
replace code = "31" if(T14_R=="سایر هزینه‌های فروش، اداری و عمومی")
replace code = "52" if(T14_R=="سود (زیان) بعد از کسر مالیات")
replace code = "39" if(T14_R=="سود (زیان) حاصل از فروش سرمایه‌گذاری")
replace code = "38" if(T14_R=="سود (زیان) حاصل از فروش مواد اولیه")
replace code = "35" if(T14_R=="سود (زیان) عملیاتی")
replace code = "49" if(T14_R=="سود (زیان) قبل از کسر مالیات")
replace code = "23" if(T14_R=="سود (زیان) ناخالص")
replace code = "40" if(T14_R=="سود (زیان) ناشی از تسعیر دارایی‌ها و بدهی‌های ارزی غیر مرتبط با عملیات اصلی")
replace code = "36" if(T14_R=="سود (زیان) ناشی از فروش دارایی‌های غیر منقول")
replace code = "37" if(T14_R=="سود (زیان) ناشی از فروش سایر دارایی‌ها")
replace code = "49" if(T14_R=="سود (زیان) ویژه")
replace code = "42" if(T14_R=="سود حاصل از اوراق مشارکت ")
replace code = "42" if(T14_R=="سود حاصل از سرمایه گذاری و اوراق مشارکت ")
replace code = "41" if(T14_R=="سود سهام/ سهم‌الشرکه")
replace code = "43" if(T14_R=="سود سپرده‌ بانکی ")
replace code = "43" if(T14_R=="سود سپرده‌های سرمایه‌گذاری ")
replace code = "06" if(T14_R=="سود ناشی از تسعیر دارایی‌ها و بدهی‌های ارزی ")
replace code = "02" if(T14_R=="سود ناشی از فروش ضایعات")
replace code = "30" if(T14_R=="هزینه اجاره محل غیر از کارخانه")
replace code = "25" if(T14_R=="هزینه بازاریابی و تبلیغات")
replace code = "27" if(T14_R=="هزینه حق حضور در جلسات هیات مدیره")
replace code = "24" if(T14_R=="هزینه حقوق، دستمزد و مزایا")
replace code = "50" if(T14_R=="هزینه مالیات بر درآمد سال جاری")
replace code = "51" if(T14_R=="هزینه مالیات بر درآمد سال قبل")
replace code = "29" if(T14_R=="هزینه مشاوره")
replace code = "03" if(T14_R=="هزینه کاهش ارزش دریافتنی ها")
replace code = "26" if(T14_R=="هزینه‌ مطالبات مشکوک الوصول و سوخت شده")
replace code = "28" if(T14_R=="هزینه‌ ‌های حسابرسی و حسابداری")
replace code = "48" if(T14_R=="هزینه‌های مالی")
replace code = "22" if(T14_R=="کسر می‌شود: بهای تمام شده درآمدهای عملیاتی")
replace code = "22" if(T14_R=="کسر می‌شود: بهای تمام شده درآمدهای عملیاتی (نقل از جدول 17 و 19)")
replace code = "04" if(T14_R=="کمک‌های مالی پرداختی (نقل از جدول 10) ")


drop T14_R prflsstype_id

rename currentyearbalance T14_R

reshape wide T14_R, i(return_id) j(code) string

forvalues i = 0(1)6 {
	rename T14_R0`i' T14_00`i' 
}


merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop if(missing(return_id))
drop return_id

drop if(missing(id))

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear sz_*

drop sz_todate sz_forooshkhalesp sz_kalaforooshraftep sz_nakhalesforooshp sz_tamamshodepeymanp sz_na_khalespeymanp sz_na_khalesp sz_hoghughp sz_hazinetablighatp sz_motalebatmashkokp sz_hazinehesabresip sz_hazinemoshaverp sz_hazineejaremahalp sz_sayerhazineforooshp sz_sumhazineforooshp sz_frooshzayeatp sz_taseirdaraeep sz_sayerdaramadamaliatip sz_khalessayerdamaliatip sz_amaliatip sz_gheirmangholp sz_forooshsayerdaraeep sz_frooshmavadp sz_frooshsarmayep sz_taseirdaraeenp sz_soodsahamp sz_mosharekatp sz_ejarep sz_helpp sz_sayerdaramadnamaliatip sz_khalessayerdnamaliatip sz_hazinemalip sz_vijep sz_daramadnpeimankarip

destring sz_*, replace ignore("NULL")


rename sz_na_khales T14_R23
rename sz_hoghugh T14_R24
rename sz_hazinetablighat T14_R25
rename sz_motalebatmashkok T14_R26
rename sz_hazinehesabresi T14_R28
rename sz_hazinemoshaver T14_R29
rename sz_hazineejaremahal T14_R30
rename sz_sayerhazineforoosh T14_R31
rename sz_sumhazineforoosh T14_R32
rename sz_sayerdaramadamaliati T14_R33
rename sz_amaliati T14_R35
rename sz_gheirmanghol T14_R36
rename sz_forooshsayerdaraee T14_R37
rename sz_frooshmavad T14_R38
rename sz_frooshsarmaye T14_R39
rename sz_taseirdaraeen T14_R40
rename sz_soodsaham T14_R41
rename sz_mosharekat T14_R42
rename sz_ejare T14_R44
rename sz_sayerdaramadnamaliati T14_R46
rename sz_khalessayerdnamaliati T14_R47
rename sz_hazinemali T14_R48
rename sz_vije T14_R49
rename sz_frooshzayeat T14_002
rename sz_help T14_004
rename sz_taseirdaraee T14_006
rename sz_forooshkhales T14_007
rename sz_kalaforooshrafte T14_008
rename sz_nakhalesforoosh T14_009
rename sz_daramadnpeimankari T14_010
rename sz_tamamshodepeyman T14_011
rename sz_na_khalespeyman T14_012
rename sz_khalessayerdamaliati T14_013

foreach i of varlist T14_008 T14_010 T14_011 T14_008 T14_009 T14_012 T14_009 {
    replace `i' = 0 if(missing(`i'))
}

gen T14_R21 = T14_008 + T14_010
gen T14_R22 = T14_011 + (T14_008 - T14_009)

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_financial.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear sz_*

drop sz_todate sz_forooshkhalesp sz_kalaforooshraftep sz_nakhalesforooshp sz_daramadnpeimankarip sz_tamamshodepeymanp sz_na_khalespeymanp sz_na_khalesp sz_hoghughp sz_hazinetablighatp sz_motalebatmashkokp sz_hazinehesabresip sz_hazinemoshaverp sz_hazineejaremahalp sz_sayerhazineforooshp sz_sumhazineforooshp sz_frooshzayeatp sz_taseirdaraeep sz_sayerhazineamaliatip sz_sayerdaramadamaliatip sz_khalessayerdamaliatip sz_amaliatip sz_gheirmangholp sz_forooshsayerdaraeep sz_frooshmavadp sz_frooshsarmayep sz_taseirdaraeenp sz_soodsahamp sz_mosharekatp sz_sarmayegozarip sz_ejarep sz_helpp sz_sayerdaramadnamaliatip sz_khalessayerdnamaliatip sz_hazinemalip sz_vijep sz_incidentalincomep

rename sz_na_khales T14_R23
rename sz_hoghugh T14_R24
rename sz_hazinetablighat T14_R25
rename sz_motalebatmashkok T14_R26
rename sz_hazinehesabresi T14_R28
rename sz_hazinemoshaver T14_R29
rename sz_hazineejaremahal T14_R30
rename sz_sayerhazineforoosh T14_R31
rename sz_sumhazineforoosh T14_R32
rename sz_sayerdaramadamaliati T14_R33
rename sz_sayerhazineamaliati T14_R34
rename sz_amaliati T14_R35
rename sz_gheirmanghol T14_R36
rename sz_forooshsayerdaraee T14_R37
rename sz_frooshmavad T14_R38
rename sz_frooshsarmaye T14_R39
rename sz_taseirdaraeen T14_R40
rename sz_soodsaham T14_R41
rename sz_mosharekat T14_R42
rename sz_sarmayegozari T14_R43
rename sz_ejare T14_R44
rename sz_incidentalincome T14_R45
rename sz_sayerdaramadnamaliati T14_R46
rename sz_khalessayerdnamaliati T14_R47
rename sz_hazinemali T14_R48
rename sz_vije T14_R49
rename sz_frooshzayeat T14_002
rename sz_help T14_004
rename sz_taseirdaraee T14_006
rename sz_forooshkhales T14_007
rename sz_kalaforooshrafte T14_008
rename sz_nakhalesforoosh T14_009
rename sz_daramadnpeimankari T14_010
rename sz_tamamshodepeyman T14_011
rename sz_na_khalespeyman T14_012
rename sz_khalessayerdamaliati T14_013

foreach i of varlist T14_008 T14_010 T14_011 T14_008 T14_009 T14_012 T14_009 {
    replace `i' = 0 if(missing(`i'))
}

gen T14_R21 = T14_008 + T14_010
gen T14_R22 = T14_011 + (T14_008 - T14_009)

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"


label var T14_000 "درآمد کالاهای صادراتی خام و نیمه خام"    
label var T14_001 "سود ناشی از فروش ضایعات"
label var T14_003 "هزینه کاهش ارزش دریافتنی ها"
label var T14_005 "سود ناشی از تسعیر دارایی‌ها و بدهی‌های ارزی"
label var T14_R21 "درآمدهای عملیاتی"
label var T14_R22 "بهای تمام شده درآمدهای عملیاتی"
label var T14_R27 "هزینه حق حضور در جلسات هیات مدیره"
label var T14_R50 "مالیات بر درآمد سال جاری"
label var T14_R51 "مالیات بر درآمد سال قبل"
label var T14_R52 "سود (زیان) بعد از کسر مالیات"

merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

sort actyear id
order id actyear

save "D:\Data_Output\Hoghooghi\Sood_Zian.dta", replace