cmake_minimum_required(VERSION 3.23)

project(Tutorial VERSION 1.0.0)

option(TUTORIAL_BUILD_UTILITIES "Build the Tutorial executable" ON)

# TODO1: Add a default-OFF option named TUTORIAL_USE_STD_SQRT, with a doc
#        string of "Use std::sqrt"
option(TUTORIAL_USE_STD_SQRT "Use std::sqrt" OFF)

if(TUTORIAL_BUILD_UTILITIES)
  add_subdirectory(Tutorial)
endif()

add_subdirectory(MathFunctions)
add_subdirectory(Vendor)

# نکته بسیار مهم:
# وقتی فایل Presets داریم، کامپایل کردن cmake با دستور قدیمی
# cmake -B build
# باعث نمی شه که بصورت خودکار از کامپایلر g++
# یا ورژن 20 استاندارد زبان استفاده کنه
# از این به بعد همیشه باید حواسم باشه با cmake --preset <name> پیکربندی کنم