% This file, common.h, is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.1 -- Don Knuth, January 1992
% Version 2.1 [p5] --- Hans-Hermann Bode, July 1992
% Version 2.1 [p5a] --- Klaus Guntermann, July 1992
% Version 2.1 [p5b] --- Hans-Hermann Bode, July 1992
% Version 2.1 [p6] --- Hans-Hermann Bode, September 1992
% Version 2.1 [p6a] --- Andreas Scherer, March 1993
% Version 2.1 [p6b] --- Andreas Scherer, July 1993
% Version 2.1 [p6c] --- Andreas Scherer, September 1993
% Version 2.8 --- Don Knuth, September 1992
% Version 2.8 [p7] --- Andreas Scherer, October 1993
% Version 3.0 --- Don Knuth, June 1993
% Version 3.0 [p8c] --- Hans-Hermann Bode, June 1993
% Version 3.0 [p8d] --- Andreas Scherer, October 1993
% Version 3.0 [p8e] --- Andreas Scherer, November 1993
% Version 3.1 [p9] --- Andreas Scherer, November 1993
% Version 3.1 [p9a] --- Andreas Scherer, November 1993
% Version 3.1 [p9b] --- Andreas Scherer, December 1993
% Version 3.1 [p9c] --- Andreas Scherer, January 1994
% Version 3.1 [p9d] --- Andreas Scherer, July 1994

% Copyright (C) 1987,1990,1993 Silvio Levy and Donald E. Knuth
% Copyright (C) 1991-1993 Hans-Hermann Bode
% Copyright (C) 1991,1993 Carsten Steger
% Copyright (C) 1993,1994 Andreas Scherer

% Permission is granted to make and distribute verbatim copies of this
% document provided that the copyright notice and this permission notice
% are preserved on all copies.

% Permission is granted to copy and distribute modified versions of this
% document under the conditions for verbatim copying, provided that the
% entire resulting derived work is distributed under the terms of a
% permission notice identical to this one.

% Please send comments, suggestions, etc. to levy@@geom.umn.edu.
% If related to changes specific for MSDOS, however,
% send them to Hans-Hermann Bode,
% hhbode@@dosuni1.rz.uni-osnabrueck.de or HHBODE@@DOSUNI1.BITNET.
% If related to changes specific for AMIGA, however,
% send them to Andreas Scherer,
% Abt-Wolf-Straße 17, 96215 Lichtenfels, Germany.

% The next few sections contain stuff from the file |"common.w"| that has
% to be included in both |"ctangle.w"| and |"cweave.w"|. It appears in this
% file |"common.h"|, which needs to be updated when |"common.w"| changes.

First comes general stuff.
In {\mc TURBO} \CEE/, we use |huge| pointers instead of large arrays.
@^system dependencies@>

@f far int
@f huge int
@f HUGE int
@#
@d ctangle 0
@d cweave 1

@<Common code for \.{CWEAVE} and \.{CTANGLE}@>=
typedef short boolean;
typedef char unsigned eight_bits;
extern boolean program; /* \.{CWEAVE} or \.{CTANGLE}? */
extern int phase; /* which phase are we in? */
@#
#ifdef __TURBOC__
#define HUGE huge
#else
#define HUGE
#endif
@^system dependencies@>

@ Version~2.1 of the {\mc AMIGA} operating system introduced localization
of programs and applications by means of ``language catalogs'' that contain
replacement strings for terminal texts produced by suitably prepared programs.
The complete \.{CWEB} system has been modified to accommodate this great idea
and so the \.{cweb.h} header file with the original English strings is
included in this section.  Other systems than the {\mc AMIGA} will have to do
the language conversion by different means, so a little bit of care is to be
taken with what follows.
@^system dependencies@>

@f type int /* Aus \.{type} wird der Pseudotyp \&{type} */
@#
@d alloc_object(object,size,@!type)
   if(!(object = (type *)calloc(size,sizeof(type))))
      fatal("",get_string(MSG_FATAL_CO85));

@<Include files@>=
#include <stdio.h>
@#
#ifdef __TURBOC__
#include <io.h>
#endif
@#
#ifndef _AMIGA /* non-{\mc AMIGA} systems don't know about \.{<exec/types.h>} */
typedef long int LONG; /* excerpt from \.{<exec/types.h>} */
typedef char * STRPTR; /* ditto, but \UNIX/ says it's signed. */
#define EXEC_TYPES_H 1 /* don't include \.{<exec/types.h>} in \.{"cweb.h"} */
#endif
@#
#ifdef STRINGARRAY
#undef STRINGARRAY /* don't include the string array |AppStrings| again */
#endif
#define get_string(n) AppStrings[n].as_Str
@#
#include "cweb.h"
@#
struct AppString
{
   LONG   as_ID;
   STRPTR as_Str;
};
@#
extern struct AppString AppStrings[];

@ Code related to the character set:
@^ASCII code dependencies@>

@d and_and 04 /* `\.{\&\&}'\,; corresponds to MIT's {\tentex\char'4} */
@d lt_lt 020 /* `\.{<<}'\,;  corresponds to MIT's {\tentex\char'20} */
@d gt_gt 021 /* `\.{>>}'\,;  corresponds to MIT's {\tentex\char'21} */
@d plus_plus 013 /* `\.{++}'\,;  corresponds to MIT's {\tentex\char'13} */
@d minus_minus 01 /* `\.{--}'\,;  corresponds to MIT's {\tentex\char'1} */
@d minus_gt 031 /* `\.{->}'\,;  corresponds to MIT's {\tentex\char'31} */
@d not_eq 032 /* `\.{!=}'\,;  corresponds to MIT's {\tentex\char'32} */
@d lt_eq 034 /* `\.{<=}'\,;  corresponds to MIT's {\tentex\char'34} */
@d gt_eq 035 /* `\.{>=}'\,;  corresponds to MIT's {\tentex\char'35} */
@d eq_eq 036 /* `\.{==}'\,;  corresponds to MIT's {\tentex\char'36} */
@d or_or 037 /* `\.{\v\v}'\,;  corresponds to MIT's {\tentex\char'37} */
@d dot_dot_dot 016 /* `\.{...}'\,;  corresponds to MIT's {\tentex\char'16} */
@d colon_colon 06 /* `\.{::}'\,;  corresponds to MIT's {\tentex\char'6} */
@d period_ast 026 /* `\.{.*}'\,;  corresponds to MIT's {\tentex\char'26} */
@d minus_gt_ast 027 /* `\.{->*}'\,;  corresponds to MIT's {\tentex\char'27} */

@<Common code...@>=
char *section_text; /* name being sought for */
char *section_text_end; /* end of |section_text| */
char *id_first; /* where the current identifier begins in the buffer */
char *id_loc; /* just after the current identifier in the buffer */

@ Code related to input routines:

@d xisalpha(c) (isalpha(c)&&((eight_bits)c<0200))
@d xisdigit(c) (isdigit(c)&&((eight_bits)c<0200))
@d xisspace(c) (isspace(c)&&((eight_bits)c<0200))
@d xislower(c) (islower(c)&&((eight_bits)c<0200))
@d xisupper(c) (isupper(c)&&((eight_bits)c<0200))
@d xisxdigit(c) (isxdigit(c)&&((eight_bits)c<0200))

@<Common code...@>=
extern char *buffer; /* where each line of input goes */
extern char *buffer_end; /* end of |buffer| */
extern char *loc; /* points to the next character to be read from the buffer*/
extern char *limit; /* points to the last character in the buffer */

@ Code related to identifier and section name storage:
@d length(c) (size_t)((c+1)->byte_start-(c)->byte_start) /* the length of a name */
@d print_id(c) term_write((c)->byte_start,length((c))) /* print identifier */
@d llink link /* left link in binary search tree for section names */
@d rlink dummy.Rlink /* right link in binary search tree for section names */
@d root name_dir->rlink /* the root of the binary search tree
  for section names */
@d chunk_marker 0

@<Common code...@>=
typedef struct name_info {
  char HUGE *byte_start; /* beginning of the name in |byte_mem| */
  struct name_info HUGE *link;
  union {
    struct name_info HUGE *Rlink; /* right link in binary search tree for section
      names */
    char Ilk; /* used by identifiers in \.{WEAVE} only */
  } dummy;
  void HUGE *equiv_or_xref; /* info corresponding to names */
} name_info; /* contains information about an identifier or section name */
typedef name_info HUGE *name_pointer; /* pointer into array of |name_info|s */
typedef name_pointer *hash_pointer;
extern char HUGE *byte_mem; /* characters of names */
extern name_info HUGE *name_dir; /* information about names */
extern char HUGE *byte_mem_end; /* end of |byte_mem| */
extern name_pointer name_dir_end; /* end of |name_dir| */
extern name_pointer name_ptr; /* first unused position in |byte_start| */
extern char HUGE *byte_ptr; /* first unused position in |byte_mem| */
#ifdef __TURBOC__
void far *allocsafe(unsigned long nunits,unsigned long unitsz);
#endif
@^system dependencies@>
extern name_pointer *hash; /* heads of hash lists */
extern hash_pointer hash_end; /* end of |hash| */
extern hash_pointer h; /* index into hash-head array */
extern int names_match(name_pointer,char *,int,eight_bits);@/
extern name_pointer id_lookup(char *,char *,char);
   /* looks up a string in the identifier table */
extern name_pointer prefix_lookup(char *,char *); /* finds section name given a prefix */
extern name_pointer section_lookup(char *,char *,int);@/
extern void init_node(name_pointer);@/
extern void init_p(name_pointer,eight_bits);@/
extern void print_prefix_name(name_pointer);@/
extern void print_section_name(name_pointer);@/
extern void sprint_section_name(char *,name_pointer);@/

@ Code related to error handling:
@d spotless 0 /* |history| value for normal jobs */
@d harmless_message 1 /* |history| value when non-serious info was printed */
@d error_message 2 /* |history| value when an error was noted */
@d fatal_message 3 /* |history| value when we had to stop prematurely */
@d mark_harmless {if (history==spotless) history=harmless_message;}
@d mark_error history=error_message
@d confusion(s) fatal(get_string(MSG_FATAL_CO66),s)

@<Common...@>=
extern history; /* indicates how bad this run was */
extern int wrap_up(void); /* indicate |history| and exit */
extern void err_print(char *); /* prints error message and context */
extern void fatal(char *,char *); /* issue error message and die */
extern void overflow(char *); /* succumb because a table has overflowed */

@ Code related to file handling:
@f line x /* make |line| an unreserved word */
@d max_file_name_length 256
@d cur_file file[include_depth] /* current file */
@d cur_file_name file_name[include_depth] /* current file name */
@d web_file_name file_name[0] /* main source file name */
@d cur_line line[include_depth] /* number of current line in current file */

@<Common code...@>=
extern include_depth; /* current level of nesting */
extern FILE **file; /* stack of non-change files */
extern FILE *change_file; /* change file */
extern char *C_file_name; /* name of |C_file| */
extern char *tex_file_name; /* name of |tex_file| */
extern char *idx_file_name; /* name of |idx_file| */
extern char *scn_file_name; /* name of |scn_file| */
extern char **file_name; /* stack of non-change file names */
extern char *change_file_name; /* name of change file */
extern int *line; /* number of current line in the stacked files */
extern change_line; /* number of current line in change file */
extern boolean input_has_ended; /* if there is no more input */
extern boolean changing; /* if the current line is from |change_file| */
extern boolean web_file_open; /* if the web file is being read */
extern boolean get_line(void); /* inputs the next line */
extern void check_complete(void); /* checks that all changes were picked up */
extern void reset_input(void); /* initialize to read the web file and change file */

@ Code related to section numbers:
@<Common code...@>=
typedef unsigned short sixteen_bits;
extern sixteen_bits section_count; /* the current section number */
extern boolean *changed_section; /* is the section changed? */
extern boolean change_pending; /* is a decision about change still unclear? */
extern boolean print_where; /* tells \.{CTANGLE} to print line and file info */

@ Code related to command line arguments:
@d show_banner flags['b'] /* should the banner line be printed? */
@d show_happiness flags['h'] /* should lack of errors be announced? */
@d show_progress flags['p'] /* should progress reports be printed? */
@d use_amiga_keywords flags['a'] /* should {\mc AMIGA/SAS C} keywords be used? */
@d use_german_macros flags['g'] /* should the output be German? */
@d indent_param_decl flags['i'] /* should formal parameter declarations be indented? */
@d order_decl_stmt flags['o'] /* should declarations and statements be separated? */
@d send_error_messages flags['m'] /* should {\mc AREXX} communication be used? */

@<Common code...@>=
extern int argc; /* copy of |ac| parameter to |main| */
extern char **argv; /* copy of |av| parameter to |main| */
extern boolean flags[]; /* an option for each 8-bit code */

@ Code relating to output:
@d update_terminal fflush(stdout) /* empty the terminal output buffer */
@d new_line putchar('\n') @d putxchar putchar
@d term_write(a,b) fflush(stdout),fwrite(a,sizeof(char),b,stdout)
@d C_printf(c,a) fprintf(C_file,c,a)
@d C_putc(c) putc(c,C_file)

@<Common code...@>=
extern FILE *C_file; /* where output of \.{CTANGLE} goes */
extern FILE *tex_file; /* where output of \.{CWEAVE} goes */
extern FILE *idx_file; /* where index from \.{CWEAVE} goes */
extern FILE *scn_file; /* where list of sections from \.{CWEAVE} goes */
extern FILE *active_file; /* currently active file for \.{CWEAVE} output */

@ The procedure that gets everything rolling:

@<Common code...@>=
extern void common_init(void);
extern void print_stats(void);
