# TODO10: Move all the Tutorial target commands to this CMakeLists.txt. Ensure
#          that all paths are updated to be relative to this new location.

# بعد از اضافه کردن دستورات مخصوص این زیرپوشه، تنها کاری که باید انجام بشه اینه که 
# حواس مون باشه تمام آدرس ها، کافیه نسبت به همین پوشه، نسبی باشن. نه نسبت به فایل اولیه

# TODO3: Add an executable target called Tutorial to the project
add_executable(Tutorial)

# TODO4: Add the Tutorial/Tutorial.cxx source file to the Tutorial target
target_sources(Tutorial
    PRIVATE                     # PRIVATE همیشه برای فایل های cxx (executable , implimentation)
        Tutorial.cxx   # بعد از انتقال به زیرپوشه، اسم زیر پوشه رو از آدرس فایل اجرایی حذف کردم
    # PUBLIC
    #     FILE_SET
    #     TYPE
    #     BASE_DIRS
    #     FILES
)