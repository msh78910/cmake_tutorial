# TODO1: Set the minimum required version of CMake to be 3.23
cmake_minimum_required(VERSION 3.23)

# TODO2: Create a project named Tutorial
project (MyProgram)

# TODO3: Add an executable target called Tutorial to the project
add_executable(Tutorial)

# TODO4: Add the Tutorial/Tutorial.cxx source file to the Tutorial target
target_sources(Tutorial
    PRIVATE                     # PRIVATE همیشه برای فایل های cxx (executable , implimentation)
        Tutorial/Tutorial.cxx
    # PUBLIC
    #     FILE_SET
    #     TYPE
    #     BASE_DIRS
    #     FILES
)

# TODO7: Add the MathFunctions library as a linked dependency
#        to the Tutorial target
target_link_libraries(Tutorial PRIVATE MathFunctions)

# TODO11: Add the Tutorial subdirectory to the project

# TODO5: Add a library target called MathFunctions to the project
add_library(MathFunctions)

# TODO6: Add the source and header file located in Step1/MathFunctions to the
#        MathFunctions target, note that the intended way to include the
#        MathFunctions header is:          #include <MathFunctions.h>
target_sources(MathFunctions
    PRIVATE
        MathFunctions/MathFunctions.cxx
    PUBLIC                          # همیشه برای هدر ها
        FILE_SET
            myHEADERS
        TYPE 
            HEADERS                 # not HEADE'R'      برای تعیین نوع (هدر ها و ماژول های سی‌پلاس‌پلاس-20) استفاده میشه
        BASE_DIRS                   # not BASE_DI'R'    (وقتی نیست، یعنی همین پوشه فعلی)
            MathFunctions           #                   اینجا جایی هست که نحوه <آدرس دهی> محتوای داخل #include
                                    #                   رو مشخص می‌کنیم. همون پوشه Header هاست که با این flag مشخص می‌شد: -I
                                    #                   اگه می‌خوایم تمیز باشه و فقط اسم فایل رو بنویسیم، باید تا پوشه حاوی خود فایل
                                    #                   عمیق بشیم و آدرس دقیق بدیم. وگرنه باید <inclue/mylib.h> بنویسیم
                                    #                   معمولا اسم پوشه مادر همه هدر ها include هست
        FILES 
            MathFunctions/MathFunctions.h 
)


# TODO13: Add the MathFunctions subdirectory to the project
