
# TODO1: Add an INTERFACE library called MathLogger
add_library(MathLogger INTERFACE)

# TODO2: Add an appropriate FILE_SET to MathLogger to capture the headers in
#        this directory
target_sources(MathLogger
    INTERFACE
        FILE_SET HEADERS
        FILES                                       # حتی نیازی به آوردن لیست فایل ها نیست، وقتی در header-only INTERFACE library
                                                    # قرار نیست هدر ها نصب بشن
            MathFormatting.h
            MathLogger.h
            MathOutput.h
)