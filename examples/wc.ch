								-*-Web-*-
This file, WC.CH, is part of CWEB.  It is a changefile written by
Andreas Scherer, Abt-Wolf-Straﬂe 17, 96215 Lichtenfels, Germany, for
WC.W that provides changes appropriate for ANSI-C compilers.

This program is distributed WITHOUT ANY WARRANTY, express or implied.

The following copyright notice extends to this changefile only, not to the
masterfile.

Copyright (c) 1993 Andreas Scherer

Permission is granted to make and distribute verbatim copies of this
document provided that the copyright notice and this permission notice
are preserved on all copies.

Permission is granted to copy and distribute modified versions of this
document under the conditions for verbatim copying, provided that the
entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

Version history:

Version	Date		Author	Comment
p1	1 Sep 1993	AS	First hack.
p2	29 Sep 1993	AS	File descriptor fd replaced by FILE pointer fp
p3	25 Oct 1993	AS	Updated to CWEB 3.0
p4	18 Nov 1993	AS	Updated to CWEB 3.1
------------------------------------------------------------------------------
@x l.5 Save paper.
\def\SPARC{SPARC\-\kern.1em station}
@y
\def\SPARC{SPARC\-\kern.1em station}
\def\fin{\par\vfill\eject % this is done when we are ending the index
  \message{Section names:}
  \def\note##1##2.{\quad{\eightrm##1~##2.}}
  \def\U{\note{Used in section}} % crossref for use of a section
  \def\Us{\note{Used in sections}} % crossref for uses of a section
  \def\I{\par\hangindent 2em}\let\*=*
  \readsections}
@z
------------------------------------------------------------------------------
An extra module will contain the local prototypes.
@x l.30
@c
@<Header files to include@>@/
@<Global variables@>@/
@<Functions@>@/
@<The main program@>
@y
@c
@<Header files to include@>@/
@<Global variables@>@/
@<Prototypes@>@/
@<Functions@>@/
@<The main program@>
@z
------------------------------------------------------------------------------
Also some global prototypes are needed.
@x l.39
@<Header files...@>=
#include <stdio.h>
@y
@<Header files...@>=
#include <stdio.h>
#include <stdlib.h>
@z
------------------------------------------------------------------------------
Just for completeness.
@x l.57
main (argc,argv)
@y
void main(argc,argv)
@z
------------------------------------------------------------------------------
We want *all* programs in this directory to be fully ANSI compatible.
@x l.104
@ Here's the code to open the file.  A special trick allows us to
handle input from |stdin| when no name is given.
Recall that the file descriptor to |stdin| is~0; that's what we
use as the default initial value.

@<Variabl...@>=
int fd=0; /* file descriptor, initialized to |stdin| */
@y
@ Here's the code to open the file.  A special trick allows us to
handle input from |stdin| when no name is given.

@<Variabl...@>=
FILE *fp=stdin; /* file pointer, initialized to the console */
@z
------------------------------------------------------------------------------
@x l.112
@ @d READ_ONLY 0 /* read access code for system |open| routine */
@y
@ @d READ_ONLY "r" /* read access code for system |fopen| routine */
@z
------------------------------------------------------------------------------
@x l.116
if (file_count>0 && (fd=open(*(++argv),READ_ONLY))<0) {
@y
if (file_count>0 && (fp=fopen(*(++argv),READ_ONLY))==0) {
@z
------------------------------------------------------------------------------
@x l.123
@ @<Close file@>=
close(fd);
@y
@ @<Close file@>=
fclose(fp);
@z
------------------------------------------------------------------------------
@x l.174
if (ptr>=buf_end) {
  ptr=buffer; c=read(fd,ptr,buf_size);
  if (c<=0) break;
  char_count+=c; buf_end=buffer+c;
}
@y
if (ptr>=buf_end) {
  ptr=buffer; c=fread(ptr,1,buf_size,fp);
  if (c<=0) break;
  char_count+=c; buf_end=buffer+c;
}
@z
------------------------------------------------------------------------------
|wc_print| does not return a value, so make it |void|.
@x l.213
wc_print(which, char_count, word_count, line_count)
char *which; /* which counts to print */
long char_count, word_count, line_count; /* given totals */
@y
void wc_print(which, char_count, word_count, line_count)
char *which; /* which counts to print */
long char_count, word_count, line_count; /* given totals */
@z
------------------------------------------------------------------------------
The additional module for the function prototypes must not disturb the
numbering of the original documentation.
@x l.237
@* Index.
@y
@ We declare the prototypes of the internal functions.

@<Prototypes@>=
void wc_print(char*,long,long,long);
void main(int,char**);

@* Index and section names.
@z
------------------------------------------------------------------------------
