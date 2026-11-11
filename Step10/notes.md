<div dir='rtl'>

تارگت های test خودشون اجرایی (executable) نیستن. بلکه کتابخانه (library) هستن
اما فایل تستی که برای نرم افزار می سازیم، باید از نظر cmake یک executable باشه

در فایل CML داخل SimpleTest اومده:

```cmake
# TODO7: Add the TransitiveDep::TransitiveDep target to the SimpleTest interface
#        library's links. Remember that interface libraries can only have
#        interface properties.
```

#### سوال
> یعنی امکان نداره که یک کتابخانه interface در جزئیات پیاده سازی خودش به یک 
 header دیگه نیاز داشته باشه که این باعث بشه بخواد اون رو PUBLIC به خودش link کنه؟
 
#### جواب: 
> public بودن، یا private بودن، فقط برای build کردن خود کتابخانه بدرد می‌خوره
 از اونجایی که کتابخانه های interface خودشون کامپایل نمی‌شن، و صرفا مشتی اطلاعات و تنظیمات 
 هستن که باید به سایرین منتفل بشن، اگه دارای header ای باشن که در پیاده سازی به 
 header دیگه ای وابسته باشه، خودش این وابستگی رو به کتابخانه مصرف کننده منتقل می‌کنه
 تا همونجایی که قراره کامپایل بشه، درستی #indlude کردنش چک بشه



### 2. آیا Interface Library می‌تواند وابستگی داشته باشد؟

بله! دقیقاً همان چیزی که گفتی.
فرض کن ساختار زیر را داریم:

```
SimpleTest/
├── include/
│   └── SimpleTest.hpp
│
└── CMakeLists.txt

TransitiveDep/
└── include/
    └── TransitiveDep.hpp
```

فرض کن `SimpleTest.hpp` داخل خودش از `TransitiveDep.hpp` استفاده می‌کند:

```
#include <TransitiveDep.hpp>
```

در این شرایط باید وابستگی را به CMake معرفی کنیم:

```
target_link_libraries(SimpleTest
    INTERFACE
        TransitiveDep
)
```

چرا `INTERFACE`؟
چون `SimpleTest` خودش چیزی را کامپایل نمی‌کند که به `TransitiveDep` نیاز داشته باشد؛ بلکه هر targetی که از SimpleTest استفاده می‌کند، باید به TransitiveDep هم دسترسی داشته باشد.
به این ویژگی Transitive Dependency می‌گویند.


### 4. تفاوت INTERFACE، PUBLIC و PRIVATE

برای اینکه موضوع کاملاً جا بیفتد:

| Scope       | خود target | مصرف‌کنندگان target |
| ----------- | ---------- | ------------------- |
| `PRIVATE`   | بله        | خیر                 |
| `PUBLIC`    | بله        | بله                 |
| `INTERFACE` | خیر        | بله                 |

این جدول برای targetهای معمولی است؛ `INTERFACE` library استثنای مهمی دارد:

| Target type         | Scopeهای مجاز   |
| ------------------- | --------------- |
| `STATIC` / `SHARED` | هر سه           |
| `INTERFACE`         | فقط `INTERFACE` |

جمع‌بندی: اشتباه رایج این است که تصور کنیم `INTERFACE` library یعنی کتابخانه‌ای که هیچ وابستگی‌ای ندارد. درحالی‌که این کتابخانه‌ها می‌توانند وابستگی‌های متعدد داشته باشند و آن‌ها را به مصرف‌کنندگان خود منتقل کنند؛ فقط خودشان مرحله‌ی کامپایل و لینک مستقل ندارند.

</div>