# TODO1: Add a MakeTable executable
add_executable(MakeTable)

# TODO2: Add MakeTable.cxx to the MakeTable executable
target_sources(MakeTable
PRIVATE
    MakeTable.cxx
)

# TODO3: Add a custom command which invokes MakeTable to generate SqrtTable.h
add_custom_command(
OUTPUT SqrtTable.h
COMMAND MakeTable  SqrtTable.h
DEPENDS MakeTable   # این که اسم executable رو هم بعنوان وابستگی بیاریم، واجب نیست
                    # اما باعث میشه اگه MakeTable مون آپدیت شد،‌ اینم دوباره اجرا بشه
                    # میشه یک فایل ورودی هم به command و DEPENDS اضافه کرد:
                    # COMMANDS MakeTable -i input.txt -o Generated.cxx
                    # DEPENDS MakeTable input.txt
VERBATIM
)

# TODO4: Add a custom target which depends on SqrtTable.h
add_custom_target(RunGenerator DEPENDS SqrtTable.h)         # الان اگه کتابخانه ای که میخواست از فایل تولیدشده استفاده کنه
                                                            # INTERFACE نبود، به این target میانی نیاز نبود.
                                                            # کافی بود فایل رو مستقیم بذاریم توی target_sources اش
                                                            # این فایل رو هم باید در ۲ target بگذاریم:
                                                            # target هم در INTERFACE target ⬇️ پایین
                                                            
# TODO5: Add an INTERFACE library to describe the SqrtTable header
add_library(sqrt_describer INTERFACE)

# TODO6: Add the current binary directory (and optionally the SqrtTable.h FILE)
#        to a header file set of the interface library
target_sources(sqrt_describer
INTERFACE
    FILE_SET HEADERS
    BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}
    FILES ${CMAKE_CURRENT_BINARY_DIR}/SqrtTable.h       # ثابت CMAKE_CURRENT_BINARY_DIR رو باید بذاریم چون محل اجرای code generator
                                                        # داخل Build Tree است. نه پوشه فعلی فایل CMakeLists.txt.
                                                        # بدون این متغیر در این دو خط، ارور میده. حتی خط BASE_DIRS هم واجبه
)

# TODO7: Use add_dependencies to ensure the custom target always runs before
#        targets that depend on the interface library
add_dependencies(sqrt_describer RunGenerator)           # اینجا ما custom_target رو مجبور می‌کنیم
                                                        # که قبل از هر target ای که بخواد INTERFACE_lib رو link کنه اجرا بشه
                                                        # (یعنی تمام وابسته های interface lib|تمام اونایی که به interface lib وابسته اند)
                                                        # 🔴 این اجبار حتما باید بعد از تعریف کامل
                                                        # تمام target هایی بیاد که اسمشان اینجاست