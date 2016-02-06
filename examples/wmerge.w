\def\9#1{} % this hack is explained in CWEB manual Appendix F11

@* Introduction.  This file contains the program \.{wmerge},
which takes two or more files and merges them according
to the conventions of \.{CWEB}. Namely, it takes an ordinary \.{.w}
file and and optional \.{.ch} file and sends the corresponding
\.{.w}-style file to standard output, expanding all ``includes''
that might be specified by \.{@@i} in the original \.{.w} file.
(A more precise description appears in the section on ``command line
arguments'' below.)

@c
#include <stdio.h>
@<Definitions@>@;
@<Functions@>;
main (argc,argv)
char **argv;
{
  scan_args(argc,argv);
  reset_input();
  while (get_line())
    put_line();
  wrap_up();
}

@ @<Definitions@>=
typedef short boolean;
typedef char unsigned eight_bits;
typedef char ASCII; /* type of characters inside \.{WEB} */

@ The lowest level of input to the \.{WEB} programs
is performed by |input_ln|, which must be told which file to read from.
The return value of |input_ln| is 1 if the read is successful and 0 if
not (generally this means the file has ended).
The characters of the next line of the file
are copied into the |buffer| array,
and the global variable |limit| is set to the first unoccupied position.
Trailing blanks are ignored. The value of |limit| must be strictly less
than |buf_size|, so that |buffer[buf_size-1]| is never filled.

We assume that none of the |ASCII| values of |*j| for |buffer<=j<limit|
is equal to 0, |0177|, |line_feed|, |form_feed|, or |carriage_return|.
Since |buf_size| is strictly less than |long_buf_size|,
some of \.{WEB}'s routines use the fact that it is safe to refer to
|*(limit+2)| without overstepping the bounds of the array.

@d buf_size 100 /* for \.{WEAVE} and \.{TANGLE} */

@<Definitions...@>=
ASCII buffer[buf_size]; /* where each line of input goes */
ASCII *buffer_end=buffer+buf_size-2; /* end of |buffer| */
ASCII *limit; /* points to the last character in the buffer */
ASCII *loc; /* points to the next character to be read from the buffer */

@ In the unlikely event that your standard I/O library does not
support |feof|, |getc| and |ungetc|, you may have to change things here.
@^system dependencies@>

Incidentally, here's a curious fact about \.{CWEB} for those of you
who are reading this file as an example of \.{CWEB} programming.
The file \.{stdio.h} includes a typedef for
the identifier |FILE|, which is not, strictly speaking, part of \Cee.
It turns out \.{CWEAVE} knows that |FILE| is a reserved word (after all,
|FILE| is almost as common as |int|); indeed, \.{CWEAVE} knows all
the types of the ISO standard \Cee\ library. But
if you're using other types like {\bf caddr\_t},
@:caddr_t}{\bf caddr_t@>
which is defined in \.{/usr/include/sys/types.h}, you should let
\.{WEAVE} know that this is a type, either by including the \.{.h} file
at \.{WEB} time (saying \.{@@i /usr/include/sys/types.h}), or by
using \.{WEB}'s format command (saying \.{@@f caddr\_t int}).  Either of
these will make {\bf caddr\_t} be treated in the same way as |int|. 

@<Func...@>=
#include <stdio.h>
input_ln(fp) /* copies a line into |buffer| or returns 0 */
FILE *fp; /* what file to read from */
{
  register int  c; /* the character read */
  register ASCII *k;  /* where next character goes */
  if (feof(fp)) return(0);  /* we have hit end-of-file */
  limit = k = buffer;  /* beginning of buffer */
  while (k<=buffer_end && (c=getc(fp)) != EOF && c!='\n')
    if ((*(k++) = c) != @' ') limit = k;
  if (k>buffer_end)
    if ((c=getc(fp))!=EOF && c!='\n') {
      ungetc(c,fp); loc=buffer; err_print("\n! Input line too long");
@.Input line too long@>
  }
  if (c==EOF && limit==buffer) return(0);  /* there was nothing after
    the last newline */
  return(1);
}

@ Now comes the problem of deciding which file to read from next.
Recall that the actual text that \.{WEB} should process comes from two
streams: a |web_file|, which can contain possibly nested include
commands `|@i|', and a |change_file|, which should not contain
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
int line[max_include_depth]; /* number of current line in the stacked files */
int change_line; /* number of current line in change file */
boolean input_has_ended; /* if there is no more input */
boolean changing; /* if the current line is from |change_file| */

@ When |changing=0|, the next line of |change_file| is kept in
|change_buffer|, for purposes of comparison with the next
line of |cur_file|. After the change file has been completely input, we
set |change_limit-limit=change_buffer-buffer|,
so that no further matches will be made.

Here's a shorthand expression for inequality between the two lines:

@d lines_dont_match (change_limit-change_buffer != limit-buffer ||
  strncmp(buffer, change_buffer, limit-buffer))

@<Def...@>=
ASCII change_buffer[buf_size]; /* where next line of |change_file| is kept */
ASCII *change_limit; /* points to the last character in |change_buffer| */

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
  if (buffer[0]!=@'@@') continue;
  @<Lowercasify |buffer[1]|@>;
  @<Check for erroneous \.{@@i}@>;
  if (buffer[1]==@'x') break;
  if (buffer[1]==@'y' || buffer[1]==@'z') {
    loc=buffer+2;
    err_print("! Where is the matching @@x?");
@.Where is the match...@>
  }
}

@ This line of code makes |"@@X"| equivalent to |"@@x"| and so on.

@<Lowerc...@>=
if (buffer[1]>=@'X' && buffer[1]<=@'Z' || buffer[1]==@'I') buffer[1]+=@'z'-@'Z';

@ We do not allow includes in a change file, so as to avoid confusion.

@<Check for erron...@>= {
  if (buffer[1]==@'i') {
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

@<Func...@>=
check_change() /* switches to |change_file| if the buffers match */
{
  int n=0; /* the number of discrepancies found */
  if (lines_dont_match) return;
  while (1) {
    changing=1; print_where=1; change_line++;
    if (!input_ln(change_file)) {
      err_print("! Change file ended before @@y");
@.Change file ended...@>
      change_limit=change_buffer; changing=0; print_where=1;
      return;
    }
    if (limit>buffer+1 && buffer[0]==@'@@')
      @<Check for erron...@>;
    @<If the current line starts with \.{@@y},
      report any discrepancies and |return|@>;@/
    @<Move |buffer| and |limit|...@>;@/
    changing=0; print_where=1; cur_line++;
    while (!input_ln(cur_file)) { /* pop the stack or quit */
      if (include_depth==0) {
        err_print("! WEB file ended during a change");
@.WEB file ended...@>
        input_has_ended=1; return;
      }
      include_depth--; print_where=1; cur_line++;
    }
    if (lines_dont_match) n++;
  }
}

@ @<If the current line starts with \.{@@y}...@>=
if (limit>buffer+1 && buffer[0]==@'@@') {
  @<Lowerc...@>;
  if (buffer[1]==@'x' || buffer[1]==@'z') {
    loc=buffer+2; err_print("! Where is the matching @@y?");
@.Where is the match...@>
    }
  else if (buffer[1]==@'y') {
    if (n>0) {
      loc=buffer+2;
      err_print("! Hmm... some of the preceding lines failed to match");
@.Hmm... some of the preceding...@>
    }
    return;
  }
}

@ The |reset_input| procedure, which gets \.{CWEAVE} ready to read the
user's \.{WEB} input, is used at the beginning of phases one and two.

@<Func...@>=
reset_input()
{
  limit=buffer; loc=buffer+1; buffer[0]=@' ';
  @<Open input files@>;
  cur_line=0; change_line=0; include_depth=0;
  changing=1; prime_the_change_buffer(); changing=!changing;
  limit=buffer; loc=buffer+1; buffer[0]=@' '; input_has_ended=0;
}

@ The following code opens the input files.
@^system dependencies@>

@<Open input files@>=
if ((web_file=fopen(web_file_name,"r"))==NULL)
	fatal("! Cannot open input file", web_file_name);
if ((change_file=fopen(change_file_name,"r"))==NULL)
	fatal("! Cannot open change file", change_file_name);

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
boolean print_where=0; /* tells \.{TANGLE} to print line and file info */

@ @<Fun...@>=
get_line() /* inputs the next line */
{
  restart:
  if (changing) changed_module[module_count]=1;
  else @<Read from |cur_file| and maybe turn on |changing|@>;
  if (changing) {
    @<Read from |change_file| and maybe turn off |changing|@>;
    if (! changing) {
      changed_module[module_count]=1; goto restart;
    }
  }
  loc=buffer; *limit=@' ';
  if (*buffer==@'@@' && (*(buffer+1)==@'i' || *(buffer+1)==@'I'))
    @<Push stack and go to |restart|@>;
  return (!input_has_ended);
}

put_line()
{
  char *ptr=buffer;
  while (ptr<limit) putchar(*ptr++);
  putchar('\n');
}

@ When a \.{@@i} line is found in the |cur_file|, we must temporarily
stop reading it and start reading from the named include file.  The
\.{@@i} line should give a complete file name with or without \.{"..."};
\.{WEB} will not look for include files in standard directories as the
\Cee\ preprocessor does when a |
#include <filename>| line is found.
Also, the file name should only contain visible ASCII characters,
since the characters are translated into ASCII and back again.

@<Push stack and...@>= {
  ASCII *k, *j;
  loc=buffer+2;
  while (loc<=limit && (*loc==@' '||*loc==@'\t'||*loc==@'"')) loc++;
  if (loc>=limit) err_print("! Include file name not given");
@.Include file name not given@>
  else {
    if (++include_depth<max_include_depth) {
      k=cur_file_name; j=loc;
      while (*loc!=@' '&&*loc!=@'\t'&&*loc!=@'"') *k++=*loc++;
      *k='\0';
      if ((cur_file=fopen(cur_file_name,"r"))==NULL) {
        loc=j;
        include_depth--;
        err_print("! Cannot open include file");
@.Cannot open include file@>
      }
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
    else {include_depth--; cur_line++;}
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
    buffer[0]=@'@@'; buffer[1]=@'z'; limit=buffer+2;
  }
  if (limit>buffer+1) /* check if the change has ended */
  if (buffer[0]==@'@@') {
    @<Lowerc...@>;
    @<Check for erron...@>;
    if (buffer[1]==@'x' || buffer[1]==@'y') {
    loc=buffer+2; err_print("! Where is the matching @@z?");
@.Where is the match...@>
    }
    else if (buffer[1]==@'z') {
      prime_the_change_buffer(); changing=!changing; print_where=1;
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
    changing=1; loc=change_limit;
    err_print("! Change file entry did not match");
  @.Change file entry did not match@>
  }
}

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
will automatically supply a period.

The actual error indications are provided by a procedure called |error|.
However, error messages are not actually reported during phase one,
since errors detected on the first pass will be detected again
during the second.

@<Functions...@>=
err_print(s) /* prints `\..' and location of error message */
char *s;
{
  ASCII *k,*l; /* pointers into |buffer| */
  fprintf(stderr,"\n%s",s);
  @<Print error location based on input buffer@>;
  fflush(stdout); mark_error;
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
if (changing) fprintf(stderr,". (l. %d of change file)\n", change_line);
else if (include_depth==0) fprintf(stderr,". (l. %d)\n", cur_line);
  else fprintf(stderr,". (l. %d of include file %s)\n", cur_line, cur_file_name);
l= (loc>=limit? limit: loc);
if (l>buffer) {
  for (k=buffer; k<l; k++)
    if (*k=='\t') putc(' ',stderr);
    else putc(*k,stderr); /* print the characters already read */
  putc('\n',stderr);
  for (k=buffer; k<l; k++) putc(' ',stderr); /* space out the next line */
}
for (k=l; k<limit; k++) putc(*k,stderr); /* print the part not yet read */
if (*limit==@'|') putc('|',stderr); /* end of \Cee\ text in module names */
putc(' ',stderr); /* to separate the message from future asterisks */

@ When no recovery from some error has been provided, we have to wrap
up and quit as graciously as possible.  This is done by calling the
function |wrap_up| at the end of the code.

@d fatal(s1,s2) {
  fprintf(stderr,s1); err_print(s2);
  history=fatal_message; wrap_up();
}

@ Sometimes the program's behavior is far different from what it should be,
and \.{WEB} prints an error message that is really for the \.{WEB}
maintenance person, not the user. In such cases the program says
|confusion("indication of where we are")|.

@d confusion(s) fatal("! This can't happen: ",s)
@.This can't happen@>

@ An overflow stop occurs if \.{WEB}'s tables aren't large enough.

@d overflow(s) {
  fprintf(stderr,"! Sorry, capacity exceeded: "); fatal("",s);
}
@.Sorry, x capacity exceeded@>

@ Some implementations may wish to pass the |history| value to the
operating system so that it can be used to govern whether or not other
programs are started. Here, for instance, we pass the operating system
a status of 0 if and only if only harmless messages were printed.
@^system dependencies@>

@<Func...@>=
wrap_up() {
  putc('\n',stderr);
  @<Print the job |history|@>;
  if (history > harmless_message) exit(1);
  else exit(0);
}

@ @<Print the job |history|@>=
switch (history) {
case spotless: fprintf(stderr,"(No errors were found.)\n"); break;
case harmless_message:
  fprintf(stderr,"(Did you see the warning message above?)\n"); break;
case error_message:
  fprintf(stderr,"(Pardon me, but I think I spotted something wrong.)\n");
    break;
case fatal_message: fprintf(stderr,"(That was a fatal error, my friend.)\n");
} /* there are no other cases */

@* Command line arguments.
The user calls \.{wmerge} with arguments on the command line.
We must look at the command line arguments and set the file names
accordingly.  At least one file name must be present: the \.{WEB}
file.  It may have an extension, or it may omit it to get |'.w'|
added.

If there is another file name present among the arguments, it is the
change file, again either with an extension or without one to get |'.ch'|
An omitted change file argument means that |'/dev/null'| should be used,
when no changes are desired.
@^system dependencies@>

@<Function...@>=
scan_args(argc,argv)
char **argv;
{
  char *dot_pos, *index(); /* position of |'.'| in the argument */
  boolean found_web=0,found_change=0; /* have these names have been seen? */
  while (--argc > 0) {
    ++argv;
    if (!found_web) @<Make |web_file_name|@>@;
    else if (!found_change) @<Make |change_file_name| from |fname|@>@;
      else @<Print usage error message and quit@>;
  }
  if (!found_web) @<Print usage error message and quit@>;
  if (!found_change) @<Set up null change file@>;
}

@ We use all of |*argv| for the |web_file_name| if there is a |'.'| in it,
otherwise add |'.w'|.  The other file names come from adding things
after the dot.  We must check that there is enough room in
|web_file_name| and the other arrays for the argument.

@<Make |web_file_name|@>=
{
  if (strlen(*argv) > max_file_name_length-5)
    @<Complain about argument length@>;
  if ((dot_pos=index(*argv,'.'))==NULL)
    sprintf(web_file_name,"%s.w",*argv);
  else {
    sprintf(web_file_name,"%s",*argv);
    *dot_pos=0; /* string now ends where the dot was */
  }
  found_web=1;
}

@ @<Make |change_file_name|...@>=
{
  if (strlen(*argv) > max_file_name_length-5)
    @<Complain about argument length@>;
  if ((dot_pos=index(*argv,'.'))==NULL)
    sprintf(change_file_name,"%s.ch",*argv);
  else sprintf(change_file_name,"%s",*argv);
  found_change=1;
}

@ @<Set up null...@>= strcpy(change_file_name,"/dev/null");

@ @<Print usage error message and quit@>=
{
  fatal("! Usage: wmerge webfile[.w] [changefile[.ch]]\n","")@;
}

@ @<Complain about arg...@>= fatal("! Filename %s too long\n", *argv);

@* Output. Here is the code that opens the output file:
@^system dependencies@>

@ The |update_terminal| procedure is called when we want
to make sure that everything we have output to the terminal so far has
actually left the computer's internal buffers and been sent.
@^system dependencies@>

@d update_terminal fflush(stdout) /* empty the terminal output buffer */

@* Index.
