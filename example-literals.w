@* Concatenated string literals.

@c
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>

@<Function return@>@;

int main(void)
{
   setlocale(LC_ALL, "en_US.utf8");
   @<String literal@>@;
   @<Wide string literal@>@;
   @<Concatenated string literal@>@;
   @<Concatenated wide string literal@>@;
   return EXIT_SUCCESS;
}

@ @<String literal@>=
const char* literal = __DATE__;
printf("%s\n", literal);

@ @<Wide string literal@>=
const wchar_t* wide_literal = L"Hello, World!";
printf("%ls\n", wide_literal);

@ @<Concatenated string...@>=
const char* conc_literal = "Hello, " "World! (" __DATE__ ")";
printf("%s\n", conc_literal);

@ @<Concatenated wide string...@>=
const wchar_t* wide_conc_literal = L"Hello, " L"World! (" __DATE__@= @>L")";
printf("%ls\n", wide_conc_literal);

@ @<Function...@>=
const wchar_t* crap(void)
{
   return (L"Hello, World\n");
}

@* Index.
