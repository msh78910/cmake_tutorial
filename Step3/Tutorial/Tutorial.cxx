// A simple program that computes the square root of a number

// TODO3: Include <format>
#include <format>

#include <iostream>
#include <string>

#include <MathFunctions.h>

using namespace std;

int main(int argc, char* argv[])
{
  if (argc < 2) {
    // TODO4: Convert the print to use std::format
    std::string formatted_str = std::format("Usage: {0} number", argv[0]);
    std::cout << formatted_str << std::endl;
    // std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  // convert input to double
  double const inputValue = std::stod(argv[1]);

  // calculate square root
  double const outputValue = mathfunctions::sqrt(inputValue);
  // TODO5: Convert the print to use std::format
  std::string formatted_str = std::format("The square root of {0} is {1}!!!", inputValue, outputValue);
  std::cout << formatted_str << std::endl;
  // std::cout << "The square root of " << inputValue << " is " << outputValue << std::endl;
}
