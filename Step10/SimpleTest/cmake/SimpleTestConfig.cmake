# TODO8: Include the CMakeFindDependencyMacro and use find_dependency to find
#        the TransitiveDep package.
include(CMakeFindDependencyMacro)
find_dependency(TransitiveDep)      # دیگه لازم نیست اینجا هم QUITE or REQUIRED بنویسیم.
                                    # چون همین که داخل دستور find_package در SimpleTest نوشتیم، کافیه و به این به ارث می‌رسه.
                                    # نیازی به دوباره کاری که امکان خطای انسانی رو افزایش می‌ده نیست.
                                    # توضیحات بیشتر در کتاب آموزش CMake

                                    # حالا که استفاده از این کتابخانه REQUIRED شده است، 
                                    # در صورت نبود find_dependency عملیات reconfigure کردن TutorialProject
                                    # که از کتابخانه SimpleTest استفاده میکنه، شکست می‌خوره
include(${CMAKE_CURRENT_LIST_DIR}/SimpleTestTargets.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/simpletest_discover_tests.cmake)
