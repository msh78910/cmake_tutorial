# TODO12: Move all the MathFunctions target commands to this CMakeLists.txt.
#         Ensure that all paths are updated to be relative to this new location.


# TODO5: Add a library target called MathFunctions to the project
add_library(MathFunctions)

# TODO6: Add the source and header file located in Step1/MathFunctions to the
#        MathFunctions target, note that the intended way to include the
#        MathFunctions header is:          #include <MathFunctions.h>
target_sources(MathFunctions
    PRIVATE
        MathFunctions.cxx           #                   (TODO12) MathFunctions/MathFunctions.cxx    >>      MathFunctions.cxx
    PUBLIC                          # همیشه برای هدر ها
        FILE_SET
            myHEADERS
        TYPE 
            HEADERS                 # not HEADE'R'      برای تعیین نوع (هدر ها و ماژول های سی‌پلاس‌پلاس-20) استفاده میشه
        #BASE_DIRS                  # not BASE_DI'R'    (وقتی نیست، یعنی همین پوشه فعلی)
        #    MathFunctions          #                   اینجا جایی هست که نحوه <آدرس دهی> محتوای داخل #include 
                                    #                   رو مشخص می‌کنیم. همون پوشه Header هست که با این flag مشخص می‌شد: -I >> 

                                    #                   (TODO_12) ممکنه این سوال پیش بیاد که قبل از انتقال به زیرپوشه، وجود این کلید، واجب بود که cmake
                                    #                   از محل هدر ها آگاه بشه تا با -I flag به کامپایلر معرفی شون بکنه.
                                    #                   اما بعد از انتقال این دستورات به این زیرپوشه دیگه اهمیتی نداره که این پوشه
                                    #                   بخشی از فلگ -I هست و باید ازش حتما از مکانش اسم برده بشه.
                                    #                   چون سی‌میک خودش بصورت خودکار «پوشه فعلی» رو در -I flag قرارش می‌ده

                                    #                   اگه می‌خوایم تمیز باشه و فقط اسم فایل رو بنویسیم، باید تا پوشه حاوی خود فایل
                                    #                   عمیق بشیم و آدرس دقیق بدیم. وگرنه باید <inclue/mylib.h> بنویسیم
                                    #                   معمولا اسم پوشه مادر همه هدر ها include هست
        FILES 
            MathFunctions.h         #                   (TODO12) MathFunctions/MathFunctions.h   >>  MathFunctions.h
)
