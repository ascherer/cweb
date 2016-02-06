								-*-Web-*-
This file, CTANGLE.CH, is part of CWEB.
It is a changefile for CTANGLE.W, Version 3.1.

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
the masterfile CTANGLE.W.

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
a1/t1	10 Oct 1991	H2B	First attempt for CTANGLE.W 2.0.
p2	13 Feb 1992	H2B	Updated for CTANGLE.W 2.2, ANSI and Turbo
				changefiles merged together.
p3	16 Apr 1992	H2B	Updated for CTANGLE.W 2.4.
p4	21 Jun 1992	H2B	Nothing changed.
p5	18 Jul 1992	H2B	Extensions for C++ implemented.
p5a	24 Jul 1992	KG	adaptions for other ANSI C compiler
p5b	28 Jul 1992	H2B	Remaining headers converted to ANSI style.
p6	06 Sep 1992	H2B	Updated for CTANGLE.W 2.7, |dot_dot_dot|
				added, parsing of @@'\'' fixed (due to KG),
				@@<Copy an ASCII constant@@> extended,
				(nonfatal) confusion in processing short
				comments fixed.
p6a     15 Mar 1993     AS      Re-changing some of the TC stuff to SAS/C
p6b     27 Jul 1993     AS      new patch level in accordance with CWeave
p6c	04 Sep 1993	AS	new patch level in accordance with Common
p6d	09 Oct 1993	AS	Updated for CTANGLE.W 2.8. (This was p7)
p7	13 Nov 1992	H2B	Converted to master change file, updated for
				CTANGLE.W 2.8. [Not released.]
p7.5	29 Nov 1992	H2B	Updated for CTANGLE.W 2.9beta. [Not released.]
p8	08 Dec 1992	H2B	Updated for CTANGLE.W 2.9++ (stuff went into
				the source file), ANSI bug in <Get a constant>
				fixed. [Not released.]
p8a	10 Mar 1993	H2B	Restructured for public release.
				[Not released.]
p8b	14 Apr 1993	H2B	Updated for CTANGLE.W 3.0beta. [Not released.]
p8c	21 Jun 1993	H2B	Updated for final CTANGLE.W 3.0.
p8d	25 Oct 1993	AS	Incorporated into Amiga version 2.8 [p7] and
				updated to version 3.0.
p8e	04 Nov 1993	AS	New patch level in accordance with COMMON.
p9	18 Nov 1993	AS	Updated to CTANGLE.W 3.1
p9a	30 Nov 1993	AS	Minor changes and corrections.
p9b	06 Dec 1993	AS	Multilinguality implemented.
p9c	18 Jan 1994	AS	Version information included.
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
% This file, CTANGLE.W, is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.4 --- Don Knuth, April 1992
% Version 2.4 [p5] --- Hans-Hermann Bode, July 1992
% Version 2.4 [p5a] --- Klaus Guntermann, July 1992
% Version 2.4 [p5b] --- Hans-Hermann Bode, July 1992
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
% Copyright (C) 1993,1994 Andreas Scherer
@z
------------------------------------------------------------------------------
@x l.25
\def\title{CTANGLE (Version 3.1)}
@y
\def\title{CTANGLE (Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.29
  \centerline{(Version 3.1)}
@y
  \centerline{(Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.33
Copyright \copyright\ 1987, 1990, 1993 Silvio Levy and Donald E. Knuth
@y
Copyright \copyright\ 1987, 1990, 1993 Silvio Levy and Donald E. Knuth
\smallskip\noindent
Copyright \copyright\ 1991--1993 Hans-Hermann Bode
\smallskip\noindent
Copyright \copyright\ 1993, 1994 Andreas Scherer
@z
------------------------------------------------------------------------------
Activate this, if only the changed modules should be printed.
x l.46
\let\maybe=\iftrue
y
\let\maybe=\iffalse
z
------------------------------------------------------------------------------
TRANSLATION
@x l.59
@d banner "This is CTANGLE (Version 3.1)\n"
@y
@d banner get_string(MSG_BANNER_CT1)
@z
------------------------------------------------------------------------------
ANSI
@x l.69
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
@x l.89
int main (ac, av)
int ac;
char **av;
@y
int main (int ac, char **av)
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.95
  @<Set initial values@>;
  common_init();
@y
  common_init();
  @<Set initial values@>;
@z
------------------------------------------------------------------------------
PORTABILITY, SYSTEM DEPENDENCIES
@x l.124
@i common.h
@y
@i comm-p.h
@^system dependencies@>
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.151
  eight_bits *tok_start; /* pointer into |tok_mem| */
@y
  eight_bits HUGE *tok_start; /* pointer into |tok_mem| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.157
text text_info[max_texts];
text_pointer text_info_end=text_info+max_texts-1;
@y
text *text_info;
text_pointer text_info_end;
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, PORTABILITY
@x l.160
eight_bits tok_mem[max_toks];
eight_bits *tok_mem_end=tok_mem+max_toks-1;
eight_bits *tok_ptr; /* first unused position in |tok_mem| */
@y
eight_bits HUGE *tok_mem;
eight_bits HUGE *tok_mem_end;
eight_bits HUGE *tok_ptr; /* first unused position in |tok_mem| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION, SYSTEM DEPENDENCIES
@x l.165
text_info->tok_start=tok_ptr=tok_mem;
@y
alloc_object(section_text,longest_name+1,char);
section_text_end = section_text + longest_name;
alloc_object(text_info,max_texts,text);
text_info_end = text_info + max_texts - 1;
#ifdef __TURBOC__
tok_mem=allocsafe(max_toks,sizeof(*tok_mem));
#else
alloc_object(tok_mem,max_toks,eight_bits);
#endif
tok_mem_end = tok_mem + max_toks - 1;
text_info->tok_start=tok_ptr=tok_mem;
alloc_object(stack,stack_size+1,output_state);
stack_end = stack + stack_size;
@^system dependencies@>
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.175
name_dir->equiv=(char *)text_info; /* the undefined section has no replacement text */
@y
name_dir->equiv=(void HUGE *)text_info; /* the undefined section has no replacement text */
@z
------------------------------------------------------------------------------
ANSI
@x l.181
int names_match(p,first,l)
name_pointer p; /* points to the proposed match */
char *first; /* position of first character of string */
int l; /* length of identifier */
@y
int names_match(name_pointer p,char *first,int l,eight_bits dummy)
/* |p|: points to the proposed match */
/* |first|: position of first character of string */
/* |l|: length of identifier */
/* |dummy|: not used by \.{TANGLE} */
@z
------------------------------------------------------------------------------
ANSI
@x l.196
void
init_node(node)
name_pointer node;
@y
void init_node(name_pointer node)
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.200
    node->equiv=(char *)text_info;
@y
    node->equiv=(void HUGE *)text_info;
@z
------------------------------------------------------------------------------
ANSI
@x l.202
void
init_p() {}
@y
void init_p(name_pointer dummy1,eight_bits dummy2)
{}
@z
------------------------------------------------------------------------------
ANSI
@x l.258
void
store_two_bytes(x)
sixteen_bits x;
@y
static void store_two_bytes(sixteen_bits x)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.262
  if (tok_ptr+2>tok_mem_end) overflow("token");
@y
  if (tok_ptr+2>tok_mem_end) overflow(get_string(MSG_OVERFLOW_CT26));
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.295
  eight_bits *end_field; /* ending location of replacement text */
  eight_bits *byte_field; /* present location within replacement text */
@y
  eight_bits HUGE *end_field; /* ending location of replacement text */
  eight_bits HUGE *byte_field; /* present location within replacement text */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.312
output_state stack[stack_size+1]; /* info for non-current levels */
stack_pointer stack_ptr; /* first unused location in the output state stack */
stack_pointer stack_end=stack+stack_size; /* end of |stack| */
@y
output_state *stack; /* info for non-current levels */
stack_pointer stack_ptr; /* first unused location in the output state stack */
stack_pointer stack_end; /* end of |stack| */
@z
------------------------------------------------------------------------------
ANSI, TRANSLATION
@x l.334
void
push_level(p) /* suspends the current level */
name_pointer p;
{
  if (stack_ptr==stack_end) overflow("stack");
@y
static void push_level(name_pointer p) /* suspends the current level */
{
  if (stack_ptr==stack_end) overflow(get_string(MSG_OVERFLOW_CT30));
@z
------------------------------------------------------------------------------
ANSI
@x l.353
void
pop_level(flag) /* do this when |cur_byte| reaches |cur_end| */
int flag; /* |flag==0| means we are in |output_defs| */
@y
static void pop_level(int flag) /* do this when |cur_byte| reaches |cur_end| */
@z
------------------------------------------------------------------------------
ANSI
@x l.389
void
get_output() /* sends next token to |out_char| */
@y
static void get_output(void) /* sends next token to |out_char| */
@z
------------------------------------------------------------------------------
PORTABILITY, TRANSLATION
@x l.423
  if ((a+name_dir)->equiv!=(char *)text_info) push_level(a+name_dir);
  else if (a!=0) {
    printf("\n! Not present: <");
@y
  if ((a+name_dir)->equiv!=(void HUGE *)text_info) push_level(a+name_dir);
  else if (a!=0) {
    printf(get_string(MSG_ERROR_CT34));
@z
------------------------------------------------------------------------------
ANSI
@x l.476
void
flush_buffer() /* writes one line to output file */
@y
static void flush_buffer(void) /* writes one line to output file */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.497
name_pointer output_files[max_files];
name_pointer *cur_out_file, *end_output_files, *an_output_file;
char cur_section_name_char; /* is it |'<'| or |'('| */
char output_file_name[longest_name]; /* name of the file */

@ We make |end_output_files| point just beyond the end of
|output_files|. The stack pointer
|cur_out_file| starts out there. Every time we see a new file, we
decrement |cur_out_file| and then write it in.
@<Set initial...@>=
cur_out_file=end_output_files=output_files+max_files;
@y
name_pointer *output_files;
name_pointer *cur_out_file, *end_output_files, *an_output_file;
char cur_section_name_char; /* is it |'<'| or |'('| */
char *output_file_name; /* name of the file */

@ We make |end_output_files| point just beyond the end of
|output_files|. The stack pointer
|cur_out_file| starts out there. Every time we see a new file, we
decrement |cur_out_file| and then write it in.

@<Set initial...@>=
alloc_object(output_files,max_files,name_pointer);
alloc_object(output_file_name,longest_name,char);
cur_out_file=end_output_files=output_files+max_files;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.519
    overflow("output files");
@y
    overflow(get_string(MSG_OVERFLOW_CT40));
@z
------------------------------------------------------------------------------
ANSI
@x l.526
@<Predecl...@>=
void phase_two();

@ @c
void
phase_two () {
@y
@<Predecl...@>=
static void phase_two(void);

@ @c
static void phase_two (void) {
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.537
    printf("\n! No program text was specified."); mark_harmless;
@y
    printf(get_string(MSG_WARNING_CT42)); mark_harmless;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.543
        printf("\nWriting the output file (%s):",C_file_name);
@y
        printf(get_string(MSG_PROGRESS_CT42_1),C_file_name);
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.547
        printf("\nWriting the output files:");
@y
        printf(get_string(MSG_PROGRESS_CT42_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.557
    if(show_happiness) printf("\nDone.");
@y
    if(show_happiness) printf(get_string(MSG_PROGRESS_CT42_3));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.571
    if (C_file ==0) fatal("! Cannot open output file:",output_file_name);
@y
    if (C_file ==0) fatal(get_string(MSG_FATAL_CO78),output_file_name);
@z
------------------------------------------------------------------------------
ANSI
@x l.595
@ @<Predecl...@>=
void output_defs();

@ @c
void
output_defs()
@y
@ @<Predecl...@>=
static void output_defs(void);

@ @c
static void output_defs(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.623
          else if (a<050000) { confusion("macro defs have strange char");}
@y
          else if (a<050000) { confusion(get_string(MSG_CONFUSION_CT47));}
@z
------------------------------------------------------------------------------
ANSI, PORTABILITY
@x l.641
@<Predecl...@>=
void out_char();

@ @c
void
out_char(cur_char)
eight_bits cur_char;
{
  char *j, *k; /* pointer into |byte_mem| */
@y
@<Predecl...@>=
static void out_char(eight_bits);

@ @c
static void out_char(eight_bits cur_char)
{
  char HUGE *j;
  char HUGE *k; /* pointer into |byte_mem| */
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.700
char translit[128][translit_length];

@ @<Set init...@>=
{
  int i;
  for (i=0;i<128;i++) sprintf(translit[i],"X%02X",(unsigned)(128+i));
}
@y
char **translit;

@ @<Set init...@>=
{
  int i;
  alloc_object(translit,128,char *);
  for(i=0; i<128; i++)
    alloc_object(translit[i],translit_length,char);
  for (i=0;i<128;i++)
    sprintf(translit[i],"X%02X",(unsigned)(128+i));
}
@z
------------------------------------------------------------------------------
MEMORY ALLOCATION
@x l.776
eight_bits ccode[256]; /* meaning of a char following \.{@@} */

@ @<Set ini...@>= {
  int c; /* must be |int| so the |for| loop will end */
@y
eight_bits *ccode; /* meaning of a char following \.{@@} */

@ @<Set ini...@>= {
  int c; /* must be |int| so the |for| loop will end */
  alloc_object(ccode,256,eight_bits);
@z
------------------------------------------------------------------------------
ANSI
@x l.800
eight_bits
skip_ahead() /* skip to next control code */
@y
static eight_bits skip_ahead(void) /* skip to next control code */
@z
------------------------------------------------------------------------------
@x l.829
No comment, long or short, is allowed to contain `\.{@@ }' or `\.{@@*}'.
@y
No comment, long or short, is allowed to contain `\.{@@\ }' or `\.{@@*}'.
@z
------------------------------------------------------------------------------
ANSI
@x l.835
int skip_comment(is_long_comment) /* skips over comments */
boolean is_long_comment;
@y
static int skip_comment(boolean is_long_comment) /* skips over comments */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.844
          err_print("! Input ended in mid-comment");
@y
          err_print(get_string(MSG_ERROR_CT60_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.857
        err_print("! Section name ended in mid-comment"); loc--;
@y
        err_print(get_string(MSG_ERROR_CT60_2)); loc--;
@z
------------------------------------------------------------------------------
ANSI
@x l.885
eight_bits
get_next() /* produces the next input token */
@y
static eight_bits get_next(void) /* produces the next input token */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1003
        err_print("! String didn't end"); loc=limit; break;
@y
        err_print(get_string(MSG_ERROR_CT67_1)); loc=limit; break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1007
        err_print("! Input ended in middle of string"); loc=buffer; break;
@y
        err_print(get_string(MSG_ERROR_CT67_2)); loc=buffer; break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1025
    printf("\n! String too long: ");
@y
    printf(get_string(MSG_ERROR_CT67_3));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1042
    case translit_code: err_print("! Use @@l in limbo only"); continue;
@y
    case translit_code: err_print(get_string(MSG_ERROR_CT68_1)); continue;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1047
        err_print("! Double @@ should be used in control text");
@y
        err_print(get_string(MSG_ERROR_CT68_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1073
        err_print("! Double @@ should be used in ASCII constant");
@y
        err_print(get_string(MSG_ERROR_CT69));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1079
        err_print("! String didn't end"); loc=limit-1; break;
@y
        err_print(get_string(MSG_ERROR_CT67_1)); loc=limit-1; break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1110
    err_print("! Input ended in section name");
@y
    err_print(get_string(MSG_ERROR_CT72_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1123
  printf("\n! Section name too long: ");
@y
  printf(get_string(MSG_ERROR_CT72_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1137
    err_print("! Section name didn't end"); break;
@y
    err_print(get_string(MSG_ERROR_CT73_1)); break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1141
    err_print("! Nesting of section names not allowed"); break;
@y
    err_print(get_string(MSG_ERROR_CT73_2)); break;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1155
  if (loc>=limit) err_print("! Verbatim string didn't end");
@y
  if (loc>=limit) err_print(get_string(MSG_ERROR_CT74));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1178
@d app_repl(c)  {if (tok_ptr==tok_mem_end) overflow("token"); *tok_ptr++=c;}
@y
@d app_repl(c)
  {if (tok_ptr==tok_mem_end)
     overflow(get_string(MSG_OVERFLOW_CT26));
   *tok_ptr++=c;}
@z
------------------------------------------------------------------------------
ANSI
@x l.1185
void
scan_repl(t) /* creates a replacement text */
eight_bits t;
@y
static void scan_repl(eight_bits t) /* creates a replacement text */
@z
------------------------------------------------------------------------------
ANSI
@x l.1196
      default: app_repl(a); /* store |a| in |tok_mem| */
@y
      case ')': /* some compilers complain about `missing space between
         macro name and its replacement list', because {\mc ANSI C} requires
         a space after the closing parenthesis */
         app_repl(a); if(t==macro) app_repl(' '); break;
      default: app_repl(a); /* store |a| in |tok_mem| */
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1199
  if (text_ptr>text_info_end) overflow("text");
@y
  if (text_ptr>text_info_end) overflow(get_string(MSG_OVERFLOW_CT76));
@z
------------------------------------------------------------------------------
ANSI
@x l.1214
{int a=id_lookup(id_first,id_loc)-name_dir; app_repl((a / 0400)+0200);
@y
{int a=id_lookup(id_first,id_loc,' ')-name_dir; app_repl((a / 0400)+0200);
@z
------------------------------------------------------------------------------
ANSI
@x l.1218
case identifier: a=id_lookup(id_first,id_loc)-name_dir;
@y
case identifier: a=id_lookup(id_first,id_loc,' ')-name_dir;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1240
    err_print("! @@d, @@f and @@c are ignored in C text"); continue;
@y
    err_print(get_string(MSG_ERROR_CT78)); continue;
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1250
  if (*try_loc=='=') err_print ("! Missing `@@ ' before a named section");
@y
  if (*try_loc=='=') err_print (get_string(MSG_ERROR_CT79));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1261
      else err_print("! Double @@ should be used in string");
@y
      else err_print(get_string(MSG_ERROR_CT80));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1308
    default: err_print("! Unrecognized escape sequence");
@y
    default: err_print(get_string(MSG_ERROR_CT81));
@z
------------------------------------------------------------------------------
ANSI
@x l.1335
void
scan_section()
@y
static void scan_section(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1382
    err_print("! Definition flushed, must start with identifier");
@y
    err_print(get_string(MSG_ERROR_CT85));
@z
------------------------------------------------------------------------------
ANSI
@x l.1386
  app_repl(((a=id_lookup(id_first,id_loc)-name_dir) / 0400)+0200);
@y
  app_repl(((a=id_lookup(id_first,id_loc,' ')-name_dir) / 0400)+0200);
@z
------------------------------------------------------------------------------
PORTABILITY
@x l.1422
else if (p->equiv==(char *)text_info) p->equiv=(char *)cur_text;
@y
else if (p->equiv==(void HUGE *)text_info) p->equiv=(void HUGE *)cur_text;
@z
------------------------------------------------------------------------------
ANSI
@x l.1433
@ @<Predec...@>=
void phase_one();

@ @c
void
phase_one() {
@y
@ @<Predec...@>=
static void phase_one(void);

@ @c
static void phase_one(void) {
@z
------------------------------------------------------------------------------
ANSI
@x l.1451
@<Predecl...@>=
void skip_limbo();

@ @c
void
skip_limbo()
@y
@<Predecl...@>=
static void skip_limbo(void);

@ @c
static void skip_limbo(void)
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1472
            err_print("! Double @@ should be used in control text");
@y
            err_print(get_string(MSG_ERROR_CT68_2));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1476
        default: err_print("! Double @@ should be used in limbo");
@y
        default: err_print(get_string(MSG_ERROR_CT93));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1488
    err_print("! Improper hex number following @@l");
@y
    err_print(get_string(MSG_ERROR_CT94_1));
@z
------------------------------------------------------------------------------
TRANSLATION
@x l.1498
      err_print("! Replacement string in @@l too long");
@y
      err_print(get_string(MSG_ERROR_CT94_2));
@z
------------------------------------------------------------------------------
ANSI
@x l.1501
      strncpy(translit[i-0200],beg,loc-beg);
@y
      strncpy(translit[i-0200],beg,(size_t)(loc-beg));
@z
------------------------------------------------------------------------------
ANSI, TRANSLATION
@x l.1506
@ Because on some systems the difference between two pointers is a |long|
but not an |int|, we use \.{\%ld} to print these quantities.

@c
void
print_stats() {
  printf("\nMemory usage statistics:\n");
  printf("%ld names (out of %ld)\n",
          (long)(name_ptr-name_dir),(long)max_names);
  printf("%ld replacement texts (out of %ld)\n",
          (long)(text_ptr-text_info),(long)max_texts);
  printf("%ld bytes (out of %ld)\n",
          (long)(byte_ptr-byte_mem),(long)max_bytes);
  printf("%ld tokens (out of %ld)\n",
          (long)(tok_ptr-tok_mem),(long)max_toks);
}
@y
@ {\mc ANSI C} declares the difference between two pointers to be of type
|ptrdiff_t| which equals |long| on (almost) all systems instead of |int|,
so we use \.{\%ld} to print these quantities and cast them to |long|
explicitly.

@c
void print_stats(void) {
  printf(get_string(MSG_STATS_CT95_1));
  printf(get_string(MSG_STATS_CT95_2),
          (long)(name_ptr-name_dir),(long)max_names);
  printf(get_string(MSG_STATS_CT95_3),
          (long)(text_ptr-text_info),(long)max_texts);
  printf(get_string(MSG_STATS_CT95_4),
          (long)(byte_ptr-byte_mem),(long)max_bytes);
  printf(get_string(MSG_STATS_CT95_5),
          (long)(tok_ptr-tok_mem),(long)max_toks);
}
@z
------------------------------------------------------------------------------
ANSI, SYSTEM DEPENDENCIES
@x l.1523
@** Index.
@y
@** Function declarations.  Here are declarations---conforming to
{\mc ANSI~C}---of all functions in this code, as far as they are
not already in |"common.h"|.  These are private to \.{CTANGLE}.

@<Predecl...@>=
static eight_bits get_next(void);@/
static eight_bits skip_ahead(void);@/
static int skip_comment(boolean);@/
static void flush_buffer(void);@/
static void get_output(void);@/
static void pop_level(int);@/
static void push_level(name_pointer);@/
static void scan_repl(eight_bits);@/
static void scan_section(void);@/
static void store_two_bytes(sixteen_bits);

@* Version information.  The {\mc AMIGA} operating system provides the
`version' command and good programs answer with some informations about
their creation date and their current version.
@^system dependencies@>

@<Glob...@>=
#ifdef _AMIGA
const unsigned char *Version = "$VER: CTangle 3.1 [p9d] "__AMIGADATE__;
#endif

@** Index.
@z
------------------------------------------------------------------------------
