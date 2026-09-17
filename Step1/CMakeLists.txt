# TODO1: Set the minimum required version of CMake to be 3.23
cmake_minimum_required(VERSION 3.23)

# TODO2: Create a project named Tutorial
project (MyProgram)



# TODO_10: Move to subdirectory
# TODO11: Add the Tutorial subdirectory to the project
add_subdirectory(Tutorial)



# TODO13: Add the MathFunctions subdirectory to the project
add_subdirectory(MathFunctions)


# TODO7: Add the MathFunctions library as a linked dependency
#        to the Tutorial target
target_link_libraries(Tutorial PRIVATE MathFunctions)   # ترتیب و محل این دستور اهمیتی نداره برای CMake
                                                        # که این کد رو بعد از add_library() بیاریم یا قبلش.
                                                        # تنها شرط اینه که اون تارگتی که میخواد ویرایش بشه قبلش باید تعریف شده باشه
                                                        
                                                        # (TODO_13) بعد از انتقال target ها به زیرپوشه ها، دیگه ترتیب دستورها برای سی‌میک مهم شد

# TODO_10: Move to subdirectory
# TODO11: Add the Tutorial subdirectory to the project
# add_subdirectory(Tutorial)


# TODO13: Add the MathFunctions subdirectory to the project
# add_subdirectory(MathFunctions)
