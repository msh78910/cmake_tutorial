# TODO8: Include the TutorialTargets.cmake file, it will be located in the same
#        list directory as this file when it is run.
include(${CMAKE_CURRENT_LIST_DIR}/TutorialTargets.cmake)    
# زمانی که این فایل به صورت دستی نصب بشه، با فایل `target export file` در یک پوشه خواهد بود
# برای همین لازمه که هنگام اجرا بهش گفته باشیم که 
# از `همین پوشه ای که فایل سی‌میک فعلی توشه` یعنی CMAKE_CURRENT_LIST_DIR
# فایل همسایه ات رو بخون و include کن