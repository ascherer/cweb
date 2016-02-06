\def\fin{\par\vfill\eject % this is done when we are ending the index
  \message{Section names:}
  \def\note##1##2.{\quad{\eightrm##1~##2.}}
  \def\U{\note{Used in section}} % crossref for use of a section
  \def\Us{\note{Used in sections}} % crossref for uses of a section
  \def\I{\par\hangindent 2em}\let\*=*
  \readsections}

\nocon

@* Character code translation.  It is a non-trivial task to transfer `text
files' from one computer system to another, because of the different code
tables in use.  For example, on the Amiga there is {\mc ECMA}~94, also known
as {\mc ISO}~Latin~1 or {\mc ISO}~8859-1, {\mc MSDOS} has {\mc IBM}'s
International CodePage~850, and on some \UNIX/ systems there is {\mc
HP}~8.  All of these code tables are extensions to the standard {\mc
ASCII}, i.e., they provide additional symbols and characters with codes
from~128 to~255.  The following program is a simple tool for file
conversion by means of external translation files.

@c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
@#
void main(int argc, char **argv)
   {
   @<Local variables of |main|@>@;
@#
   @<Initialize the local variables@>@;
   @<Scan the arguments from the command line@>@;
   @<Set up the translation tables for both directions@>@;
   @<Copy |in_file| to |out_file| according to |trans_file|@>@;
   @<The endgame@>@;
   }

@ There are three different files used in the process of code translation.
Input is read from |in_file| and written to |out_file|.  |trans_file| is a
special file with exactly 512~characters in two groups of 256~characters
each, defining two translation tables at once.

@d in_file file[0]
@d out_file file[1]
@d trans_file file[2]
@#
@d in_file_name file_name[0]
@d out_file_name file_name[1]
@d trans_file_name file_name[2]
@d prog_name file_name[3]

@<Local variables of |main|@>=
FILE *file[3];
char file_name[4][60];

@ To control the direction of translation, this program accepts two
command line options, indicated by a leading `\.-' sign.  If you set
`\.{-t}' anywhere in the command line, translation is done according to
the |to_code| table, i.e., the output is written by means of this table.
If you set `\.{-f}', all characters read from |in_file| are translated
according to the |from_code| table.  You shouldn't use `\.{-f}' and
`\.{-t}' simultaneously.

@d copy_from flags['f']
@d copy_to flags['t']

@<Local variables of |main|@>=
unsigned char uc,*cp,from_code[256],to_code[256],flags[256];
unsigned char found_trans,found_in,found_out;
int i;

@ Either we use global variables, which are statically zeroed, or we must
do this ourselves.

@<Initialize the local variables@>=
   strcpy(prog_name,argv[0]);
   for(i=0; i<256; i++)
      flags[i]=0;
   found_trans=found_in=found_out=0;

@ @<Scan the arguments from the command line@>=
   while(--argc>0) {
      if(**(++argv)=='-')
         @<Handle flag argument@>@;
      else {
         if(!found_trans)
            @<Make |trans_file_name| and open |trans_file|@>@;
         else if(!found_in)
            @<Make |in_file_name| and open |in_file|@>@;
         else if(!found_out)
            @<Make |out_file_name| and open |out_file|@>@;
         }
      }
   if(!found_in || !found_out || !found_trans) {
      fprintf(stderr,"Usage: %s [options] trans_file in_file out_file\n"@|
         "\toptions are\n"@|
         "\t\t-t to translate to another codepage\n"@|
         "\t\t-f to translate from another codepage\n",prog_name);
      exit(1);
      }

@ There is a flag value for each possible character code, although only two
of them have a sensible meaning.

@<Handle flag argument@>=
   for(cp=*argv+1; *cp>'\0'; cp++)
      flags[*cp]=1;

@ @<Make |trans_file_name| and open |trans_file|@>={
   strcpy(trans_file_name,*argv);
   if(!(trans_file=fopen(trans_file_name,"r"))) exit(1);
   found_trans=1;
   }

@ @<Make |in_file_name| and open |in_file|@>={
   strcpy(in_file_name,*argv);
   if(!(in_file=fopen(in_file_name,"r"))) exit(1);
   found_in=1;
   }

@ @<Make |out_file_name| and open |out_file|@>={
   strcpy(out_file_name,*argv);
   if(!(out_file=fopen(out_file_name,"w"))) exit(1);
   found_out=1;
   }

@ After the files have been opened, the translation tables can be read
from |trans_file|.  Here we don't check for errors in |trans_file|.
Make sure that there are at least 512~characters to read.  The first
half of |trans_file| gives the translation rules for conversion ``from
the home system to the target system,'' i.e., for every character position
from~0 to~255 the numeric equivalent for the target system is given in form
of a byte value, the second half is the other way round, i.e., for every
character value from the foreign system the equivalent of the home system
is defined.  As soon this is done, we close the translation file.

@<Set up the translation tables for both directions@>=
   for(i=0; i<256; i++)
      to_code[i] = (unsigned char)fgetc(trans_file);
   for(i=0; i<256; i++)
      from_code[i] = (unsigned char)fgetc(trans_file);

   fclose(trans_file);

@ The code in this section actually translates |in_file| to |out_file|
according to the rules given in |trans_file|.  Here are two examples:

If you want to translate one of your {\mc ASCII} files for use on another
system, e.g., from Amiga to {\mc MSDOS}, use something like

\.{ct pc850.crossdos {\it$\langle$Amiga file$\rangle$}
-t {\it$\langle$MSDOS file$\rangle$}}

If you want to translate a file from another system to make it usable on
your own system, e.g., from {\mc MSDOS} to Amiga, use something like

\.{ct pc850.crossdos -f {\it$\langle$MSDOS file$\rangle$
$\langle$Amiga file$\rangle$}}

Note that in both cases \.{pc850.crossdos} is used as the |trans_file|, but
the direction of translation is determined by the appropriate option.  There
is no sense in setting both the `\.{-f}' and the `\.{-t}' option, the
results would get fouled up.

@<Copy |in_file| to |out_file| according to |trans_file|@>=
   while((uc = (unsigned char)fgetc(in_file)) != EOF) {
      if(copy_from) uc = from_code[uc];
      if(copy_to)
         fputc((int)to_code[uc],out_file);
      else
         fputc((int)uc,out_file);
      }

@ After our work is done we close the source and the target files and quit.

@<The endgame@>=
   fclose(in_file);
   fclose(out_file);
   exit(0);

@* Index.
