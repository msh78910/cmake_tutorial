cmake_minimum_required(VERSION 3.23)

project(Tutorial)

# option(CMAKE_CXX_STANDARD 20)
# option(CMAKE_CXX_COMPILER "g++-13")

# TODO1: Add a default ON option for a cache variable named:
#          TUTORIAL_BUILD_UTILITIES.
#        option() requires a doc string as its second argument, set this to
#        something like:
#          "Build the Tutorial executable"
option(TUTORIAL_BUILD_UTILITIES "Build the Tutorial executable" ON) 
# آرگومان های `CACHE STRING` مال دستور `set()` است،‌نه `option`
# متغیر معمولی میشد، نه کش CACHE STRING(NO 'S') بدون


# TODO2: Add a conditional statement around add_subdirectory(Tutorial). Only
#        build the Tutorial target if TUTORIAL_BUILD_UTILITIES is ON (or
#        otherwise truthy).
if(TUTORIAL_BUILD_UTILITIES)
    add_subdirectory(Tutorial)
endif()

add_subdirectory(MathFunctions)
