@* If. In this weird little concoction of a \.{CWEB} program, we test the new
feature of \.{CTANGLE} to allow a wild mixture of preprocessor \.{\#if}---%
\.{\#elif}---\.{\#else} logic and interspersed \.{@@<section code@@>}, trying to
keep the \.{\#line} information intact while jumping around in the non-linear
\.{CWEB} code, for the sake of the preprocessor, the \CEE/ compiler, and the
debugger.

You can compile this creation with either \.{-DSTAT} or \.{-DDEBUG}, none of
these, or both.

@d print_where(S) printf( S " in %s line %d\n", __FILE__, __LINE__)

@c
#include <stdio.h>
#include <stdlib.h>
@;@/
int main(void)
{
	print_where("Start");

#ifdef STAT
	print_where("Start defined STAT");
	@<Code for defined |STAT|@>@;

#	if defined DEBUG
	print_where("Start defined DEBUG");
	@<Code for defined |DEBUG|@>@;
	print_where("End defined DEBUG");
#	endif

	print_where("End defined STAT");
#elif defined DEBUG
	print_where("Start defined DEBUG");
	@<Code for defined |DEBUG|@>@;
	print_where("End defined DEBUG");
#else
	print_where("Start undefined STAT");
	@<Code for undefined |STAT|@>@;
	print_where("End undefined STAT");
#endif
	print_where("End");

	return EXIT_SUCCESS;
}

@ @<Code for defined |STAT|@>=
	print_where("Code for defined STAT");

@ @<Code for undef...@>=
	print_where("Code for undefined STAT");

@ @<Code for defined |DEBUG|@>=
	print_where("Code for defined DEBUG");

@* Index.
