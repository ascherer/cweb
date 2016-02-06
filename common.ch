								-*-Web-*-
This file, COMMON.CH, is part of CWEB.
It is a changefile for COMMON.W, Version 3.1.

Authors and Contributors:
(H2B) Hans-Hermann Bode, Universität Osnabrück,
  (hhbode@@dosuni1.rz.uni-osnabrueck.de or HHBODE@@DOSUNI1.BITNET).

(KG) Klaus Guntermann, TH Darmstadt,
  (guntermann@@iti.informatik.th-darmstadt.de).

(AS) Andreas Scherer,
  Abt-Wolf-Straße 17, 96215 Lichtenfels, Germany.

(CS) Carsten Steger, Universität München,
  carsten.steger@@informatik.tu-muenchen.de

(TW) Tomas Willis
  tomas@@cae.wisc.edu

Caveat utilitor:  Some of the source code introduced by this change file is
made conditional to the use of specific compilers on specific systems.
This applies to places marked with `#ifdef __TURBOC__' and `#ifdef _AMIGA'.

This program is distributed WITHOUT ANY WARRANTY, express or implied.

The following copyright notice extends to this changefile only, not to
the masterfile COMMON.W.

Copyright (C) 1993,1994 Andreas Scherer
Copyright (C) 1991,1993 Carsten Steger
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
a1/t1	10 Oct 1991	H2B	First attempt for COMMON.W 2.0.
p2	13 Feb 1992	H2B	Updated for COMMON.W 2.1, ANSI and Turbo
				changefiles merged together.
p3	16 Apr 1992	H2B	Updated for COMMON.W 2.2, change option for
				|@@i| completed.
p4	22 Jun 1992	H2B	Updated for COMMON.W 2.4, getting INCLUDEDIR
				from environment variable CWEBINCLUDE.
p5	19 Jul 1992	H2B	string.h included, usage message extended.
p5a	24 Jul 1992	KG	adaptions for other ANSI C compiler
p5b	28 Jul 1992	H2B	Remaining headers converted to ANSI style.
p5c	30 Jul 1992	KG	removed comments used after #endif
p6	06 Sep 1992	H2B	Updated for COMMON.W 2.7.
p6a     15 Mar 1993     AS      adaptions for SAS/C 6.0 compiler
p6b     28 Jul 1993     AS      path delimiters are `/' or `:' for AMIGA
	31 Aug 1993	AS	return codes extended to AMIGA values
p6c	04 Sep 1993	AS	path searching with CWEBINCLUDE
p6d	09 Oct 1993	AS	Updated for COMMON.W 2.8. (This was p7 for me)
p7	06 Nov 1992	H2B	Converted to master change file, updated for
				common.w 2.8. [Not released.]
p7.5	29 Nov 1992	H2B	Updated for COMMON.W 2.9beta. [Not released.]
p8	04 Dec 1992	H2B	Updated for COMMON.W 2.9++ (stuff went into
				the source file). [Not released.]
p8a	10 Mar 1993	H2B	Restructured for public release.
				[Not released.]
p8b	15 Apr 1993	H2B	Updated for COMMON.W 3.0beta. [Not released.]
p8c	21 Jun 1993	H2B	Updated for final COMMON.W 3.0.
p8d	26 Oct 1993	AS	Incorporated with AMIGA version 2.8 [p7] and
				updated to version 3.0.
p8e	04 Nov 1993	AS	Minor bugs fixed for UNIX and GNU-C.
p9	18 Nov 1993	AS	Updated for COMMON.W 3.1
p9a	30 Nov 1993	AS	Minor changes and corrections.
p9b	06 Dec 1993	AS	Multilinguality implemented.
	07 Dec 1993	AS	Fixed an obvious portability problem.
p9c	18 Jan 1994	AS	Version information included.
	25 Mar 1994	AS	Special `wrap_up' for Borland C.
p9d	13 May 1994	AS	Dynamic memory allocation.
	24 Jun 1994	AS	ARexx support for error-handling
	02 Jul 1994	AS	Portability version.
------------------------------------------------------------------------------
@x l.1
% This file is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 3.1 --- November 1993

% Copyright (C) 1987,1990,1993 Silvio Levy and Donald E. Knuth
@y
% This file, common.w, is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.4 --- Don Knuth, June 1992
% Version 2.4 [p5] --- Hans-Hermann Bode, July 1992
% Version 2.4 [p5a] --- Klaus Guntermann, July 1992
% Version 2.4 [p5b] --- Hans-Hermann Bode, July 1992
% Version 2.4 [p5c] --- Klaus Guntermann, July 1992
% Version 2.7 [p6] --- Hans-Hermann Bode, September 1992
% Version 2.7 [p6a] --- Andreas Scherer, March 1993
% Version 2.7 [p6b] --- Andreas Scherer, August 1993
% Version 2.7 [p6c] --- Andreas Scherer, September 1993
% Version 2.8 --- Don Knuth, June 1992
% Version 2.8 [p7] --- Andreas Scherer, October 1993
% Version 3.0 --- Don Knuth, June 1993
% Version 3.0 [p8c] --- Hans-Hermann Bode, June 1993
% Version 3.0 [p8d] --- Andreas Scherer, October 1993
% Version 3.0 [p8e] --- Andreas Scherer, November 1993
% Version 3.1 --- Don Knuth, November 1993
% Version 3.1 [p9] --- Andreas Scherer, November 1993
% Version 3.1 [p9a] --- Andreas Scherer, November 1993
% Version 3.1 [p9b] --- Andreas Scherer, December 1993
% Version 3.1 [p9c] --- Andreas Scherer, January 1994
% Version 3.1 [p9d] --- Andreas Scherer, July 1994

% Copyright (C) 1987,1990,1993 Silvio Levy and Donald E. Knuth
% Copyright (C) 1991-1993 Hans-Hermann Bode
% Copyright (C) 1991,1993 Carsten Steger
% Copyright (C) 1993,1994 Andreas Scherer
@z
------------------------------------------------------------------------------
@x l.20
\def\title{Common code for CTANGLE and CWEAVE (Version 3.1)}
@y
\def\title{Common code for CTANGLE and CWEAVE (Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.25
  \centerline{(Version 3.1)}
@y
  \centerline{(Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.29
Copyright \copyright\ 1987, 1990, 1993 Silvio Levy and Donald E. Knuth
@y
Copyright \copyright\ 1987, 1990, 1993 Silvio Levy and Donald E. Knuth
\smallskip\noindent
Copyright \copyright\ 1991--1993 Hans-Hermann Bode
\smallskip\noindent
Copyright \copyright\ 1991, 1993 Carsten Steger
\smallskip\noindent
Copyright \copyright\ 1993, 1994 Andreas Scherer
@z
------------------------------------------------------------------------------
Activate this, if only the changed modules should be printed.
x l.43
\let\maybe=\iftrue
y
\let\maybe=\iffalse
z
------------------------------------------------------------------------------
PORTABILITY
@x l.58
@<Include files@>@/
@y
@<Include files@>@/
@<Macro definitions@>@/
@z
------------------------------------------------------------------------------
ANSI, TRANSLATION
@x l.89
void
common_init()
{
  @<Initialize pointers@>;
  @<Set the default options common to \.{CTANGLE} and \.{CWEAVE}@>;
  @<Scan arguments and open output files@>;
}
@y
void common_init(void)
{
  @<Initialize pointers@>;
  @<Use catalog translations@>;
  @<Set the default options common to \.{CTANGLE} and \.{CWEAVE}@>;
  @<Scan arguments and open output files@>;
}
@z
------------------------------------------------------------------------------
@x l.108
character set can type things like \.{\char'32} and \.{char'4} instead
@y
character set can type things like \.{\char'32} and \.{\char'4} instead
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.158
char buffer[long_buf_size]; /* where each line of input goes */
char *buffer_end=buffer+buf_size-2; /* end of |buffer| */
char *limit=buffer; /* points to the last character in the buffer */
char *loc=buffer; /* points to the next character to be read from the buffer */
@y
char *buffer; /* where each line of input goes */
char *buffer_end; /* end of |buffer| */
char *limit; /* points to the last character in the buffer */
char *loc; /* points to the next character to be read from the buffer */
@z
------------------------------------------------------------------------------
ANSI
@x l.171
int input_ln(fp) /* copies a line into |buffer| or returns 0 */
FILE *fp; /* what file to read from */
@y
static int input_ln(FILE *fp) /* copies a line into |buffer| or returns 0 */
/* |fp|: what file to read from */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.182
      ungetc(c,fp); loc=buffer; err_print("! Input line too long");
@y
      ungetc(c,fp); loc=buffer; err_print(get_string(MSG_ERROR_CO9));
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.205
@d max_file_name_length 60
@y
@d max_file_name_length 256
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.214
FILE *file[max_include_depth]; /* stack of non-change files */
FILE *change_file; /* change file */
char file_name[max_include_depth][max_file_name_length];
  /* stack of non-change file names */
char change_file_name[max_file_name_length]; /* name of change file */
char alt_web_file_name[max_file_name_length]; /* alternate name to try */
int line[max_include_depth]; /* number of current line in the stacked files */
@y
FILE **file; /* stack of non-change files */
FILE *change_file; /* change file */
char **file_name; /* stack of non-change file names */
char *change_file_name; /* name of change file */
char *alt_web_file_name; /* alternate name to try */
int *line; /* number of current line in the stacked files */
@z
------------------------------------------------------------------------------
ANSI
@x l.235
@d lines_dont_match (change_limit-change_buffer != limit-buffer ||
  strncmp(buffer, change_buffer, limit-buffer))
@y
@d lines_dont_match (change_limit-change_buffer != limit-buffer || @|
  strncmp(buffer, change_buffer, (size_t)(limit-buffer)))
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.239
char change_buffer[buf_size]; /* next line of |change_file| */
@y
char *change_buffer; /* next line of |change_file| */
@z
------------------------------------------------------------------------------
ANSI
@x l.250
void
prime_the_change_buffer()
@y
static void prime_the_change_buffer(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.273
    err_print("! Missing @@x in change file");
@y
    err_print(get_string(MSG_ERROR_CO13));
@z
------------------------------------------------------------------------------
TRANLSATION
@x l.284
    err_print("! Change file ended after @@x");
@y
    err_print(get_string(MSG_ERROR_CO14));
@z
------------------------------------------------------------------------------
ANSI
@x l.292
  change_limit=change_buffer-buffer+limit;
  strncpy(change_buffer,buffer,limit-buffer+1);
@y
  change_limit=change_buffer+(ptrdiff_t)(limit-buffer);
  strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
@z
------------------------------------------------------------------------------
ANSI
@x l.319
void
check_change() /* switches to |change_file| if the buffers match */
@y
static void check_change(void) /* switches to |change_file| if the buffers match */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.332
      err_print("! Change file ended before @@y");
@y
      err_print(get_string(MSG_ERROR_CO16_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.346
        err_print("! CWEB file ended during a change");
@y
        err_print(get_string(MSG_ERROR_CO16_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.358
  loc=buffer+2; err_print("! Where is the matching @@y?");
@y
  loc=buffer+2; err_print(get_string(MSG_ERROR_CO17_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.365
    err_print("of the preceding lines failed to match");
@y
    err_print(get_string(MSG_ERROR_CO17_2));
@z
------------------------------------------------------------------------------
ANSI
@x l.377
void
reset_input()
@y
void reset_input(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.395
       fatal("! Cannot open input file ", web_file_name);
@y
       fatal(get_string(MSG_FATAL_CO19_1), web_file_name);
@z
------------------------------------------------------------------------------
PORTABILITY, TRANSLATION
Right after the web file was opened we set up communication with the AREXX
port of the SAS/C++ 6.x message browser.  If `scmsg' is not yet running we
start it in `rexxonly' mode (no window will appear) and initialize the
compilation run with the (full) name of the web file.
@x l.400
if ((change_file=fopen(change_file_name,"r"))==NULL)
       fatal("! Cannot open change file ", change_file_name);
@y
@<Set up the {\mc AREXX} communication@>@;
if ((change_file=fopen(change_file_name,"r"))==NULL)
       fatal(get_string(MSG_FATAL_CO19_2), change_file_name);
@z
------------------------------------------------------------------------------
ANSI
@x l.417
typedef unsigned short sixteen_bits;
@y
typedef unsigned char eight_bits;
typedef unsigned short sixteen_bits;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.419
boolean changed_section[max_sections]; /* is the section changed? */
@y
boolean *changed_section; /* is the section changed? */
@z
------------------------------------------------------------------------------
ANSI
@x l.425
int get_line() /* inputs the next line */
@y
int get_line(void) /* inputs the next line */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.439
      err_print("! Include file name not given");
@y
      err_print(get_string(MSG_ERROR_CO21_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.444
      err_print("! Too many nested includes");
@y
      err_print(get_string(MSG_ERROR_CO21_2));
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES, TRANSLATION
We provide a multiple search path algorithm much like the C preprocessor.
@x l.454
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

@d too_long() {include_depth--;
        err_print("! Include file name too long"); goto restart;}

@<Include...@>=
#include <stdlib.h> /* declaration of |getenv| and |exit| */
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
character.  For other systems than the {\mc AMIGA} different settings may
be needed.
@^system dependencies@>

@d too_long() {include_depth--;
        err_print(get_string(MSG_ERROR_CO22)); goto restart;}

@<Include...@>=
#include <stdlib.h> /* declaration of |getenv| and |exit| */
#include <stddef.h> /* type definition of |ptrdiff_t| */
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
@z
------------------------------------------------------------------------------
PORTABILITY
CWEB will perform a path search for `@i'nclude files along the environment
variable CWEBINPUTS in case the given file can not be opened in the current
directory or in the absolute path.  The single paths are delimited by
PATH_SEPARATORs.
@x l.485
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
      cur_line=0; print_where=1;
      goto restart; /* success */
    }
  }
@y
  if(0==set_path(include_path,getenv("CWEBINPUTS"))) {
    include_depth--; goto restart; /* internal error */
  }
  path_prefix = include_path;
  while(path_prefix) {
    for(kk=temp_file_name, p=path_prefix, l=0;
      p && *p && *p!=PATH_SEPARATOR;
      *kk++ = *p++, l++);
    if(path_prefix && *path_prefix && *path_prefix!=PATH_SEPARATOR && @|
      *--p!=DEVICE_SEPARATOR && *p!=DIR_SEPARATOR) {
      *kk++ = DIR_SEPARATOR; l++;
    }
    if(k+l+2>=cur_file_name_end) too_long(); /* emergency break */
    strcpy(kk,cur_file_name);
    if(cur_file = fopen(temp_file_name,"r")) {
      cur_line=0; print_where=1; goto restart; /* success */
    }
    if(next_path_prefix = strchr(path_prefix,PATH_SEPARATOR))
      path_prefix = next_path_prefix+1;
    else break; /* no more paths to search; no file found */
  }
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.509
  include_depth--; err_print("! Cannot open include file"); goto restart;
@y
  include_depth--; err_print(get_string(MSG_ERROR_CO23)); goto restart;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.532
    err_print("! Change file ended without @@z");
@y
    err_print(get_string(MSG_ERROR_CO25_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.548
        err_print("! Where is the matching @@z?");
@y
        err_print(get_string(MSG_ERROR_CO25_2));
@z
------------------------------------------------------------------------------
ANSI
@x l.562
void
check_complete(){
  if (change_limit!=change_buffer) { /* |changing| is 0 */
    strncpy(buffer,change_buffer,change_limit-change_buffer+1);
    limit=buffer+(int)(change_limit-change_buffer);
@y
void check_complete(void) {
  if (change_limit!=change_buffer) { /* |changing| is 0 */
    strncpy(buffer,change_buffer,(size_t)(change_limit-change_buffer+1));
    limit=buffer+(ptrdiff_t)(change_limit-change_buffer);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.568
    err_print("! Change file entry did not match");
@y
    err_print(get_string(MSG_ERROR_CO26));
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.588
  char *byte_start; /* beginning of the name in |byte_mem| */
@y
  char HUGE *byte_start; /* beginning of the name in |byte_mem| */
@z
------------------------------------------------------------------------------
PORTABILITY, MEMORY ALLOCATION
@x l.591
typedef name_info *name_pointer; /* pointer into array of |name_info|s */
char byte_mem[max_bytes]; /* characters of names */
char *byte_mem_end = byte_mem+max_bytes-1; /* end of |byte_mem| */
name_info name_dir[max_names]; /* information about names */
name_pointer name_dir_end = name_dir+max_names-1; /* end of |name_dir| */
@y
typedef name_info HUGE *name_pointer; /* pointer into array of |name_info|s */
char HUGE *byte_mem; /* characters of names */
char HUGE *byte_mem_end; /* end of |byte_mem| */
name_info HUGE *name_dir; /* information about names */
name_pointer name_dir_end; /* end of |name_dir| */
@z
------------------------------------------------------------------------------
ANSI
@x l.601
@d length(c) (c+1)->byte_start-(c)->byte_start /* the length of a name */
@y
@d length(c) (size_t)((c+1)->byte_start-(c)->byte_start) /* the length of a name */
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.611
char *byte_ptr; /* first unused position in |byte_mem| */
@y
char HUGE *byte_ptr; /* first unused position in |byte_mem| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, PORTABILITY, SYSTEM DEPENDENCIES, TRANSLATION
@x l.613
@ @<Init...@>=
name_dir->byte_start=byte_ptr=byte_mem; /* position zero in both arrays */
@y
@ @f type int /* Aus \.{type} wird der Pseudotyp \&{type} */
@#
@d alloc_object(object,size,@!type)
   if(!(object = (type *)calloc(size,sizeof(type))))
      fatal("",get_string(MSG_FATAL_CO85));

@<Init...@>=
alloc_object(buffer,long_buf_size,char);
buffer_end = buffer + buf_size - 2;
limit = loc = buffer;
alloc_object(file,max_include_depth,FILE *);
alloc_object(file_name,max_include_depth,char *);
for(phase=0; phase<max_include_depth; phase++)
  alloc_object(file_name[phase],max_file_name_length,char);
alloc_object(change_file_name,max_file_name_length,char);
alloc_object(alt_web_file_name,max_file_name_length,char);
alloc_object(line,max_include_depth,int);
alloc_object(change_buffer,buf_size,char);
alloc_object(changed_section,max_sections,boolean);
#ifdef __TURBOC__
byte_mem=allocsafe(max_bytes,sizeof(*byte_mem));
name_dir=allocsafe(max_names,sizeof(*name_dir));
#else
alloc_object(byte_mem,max_bytes,char);
alloc_object(name_dir,max_names,name_info);
#endif
byte_mem_end = byte_mem + max_bytes - 1;
name_dir_end = name_dir + max_names - 1;
name_dir->byte_start=byte_ptr=byte_mem; /* position zero in both arrays */
@^system dependencies@>
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.624
struct name_info *link;
@y
struct name_info HUGE *link;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.638
name_pointer hash[hash_size]; /* heads of hash lists */
hash_pointer hash_end = hash+hash_size-1; /* end of |hash| */
@y
name_pointer *hash; /* heads of hash lists */
hash_pointer hash_end; /* end of |hash| */
@z
------------------------------------------------------------------------------
ANSI
@x l.642
@ @<Predec...@>=
extern int names_match();
@y
@ @<Predec...@>=
extern int names_match(name_pointer,char *,int,eight_bits);@/
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.647
@<Init...@>=
for (h=hash; h<=hash_end; *h++=NULL) ;
@y
@<Init...@>=
alloc_object(hash,hash_size,name_pointer);
hash_end = hash + hash_size - 1;
for (h=hash; h<=hash_end; *h++=NULL) ;
alloc_object(C_file_name,max_file_name_length,char);
alloc_object(tex_file_name,max_file_name_length,char);
alloc_object(idx_file_name,max_file_name_length,char);
alloc_object(scn_file_name,max_file_name_length,char);
@z
------------------------------------------------------------------------------
ANSI
@x l.653
name_pointer
id_lookup(first,last,t) /* looks up a string in the identifier table */
char *first; /* first character of string */
char *last; /* last character of string plus one */
char t; /* the |ilk|; used by \.{CWEAVE} only */
@y
name_pointer id_lookup(char *first,char *last,char t)
/* looks up a string in the identifier table */
/* |first|: first character of string */
/* |last|:  last character of string plus one */
/* |t|:     the |ilk|; used by \.{CWEAVE} only */
@z
------------------------------------------------------------------------------
ANSI
@x l.664
  l=last-first; /* compute the length */
@y
  l=(int)(last-first); /* compute the length */
@z
------------------------------------------------------------------------------
ANSI
@x l.695
@<Pred...@>=
void init_p();
@y
@<Pred...@>=
extern void init_p(name_pointer,eight_bits);@/
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.699
  if (byte_ptr+l>byte_mem_end) overflow("byte memory");
  if (name_ptr>=name_dir_end) overflow("name");
@y
  if (byte_ptr+l>byte_mem_end) overflow(get_string(MSG_OVERFLOW_CO39_1));
  if (name_ptr>=name_dir_end) overflow(get_string(MSG_OVERFLOW_CO39_2));
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.724
  struct name_info *Rlink; /* right link in binary search tree for section
@y
  struct name_info HUGE *Rlink; /* right link in binary search tree for section
@z
------------------------------------------------------------------------------
ANSI
@x l.757
void
print_section_name(p)
name_pointer p;
@y
void print_section_name(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.761
  char *ss, *s = first_chunk(p);
@y
  char HUGE *ss;
  char HUGE *s = first_chunk(p);
@z
------------------------------------------------------------------------------
ANSI
@x l.766
      term_write(s,ss-s); p=q->link; q=p;
    } else {
      term_write(s,ss+1-s); p=name_dir; q=NULL;
@y
      term_write(s,(size_t)(ss-s)); p=q->link; q=p;
    } else {
      term_write(s,(size_t)(ss+1-s)); p=name_dir; q=NULL;
@z
------------------------------------------------------------------------------
ANSI
@x l.776
void
sprint_section_name(dest,p)
  char*dest;
  name_pointer p;
@y
void sprint_section_name(char *dest,name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.781
  char *ss, *s = first_chunk(p);
@y
  char HUGE *ss;
  char HUGE *s = first_chunk(p);
@z
------------------------------------------------------------------------------
ANSI
@x l.790
    strncpy(dest,s,ss-s), dest+=ss-s;
@y
    strncpy(dest,s,(size_t)(ss-s)), dest+=ss-s;
@z
------------------------------------------------------------------------------
ANSI
@x l.797
void
print_prefix_name(p)
name_pointer p;
@y
void print_prefix_name(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.801
  char *s = first_chunk(p);
@y
  char HUGE *s = first_chunk(p);
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY
@x l.818
int web_strcmp(j,j_len,k,k_len) /* fuller comparison than |strcmp| */
  char *j, *k; /* beginning of first and second strings */
  int j_len, k_len; /* length of strings */
{
  char *j1=j+j_len, *k1=k+k_len;
@y
static int web_strcmp(char HUGE *j, int j_len, char HUGE *k, int k_len)
 /* fuller comparison than |strcmp| */
 /* |j|: beginning of first string */
 /* |k|: beginning of second string */
 /* |j_len|: length of first string */
 /* |k_len|: length of second string */
{
  char HUGE *j1=j+j_len;
  char HUGE *k1=k+k_len;
@z
------------------------------------------------------------------------------
ANSI
@x l.844
@<Prede...@>=
extern void init_node();
@y
@<Prede...@>=
extern void init_node(name_pointer);@/
@z
------------------------------------------------------------------------------
ANSI
@x l.848
name_pointer
add_section_name(par,c,first,last,ispref) /* install a new node in the tree */
name_pointer par; /* parent of new node */
int c; /* right or left? */
char *first; /* first character of section name */
char *last; /* last character of section name, plus one */
int ispref; /* are we adding a prefix or a full name? */
@y
name_pointer add_section_name(name_pointer par, int c,
  char *first, char *last, int ispref)
  /* install a new node in the tree */
  /* par: parent of new node */
  /* c: right or left? */
  /* first: first character of section name */
  /* last: last character of section name, plus one */
  /* ispref: are we adding a prefix or a full name? */
@z
------------------------------------------------------------------------------
ANSI, TRANSLATION
@x l.857
  char *s=first_chunk(p);
  int name_len=last-first+ispref; /* length of section name */
  if (s+name_len>byte_mem_end) overflow("byte memory");
  if (name_ptr+1>=name_dir_end) overflow("name");
@y
  char HUGE *s=first_chunk(p);
  int name_len=(int)(last-first)+ispref; /* length of section name */
  if (s+name_len>byte_mem_end) overflow(get_string(MSG_OVERFLOW_CO39_1));
  if (name_ptr+1>=name_dir_end) overflow(get_string(MSG_OVERFLOW_CO39_2));
@z
------------------------------------------------------------------------------
ANSI
@x l.877
void
extend_section_name(p,first,last,ispref)
name_pointer p; /* name to be extended */
char *first; /* beginning of extension text */
char *last; /* one beyond end of extension text */
int ispref; /* are we adding a prefix or a full name? */
@y
void extend_section_name(name_pointer p,char *first,char *last,int ispref)
  /* p: name to be extended */
  /* first: beginning of extension text */
  /* last: one beyond end of extension text */
  /* ispref: are we adding a prefix or a full name? */
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY, TRANSLATION
@x l.884
  char *s;
  name_pointer q=p+1;
  int name_len=last-first+ispref;
  if (name_ptr>=name_dir_end) overflow("name");
@y
  char HUGE *s;
  name_pointer q=p+1;
  int name_len=(int)(last-first)+ispref;
  if (name_ptr>=name_dir_end) overflow(get_string(MSG_OVERFLOW_CO39_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.892
  if (s+name_len>byte_mem_end) overflow("byte memory");
@y
  if (s+name_len>byte_mem_end) overflow(get_string(MSG_OVERFLOW_CO39_1));
@z
------------------------------------------------------------------------------
@x l.900
its doesn't match an existing one. The new name is the string
@y
it doesn't match an existing one. The new name is the string
@z
------------------------------------------------------------------------------
ANSI
@x l.905
name_pointer
section_lookup(first,last,ispref) /* find or install section name in tree */
char *first, *last; /* first and last characters of new name */
int ispref; /* is the new name a prefix or a full name? */
@y
name_pointer section_lookup(char *first,char *last,int ispref)
  /* find or install section name in tree */
  /* first, last: first and last characters of new name */
  /* ispref: is the new name a prefix or a full name? */
@z
------------------------------------------------------------------------------
ANSI
@x l.916
  int name_len=last-first+1;
@y
  int name_len=(int)(last-first)+1;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.937
      printf("\n! Ambiguous prefix: matches <");
@.Ambiguous prefix ... @>
      print_prefix_name(p);
      printf(">\n and <");
@y
      printf(get_string(MSG_ERROR_CO50_1));
@.Ambiguous prefix ... @>
      print_prefix_name(p);
      printf(get_string(MSG_ERROR_CO50_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.966
      printf("\n! New name is a prefix of <");
@y
      printf(get_string(MSG_ERROR_CO52_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.978
      printf("\n! New name extends <");
@y
      printf(get_string(MSG_ERROR_CO52_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.984
    printf("\n! Section name incompatible with <");
@.Section name incompatible...@>
    print_prefix_name(r);
    printf(">,\n which abbreviates <");
@y
    printf(get_string(MSG_ERROR_CO52_3));
@.Section name incompatible...@>
    print_prefix_name(r);
    printf(get_string(MSG_ERROR_CO52_4));
@z
------------------------------------------------------------------------------
ANSI
@x l.1009
@<Predec...@>=
int section_name_cmp();
@y
@<Predec...@>=
static int section_name_cmp(char **,int,name_pointer);@/
@z
------------------------------------------------------------------------------
ANSI
@x l.1013
int section_name_cmp(pfirst,len,r)
char **pfirst; /* pointer to beginning of comparison string */
int len; /* length of string */
name_pointer r; /* section name being compared */
@y
static int section_name_cmp(char **pfirst,int len,name_pointer r)
  /*pfirst: pointer to beginning of comparison string */
  /* len: length of string */
  /* r: section name being compared */
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.1020
  char *ss, *s=first_chunk(r);
@y
  char HUGE *ss;
  char HUGE *s=first_chunk(r);
@z
------------------------------------------------------------------------------
ANSI
@x l.1030
          *pfirst=first+(ss-s);
@y
          *pfirst=first+(ptrdiff_t)(ss-s);
@z
------------------------------------------------------------------------------
ANSI
@x l.1037
      if (q!=name_dir) {len -= ss-s; s=q->byte_start; r=q; continue;}
@y
      if (q!=name_dir) {len -= (int)(ss-s); s=q->byte_start; r=q; continue;}
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY
@x l.1052
|equiv_or_xref| as a pointer to a |char|.

@<More elements of |name...@>=
char *equiv_or_xref; /* info corresponding to names */
@y
|equiv_or_xref| as a pointer to |void|.

@<More elements of |name...@>=
void HUGE *equiv_or_xref; /* info corresponding to names */
@z
------------------------------------------------------------------------------
ANSI
@x l.1082
if the string begins with |"|"|.

@<Predecl...@>=
void  err_print();
@y
if the string begins with |"!"|.

@<Predecl...@>=
extern void err_print(char *);@/
@z
------------------------------------------------------------------------------
ANSI
@x l.1088
void
err_print(s) /* prints `\..' and location of error message */
char *s;
@y
void err_print(char *s) /* prints `\..' and location of error message */
@z
------------------------------------------------------------------------------
PORTABILITY, TRANSLATION
@x l.1109
{if (changing && include_depth==change_depth)
  printf(". (l. %d of change file)\n", change_line);
else if (include_depth==0) printf(". (l. %d)\n", cur_line);
  else printf(". (l. %d of include file %s)\n", cur_line, cur_file_name);
@y
{if (changing && include_depth==change_depth) {
  printf(get_string(MSG_ERROR_CO59_1), change_line);
  @<Report an error in the change file@>@;
  }
else if (include_depth==0) {
  printf(get_string(MSG_ERROR_CO59_2), cur_line);
  @<Report an error in the web file@>@;
  }
else {
  printf(get_string(MSG_ERROR_CO59_3), cur_line, cur_file_name);
  @<Report an error in an include file@>@;
  }

@<Put the error message in the browser@>@;
@z
------------------------------------------------------------------------------
ANSI
@x l.1132
@<Prede...@>=
int wrap_up();
extern void print_stats();
@y
@<Prede...@>=
extern int wrap_up(void);@/
extern void print_stats(void);@/
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES, TRANSLATION
@x l.1136
@ Some implementations may wish to pass the |history| value to the
operating system so that it can be used to govern whether or not other
programs are started. Here, for instance, we pass the operating system
a status of 0 if and only if only harmless messages were printed.
@^system dependencies@>

@c
int wrap_up() {
  putchar('\n');
  if (show_stats)
    print_stats(); /* print statistics about memory usage */
  @<Print the job |history|@>;
  if (history > harmless_message) return(1);
  else return(0);
}
@y
@ On multi-tasking systems like the {\mc AMIGA} it is very convenient to know
a little bit more about the reasons why a program failed.  The four levels
of return indicated by the |history| value are very suitable for this
purpose.  Here, for instance, we pass the operating system a status of~0
if and only if the run was a complete success.  Any warning or error
message will result in a higher return value, so {\mc AREXX} scripts can be
made sensitive to these conditions.
@^system dependencies@>

@d RETURN_OK     0 /* No problems, success */
@d RETURN_WARN   5 /* A warning only */
@d RETURN_ERROR 10 /* Something wrong */
@d RETURN_FAIL  20 /* Complete or severe failure */

@c
#ifndef __TURBOC__
int wrap_up(void) {
  putchar('\n');
  if (show_stats) print_stats(); /* print statistics about memory usage */
  @<Print the job |history|@>;
  @<Close the language catalog@>;
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

  putchar('\n');
  if (show_stats) print_stats(); /* print statistics about memory usage */
  @<Print the job |history|@>;
  @<Close the language catalog@>;
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
TRANSLATION
@x l.1154
case spotless: if (show_happiness) printf("(No errors were found.)\n"); break;
case harmless_message:
  printf("(Did you see the warning message above?)\n"); break;
case error_message:
  printf("(Pardon me, but I think I spotted something wrong.)\n"); break;
case fatal_message: printf("(That was a fatal error, my friend.)\n");
@y
case spotless:
  if (show_happiness) printf(get_string(MSG_HAPPINESS_CO62)); break;
case harmless_message:
  printf(get_string(MSG_WARNING_CO62)); break;
case error_message:
  printf(get_string(MSG_ERROR_CO62)); break;
case fatal_message:
  printf(get_string(MSG_FATAL_CO62));
@z
------------------------------------------------------------------------------
ANSI
@x l.1165
@<Predec...@>=
void fatal(), overflow();
@y
@<Predec...@>=
extern void fatal(char *,char *);
extern void overflow(char *);
@z
------------------------------------------------------------------------------
ANSI
@x l.1171
@c void
fatal(s,t)
  char *s,*t;
@y
@c void fatal(char *s,char *t)
@z
------------------------------------------------------------------------------
ANSI
@x l.1182
@c void
overflow(t)
  char *t;
@y
@c void overflow(char *t)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1186
  printf("\n! Sorry, %s capacity exceeded",t); fatal("","");
@y
  printf(get_string(MSG_FATAL_CO65),t); fatal("","");
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1195
@d confusion(s) fatal("! This can't happen: ",s)
@y
@d confusion(s) fatal(get_string(MSG_FATAL_CO66),s)
@z
------------------------------------------------------------------------------
PORTABILITY
On the AMIGA there is a list of additional identifiers that have to be
formatted correctly.  We don't want to \.{@@i}nclude them for every AMIGA
program anew, so we provide an extension to CWEAVE.
For German programmers it is more convenient to write program documentations
in German instead of in English.  With the \.{+g} option German TeX macros
are included.
The original CWEAVE indents parameter declarations in old-style function
heads.  If you don't like this, you can typeset them flush left with \.{-i}.
The original CWEAVE puts extra white space after variable declarations and
before the first statement in a function block.  If you don't like this,
you can use the \.{-o} option.  This feature was already mentioned in the
original documentation, but it was not implemented.
This changes by Andreas Scherer are based on ideas by Carsten Steger
provided in his `CWeb 2.0' port from ><> 551 and his `CWeb 2.8' port
from the electronic nets.
@x l.1201
or flags to be turned on (beginning with |"+"|.
The following globals are for communicating the user's desires to the rest
of the program. The various file name variables contain strings with
the names of those files. Most of the 128 flags are undefined but available
for future extensions.

@d show_banner flags['b'] /* should the banner line be printed? */
@d show_progress flags['p'] /* should progress reports be printed? */
@d show_stats flags['s'] /* should statistics be printed at end of run? */
@d show_happiness flags['h'] /* should lack of errors be announced? */
@y
or flags to be turned on (beginning with |"+"|).
The following globals are for communicating the user's desires to the rest
of the program. The various file name variables contain strings with
the names of those files. Most of the 256 flags are undefined but available
for future extensions.

@d show_banner flags['b'] /* should the banner line be printed? */
@d show_progress flags['p'] /* should progress reports be printed? */
@d show_stats flags['s'] /* should statistics be printed at end of run? */
@d show_happiness flags['h'] /* should lack of errors be announced? */
@d use_amiga_keywords flags['a'] /* should {\mc AMIGA/SAS C} keywords be used? */
@d use_german_macros flags['g'] /* should the output be German? */
@d indent_param_decl flags['i'] /* should formal parameter declarations be indented? */
@d send_error_messages flags['m'] /* should {\mc AREXX} communication be used? */
@d order_decl_stmt flags['o'] /* should declarations and statements be separated? */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.1215
char C_file_name[max_file_name_length]; /* name of |C_file| */
char tex_file_name[max_file_name_length]; /* name of |tex_file| */
char idx_file_name[max_file_name_length]; /* name of |idx_file| */
char scn_file_name[max_file_name_length]; /* name of |scn_file| */
boolean flags[128]; /* an option for each 7-bit code */
@y
char *C_file_name; /* name of |C_file| */
char *tex_file_name; /* name of |tex_file| */
char *idx_file_name; /* name of |idx_file| */
char *scn_file_name; /* name of |scn_file| */
boolean flags[256]; /* an option for each 8-bit code */
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES
@x l.1225
@<Set the default options common to \.{CTANGLE} and \.{CWEAVE}@>=
show_banner=show_happiness=show_progress=1;
@y
@<Set the default options common to \.{CTANGLE} and \.{CWEAVE}@>=
show_banner=show_happiness=show_progress=1;
#ifdef _AMIGA
use_amiga_keywords=
#endif
use_german_macros=indent_param_decl=order_decl_stmt=1;
@^system dependencies@>
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.1237
An omitted change file argument means that |"/dev/null"| should be used,
when no changes are desired.
@y
An omitted change file argument means that |"/dev/null"| or---on {\mc
MS-DOS} systems---|"nul"| or---on {\mc AMIGA} systems---|"NIL:"| should be
used, when no changes are desired.
@z
------------------------------------------------------------------------------
ANSI
@x l.1243
@<Pred...@>=
void scan_args();
@y
@<Pred...@>=
static void scan_args(void);@/
@z
------------------------------------------------------------------------------
ANSI
@x l.1247
void
scan_args()
@y
static void scan_args(void)
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES
@x l.1261
      while (*s) {
        if (*s=='.') dot_pos=s++;
        else if (*s=='/') dot_pos=NULL,name_pos=++s;
        else s++;
      }
@y
      while (*s) {
        if (*s=='.') dot_pos=s++;
#ifdef _AMIGA
        else if ((*s==DIR_SEPARATOR) || (*s==DEVICE_SEPARATOR)) dot_pos=NULL,name_pos=++s;
#else
        else if (*s==DIR_SEPARATOR) dot_pos=NULL,name_pos=++s;
#endif
        else s++;
      }
@^system dependencies@>
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES
@x l.1274
  if (found_change<=0) strcpy(change_file_name,"/dev/null");
@y
#if defined( _AMIGA )
  if (found_change<=0) strcpy(change_file_name,"NIL:");
#else
#if defined( __TURBOC__ )
  if (found_change<=0) strcpy(change_file_name,"nul");
#else
  if (found_change<=0) strcpy(change_file_name,"/dev/null");
#endif
#endif
@^system dependencies@>
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1328
        fatal("! Output file name should end with .tex\n",*argv);
@y
        fatal(get_string(MSG_FATAL_CO73),*argv);
@z
------------------------------------------------------------------------------
SYSTEM DEPENDENCIES, TRANSLATION
When called with no arguments CTANGLE and CWEAVE provide a list of options.
@x l.1351
  fatal(
"! Usage: ctangle [options] webfile[.w] [{changefile[.ch]|-} [outfile[.c]]]\n"
   ,"");
@.Usage:@>
else fatal(
"! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\n"
   ,"");
@y
  fatal(get_string(MSG_FATAL_CO75_1),"");
@.Usage:@>
#ifdef _AMIGA
else fatal(get_string(MSG_FATAL_CO75_2),"");
#else
else fatal(get_string(MSG_FATAL_CO75_3),"");
#endif
@^system dependencies@>
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1360
@ @<Complain about arg...@>= fatal("! Filename too long\n", *argv);
@y
@ @<Complain about arg...@>= fatal(get_string(MSG_FATAL_CO76), *argv);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1377
    fatal("! Cannot open output file ", C_file_name);
@y
    fatal(get_string(MSG_FATAL_CO78), C_file_name);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1382
    fatal("! Cannot open output file ", tex_file_name);
@y
    fatal(get_string(MSG_FATAL_CO78), tex_file_name);
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY, SYSTEM DEPENDENCIES, TRANSLATION
The `standard' header files are.  Any compiler ignoring them is not.
@x l.1402
@ We predeclare several standard system functions here instead of including
their system header files, because the names of the header files are not as
standard as the names of the functions. (For example, some \CEE/ environments
have \.{<string.h>} where others have \.{<strings.h>}.)

@<Predecl...@>=
extern int strlen(); /* length of string */
extern int strcmp(); /* compare strings lexicographically */
extern char* strcpy(); /* copy one string to another */
extern int strncmp(); /* compare up to $n$ string characters */
extern char* strncpy(); /* copy up to $n$ string characters */

@** Index.
@y
@ For string handling we include the {\mc ANSI C} system header file instead
of predeclaring the standard system functions |strlen|, |strcmp|, |strcpy|,
|strncmp|, and |strncpy|.
@^system dependencies@>

@<Include...@>=
#include <string.h>

@** Path searching.  By default, \.{CTANGLE} and \.{CWEAVE} are looking
for include files along the path |CWEBINPUTS|.  By setting the environment
variable of the same name to a different search path that suits your
personal needs, you may override the default on startup.  The following
procedure copies the value of the environment variable (if any) to the
variable |include_path| used for path searching.

@c
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
needs a few extra variables.  If no string is given in this variable,
the internal default |CWEBINPUTS| is used instead, which holds some
sensible paths.
@^system dependencies@>

@d max_path_length 4095

@<Other...@>=
char *include_path;@/
char *p, *path_prefix, *next_path_prefix;@/

@ @<Init...@>=
alloc_object(include_path,max_path_length+1,char);
strcpy(include_path,CWEBINPUTS);

@** Memory allocation. Due to restrictions of most {\mc MS-DOS}-\CEE/ compilers,
large arrays will be allocated dynamically rather than statically. In the {\mc
TURBO}-\CEE/ implementation the |farcalloc| function provides a way to allocate
more than 64~KByte of data. The |allocsafe| function tries to carry out an
allocation of |nunits| blocks of size |unitsz| by calling |farcalloc| and takes
a safe method, when this fails: the program will be aborted.

To deal with such allocated data areas |huge| pointers will be used in this
implementation.

@f far int
@f huge int
@f HUGE int

@<Pred...@>=
#ifdef __TURBOC__
extern void far *allocsafe(unsigned long,unsigned long);
#endif
@^system dependencies@>

@ @c
#ifdef __TURBOC__
void far *allocsafe (unsigned long nunits,unsigned long unitsz)
{
  void far *p = farcalloc(nunits,unitsz);
  if (p==NULL) fatal("",get_string(MSG_FATAL_CO85));
@.Memory allocation failure@>
  return p;
}
#endif
@^system dependencies@>

@ @<Include...@>=
#ifdef __TURBOC__
#include <alloc.h> /* import |farcalloc| */
#include <io.h> /* import |write| */
#endif
@^system dependencies@>

@ @<Macro...@>=
#ifdef __TURBOC__
#define HUGE huge
#else
#define HUGE
#endif
@^system dependencies@>

@** Multilinguality.  The {\mc AMIGA} operating system (and maybe some
other operating systems as well), starting with version~2.1, is inherently
multilingual.  With the help of system catalogs, any decent program
interface can be made sensitive to the language the user wants to be
addressed with.  All terminal output strings were located and replaced by
references to an external array |AppStrings|.  The English defaults of
these strings can be overwritten by the entries of translated catalogs.
The following include file \.{cweb.h} contains a complete description of
all strings used in this extended \.{CWEB} system.
@^system dependencies@>

@<Include files@>=
#ifdef _AMIGA
#include <libraries/locale.h>
#include <proto/locale.h>
#include <proto/exec.h>
@#
struct Library *LocaleBase; /* pointer to the locale library */
struct Catalog *catalog; /* pointer to the external catalog */
int i; /* global counter for list of strings */
#else /* non-{\mc AMIGA} systems don't know about \.{<exec/types.h>} */
typedef long int LONG; /* excerpt from \.{<exec/types.h>} */
typedef char * STRPTR; /* ditto, but \UNIX/ says it's signed. */
#define EXEC_TYPES_H 1 /* don't include \.{<exec/types.h>} in \.{"cweb.h"} */
#endif
@#
#define STRINGARRAY 1 /* include the string array |AppStrings| for real */
#define get_string(n) AppStrings[n].as_Str /* reference string $n$ */
@#
#include "cweb.h"

@ Version~2.1 or higher of the {\mc AMIGA} operating system (represented as
internal version~38) will replace the complete set of terminal output strings
by an external translation in accordance to the system default language.
@^system dependencies@>

@<Use catalog translations@>=
#ifdef _AMIGA
  if(LocaleBase=OpenLibrary("locale.library",38L)) {
    if(catalog=OpenCatalog(NULL,"cweb.catalog",
      OC_BuiltInLanguage,"english",TAG_DONE)) {
      for(i=MSG_ERROR_CO9; i<=MSG_STATS_CW248_6; ++i)
        AppStrings[i].as_Str=GetCatalogStr(catalog,i,AppStrings[i].as_Str);
      }
    }
#endif

@ It is essential to close the pointer references to the language catalog
and to the system library before shutting down the program itself.
@^system dependencies@>

@<Close the language catalog@>=
#ifdef _AMIGA
  if(LocaleBase) {
    CloseCatalog(catalog);
    CloseLibrary(LocaleBase);
    }
#endif

@** AREXX communication.  In case of an error we want to have a common
interface used by \.{CWEB} and the \CEE/ compiler in the same way.  For
the {\mc AMIGA} this is \.{SCMSG}, the message browser of the {\mc SAS/C}
development system.  This program has an {\mc AREXX} port and can be
addressed by other applications like \.{CTANGLE} and \.{CWEAVE} with
the help of the routines described in this part.  (I admit to have
shamelessly borrowed code from the Pas\TEX/ implementation of
\.{dvips}~5.47 by Georg He{\ss}mann.)  To make use of this feature
it is necessary (besides having an {\mc AMIGA}) to include system
dependent header files.
@^system dependencies@>

@<Include files@>=
#ifdef _AMIGA
#include <exec/types.h>
#include <libraries/dos.h>
#include <clib/alib_protos.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>
#include <pragmas/exec_pragmas.h>
#include <pragmas/dos_pragmas.h>
@#
#include <string.h>
#include <dos.h>
@#
#include <rexx/rxslib.h>
#include <rexx/errors.h>
#endif

@ A list of declarations and variables is added.  Most of these are
globally defined because the initialization of the message port is done
outside these local routines.
@^system dependencies@>

@<Other...@>=
#ifdef _AMIGA
extern struct ExecBase *SysBase;
extern struct DOSBase *DOSBase;
@#
STRPTR          CreateArgstring(STRPTR, long);
void            DeleteArgstring(STRPTR);
struct RexxMsg  *CreateRexxMsg(struct MsgPort *, STRPTR, STRPTR);
void            DeleteRexxMsg(struct RexxMsg *);
@#
long result = 20;
char msg_string[BUFSIZ];
char pth_buffer[BUFSIZ];
char cur_buffer[BUFSIZ];
@#
struct RexxMsg *rm;
struct MsgPort *rp;
@#
@=#pragma libcall RexxSysBase CreateArgstring 7e 0802@>@;
@=#pragma libcall RexxSysBase DeleteArgstring 84 801@>@;
@=#pragma libcall RexxSysBase CreateRexxMsg   90 09803@>@;
@=#pragma libcall RexxSysBase DeleteRexxMsg   96 801@>@;
@#
#define MSGPORT  "SC_SCMSG"
#define PORTNAME "CWEBPORT"
#define RXEXTENS "rexx"
@#
struct RxsLib *RexxSysBase = NULL;
#endif

@ This function addresses the message browser of the {\mc SAS/C} system by
means of its {\mc AREXX} communication port.
@^system dependencies@>

@c
#ifdef _AMIGA
static int PutRexxMsg(struct MsgPort *mp, long action, STRPTR arg0,
  struct RexxMsg *arg1)
  {
  if ((rm = CreateRexxMsg(mp, RXEXTENS, mp->mp_Node.ln_Name)) != NULL) {
    rm->rm_Action  = action;
    rm->rm_Args[0] = arg0;
    rm->rm_Args[1] = (STRPTR)arg1;

    Forbid(); /* Disable multitasking. */
    if ((rp = FindPort(MSGPORT)) != NULL)
      PutMsg(rp, (struct Message *)rm);
    Permit(); /* Enable multitasking. */

    if (rp == NULL) /* Sorry, message browser not found. */
      DeleteRexxMsg(rm);
  }
  return(rm != NULL && rp != NULL);
}
#endif

@ This function is the ``interface'' between \.{CWEB} and {\mc AREXX}\null.
The first argument is a string containing a full line of text to be sent to
the browser.  The second argument returns the transmission result.
@^system dependencies@>

@c
#ifdef _AMIGA
int __stdargs call_rexx(char *str, long *result)
{
  char *arg;
  struct MsgPort *mp;
  struct RexxMsg *rm, *rm2;
  int ret = FALSE;
  int pend;

  if (!(RexxSysBase = (struct RxsLib *)OpenLibrary(RXSNAME, 0)))
    return(ret);

  Forbid(); /* Disable multitasking. */
  if (FindPort(PORTNAME) == NULL)
    mp = CreatePort(PORTNAME, 0);
  Permit(); /* Enable multitasking. */

  if (mp != NULL) {
    if ((arg = CreateArgstring(str, strlen(str))) != NULL) {
      if (PutRexxMsg(mp, RXCOMM | RXFF_STRING, arg, NULL)) {

        for (pend = 1; pend != 0; )
          if (WaitPort(mp) != NULL)
            while ((rm = (struct RexxMsg *)GetMsg(mp)) != NULL)
              if (rm->rm_Node.mn_Node.ln_Type == NT_REPLYMSG) {
                ret = TRUE;
                *result = rm->rm_Result1;
                if ((rm2 = (struct RexxMsg *)rm->rm_Args[1]) != NULL) {
                  rm2->rm_Result1 = rm->rm_Result1;
                  rm2->rm_Result2 = 0;
                  ReplyMsg((struct Message *)rm2);
                }
                DeleteRexxMsg(rm);
                pend--;
              }
              else {
                rm->rm_Result2 = 0;
                if (PutRexxMsg(mp, rm->rm_Action, rm->rm_Args[0], rm))
                  pend++;
                else {
                  rm->rm_Result1 = RC_FATAL;
                  ReplyMsg((struct Message *)rm);
                }
              }
      }
      DeleteArgstring(arg);
    }
    DeletePort(mp);
  }

  CloseLibrary((struct Library *)RexxSysBase);

  return(ret);
}
#endif

@ The prototypes for these two new functions are added to the common list.
@^system dependencies@>

@<Predecl...@>=
#ifdef _AMIGA
static int PutRexxMsg(struct MsgPort *,long,STRPTR,struct RexxMsg *);
int __stdargs call_rexx(char *,long *);
#endif

@ Before we can send any signal to the message browser we have to make sure
that the receiving port is active.  Possibly a call to \.{scmsg} will
suffice.  If it is not there, any attempt to send a message will fail.

You can control the behaviour of \.{scmsg} via the external environment
variable \.{SCMSGOPT} which may contain any legal command line options as
described in the documentation provided by {\mc SAS}~Institute.
The display window with the error messages will not appear if you supply
\.{scmsg} with its \.{rexxonly} option.  If you want to see every message
on your screen, replace this option with \.{hidden}.  The first error
message received by \.{scmsg} will open the output window.  The very first
message for the browser initializes its database for the current web file.
Any pending entries will be destroyed before new ones are added.
@^system dependencies@>

@<Set up the {\mc AREXX} communication@>=
#ifdef _AMIGA
if(send_error_messages) {
  Forbid(); /* Disable multitasking. */
  if ((rp = FindPort(MSGPORT)) != NULL); /* Check for browser port. */
  Permit(); /* Enable multitasking. */

  if(!rp) { /* Make sure, the browser is active. */
    strcpy(msg_string,"run <nil: >nil: scmsg ");
    strcat(msg_string,getenv("SCMSGOPT")); /* Add browser options. */
    system(msg_string);
    }

  if(GetCurrentDirName(cur_buffer,BUFSIZ) && @|
    AddPart(cur_buffer,web_file_name,BUFSIZ)) {
    sprintf(msg_string,"newbld \"%s\"",cur_buffer);
    call_rexx(msg_string,&result); /* Ignore the results. */
    }
  }
#endif

@ There are three types of \.{CWEB} errors reported to the message browser.
For completeness we give them the numbers~997 to~999.  The first one refers
to errors in the active change file.  If you click on the error line in the
browser window, your system editor will take you to the offending line in
the change file (given the communication between the browser and your
editor is properly set up).  There is a slight difficulty when entering
file names into the error message; the browser expects complete path names
and we have to add them more or less manually.
@^system dependencies@>

@<Report an error in the change file@>=
#ifdef _AMIGA
if(send_error_messages) {
  if(GetCurrentDirName(cur_buffer,BUFSIZ) && @|
    AddPart(cur_buffer,web_file_name,BUFSIZ) && @|
    GetCurrentDirName(pth_buffer,BUFSIZ) && @|
    AddPart(pth_buffer,change_file_name,BUFSIZ))
    sprintf(msg_string,"newmsg \"%s\" \"%s\" %d 0 \"\" 0 Error 997 %s",@|
      cur_buffer,pth_buffer,change_line,s);
  }
#endif

@ The next type of error occurs in the web file itself, so the current file
is the same as the offending file.  We have to create the full name only once.
@^system dependencies@>

@<Report an error in the web file@>=
#ifdef _AMIGA
if(send_error_messages) {
  if(GetCurrentDirName(cur_buffer,BUFSIZ) && @|
    AddPart(cur_buffer,cur_file_name,BUFSIZ))
    sprintf(msg_string,"newmsg \"%s\" \"%s\" %d 0 \"\" 0 Error 998 %s",@|
      cur_buffer,cur_buffer,cur_line,s);
  }
#endif

@ The error with the highest number is also the most subtle type.  It
occurs inside an include file, so we have to distinguish between the web
file and the offending file.
@^system dependencies@>

@<Report an error in an include file@>=
#ifdef _AMIGA
if(send_error_messages) {
  strcpy(msg_string,"\0");
  if(GetCurrentDirName(cur_buffer,BUFSIZ) && @|
    AddPart(cur_buffer,cur_file_name,BUFSIZ) && @|
    GetCurrentDirName(pth_buffer,BUFSIZ) && @|
    AddPart(pth_buffer,web_file_name,BUFSIZ))
    sprintf(msg_string,"newmsg \"%s\" \"%s\" %d 0 \"\" 0 Error 999 %s",@|
      pth_buffer,cur_buffer,cur_line,s);
  }
#endif

@ In the three sections above we simply created a string holding the full
entry line which is handed over to the message browser by calling our
|call_rexx| routine.  The boolean return value is ignored.
@^system dependencies@>

@<Put the error message in the browser@>=
#ifdef _AMIGA
if(send_error_messages && msg_string)
  call_rexx(msg_string,&result); /* Ignore the results. */
#endif

@** Function declarations. Here are declarations, conforming to {\mc ANSI~C},
of all functions in this code that appear in |"common.h"| and thus should
agree with \.{CTANGLE} and \.{CWEAVE}.

@<Predecl...@>=
int get_line(void);@/
name_pointer add_section_name(name_pointer,int,char *,char *,int);@/
name_pointer id_lookup(char *,char *,char);@/
name_pointer section_lookup(char *,char *,int);
void check_complete(void);@/
void common_init(void);@/
void extend_section_name(name_pointer,char *,char *,int);@/
void print_prefix_name(name_pointer);@/
void print_section_name(name_pointer);@/
void reset_input(void);@/
void sprint_section_name(char *,name_pointer);@/

@ The following functions are private to |"common.w"|.

@<Predecl...@>=
static boolean set_path(char *,char *);@/
static int input_ln(FILE *);@/
static int web_strcmp(char HUGE *,int,char HUGE *,int);@/
static void check_change(void);@/
static void prime_the_change_buffer(void);@/

@** Index.
@z
------------------------------------------------------------------------------
