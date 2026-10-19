# TODO1: Add an executable target for the tests
add_executable(Tester)

# TODO2: Add the TestMathFunctions.cxx file to the test target's sources
target_sources(Tester
PRIVATE
    TestMathFunctions.cxx
)
# TODO3: Add the MathFunctions library to the test target's link libraries
target_link_libraries(Tester PRIVATE MathFunctions)

# TODO4: Write a function that takes a single operation name as an argument.
#        The function will call add_test() with the operation name as the NAME
#        of the test, and a COMMAND of the form: <TestTarget> <operation name>
function(TestThis operation)
    set(TestName "${operation}_TestApp")
    add_test(
        NAME        ${TestName}
        COMMAND     Tester  ${operation}
    )
endfunction()


# TODO5: Call the function for all four supported operations:
#          add, mul, sqrt, sub
TestThis(add)
TestThis(mul)
TestThis(sqrt)
TestThis(sub)