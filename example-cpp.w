@* String literals in \CPLUSPLUS/.

@c
#include <iostream>
 
char array1[] = "Foo" "bar";
// same as
char array2[] = { 'F', 'o', 'o', 'b', 'a', 'r', '\0' };

const char* s1 = @=R"foo(@>@|
@=Hello@>@|
@=World@>@|
@=)foo"@>;
//same as
const char* s2 = "\nHello\nWorld\n";
 
int main()
{
    std::cout << array1 << '\n';
    std::cout << array2 << '\n';
      
    std::cout << s1;
    std::cout << s2;
}

@* Index.
