@* Concatenated string literals.

@c
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>

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
const wchar_t* wide_literal = L"Hällö, W€lt!";
printf("%ls\n", wide_literal);

@ @<Concatenated string...@>=
const char* conc_literal = "Hello, " "World! (" __DATE__ ")";
printf("%s\n", conc_literal);

@ @<Concatenated wide string...@>=
const wchar_t* wide_conc_literal = L"Hällö, " L"W€lt! (" __DATE__ ")";
printf("%ls\n", wide_conc_literal);

@* Index.
