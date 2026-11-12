add_executable(Tutorial)

target_sources(Tutorial
  PRIVATE
    Tutorial.cxx
)

target_link_libraries(Tutorial
  PRIVATE
    MathFunctions
)

target_compile_features(Tutorial PRIVATE cxx_std_20)

if(
  (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC") OR
  (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
)

  target_compile_options(Tutorial PRIVATE /W3)

elseif(
  (CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR
  (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
)

  target_compile_options(Tutorial PRIVATE -Wall)

endif()

# TODO9: Find the path to the folder containing Unpackaged.h. The build should
#        fail if this path is not discovered. Note that Unpackaged.h is stored
#        in a subdirectory named "Unpackaged".

# به طور پیش فرض خود CMake مسیرهای پیش‌فرضی را جستجو می‌کند. 
# مسیرهای پیش‌فرض شامل مسیرهای زیر است:
# default paths: /usr/include`، `/usr/local/include , CMAKE_PREFIX_PATH 
# ⚠️ در مورد CMAKE_PREFIX_PATH این چون خودش prefix و پیشوند است،
# ⚠️ وقتی suffix یا پسوند رو هم با PATH_SUFFIXES بهش معرفی می‌کنیم، به هم می‌چسبن تا مسیر کامل شه و فایل رو پیدا می‌کنن

find_path(UnpackagedIncludeFolder Unpackaged.h REQUIRED
  PATH_SUFFIXES Unpackaged                                    # :جواب خود سایت CMake که ارور میده
)

# find_path(MyUnpackagedIncludePATH
#           Unpackaged.h REQUIRED 
          # PATH_SUFFIXES Unpackaged                          # این دستور در پاسخ پیشنهادی پیش فرض cmake کارنمی‌کنه و خطا می‌ده
                                                              # نکته این است که نیازی به اضافه کردن دستی include به ادرس نیست.
                                                              # cmake خودش بصورت خودکار اضافه اش می‌کند.
                                                              # پس این دستور باید کارمیکرد. اما ارور میده

          # PATH_SUFFIXES ${CMAKE_INSTALL_INCLUDEDIR}/Unpackaged  # این دستور یعنی: 
                                                                # «در تمام مسیرهای پیش‌فرض (default path) جستجو کن،
                                                                # و در هر مسیر، زیرپوشه include/Unpackaged را هم بررسی کن.»
                                                                # طبق توضیات chatGPT این دستور به غلط دوباره include را
                                                                # به آدرس زیرپوشه اضافه میکند که باید خطا میداد، ولی درست کارمی‌کنه

          # NO_DEFAULT_PATH             # اضافه کردن این خط هم موجب خطا می‌شود
# )

# دلیل خطای NO_DEFAULT_PATH:
# اما با این دستور فقط مسیرهای صریحا دستی معرفی شده (با PATHS) محدود خواهد کرد
# و مسیرهای پیش فرض را جستجو نخواهد کرد. درنتیجه فقط در کنار PATHS باید استفاده شود:
# find_path(
#     MyIncludePath
#     Unpackaged.h
#     PATHS "${CMAKE_PREFIX_PATH}"
#     PATH_SUFFIXES include/Unpackaged
#     NO_DEFAULT_PATH
#     REQUIRED
# )


# TODO10: Add the discovered path to the Tutorial executable target's
#         include directories.
target_include_directories(Tutorial
  PRIVATE
    ${MyUnpackagedIncludePATH}
)