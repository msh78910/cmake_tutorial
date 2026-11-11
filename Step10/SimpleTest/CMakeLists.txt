# A very simple test framework for demonstrating how dependencies work
cmake_minimum_required(VERSION 3.23)

project(SimpleTest
  VERSION 0.0.1
)

add_library(SimpleTest INTERFACE)
target_sources(SimpleTest
  INTERFACE
    FILE_SET HEADERS
    FILES
      SimpleTest.h
)
target_compile_features(SimpleTest INTERFACE cxx_std_20)

# TODO6: Find the TransitiveDep package with find_package. The SimpleTest
#        build should fail if TransitiveDep cannot be found.
find_package(TransitiveDep REQUIRED)
# TODO7: Add the TransitiveDep::TransitiveDep target to the SimpleTest interface
#        library's links. Remember that interface libraries can only have
#        interface properties.
# یعنی امکان نداره که یک کتابخانه interface در جزئیات پیاده سازی خودش به یک 
# header دیگه نیاز داشته باشه که این باعث بشه بخواد اون رو PUBLIC به خودش link کنه؟
target_link_libraries(SimpleTest INTERFACE TransitiveDep::TransitiveDep) 
# جواب: public بودن، یا private بودن، فقط برای build کردن خود کتابخانه بدرد می‌خوره
# از اونجایی که کتابخانه های interface خودشون کامپایل نمی‌شن، و صرفا مشتی اطلاعات و تنظیمات 
# هستن که باید به سایرین منتفل بشن، اگه دارای header ای باشن که در پیاده سازی به 
# header دیگه ای وابسته باشه، خودش این وابستگی رو به کتابخانه مصرف کننده منتقل می‌کنه
# تا همونجایی که قراره کامپایل بشه، درستی #indlude کردنش چک بشه


# آیا Interface Library می‌تواند وابستگی داشته باشد؟
# بله! دقیقاً همان چیزی که گفتی.
# فرض کن ساختار زیر را داریم:
# SimpleTest/
# ├── include/
# │   └── SimpleTest.hpp
# │
# └── CMakeLists.txt

# TransitiveDep/
# └── include/
#     └── TransitiveDep.hpp

# فرض کن SimpleTest.hpp داخل خودش از TransitiveDep.hpp استفاده می‌کند:
# #include <TransitiveDep.hpp>

# در این شرایط باید وابستگی را به CMake معرفی کنیم:
# target_link_libraries(SimpleTest
#     INTERFACE
#         TransitiveDep::TransitiveDep
# )

# چرا INTERFACE؟
# چون SimpleTest خودش چیزی را کامپایل نمی‌کند که به TransitiveDep نیاز داشته باشد؛
# بلکه هر targetی که از SimpleTest استفاده می‌کند، باید به TransitiveDep هم دسترسی داشته باشد.
# به این ویژگی Transitive Dependency می‌گویند.

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

install(
  TARGETS SimpleTest
  EXPORT SimpleTestTargets
  FILE_SET HEADERS
)

install(
  EXPORT SimpleTestTargets
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/SimpleTest
  NAMESPACE SimpleTest::
)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/SimpleTestConfigVersion.cmake
  COMPATIBILITY ExactVersion
  ARCH_INDEPENDENT
)

install(
  FILES
    cmake/simpletest_discover_impl.cmake
    cmake/simpletest_discover_tests.cmake
    cmake/SimpleTestConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/SimpleTestConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/SimpleTest
)
