% COMMONWORDS example of WEB/CWEB portability.  This documentation was
% originally published in the ``Communications of the ACM'', Volume 29,6
% (June 1986), and later in the book ``Literate Programming'', October 1991,
% where it appeared as an example of WEB programming for Pascal by Donald
% E. Knuth.  It has been translated into CWEB by Andreas Scherer to show
% the ease of portability between Pascal/WEB and C/CWEB.  As little changes
% as possible were made, so that the module numbering of the Pascal and
% the C versions are virtually identical.  Restrictions of Pascal mentioned
% in the WEB source were removed and the features of C were used instead.

% This program is distributed WITHOUT ANY WARRANTY, express or implied.
% WEB Version --- Don Knuth, 1984
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

\def\title{COMMONWORDS (C Version 1.1)}
\def\topofcontents{\null\vfill
  \centerline{\titlefont Counting common word frequencies}
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

@* Introduction.  The purpose of this program is to solve the following
problem posed by Jon Bentley@^Bentley, Jon Louis@>:

{\narrower\noindent Given a text file and an integer $k$, print the $k$
most common words in the file (and the number of their occurrences) in
decreasing frequency.\par}

Jon intentionally left the problem somewhat vague, but he stated that ``a
user should be able to find the one hundred most frequent words in a
twenty-page technical paper (roughly a 50K byte file) without undue
emotional trauma.''

Let us agree that a {\it word\/} is a sequence of one or more contiguous
letters; \.{"Bentley"} is a word, but \.{"ain't"} isn't.  The sequence
of letters should be maximal, in the sense that it cannot be lengthened
without including a nonletter.  Uppercase letters are considered equivalent
to their lowercase counterparts, so that the words \.{"Bentley"} and
\.{"BENTLEY"} and \.{"bentley"} are essentially identical.

The given problem still isn't well defined, for the file might contain more
than $k$ words, all of the same frequency; or there might not even be as
many as $k$ words.  Let's be more precise:  The most common words are to be
printed in order of decreasing frequency, with words of equal frequency
listed in alphabetic order.  Printing should stop after $k$ words have been
output, if more than $k$ words are present.

@ The |stdin| file is assumed to contain the given text.  If it
begins with a positive decimal number (preceded by optional blanks), that
number will be the value of $k$; otherwise we shall assume that $k=100$.
Answers will be sent to the |stdout| file.

@d default_k 100 /* use this value if $k$ isn't otherwise specified */

@ Besides solving the given problem, this program is supposed to be an
example of the \.{CWEB} system, for people who know some \CEE/ but who
have never seen \.{CWEB} before.  Here is an outline of the program to be
constructed:
@^Differences between \PASCAL/ and \CEE/@>

@d FALSE 0
@d TRUE 1

@c
#include <stdio.h>
#include <stdlib.h>

typedef unsigned char boolean; /* for logical switches */
@<Type declarations@>@/
@<Global variables@>@/
@<Procedures for initialization@>@/
@<Procedures for input and output@>@/
@<Procedures for data manipulation@>@/
@<The main program@>@/

@ The main idea of the \.{CWEB} approach is to let the program grow in
natural stages, with its parts presented in roughly the order that they
might have been written by a programmer who isn't especially clairvoyant.

For example, each global variable will be introduced when we first know
that it is necessary or desirable; the \.{CWEB} system will take care of
collecting these declarations into the proper place.  We already know about
one global variable, namely the number that Bentley called $k$.  Let us
give it the more descriptive name |max_words_to_print|.

@<Global variables@>=
unsigned int max_words_to_print; /* at most this many words will be printed */

@ As we introduce new global variables, we'll often want to give them
certain starting values.  This will be done by the |initialize| procedure,
whose body will consist of various pieces of code to be specified when we
think of particular kinds of initialization.

@<Procedures for initialization@>=
void initialize(void)
   {
   int i; /* all-purpose index for initializations */

   @<Set initial values@>@;
   }

@ The \.{CWEB} system, which may be thought of as a preprocessor for
\CEE/, includes a macro definition facility so that portable programs are
easier to write.  For example, we have already defined `|default_k|' to be
100.  Here are two more examples of \.{CWEB} macros; they allow us to
write, e.g., `|incr(count[p])|' as a convenient abbreviation for the
statement `|count[p]=count[p]+1|'.

@d incr(A) ++A /* increment a variable */
@d decr(A) --A /* decrement a variable */

@ Originally this program was written in the \PASCAL/ \.{WEB} language.
In difference to \CEE/, \PASCAL/ uses labels and |goto| statements when
abrupting procedures.  This isn't necessary for \CEE/ programs; they
already know the |return| command, so this program will be totally
|goto|-free.
@^Differences between \PASCAL/ and \CEE/@>

@* Strategic considerations.  What algorithms and data structures should be
used for Bentley's problem?  Clearly we need to be able to recognize
different occurrences of the same word, so some sort of internal dictionary
is necessary.  There's no obvious way to decide that a particular word of
the input cannot possibly be in the final set, until we've gotten very near
the end of the file; so we might as well remember every word that appears.

There should be a frequency count associated with each word, and we will
eventually want to run through the words in order of decreasing frequency.
But there's no need to keep these counts in order as we read through the
input, since the order matters only at the end.

Therefore it makes sense to structure our program as follows:

@<The main program@>=
void main(void)
   {
   initialize();
   @<Establish the value of |max_words_to_print|@>@;
   @<Input the text, maintaining a dictionary with frequency counts@>@;
   @<Sort the dictionary by frequency@>@;
   @<Output the results@>@;
   }

@* Basic input routines.  Let's switch to a bottom-up approach now, by
writing some of the procedures that we know will be necessary sooner or
later.  Then we'll have some confidence that our program is taking shape,
even though we haven't decided yet how to handle the searching or the
sorting.  It will be nice to get the messy details of \CEE/ input out of
the way and off our minds.

Here's a function that reads an optional positive integer, returning zero
if none is present at the beginning of the current line.

@<Procedures for input and output@>=
int read_int(void)
   {
   int n=0; /* the accumulated value */
   char c; /* the character from the input we're reading */

   if( (c=fgetc(stdin)) != EOF ) {
      for(; (c=='\n') || (c==' ') || (c=='\t'); c=fgetc(stdin));
      while(c>='0' && c<='9') {
         n = 10*n + c - '0';
         c=fgetc(stdin);
         }
      }
   return(n);
   }

@ We invoke |read_int| only once.

@<Establish the value of |max_words_to_print|@>=
   max_words_to_print = read_int();
   if(max_words_to_print==0)
      max_words_to_print = default_k;

@ To find words in the |stdin| file, we want a quick way to distinguish
letters from nonletters.  In contrary to \PASCAL/, \CEE/ makes this problem
very easy, because we can fully rely on {\mc ASCII}.  We shall define an
array, |lettercode|, which maps arbitrary characters into the integers
$0\ldots26$.
@^Differences between \PASCAL/ and \CEE/@>

If $c$ is a value of type |char| that represents the $k$th letter of the
alphabet, then |lettercode[c]==k|; but if $c$ is a nonletter,
|lettercode[c]==0|.  We assume that $0\leq c\leq255$ whenever $c$ is of
type |char|, i.e., we are dealing with |unsigned char|.

@<Global variables@>=
unsigned char lettercode[256]; /* the input conversion table */

@ The array |lettercode| is filled with $0$ for all non-letters, and with
the number of the letter in the alphabet.  We won't distinguish between
uppercase and lowercase letters in this program.
@^Differences between \PASCAL/ and \CEE/@>

@<Set initial values@>=
   for(i=0; i<=255; ++i)
      lettercode[i]=0; /* non-letter */

   lettercode['a'] = lettercode['A'] = 1; @+
   lettercode['b'] = lettercode['B'] = 2;
   lettercode['c'] = lettercode['C'] = 3; @+
   lettercode['d'] = lettercode['D'] = 4;
   lettercode['e'] = lettercode['E'] = 5; @+
   lettercode['f'] = lettercode['F'] = 6;
   lettercode['g'] = lettercode['G'] = 7; @+
   lettercode['h'] = lettercode['H'] = 8;
   lettercode['i'] = lettercode['I'] = 9; @+
   lettercode['j'] = lettercode['J'] = 10;
   lettercode['k'] = lettercode['K'] = 11; @+
   lettercode['l'] = lettercode['L'] = 12;
   lettercode['m'] = lettercode['M'] = 13; @+
   lettercode['n'] = lettercode['N'] = 14;
   lettercode['o'] = lettercode['O'] = 15; @+
   lettercode['p'] = lettercode['P'] = 16;
   lettercode['q'] = lettercode['Q'] = 17; @+
   lettercode['r'] = lettercode['R'] = 18;
   lettercode['s'] = lettercode['S'] = 19; @+
   lettercode['t'] = lettercode['T'] = 20;
   lettercode['u'] = lettercode['U'] = 21; @+
   lettercode['v'] = lettercode['V'] = 22;
   lettercode['w'] = lettercode['W'] = 23; @+
   lettercode['x'] = lettercode['X'] = 24;
   lettercode['y'] = lettercode['Y'] = 25; @+
   lettercode['z'] = lettercode['Z'] = 26;

@ Each new word found in the input will be placed into a |buffer| array.
We shall assume that no words are more than $60$ letters long; if a longer
word appears, it will be truncated to 60~characters, and a warning message
will be printed at the end of the run.

@d max_word_length 60 /* words shouldn't be longer than this */

@<Global variables@>=
unsigned char buffer[max_word_length]; /* the current word */
unsigned int word_length; /* the number of active letters currently in |buffer|;
   $0\ldots$|max_word_length| */
boolean word_truncated; /* was some word longer than |max_word_length|?*/

@ @<Set initial values@>=
   word_truncated=FALSE;

@ We're ready now for the main input routine, which puts the next word into
the buffer.  If no more words remain, |word_length| is set to zero;
otherwise |word_length| is set to the length of the new word.

@<Procedures for input and output@>=
void get_word(void)
   {
   unsigned char c; /* the character we're currently reading */

   word_length=0;
   if((c=fgetc(stdin))!=EOF) {
      while(lettercode[c]==0)
         if((c=fgetc(stdin))==EOF)
            return;
      @<Read a word into |buffer|@>@;
      }
   }

@ At this point |lettercode[c]>0|, hence $c$ contains the first letter of a
word.

@<Read a word into |buffer|@>=
   do @+ {
      if(word_length==max_word_length)
         word_truncated=TRUE;
      else {
         incr(word_length);
         buffer[word_length-1]=lettercode[c];
         }
      c=fgetc(stdin);
      } @+ while(lettercode[c]!=0);

@* Dictionary lookup.  Given a word in the buffer, we will want to look for
it in a dynamic dictionary of all words that have appeared so far.  We
expect many words to occur often, so we want a search technique that will
find existing words quickly.  Furthermore, the dictionary should
accommodate words of variable length, and (ideally) it should also
facilitate the task of alphabetic ordering.

These constraints suggest a variant of the data structure introduced by
Frank M. Liang@^Liang, Franklin Mark@> in his Ph.D. thesis [{\sl Word
Hy-phen-a-tion by Com-pu-ter}, Stanford University, 1983].  Liang's
structure, which we may call a {\it hash trie}, requires comparatively few
operations to find a word that is already present, although it may take
somewhat longer to insert a new entry.  Some space is sacrificed---we will
need two pointers, a count, and another 5-bit field for each character in
the dictionary, plus extra space to keep the hash table from becoming
congested---but relatively large memories are commonplace nowadays, so the
method seems ideal for the present application.

A trie represents a set of words and all prefixes of those words
[cf.~Knuth@^Knuth, Donald Ervin@>, {\sl Sorting and Searching}, Section~6.3].
For convenience, we shall say that all nonempty prefixes of the words in
our dictionary are also words, even though they may not occur as ``words''
in the input file.  Each word (in this generalized sense) is represented
by a |pointer|, which is an index into four large arrays called |link|,
|sibling|, |count|, and |ch|.

@d trie_size 32767 /* the largest pointer value */

@<Type declarations@>=
typedef unsigned int pointer; /* $0\ldots$|trie_size| */

@ One-letter words are represented by the pointers $1$ through $26$.  The
representation of longer words is defined recursively: If $p$ represents
word $w$ and if $1\leq c\leq26$, then the word $w$ followed by the $c$th
letter of the alphabet is represented by |link[p]+c|.

For example, suppose that |link[2]==1000|, |link[1005]==2000|, and
|link[2014]==3000|.  Then the word \.{"b"} is represented by the pointer
value~2; \.{"be"} is represented by |link[2]+5==1005|; \.{"ben"} is
represented by~2014; and \.{"bent"} by~3020.  If no longer word beginning
with \.{"bent"} appears in the dictionary, |link[3020]| will be zero.

The hash trie also contains redundant information to facilitate traversal
and updating.  If |link[p]| is nonzero, then |link[link[p]]==p|.
Furthermore if |q==link[p]+c| is a ``child'' of $p$, we have |ch[q]==c|;
this additional information makes it possible to go from child to parent,
since |link[q-ch[q]]==link[link[p]]==p|.

Children of the same parent are linked together cyclically by |sibling|
pointers: The largest child of $p$ is |sibling[link[p]]|, and the next
largest is |sibling[sibling[link[p]]]|; the smallest child's |sibling|
pointer is |link[p]|.  Continuing our example, if all words in the
dictionary beginning with \.{"be"} start with either \.{"ben"} or
\.{"bet"}, then |sibling[2000]==2020|, |sibling[2020]==2014|, and
|sibling[2014]==2000|.

Notice that children of different parents might appear next to each other.
For example, we might have |ch[2019]==6|, for the child of some word such
that |link[p]==2013|.

If |link[p]!=0|, the table entry in position |link[p]| is called the
``header'' of $p$'s children.  The special code value |header| appears in
the |ch| field of each header entry.

If $p$ represents a word, |count[p]| is the number of times that the word
has occurred in the input so far.  The |count| field in a header entry is
undefined.

Unused positions $p$ have |ch[p]==empty_slot|.  In this case |link[p]|,
|sibling[p]|, and |count[p]| are undefined.

@d empty_slot 0
@d header 27
@d move_to_prefix(A) A=link[A-ch[A]]
@d move_to_last_suffix(A) while(link[A]!=0) A=sibling[link[A]]

@<Global variables@>=
unsigned int link[trie_size+1],sibling[trie_size+1]; /* $0\ldots$|trie_size| */
unsigned char ch[trie_size+1]; /* |empty_slot|$\ldots$|header| */

@ @<Set initial values@>=
   for(i=27; i<=trie_size; ++i)
      ch[i]=empty_slot;
   for(i=1; i<=26; ++i) {
      ch[i]=i; @+ link[i]=count[i]=0; @+ sibling[i]=i-1;
      }
   ch[0]=header; @+ link[0]=0; @+ sibling[0]=26;

@ Here's the basic subroutine that finds a given word in the dictionary.
The word will be inserted (with a |count| of zero) if it isn't already
present.

More precisely, the |find_buffer| function looks for the contents of
|buffer|, and returns a pointer to the appropriate dictionary location.  If
the dictionary is so full that a new word cannot be inserted, the pointer~$0$
is returned.

@d abort_find return(0)

@<Procedures for data manipulation@>=
unsigned int find_buffer(void) /* returns values from $0$ to |trie_size| */
   {
   unsigned int i; /* index into |buffer| with values from
      $1$ to |max_word_length| */
   unsigned int p; /* the current word position */
   unsigned int q; /* the next word position */
   unsigned char c; /* current letter code */
   @<Other local variables of |find_buffer|@>@;@#

   i=1; @+ p=buffer[0];
   while(i<word_length) {
      incr(i); @+ c=buffer[i-1];
      @<Advance |p| to its child number |c| @>@;
      }
   return(p);
   }

@ @<Advance |p| to its child number |c|@>=
   if(link[p]==0)
      @<Insert the firstborn child of |p| and move to it, or |abort_find|@>@;
   else {
      q = link[p] + c;
      if(ch[q] != c) {
         if(ch[q] != empty_slot)
            @<Move |p|'s family to a place where child |c| will fit,
              or |abort_find|@>@;
         @<Insert child |c| into |p|'s family@>@;
         }
      p = q;
   }

@ Each ``family'' in the trie has a header location |h==link[p]| such that
child |c| is in location |h+c|.  We want these values to be spread out in
the trie, so that families don't often interfere with each other.
Furthermore we will need to have $26<h\leq{}$|trie_size|${}-26$ if the
search algorithm is going to work properly.

One of the main tasks of the insertion algorithm is to find a place for a
new header.  The theory of hashing tells us that it is advantageous to put
the |n|th header near the location $x_n=\alpha n\bmod t$, where
$t={}$|trie_size|${}-52$ and where $\alpha$ is an integer relatively prime
to $t$ such that $\alpha/t$ is approximately equal to the golden ratio
$(\sqrt{5}-1)/2\approx.61803$.  [These locations $x_n$ are about as
``spread out'' as you can get; see {\sl Sorting and Searching},
pp.~510--511.]

@d alpha 20219 /* $\approx.61803$|trie_size| */

@<Global variables@>=
pointer x; /* $\alpha n \bmod ($|trie_size|${}-52)$ */

@ @<Set initial values@>=
   x = 0;

@ We will give up trying to find a vacancy if 1000 trials have been made
without success.  This will happen only if the table is quite full, at
which time the most common words will probably already appear in the
dictionary.

@d tolerance 1000

@<Get set for computing header locations@>=
   if(x < trie_size - 52 - alpha)
      x += alpha;
   else
      x += alpha - trie_size + 52;
   h = x + 27; /* now $26<h\leq{}$|trie_size|${}-26$ */
   if(h <= trie_size - 26 - tolerance)
      last_h = h + tolerance;
   else
      last_h = h + tolerance - trie_size + 52;

@ @<Compute the next trial header location |h|, or |abort_find|@>=
   if(h == last_h)
      abort_find;
   if(h == trie_size - 26)
      h = 27;
   else
      incr(h);

@ @<Other local variables of |find_buffer|@>=
   pointer h; /* trial header location */
   int last_h; /* the final one to try */

@ @<Insert the firstborn child of |p| and move to it, or |abort_find|@>=
   {
   @<Get set for computing header locations@>@;
   do @+ {
      @<Compute the next trial header location |h|, or |abort_find|@>@;
      } @+ while((ch[h] != empty_slot) || (ch[h+c] != empty_slot));
   link[p] = h; @+ link[h] = p; @+p = h + c;
   ch[h] = header; @+ ch[p] = c;
   sibling[h] = p; @+ sibling[p] = h; @+ count[p] = link[p] = 0;
   }

@ The decreasing order of |sibling| pointers is preserved here.  We assume
that |q==link[p]+c|.

@<Insert child |c| into |p|'s family@>=
   {
   h = link[p];
   while(sibling[h]>q)
      h = sibling[h];
   sibling[q] = sibling[h]; @+ sibling[h] = q;
   ch[q] = c; @+ count[q] = link[q] = 0;
   }

@ There's one complicated case, which we have left for last.  Fortunately
this step doesn't need to be done very often in practice, and the families
that need to be moved are generally small.

@<Move |p|'s family to a place where child |c| will fit, or |abort_find|@>=
   {
   @<Find a suitable place |h| to move, or |abort_find|@>@;
   q = h+c; @+ r = link[p]; @+ delta = h-r;
   do @+ {
      sibling[r+delta] = sibling[r] + delta;
      ch[r+delta] = ch[r];
      ch[r] = empty_slot;
      count[r+delta] = count[r];
      link[r+delta] = link[r];
      if(link[r] != 0)
         link[link[r]] = r + delta;
      r = sibling[r];
      } @+ while(ch[r] != empty_slot);
   }

@ @<Other local variables of |find_buffer|@>=
   pointer r; /* family member to be moved */
   int delta; /* amount of motion */
   boolean slot_found; /* have we found a new homestead? */

@ @<Find a suitable place |h| to move, or |abort_find|@>=
   slot_found = FALSE;
   @<Get set for computing header locations@>@;
   do @+ {
      @<Compute the next trial header location |h|, or |abort_find|@>@;
      if(ch[h+c] == empty_slot) {
         r = link[p];
         delta = h-r;
         while((ch[r+delta]==empty_slot) && (sibling[r]!=link[p]))
            r = sibling[r];
         if(ch[r+delta] == empty_slot)
            slot_found = TRUE;
         }
      } @+ while(!slot_found);

@* The frequency counts.  It is, of course, a simple matter to combine
dictionary lookup with the |get_word| routine, so that all the word
frequencies are counted.  We may have to drop a few words in extreme cases
(when the dictionary is full or the maximum count has been reached).

@d max_count 32767 /* counts won't go higher than this */

@<Global variables@>=
   int count[trie_size+1];
   boolean word_missed; /* did the dictionary get too full? */
   pointer p; /* location of the current word */

@ @<Set initial values@>=
   word_missed = FALSE;

@ @<Input the text, maintaining a dictionary with frequency counts@>=
   get_word();
   while(word_length) {
      if((p = find_buffer()) == NULL)
         word_missed = TRUE;
      else if(count[p] < max_count)
         incr(count[p]);
      get_word();
      }

@ While we have the dictionary structure in mind, let's write a routine
that prints the word corresponding to a given pointer, together with the
corresponding frequency count.

For obvious reasons, we put the word into the buffer backwards during this
process.

As we can rely on the relative order of the characters in the {\mc ASCII}
set, no conversion array is needed here.  Simple arithmetic will suffice.
@^Differences between \PASCAL/ and \CEE/@>

@<Procedures for input and output@>=
void print_word(pointer p)
   {
   pointer q; /* runs through ancestors of |p| */
   unsigned int i; /* index into |buffer|; $1\ldots{}$|max_word_length| */

   word_length = 0; @+ q = p; @+ fputc(' ',stdout);
   do @+ {
      incr(word_length);
      buffer[word_length-1] = ch[q];
      move_to_prefix(q);
      } @+ while(q != 0);
   for(i=word_length; i>=1; --i)
      fputc(buffer[i-1]-1+'a',stdout);
   if(count[p] < max_count)
      fprintf(stdout," %d\n",count[p]);
   else
      fprintf(stdout," %d or more\n",max_count);
   fflush(stdout);
   }

@* Sorting a trie.  Almost all of the frequency counts will be small, in
typical situations, so we needn't use a general-purpose sorting method.  It
suffices to keep a few linked lists for the words with small frequencies,
with one other list to hold everything else.

@d large_count 200 /* smaller counts are in separate lists */

@<Global variables@>=
pointer sorted[large_count]; /* list heads */
unsigned int total_words; /* the number of words sorted */

@ If we walk through the trie in reverse alphabetical order, it is a simple
matter to change the sibling links so that the words of frequency |f| are
pointed to by |sorted[f-1]|, |sibling[sorted[f-1]]|, $\ldots$ in alphabetical
order.  When |f==large_count|, the words must also be linked in decreasing
order of their |count| fields.

The restructuring operations are slightly subtle here, because we are
modifying the |sibling| pointers while traversing the trie.

@<Procedures for data manipulation@>=
void trie_sort(void)
   {
   unsigned int k; /* index to |sorted|; $1\ldots{}$|large_count| */
   pointer p; /* current position in the trie */
   unsigned int f; /* current frequency count; $0\ldots{}$|max_count| */
   pointer q, r; /* list manipulation variables */

   total_words = 0;
   for(k=1; k<=large_count; ++k)
      sorted[k-1] = 0;
   p = sibling[0]; @+ move_to_last_suffix(p);
   do @+ {
      f = count[p]; @+ q = sibling[p];
      if(f)
         @<Link |p| into the list |sorted[f-1]|@>@;
      if(ch[q] != header) {
         p = q; @+ move_to_last_suffix(p);
         }
      else
         p = link[q]; /* move to prefix */
      } @+ while(p);
   }

@ Here we use the fact that |count[0]==0|.

@<Link |p| into the list |sorted[f-1]|@>=
   {
   incr(total_words);
   if(f < large_count) { /* easy case */
      sibling[p] = sorted[f-1]; @+ sorted[f-1] = p;
      }
   else {
      r = sorted[large_count-1];
      if(count[p] >= count[r]) {
         sibling[p] = r; @+ sorted[large_count-1] = p;
         }
      else {
         while(count[p] < count[sibling[r]])
            r = sibling[r];
         sibling[p] = sibling[r]; @+ sibling[r] = p;
         }
      }
   }

@ @<Sort the dictionary by frequency@>=
   trie_sort();

@ After |trie_sort| has done its thing, the sequence of linked lists
|sorted[large_count-1]|, $\ldots$, |sorted[0]| collectively contain all the
words of the input file, in decreasing order of frequency.  Words of equal
frequency appear in alphabetic order.  The individual lists are linked by
means of the |sibling| array.

Therefore the following procedure will print the first |k| words, as
required in Bentley's problem.

@<Procedures for input and output@>=
void print_common(int k)
   {
   unsigned int f; /* current frequency */
   pointer p; /* current or next word */

   f = large_count; @+ p = sorted[f-1];
   do @+ {
      while(p == 0) {
         if(f==1)
            return;
         decr(f); @+ p = sorted[f-1];
         }
      print_word(p); @+ decr(k); @+ p = sibling[p];
      } @+ while(k>0);
   }

@* The endgame.  We have recorded |total_words| different words.
Furthermore the global variables |word_missed| and |word_truncated| tell
whether or not any storage limitations were exceeded.  So the remaining
task is simple:

@<Output the results@>=
   if(total_words == 0)
      fputs("There are no words in the input!\n",stdout);
   else {
      if(total_words < max_words_to_print) /* we will print all words */
         fputs("Words of the input file, ordered by frequency: \n",stdout);
      else if(max_words_to_print == 1)
         fputs("The most common word and its frequency: \n",stdout);
      else
         fprintf(stdout,"The %d most common words, and their frequencies: \n",
            max_words_to_print);
      print_common(max_words_to_print);
      if(word_truncated)
         fprintf(stdout,"(At least one word had to be shortened to %d letters.)\n",
            max_word_length);
      if(word_missed)
         fputs("(Some input data was skipped, due to memory limitations.)\n",
            stdout);
      }
   fflush(stdout);

@* Index.  Here is a list of all uses of all identifiers, underlined at the
point of definition.
