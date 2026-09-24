cmake_minimum_required(VERSION 3.23)


function(FilterFoo OutVar)
# TODO3: Search all the variables in the argument list passed to FilterFoo,
#        and place those containing "Foo" into the list named by "OutVar"
  message(${ARGN})                                  # هر چرتی بهش بدیم چک نمی کنه متغیره یا رشته. بدون $ همه چی رو رشته فرض میکنه
  foreach(arg IN LISTS ARGN)                        # IN حتما باید کاملا UPPERCASE باشه -- IN LISTS هیچ گونه underline ای نداره
                                                    # برخلاف بالا که ${ARGN} میخواست، اینجا فقط ARGN خالی فقط بدون ${} قبوله        ***************
                                                    # ARGN یکجور متغیر مخفی هست که مثل سایر آرگومان ها به تابع فرستاده میشه.
                                                    # برای همین باید مثل سایر متغیرها با آکولاد بازش کنیم
    # if ("[Foo]+" IN_LIST ${ARGN})                 # کلمه IN_LIST دقیقا هر رشته ای که بدیم رو جستجو میکنه، نه REGEX را
    message("${arg} in loop")
    if (${arg} MATCHES "[Foo]+")                    # چرا حتی بدون regex و " " هم قبول میکنه؟ چرا این regex حتی BazFodoBar رو هم pass میکنه؟
      list(APPEND ${OutVar} ${arg})                      # فقط با حروف بزرگ APPEND -- arg خالی غلطه. ${arg} درسته -- 
      message(appended)
    endif()
  endforeach()
  
  # or
  # List(FILTER ${ARGN} include REGEX "[Foo]+")
  set(${OutVar} ${${OutVar}} PARENT_SCOPE)
endfunction()



# Testing for the above
function(check_contains var)
  if(NOT var IN_LIST OutList)
    message(WARNING "OutList does not contain: ${var}")
    set(Failed True PARENT_SCOPE)
  endif()
endfunction()

function(check_nonfoo)
  list(FILTER ARGN EXCLUDE REGEX Foo)
  if(NOT ARGN STREQUAL "")
    message(WARNING "OutList contains extra item(s): ${ARGN}")
    set(Failed True PARENT_SCOPE)
  endif()
endfunction()

if(SKIP_TESTS)
  return()
endif()

set(InList FooBar BarBaz FooBaz BazBar QuxFoo BazQux)

FilterFoo(OutList ${InList})                                              # چرا با براکت و بدون براکت فرستاده؟ به پیاده سازی تابع خودمون بستگی داره
                                                                          # چون InList بدون براکت فقط یک رشته می‌بود. ولی حالا محتواشو میفرسته
if(NOT DEFINED OutList)
  message("FilterFoo unimplemented or does nothing")
  return()                                                                # حتی درون یک شرط هم استفاده میکنن از return()?
endif()

set(Failed False)

check_contains(FooBar)
check_contains(FooBaz)
check_contains(QuxFoo)
check_nonfoo(${OutList})

if(NOT Failed)
  message("Success!")
endif()
