#include <MathFunctions.h>

// TODO5: Replace the following 5 lines with #include <SimpleTest.h>

// #define TEST(x) namespace
// #define REQUIRE(x)
// int main()
// {
// }

//                      :استفاده کنه SimpleTest های macro کد یک خطی ای که ما اضافه کردیم تا از
#include <SimpleTest.h>
// 
TEST("add")
{
  REQUIRE(mathfunctions::OpAdd(2.0, 2.0) == 4.0);
}

TEST("sub")
{
  REQUIRE(mathfunctions::OpSub(4.0, 2.0) == 2.0);
}

TEST("mul")
{
  REQUIRE(mathfunctions::OpMul(5.0, 5.0) == 25.0);
}

TEST("sqrt")
{
  REQUIRE(mathfunctions::sqrt(25.0) == 5.0);
}
