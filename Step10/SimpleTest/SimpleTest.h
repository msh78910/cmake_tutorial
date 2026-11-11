#pragma once

#include <cstdio>
#include <map>
#include <string_view>

namespace SimpleTest {

using TestFunc = void (*)();

using Registry = std::map<std::string_view, TestFunc, std::less<>>;
inline Registry g_registry;     // دلیل inline کردن این متغیر global کتابخانه های header-only ممکنه توسط چندین فایل include بشن.
                                // و متغیرهای global این کتابخانه ها با اسمی یکسان، در فایل TU نهایی چندین بار declare بشن
                                // و خطای duplicate definition بگیریم.
                                // اما با inline کردن به کامپایلر/لینکر می‌گیم که این map در کل پروژه یکسان است

inline Registry& registry()
{
  return g_registry;
}

struct failure
{
  char const* file;
  int line;
  char const* expr;
};

struct Registrar
{
  template <std::size_t N>
  Registrar(char const (&name)[N], TestFunc f)
  {
    auto [it, inserted] =
      registry().emplace(std::string_view{ name, N ? (N - 1) : 0 }, f);
    if (!inserted) {
      std::printf("[  WARN    ] duplicate test name: %.*s\n",
                  int(it->first.size()), it->first.data());
    }
  }
};

inline Registry const& all()
{
  return registry();
}
inline TestFunc find(std::string_view name)
{
  auto it = registry().find(name);
  return it == registry().end() ? nullptr : it->second;
}

}

#define SIMPLETEST_CONCAT_(a, b) a##b
#define SIMPLETEST_CONCAT(a, b) SIMPLETEST_CONCAT_(a, b)

// عملیات ساخت یک تابع و ساخت Registrar (از جنس map) و ساخت امضای تابع بدون scopes {}
// این عبارات، همه شون در یک خط قرار دارن. با کامنت کردن خط بالایی، همه کامنت میشن
#define TEST(name_literal)                                                    \
  static void SIMPLETEST_CONCAT(_simpletest_fn_, __LINE__)();                 \
  static ::SimpleTest::Registrar SIMPLETEST_CONCAT(_simpletest_reg_,          \
                                                   __LINE__)(                 \
    name_literal, &SIMPLETEST_CONCAT(_simpletest_fn_, __LINE__));             \
  static void SIMPLETEST_CONCAT(_simpletest_fn_, __LINE__)()

// اصل عملیات انجام تست اینجا اتفاق می افته. اگه حاصل شرط true نباشه، اینجاست که ارور دقیق می‌سازه
// خود expr در if گذاشته میشه، چون حاصلش true/false است. اما متن کدش، در #expr تبدیل به رشته میشه برای چاپ 
// Minimal assertion
#define REQUIRE(expr)                                                         \
  do {                                                                        \
    if (!(expr))                                                              \
      throw ::SimpleTest::failure{ __FILE__, __LINE__, #expr };               \
  } while (0)

int main(int argc, char** argv)
{
  using namespace ::SimpleTest;

  std::string_view arg1 =
    (argc >= 2) ? std::string_view{ argv[1] } : std::string_view{};

  if (arg1 == "--list") {
    bool first = true;
    for (auto const& [name, _] : registry()) {
      if (!first)
        std::printf(",");
      std::printf("%.*s", int(name.size()), name.data());
      first = false;
    }
    std::printf("\n");
    return 0;
  }

  if (arg1 == "--test") {
    if (argc < 3) {
      std::printf("usage: %s [--list] [--test <name>]\n", argv[0]);
      return 2;
    }

#ifdef SIMPLETEST_CONFIG
    std::printf("SimpleTest built with config: %s\n", SIMPLETEST_CONFIG);
#endif

    std::string_view name{ argv[2] };
    auto it = registry().find(name);
    if (it == registry().end()) {
      std::printf("[ NOTFOUND ] %s\n", argv[2]);
      return 2;
    }

    int failed = 0;
    std::printf("[ RUN      ] %.*s\n", int(it->first.size()),
                it->first.data());
    try {
      it->second();
      std::printf("[       OK] %.*s\n", int(it->first.size()),
                  it->first.data());
    } catch (failure const& f) {
      std::printf("[  FAILED  ] %.*s at %s:%d : %s\n", int(it->first.size()),
                  it->first.data(), f.file, f.line, f.expr);
      failed = 1;
    } catch (...) {
      std::printf("[  FAILED  ] %.*s : unknown exception\n",
                  int(it->first.size()), it->first.data());
      failed = 1;
    }
    return failed;
  }

  if (argc > 1) {
    std::printf("usage: %s [--list] [--test <name>]\n", argv[0]);
    return 2;
  }

#ifdef SIMPLETEST_CONFIG
  std::printf("SimpleTest built with config: %s\n", SIMPLETEST_CONFIG);
#endif

  // Default: run all tests.
  int failed = 0;
  for (auto const& [name, func] : all()) {
    std::printf("[ RUN      ] %.*s\n", int(name.size()), name.data());
    try {
      func();
      std::printf("[       OK ] %.*s\n", int(name.size()), name.data());
    } catch (failure const& f) {
      std::printf("[  FAILED  ] %.*s at %s:%d : %s\n", int(name.size()),
                  name.data(), f.file, f.line, f.expr);
      failed = 1;
    } catch (...) {
      std::printf("[  FAILED  ] %.*s : unknown exception\n", int(name.size()),
                  name.data());
      failed = 1;
    }
  }
  return failed;
}
