\def\cweb{\.{CWEB}}

@* Introduction.
This is a segment from the calculator program from Chapter 4
of Kernighan and Ritchie's {\it The C Programming Language}, which
I'm using as a test to see how \cweb\ handles function prototypes,
separately compiled modules, and the like.

This segment defines the |push| and |pop| procedures, which manage
the operand stack.

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
	@<Definition of |push()|@>@;
	@<Definition of |pop()|@>

@ Each function defined here has to have its prototype exported,
so that functions in other source files that want to call the
functions defined here will have the necessary declarations available.

@<Function prototypes to be exported@>=
	@<Function prototype for |push()|@>;
	@<Function prototype for |pop()|@>;

@ In this module we collect up information that needs to be written to
the header file \.{stack.h} so that other source files that want to
make use of the function defined here will have the necessary declarations
available.

@(stack.h@>=
	@<Function prototypes to be exported@>

@* The functions |push()| and |pop()|.

@ This defines the stack data structure that the routines |push()|
and |pop()| share.

@d MAXVAL 100	/* maximum depth of val stack */

@<Private variables for this source file@>=
	static int sp = 0;		/* next free stack position */
	static double val[MAXVAL];	/* value stack */

@ 
@<Function prototype for |push()|@>=
void push(double f)

@ 
@<Definition of |push()|@>=
@<Function prototype for |push()|@>
{
	if (sp < MAXVAL)
		val[sp++] = f;
	else
		printf("error: stack full, can't push %g\n", f);
}

@ 
@<Function prototype for |pop()|@>=
double pop(void)

@ 
@<Definition of |pop()|@>=
@<Function prototype for |pop()|@>
{
	if (sp > 0)
		return val[--sp];
	else {
		printf("error: stack empty\n");
		return 0.0;
	}
}

@* Index.
