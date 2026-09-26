cmake_minimum_required(VERSION 4.4.2)

option(FIRST_CACHE "HI THERE" OFF)
option(SECOND_CACHE "BYE THERE" ON)

if (FIRST_CACHE)
    message(first)
elseif(SECOND_CACHE)
    message(${SECOND_CACHE})
endif()

# وقتی میگن متغیر cache رو تنظیم کنین، ممکنه دو راه زیر ما را گیج کنه:
# option(TUTORIAL_BUILD_UTILITIES "Build the Tutorial executable" ON) 

# set(ShadowVariable "In the shadows" CACHE STRING "")          # روش shadowing فقط با set امکان پذیره. چون متغیرهای set 
# set(ShadowVariable "Hiding the cache variable")               # میتونن محلی باشن. ولی با option همیشه cache هستن
# message("ShadowVariable: ${ShadowVariable}")

# unset(ShadowVariable)
# message("ShadowVariable: ${ShadowVariable}")

# cmake -P ShadowVariable.cmake
# ShadowVariable: Hiding the cache variable
# ShadowVariable: In the shadows