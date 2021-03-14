Added support for new C++ numeric literals. Note: The TeX side of this is rather jank.
Currently, binary literals are formatted just like hexadecimal literals except with a
superscript “b” instead of “#”.

Added support for C and C++ attributes.

Allowed “`default;`” as a function body.

Added more reserved words: `alignas`, `_Alignas`, `alignof`, `_Alignof`, `_Atomic`,
`_Bool`, `char8_t`, `char16_t`, `char32_t`, `co_await`, `_Complex`, `consteval`,
`constexpr`, `constinit`, `co_return`, `co_yield`, `_Decimal128`, `_Decimal32`,
`_Decimal64`, `decltype`, `_Generic`, `_Imaginary`, `noexcept`, `_Noreturn`, `nullptr`,
`static_assert`, `_Static_assert`, `thread_local`, `_Thread_local`.

Made `typeid` act like `sizeof`.

Added support for `enum class`, `enum struct`.

Alter handling of `template` and `typename`.  If you supply the option `+t`, the
identifier `N` in

```C++
template<typename N> class C { … };
```

will be made a reserved word so that it acts like a type name.