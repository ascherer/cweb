								-*-Web-*-
This file, WMERGE.CH, is part of CWEB.
It is a changefile for WMERGE.W, Version 3.1.

Authors and Contributors:
(H2B) Hans-Hermann Bode, Universität Osnabrück,
  (hhbode@@dosuni1.rz.uni-osnabrueck.de or HHBODE@@DOSUNI1.BITNET).

(KG) Klaus Guntermann, TH Darmstadt,
  (guntermann@@iti.informatik.th-darmstadt.de).

(AS) Andreas Scherer,
  Abt-Wolf-Straße 17, 96215 Lichtenfels, Germany.

Caveat utilitor:  Some of the source code introduced by this change file is
made conditional to the use of specific compilers on specific systems.
This applies to places marked with `#ifdef __TURBOC__' and `#ifdef _AMIGA'.

This program is distributed WITHOUT ANY WARRANTY, express or implied.

The following copyright notice extends to this changefile only, not to
the masterfile WMERGE.W.

Copyright (C) 1993,1994 Andreas Scherer
Copyright (C) 1991-1993 Hans-Hermann Bode

Permission is granted to make and distribute verbatim copies of this
document provided that the copyright notice and this permission notice
are preserved on all copies.

Permission is granted to copy and distribute modified versions of this
document under the conditions for verbatim copying, provided that the
entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

Version history:

Version	Date		Author	Comment
p2	13 Feb 1992	H2B	First hack.
p3	16 Apr 1992	H2B	Change of |@@i| allowed, /dev/null in case
				replaced by nul.
p4	21 Jun 1992	H2B	Nothing changed.
p5	21 Jul 1992	H2B	Nothing changed.
p5a	30 Jul 1992	KG	remove one #include <stdio.h>,
				use strchr instead of index and
				include <string.h> for |strchr| declaration
p5b	06 Aug 1992	KG	fixed a typo
p6	06 Sep 1992	H2B	Nothing changed.
p6a     15 Mar 1993     AS      SAS/C 6.0 support
p6b     28 Jul 1993     AS      make some functions return `void'
p6c	04 Sep 1993	AS	path searching with CWEBINCLUDE
p7	09 Oct 1993	AS	Updated to CWEB 2.8
p8a	11 Mar 1993	H2B	Converted to master change file.
				[Not released.]
p8b	15 Apr 1993	H2B	Updated for wmerge.w 3.0beta (?).
				[Not released.]
p8c	22 Jun 1993	H2B	Updated for final wmerge.w 3.0 (?).
p8d	26 Oct 1993	AS	Incorporated with Amiga version 2.8 [p7].
p8e	04 Nov 1993	AS	New patch level in accordance with CWEB.
p9	18 Nov 1993	AS	Update for wmerge.w 3.1.
	26 Nov 1993	AS	Minor casting problems fixed.
p9c	18 Jan 1994	AS	Version information included.
------------------------------------------------------------------------------
@x l.14
#include <stdio.h>
@y
#include <stdio.h>
#include <string.h>
@z
------------------------------------------------------------------------------
@x l.45
@<Predecl...@>=
extern int strlen(); /* length of string */
extern char* strcpy(); /* copy one string to another */
extern int strncmp(); /* compare up to $n$ string characters */
extern char* strncpy(); /* copy up to $n$ string characters */
@y
@z
------------------------------------------------------------------------------
@x l.94
input_ln(fp) /* copies a line into |buffer| or returns 0 */
FILE *fp; /* what file to read from */
@y
int input_ln(FILE *fp) /* copies a line into |buffer| or returns 0 */
  /* |fp|: what file to read from */
@z
------------------------------------------------------------------------------
AmigaDOS allows path names with up to 255 characters.
@x l.127
@d max_file_name_length 60
@y
@d max_file_name_length 256
@z
------------------------------------------------------------------------------
The third argument of `strncpy' should be of type `size_t' not `long'.
@x l.157
@d lines_dont_match (change_limit-change_buffer != limit-buffer ||
  strncmp(buffer, change_buffer, limit-buffer))
@y
@d lines_dont_match (change_limit-change_buffer != limit-buffer ||
  strncmp(buffer, change_buffer, (size_t)(limit-buffer)))
@z
------------------------------------------------------------------------------
To avoid some nasty warnings by strict ANSI C compilers we redeclare all
functions to `void' that return no concrete values.
@x l.172
void
prime_the_change_buffer()
@y
void prime_the_change_buffer(void)
@z
------------------------------------------------------------------------------
The third argument of `strncpy' should be of type `size_t' not `long'.
@x l.215
  strncpy(change_buffer,buffer,limit-buffer+1);
@y
  strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
@z
------------------------------------------------------------------------------
Another `void' function, i.e., a procedure.
@x l.231
void
check_change() /* switches to |change_file| if the buffers match */
@y
void check_change(void) /* switches to |change_file| if the buffers match */
@z
------------------------------------------------------------------------------
Another `void function, i.e., a procedure.
@x l.283
void
reset_input()
@y
void reset_input(void)
@z
------------------------------------------------------------------------------
SAS/C defines `putchar' as a macro and reports a warning about multiple
macro expansion.  The resulting `wmerge' is definitely wrong; it leaves
every second letter out.
@x l.345
void put_line()
{
  char *ptr=buffer;
  while (ptr<limit) putc(*ptr++,out_file);
  putc('\n',out_file);
}
@y
void put_line(void)
{
  char *ptr=buffer;
  while (ptr<limit)
  {
    putc(*ptr,out_file);
    *ptr++;
  }
  putc('\n',out_file);
}
@z
------------------------------------------------------------------------------
@x l.352
@ When an \.{@@i} line is found in the |cur_file|, we must temporarily
stop reading it and start reading from the named include file.  The
\.{@@i} line should give a complete file name with or without
double quotes.
If the environment variable \.{CWEBINPUTS} is set, or if the compiler flag 
of the same name was defined at compile time,
\.{CWEB} will look for include files in the directory thus named, if
it cannot find them in the current directory.
(Colon-separated paths are not supported.)
The remainder of the \.{@@i} line after the file name is ignored.
@y
@ When an \.{@@i} line is found in the |cur_file|, we must temporarily
stop reading it and start reading from the named include file.  The
\.{@@i} line should give a complete file name with or without
double quotes.  The remainder of the \.{@@i} line after the file name
is ignored.  \.{CWEB} will look for include files in standard directories
specified in the environment variable \.{CWEBINPUTS}. Multiple search paths
can be specified by delimiting them with \.{PATH\_SEPARATOR}s.  The given
file is searched for in the current directory first.  You also may include
device names; these must have a \.{DEVICE\_SEPARATOR} as their rightmost
character.
@z
------------------------------------------------------------------------------
CWEB will perform a path search for `@i'nclude files along the environment
variable CWEBINPUTS in case the given file can not be opened in the current
directory or in the absolute path.  The single paths are delimited by
PATH_SEPARATORs.
@x l.380
  kk=getenv("CWEBINPUTS");
  if (kk!=NULL) {
    if ((l=strlen(kk))>max_file_name_length-2) too_long();
    strcpy(temp_file_name,kk);
  }
  else {
#ifdef CWEBINPUTS
    if ((l=strlen(CWEBINPUTS))>max_file_name_length-2) too_long();
    strcpy(temp_file_name,CWEBINPUTS);
#else
    l=0; 
#endif /* |CWEBINPUTS| */
  }
  if (l>0) {
    if (k+l+2>=cur_file_name_end)  too_long();
@.Include file name ...@>
    for (; k>= cur_file_name; k--) *(k+l+1)=*k;
    strcpy(cur_file_name,temp_file_name);
    cur_file_name[l]='/'; /* \UNIX/ pathname separator */
    if ((cur_file=fopen(cur_file_name,"r"))!=NULL) {
      cur_line=0; 
      goto restart; /* success */
    }
  }
@y
@#
#ifdef _AMIGA
#define PATH_SEPARATOR   ','
#define DIR_SEPARATOR    '/'
#define DEVICE_SEPARATOR ':'
#else
#ifdef __TURBOC__
#define PATH_SEPARATOR   ';'
#define DIR_SEPARATOR    '\\'
#define DEVICE_SEPARATOR ':'
#else
#define PATH_SEPARATOR   ':'
#define DIR_SEPARATOR    '/'
#define DEVICE_SEPARATOR '/'
#endif
#endif
@#
  if(0==set_path(include_path,getenv("CWEBINPUTS"))) {
    include_depth--; goto restart; /* internal error */
  }
  path_prefix = include_path;
  while(path_prefix) {
    for(kk=temp_file_name, p=path_prefix, l=0;
      p && *p && *p!=PATH_SEPARATOR;
      *kk++ = *p++, l++);
    if(path_prefix && *path_prefix && *path_prefix!=PATH_SEPARATOR &&
      *--p!=DEVICE_SEPARATOR && *p!=DIR_SEPARATOR) {
      *kk++ = DIR_SEPARATOR; l++;
    }
    if(k+l+2>=cur_file_name_end) too_long(); /* emergency break */
    strcpy(kk,cur_file_name);
    if(cur_file = fopen(temp_file_name,"r")) {
      cur_line=0; goto restart; /* success */
    }
    if(next_path_prefix = strchr(path_prefix,PATH_SEPARATOR))
      path_prefix = next_path_prefix+1;
    else break; /* no more paths to search; no file found */
  }
@z
------------------------------------------------------------------------------
Another `void' function, i.e., a procedure.
@x l.450
void
check_complete(){
@y
void check_complete(void) {
@z
------------------------------------------------------------------------------
The third argument of `strncpy' should be of type `size_t' not `long'.
@x l.453
    strncpy(buffer,change_buffer,change_limit-change_buffer+1);
@y
    strncpy(buffer,change_buffer,(size_t)(change_limit-change_buffer+1));
@z
------------------------------------------------------------------------------
Another `void' function, i.e., a procedure.
@x l.490
@<Predecl...@>=
void  err_print();

@
@<Functions...@>=
void
err_print(s) /* prints `\..' and location of error message */
char *s;
@y
@<Predecl...@>=
void  err_print(char *);

@
@<Functions...@>=
void err_print(char *s) /* prints `\..' and location of error message */
@z
------------------------------------------------------------------------------
On the AMIGA it is very convenient to know a little bit more about the
reasons why a program failed.  There are four levels of return for this
purpose.  Let CWeb be so kind to use them, so scripts can be made better.
@x l.540
@ Some implementations may wish to pass the |history| value to the
operating system so that it can be used to govern whether or not other
programs are started. Here, for instance, we pass the operating system
a status of 0 if and only if only harmless messages were printed.
@^system dependencies@>

@<Func...@>=
wrap_up() {
  @<Print the job |history|@>;
  if (history > harmless_message) return(1);
  else return(0);
}
@y
@ On multi-tasking systems like the Amiga it is very convenient to know
a little bit more about the reasons why a program failed.  The four levels
of return indicated by the |history| value are very suitable for this
purpose.  Here, for instance, we pass the operating system a status of~0
if and only if the run was a complete success.  Any warning or error
message will result in a higher return value, so ARexx scripts can be
made sensitive to these conditions.
@^system dependencies@>

@d RETURN_OK     0 /* No problems, success */
@d RETURN_WARN   5 /* A warning only */
@d RETURN_ERROR 10 /* Something wrong */
@d RETURN_FAIL  20 /* Complete or severe failure */

@<Func...@>=
#ifndef __TURBOC__
int wrap_up(void) {
  @<Print the job |history|@>;
  switch(history) {
  case harmless_message: return(RETURN_WARN); break;
  case error_message: return(RETURN_ERROR); break;
  case fatal_message: return(RETURN_FAIL); break;
  default: return(RETURN_OK);
    }
}
#else
int wrap_up(void) {
  int return_val;

  @<Print the job |history|@>;
  switch(history) {
  case harmless_message: return_val=RETURN_WARN; break;
  case error_message: return_val=RETURN_ERROR; break;
  case fatal_message: return_val=RETURN_FAIL; break;
  default: return_val=RETURN_OK;
    }
  return(return_val);
}
#endif
@z
------------------------------------------------------------------------------
@x l.569
the names of those files. Most of the 128 flags are undefined but available
@y
the names of those files. Most of the 256 flags are undefined but available
@z
------------------------------------------------------------------------------
@x l.579
boolean flags[128]; /* an option for each 7-bit code */
@y
boolean flags[256]; /* an option for each 8-bit code */
@z
------------------------------------------------------------------------------
@x l.593
An omitted change file argument means that |'/dev/null'| should be used,
@y
An omitted change file argument means that |'/dev/null'| or---on {\mc
MS-DOS} systems---|'nul'| or---on {\mc AMIGA} systems---|'NIL:'|
should be used,
@z
------------------------------------------------------------------------------
Another `void' function, i.e., a procedure.
@x l.599
@<Pred...@>=
void scan_args();

@
@<Function...@>=
void
scan_args()
@y
@<Pred...@>=
void scan_args(void);

@
@<Function...@>=
void scan_args(void)
@z
------------------------------------------------------------------------------
@x l.630
  if (!found_change) strcpy(change_file_name,"/dev/null");
@y
#if defined( __TURBOC__ )
  if (!found_change) strcpy(change_file_name,"nul");
#elif defined( _AMIGA )
  if (!found_change) strcpy(change_file_name,"NIL:");
#else
  if (!found_change) strcpy(change_file_name,"/dev/null");
#endif
@z
------------------------------------------------------------------------------
@x l.612
@* Index.
@y
@* Path searching.  By default, \.{CTANGLE} and \.{CWEAVE} are looking
for include files along the path |CWEBINPUTS|.  By setting the environment
variable of the same name to a different search path that suits your
personal needs, you may override the default on startup.  The following
procdure copies the value of the environment variable (if any) to the
variable |include_path| used for path searching.

@<Functions@>=
static boolean set_path(char *ptr,char *override)
{
  if(override) {
    if(strlen(override) >= max_path_length) {
      err_print("! Include path too long"); return(0);
@.Include path too long@>
    }
    else strcpy(ptr, override);
  }
  return(1);
}

@ The path search algorithm defined in section |@<Try to open...@>|
needs a few extra variables.  The search path given in the environment
variable |CWEBINPUTS| must not be longer than |max_path_length|.  If no
string is given in this variable, the internal default |CWEBINPUTS| is
used instead, which holds some sensible paths.

@d max_path_length 4095

@<Definitions...@>=
char include_path[max_path_length+1]=CWEBINPUTS;@/
char *p, *path_prefix, *next_path_prefix;@/

@ To satisfy all the {\mc ANSI} compilers out there, here are the
prototypes of all internal functions.

@<Predecl...@>=
int get_line(void);@/
int input_ln(FILE *fp);@/
int main(int argc,char **argv);
int wrap_up(void);@/
void check_change(void);@/
void check_complete(void);@/
void err_print(char *s);@/
void prime_the_change_buffer(void);@/
void put_line(void);@/
void reset_input(void);@/
void scan_args(void);@/
static boolean set_path(char *ptr,char *override);@/

@ Version information.  The {\mc AMIGA} operating system provides the
`version' command and good programs answer with some informations about
their creation date and their current version.

@<Defi...@>=
#ifdef _AMIGA
const unsigned char *Version = "$VER: WMerge 3.1 [p9c] "__AMIGADATE__;
#endif

@* Index.
@z
------------------------------------------------------------------------------
