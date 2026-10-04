add_library(VendorLib INTERFACE)            # معنی این چیه؟ مگه این کتابخانه، هم هدر نداره و هم پیاده سازی؟
                                            # پس چرا گفته فقط هدرهاش به سایرین نشان داده بشه؟ (برداشتم اصلا درسته؟)
                                            # طبق فصل ۵ معنیش اینه که این کتابخانه در دسته INTERFACE_LIBRARY قرارمی‌گیره
                                            # یه گونه کتابخانه کامله که هدفش کلا اینه که دستورالعمل بده به سایرین، 
                                            ‌# نه اینکه خودش پیاده سازی داشته باشه. همه صفاتش هم باید interface باشن
target_compile_definitions(VendorLib INTERFACE TUTORIAL_USE_VENDORLIB)

# TODO11: Add the include directory to VendorLib
target_include_directories(VendorLib INTERFACE include)     # فقط INTERFACE برای هدرها قبوله. با PRIVATE/PUBLIC ارور میده
                                                            # Vendor/include غلطه چون آدرس دهی از همین پوشه شروع میشه
# TODO12: Add the lib directory to VendorLib
target_link_directories(VendorLib INTERFACE lib)            # این چرا فقط INTERFACE? این که فایل هاییه که واسه Build ساخت خودش لازمه...
                                                            # نخیر. یک کتابخانه INTERFACE طبق فصل ۵ (add_library(INTERFACE))
                                                            # اصلا بیلد نمیشه
                                                            # Vendor/lib غلطه چون آدرس دهی از همین پوشه شروع میشه

# TODO13: Add the Vendor archive to VendorLib
# target_sources(VendorLib
#     PRIVATE
#         lib/Vendor.cxx
#     PUBLIC
#         FILE_SET    myVendor
#         TYPE        HEADERS                           # چرا این کد کلا غلطه؟
#         BASE_DIRS   include
#         FILES       include/Vendor.h
# )

target_link_libraries(VendorLib INTERFACE )