add_executable(Tutorial)

target_sources(Tutorial
  PRIVATE
    Tutorial.cxx
)

# TODO14: Add VendorLib to Tutorial

target_link_libraries(Tutorial
  PRIVATE
    MathFunctions
    VendorLib                             # اگر چه توی یک پوشه دیگه است و این اسم اینجا هیچ رفرنسی نداره، اما میشه خالی
                                          # بگذاریمش همینجا. وقتی که همه فایل های سی‌میک به هم وصل بشن، مالکش پیدا میشه
                                          # به هیچ include() ای هم نیازی نیست. اون برای ماژول های داخلی cmake است. نه اینجور چیزا
)

# TODO4: Add a compile feature for C++20 support to Tutorial
target_compile_features(Tutorial PRIVATE cxx_std_20)

if(
  (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC") OR
  (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
)
  # TODO9: Add the /W3 compile flag to Tutorial
target_compile_options(Tutorial PRIVATE /W3)
elseif(
  (CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR
  (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
)
  # TODO10: Add the -Wall compile flag to Tutorial
target_compile_options(Tutorial PRIVATE -Wall) #  -Werror       # با فعال شدن این دستور، حالا به چیزایی گیر میده که قبلا گیر نمی داد
message("hi my friend!")

endif()
