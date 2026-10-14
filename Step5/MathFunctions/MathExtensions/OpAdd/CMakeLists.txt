add_library(OpAdd OBJECT)

target_sources(OpAdd
  PRIVATE
    OpAdd.cxx

  INTERFACE
    FILE_SET HEADERS
    FILES
      OpAdd.h                   # استفاده از این هدر ها در کتابخانه object صرفا برای سهولت dependency tracking است
                                # خودشون که کامپایل نمیشن. صرفا باعث میشن اگه تغییری در این فایل ها ایجاد شد، cmake بفهمه
                                # و این کتابخانه رو از اول compile کنه
                                
                                # اگه نمی گذاشتیمش، cmake از کجا میخواست بفهمه که این هدر رو باید برداره و مال OpAdd.cxx است؟
)
