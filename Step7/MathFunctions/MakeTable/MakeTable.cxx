// A simple program that builds a sqrt table
#include <cmath>
#include <fstream>
#include <iostream>

int main(int argc, char* argv[])
{
  // make sure we have enough arguments
  if (argc < 2) {                     // پس از اینجا میفهمیم که دومین آرگومانی که موقع اجرای این کد باید پاس داده میشد،
                                      // باید نام فایل باشه و نه -o
    return 1;
  }

  std::ofstream fout(argv[1], std::ios_base::out);  // اینجا هم از متغیر دوم، به عنوان نام فایل استفاده میکنه
  bool const fileOpen = fout.is_open();
  if (fileOpen) {
    fout << "double sqrtTable[] = {" << std::endl;              // داره چکار میکنه؟؟
                                      // عملیات code generating داخل فایل SqrtTable.h که در CMakeLists.txt قول دادیم بسازیم. 
    for (int i = 0; i < 10; ++i) {
      fout << sqrt(static_cast<double>(i)) << "," << std::endl;
    }
    // close the table with a zero
    fout << "0};" << std::endl;         // خروجی شبیه: double sqrtTable[] = {0, 1, 1.73205, 2, 2.64575, 3, 0};
    fout.close();
  }
  return fileOpen ? 0 : 1; // return 0 if wrote the file
}
