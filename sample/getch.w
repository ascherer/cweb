\def\cweb{\.{CWEB}}

@* Introduction.
This is a segment from the calculator program from Chapter 4
of Kernighan and Ritchie's {\it The C Programming Language}, which
I'm using as a test to see how \cweb\ handles function prototypes,
separately compiled modules, and the like.

This segment defines the |getch| and |ungetch| procedures, which
perform character-by-character reading and un-reading of the input stream.

Since this is being typed in from the \Cee\ book, which was not
written with \cweb\ in mind, it probably won't seem as neatly
presented as most \cweb\ code.

Here is the only unnamed code module in this file.

@c
@<Included header files@>@;
@<Private variables for this source file@>@;
@<Functions defined in this source file@>

@ We need one header file from the \Cee\ library.
It provides the standard I/O functions.

@<Included...@>=
#include <stdio.h>

@ This source file defines two functions.

@<Functions defined in this source file@>=
	@<Definition of |getch()|@>@;
	@<Definition of |ungetch()|@>

@ Each function defined here has to have its prototype exported,
so that functions in other source files that want to call the
functions defined here will have the necessary declarations available.

@<Function prototypes to be exported@>=
	@<Function prototype for |getch()|@>;
	@<Function prototype for |ungetch()|@>;

@ In this module we collect up information that needs to be written to
the header file \.{getch.h} so that other source files that want to
make use of the function defined here will have the necessary declarations
available.

@(getch.h@>=
	@<Function prototypes to be exported@>

@* The functions |getch()| and |ungetch()|.

@ First we define the buffer that the routines
|getch()| and |ungetch()| share.

@d BUFSIZE 100	/* maximum depth of val stack */

@<Private variables for this source file@>=
	static char buf[BUFSIZE];	/* buffer for |ungetch| */
	static int  bufp = 0;		/* next free position in |buf| */

@ 
@<Function prototype for |getch()|@>=
int getch(void)

@ 
@<Definition of |getch()|@>=
@<Function prototype for |getch()|@>
{
	return (bufp > 0) ? buf[--bufp] : getchar();
}

@ 
@<Function prototype for |ungetch()|@>=
void ungetch(int c)

@ 
@<Definition of |ungetch()|@>=
@<Function prototype for |ungetch()|@>
{
	if (bufp > BUFSIZE)
		printf("ungetch: too many characters\n");
	else
		buf[bufp++] = c;
}

@* Index.
