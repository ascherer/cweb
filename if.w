@* If.

@c
#include <stdio.h>
#include <stdlib.h>
@;@/
int main(void)
{
	printf("Start %s line %d\n", __FILE__, __LINE__);

#ifdef STAT
	printf("Start defined STAT in %s line %d\n", __FILE__, __LINE__);
	@<Code for defined |STAT|@>@;
	printf("End defined STAT in %s line %d\n", __FILE__, __LINE__);
#elif defined DEBUG
	printf("Start defined DEBUG in %s line %d\n", __FILE__, __LINE__);
	@<Code for defined |DEBUG|@>@;
	printf("End defined DEBUG in %s line %d\n", __FILE__, __LINE__);
#else
	printf("Start undefined STAT in %s line %d\n", __FILE__, __LINE__);
	@<Code for undefined |STAT|@>@;
	printf("End undefined STAT in %s line %d\n", __FILE__, __LINE__);
#endif
	printf("End %s line %d\n", __FILE__, __LINE__);

	return EXIT_SUCCESS;
}

@ @<Code for defined |STAT|@>=
	printf("Code for defined STAT in %s line %d\n", __FILE__, __LINE__);

@ @<Code for undef...@>=
	printf("Code for undefined STAT in %s line %d\n", __FILE__, __LINE__);

@ @<Code for defined |DEBUG|@>=
	printf("Code for defined DEBUG in %s line %d\n", __FILE__, __LINE__);

@* Index.
