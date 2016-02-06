\def\cweb{\.{CWEB}}

@* Introduction.
This is the main segment for the calculator program from Chapter 4
of Kernighan and Ritchie's {\it The C Programming Language}, which
I'm using as a test to see how \cweb\ handles function prototypes,
separately compiled modules, and the like.

Since this is being typed in from the \Cee\ book, which was not
written with \cweb\ in mind, it probably won't seem as neatly
presented as most \cweb\ code.

Here is the only unnamed code module in this file, giving an overview
of the program:

@c
@<Included header files@>@;
@<Main program@>

@ We need two header files from the \Cee\ library.
One provides the standard I/O functions, the other provides
the function that converts strings to floating point numbers (|atof|).

@<Included...@>=
#include <stdio.h>
#include <stdlib.h> /* for |atof()| */

@ We also need header files from other segments of this program,
declaring the interface that we need in order to recognize the functions
defined in those segments.

@<Included...@>=
#include "getop.h"	/* for |getop()| */
#include "stack.h"	/* for |push()| and |pop()| */

@* The main program.
This is the top level loop for our reverse Polish calculator.

@d MAXOP 100	/* the maximum size allowed for a single operand or operator */

@<Main program@>=
main()
{
	int type;
	char s[MAXOP];
	@<Other local variables of |main|@>@;@#
	
	while ((type = getop(s)) != EOF) {
		switch (type) {
		@<Case for numbers@>@;
		@<Cases for commutative operators@>@;
		@<Cases for non-commutative operators@>@;
		@<Case for newlines@>@;
		default:
			printf("error: unknown command %s\n", s);
			break;
		}
	}
	return 0;
}

@ Non-commutative operators are tricky.  We'd like to be able to say
something like\par
\smallskip\centerline{|push(pop() - pop());|}\smallskip\noindent
but that would be wrong, because it assumes that the |pop()|s are
executed in a certain order, which \Cee\ does not guarantee (the
compiler is free to determine order of evaluation of function calls
in a single expression).  So we have to use an explicit temporary to
make sure that the topmost stack element becomes the second and not
the first operand.

@<Cases for non-commutative operators@>=
	case '-':
		op2 = pop();
		push(pop() - op2);
		break;
	case '/':
		op2 = pop();
		if (op2 != 0.0)
			push(pop() / op2);
		else
			printf("error: zero divisor\n");
		break;

@ Here we declare the variable we used above.
@<Other local variables of |main|@>=
	double op2;

@ Having seen the handling of non-commutative operators, you can
appreciate the comparative simplicity of handling commutative ones.

@<Cases for commutative operators@>=
	case '+':
		push(pop() + pop());
		break;
	case '*':
		push(pop() * pop());
		break;

@ The handling of numbers is easy: we parse the string that represents
the number, obtaining an actual numerical value, and we push that
value onto the stack.

@<Case for numbers@>=
	case NUMBER:
		push(atof(s));
		break;

@ When we see a newline character, we print the top element of the stack.

@<Case for newlines@>=
	case '\n':
		printf("\t%.8g\n", pop());
		break;

@* Index.
