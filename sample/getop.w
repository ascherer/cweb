\def\cweb{\.{CWEB}}

@* Introduction.
This is a segment from the calculator program from Chapter 4
of Kernighan and Ritchie's {\it The C Programming Language}, which
I'm using as a test to see how \cweb\ handles function prototypes,
separately compiled modules, and the like.

This segment defines the |getop| procedure, which reads the input
looking for an operator or operand.

Since this is being typed in from the \Cee\ book, which was not
written with \cweb\ in mind, it probably won't seem as neatly
presented as most \cweb\ code.

Here is the only unnamed code module in this file.

@c
@<Included header files@>@;
@<Public |#define| statements to be exported@>@;
@<Functions defined in this source file@>

@ We need two header files from the \Cee\ library.
One provides functions for recognizing digits and other character classes.
The other provides standard I/O definitions, and we need it only for
the definition of |EOF|.

@<Included...@>=
#include <ctype.h>
#include <stdio.h>

@ We also need a header file from another segment of this program,
declaring the interface that we need in order to recognize the functions
defined in that segment.

@<Included...@>=
#include "getch.h"

@ As it happens, this file defines only one function: |getop()|.

@<Functions defined in this source file@>=
	@<Definition of |getop()|@>

@ The function defined here has to have its prototype exported,
so that functions in other source files that want to call this
one will have the necessary declaration available.

@<Function prototypes to be exported@>=
	@<Function prototype for |getop()|@>;

@ In this module we collect up information that needs to be written to
the header file \.{getop.h} so that other source files that want to
make use of the function defined here will have the necessary declarations
available.

@(getop.h@>=
	@<Public |#define| statements to be exported@>@;
	@<Function prototypes to be exported@>

@* The function |getop()|.

@<Function prototype for |getop()|@>=
int getop(char s[])

@ 
@<Definition of |getop()|@>=
@<Function prototype for |getop()|@>
{
	int i, c;
	
	while ((s[0]= c = getch()) == ' ' || c == '\t')
		;
	s[1] = '\0';
	if (!isdigit(c) && c != '.')
		return c; /* not a number */
	i = 0;
	if (isdigit(c))	/* collect integer part */
		while (isdigit(s[++i] = c = getch()))
			;
	if (c == '.')	/* collect fraction part */
		while (isdigit(s[++i] = c = getch()))
			;
	s[i] = '\0';
	if (c != EOF)
		ungetch(c);
	return NUMBER;
}

@ This defines the signal that |getop()| returns when it sees
a number (any number).  This is used within the code of |getop()|
{\it and\/} in the routine that calls |getop()| (which means it
must be included in the header file \.{getop.h}).

@<Public |#define| statements to be exported@>=
#define NUMBER '0'

@* Index.
