% PRIMES example of WEB/CWEB portability.  This documentation was
% originally published in the article ``Literate Programming'' by Donald
% E. Knuth in ``The Computer Journal'', May 1984, and later in the book
% ``Literate Programming'', October 1991, where it appeared as the first
% example of WEB programming for Pascal.  It has been translated into
% CWEB by Andreas Scherer to show the ease of portability between
% Pascal/WEB and C/CWEB.  As little changes as possible were made, so that
% the section numbering of the Pascal and the C version are identical,
% except that a small list of related literature was appended at the end.
% Minor changes to include extra C functionality are mentioned in the text
% that follows.  The `cite' feature of CWEB 2.8 is used.

% This program is distributed WITHOUT ANY WARRANTY, express or implied.
% WEB Version --- Don Knuth, 1986
% CWEB Version --- Andreas Scherer, 1993

% Copyright (c) 1993 Andreas Scherer

% Permission is granted to make and distribute verbatim copies of this
% document provided that the copyright notice and this permission notice
% are preserved on all copies.

% Permission is granted to copy and distribute modified versions of this
% document under the conditions for verbatim copying, provided that the
% entire resulting derived work is distributed under the terms of a
% permission notice identical to this one.

\font\csc=cmcsc10
\def\PASCAL/{{\csc Pascal\spacefactor1000}}
\def\[{\ifhmode\ \fi$[\mkern-2mu[$}
\def\]{$]\mkern-2mu]$\ }
\def\Section{\mathhexbox278}
\hyphenation{Dijk-stra}

\def\title{PRIMES (C Version 1.1)}
\def\topofcontents{\null\vfill
  \centerline{\titlefont Printing prime numbers}
  \vskip15pt
  \centerline{(C Version 1.1)}
  \vfill}
\def\botofcontents{\vfill
  \noindent Copyright \copyright\ 1993 Andreas Scherer
  \bigskip
  \noindent Permission is granted to make and distribute verbatim copies of
  this document provided that the copyright notice and this permission
  notice are preserved on all copies.
  \smallskip
  \noindent Permission is granted to copy and distribute modified versions
  of this document under the conditions for verbatim copying, provided that
  the entire resulting derived work is distributed under the terms of a
  permission notice identical to this one.}

@* Printing primes: An example of {\tt CWEB}. The following program is
essentially the same as Edsger Dijkstra's@^Dijkstra, Edsger@> ``first
example of step-wise program composition,'' found on pages 26--39 of his
{\sl Notes on Structured Programming\/} [1], as presented by Donald E.
Knuth@^Knuth, Donald E.@> on pages 103--112 of his {\sl Literate
Programming\/} [2], but it has been translated into the \.{CWEB} language
by Andreas Scherer@^Scherer, Andreas@>.
@.CWEB@>@.WEB@>

\[Double brackets will be used in what follows to enclose comments relating
to \.{CWEB} itself, because the chief purpose of this program is to introduce
the reader to the \.{CWEB} style of documentation. \.{CWEB} programs are always
broken into small sections, each of which has a serial number; the present
section is number 1.\]

Dijkstra's program prints a table of the first thousand prime numbers. We
shall begin as he did, by reducing the entire program to its top-level
description. \[Every section in a \.{CWEB} program begins with optional {\it
commentary\/} about that section, and ends with optional {\it program
text\/} for the section. For example, you are now reading part of the
commentary in \Section1, and the program text for \Section1 immediately
follows the present paragraph. Program texts are specifications of \CEE/ 
programs; they either use \CEE/ language directly, or they use angle brackets
to represent \CEE/ code that appears in other sections. For example, the
angle-bracket notation `|@<Program to print...@>|' is \.{CWEB}'s way of saying
the following: ``The \CEE/ text to be inserted here is called `Program to
print $\ldots$ numbers', and you can find out all about it by looking at
section 2.'' One of the main characteristics of \.{CWEB} is that different
parts of the program are usually abbreviated, by giving them such an
informal top-level description.\]

@c
@<Program to print the first thousand prime numbers@>

@ This program has no input, because we want to keep it rather simple. The
result of the program will be to produce a list of the first thousand prime
numbers, and this list will appear on the |stdout| file.

Since there is no input, we declare the value |MM==1000| as a compile-time
constant. The program itself is capable of generating the first |MM| prime
numbers for any positive |MM|, as long as the computer's finite limitations
are not exceeded. The boolean values |TRUE| and |FALSE| are defined.

\[The program text below specifies the ``expanded meaning'' of `|@<Program
to print...@>|'; notice that it involves the top-level descriptions of two
other sections. When those top-level descriptions are replaced by their
expanded meanings, a syntactically correct \CEE/ program will be obtained.\]

@d MM    1000
@d TRUE     1
@d FALSE    0

@<Program to print...@>=
#include <stdio.h>

void main(void)
   {
   @<Variables of the program@>@;@#

   @<Print the first |MM| prime numbers@>@;
   }

@* Plan of the program. We shall proceed to fill out the rest of the
program by making whatever decisions seem easiest at each step; the idea
will be to strive for simplicity first and efficiency later, in order to
see where this leads us. The final program may not be optimum, but we want
it to be reliable, well motivated, and reasonably fast.

Let us decide at this point to maintain a table that includes all of the
prime numbers that will be generated, and to separate the generation
problem from the printing problem.

\[The \.{CWEB} description you are reading once again follows a pattern that
will soon be familiar: A typical section begins with comments and ends with
program text. The comments motivate and explain noteworthy features of the
program text.\]

@<Print the first...@>=
   @<Fill table |p| with the first |MM| prime numbers@>@;
   @<Print table |p|                                 @>@;

@ How should table |p| be represented? Two possibilities suggest
themselves: We could construct a sufficiently large array of boolean values
in which the |k|th entry is |TRUE| if and only if the number |k| is prime;
or we could build an array of integers in which the |k|th entry is the
|k|th prime number. Let us choose the latter alternative, by introducing an
integer array called |p[MM]|.

In the documentation below, the notation `|p[k]|' will refer to the |k|th
element of array |p|, while `$p_k$' will refer to the |k|th prime number.
If the program is correct, |p[k-1]| will either be equal to $p_k$ or it
will not yet have been assigned any value. (Note that arrays in \CEE/ are
indexed starting from 0 and not from 1 as in \PASCAL/)
@^Differences between \PASCAL/ and \CEE/@>

\[Incidentally, our program will eventually make use of several more
variables as we refine the data structures. All of the sections where
variables are declared will be called `|@<Variables of...@>|'; the
number `4' in this name refers to the present section, which is the first
section to specify the expanded meaning of `|@<Variables of...@>|'.
The note `{\eightrm See also~$\ldots$}' refers to all of the other sections
that have the same top-level description. The expanded meaning of
`|@<Variables of...@>|' consists of all the program texts for this name,
not just the text found in \Section4.\]

@<Variables of the program@>=
   int p[MM]; /* the first |MM| prime numbers, in increasing order */

@* The output phase. Let's work on the second part of the program first.
It's not as interesting as the problem of computing prime numbers; but the
job of printing must be done sooner or later, and we might as well do it
sooner, since it will be good to have it done. \[And it is easier to learn
\.{CWEB} when reading a program that has comparatively few distracting
complications.\]

Since |p| is simply an array of integers, there is little difficulty in
printing the output, except that we need to decide upon a suitable output
format. Let us print the table on separate pages, with |RR| rows and |CC|
columns per page, where every column is |WW| character positions wide. In
this case we shall choose |RR==50|, |CC==5|, and |WW==10|, so that
the first 1000~primes will appear on four pages. The program will not assume
that |MM| is an exact multiple of |RR@t${}\times{}$@>CC|.
@^output format@>
@^Differences between \PASCAL/ and \CEE/@>

@d RR 50 /* this many rows will be on each page in the output         */
@d CC  5 /* this many columns will be on each page in the output      */
@d WW 10 /* this many character positions will be used in each column */

@ In order to keep this program reasonably free of notations that are
uniquely \CEE/esque, \[and in order to illustrate more of the facilities of
\.{CWEB},\] a few macro definitions for low-level output instructions are
introduced here. All of the output-oriented commands in the remainder of
the program will be stated in terms of five simple primitives called
|print_string|, |print_integer|, |print_entry|, |new_line|, and |new_page|.

\[Sections of a \.{CWEB} program are allowed to contain {\it macro
definitions} between the opening comments and the closing program text. The
general format for each section is actually tripartite: commentary, then
definitions, then program. Any of the three parts may be absent; for
example, the present section contains no program text.\]

\[Simple macros simply substitute a bit of \CEE/ code for an identifier.
Parametric macros are similar, but they also substitute an argument
wherever `A' occurs in the macro definition. (You may \#|define| macros with
more than just one parameter in \CEE/.) The first three macro definitions
here are parametric; the other two are simple. (I am using |fputs| in order
to get rid of the surplus `new line' character inserted by |puts|, and I am
using |putc| instead of |putchar| for consistency in notation.)\]
@^Differences between \PASCAL/ and \CEE/@>

@d print_string(A)
   fputs(A,stdout) /* put a given string into the |stdout| file */
@d print_integer(A)
   printf("%d",A) /* put a given integer into the |stdout| file, in decimal
   notation, using only as many digit positions as necessary */
@d print_entry(A)
   printf("%*d",WW,A) /* like |print_integer|, but |WW| character positions
   are filled, inserting blanks at the left */
@d new_line putc('\n',stdout); fflush(stdout)
   /* advance to a new line in the |stdout| file */
@d new_page putc('\f',stdout); fflush(stdout)
   /* advance to a new page in the |stdout| file */

@ Several variables are needed to govern the output process. When we begin
to print a new page, the variable |page_number| will be the ordinal number
of that page, and |page_offset| will be such that |p[page_offset-1]| is the
first prime to be printed. Similarly, |p[row_offset-1]| will be the first
prime in a given row.

\[Notice the notation `$\mathrel+\E$' below; this indicates that the present
section has the same name as a previous section, so the program text will
be appended to some text that was previously specified.\]

@<Variables of the program@>=
   int page_number;
      /* one more than the number of pages printed so far */
   int page_offset;
      /* index into |p| for the first entry on the current page */
   int row_offset;
      /* index into |p| for the first entry in the current row */
   int c;
      /* runs through the columns in a row (|0@t${}\ldots{}$@>CC|) */

@ Now that appropriate auxiliary variables have been introduced, the
process of outputting table |p| almost writes itself.

@<Print table |p|@>={
   page_number = page_offset = 1;
   while(page_offset <= MM) {
      @<Output a page of answers@>@;
      page_number++;
      page_offset += RR*CC;
      }
   }

@ A simple heading is printed at the top of each page.
@^output format@>
@^page headings@>
@<Output a page of answers@>={
   print_string("The First ");@+               print_integer(MM);
   print_string(" Prime Numbers --- Page ");@+ print_integer(page_number);
   new_line;@+ new_line; /* there's a blank line after the heading */
   for(row_offset = page_offset; row_offset <= page_offset + RR - 1;
      row_offset++)
      @<Output a line of answers@>@;
   new_page;
   }

@ The first row will contain
$$
  p[1-1],\thinspace p[1+\.{RR}-1],\thinspace
  p[1+2\cdot\.{RR}-1],\thinspace \ldots;
$$
a similar pattern holds for each value of the |row_offset|.

@<Output a line of answers@>={
   for(c=0; c<=CC-1; c++) {
      if(row_offset+c*RR <= MM)
         print_entry(p[row_offset + c*RR -1]);
      }
   new_line;
   }

@* Generating the primes. The remaining task is to fill table |p| with the
correct numbers. Let us do this by generating its entries one at a time:
Assuming that we have computed all primes that are |j| or less, we will
advance |j| to the next suitable value, and continue doing this until the
table is completely full.

The program includes a provision to initialize the variables in certain
data structures that will be introduced later.

@<Fill table |p| with...@>=
   @<Initialize the data structures@>@;
   while(k < MM) {
      @<Increase |j| until it is the next prime number@>@;
      k++;@+ p[k-1] = j;
      }

@ We need to declare the two variables |j| and |k| that were just
introduced.

@<Variables of the...@>=
   int j; /* all primes ${}\leq j$ are in table |p|                    */
   int k; /* this many primes are in table |p| (|0@t${}\ldots{}$@>MM|) */

@ So far we haven't needed to confront the issue of what a prime number is.
But everything else has been taken care of, so we must delve into a bit of
number theory now.

By definition, a number is called prime if it is an integer greater than 1
that is not evenly divisible by any smaller prime number. Stating this
another way, the integer $j>1$ is not prime if and only if there exists a
prime number $p_n<j$ such that |j| is a multiple of $p_n$.
@^prime number, definition of@>

Therefore the section of the program that is called `|@<Increase |j|...@>|'
could be coded very simply: `|do { j++; @<Give to...@> } while(!j_prime)@;|'.
And to compute the boolean value |j_prime|, the following would suffice:
`|j_prime=TRUE; for(n=1; n<=k; n++) @<If |p[n-1]|...@>@;|'.

@ However, it is possible to obtain a much more efficient algorithm by
using more facts of number theory. In the first place, we can speed things
up a bit by recognizing that $p_1=2$ and that all subsequent primes are
odd; therefore we can let |j| run through odd values only. Our Program now
takes the following form:

@<Increase...@>=
   do@+ {
      j += 2;
      @<Update variables that depend on |j|                 @>@;
      @<Give to |j_prime| the meaning: |j| is a prime number@>@;
      }@+ while(!j_prime);

@ The |do| loop in the previous section introduces a boolean variable
|j_prime|, so that it will not be necessary to resort to a |goto|
statement. (We are following Dijkstra~[1], not Knuth~[3].)
@^Dijkstra, Edsger@>
@^Knuth, Donald E.@>

@<Variables...@>=
   unsigned char j_prime; /* is |j| a prime number? */

@ In order to make the odd-even trick work, we must of course initialize
the variables |j|, |k|, and |p[0]| as follows.

@<Initialize...@>=
   j = k = 1;@+ p[0] = 2;

@ Now we can apply more number theory in order to obtain further economies.
If |j| is not prime, its smallest prime factor $p_n$ will be $\sqrt{j}$ or
less. Thus if we know a number |ord| such that
$$
  p[ord-1]^2>j,
$$
and if |j| is odd, we need only test for divisors in the set
$\{$|p[1]|$,\ldots,$|p[ord-2]|$\}$. This is much faster than testing
divisibility by the full set $\{$|p[1]|$,\ldots,$|p[k-1]|$\}$, since |ord|
tends to be much smaller than |k|. (Indeed, when |k| is large, the celebrated
``prime number theorem'' implies that the value of |ord| will be approximately
$2\sqrt{k}/{\rm ln}k$.)

Let us therefore introduce |ord| into the data structure. A moment's
thought makes it clear that |ord| changes in a simple way when |j|
increases, and that another variable |square| facilitates the updating
process.

@<Variables...@>=
   int ord; /* the smallest index ${}\geq2$ such that $p^2_{ord}>j$ */
   int square; /* |square|${}=p^2_{ord}$ */

@ @<Initialize...@>=
   ord=2;@+ square=9;

@ The value of |ord| will never get larger than a certain value |ORD_MAX|,
which must be chosen sufficiently large. It turns out that |ord| never
exceeds 30 when |MM==1000|.

@d ORD_MAX 30 /* $p^2_{ord\_max}$ must exceed $p_M$ */

@ When |j| has been increased by 2, we must increase |ord| by unity when
$j=p^2_{ord}$, i.e., when |j==square|.

@<Update variables that depend on |j|@>=
   if(j==square) {
      ord++;@+ @<Update variables that depend on |ord|@>@;
      }

@ At this point in the program, |ord| has just been increased by unity, and
we want to set |square@t${}=p^2_{ord}$@>|. A surprisingly subtle point arises
here: How do we know that $p_{ord}$ has already been computed, i.e., that
|ord<=k|? If there were a gap in the sequence of prime numbers, such
that $p_{k+1}>p^2_k$ for some |k|, then this part of the program would refer to
the yet-uncomputed value |p[k]| unless some special test were made.

Fortunately, there are no such gaps. But no simple proof of this fact is
known. For example, Euclid's famous demonstration that there are infinitely
many prime numbers is strong enough to prove only that $p_{k+1}\leq
p_1\ldots p_k+1$. Advanced books on number theory come to our rescue by
showing that much more is true; for example, ``Bertrand's postulate''
states that $p_{k+1}<2p_k$ for all $k$.
@^Bertrand, Joseph, postulate@>
@^Euclid@>

@<Update variables that depend on |ord|@>=
   square = p[ord-1]*p[ord-1]; /* at this point |ord<=k| */

@* The inner loop. Our remaining task is to determine whether or not a
given integer |j| is prime. The general outline of this part of the program
is quite simple, using the value of |ord| as described above.

@<Give to...@>=
   n = 2;@+ j_prime = TRUE;
   while((n<ord) && j_prime) {
      @<If |p[n-1]| is a factor of |j|, set |j_prime=FALSE|@>@;
      n++;
      }

@ @<Variables...@>=
   int n; /* runs from 2 to |ord| when testing divisibility */

@ Let's suppose that division is very slow or nonexistent on our machine.
We want to detect nonprime odd numbers, which are odd multiples of the set
of primes $\{p_2,\ldots,p_{ord-1}\}$.

Since |ORD_MAX| is small, it is reasonable to maintain an auxiliary table
of the smallest odd multiples that haven't already been used to show that
some |j| is nonprime. In other words, our goal is to ``knock out'' all of
the odd multiples of each $p_n$ in the set $\{p_2,\ldots,p_{ord-1}\}$, and
one way to do this is to introduce an auxiliary table that serves as a
control structure for a set of knock-out procedures that are being
simulated in parallel. (The so-called ``sieve of Eratosthenes'' generates
primes by a similar method, but it knocks out the multiples of each prime
serially.)
@^Eratosthenes, sieve of@>

The auxiliary table suggested by these considerations is a |mult| array that
satisfies the following invariant condition: For $2\leq n<ord$, |mult[n-1]|
is an odd multiple of $p_n$ such that |mult[n-1]@t${}<j+2p_n$@>|.

@<Variables...@>=
   int mult[ORD_MAX]; /* runs through multiples of primes */

@ When |ord| has been increased, we need to initialize a new element of the
|mult| array. At this point |j==p[ord-2]@t$^2$@>|, so there is no need for an
elaborate computation.

@<Update variables that depend on |ord|@>=
   mult[ord-2]=j;

@ The remaining task is straightforward, given the data structures already
prepared. Let us recapitulate the current situation: The goal is to test
whether or not |j| is divisible by $p_n$, without actually performing a
division. We know that |j| is odd, and that |mult[n-1]| is an odd multiple
of $p_n$ such that |mult[n-1]<j+2@t$p_n$@>|. If |mult[n-1]<j|, we can
increase |mult[n-1]| by $2p_n$ and the same conditions will hold. On the
other hand if |mult[n-1]<=j|, the conditions imply that |j| is
divisible by $p_n$ if and only if |j==mult[n-1]|.

@<If |p[n-1]|...@>=
   while(mult[n-1]<j)
      mult[n-1] += 2*p[n-1];
   if(mult[n-1]==j)
      j_prime=FALSE;

@* For further reading. Here is a very short list of literature that has
been mentioned in this text. A full reference can be found in [2].
{\frenchspacing\parindent=1cm
\bigskip
\item{[1]} Ole-Johan Dahl, Edsger W. Dijkstra, and C. A. R. Hoare, {\sl
Structured programming\/} (London: Academic Press, 1972), 220 pp.
\item{[2]} Donald E. Knuth, {\sl Literate Programming\/} (Leland Stanford
Junior University, 1992), 368 pp.
\item{[3]} Donald E. Knuth, ``Structured programming with {\bf go to}
statements,'' {\sl Computing Surveys\/} {\bf 6}, 4 (December 1974),
261--301. (Reprinted as chapter 2 of [2])\par}

@* Index. Every identifier used in this program is shown here together with
a list of the section numbers where that identifier appears. The section
number is underlined if the identifier was defined in that section.
However, one-letter identifiers are indexed only at their point of
definition, since such identifiers tend to appear almost everywhere. \[An
index like this is prepared automatically by the \.{CWEB} software, and it is
appended to the final section of the program.\]

This index also refers to some of the places where key elements of the
program are treated. For example, the entries for `output format' and `page
headings' indicate where details of the output format are discussed.
Several other topics that appear in the documentation (e.g., `Bertrand's
postulate') have also been indexed. \[Special instructions within a \.{CWEB}
source file can be used to insert essentially anything into the index.\]
