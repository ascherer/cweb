Added support for new C++ numeric literals. Note: The TeX side of this is rather
jank. Currently, binary literals are formatted just like hexadecimal literals
except with a superscript “b” instead of “#”, and the `'` digit separator
becomes a thin space (`\,` in TeX). If you run `CTANGLE` with the option `+k`,
it will omit the separator in output, so that you can use it in C code as well
as in C++ code.

Added support for C and C++ attributes.

Allowed “`default;`” as a function body.

Added more reserved words: `alignas`, `_Alignas`, `alignof`, `_Alignof`,
`_Atomic`, `_Bool`, `char8_t`, `char16_t`, `char32_t`, `co_await`, `_Complex`,
`consteval`, `constexpr`, `constinit`, `co_return`, `co_yield`, `_Decimal128`,
`_Decimal32`, `_Decimal64`, `decltype`, `_Generic`, `_Imaginary`, `noexcept`,
`_Noreturn`, `nullptr`, `static_assert`, `_Static_assert`, `thread_local`,
`_Thread_local`.

Made `typeid` act like `sizeof`.

Added support for `enum class`, `enum struct`.

Altered handling of `template` and `typename`.  If you supply the option `+t`,
the identifier `N` in

```C++
template<typename N> class C { … };
```

will be made a reserved word so that it acts like a type name.

Quite a few new productions have been added to `prod.w`; they are all at the
end, even though many of them would belong more logically earlier in the file.
<<<<<<< 76a4f0af90fd9687d35e3edcf06ad1dc4067cf53
There are new kinds of scrap as well, mostly for handling attributes.

To test the major additions, run `CWEAVE` on `testthings.w`.
=======
There are new kinds of scrap as well, mostly for handling attributes. To test
the major additions, run `CWEAVE` on `testthings.w`.
>>>>>>> Added new literals to CTANGLE
