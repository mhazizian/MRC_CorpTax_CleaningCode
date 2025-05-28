

// ################## list unidentifed exemptions:
// global dir "C:\Users\asus\Documents\Majlis RC\data\tax_return\Hoghooghi\Moafiat.dta"
global dir "D:\Data_Output\Hoghooghi\Moafiat.dta"

use $dir, clear

// keep if exemption_id == 100
// gen count = 1
// collapse (sum) count Exempted_Profit actyear, by(original_description)
// gsort -Exempted_Profit


// ##################  Fix exemption_id == 100

replace exemption_id  = 37 if original_description == "سايرفعاليتهاي معاف"
replace exemption_description = 19 if original_description == "سايرفعاليتهاي معاف"

replace exemption_id  = 37 if original_description == "سایر معافیت ها "
replace exemption_description = 19 if original_description == "سایر معافیت ها "

replace exemption_id  = 37 if original_description == "سایر معافیت ها"
replace exemption_description = 19 if original_description == "سایر معافیت ها"

***************************

replace exemption_id  = 20 if original_description == "سود سپرده بانکها و موسسات غیرب"
replace exemption_description = 20 if original_description == "سود سپرده بانکها و موسسات غیرب"

***************************

replace exemption_id  = 2 if original_description == "درآمد واحدهاي معدني ماده132"
replace exemption_description = 27 if original_description == "درآمد واحدهاي معدني ماده132"

replace exemption_id  = 2 if original_description == " درآمد واحدهاي معدني (ماده132)"
replace exemption_description = 27 if original_description == " درآمد واحدهاي معدني (ماده132)"

replace exemption_id  = 2 if original_description == "معافیت ماده132درآمد تولیدی "
replace exemption_description = 27 if original_description == "معافیت ماده132درآمد تولیدی "

replace exemption_id  = 2 if original_description == "ماده 132 قانون مالیات ،تولیدی"
replace exemption_description = 27 if original_description == "ماده 132 قانون مالیات ،تولیدی"

***************************

replace exemption_id = 35 if original_descriptio == "مالیات مقطوع پروژه میرداماد"
replace exemption_description = 30 if original_description == "مالیات مقطوع پروژه میرداماد"

***************************

// replace exemption_id = 41 if original_description == "آقای پارسا"
// replace exemption_description = 51 if original_description == "آقای پارسا"
//
// label define temp 51 "نامعاوم", modify
// label values exemption_description temp

***************************

replace exemption_id = 42 if original_description == "بند‌الف‌تبصره1قانون‌بودجه‌1401"
replace exemption_description = 52 if original_description == "بند‌الف‌تبصره1قانون‌بودجه‌1401"

replace exemption_id = 42 if original_description == "بند الف تبصره 1 قانون بودجه 99"
replace exemption_description = 52 if original_description == "بند الف تبصره 1 قانون بودجه 99"

replace exemption_id = 42 if original_description == "بندالف تبصره1قانون بودجه1400"
replace exemption_description = 52 if original_description == "بندالف تبصره1قانون بودجه1400"

replace exemption_id = 42 if original_description == "بندالف‌تبصره1قانون‌بودجه‌سال98"
replace exemption_description = 52 if original_description == "بندالف‌تبصره1قانون‌بودجه‌سال98"

label define temp 52 "معافیت شرکت ملی گاز و شرکت ملی نفت در قوانین بودجه سنواتی", modify
label values exemption_description temp

***************************

replace exemption_id = 43 if original_descriptio == "افزایش سرمایه از محل سود انباش"
replace exemption_description = 53 if original_description == "افزایش سرمایه از محل سود انباش"

replace exemption_id = 43 if original_description == "1401بندف تبصره2قانون بودجه سال"
replace exemption_id = 43 if original_description == "بندف تبصره 2 قانون بودجه 1401 "
replace exemption_description = 53 if original_description == "1401بندف تبصره2قانون بودجه سال"
replace exemption_description = 53 if original_description == "بندف تبصره 2 قانون بودجه 1401 "

replace exemption_id = 43 if original_description == "تبصره 2بند ف قانون بودجه  1401"
replace exemption_description = 53 if original_description == "تبصره 2بند ف قانون بودجه  1401"

replace exemption_id = 43 if original_descriptio == "افزایش سرمایه طبق قانون بودجه "
replace exemption_description = 53 if original_description == "افزایش سرمایه طبق قانون بودجه "

replace exemption_id = 43 if original_descriptio == "بند(ف) تبصره 2قانون بودجه1401"
replace exemption_description = 53 if original_description == "بند(ف) تبصره 2قانون بودجه1401"

replace exemption_id = 43 if original_descriptio == "تبصره ف قانون بودجه سال 1401"
replace exemption_description = 53 if original_description == "تبصره ف قانون بودجه سال 1401"

replace exemption_id = 43 if original_descriptio == "بند ف تبصره 2 قانون بودجه 1401"
replace exemption_description = 53 if original_description == "بند ف تبصره 2 قانون بودجه 1401"

replace exemption_id = 43 if original_descriptio == "بند ف تبصره2 قانون بودجه 1401 "
replace exemption_description = 53 if original_description == "بند ف تبصره2 قانون بودجه 1401 "

replace exemption_id = 43 if original_descriptio == "بند ف تبصره 2 قانون بودجه1401"
replace exemption_description = 53 if original_description == "بند ف تبصره 2 قانون بودجه1401"

replace exemption_id = 43 if original_descriptio == "افزايش سرمايه از محل سود جاري"
replace exemption_description = 53 if original_description == "افزايش سرمايه از محل سود جاري"

replace exemption_id = 43 if original_descriptio == "افزایش سرمایه"
replace exemption_description = 53 if original_description == "افزایش سرمایه"

replace exemption_id = 43 if original_descriptio == "معافیت افزایش سرمایه "
replace exemption_description = 53 if original_description == "معافیت افزایش سرمایه "

replace exemption_id = 43 if original_descriptio == "معافیت بند ف قانون بودجه"
replace exemption_description = 53 if original_description == "معافیت بند ف قانون بودجه"

replace exemption_id = 43 if original_descriptio == "معافیت بند ف تبصره2قانون بودجه"
replace exemption_description = 53 if original_description == "معافیت بند ف تبصره2قانون بودجه"

replace exemption_id = 43 if original_descriptio == "بند (ف) تبصره 2 قانون بودجه"
replace exemption_description = 53 if original_description == "بند (ف) تبصره 2 قانون بودجه"

replace exemption_id = 43 if original_descriptio == " 1401 تبصره 2 قانون بودجه"
replace exemption_description = 53 if original_description == " 1401 تبصره 2 قانون بودجه"

replace exemption_id = 43 if original_descriptio == "بند ه تبصره 2 قانون بودجه "
replace exemption_description = 53 if original_description == "بند ه تبصره 2 قانون بودجه "

replace exemption_id = 43 if original_descriptio == "معافیت بند ه قانون بودجه"
replace exemption_description = 53 if original_description == "معافیت بند ه قانون بودجه"

replace exemption_id = 43 if original_descriptio == "نرخ صفر افزایش سرمایه"
replace exemption_description = 53 if original_description == "نرخ صفر افزایش سرمایه"

replace exemption_id = 43 if original_descriptio == "معافیت موضوع بند ه تبصره دو "
replace exemption_description = 53 if original_description == "معافیت موضوع بند ه تبصره دو "

replace exemption_id = 43 if original_descriptio == "بند ف تبصره 2قانون بودجه 1401"
replace exemption_description = 53 if original_description == "بند ف تبصره 2قانون بودجه 1401"

replace exemption_id = 43 if original_descriptio == "بند ه تبصره 2 بودجه 1402"
replace exemption_description = 53 if original_description == "بند ه تبصره 2 بودجه 1402"

replace exemption_id = 43 if original_descriptio == "معافیت بند ه تبصره 2 "
replace exemption_description = 53 if original_description == "معافیت بند ه تبصره 2 "

replace exemption_id = 43 if original_descriptio == "بند ه تبصره 2قانون بودجه 1402"
replace exemption_description = 53 if original_description == "بند ه تبصره 2قانون بودجه 1402"

replace exemption_id = 43 if original_descriptio == "بند ه تبصره 2 قانون بودجه 1402"
replace exemption_description = 53 if original_description == "بند ه تبصره 2 قانون بودجه 1402"

replace exemption_id = 43 if original_descriptio == "بند هـ تبصره 2 بودجه 1402"
replace exemption_description = 53 if original_description == "بند هـ تبصره 2 بودجه 1402"

replace exemption_id = 43 if original_descriptio == "افزایش سرمایه بند ف تبصره 2 "
replace exemption_description = 53 if original_description == "افزایش سرمایه بند ف تبصره 2 "

replace exemption_id = 43 if original_descriptio == "1401بند ف تبصره 2 قانون بودجه "
replace exemption_description = 53 if original_description == "1401بند ف تبصره 2 قانون بودجه "

replace exemption_id = 43 if original_descriptio == "بند ه تبصره بودجه 1402"
replace exemption_description = 53 if original_description == "بند ه تبصره بودجه 1402"

replace exemption_id = 43 if original_descriptio == "بند هـ تبصره 2  بودجه 1402 "
replace exemption_description = 53 if original_description == "بند هـ تبصره 2  بودجه 1402 "






label define temp 53 "معافیت افزایش سرمایه از محل سود انباشته شرکت", modify
label values exemption_description temp

***************************

replace exemption_id = 44 if original_description == "بند ر تبصره 7 قانون بودجه 1402"
replace exemption_description = 54 if original_description == "بند ر تبصره 7 قانون بودجه 1402"
label define temp 54 "معافیت ایدرو و ایمیدرو در بند ر تبصره ۷ قانون بودجه ۱۴۰۲", modify
label values exemption_description temp

***************************

replace exemption_id = 45 if original_description == "بند الف-45 قانون احکام دائمی"
replace exemption_description = 55 if original_description == "بند الف-45 قانون احکام دائمی"

replace exemption_id = 45 if original_description == "الف-45 قانون احکام دائمی توسعه"
replace exemption_description = 55 if original_description == "الف-45 قانون احکام دائمی توسعه"

replace exemption_id = 45 if original_description == "ماده 45 احکام دائمی برنامه 6"
replace exemption_description = 55 if original_description == "ماده 45 احکام دائمی برنامه 6"


label define temp 55 "سود تسعیر دارایی ها و بدهیهای ارزی بانک توسعه صادرات ایران، صندوق ضمانت صادرات ایران و شرکت   سرمایه گذاری خارجی ایران", modify
label values exemption_description temp

***************************

replace exemption_id = 46 if original_description == "ماده 40 احکام دایمی برنامه توس"
replace exemption_description = 56 if original_description == "ماده 40 احکام دایمی برنامه توس"
label define temp 56 "معافیت منابع عمومی در حساب بانکی خزانه داری کل کشور", modify
label values exemption_description temp

***************************

replace exemption_id = 47 if original_description == "سود تسعیر ارز حاصل از صادرات"
replace exemption_description = 57 if original_description == "سود تسعیر ارز حاصل از صادرات"

replace exemption_id = 47 if original_description == "سود تفاوت نرخ تسعیر ارز صادرات"
replace exemption_description = 57 if original_description == "سود تفاوت نرخ تسعیر ارز صادرات"

replace exemption_id = 47 if original_description == "سود تسعیر"
replace exemption_description = 57 if original_description == "سود تسعیر"

replace exemption_id = 47 if original_description == "تسعیر ارز صادرات-ماده73 ق ا د"
replace exemption_description = 57 if original_description == "تسعیر ارز صادرات-ماده73 ق ا د"

replace exemption_id = 47 if original_description == "تسعیر ارز صادرات- ماده 73 ق اد"
replace exemption_description = 57 if original_description == "تسعیر ارز صادرات- ماده 73 ق اد"

replace exemption_id = 47 if original_description == "سود تسعییر ارز دارایی ها"
replace exemption_description = 57 if original_description == "سود تسعییر ارز دارایی ها"

replace exemption_id = 47 if original_description == "سود تسعیر ارز"
replace exemption_description = 57 if original_description == "سود تسعیر ارز"

replace exemption_id = 47 if original_description == "سود تسعیر"
replace exemption_description = 57 if original_description == "سود تسعیر"


label define temp 57 "سود تسعیر ارز حاصل از صادرات", modify
label values exemption_description temp

***************************

replace exemption_id = 48 if original_description == "ماده(۳۶) قانون رفع موانع تولید"
replace exemption_description = 58 if original_description == "ماده(۳۶) قانون رفع موانع تولید"
label define temp 58 "سود و زیان ناشی از تسعیر دارایی ها و بدهی های ارزی صندوق توسعه ملی", modify
label values exemption_description temp

***************************

save $dir , replace

// to be moved to bakhshoudegi table:

// "بند (ن) تبصره 6 قانون بودجه "
// "معافیت 7 درصدی مالیات 1401"