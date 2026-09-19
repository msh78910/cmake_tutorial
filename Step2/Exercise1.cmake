cmake_minimum_required(VERSION 3.23)


# TODO1: Implement MacroAppend
macro(MacroAppend ListVar Value)
  # message(ListVar) # ListVar
  # message(${ListVar}) # BeginList
  # message("${ListVar}") # BeginList
  # message(${${ListVar}}) # BetaGamma
  # message("${${ListVar}};${${Value}}")      # این غلطه. چون فقط وقتی متغیر میفرستیم، اسمش فرستاده میشه که نیازه دوبار بازش کنیم. اما متغیر Value
                                              # یک مقدار خالص بوده که مستقیم به تابع فرستاده شده. برای همین نیازی به دوبار گشایش نداره
  # set(ListVar "${${ListVar}};${Value}")     # این غلطه. چون برعکس حالت عادی، در توابع و ماکروها، اسم متغیرها رو نباید خالی بذاریم توی set
  if (NOT "${${ListVar}}" STREQUAL "")        # کلمه Not رو قبول نمی کنه. فقط باید همه حروف بزرگ باشن
    set(${ListVar} "${${ListVar}};${Value}")
  else()
    set(${ListVar} "${Value}")
  endif()
  # return(PROPAGATE)                         # چون ماکرو ئه، نیازی به این نیست. خودش کد رو کپی می‌کنه. پس تاثیر تغییرات روی متغیرها می‌مونه
endmacro()

# TODO2: Call MacroAppend, then return the value from FuncAppend
function(FuncAppend ListVar Value)
  # set(${ListVar} "${${ListVar}};${Value}" PARENT_SCOPE)         # روش یک خطی مثل ماکروی بالا
  # set(PARENT_SCOPE)
  MacroAppend(${ListVar} ${Value})                                # روش فرستادن اسامی متغیرهایی که از پارامترهای تابع گرفتیم اینه. باید اسم متغیرها رو بدیم
                                                                  # اینجا برعکس مکان صدا زدن توابع، Value دیگر یک مقدار نیست که 
                                                                  # مستقیما به تابع پاس داده شده باشه. بلکه خودش یک متغیر (value) شده
                                                                  # اگه یک متغیر محلی در داخل تابع تعریف می‌کردیم، چون مال همین محله، دیگه $ نمی‌خواست
  set(${ListVar} "${${ListVar}}" PARENT_SCOPE)                    # آرگومان اول اسم متغیر باشد و آرگومان دوم، مقدار متغیر. (یعنی value اش)
endfunction()



# Testing for the above, final expected value is "Alpha;Beta;Gamma;Delta"
if(SKIP_TESTS)
  return()
endif()

set(Original "Beta;Gamma")
set(Expected "Alpha;Beta;Gamma;Delta")

set(BeginList ${Original})
set(EndList "Alpha")

MacroAppend(BeginList "Delta")
foreach(value IN LISTS BeginList)
  MacroAppend(EndList ${value})
endforeach()

if(BeginList STREQUAL Original)
  message("MacroAppend unimplemented or did nothing")
elseif(NOT EndList STREQUAL Expected)
  message(WARNING "MacroAppend error, final value: ${EndList}")
else()
  message("MacroAppend correct")
endif()

set(BeginList ${Original})
set(EndList "Alpha")

FuncAppend(BeginList "Delta")
foreach(value IN LISTS BeginList)
  FuncAppend(EndList ${value})
endforeach()

if(BeginList STREQUAL Original)
  message("FuncAppend unimplemented or did nothing")
elseif(NOT EndList STREQUAL Expected)
  message(WARNING "FuncAppend error, final value: ${EndList}")
else()
  message("FuncAppend correct")
endif()

# Bonus Tests

FuncAppend(UndefinedList "Test")

set(EmptyList "")
FuncAppend(EmptyList "Test")

set(FalseList "False")
FuncAppend(FalseList "Test")

if(
  (UndefinedList STREQUAL "Test") AND
  (EmptyList STREQUAL "Test") AND
  (FalseList STREQUAL "False;Test")
)
  message("You implemented the empty list case, well done!")
endif()
