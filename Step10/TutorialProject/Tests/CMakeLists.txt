add_executable(TestMathFunctions)

target_sources(TestMathFunctions
  PRIVATE
    TestMathFunctions.cxx
)

# TODO1: Find the SimpleTest package. This should be a required dependency when
#        building tests.
find_package(SimpleTest 0.0.1 REQUIRED)   # من همینجوری الکی واسه کلاسش نوشتم Required.
                                          # دراصل باید می‌نوشتیم چون تست ها نمی تونن بدون این پکیج build بشن

# TODO2: Add the SimpleTest::SimpleTest target to TestMathFunctions
target_link_libraries(TestMathFunctions
  PRIVATE
    MathFunctions
    SimpleTest::SimpleTest        # اون هایی که :: دارن، اسم یک target عادی هستن که چون در install(EXPORT) شان یک 
                                  # namespace تعریف شده، اینجا هم باید از داخل یک namespace صدا شون بزنیم و آن را ذکر کنیم
)

# TODO3: Replace MathFunctionTest and all the calls to it with
#        simpletest_discover_tests called on TestMathFunctions

function(MathFunctionTest op)
  add_test(
    NAME ${op}
    COMMAND TestMathFunctions ${op}
  )
endfunction()

# MathFunctionTest(add)
# MathFunctionTest(mul)
# MathFunctionTest(sqrt)
# MathFunctionTest(sub)

simpletest_discover_tests(TestMathFunctions) # طبق رسم توابع تست، حتما اسم یک executable target ای رو باید بهش بدیم که مسئول Test باشه