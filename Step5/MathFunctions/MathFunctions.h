#pragma once

// TODO10: Include <OpAdd.h>, <OpMul.h>, and <OpSub.h>
#include <OpAdd.h>          // سوال: باتوجه به اینکه فایل declaration و definition قراره با هم ادغام بشن،
#include <OpMul.h>          // حالا که MathFunctions مون، این سه object libraries رو بصورت public لینک کرده،
#include <OpSub.h>          // آیا فرقی داشت که این هدر ها رو کجا include کنیم؟ (در .cxx یا .h)
                            
namespace mathfunctions {   // جواب: بله فرق داشت. این ۲ فایل قرار نیست ادغام شن. جدا کامپایل میشن.
                            // پس حتما باید در .h file باشه که مصرف کننده ای که اینو include میکنه، بتونه این سه تا رو ببینه.
double sqrt(double x);      // برای همین هم این سه‌تا رو PUBLIC لینک شون کردیم که مصرف کننده هم ببینه.
}                           // اونایی رو هم که فقط برای پیاده سازی توابع MathFunctions لازم اند، فقط باید داخل 
                            // .cxx مون include شن