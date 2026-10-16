cmake_minimum_required(VERSION 3.23)

project(Tutorial)

option(TUTORIAL_BUILD_UTILITIES "Build the Tutorial executable" ON)
option(TUTORIAL_USE_STD_SQRT "Use std::sqrt" OFF)

# TODO6: Add a default-ON option named TUTORIAL_ENABLE_IPO with a doc string:
#          "Check for and use IPO support"

option(TUTORIAL_ENABLE_IPO "Check for and use IPO support" ON)        # این بی تاثیره و غلطه چون IPO فقط روی همین پروژه تاثیر میذاره

# TODO7: Include and use the CheckIPOSupported module to enable IPO if
#        TUTORIAL_ENABLE_IPO is True. To enable IPO, use:
#          set(CMAKE_INTERPROCEDURAL_OPTIMIZATION True)
#        Otherwise, follow the examples in the CheckIPOSupported documentation.
#        Specifically, follow the documentation example to emit an error message
#        if IPO is unavailable. Additionally, when IPO is available, emit a
#        message indicating so (otherwise IPO has no easily visible change in
#        the logs or build).
if(TUTORIAL_ENABLE_IPO)
  include(CheckIPOSupported)
  # check_ipo_supported()   # با این فقط وجود پشتیبانی از این قابلیت رو چک میکنیم. اگه کامپایلر پشتیبانی نمی کرد:‌ FATAL ERROR
  check_ipo_supported(RESULT result OUTPUT err_msg)  # باید قبل فعال سازی بررسی کنیم که آیا اصلا پشتیبانی میشه؟
                                      # با این متغیر result حالا دیگه FATAL ERR نمیده و قبل فعال سازی، خروجی چک رو هم میگیریم
  if(result)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION True)  # متغیرهای CMAKE_ دار این قابلیت رو در سراسر پروژه برای همه target ها فعال می‌کنه
    message("IPO Optimization Is Available!!")    # برای همین کار خوب و اصولی ای نیست که از داخل پروژه با set 
                                                  # یک متغیر سراسری رو تغییر بدیم چون اولویت بالای set خواسته‌های پکیجرها رو هم نادیده میگیره
                                                  # اما چون IPO باید سراسری تنظیم بشه،
                                                  # تا برای بهینه سازی بتونه داخل سایر target ها رو هم ببینه
  else()
    message(WARNING "IPO Optimization Is NOT supported. ERR: ${err_msg}")
  endif()
endif()


if(TUTORIAL_BUILD_UTILITIES)
  add_subdirectory(Tutorial)
endif()

add_subdirectory(MathFunctions)
