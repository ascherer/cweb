% SAMPLE example of WEB/CWEB portability.  This documentation was
% originally published in the ``Communications of the ACM'', Volume 29,5
% (May 1986), and later in the book ``Literate Programming'', October 1991,
% where it appeared as an example of WEB programming for Pascal.  It has
% been translated into CWEB by Andreas Scherer to show the ease of
% portability between Pascal/WEB and C/CWEB.  Minor changes to include
% extra C functionality are mentioned in the text that follows.

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

\def\title{SAMPLE (C Version 1.0)}
\def\topofcontents{\null\vfill
  \centerline{\titlefont Producing random numbers}
  \vskip15pt
  \centerline{(C Version 1.0)}
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

@* Introduction.  Jon Bentley@^Bentley, Jon Louis@> recently discussed
the following interesting problem as one of his ``Programming Pearls''
[{\sl Communications of the ACM}~{\bf 27} (December, 1984), 1179--1182]:

{\narrower\noindent The input consists of two integers $M$ and $N$, with
$M<N${}.  The output is a sorted list of $M$ random numbers in the range
$1\ldots N$ in which no integer occurs more than once.  For probability
buffs, we desire a sorted selection without replacement in which each
selection occurs equiprobably.\par}

The present program illustrates what I (i.e., Donald E. Knuth
@^Knuth, Donald E.@> in his {\sl Literate Programming} (October, 1991),
144--149) think is the best solution to this problem, when $M$ is
reasonably large yet small compared to $N${}.  It's the method described
tersely in the answer to exercise 3.4.2--15 of my book {\sl Seminumerical
Algorithms}, pp.~141 and~555.  The \.{WEB} program was translated to \.{CWEB}
by Andreas Scherer.  Necessary changes for \CEE/ were included and some
\PASCAL/ restrictions removed.
@^Scherer, Andreas@>

@ For simplicity, all input and output in this program is assumed to be
handled at the terminal.  The \.{CWEB} macro |read_terminal| defined here
can easily be changed to accommodate other conventions.  The macro |trunc|
replaces the \PASCAL/ routine of the same name for \CEE/.
@^Differences between \PASCAL/ and \CEE/@>

@d read_terminal(a) fscanf(stdin,"%d",&a)
   /* input a value from the terminal */
@d trunc(a) (int)(a)

@ Here's an outline of the entire \CEE/ program:

@c
@<Global \#|include|s@>@/
@<Global variables@>@/
@<The random number generation procedure@>@/
@<The |main| program@>

@ The library interfaces of \PASCAL/ and \CEE/ are different, so here is
the needed information.
@^Differences between \PASCAL/ and \CEE/@>

@<Global \#|include|s@>=
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <time.h>

@ The global variables $M$ and $N$ have already been mentioned; we had
better declare them.  Other global variables will be declared later.

@<Global variables@>=
   int M; /* size of the sample */
   int N; /* size of the population */

@ In \CEE/ it's very easy to generate random integers in the range $i\ldots
j$, so the assumed external routine for the \PASCAL/ version comes down to
this.
@^Differences between \PASCAL/ and \CEE/@>

@<The random number generation procedure@>=
int rand_int(int i,int j)
   {
   return(i + rand()%(j-i+1));
   }

@ @<Initialize the random number generator@>=
   srand((unsigned)time(NULL) % UINT_MAX);
@^Differences between \PASCAL/ and \CEE/@>

@* A plan of attack.  After the user has specified $M$ and $N$, we compute
the sample by following a general procedure recommended by Bentley:
@^Bentley, Jon Louis@>

@<The |main| program@>=
void main(void)
   {
   @<Establish the values of |M| and |N|@>@;
   @<Initialize the random number generator@>@;
   size = 0; @+ @<Initialize set |S| to empty@>@;
   while(size < M) {
      T = rand_int(1,N);
      @<If |T| is not in |S|, insert it and increase |size|@>@;
      }
   @<Print the elements of |S| in sorted order@>@;
   @<Free the allocated |hash| table@>@;
   }

@ The main program just sketched has introduced several more global
variables.  There's a set |S| of integers, whose representation will be
deferred until later; but we can declare two auxiliary integer variables
now.

@<Global variables@>=
   int size; /* the number of elements in set |S| */
   int T; /* new candidate for membership in |S| */

@ The first order of business is to have a short dialog with the user.

@<Establish the values of |M| and |N|@>=
   do @+ {
      printf("population size: N = "); @+ read_terminal(N);
      if(N<=0) printf("N should be positive!\n");
      } @+ while(N<=0);
   do @+ {
      printf("sample size: M = "); @+ read_terminal(M);
      if(M<0) printf("M shouldn't be negative!\n");
      else if(M>N) printf("M shouldn't exceed N!\n");
      } @+ while((M<0) || (M>N));

@ @<Free the allocated |hash| table@>=
   if(hash) free(hash);
@^Differences between \PASCAL/ and \CEE/@>

@* An ordered hash table.  The key idea to an efficient solution of this
sampling problem is to maintain a set whose entries are easily sorted.  The
method of ``ordered hash tables'' [Amble and Knuth, {\sl The Computer
Journal}~{\bf 17} (May 1974), 135--142] is ideally suited to this task, as
we shall see.
@^Amble, Ole@>
@^Knuth, Donald E.@>

Ordered hashing is similar to ordinary linear probing, except that the
relative order of keys is taken into account.  The cited paper derives
theoretical results that will not be rederived here, but we shall use the
following fundamental property: {\sl The entries of an ordered hash table
are independent of the order in which its keys were inserted.}  Thus, an
ordered hash table is a ``canonical'' representation of its set of entries.

We shall represent |S| by an array of $2M$ integers.

@<Global variables@>=
   int *hash; /* (a pointer to) the ordered hash table */
   int H; /* an index into |hash| */
   int H_max; /* the current hash size */
   float alpha; /* the ratio of table size to |N| */
@^Differences between \PASCAL/ and \CEE/@>

@ @<Initialize set |S| to empty@>=
   if(hash = (int *)calloc(2*M,sizeof(int))) {
      H_max = 2*M-1; @+ alpha = 2*M/N;
      for(H=0; H<=H_max; H++)
         hash[H] = 0;
      }
   else exit(1);
@^Differences between \PASCAL/ and \CEE/@>

@ Now we come to the interesting part, where the algorithm tries to insert
|T| into an ordered hash table.  We use the hash address $H=\lfloor
2M(T-1)/N\rfloor$ as a starting point, since this quantity is monotonic in
|T| and almost uniformly distributed in the range $0\leq H<2M$.

@<If |T| is not in |S|, insert it and increase |size|@>=
   H=trunc(alpha*(T-1));
   while(hash[H]>T)
      if(H==0)
         H=H_max;
      else
         H--;
   if(hash[H]<T) { /* |T| is not present */
      size++; @+ @<Insert |T| into the ordered hash table@>@;
   }

@ The heart of ordered hashing is the insertion process.  In general, the
new key |T| will be inserted in place of a previous key $T_1<T$, which is
then reinserted in place of $T_2<T_1$, etc., until an empty slot is
discovered.

@<Insert |T| into the ordered hash table@>=
   while(hash[H]>0) {
      TT=hash[H]; /* we have $0<TT<T$ */
      hash[H]=T; @+ T=TT;
      do @+ {
         if(H==0)
            H=H_max;
         else
            H--;
         } @+ while(hash[H]>=T);
      }
   hash[H]=T;

@ @<Global variables@>=
   int TT; /* a key that's being moved */

@* Sorting in linear time.  The climax of this program is the fact that the
entries in our ordered hash table can easily be read out in increasing
order.

Why is this true?  Well, we know that the final state of the table is
independent of the order in which the elements entered.  Furthermore it's
easy to understand what the table looks like when the entries are inserted
in decreasing order, because we have used a monontonic hash function.
Therefore we know that the table must have an especially simple form.

Suppose the nonzero entries are $T_1<\dots<T_M$. If $k$ of these have
``wrapped around'' in the insertion process (i.e., if |H| passed from $0$
to |H_max|, $k$ times), table position |hash[0]| will either be zero (in
which case $k$ must also be zero) or it will contain $T_{k+1}$.  In the
latter case, the entries $T_{k+1}<\dots<T_M$ and $T_1<\dots<T_k$ will
appear in order from left to right.  Thus the output can be sorted with at
most two passes over the table.

@d print_it printf("%10d\n",hash[H])

@<Print the elements of |S| in sorted order@>=
   if(hash[0]==0) { /* there was no wrap-around */
      for(H=1; H<=H_max; H++)
         if(hash[H]>0)
            print_it;
      }
   else { /* print the wrap-around entries */
      for(H=1; H<=H_max; H++)
         if(hash[H]>0)
            if(hash[H]<hash[0])
               print_it;
      for(H=0; H<=H_max; H++)
          if(hash[H]>=hash[0])
             print_it;
      }

@* Index.  The uses of single-letter variables aren't indexed by \.{CWEB},
so this list is quite short.  (And an index is quite pointless anyway, for
a program of this size.)  Changes for \.{CWEB} can be found under the
entry ``Differences between \PASCAL/ and \CEE/.''
