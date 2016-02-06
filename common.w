% This file is part of CWEB.
% This program by Silvio Levy is based on a program by D. E. Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.4 --- Don Knuth, June 1992

% Copyright (C) 1987,1990 Silvio Levy and Donald E. Knuth

% Permission is granted to make and distribute verbatim copies of this
% document provided that the copyright notice and this permission notice
% are preserved on all copies.

% Permission is granted to copy and distribute modified versions of this
% document under the conditions for verbatim copying, provided that the
% entire resulting derived work is distributed under the terms of a
% permission notice identical to this one.

\def\v{\char'174} % vertical (|) in typewriter font

\def\title{Common code for CTANGLE and CWEAVE (Version 2.7)}
\def\topofcontents{\null\vfill
  \centerline{\titlefont Common code for {\ttitlefont CTANGLE} and
    {\ttitlefont CWEAVE}}
  \vskip 15pt
  \centerline{(Version 2.7)}
  \vfill}
\def\botofcontents{\vfill
\noindent
Copyright \copyright\ 1987,\thinspace1990 Silvio Levy and Donald E. Knuth
\bigskip\noindent
Permission is granted to make and distribute verbatim copies of this
document provided that the copyright notice and this permission notice
are preserved on all copies.

\smallskip\noindent
Permission is granted to copy and distribute modified versions of this
document under the conditions for verbatim copying, provided that the
entire resulting derived work is distributed under the terms of a
permission notice identical to this one.
}

\pageno=\contentspagenumber \advance\pageno by 1
\let\maybe=\iftrue

@* Introduction.  This file contains code common
to both \.{TANGLE} and \.{WEAVE}, that roughly concerns the following
problems: character uniformity, input routines, error handling and
parsing of command line.  We have tried to concentrate in this file
all the system dependencies, so as to maximize portability.

In the texts below we will
sometimes use \.{WEB} to refer to either of the two component
programs, if no confusion can arise.

Here is the overall appearance of this file:

@c
@<Include files@>@/
@<Definitions that should agree with \.{TANGLE} and \.{WEAVE}@>@;
@<Other definitions@>@;
@<Functions@>;

@ In certain cases \.{TANGLE} and \.{WEAVE} should do almost, but not
quite, the same thing.  In these cases we've written common code for
both, differentiating between the two by means of the global variable
|program|.

@d tangle 0
@d weave 1

@<Definitions...@>=
typedef short boolean;
boolean program; /* \.{WEAVE} or \.{TANGLE}? */

@ \.{CWEAVE} operates in three phases: first it inputs the source
file and stores cross-reference data, then it inputs the source once again and
produces the \TeX\ output file, and finally it sorts and outputs the index.
Similarly, \.{CTANGLE} operates in two phases.
The global variable |phase| tells which phase we are in.

@<Other...@>= int phase; /* which phase are we in? */

@ There's an initialization procedure that gets both \.{CTANGLE} and
\.{CWEAVE} off to a good start. We will fill in the details of this
procedure later.

@<Functions...@>=
common_init()
{
  @<Initialize pointers@>;
  @<Set the default options common to \.{TANGLE} and \.{WEAVE}@>;
  @<Scan arguments and open output files@>;
}

@* The character set.
\.{CWEB} uses the conventions of \Cee\ programs found in the standard
\.{ctype.h} header file.

@<Include files@>=
#include <ctype.h>

@ A few character pairs are encoded internally as single characters,
using the definitions below. These definitions are consistent with
an extension of ASCII code originally developed at MIT and explained in
Appendix~C of {\sl The \TeX book\/}; thus, users who have such a
character set can type things like \.{\char'32} and \.{char'4} instead
of \.{!=} and \.{\&\&}. (However, their files will not be too portable
until more people adopt the extended code.)

If the character set is not ASCII, the definitions given here may conflict
with existing characters; in such cases, other arbitrary codes should be
substituted. The indexes to \.{CTANGLE} and \.{CWEAVE} mention every
case where similar codes may have to be changed in order to
avoid character conflicts. Look for the entry ``ASCII code dependencies''
in those indexes.

@^ASCII code dependencies@>
@^system dependencies@>

@d and_and 04 /* `\.{\&\&}'; this corresponds to MIT's {\tentex\char'4} */
@d lt_lt 020 /* `\.{<<}';  this corresponds to MIT's {\tentex\char'20} */
@d gt_gt 021 /* `\.{>>}';  this corresponds to MIT's {\tentex\char'21} */
@d plus_plus 013 /* `\.{++}';  this corresponds to MIT's {\tentex\char'13} */
@d minus_minus 01 /* `\.{--}';  this corresponds to MIT's {\tentex\char'1} */
@d minus_gt 031 /* `\.{->}';  this corresponds to MIT's {\tentex\char'31} */
@d not_eq 032 /* `\.{!=}';  this corresponds to MIT's {\tentex\char'32} */
@d lt_eq 034 /* `\.{<=}';  this corresponds to MIT's {\tentex\char'34} */
@d gt_eq 035 /* `\.{>=}';  this corresponds to MIT's {\tentex\char'35} */
@d eq_eq 036 /* `\.{==}';  this corresponds to MIT's {\tentex\char'36} */
@d or_or 037 /* `\.{\v\v}';  this corresponds to MIT's {\tentex\char'37} */

@* Input routines.  The lowest level of input to the \.{WEB} programs
is performed by |input_ln|, which must be told which file to read from.
The return value of |input_ln| is 1 if the read is successful and 0 if
not (generally this means the file has ended). The conventions
of \TeX\ are followed; i.e., the characters of the next line of the file
are copied into the |buffer| array,
and the global variable |limit| is set to the first unoccupied position.
Trailing blanks are ignored. The value of |limit| must be strictly less
than |buf_size|, so that |buffer[buf_size-1]| is never filled.

Since |buf_size| is strictly less than |long_buf_size|,
some of \.{WEB}'s routines use the fact that it is safe to refer to
|*(limit+2)| without overstepping the bounds of the array.

@d buf_size 100 /* for \.{WEAVE} and \.{TANGLE} */
@d long_buf_size 500 /* for \.{WEAVE} */

@<Definitions...@>=
char buffer[long_buf_size]; /* where each line of input goes */
char *buffer_end=buffer+buf_size-2; /* end of |buffer| */
char *limit=buffer; /* points to the last character in the buffer */
char *loc=buffer; /* points to the next character to be read from the buffer */

@ @<Include files@>=
#include <stdio.h>

@ In the unlikely event that your standard I/O library does not
support |feof|, |getc| and |ungetc| you may have to change things here.
@^system dependencies@>

@<Func...@>=
input_ln(fp) /* copies a line into |buffer| or returns 0 */
FILE *fp; /* what file to read from */
{
  register int  c; /* the character read */
  register char *k;  /* where next character goes */
  if (feof(fp)) return(0);  /* we have hit end-of-file */
  limit = k = buffer;  /* beginning of buffer */
  while (k<=buffer_end && (c=getc(fp)) != EOF && c!='\n')
    if ((*(k++) = c) != ' ') limit = k;
  if (k>buffer_end)
    if ((c=getc(fp))!=EOF && c!='\n') {
      ungetc(c,fp); loc=buffer; err_print("! Input line too long");
@.Input line too long@>
  }
  if (c==EOF && limit==buffer) return(0);  /* there was nothing after
    the last newline */
  return(1);
}

@ Now comes the problem of deciding which file to read from next.
Recall that the actual text that \.{WEB} should process comes from two
streams: a |web_file|, which can contain possibly nested include
commands \.{@@i}, and a |change_file|, which should not contain
includes.  The |web_file| together with the currently open include
files form a stack |file|, whose names are stored in a parallel stack
|file_name|.  The boolean |changing| tells whether or not we're reading
form the |change_file|.

The line number of each open file is also kept for error reporting and
for the benefit of \.{TANGLE}.

@f line x /* make |line| an unreserved word */
@d max_include_depth 10 /* maximum number of source files open
  simultaneously, not counting the change file */
@d max_file_name_length 60
@d cur_file file[include_depth] /* current file */
@d cur_file_name file_name[include_depth] /* current file name */
@d cur_line line[include_depth] /* number of current line in current file */
@d web_file file[0] /* main source file */
@d web_file_name file_name[0] /* main source file name */

@<Definitions...@>=
int include_depth; /* current level of nesting */
FILE *file[max_include_depth]; /* stack of non-change files */
FILE *change_file; /* change file */
char file_name[max_include_depth][max_file_name_length];
  /* stack of non-change file names */
char change_file_name[max_file_name_length]; /* name of change file */
char alt_web_file_name[max_file_name_length]; /* alternate name to try */
int line[max_include_depth]; /* number of current line in the stacked files */
int change_line; /* number of current line in change file */
boolean input_has_ended; /* if there is no more input */
boolean changing; /* if the current line is from |change_file| */
boolean web_file_open=0; /* if the web file is being read */

@ When |changing=0|, the next line of |change_file| is kept in
|change_buffer|, for purposes of comparison with the next
line of |cur_file|. After the change file has been completely input, we
set |change_limit=change_buffer|,
so that no further matches will be made.

Here's a shorthand expression for inequality between the two lines:

@d lines_dont_match (change_limit-change_buffer != limit-buffer ||
  strncmp(buffer, change_buffer, limit-buffer))

@<Other...@>=
char change_buffer[buf_size]; /* next line of |change_file| */
char *change_limit; /* points to the last character in |change_buffer| */

@ Procedure |prime_the_change_buffer| sets |change_buffer| in preparation
for the next matching operation. Since blank lines in the change file are
not used for matching, we have |(change_limit==change_buffer && !changing)|
if and only if the change file is exhausted. This procedure is called only
when |changing| is 1; hence error messages will be reported correctly.

@<Func...@>=
prime_the_change_buffer()
{
  change_limit=change_buffer; /* this value is used if the change file ends */
  @<Skip over comment lines in the change file; |return| if end of file@>;
  @<Skip to the next nonblank line; |return| if end of file@>;
  @<Move |buffer| and |limit| to |change_buffer| and |change_limit|@>;
}

@ While looking for a line that begins with \.{@@x} in the change file,
we allow lines that begin with \.{@@}, as long as they don't begin with
\.{@@y} or \.{@@z} (which would probably indicate that the change file is
fouled up).

@<Skip over comment lines in the change file...@>=
while(1) {
  change_line++;
  if (!input_ln(change_file)) return;
  if (limit<buffer+2) continue;
  if (buffer[0]!='@@') continue;
  if (isupper(buffer[1])) buffer[1]=tolower(buffer[1]);
  @<Check for erroneous \.{@@i}@>;
  if (buffer[1]=='x') break;
  if (buffer[1]=='y' || buffer[1]=='z') {
    loc=buffer+2;
    err_print("! Where is the matching @@x?");
@.Where is the match...@>
  }
}

@ We do not allow includes in a change file, so as to avoid confusion.

@<Check for erron...@>= {
  if (buffer[1]=='i') {
    loc=buffer+2;
    err_print("! No includes allowed in change file");
@.No includes allowed...@>
  }
}

@ Here we are looking at lines following the \.{@@x}.

@<Skip to the next nonblank line...@>=
do {
  change_line++;
  if (!input_ln(change_file)) {
    err_print("! Change file ended after @@x");
@.Change file ended...@>
    return;
  }
} while (limit==buffer);

@ @<Move |buffer| and |limit| to |change_buffer| and |change_limit|@>=
{
  change_limit=change_buffer-buffer+limit;
  strncpy(change_buffer,buffer,limit-buffer+1);
}

@ The following procedure is used to see if the next change entry should
go into effect; it is called only when |changing| is 0.
The idea is to test whether or not the current
contents of |buffer| matches the current contents of |change_buffer|.
If not, there's nothing more to do; but if so, a change is called for:
All of the text down to the \.{@@y} is supposed to match. An error
message is issued if any discrepancy is found. Then the procedure
prepares to read the next line from |change_file|.

When a match is found, the current module is marked as changed unless
the first line after the \.{@@x} and after the \.{@@y} both start with
either |'@@*'| or |'@@ '| (possibly preceded by whitespace).

This procedure is called only when |buffer<limit|, i.e., when the
current line is nonempty.

@d if_module_start_make_pending(b) {@+*limit='!';
  for (loc=buffer;isspace(*loc);loc++) ;
  *limit=' ';
  if (*loc=='@@' && (isspace(*(loc+1)) || *(loc+1)=='*')) change_pending=b;
}

@<Func...@>=
check_change() /* switches to |change_file| if the buffers match */
{
  int n=0; /* the number of discrepancies found */
  if (lines_dont_match) return;
  change_pending=0;
  if (!changed_module[module_count]) {
    if_module_start_make_pending(1);
    if (!change_pending) changed_module[module_count]=1;
  }
  while (1) {
    changing=1; print_where=1; change_line++;
    if (!input_ln(change_file)) {
      err_print("! Change file ended before @@y");
@.Change file ended...@>
      change_limit=change_buffer; changing=0;
      return;
    }
    if (limit>buffer+1 && buffer[0]=='@@') {
      if (isupper(buffer[1])) buffer[1]=tolower(buffer[1]);
      @<If the current line starts with \.{@@y},
        report any discrepancies and |return|@>;
    }
    @<Move |buffer| and |limit|...@>;
    changing=0; cur_line++;
    while (!input_ln(cur_file)) { /* pop the stack or quit */
      if (include_depth==0) {
        err_print("! WEB file ended during a change");
@.WEB file ended...@>
        input_has_ended=1; return;
      }
      include_depth--; cur_line++;
    }
    if (lines_dont_match) n++;
  }
}

@ @<If the current line starts with \.{@@y}...@>=
if (buffer[1]=='x' || buffer[1]=='z') {
  loc=buffer+2; err_print("! Where is the matching @@y?");
@.Where is the match...@>
  }
else if (buffer[1]=='y') {
  if (n>0) {
    loc=buffer+2;
    printf("\n! Hmm... %d ",n);
    err_print("of the preceding lines failed to match");
@.Hmm... n of the preceding...@>
  }
  return;
}

@ The |reset_input| procedure, which gets \.{WEB} ready to read the
user's \.{WEB} input, is used at the beginning of phase one of \.{TANGLE},
phases one and two of \.{WEAVE}.

@<Func...@>=
reset_input()
{
  limit=buffer; loc=buffer+1; buffer[0]=' ';
  @<Open input files@>;
  include_depth=0; cur_line=0; change_line=0;
  changing=1; prime_the_change_buffer(); changing=!changing;
  limit=buffer; loc=buffer+1; buffer[0]=' '; input_has_ended=0;
}

@ The following code opens the input files.
@^system dependencies@>

@<Open input files@>=
if ((web_file=fopen(web_file_name,"r"))==NULL) {
  strcpy(web_file_name,alt_web_file_name);
  if ((web_file=fopen(web_file_name,"r"))==NULL)
       fatal("! Cannot open input file ", web_file_name);
}
@.Cannot open input file@>
@.Cannot open change file@>
web_file_open=1;
if ((change_file=fopen(change_file_name,"r"))==NULL)
       fatal("! Cannot open change file ", change_file_name);

@ The |get_line| procedure is called when |loc>limit|; it puts the next
line of merged input into the buffer and updates the other variables
appropriately. A space is placed at the right end of the line.
This procedure returns |!input_has_ended| because we often want to
check the value of that variable after calling the procedure.

If we've just changed from the |cur_file| to the |change_file|, or if
the |cur_file| has changed, we tell \.{TANGLE} to print this
information in the \Cee\ file by means of the |print_where| flag.

@d max_modules 2000 /* number of identifiers, strings, module names;
  must be less than 10240 */

@<Defin...@>=
typedef unsigned short sixteen_bits;
sixteen_bits module_count; /* the current module number */
boolean changed_module[max_modules]; /* is the module changed? */
boolean change_pending; /* if the current change is not yet recorded in
  |changed_module[module_count]| */
boolean print_where=0; /* should \.{TANGLE} print line and file info? */

@ @<Fun...@>=
get_line() /* inputs the next line */
{
  restart:
  if (changing) @<Read from |change_file| and maybe turn off |changing|@>;
  if (! changing) {
    @<Read from |cur_file| and maybe turn on |changing|@>;
    if (changing) goto restart;
  }
  loc=buffer; *limit=' ';
  if (*buffer=='@@' && (*(buffer+1)=='i' || *(buffer+1)=='I'))
    @<Push stack and go to |restart|@>;
  return (!input_has_ended);
}

@ When a \.{@@i} line is found in the |cur_file|, we must temporarily
stop reading it and start reading from the named include file.  The
\.{@@i} line should give a complete file name with or without
double quotes;
\.{CWEB} will not look for include files in standard directories as the
\Cee\ preprocessor does when a |
#include <filename>
| line is found, although it will try a prefix if |INCLUDEDIR| is
defined at compile time. The remainder of the line after the file name
is ignored.

@<Push stack and...@>= {
  char *k, *j;
  loc=buffer+2;
  while (loc<=limit && (*loc==' '||*loc=='\t'||*loc=='"')) loc++;
  if (loc>=limit) err_print("! Include file name not given");
@.Include file name not given@>
  else {
    if (++include_depth<max_include_depth) {
      k=cur_file_name; j=loc;
      while (*loc!=' '&&*loc!='\t'&&*loc!='"') *k++=*loc++;
      *k='\0';
      if ((cur_file=fopen(cur_file_name,"r"))==NULL) {
#ifdef INCLUDEDIR
strcpy(cur_file_name,INCLUDEDIR);
k=cur_file_name+strlen(cur_file_name);
while (*j!=' '&&*j!='\t'&&*j!='"') *k++=*j++;
*k='\0';
if ((cur_file=fopen(cur_file_name,"r"))==NULL) {
#endif INCLUDEDIR
        include_depth--;
        err_print("! Cannot open include file");
@.Cannot open include file@>
      }
#ifdef INCLUDEDIR
else {cur_line=0; print_where=1;}
}
#endif INCLUDEDIR
      else {cur_line=0; print_where=1;}
    }
    else {
      include_depth--;
      err_print("! Too many nested includes");
@.Too many nested includes@>
    }
  }
  goto restart;
}

@ @<Read from |cur_file|...@>= {
  cur_line++;
  while (!input_ln(cur_file)) { /* pop the stack or quit */
    print_where=1;
    if (include_depth==0) {input_has_ended=1; break;}
    else {fclose(cur_file); include_depth--; cur_line++;}
  }
  if (!input_has_ended)
  if (limit==change_limit-change_buffer+buffer)
    if (buffer[0]==change_buffer[0])
      if (change_limit>change_buffer) check_change();
}

@ @<Read from |change_file|...@>= {
  change_line++;
  if (!input_ln(change_file)) {
    err_print("! Change file ended without @@z");
@.Change file ended...@>
    buffer[0]='@@'; buffer[1]='z'; limit=buffer+2;
  }
  if (limit>buffer) { /* check if the change has ended */
    if (change_pending) {
      if_module_start_make_pending(0);
      if (change_pending) {
        changed_module[module_count]=1; change_pending=0;
      }
    }
    *limit=' ';
    if (buffer[0]=='@@') {
      if (isupper(buffer[1])) buffer[1]=tolower(buffer[1]);
      @<Check for erron...@>;
      if (buffer[1]=='x' || buffer[1]=='y') {
      loc=buffer+2; err_print("! Where is the matching @@z?");
@.Where is the match...@>
      }
      else if (buffer[1]=='z') {
        prime_the_change_buffer(); changing=!changing; print_where=1;
      }
    }
  }
}

@ At the end of the program, we will tell the user if the change file
had a line that didn't match any relevant line in |web_file|.

@<Funct...@>=
check_complete(){
  if (change_limit!=change_buffer) { /* |changing| is 0 */
    strncpy(buffer,change_buffer,change_limit-change_buffer+1);
    limit=change_limit-change_buffer+buffer;
    changing=1; loc=buffer;
    err_print("! Change file entry did not match");
  @.Change file entry did not match@>
  }
}

@* Storage of names and strings.
Both \.{WEAVE} and \.{TANGLE} store identifiers, module names and
other strings in a large array of |char|s, called |byte_mem|.
Information about the names is kept in the array |name_dir|, whose
elements are structures of type |name_info|, containing a pointer into
the |byte_mem| array (the address where the name begins) and other data.
A |name_pointer| variable is a pointer into |name_dir|.

@d max_bytes 90000 /* the number of bytes in identifiers,
  index entries, and module names */
@d max_names 4000 /* number of identifiers, strings, module names;
  must be less than 10240 */

@<Definitions that...@>=
typedef struct name_info {
  char *byte_start; /* beginning of the name in |byte_mem| */
  @<More elements of |name_info| structure@>@;
} name_info; /* contains information about an identifier or module name */
typedef name_info *name_pointer; /* pointer into array of |name_info|s */
char byte_mem[max_bytes]; /* characters of names */
char *byte_mem_end = byte_mem+max_bytes-1; /* end of |byte_mem| */
name_info name_dir[max_names]; /* information about names */
name_pointer name_dir_end = name_dir+max_names-1; /* end of |name_dir| */

@ The actual sequence of characters in the name pointed to by a |name_pointer
p| appears in positions |p->byte_start| to |(p+1)->byte_start-1|, inclusive.
The |print_id| macro prints this text on the user's terminal.

@d length(c) (c+1)->byte_start-(c)->byte_start /* the length of a name */
@d print_id(c) term_write((c)->byte_start,length((c)))
  /* print identifier or module name */

@ The first unused position in |byte_mem| and |name_dir| is
kept in |byte_ptr| and |name_ptr|, respectively.  Thus we
usually have |name_ptr->byte_start=byte_ptr|, and certainly
we want to keep |name_ptr<=name_dir_end| and |byte_ptr<=byte_mem_end|.

@<Defini...@>=
name_pointer name_ptr; /* first unused position in |byte_start| */
char *byte_ptr; /* first unused position in |byte_mem| */

@ @<Init...@>=
name_dir->byte_start=byte_ptr=byte_mem; /* position zero in both arrays */
name_ptr=name_dir+1; /* |name_dir[0]| will be used only for error recovery */
name_ptr->byte_start=byte_mem; /* this makes name 0 of length zero */

@ The names of identifiers are found by computing a hash address |h| and
then looking at strings of bytes signified by the |name_pointer|s
|hash[h]|, |hash[h]->link|, |hash[h]->link->link|, \dots,
until either finding the desired name or encountering the null pointer.

@<More elements of |name...@>=
struct name_info *link;

@ The hash table itself
consists of |hash_size| entries of type |name_pointer|, and is
updated by the |id_lookup| procedure, which finds a given identifier
and returns the appropriate |name_pointer|. The matching is done by the
function |names_match|, which is slightly different in
\.{WEAVE} and \.{TANGLE}.  If there is no match for the identifier,
it is inserted into the table.

@d hash_size 353 /* should be prime */

@<Defini...@>=
typedef name_pointer *hash_pointer;
name_pointer hash[hash_size]; /* heads of hash lists */
hash_pointer hash_end = hash+hash_size-1; /* end of |hash| */
hash_pointer h; /* index into hash-head array */

@ Initially all the hash lists are empty.

@<Init...@>=
for (h=hash; h<=hash_end; *h++=NULL) ;

@ Here is the main procedure for finding identifiers:

@c name_pointer
id_lookup(first,last,t) /* looks up a string in the identifier table */
char *first; /* first character of string */
char *last; /* last character of string plus one */
sixteen_bits t; /* the |ilk|; used by \.{WEAVE} only */
{
  char *i=first; /* position in |buffer| */
  int h; /* hash code */
  int l; /* length of the given identifier */
  name_pointer p; /* where the identifier is being sought */
  if (last==NULL) for (last=first; *last!='\0'; last++);
  l=last-first; /* compute the length */
  @<Compute the hash code |h|@>;
  @<Compute the name location |p|@>;
  if (p==name_ptr) @<Enter a new name into the table at position |p|@>;
  return(p);
}

@ A simple hash code is used: If the sequence of
character codes is $c_1c_2\ldots c_n$, its hash value will be
$$(2^{n-1}c_1+2^{n-2}c_2+\cdots+c_n)\,\bmod\,|hash_size|.$$

@<Compute the hash...@>=
h=*i; while (++i<last) h=(h+h+*i) % hash_size;

@ If the identifier is new, it will be placed in position |p=name_ptr|,
otherwise |p| will point to its existing location.

@<Compute the name location...@>=
p=hash[h];
while (p && !names_match(p,first,l,t)) p=p->link;
if (p==NULL) {
  p=name_ptr; /* the current identifier is new */
  p->link=hash[h]; hash[h]=p; /* insert |p| at beginning of hash list */
}

@ The information associated with a new identifier must be initialized
in a slightly different way in \.{WEAVE} than in \.{TANGLE}; hence the
|init_p| procedure.

@<Enter a new name...@>= {
  if (byte_ptr+l>byte_mem_end) overflow("byte memory");
  if (name_ptr>=name_dir_end) overflow("name");
  strncpy(byte_ptr,first,l);
  (++name_ptr)->byte_start=byte_ptr+=l;
  if (program==weave) init_p(p,t);
}

@ The names of modules are stored in |byte_mem| together
with the identifier names, but a hash table is not used for them because
\.{TANGLE} needs to be able to recognize a module name when given a prefix of
that name. A conventional binary search tree is used to retrieve module names,
with fields called |llink| and |rlink| (where |llink| takes the place
of |link|).  The root of this tree is stored in |name_dir->rlink|;
this will be the only information in |name_dir[0]|.

Since the space used by |rlink| has a different function for
identifiers than for module names, we declare it as a |union|.

@d llink link /* left link in binary search tree for module names */
@d rlink dummy.Rlink /* right link in binary search tree for module names */
@d root name_dir->rlink /* the root of the binary search tree
  for module names */

@<More elements of |name...@>=
union {
  struct name_info *Rlink; /* right link in binary search tree for module
    names */  
  sixteen_bits Ilk; /* used by identifiers in \.{WEAVE} only */
} dummy;

@ @<Init...@>=
root=NULL; /* the binary search tree starts out with nothing in it */

@ The |mod_lookup| procedure finds a module name in the
search tree, after inserting it if necessary, and returns a pointer to
where it was found.

According to the rules of \.{WEB}, no module name should be a proper
prefix of another, so a ``clean'' comparison should occur between any
two names. The result of |mod_lookup| is |name_dir| (the location of
a dummy module name) if this prefix condition
is violated. An error message is printed when such violations are detected.

@d less 0 /* the first name is lexicographically less than the second */
@d equal 1 /* the first name is equal to the second */
@d greater 2 /* the first name is lexicographically greater than the second */
@d prefix 3 /* the first name is a proper prefix of the second */
@d extension 4 /* the first name is a proper extension of the second */

@<Other...@>=
name_pointer install_node();

@ @c name_pointer
mod_lookup(k,l) /* finds module name */
char *k; /* first character of name */
char *l; /* last character of name */
{
  short c = greater; /* comparison between two names */
  name_pointer p = root; /* current node of the search tree */
  name_pointer q = name_dir; /* father of node |p| */
  while (p) {
    c=web_strcmp(k,l+1,p->byte_start,(p+1)->byte_start);
    q=p;
    switch(c) {
      case less: p=p->llink; continue;
      case greater: p=p->rlink; continue;
      case equal: return p;
      default: err_print("! Incompatible section names"); return name_dir;
@.Incompatible section names@>
    }
  }
  return(install_node(q,c,k,l-k+1));
}

@ This function is like |strcmp|, but it does not assume the strings
are null-terminated.

@c
web_strcmp(j,j1,k,k1) /* fuller comparison than |strcmp| */
char *j; /* beginning of first string */
char *j1; /* end of first string plus one */
char *k; /* beginning of second string */
char *k1; /* end of second string plus one */
{
  while (k<k1 && j<j1 && *j==*k) k++, j++;
  if (k==k1) if (j==j1) return equal;
    else return extension;
  else if (j==j1) return prefix;
  else if (*j<*k) return less;
  else return greater;
}

@ The reason we initialized |c| to |greater| is so that
|name_pointer| will make |name_dir->rlink| point to the root of the tree 
when |q=name_dir|, that is, the first time it is called.

The information associated with a new node must be initialized
in a slightly different way in \.{WEAVE} than in \.{TANGLE}; hence the
|init_node| procedure.

@c name_pointer
install_node(parent,c,j,name_len) /* install a new node in the tree */
name_pointer parent; /* parent of new node */
int c; /* right or left? */
char *j; /* where replacement text starts */
int name_len; /* length of replacement text */
{
  name_pointer node=name_ptr; /* new node */
  if (byte_ptr+name_len>byte_mem_end) overflow("byte memory");
  if (name_ptr==name_dir_end) overflow("name");
  if (c==less) parent->llink=node; else parent->rlink=node;
  node->llink=NULL; node->rlink=NULL;
  init_node(node);
  strncpy(byte_ptr,j,name_len);
  (++name_ptr)->byte_start=byte_ptr+=name_len;
  return(node);
}

@ The |prefix_lookup| procedure is supposed to find exactly one module
name that has |k..l| as a prefix. Actually the algorithm
silently accepts also the situation that some module name is a prefix of
|k..l|, because the user who painstakingly typed in more than
necessary probably doesn't want to be told about the wasted effort.

@c name_pointer
prefix_lookup(k,l) /* finds module name given a prefix */
char *k; /* first char of prefix */
char *l; /* last char of prefix */
{
  short c = greater; /* comparison between two names */
  short count = 0; /* the number of hits */
  name_pointer p = root; /* current node of the search tree */
  name_pointer q = NULL;
    /* another place to resume the search after one is done */
  name_pointer r = name_dir; /* extension found */
  while (p) {
    c=web_strcmp(k,l+1,p->byte_start,(p+1)->byte_start);
    switch(c) {
      case less: p=p->llink; break;
      case greater: p=p->rlink; break;
      default: r=p; count++; q=p->rlink; p=p->llink;
    }
    if (p==NULL) {
      p=q; q=NULL;
    }
  }
  if (count==0) err_print("! Name does not match");
@.Name does not match@>
  if (count>1) err_print("! Ambiguous prefix");
@.Ambiguous prefix@>
  return(r); /* the result will be |name_dir| if there was no match */
}

@ The last component of |name_info| is different for \.{TANGLE} and
\.{WEAVE}.  In \.{TANGLE}, if |p| is a pointer to a module name,
|p->equiv| is a pointer to its replacement text, an element of the
array |text_info|.  In \.{WEAVE}, on the other hand, if 
|p| points to an identifier, |p->xref| is a pointer to its
list of cross-references, an element of the array |xmem|.  The make-up
of |text_info| and |xmem| is discussed in the \.{TANGLE} and \.{WEAVE}
source files, respectively; here we just declare a common field
|equiv_or_xref| as a pointer to a |char|.

@<More elements of |name...@>=
char *equiv_or_xref; /* info corresponding to names */

@* Reporting errors to the user.
A global variable called |history| will contain one of four values
at the end of every run: |spotless| means that no unusual messages were
printed; |harmless_message| means that a message of possible interest
was printed but no serious errors were detected; |error_message| means that
at least one error was found; |fatal_message| means that the program
terminated abnormally. The value of |history| does not influence the
behavior of the program; it is simply computed for the convenience
of systems that might want to use such information.

@d spotless 0 /* |history| value for normal jobs */
@d harmless_message 1 /* |history| value when non-serious info was printed */
@d error_message 2 /* |history| value when an error was noted */
@d fatal_message 3 /* |history| value when we had to stop prematurely */
@d mark_harmless {if (history==spotless) history=harmless_message;}
@d mark_error history=error_message

@<Definit...@>=
int history=spotless; /* indicates how bad this run was */

@ The command `|err_print("! Error message")|' will report a syntax error to
the user, by printing the error message at the beginning of a new line and
then giving an indication of where the error was spotted in the source file.
Note that no period follows the error message, since the error routine
will automatically supply a period. A newline is automatically supplied
if the string begins with |"|"|.

@<Functions...@>=
err_print(s) /* prints `\..' and location of error message */
char *s;
{
  char *k,*l; /* pointers into |buffer| */
  printf(*s=='!'? "\n%s" : "%s",s);
  if(web_file_open) @<Print error location based on input buffer@>;
  update_terminal; mark_error;
}

@ The error locations can be indicated by using the global variables
|loc|, |cur_line|, |cur_file_name| and |changing|,
which tell respectively the first
unlooked-at position in |buffer|, the current line number, the current
file, and whether the current line is from |change_file| or |cur_file|.
This routine should be modified on systems whose standard text editor
has special line-numbering conventions.
@^system dependencies@>

@<Print error location based on input buffer@>=
{if (changing) printf(". (l. %d of change file)\n", change_line);
else if (include_depth==0) printf(". (l. %d)\n", cur_line);
  else printf(". (l. %d of include file %s)\n", cur_line, cur_file_name);
l= (loc>=limit? limit: loc);
if (l>buffer) {
  for (k=buffer; k<l; k++)
    if (*k=='\t') putchar(' ');
    else putchar(*k); /* print the characters already read */
  putchar('\n');
  for (k=buffer; k<l; k++) putchar(' '); /* space out the next line */
}
for (k=l; k<limit; k++) putchar(*k); /* print the part not yet read */
if (*limit=='|') putchar('|'); /* end of \Cee\ text in module names */
putchar(' '); /* to separate the message from future asterisks */
}

@ When no recovery from some error has been provided, we have to wrap
up and quit as graciously as possible.  This is done by calling the
function |wrap_up| at the end of the code.

@d fatal(s,t) {
  printf(s); err_print(t);
  history=fatal_message; wrap_up();
}

@ Sometimes the program's behavior is far different from what it should be,
and \.{WEB} prints an error message that is really for the \.{WEB}
maintenance person, not the user. In such cases the program says
|confusion("indication of where we are")|.

@d confusion(s) fatal("! This can't happen: ",s)
@.This can't happen@>

@ An overflow stop occurs if \.{WEB}'s tables aren't large enough.

@d overflow(t) {
  printf("\n! Sorry, %s capacity exceeded",t); fatal("","");
}
@.Sorry, capacity exceeded@>

@ Some implementations may wish to pass the |history| value to the
operating system so that it can be used to govern whether or not other
programs are started. Here, for instance, we pass the operating system
a status of 0 if and only if only harmless messages were printed.
@^system dependencies@>

@<Func...@>=
wrap_up() {
  putchar('\n');
#ifdef STAT
  if (show_stats) print_stats(); /* print statistics about memory usage */
#endif
  @<Print the job |history|@>;
  if (history > harmless_message) exit(1);
  else exit(0);
}

@ @<Print the job |history|@>=
switch (history) {
case spotless: if (show_happiness) printf("(No errors were found.)\n"); break;
case harmless_message:
  printf("(Did you see the warning message above?)\n"); break;
case error_message:
  printf("(Pardon me, but I think I spotted something wrong.)\n"); break;
case fatal_message: printf("(That was a fatal error, my friend.)\n");
} /* there are no other cases */

@* Command line arguments.
The user calls \.{CWEAVE} and \.{CTANGLE} with arguments on the command line.
These are either file names or flags to be turned off (beginning with |"-"|)
or flags to be turned on (beginning with |"+"|.
The following globals are for communicating the user's desires to the rest
of the program. The various file name variables contain strings with
the names of those files. Most of the 128 flags are undefined but available
for future extensions.

@d show_banner flags['b'] /* should the banner line be printed? */
@d show_progress flags['p'] /* should progress reports be printed? */
@d show_stats flags['s'] /* should statistics be printed at end of run? */
@d show_happiness flags['h'] /* should lack of errors be announced? */

@<Defin...@>=
int argc; /* copy of |ac| parameter to |main| */
char **argv; /* copy of |av| parameter to |main| */
char C_file_name[max_file_name_length]; /* name of |C_file| */
char tex_file_name[max_file_name_length]; /* name of |tex_file| */
boolean flags[128]; /* an option for each 7-bit code */

@ The |flags| will be initially zero. Some of them are set to~1 before
scanning the arguments; if additional flags are 1 by default they
should be set before calling |common_init|.

@<Set the default options common to \.{TANGLE} and \.{WEAVE}@>=
show_banner=show_happiness=show_progress=1;

@ We now must look at the command line arguments and set the file names
accordingly.  At least one file name must be present: the \.{WEB}
file.  It may have an extension, or it may omit the extension to get |".w"| or
|".web"| added.  The \TeX\ output file name is formed by replacing the \.{WEB}
file name extension by |".tex"|, and the \Cee\ file name by replacing
the extension by |".c"|, after removing the directory name (if any).

If there is a second file name present among the arguments, it is the
change file, again either with an extension or without one to get |".ch"|.
An omitted change file argument means that |"/dev/null"| should be used,
when no changes are desired.
@^system dependencies@>

If there's a third file name, it will be the output file.

@<Function...@>=
scan_args()
{
  char *dot_pos; /* position of |'.'| in the argument */
  char *name_pos; /* file name beginning, sans directory */
  register char *s; /* register for scanning strings */
  boolean found_web=0,found_change=0,found_out=0;
             /* have these names have been seen? */
  boolean flag_change;

  while (--argc > 0) {
    if (**(++argv)=='-' || **argv=='+') @<Handle flag argument@>@;
    else {
      s=name_pos=*argv;@+dot_pos=NULL;
      while (*s) {
        if (*s=='.') dot_pos=s++;
        else if (*s=='/') dot_pos=NULL,name_pos=++s;
        else s++;
      }
      if (!found_web) @<Make
       |web_file_name|, |tex_file_name| and |C_file_name|@>@;
      else if (!found_change) @<Make |change_file_name| from |fname|@>@;
      else if (!found_out) @<Override |tex_file_name| and |C_file_name|@>@;
        else @<Print usage error message and quit@>;
    }
  }
  if (!found_web) @<Print usage error message and quit@>;
  if (!found_change) strcpy(change_file_name,"/dev/null");
}

@ We use all of |*argv| for the |web_file_name| if there is a |'.'| in it,
otherwise we add |".w"|. If this file can't be opened, we prepare an
|alt_web_file_name| by adding |"web"| after the dot.
The other file names come from adding other things
after the dot.  We must check that there is enough room in
|web_file_name| and the other arrays for the argument.

@<Make |web_file_name|...@>=
{
  if (s-*argv > max_file_name_length-5)
    @<Complain about argument length@>;
  if (dot_pos==NULL)
    sprintf(web_file_name,"%s.w",*argv);
  else {
    strcpy(web_file_name,*argv);
    *dot_pos=0; /* string now ends where the dot was */
  }
  sprintf(alt_web_file_name,"%s.web",*argv);
  sprintf(tex_file_name,"%s.tex",name_pos); /* strip off directory name */
  sprintf(C_file_name,"%s.c",name_pos);
  found_web=1;
}

@ @<Make |change_file_name|...@>=
{
  if (s-*argv > max_file_name_length-4)
    @<Complain about argument length@>;
  if (dot_pos==NULL)
    sprintf(change_file_name,"%s.ch",*argv);
  else strcpy(change_file_name,*argv);
  found_change=1;
}

@ @<Override...@>=
{
  if (s-*argv > max_file_name_length-5)
    @<Complain about argument length@>;
  if (dot_pos==NULL) {
    sprintf(tex_file_name,"%s.tex",*argv);
    sprintf(C_file_name,"%s.c",*argv);
  } else {
    strcpy(tex_file_name,*argv);
    strcpy(C_file_name,*argv);
  }
  found_out=1;
}

@ @<Handle flag...@>=
{
  if (**argv=='-') flag_change=0;
  else flag_change=1;
  for(dot_pos=*argv+1;*dot_pos>'\0';dot_pos++)
    flags[*dot_pos]=flag_change;
}

@ @<Print usage error message and quit@>=
{
if (program==tangle)
  fatal(
"! Usage: ctangle [options] webfile[.w] [changefile[.ch] [outfile[.c]]]\n"
   ,"")@;
else fatal(
"! Usage: cweave [options] webfile[.w] [changefile[.ch] [outfile[.tex]]]\n"
   ,"");
}

@ @<Complain about arg...@>= fatal("! Filename too long\n", *argv);

@* Output. Here is the code that opens the output file:
@^system dependencies@>

@<Defin...@>=
FILE *C_file; /* where output of \.{TANGLE} goes */
FILE *tex_file; /* where output of \.{WEAVE} goes */

@ @<Scan arguments and open output files@>=
scan_args();
if (program==tangle) {
  if ((C_file=fopen(C_file_name,"w"))==NULL)
    fatal("! Cannot open output file ", C_file_name);
@.Cannot open output file@>
}
else {
  if ((tex_file=fopen(tex_file_name,"w"))==NULL)
    fatal("! Cannot open output file ", tex_file_name);
}

@ The |update_terminal| procedure is called when we want
to make sure that everything we have output to the terminal so far has
actually left the computer's internal buffers and been sent.
@^system dependencies@>

@d update_terminal fflush(stdout) /* empty the terminal output buffer */

@ Terminal output uses |putchar| and |putc| when we have to
translate from \.{WEB}'s code into the external character code,
and |printf| when we just want to print strings.
Several macros make other kinds of output convenient.
@^system dependencies@>
@d new_line putchar('\n') @d putxchar putchar
@d term_write(a,b) fflush(stdout), write(1,a,b) /* write on the standard output */
@d line_write(c) write(fileno(C_file),c) /* write on the C output file */
@d C_printf(c,a) fprintf(C_file,c,a)
@d C_putc(c) putc(c,C_file) /* isn't \UNIX\ wonderfully consistent? */

@* Index.
