								-*-Web-*-
This file, CWEAVE.CH, is part of CWEB.
It is a changefile for CWEAVE.W, Version 3.1.

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
the masterfile CWEAVE.W.

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
a1/t1	10 Oct 1991	H2B	First attempt for CWEAVE.W 2.1.
p2	13 Feb 1992	H2B	Updated for CWEAVE.W 2.4, ANSI and Turbo
				changefiles merged together, typesetting of
				certain ANSI and special constructions fixed.
p3	16 Apr 1992	H2B	Updated for CWEAVE.W 2.5.
p4	22 Jun 1992	H2B	Updated for CWEAVE.W 2.6, retaining hack for
				underlining of customized iddentifiers.
p5	21 Jul 1992	H2B	Extensions for C++ implemented.
p5a	24 Jul 1992	KG	adaptions for other ANSI C compiler
p5b	28 Jul 1992	H2B	Remaining headers converted to ANSI style.
p5c	30 Jul 1992	KG	removed comments used after #endif
p6	06 Sep 1992	H2B	Updated for CWEAVE.W 2.7, |dot_dot_dot| added,
				proper typesetting of formatted macro
				identifiers provided, bug in processing
				short comments fixed.
p6a     15 Mar 1993     AS      adaptions for SAS/C 6.0 and use of German
                                macro file gcwebmac.tex
p6b     28 Jul 1993     AS      new patch level due to minor changes
        01 Aug 1993     AS      missing `ptrdiff_t' datatype included
p6c	04 Sep 1993	AS	new patch level in accordance with Common
p6d	09 Oct 1993	AS	Updated for CWEAVE.W 2.8. (This was p7)
p7	13 Nov 1992	H2B	Converted to master change file, updated for
				CWEAVE.W 2.8. [Not released.]
p7.5	29 Nov 1992	H2B	Updated for CWEAVE.W 2.9beta. [Not released.]
p8	04 Dec 1992	H2B	Updated for CWEAVE.W 2.9++ (stuff went into
				the source file). [Not released.]
p8a	10 Mar 1993	H2B	Restructured for public release. [Not released.]
p8b	15 Apr 1993	H2B	Updated for CWEAVE.W 3.0beta. [Not released.]
p8c	21 Jun 1993	H2B	Updated for final CWEAVE.W 3.0.
p8d	25 Oct 1993	AS	Incorporated with AMIGA version 2.8 [p7] and
				updated to version 3.0.
p8e	04 Nov 1993	AS	Minor bug fixed for UNIX and GNU-C.
p9	18 Nov 1993	AS	Updated for CWEAVE.W 3.1.
p9a	30 Nov 1993	AS	Minor changes and corrections.
p9b	06 Dec 1993	AS	Multilinguality implemented.
p9c	18 Jan 1994	AS	Version information included.
	03 Mar 1994	AS	`fflush' added for `Writing the index'.
p9d	13 May 1994	AS	Dynamic memory allocation.
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
% This file, CWEAVE.W, is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.6 --- Don Knuth, June 1992
% Version 2.6 [p5] --- Hans-Hermann Bode, July 1992
% Version 2.6 [p5a] --- Klaus Guntermann, July 1992
% Version 2.6 [p5b] --- Hans-Hermann Bode, July 1992
% Version 2.6 [p5c] --- Klaus Guntermann, July 1992
% Version 2.7 --- Don Knuth, July 1992
% Version 2.7 [p6] --- Hans-Hermann Bode, September 1992
% Version 2.7 [p6a] --- Andreas Scherer, March 1993
% Version 2.7 [p6b] --- Andreas Scherer, July 1993
% Version 2.7 [p6c] --- Andreas Scherer, September 1993
% Version 2.8 --- Don Knuth, September 1992
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
@x l.30
\def\title{CWEAVE (Version 3.1)}
@y
\def\title{CWEAVE (Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.34
  \centerline{(Version 3.1)}
@y
  \centerline{(Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.38
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
x l.51
\let\maybe=\iftrue
y
\let\maybe=\iffalse
z
------------------------------------------------------------------------------
TRANSLATION
@x l.64
@d banner "This is CWEAVE (Version 3.1)\n"
@y
@d banner get_string(MSG_BANNER_CW1)
@z
------------------------------------------------------------------------------
ANSI
@x l.73
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
@y
@ For string handling we include the {\mc ANSI C} system header file instead
of predeclaring the standard system functions |strlen|, |strcmp|, |strcpy|,
|strncmp|, and |strncpy|.
@^system dependencies@>

@<Include files@>=
#include <string.h>
@z
------------------------------------------------------------------------------
ANSI
@x l.94
int main (ac, av)
int ac; /* argument count */
char **av; /* argument values */
@y
int main (int ac, char **av)
/* argument count and argument values */
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES
@x l.139
@i common.h
@y
@i comm-p.h
@^system dependencies@>
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.223
typedef struct xref_info {
  sixteen_bits num; /* section number plus zero or |def_flag| */
  struct xref_info *xlink; /* pointer to the previous cross-reference */
} xref_info;
typedef xref_info *xref_pointer;
@y
typedef struct xref_info {
  sixteen_bits num; /* section number plus zero or |def_flag| */
  struct xref_info HUGE *xlink; /* pointer to the previous cross-reference */
} xref_info;
typedef xref_info HUGE *xref_pointer;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.230
xref_info xmem[max_refs]; /* contains cross-reference information */
xref_pointer xmem_end = xmem+max_refs-1;
@y
xref_info HUGE *xmem; /* contains cross-reference information */
xref_pointer xmem_end;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, PORTABILITY, SYSTEM DEPENDENCIES
@x l.244
xref_ptr=xmem; name_dir->xref=(char*)xmem; xref_switch=0; section_xref_switch=0;
@y
if(!(section_text=(char *)calloc(longest_name+1,sizeof(char))))
  fatal("",get_string(MSG_FATAL_CO85));
section_text_end = section_text + longest_name;
#ifdef __TURBOC__
xmem=allocsafe(max_refs,sizeof(*xmem));
#else
alloc_object(xmem,max_refs,xref_info);
#endif
xmem_end = xmem + max_refs - 1;
xref_ptr=xmem; name_dir->xref=(void HUGE*)xmem;
xref_switch=0; section_xref_switch=0;
@^system dependencies@>
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.256
@d append_xref(c) if (xref_ptr==xmem_end) overflow("cross-reference");
@y
@d append_xref(c) if (xref_ptr==xmem_end) overflow(get_string(MSG_OVERFLOW_CW21));
@z
------------------------------------------------------------------------------
ANSI
@x l.262
@c
void
new_xref(p)
name_pointer p;
@y
@c static void new_xref(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.279
  append_xref(m); xref_ptr->xlink=q; p->xref=(char*)xref_ptr;
@y
  append_xref(m); xref_ptr->xlink=q; p->xref=(void HUGE*)xref_ptr;
@z
------------------------------------------------------------------------------
ANSI
@x l.293
@c
void
new_section_xref(p)
name_pointer p;
@y
@c static void new_section_xref(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.306
  if (r==xmem) p->xref=(char*)xref_ptr;
@y
  if (r==xmem) p->xref=(void HUGE*)xref_ptr;
@z
------------------------------------------------------------------------------
ANSI
@x l.313
@c
void
set_file_flag(p)
name_pointer p;
@y
@c static void set_file_flag(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.323
  p->xref = (char *)xref_ptr;
@y
  p->xref = (void HUGE*)xref_ptr;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, PORTABILITY
@x l.334
typedef token *token_pointer;
typedef token_pointer *text_pointer;
@y
typedef token HUGE *token_pointer;
typedef token_pointer HUGE *text_pointer;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, PORTABILITY
@x l.343
token tok_mem[max_toks]; /* tokens */
token_pointer tok_mem_end = tok_mem+max_toks-1; /* end of |tok_mem| */
token_pointer tok_start[max_texts]; /* directory into |tok_mem| */
token_pointer tok_ptr; /* first unused position in |tok_mem| */
text_pointer text_ptr; /* first unused position in |tok_start| */
text_pointer tok_start_end = tok_start+max_texts-1; /* end of |tok_start| */
@y
token HUGE *tok_mem; /* tokens */
token_pointer tok_mem_end; /* end of |tok_mem| */
token_pointer *tok_start; /* directory into |tok_mem| */
token_pointer tok_ptr; /* first unused position in |tok_mem| */
text_pointer text_ptr; /* first unused position in |tok_start| */
text_pointer tok_start_end; /* end of |tok_start| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, SYSTEM DEPENDENCIES
@x l.353
tok_ptr=tok_mem+1; text_ptr=tok_start+1; tok_start[0]=tok_mem+1;
@y
#ifdef __TURBOC__
tok_mem=allocsafe(max_toks,sizeof(*tok_mem));
#else
alloc_object(tok_mem,max_toks,token);
#endif
tok_mem_end = tok_mem + max_toks - 1;
if(!(tok_start=(token_pointer *)calloc(max_texts,sizeof(token_pointer))))
  fatal("",get_string(MSG_FATAL_CO85));
tok_start_end = tok_start + max_texts - 1;
tok_ptr=tok_mem+1; text_ptr=tok_start+1; tok_start[0]=tok_mem+1;
@^system dependencies@>
@z
------------------------------------------------------------------------------
ANSI
@x l.359
@c
int names_match(p,first,l,t)
name_pointer p; /* points to the proposed match */
char *first; /* position of first character of string */
int l; /* length of identifier */
eight_bits t; /* desired ilk */
@y
@c int names_match(name_pointer p,char *first,int l,eight_bits t)
/* |p|: points to the proposed match */
/* |first|:  position of first character of string */
/* |l|: length of identifier */
/* |t|: desired |ilk| */
@z
------------------------------------------------------------------------------
ANSI
@x l.370
void
init_p(p,t)
name_pointer p;
eight_bits t;
@y
void init_p(name_pointer p,eight_bits t)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.375
  p->ilk=t; p->xref=(char*)xmem;
@y
  p->ilk=t; p->xref=(void HUGE*)xmem;
@z
------------------------------------------------------------------------------
ANSI
@x l.378
void
init_node(p)
name_pointer p;
@y
void init_node(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.382
  p->xref=(char*)xmem;
@y
  p->xref=(void HUGE*)xmem;
@z
------------------------------------------------------------------------------
SYSTEM DEPENDENCIES
We append AMIGA specific keywords from Commodore and SAS Institute.
@x l.467
id_lookup("while",NULL,for_like);
@y
id_lookup("while",NULL,for_like);

#ifdef _AMIGA
if(use_amiga_keywords) {
   @<Keywords specific to {\mc SAS/C}@>@;
   @<Registers of the {\mc AMIGA}@>@;
   @<Keywords by Commodore@>@;
   }
#endif
@^system dependencies@>
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.522
eight_bits ccode[256]; /* meaning of a char following \.{@@} */

@ @<Set ini...@>=
{int c; for (c=0; c<256; c++) ccode[c]=0;}
@y
eight_bits *ccode; /* meaning of a char following \.{@@} */

@ @<Set ini...@>=
{int c;
alloc_object(ccode,256,eight_bits);
for (c=0; c<256; c++) ccode[c]=0;}
@z
------------------------------------------------------------------------------
ANSI
@x l.562
@<Predec...@>=
void   skip_limbo();

@ @c
void
skip_limbo() {
@y
@<Predec...@>=
static void skip_limbo(void);

@ @c
static void skip_limbo(void) {
@z
------------------------------------------------------------------------------
ANSI
@x l.587
@c
unsigned
skip_TeX() /* skip past pure \TEX/ code */
@y
@c static unsigned skip_TeX(void) /* skip past pure \TEX/ code */
@z
------------------------------------------------------------------------------
ANSI
@x l.645
#include <ctype.h> /* definition of |isalpha|, |isdigit| and so on */
#include <stdlib.h> /* definition of |exit| */
@y
#include <ctype.h> /* definition of |isalpha|, |isdigit| and so on */
#include <stdlib.h> /* definition of |exit| */
#include <stddef.h> /* type definition of |ptrdiff_t| */
@z
------------------------------------------------------------------------------
ANSI
@x l.655
@<Predecl...@>=
eight_bits get_next();

@ @c
eight_bits
get_next() /* produces the next input token */
{@+eight_bits c; /* the current character */
@y
@<Predecl...@>=
static eight_bits get_next(void);

@ @c
static eight_bits get_next(void) /* produces the next input token */
{
  eight_bits c; /* the current character */
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY
Macro invocation may have multiple side effects.
@x l.798
    *id_loc++='$'; *id_loc++=toupper(*loc++);
@y
    *id_loc++='$'; *id_loc++=toupper(*loc); *loc++;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.821
        err_print("! String didn't end"); loc=limit; break;
@y
        err_print(get_string(MSG_ERROR_CT67_1)); loc=limit; break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.825
        err_print("! Input ended in middle of string"); loc=buffer; break;
@y
        err_print(get_string(MSG_ERROR_CT67_2)); loc=buffer; break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.840
    printf("\n! String too long: ");
@y
    printf(get_string(MSG_ERROR_CT67_3));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.855
    case translit_code: err_print("! Use @@l in limbo only"); continue;
@y
    case translit_code: err_print(get_string(MSG_ERROR_CT68_1)); continue;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.894
    err_print("! Input ended in section name");
@y
    err_print(get_string(MSG_ERROR_CT72_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.907
  printf("\n! Section name too long: ");
@y
  printf(get_string(MSG_ERROR_CT72_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.921
    err_print("! Section name didn't end"); break;
@y
    err_print(get_string(MSG_ERROR_CT73_1)); break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.925
    err_print("! Control codes are forbidden in section name"); break;
@y
    err_print(get_string(MSG_ERROR_CW54)); break;
@z
------------------------------------------------------------------------------
ANSI
@x l.933
@<Predecl...@>=
void skip_restricted();

@ @c
void
skip_restricted()
@y
@<Predecl...@>=
void skip_restricted(void);

@ @c
void skip_restricted(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.945
    err_print("! Control text didn't end"); loc=limit;
@y
    err_print(get_string(MSG_ERROR_CW56_1)); loc=limit;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.951
      err_print("! Control codes are forbidden in control text");
@y
      err_print(get_string(MSG_ERROR_CW56_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.964
  if (loc>=limit) err_print("! Verbatim string didn't end");
@y
  if (loc>=limit) err_print(get_string(MSG_ERROR_CT74));
@z
------------------------------------------------------------------------------
ANSI
@x l.983
@ The overall processing strategy in phase one has the following
straightforward outline.

@<Predecl...@>=
void phase_one();

@ @c
void
phase_one() {
@y
@ The overall processing strategy in phase one has the following
straightforward outline.

@<Predecl...@>=
static void phase_one(void);

@ @c
static void phase_one(void) {
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1004
  if (++section_count==max_sections) overflow("section number");
@y
  if (++section_count==max_sections) overflow(get_string(MSG_OVERFLOW_CW61));
@z
------------------------------------------------------------------------------
ANSI
@x l.1033
+wildcard| and |xref_typewriter==identifier+typewriter| and |normal==0|.

@<Predecl...@>=
void C_xref();

@ @c
void
C_xref( spec_ctrl ) /* makes cross-references for \CEE/ identifiers */
  eight_bits spec_ctrl;
@y
+wildcard| and |xref_typewriter==identifier+typewriter| and finally
|normal==0|.

@<Predecl...@>=
static void C_xref(eight_bits);

@ @c
static void C_xref( eight_bits spec_ctrl )
   /* makes cross-references for \CEE/ identifiers */
@z
------------------------------------------------------------------------------
ANSI
@x l.1065
@<Predecl...@>=
void outer_xref();

@ @c
void
outer_xref() /* extension of |C_xref| */
@y
@<Predecl...@>=
static void outer_xref(void);

@ @c
static void outer_xref(void) /* extension of |C_xref| */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1095
    case translit_code: err_print("! Use @@l in limbo only"); continue;
@y
    case translit_code: err_print(get_string(MSG_ERROR_CT68_1)); continue;
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.1168
            else lhs->xref=(char*)q->xlink;
@y
            else lhs->xref=(void HUGE*)q->xlink;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1182
    err_print("! Missing left identifier of @@s");
@y
    err_print(get_string(MSG_ERROR_CW71_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1187
      err_print("! Missing right identifier of @@s");
@y
      err_print(get_string(MSG_ERROR_CW71_2));
@z
------------------------------------------------------------------------------
ANSI
@x l.1226
@<Predecl...@>=
void section_check();

@ @c
void
section_check(p)
name_pointer p; /* print anomalies in subtree |p| */
@y
@<Predecl...@>=
static void section_check(name_pointer);

@ @c
static void section_check(name_pointer p)
   /* print anomalies in subtree |p| */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1240
      printf("\n! Never defined: <"); print_section_name(p); putchar('>'); mark_harmless;
@y
      printf(get_string(MSG_WARNING_CW75_1));
      print_section_name(p); putchar('>'); mark_harmless;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1245
      printf("\n! Never used: <"); print_section_name(p); putchar('>'); mark_harmless;
@y
      printf(get_string(MSG_WARNING_CW75_2));
      print_section_name(p); putchar('>'); mark_harmless;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.1261
char out_buf[line_length+1]; /* assembled characters */
char *out_ptr; /* just after last character in |out_buf| */
char *out_buf_end = out_buf+line_length; /* end of |out_buf| */
@y
char *out_buf; /* assembled characters */
char *out_ptr; /* just after last character in |out_buf| */
char *out_buf_end; /* end of |out_buf| */
@z
------------------------------------------------------------------------------
ANSI
@x l.1283
void
flush_buffer(b,per_cent,carryover)
char *b;  /* outputs from |out_buf+1| to |b|,where |b<=out_ptr| */
boolean per_cent,carryover;
@y
static void flush_buffer(char *b,boolean per_cent,boolean carryover)
   /* outputs from |out_buf+1| to |b|, where |b<=out_ptr| */
@z
------------------------------------------------------------------------------
ANSI
@x l.1299
  if (b<out_ptr) strncpy(out_buf+1,b+1,out_ptr-b);
@y
  if (b<out_ptr) strncpy(out_buf+1,b+1,(size_t)(out_ptr-b));
@z
------------------------------------------------------------------------------
ANSI
@x l.1312
void
finish_line() /* do this at the end of a line */
@y
static void finish_line(void) /* do this at the end of a line */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, PORTABILITY
Additionally to the AMIGA keywords there is also a German version of
the TeX macros called gcwebmac.tex. You may include these macros by
setting the `+g' command line switch.
@x l.1327
`\.{\\input cwebmac}'.

@<Set init...@>=
out_ptr=out_buf+1; out_line=1; active_file=tex_file;
*out_ptr='c'; tex_printf("\\input cwebma");
@y
`\.{\\input ccwebmac}' or `\.{\\input gcwebmac}' if the `\.{+g}' option was
set.

@<Set init...@>=
alloc_object(out_buf,line_length+1,char);
out_buf_end = out_buf + line_length;
out_ptr=out_buf+1; out_line=1; active_file=tex_file; *out_ptr='c';
if(use_german_macros) tex_printf("\\input gcwebma");
else tex_printf("\\input ccwebma");
@z
------------------------------------------------------------------------------
ANSI
@x l.1344
void
out_str(s) /* output characters from |s| to end of string */
char *s;
@y
static void out_str(char*s) /* output characters from |s| to end of string */
@z
------------------------------------------------------------------------------
ANSI
@x l.1362
@<Predecl...@>=
void break_out();

@ @c
void
break_out() /* finds a way to break the output line */
@y
@<Predecl...@>=
static void break_out(void);

@ @c static void break_out(void) /* finds a way to break the output line */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1388
  printf("\n! Line had to be broken (output l. %d):\n",out_line);
@y
  printf(get_string(MSG_WARNING_CW85),out_line);
@z
------------------------------------------------------------------------------
ANSI
@x l.1401
void
out_section(n)
sixteen_bits n;
@y
static void out_section(sixteen_bits n)
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY
@x l.1415
void
out_name(p)
name_pointer p;
{
  char *k, *k_end=(p+1)->byte_start; /* pointers into |byte_mem| */
@y
static void out_name(name_pointer p)
{
  char HUGE *k;
  char HUGE *k_end=(p+1)->byte_start; /* pointers into |byte_mem| */
@z
------------------------------------------------------------------------------
ANSI
@x l.1442
void
copy_limbo()
@y
static void copy_limbo(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1461
        default: err_print("! Double @@ should be used in limbo");
@y
        default: err_print(get_string(MSG_ERROR_CT93));
@z
------------------------------------------------------------------------------
ANSI
@x l.1477
eight_bits
copy_TeX()
@y
static eight_bits copy_TeX(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1503
@d app_tok(c) {if (tok_ptr+2>tok_mem_end) overflow("token"); *(tok_ptr++)=c;}
@y
@d app_tok(c) {if (tok_ptr+2>tok_mem_end)
    overflow(get_string(MSG_OVERFLOW_CT26));
  *(tok_ptr++)=c;}
@z
------------------------------------------------------------------------------
ANSI
@x l.1505
@<Predec...@>=
int copy_comment();

@ @c
int copy_comment(is_long_comment,bal) /* copies \TEX/ code in comments */
boolean is_long_comment; /* is this a traditional \CEE/ comment? */
int bal; /* brace balance */
@y
@<Predec...@>=
static int copy_comment(boolean,int);

@ @c static copy_comment(boolean is_long_comment,int bal)
   /* copies \TeX\ code in comments */
   /* |is_long_comment|: is this a traditional \CEE/ comment? */
   /* |bal|: brace balance */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1518
          err_print("! Input ended in mid-comment");
@y
          err_print(get_string(MSG_ERROR_CT60_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1524
        if (bal>1) err_print("! Missing } in comment");
@y
        if (bal>1) err_print(get_string(MSG_ERROR_CW92_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1540
      else {err_print("! Extra } in comment");
@y
      else {err_print(get_string(MSG_ERROR_CW92_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1552
  if (bal>1) err_print("! Missing } in comment");
@y
  if (bal>1) err_print(get_string(MSG_ERROR_CW92_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1560
    err_print("! Illegal use of @@ in comment");
@y
    err_print(get_string(MSG_ERROR_CW94));
@z
------------------------------------------------------------------------------
@x l.1597
no such productions exist, we find to find the longest production
@y
no such productions exist, we try to find the longest production
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.1670
char cat_name[256][12];
eight_bits cat_index;

@ @<Set in...@>=
@y
char **cat_name;
eight_bits cat_index;

@ @<Set in...@>=
    alloc_object(cat_name,256,char *);
    for(cat_index=0; cat_index<255; cat_index++)
      alloc_object(cat_name[cat_index],12,char);
@z
------------------------------------------------------------------------------
ANSI
@x l.1734
void
print_cat(c) /* symbolic printout of a category */
eight_bits c;
@y
static void print_cat(eight_bits c) /* symbolic printout of a category */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.2025
scrap scrap_info[max_scraps]; /* memory array for scraps */
scrap_pointer scrap_info_end=scrap_info+max_scraps -1; /* end of |scrap_info| */
@y
scrap *scrap_info; /* memory array for scraps */
scrap_pointer scrap_info_end; /* end of |scrap_info| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.2034
@ @<Set init...@>=
scrap_base=scrap_info+1;
max_scr_ptr=scrap_ptr=scrap_info;
@y
@ @<Set init...@>=
alloc_object(scrap_info,max_scraps,scrap);
scrap_info_end = scrap_info + max_scraps - 1;
scrap_base=scrap_info+1;
max_scr_ptr=scrap_ptr=scrap_info;
@z
------------------------------------------------------------------------------
ANSI
@x l.2062
void
print_text(p) /* prints a token list for debugging; not used in |main| */
text_pointer p;
@y
static void print_text(text_pointer p)
   /* prints a token list for debugging; not used in |main| */
@z
------------------------------------------------------------------------------
ANSI
@x l.2180
@d app(a) *(tok_ptr++)=a
@d app1(a) *(tok_ptr++)=tok_flag+(int)((a)->trans-tok_start)
@y
@d app(a) *(tok_ptr++)=(token)(a)
@d app1(a) *(tok_ptr++)=(token)(tok_flag+(int)((a)->trans-tok_start))
@z
------------------------------------------------------------------------------
ANSI
@x l.2186
@ @c
void
app_str(s)
char *s;
@y
@ @c static void app_str(char *s)
@z
------------------------------------------------------------------------------
ANSI
@x l.2194
void
big_app(a)
token a;
@y
static void big_app(token a)
@z
------------------------------------------------------------------------------
ANSI
@x l.2211
void
big_app1(a)
scrap_pointer a;
@y
static void big_app1(scrap_pointer a)
@z
------------------------------------------------------------------------------
ANSI
@x l.2312
token_pointer
find_first_ident(p)
text_pointer p;
@y
static token_pointer find_first_ident(text_pointer p)
@z
------------------------------------------------------------------------------
ANSI
@x l.2339
void
make_reserved(p) /* make the first identifier in |p->trans| like |int| */
scrap_pointer p;
@y
static void make_reserved(scrap_pointer p)
/* make the first identifier in |p->trans| like |int| */
@z
------------------------------------------------------------------------------
ANSI
@x l.2356
  (name_dir+(sixteen_bits)(tok_value%id_flag))->ilk=raw_int;
@y
  (name_dir+(ptrdiff_t)(tok_value%id_flag))->ilk=raw_int;
@z
------------------------------------------------------------------------------
ANSI
@x l.2370
void
make_underlined(p)
/* underline the entry for the first identifier in |p->trans| */
scrap_pointer p;
@y
static void make_underlined(scrap_pointer p)
/* underline the entry for the first identifier in |p->trans| */
@z
------------------------------------------------------------------------------
ANSI
@x l.2386
@<Predecl...@>=
void  underline_xref();

@ @c
void
underline_xref(p)
name_pointer p;
@y
@<Predecl...@>=
static void underline_xref(name_pointer);

@ @c
static void underline_xref(name_pointer p)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.2423
  p->xref=(char*)xref_ptr;
@y
  p->xref=(void HUGE*)xref_ptr;
@z
------------------------------------------------------------------------------
PORTABILITY
CWeave indents declarations after old-style function definitions.  With the
`-i' option they will come out flush left.  You won't see any difference if
you use the ANSI-style function definitions.
@x l.2432
@<Cases for |exp|@>=
if (cat1==lbrace || cat1==int_like || cat1==decl) {
  make_underlined(pp); big_app1(pp); big_app(indent); app(indent);
  reduce(pp,1,fn_decl,0,1);
}
@y
@<Cases for |exp|@>=
if(cat1==lbrace || cat1==int_like || cat1==decl) {
  make_underlined(pp); big_app1(pp);
  if (indent_param_decl) {
    big_app(indent); app(indent);
  }
  reduce(pp,1,fn_decl,0,1);
}
@z
----------------------------------------------------------------------
PORTABILITY
@x l.2537
@ @<Cases for |decl_head|@>=
if (cat1==comma) {
  big_app2(pp); big_app(' '); reduce(pp,2,decl_head,-1,33);
}
else if (cat1==unorbinop) {
  big_app1(pp); big_app('{'); big_app1(pp+1); big_app('}');
  reduce(pp,2,decl_head,-1,34);
}
else if (cat1==exp && cat2!=lpar && cat2!=exp) {
  make_underlined(pp+1); squash(pp,2,decl_head,-1,35);
}
else if ((cat1==binop||cat1==colon) && cat2==exp && (cat3==comma ||
    cat3==semi || cat3==rpar))
  squash(pp,3,decl_head,-1,36);
else if (cat1==cast) squash(pp,2,decl_head,-1,37);
else if (cat1==lbrace || (cat1==int_like&&cat2!=colcol) || cat1==decl) {
  big_app1(pp); big_app(indent); app(indent); reduce(pp,1,fn_decl,0,38);
}
else if (cat1==semi) squash(pp,2,decl,-1,39);
@y
@ @<Cases for |decl_head|@>=
if (cat1==comma) {
  big_app2(pp); big_app(' '); reduce(pp,2,decl_head,-1,33);
}
else if (cat1==unorbinop) {
  big_app1(pp); big_app('{'); big_app1(pp+1); big_app('}');
  reduce(pp,2,decl_head,-1,34);
}
else if (cat1==exp && cat2!=lpar && cat2!=exp) {
  make_underlined(pp+1); squash(pp,2,decl_head,-1,35);
}
else if ((cat1==binop||cat1==colon) && cat2==exp && (cat3==comma ||
    cat3==semi || cat3==rpar))
  squash(pp,3,decl_head,-1,36);
else if (cat1==cast) squash(pp,2,decl_head,-1,37);
else if (cat1==lbrace || (cat1==int_like&&cat2!=colcol) || cat1==decl) {
  big_app1(pp);
  if (indent_param_decl) {
    big_app(indent); app(indent);
  }
  reduce(pp,1,fn_decl,0,38);
}
else if (cat1==semi) squash(pp,2,decl,-1,39);
@z
------------------------------------------------------------------------------
PORTABILITY
The original manual described the `-o' option for CWEAVE, but this was not
yet present.  Here is a simple implementation.  The purpose is to suppress
the extra space between local variable declarations and the first statement
in a function block.
@x l.2562
else if (cat1==stmt || cat1==function) {
  big_app1(pp); big_app(big_force);
  big_app1(pp+1); reduce(pp,2,cat1,-1,41);
}
@y
else if (cat1==stmt || cat1==function) {
  big_app1(pp);
  if(order_decl_stmt) big_app(big_force);
  else big_app(force);
  big_app1(pp+1); reduce(pp,2,cat1,-1,41);
}
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.2608
@ @<Cases for |fn_decl|@>=
if (cat1==decl) {
  big_app1(pp); big_app(force); big_app1(pp+1); reduce(pp,2,fn_decl,0,51);
}
else if (cat1==stmt) {
  big_app1(pp); app(outdent); app(outdent); big_app(force);
  big_app1(pp+1); reduce(pp,2,function,-1,52);
}
@y
@ @<Cases for |fn_decl|@>=
if (cat1==decl) {
  big_app1(pp); big_app(force); big_app1(pp+1); reduce(pp,2,fn_decl,0,51);
}
else if (cat1==stmt) {
  big_app1(pp);
  if (indent_param_decl) {
    app(outdent); app(outdent);
  }
  big_app(force);
  big_app1(pp+1); reduce(pp,2,function,-1,52);
}
@z
----------------------------------------------------------------------
ANSI
@x l.2866
void
reduce(j,k,c,d,n)
scrap_pointer j;
eight_bits c;
short k, d, n;
@y
static void reduce(scrap_pointer j, short k, eight_bits c, short d, short n)
@z
------------------------------------------------------------------------------
ANSI
@x l.2896
void
squash(j,k,c,d,n)
scrap_pointer j;
eight_bits c;
short k, d, n;
@y
static void squash(scrap_pointer j, short k, eight_bits c, short d, short n)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.2931
    overflow("token");
@y
    overflow(get_string(MSG_OVERFLOW_CT30));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.2935
    overflow("text");
@y
    overflow(get_string(MSG_OVERFLOW_CT76));
@z
------------------------------------------------------------------------------
ANSI
@x l.2992
text_pointer
translate() /* converts a sequence of scraps */
@y
static text_pointer translate(void) /* converts a sequence of scraps */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3015
    if (tok_ptr+6>tok_mem_end) overflow("token");
@y
    if (tok_ptr+6>tok_mem_end) overflow(get_string(MSG_OVERFLOW_CT26));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3023
  printf("\nIrreducible scrap sequence in section %d:",section_count);
@y
  printf(get_string(MSG_WARNING_CW171),section_count);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3032
  printf("\nTracing after l. %d:\n",cur_line); mark_harmless;
@y
  printf(get_string(MSG_WARNING_CW172),cur_line); mark_harmless;
@z
------------------------------------------------------------------------------
ANSI
@x l.3057
void
C_parse(spec_ctrl) /* creates scraps from \CEE/ tokens */
  eight_bits spec_ctrl;
@y
static void C_parse(eight_bits spec_ctrl)
  /* creates scraps from \CEE/ tokens */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3160
  overflow("scrap/token/text");
@y
  overflow(get_string(MSG_OVERFLOW_CW176));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3244
        else err_print("! Double @@ should be used in strings");
@y
        else err_print(get_string(MSG_ERROR_CT80));
@z
------------------------------------------------------------------------------
@x l.3257
open, to be picked up by next scrap. If it comes at the end of a
@y
open, to be picked up by the next scrap. If it comes at the end of a
@z
------------------------------------------------------------------------------
ANSI
@x l.3276
@<Predec...@>=
void app_cur_id();

@ @c
void
app_cur_id(scrapping)
boolean scrapping; /* are we making this into a scrap? */
@y
@<Predec...@>=
void app_cur_id(boolean);

@ @c
void app_cur_id(boolean scrapping) /* are we making this into a scrap? */
@z
------------------------------------------------------------------------------
ANSI
@x l.3301
text_pointer
C_translate()
@y
static text_pointer C_translate(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3308
  if (next_control!='|') err_print("! Missing '|' after C text");
@y
  if (next_control!='|') err_print(get_string(MSG_ERROR_CW182));
@z
------------------------------------------------------------------------------
ANSI
@x l.3323
void
outer_parse() /* makes scraps from \CEE/ tokens and comments */
@y
static void outer_parse(void) /* makes scraps from \CEE/ tokens and comments */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.3414
output_state stack[stack_size]; /* info for non-current levels */
stack_pointer stack_ptr; /* first unused location in the output state stack */
stack_pointer stack_end=stack+stack_size-1; /* end of |stack| */
@y
output_state *stack; /* info for non-current levels */
stack_pointer stack_ptr; /* first unused location in the output state stack */
stack_pointer stack_end; /* end of |stack| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.3419
@ @<Set init...@>=
max_stack_ptr=stack;
@y
@ @<Set init...@>=
alloc_object(stack,stack_size,output_state);
stack_end = stack + stack_size - 1;
max_stack_ptr=stack;
@z
------------------------------------------------------------------------------
ANSI
@x l.3427
void
push_level(p) /* suspends the current level */
text_pointer p;
@y
static void push_level(text_pointer p) /* suspends the current level */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3431
  if (stack_ptr==stack_end) overflow("stack");
@y
  if (stack_ptr==stack_end) overflow(get_string(MSG_OVERFLOW_CT30));
@z
------------------------------------------------------------------------------
ANSI
@x l.3447
void
pop_level()
@y
static void pop_level(void)
@z
------------------------------------------------------------------------------
ANSI
@x l.3469
eight_bits
get_output() /* returns the next token of output */
@y
static eight_bits get_output(void) /* returns the next token of output */
@z
------------------------------------------------------------------------------
ANSI
@x l.3487
  return(a);
@y
  return((eight_bits)a);
@z
------------------------------------------------------------------------------
ANSI
@x l.3511
void
output_C() /* outputs the current token list */
@y
static void output_C(void) /* outputs the current token list */
@z
------------------------------------------------------------------------------
ANSI
@x l.3531
@<Predecl...@>=
void make_output();

@ @c
void
make_output() /* outputs the equivalents of tokens */
@y
@<Predecl...@>=
static void make_output(void);

@ @c
static void make_output(void) /* outputs the equivalents of tokens */
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.3541
  char *k, *k_limit; /* indices into |byte_mem| */
@y
  char HUGE *k;
  char HUGE *k_limit; /* indices into |byte_mem| */
@z
------------------------------------------------------------------------------
SYSTEM DEPENDENCIES
We need a huge pointer here instead of j; k seems a good choice, since it is
declared as index into byte_mem anyhow.
@x l.3587
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      out(isxalpha(*j)? 'x':*j);
@y
#ifdef __TURBOC__
    for (k=cur_name->byte_start;k<(cur_name+1)->byte_start;k++)
      out(isxalpha(*k)? 'x':*k);
#else
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      out(isxalpha(*j)? 'x':*j);
#endif
@^system dependencies@>
@z
------------------------------------------------------------------------------
SYSTEM DEPENDENCIES
@x l.3593
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      if (xislower(*j)) { /* not entirely uppercase */
@y
#ifdef __TURBOC__
    for (k=cur_name->byte_start;k<(cur_name+1)->byte_start;k++)
      if (xislower(*k)) { /* not entirely uppercase */
#else
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      if (xislower(*j)) { /* not entirely uppercase */
#endif
@^system dependencies@>
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3744
  printf("\n! Illegal control code in section name: <");
@y
  printf(get_string(MSG_ERROR_CW201));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3759
    printf("\n! C text in section name didn't end: <");
@y
    printf(get_string(MSG_ERROR_CW202));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3770
      if (j>buffer+long_buf_size-3) overflow("buffer");
@y
      if (j>buffer+long_buf_size-3) overflow(get_string(MSG_OVERFLOW_CW202));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3778
  if (j>buffer+long_buf_size-4) overflow("buffer");
@y
  if (j>buffer+long_buf_size-4) overflow(get_string(MSG_OVERFLOW_CW202));
@z
------------------------------------------------------------------------------
ANSI
@x l.3789
@<Predecl...@>=
void phase_two();

@ @c
void
phase_two() {
@y
@<Predecl...@>=
static void phase_two(void);

@ @c
static void phase_two(void) {
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3795
reset_input(); if (show_progress) printf("\nWriting the output file...");
@y
reset_input(); if (show_progress) printf(get_string(MSG_PROGRESS_CW204));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3878
        err_print("! TeX string should be in C text only"); break;
@y
        err_print(get_string(MSG_ERROR_CW209_1)); break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3884
        err_print("! You can't do that in TeX text"); break;
@y
        err_print(get_string(MSG_ERROR_CW209_2)); break;
@z
------------------------------------------------------------------------------
ANSI
@x l.3912
@<Predecl...@>=
void finish_C();

@ @c
void
finish_C(visible) /* finishes a definition or a \CEE/ part */
  boolean visible; /* nonzero if we should produce \TEX/ output */
@y
@<Predecl...@>=
static void finish_C(boolean);

@ @c
static void finish_C(boolean visible) /* finishes a definition or a \Cee\ part */
  /* |visible|: nonzero if we should produce \TeX\ output */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3956
    err_print("! Improper macro definition");
@y
    err_print(get_string(MSG_ERROR_CW213));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3965
      default: err_print("! Improper macro definition"); break;
@y
      default: err_print(get_string(MSG_ERROR_CW213)); break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.3991
  if (scrap_ptr!=scrap_info+2) err_print("! Improper format definition");
@y
  if (scrap_ptr!=scrap_info+2) err_print(get_string(MSG_ERROR_CW214));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.4026
  err_print("! You need an = sign after the section name");
@y
  err_print(get_string(MSG_ERROR_CW217));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.4048
  err_print("! You can't do that in C text");
@y
  err_print(get_string(MSG_ERROR_CW218));
@z
------------------------------------------------------------------------------
ANSI
@x l.4083
@<Predecl...@>=
void footnote();

@ @c
void
footnote(flag) /* outputs section cross-references */
sixteen_bits flag;
@y
@<Predecl...@>=
static void footnote(sixteen_bits);

@ @c
static void footnote(sixteen_bits flag) /* outputs section cross-references */
@z
------------------------------------------------------------------------------
@x l.4128
If the user has set the |no_xref| flag (the |-x| option on the command line),
@y
If the user has set the |no_xref| flag (the \.{-x} option on the command line),
@z
------------------------------------------------------------------------------
ANSI
@x l.4132
@<Predecl...@>=
void phase_three();

@ @c
void
phase_three() {
@y
@<Predecl...@>=
static void phase_three(void);

@ @c
static void phase_three(void) {
@z
------------------------------------------------------------------------------
ANSI, TRANSLATION
Switching from the automatic string to `get_string' causes a timing
problem.  Obviously the output is buffered, so `fflush' its contents.
@x l.4145
  phase=3; if (show_progress) printf("\nWriting the index...");
@y
  phase=3;
  if (show_progress) {
    printf(get_string(MSG_PROGRESS_CW225)); fflush(stdout);
  }
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.4149
    fatal("! Cannot open index file ",idx_file_name);
@y
    fatal(get_string(MSG_FATAL_CW225_1),idx_file_name);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.4164
    fatal("! Cannot open section file ",scn_file_name);
@y
    fatal(get_string(MSG_FATAL_CW225_2),scn_file_name);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.4176
if (show_happiness) printf("\nDone.");
@y
if (show_happiness) printf(get_string(MSG_PROGRESS_CT42_3));
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.4210
name_pointer bucket[256];
name_pointer next_name; /* successor of |cur_name| when sorting */
name_pointer blink[max_names]; /* links in the buckets */
@y
name_pointer *bucket;
name_pointer next_name; /* successor of |cur_name| when sorting */
name_pointer *blink; /* links in the buckets */
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.4224
    if (cur_name->xref!=(char*)xmem) {
@y
    if (cur_name->xref!=(void HUGE*)xmem) {
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.4254
char *cur_byte; /* index into |byte_mem| */
@y
char HUGE *cur_byte; /* index into |byte_mem| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.4258
@ @<Set init...@>=
max_sort_ptr=scrap_info;
@y
@ @<Set init...@>=
alloc_object(bucket,256,name_pointer);
alloc_object(blink,max_names,name_pointer);
max_sort_ptr=scrap_info;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
The \.{@@t} feature causes problems when there are `<' or `>' operators
placed directly aside the `@t...@>' group.  Most of the other C operators
work fine.  Provide an improvement of the documentation.
@x l.4261
@ The desired alphabetic order is specified by the |collate| array; namely,
|collate[0]<collate[1]<@t$\cdots$@><collate[100]|.

@<Global...@>=
eight_bits collate[102+128]; /* collation order */
@^high-bit character handling@>
@y
@ The desired alphabetic order is specified by the |collate| array; namely,
|collate[0]@t${}<\cdots<{}$@>collate[100]|.

@<Global...@>=
eight_bits *collate; /* collation order */
@^high-bit character handling@>
@z
------------------------------------------------------------------------------
ANSI, MEMORY ALLOCATION
@x l.4275
collate[0]=0; strcpy(collate+1," \1\2\3\4\5\6\7\10\11\12\13\14\15\16\17\
\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37\
!\42#$%&'()*+,-./:;<=>?@@[\\]^`{|}~_\
abcdefghijklmnopqrstuvwxyz0123456789\
\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217\
\220\221\222\223\224\225\226\227\230\231\232\233\234\235\236\237\
\240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257\
\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277\
\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317\
\320\321\322\323\324\325\326\327\330\331\332\333\334\335\336\337\
\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357\
\360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377\
");
@y
alloc_object(collate,102+128,eight_bits);
collate[0]=0; strcpy((char *)collate+1,
  " \1\2\3\4\5\6\7\10\11\12\13\14\15\16\17"@|
  "\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37"@|
  "!\42#$%&'()*+,-./:;<=>?@@[\\]^`{|}~_abcdefghijklmnopqrstuvwxyz0123456789"@|
  "\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217"@|
  "\220\221\222\223\224\225\226\227\230\231\232\233\234\235\236\237"@|
  "\240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257"@|
  "\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277"@|
  "\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317"@|
  "\320\321\322\323\324\325\326\327\330\331\332\333\334\335\336\337"@|
  "\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357"@|
  "\360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377");
@z
------------------------------------------------------------------------------
ANSI
@x l.4297
@<Predecl...@>=
void  unbucket();

@ @c
void
unbucket(d) /* empties buckets having depth |d| */
eight_bits d;
@y
@<Predecl...@>=
static void unbucket(eight_bits);

@ @c
static void unbucket(eight_bits d) /* empties buckets having depth |d| */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.4309
    if (sort_ptr>=scrap_info_end) overflow("sorting");
@y
    if (sort_ptr>=scrap_info_end) overflow(get_string(MSG_OVERFLOW_CW237));
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.4358
    else {char *j;
@y
    else {char HUGE *j;
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.4373
  case custom: case quoted: {char *j; out_str("$\\");
@y
  case custom: case quoted: {char HUGE *j; out_str("$\\");
@z
------------------------------------------------------------------------------
ANSI
@x l.4417
@<Predecl...@>=
void section_print();

@ @c
void
section_print(p) /* print all section names in subtree |p| */
name_pointer p;
@y
@<Predecl...@>=
static void section_print(name_pointer);

@ @c
static void section_print(name_pointer p) /* print all section names in subtree |p| */
@z
------------------------------------------------------------------------------
ANSI, TRANSLATION
@x l.4439
@ Because on some systems the difference between two pointers is a |long|
rather than an |int|, we use \.{\%ld} to print these quantities.

@c
void
print_stats() {
  printf("\nMemory usage statistics:\n");
@.Memory usage statistics:@>
  printf("%ld names (out of %ld)\n",
            (long)(name_ptr-name_dir),(long)max_names);
  printf("%ld cross-references (out of %ld)\n",
            (long)(xref_ptr-xmem),(long)max_refs);
  printf("%ld bytes (out of %ld)\n",
            (long)(byte_ptr-byte_mem),(long)max_bytes);
  printf("Parsing:\n");
  printf("%ld scraps (out of %ld)\n",
            (long)(max_scr_ptr-scrap_info),(long)max_scraps);
  printf("%ld texts (out of %ld)\n",
            (long)(max_text_ptr-tok_start),(long)max_texts);
  printf("%ld tokens (out of %ld)\n",
            (long)(max_tok_ptr-tok_mem),(long)max_toks);
  printf("%ld levels (out of %ld)\n",
            (long)(max_stack_ptr-stack),(long)stack_size);
  printf("Sorting:\n");
  printf("%ld levels (out of %ld)\n",
            (long)(max_sort_ptr-scrap_info),(long)max_scraps);
}
@y
@ {\mc ANSI C} declares the difference between two pointers to be of type
|ptrdiff_t| which equals |long| on (almost) all systems instead of |int|,
so we use \.{\%ld} to print these quantities and cast them to |long|
explicitly.

@c
void print_stats(void) {
  printf(get_string(MSG_STATS_CT95_1));
@.Memory usage statistics:@>
  printf(get_string(MSG_STATS_CT95_2),
            (long)(name_ptr-name_dir),(long)max_names);
  printf(get_string(MSG_STATS_CW248_1),
            (long)(xref_ptr-xmem),(long)max_refs);
  printf(get_string(MSG_STATS_CT95_4),
            (long)(byte_ptr-byte_mem),(long)max_bytes);
  printf(get_string(MSG_STATS_CW248_2));
  printf(get_string(MSG_STATS_CW248_3),
            (long)(max_scr_ptr-scrap_info),(long)max_scraps);
  printf(get_string(MSG_STATS_CW248_4),
            (long)(max_text_ptr-tok_start),(long)max_texts);
  printf(get_string(MSG_STATS_CT95_5),
            (long)(max_tok_ptr-tok_mem),(long)max_toks);
  printf(get_string(MSG_STATS_CW248_5),
            (long)(max_stack_ptr-stack),(long)stack_size);
  printf(get_string(MSG_STATS_CW248_6));
  printf(get_string(MSG_STATS_CW248_5),
            (long)(max_sort_ptr-scrap_info),(long)max_scraps);
}
@z
------------------------------------------------------------------------------
ANSI, SYSTEM DEPENDENCIES
@x l.4467
@** Index.
@y
@** Function declarations.  Here are declarations---conforming to
{\mc ANSI~C}---of all functions in this code, as far as they are
not already in |"common.h"|.  These are private to \.{CWEAVE}.

@<Predecl...@>=
static eight_bits copy_TeX(void);@/
static eight_bits get_output(void);@/
static text_pointer C_translate(void);@/
static text_pointer translate(void);@/
static token_pointer find_first_ident(text_pointer);@/
static unsigned skip_TeX(void);@/
static void app_str(char *);@/
static void big_app(token);@/
static void big_app1(scrap_pointer);@/
static void copy_limbo(void);@/
static void C_parse(eight_bits);@/
static void finish_line(void);@/
static void flush_buffer(char *,boolean,boolean);@/
static void make_reserved(scrap_pointer);@/
static void make_underlined(scrap_pointer);@/
static void new_section_xref(name_pointer);@/
static void new_xref(name_pointer);@/
static void outer_parse(void);@/
static void output_C(void);@/
static void out_name(name_pointer);@/
static void out_section(sixteen_bits);@/
static void out_str(char *);@/
static void pop_level(void);@/
static void print_cat(eight_bits);@/
static void print_text(text_pointer p);@/
static void push_level(text_pointer);@/
static void reduce(scrap_pointer,short,eight_bits,short,short);@/
static void set_file_flag(name_pointer);@/
static void skip_limbo(void);@/
static void squash(scrap_pointer,short,eight_bits,short,short);@/
#ifdef DEAD_CODE
static void out_str_del(char *,char *);@/
#endif

@** System specific keywords.  For the convenience of {\mc AMIGA} users a
list of additional keywords is appended to \.{CWEAVE}'s internal tables.
Some of these are introduced by Commodore's operating system, others by
the {\mc SAS/C} compiler.
@^system dependencies@>

 @<Keywords specific to {\mc SAS/C}@>=
   id_lookup("__aligned",NULL,int_like);@+
   id_lookup("__asm",NULL,int_like);
   id_lookup("__chip",NULL,int_like);@+
   id_lookup("__far",NULL,int_like);
   id_lookup("__inline",NULL,int_like);@+
   id_lookup("__interrupt",NULL,int_like);
   id_lookup("__near",NULL,int_like);@+
   id_lookup("__regargs",NULL,int_like);
   id_lookup("__saveds",NULL,int_like);@+
   id_lookup("__stackext",NULL,int_like);
   id_lookup("__stdargs",NULL,int_like);

@ @<Registers of the {\mc AMIGA}@>=
   id_lookup("__d0",NULL,int_like);@+
   id_lookup("__d1",NULL,int_like);
   id_lookup("__d2",NULL,int_like);@+
   id_lookup("__d3",NULL,int_like);
   id_lookup("__d4",NULL,int_like);@+
   id_lookup("__d5",NULL,int_like);
   id_lookup("__d6",NULL,int_like);@+
   id_lookup("__d7",NULL,int_like);
   id_lookup("__a0",NULL,int_like);@+
   id_lookup("__a1",NULL,int_like);
   id_lookup("__a2",NULL,int_like);@+
   id_lookup("__a3",NULL,int_like);
   id_lookup("__a4",NULL,int_like);@+
   id_lookup("__a5",NULL,int_like);
   id_lookup("__a6",NULL,int_like);@+
   id_lookup("__a7",NULL,int_like);
   id_lookup("__fp0",NULL,int_like);@+
   id_lookup("__fp1",NULL,int_like);
   id_lookup("__fp2",NULL,int_like);@+
   id_lookup("__fp3",NULL,int_like);
   id_lookup("__fp4",NULL,int_like);@+
   id_lookup("__fp5",NULL,int_like);
   id_lookup("__fp6",NULL,int_like);@+
   id_lookup("__fp7",NULL,int_like);

@ @<Keywords by Commodore@>=
   id_lookup("GLOBAL",NULL,int_like);@+
   id_lookup("IMPORT",NULL,int_like);
   id_lookup("STATIC",NULL,int_like);@+
   id_lookup("REGISTER",NULL,int_like);
   id_lookup("VOID",NULL,int_like);@+
   id_lookup("APTR",NULL,int_like);
   id_lookup("LONG",NULL,int_like);@+
   id_lookup("ULONG",NULL,int_like);
   id_lookup("LONGBITS",NULL,int_like);@+
   id_lookup("WORD",NULL,int_like);
   id_lookup("UWORD",NULL,int_like);@+
   id_lookup("WORDBITS",NULL,int_like);
   id_lookup("BYTE",NULL,int_like);@+
   id_lookup("UBYTE",NULL,int_like);
   id_lookup("BYTEBITS",NULL,int_like);@+
   id_lookup("RPTR",NULL,int_like);
   id_lookup("STRPTR",NULL,int_like);@+
   id_lookup("SHORT",NULL,int_like);
   id_lookup("USHORT",NULL,int_like);@+
   id_lookup("COUNT",NULL,int_like);
   id_lookup("UCOUNT",NULL,int_like);@+
   id_lookup("CPTR",NULL,int_like);
   id_lookup("FLOAT",NULL,int_like);@+
   id_lookup("DOUBLE",NULL,int_like);
   id_lookup("BOOL",NULL,int_like);@+
   id_lookup("TEXT",NULL,int_like);
   id_lookup("BPTR",NULL,int_like);@+
   id_lookup("BSTR",NULL,int_like);

   id_lookup("byte",NULL,int_like);@+
   id_lookup("Class",NULL,int_like);
   id_lookup("ClassID",NULL,int_like);@+
   id_lookup("CxMsg",NULL,int_like);
   id_lookup("CxObj",NULL,int_like);@+
   id_lookup("dev_t",NULL,int_like);
   id_lookup("DIR",NULL,int_like);@+
   id_lookup("DisplayInfoHandle",NULL,int_like);
   id_lookup("ino_t",NULL,int_like);@+
   id_lookup("IX",NULL,int_like);
   id_lookup("Msg",NULL,int_like);@+
   id_lookup("Object",NULL,int_like);
   id_lookup("off_t",NULL,int_like);@+
   id_lookup("PFL",NULL,int_like);
   id_lookup("PLANEPTR",NULL,int_like);@+
   id_lookup("Tag",NULL,int_like);
   id_lookup("tPoint",NULL,int_like);@+
   id_lookup("ushort",NULL,int_like);
   id_lookup("u_char",NULL,int_like);@+
   id_lookup("u_int",NULL,int_like);
   id_lookup("u_long",NULL,int_like);@+
   id_lookup("u_short",NULL,int_like);
   id_lookup("WINDOW",NULL,int_like);

@* Version information.  The {\mc AMIGA} operating system provides the
`version' command and good programs answer with some informations about
their creation date and their current version.

@<Glob...@>=
#ifdef _AMIGA
const unsigned char *Version = "$VER: CWeave 3.1 [p9d] "__AMIGADATE__;
#endif
@^system dependencies@>

@** Index.
@z
------------------------------------------------------------------------------
