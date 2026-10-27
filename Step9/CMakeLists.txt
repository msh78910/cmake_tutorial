cmake_minimum_required(VERSION 3.23)

# TODO9: Add a VERSION parameter to the project() command for version 1.0.0
project(Tutorial VERSION 1.0.0)

option(TUTORIAL_BUILD_UTILITIES "Build the Tutorial executable" ON)
option(TUTORIAL_USE_STD_SQRT "Use std::sqrt" OFF)
option(TUTORIAL_ENABLE_IPO "Check for and use IPO support" ON)
option(BUILD_TESTING "Enable testing and build tests" ON)

if(TUTORIAL_ENABLE_IPO)
  include(CheckIPOSupported)
  check_ipo_supported(RESULT result OUTPUT output)
  if(result)
    message("IPO is supported, enabling IPO")
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
  else()
    message(WARNING "IPO is not supported: ${output}")
  endif()
endif()

if(TUTORIAL_BUILD_UTILITIES)
  add_subdirectory(Tutorial)
  # TODO1: Install the Tutorial target
              # دلیل این که جدا از سایر target ها این دستور رو می‌آریم اینه که اصلا 
              # add_subdirectory و build این target هم مشروطه و به انتخاب کاربر بستگی داره.
              # اگه اسم Tutorial رو خارج از شرط if بیاریم، ممکنه نشناسه اگه DEFINITION رو به درستی ست نکرده باشیم
  install(
    TARGETS Tutorial                # وظیفه نصب فیزیکی خود target ها رو برعهده دارد
    )

  # TODO3: Add the Tutorial target to the TutorialTargets export
  install(                          # دستوراتی که کلمه EXPORT دارند:
      TARGETS Tutorial # etc        یک لیست از همه تارگت هایی میسازه که میخوایم براشون فایل دسترسی خارجی بسازیم
      # چون که یک executable هیچ هدری برای به اشتراک گذاری و به ارث رساندن نداره، گزینه FILE_SET هم نداره
      EXPORT TutorialTargets        # فعلا فایل این لیست رو نمی سازه. فقط به یک متغیر اضافه اش می کنه
    )

endif()

if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(Tests)
endif()

add_subdirectory(MathFunctions)

# TODO4: Include the GNUInstallDirs module
include(GNUInstallDirs)         # برای دسترسی داشتن به متغیرهایی مثل CMAKE_INSTALL_LIBDIR
                                # که در دستورهای نصب بصورت ضمنی و مخفی وجود داره، لازمه

# TODO2: Install the MathFunctions, OpAdd, OpMul, OpSub, SqrtTable, and
#        MathLogger targets. Ensure you name their header file set so the
#        headers will be installed.
install(
  TARGETS   MathFunctions OpAdd OpMul         # از آنجایی که MathLogger خودش interface است، فایل مستقلی کامپایل نمی کنه.
            OpSub SqrtTable MathLogger        # اما چرا هدرش نیست؟ چون در داخل MathFunction مون include شده
                                              # و اونجا باهم کلا یک فایل کامپایل کردن.
                                              # هدرش هم PRIVATE به اون link شده 
                                              # و برای مصرف MathFunction ئه. واسه سایرین مخفیه

  FILE_SET HEADERS          # همه این کتابخانه‌ها یک FILE_SET ای به اسم HEADERS دارن. از کجا می‌فهمه منظورمون کدومشه
)

# TODO5: Add the targets from TODO2 to the TutorialTargets export
install(                                      # افزودن سایر target های نصب شده، به لیست اشتراک گذاری
  TARGETS MathFunctions OpAdd OpMul OpSub SqrtTable MathLogger
  EXPORT TutorialTargets
  FILE_SET HEADERS                            # چی شد؟ این دستور اینجا چکار میکنه؟ چرا بالا نبود؟ ⁉️
                                              # -- بالا توضیح دادم
                                              # از کجا میفهمه منظور مون FILE_SET HEADERS کدوم target است؟
)

# TODO6: Install the TutorialTargets export to:
#          ${CMAKE_INSTALL_LIBDIR}/cmake/Tutorial
#        And give them a namespace of "Tutorial::"
install(
  EXPORT TutorialTargets          # این دستوری که هیچ TARGETS ای نداره، فایل `target export file` رو می‌سازه و
                                  # و با این کار، تارگت های لیستی که بالا ساختیم رو
                                  # برای مصرف‌کنندگان خارجی قابل دسترسی/رؤیت می‌کنه
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Tutorial
  NAMESPACE Tutorial::
)

# TODO10: Include CMakePackageConfigHelpers
include(CMakePackageConfigHelpers)                  # برای ورژن فایل

# TODO11: Use write_basic_package_version_file to write a
#         TutorialConfigVersion.cmake file to the CMAKE_CURRENT_BINARY_DIR.
#         The version compatibility should be ExactVersion.
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/TutorialConfigVersion.cmake
  COMPATIBILITY ExactVersion
)

# TODO12: Add the generated TutorialConfigVersion.cmake file to the file list
#         of the TODO7 install() command.                             یعنی اصلا نفهمیدم این دستور چطور کار میکنه ⁉️
# install(
#   FILE          cmake/TutorialConfig.cmake              #   کلمه FILE غلطه. S داره
#                 ${CMAKE_CURRENT_BINARY_DIR}/TutorialConfigVersion.cmake
#   DESTINATION   ${CMAKE_INSTALL_LIBDIR}/cmake/Tutorial
# )

# TODO7: Install the config file at cmake/TutorialConfig.cmake to the same
#        destination as the TutorialTargets export.
install(                        # برای separation of concerns این فایل _Config.cmake رو که دستی ساختیم رو دستی نصب می‌کنیم
                                # تا `target export file` (TutorialTargets export) رو include کنه.
                                # یک کپی ساده فایل از آدرس بالا به آدرس پایینه
  # FILES cmake/TutorialConfig.cmake
  FILES       cmake/TutorialConfig.cmake ${CMAKE_CURRENT_BINARY_DIR}/TutorialConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Tutorial
)

# مسئله نصب سایر FILE_SET ها بغیر HEADERS. از کجا میفهمه منظور مون FILE_SET کدوم target است؟

# جواب: CMake برای هر یک از `MathFunctions`، `OpAdd` و... جداگانه نگاه می‌کند
# که آیا با `target_sources(... FILE_SET HEADERS ...)` مجموعه‌ای به نام `HEADERS` یا هر اسم دیگری
# تعریف کرده‌اید یا خیر. اگر تعریف کرده باشید، فایل‌های آن مجموعه نصب می‌شوند؛
# اگر تعریف نکرده باشید، برای آن تارگت خاص کاری انجام نمی‌شود
# (یا خطا می‌دهد اگر تارگت ملزم به اکسپورت باشد).

# install(TARGETS <target>... [...])
# هر تارگتی که FILE_SET شون PUBLIC یا INTERFACE باشه، باید در جلوی EXPORT ذکر بشن. با اینکار، اگر یک target ای بیش از یک FILE_SET داشته باشه، تمام FILE_SET های PUBLIC و INTERFACE داخل target، به EXPORT مون اضافه خواهند شد.
# هر FILE_SET ای با TYPE HEADERS نصب میشه. سایرین Default destination ندارن. پس باید برای هریک آپشن DESTINATION براشون مشخص کنیم
# The directory structure relative to the file set's base directories is preserved. For example, a file added to the file set as 
# /blah/include/myproj/here.h
# with a base directory 
# /blah/include
# would be installed to myproj/here.h below the destination.

# 💡 نکته مهم: در یک پروژه واقعی و تمیز، اگه فایل اجرایی از سایر کتابخانه ها
#   با یک شرط جدا نشده بود، معمولاً این‌ها را ادغام می‌کنند، مثلاً:
# install(
#  TARGETS Tutorial
#  EXPORT TutorialTargets
#  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}  # 🔴
#)
# و برای کتابخانه‌ها:
#install(
#  TARGETS MathFunctions OpAdd ...
#  EXPORT TutorialTargets
#  FILE_SET HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}   # 🔴
#  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}  # 🔴
#)