cmake_minimum_required(VERSION 4.4.2)

function(myfunc_1 var)
    message(var)                # var
    message(${var})             # foo
    message("${${var}}\n")      # "hi;there"
endfunction()


function(myfunc_2 var)
    message(var)                # var
    message(${var})             # hi there
endfunction()


set(foo hi there)             # اگه از double quotation استفاده می کردیم، خود جمله در تابع اول چاپ میشد. اما حالا فکر میکنه لیست ئه.
myfunc_1 (foo)                  # 1: این بار فقط اسم/خود متغیر رو میفرستیم
myfunc_2 (${foo})               # 2: این بار محتوای متغیر رو فرستادیم. نه اسمش رو



set(var hi there Im doing great)            # طرز ساخت لیست اینطوریه. نه با براکد/آکولاد/تک‌کوتیشن

message ("${var}" " how are you?\n") # array modifying level
message (${var} "\n") # string manipulating level

set(char   "hi there Im doing great")
set(char_2 'hi there Im doing great')       # کلا با تک کوتیشن string نباید بسازیم چون فکر میکنه یک لیسته که بعضی عناصرش برحسب اتقاق ' دارن
message(${char})
message(${char_2})

# سه مدل اتفاق داریم
# set(List "hello pretty world)
# set(list2 "Hello;Pretty;World)
# set(list3 hello pretty world)
# فقط دو مدل پایین، توصیفی از یک لیست هستن و هردو معادل اند.
# اهمیت این از این بابته، که گاهی لازمه چندین آرگومان به یک تابع مثل
# message(), add_library (..), set(..), myFunc()
# بدیم، اما حوصله نداشته باشیم، تک‌تک بنویسیم شون. اینجا میشه بذاریم‌شون توی
# یک لیست و فقط اون لیست رو (محتوای لیست، نه اسمش) بدیم به اون تابع:
# add_library (${list2}) ≡
# بعد عناصر list2 با space separated در (پرانتز تابع) باز میشن و باوجود اینکه ما فقط یک list2 
# به تابع، پاس دادیم، اون چندین پارامتر دریافت می‌کنه و هر عنصر list2، یکی از آرگومان های مورد انتظار تابع رو فراهم می‌کنن.
# ≡ add_library(Hello Pretty World)
# اما اگه list2 رو با ".." بغل می‌کردیم، انگار فقط یک آرگومان string فرستادیم:
# add_library ("${list2}") ≡ add_library("Hello;Pretty;World")

# پس منظور از space separated، در سطح syntax هست، 
# مثل آرگومان های جدای توابع که باید هریک space separated باشن؛ نه موقع چاپ. 
# وقتی یک list رو بدون ".."، print اش کنیم، دیگه space separated نیستن. 
# message(${list2} T) 
# // HelloPrettyWorldT

# و منظور این نیست که اگه رشته رو با تک‌کوتیشن ' یا بی‌کوتیشن چاپ کنیم، فکر میکنه لیسته و خودبخود ; میذاره بینشون، 
# یا اگه بین شون ; باشه و با تک‌کوتیشن بخوایم چاپش کنیم، خودش space بزنه بین کلمات.