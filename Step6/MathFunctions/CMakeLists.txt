add_library(MathFunctions)

target_sources(MathFunctions
  PRIVATE
    MathFunctions.cxx

  PUBLIC
    FILE_SET HEADERS
    FILES
      MathFunctions.h
)

target_link_libraries(MathFunctions
  PRIVATE
    MathLogger

  PUBLIC
    OpAdd
    OpMul
    OpSub
)

target_compile_features(MathFunctions PRIVATE cxx_std_20)

if(TUTORIAL_USE_STD_SQRT)
  target_compile_definitions(MathFunctions PRIVATE TUTORIAL_USE_STD_SQRT)
endif()

# TODO1: Include the CheckIncludeFiles module and use it to check for
#        the emmintrin.h header.
include(CheckIncludeFiles)                                                # این فقط بدرد چک کردن وجود هدرهای داخلی کامپایلر می‌خوره.
                                                                          # نه هدرهای کتابخانه های وارداتی و مال خودم
check_include_files(emmintrin.h IS_THERE_EMMINTRIN_HEADER LANGUAGE CXX)   # یه اسم متغیر دلخواه میدیم که نتیجه چک رو بریزه توش

# TODO2: If emmintrin.h is available, add a compile definition to MathFunctions
#        named TUTORIAL_USE_SSE2. This will only be needed by the MathFunctions
#        implementation file.
if(IS_THERE_EMMINTRIN_HEADER)
  target_compile_definitions(MathFunctions PRIVATE TUTORIAL_USE_SSE2)
endif()

# TODO4: Include the CheckSourceCompiles module and use it to check if the
#        following program compiles:
#
#           typedef double v2df __attribute__((vector_size(16)));
#           int main() {
#             __builtin_ia32_sqrtsd(v2df{});
#           }
include(CheckSourceCompiles)
check_source_compiles(CXX                                   # توضیحات چیستی این نوع توابع در فایل cmake tutorial 
"
    typedef double v2df __attribute__((vector_size(16)));
    int main() {
      __builtin_ia32_sqrtsd(v2df{});
    }
"
  HAS_GNU_BUILTIN
)

# TODO5: If the GNU builtins are available, add a compile definition to
#        MathFunctions named TUTORIAL_USE_GNU_BUILTIN. This will only be needed
#        by the MathFunctions implementation file.
if(HAS_GNU_BUILTIN)
  target_compile_definitions(MathFunctions PRIVATE TUTORIAL_USE_GNU_BUILTIN)
endif()

add_subdirectory(MathLogger)
add_subdirectory(MathExtensions)
