% This file is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth 
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.8 -- September 1992

% Copyright (C) 1987,1990,1991,1992 Silvio Levy and Donald E. Knuth

% Permission is granted to make and distribute verbatim copies of this
% document provided that the copyright notice and this permission notice
% are preserved on all copies.

% Permission is granted to copy and distribute modified versions of this
% document under the conditions for verbatim copying, provided that the
% entire resulting derived work is distributed under the terms of a
% permission notice identical to this one.

% Please send comments, suggestions, etc. to levy@@math.berkeley.edu.

% The next few sections contain stuff from the file |"common.w"| that has
% to be included in both |"tangle.w"| and |"weave.w"|. It appears in this
% file |"common.h"|, which needs to be updated when |"common.w"| changes.

First comes general stuff:

@d tangle 0
@d weave 1

@<Common code for \.{WEAVE} and \.{TANGLE}@>=
typedef short boolean;
typedef char unsigned eight_bits;
extern boolean program; /* \.{WEAVE} or \.{TANGLE}? */
extern int phase; /* which phase are we in? */

@ @<Include files@>=
#include <stdio.h>

@ Code related to the character set:
@^ASCII code dependencies@>

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

@<Common code...@>=
char section_text[longest_name+1]; /* name being sought for */
char *section_text_end = section_text+longest_name; /* end of |section_text| */
char *id_first; /* where the current identifier begins in the buffer */
char *id_loc; /* just after the current identifier in the buffer */

@ Code related to input routines:

@<Common code...@>=
extern char buffer[]; /* where each line of input goes */
extern char *buffer_end; /* end of |buffer| */
extern char *loc; /* points to the next character to be read from the buffer*/
extern char *limit; /* points to the last character in the buffer */

@ Code related to identifier and section name storage:
@d length(c) (c+1)->byte_start-(c)->byte_start /* the length of a name */
@d print_id(c) term_write((c)->byte_start,length((c))) /* print identifier */
@d llink link /* left link in binary search tree for section names */
@d rlink dummy.Rlink /* right link in binary search tree for section names */
@d root name_dir->rlink /* the root of the binary search tree
  for section names */
@d chunk_marker 0

@<Common code...@>=
typedef struct name_info {
  char *byte_start; /* beginning of the name in |byte_mem| */
  struct name_info *link;
  union {
    struct name_info *Rlink; /* right link in binary search tree for section
      names */  
    char Ilk; /* used by identifiers in \.{WEAVE} only */
  } dummy;
  char *equiv_or_xref; /* info corresponding to names */
} name_info; /* contains information about an identifier or section name */
typedef name_info *name_pointer; /* pointer into array of |name_info|s */
typedef name_pointer *hash_pointer;
extern char byte_mem[]; /* characters of names */
extern char *byte_mem_end; /* end of |byte_mem| */
extern name_info name_dir[]; /* information about names */
extern name_pointer name_dir_end; /* end of |name_dir| */
extern name_pointer name_ptr; /* first unused position in |byte_start| */
extern char *byte_ptr; /* first unused position in |byte_mem| */
extern name_pointer hash[]; /* heads of hash lists */
extern hash_pointer hash_end; /* end of |hash| */
extern hash_pointer h; /* index into hash-head array */
extern name_pointer id_lookup(); /* looks up a string in the identifier table */
extern name_pointer section_lookup(); /* finds section name */
extern name_pointer prefix_lookup(); /* finds section name given a prefix */

@ Code related to error handling:
@d spotless 0 /* |history| value for normal jobs */
@d harmless_message 1 /* |history| value when non-serious info was printed */
@d error_message 2 /* |history| value when an error was noted */
@d fatal_message 3 /* |history| value when we had to stop prematurely */
@d mark_harmless {if (history==spotless) history=harmless_message;}
@d mark_error history=error_message
@d confusion(s) fatal("! This can't happen: ",s)
@d fatal(s,t) {
  printf(s); err_print(t);
  history=fatal_message; wrap_up();
}
@d overflow(t) {
  printf("\n! Sorry, %s capacity exceeded",t); fatal("","");
}

@<Common...@>=
extern history; /* indicates how bad this run was */
extern err_print(); /* prints error message and context */
extern wrap_up(); /* indicate |history| and exit */

@ Code related to file handling:
@f line x /* make |line| an unreserved word */
@d max_file_name_length 60
@d cur_file file[include_depth] /* current file */
@d cur_file_name file_name[include_depth] /* current file name */
@d web_file_name file_name[0] /* main source file name */
@d cur_line line[include_depth] /* number of current line in current file */

@<Common code...@>=
extern include_depth; /* current level of nesting */
extern FILE *file[]; /* stack of non-change files */
extern FILE *change_file; /* change file */
extern char C_file_name[]; /* name of |C_file| */
extern char tex_file_name[]; /* name of |tex_file| */
extern char file_name[][max_file_name_length];
  /* stack of non-change file names */
extern char change_file_name[]; /* name of change file */
extern line[]; /* number of current line in the stacked files */
extern change_line; /* number of current line in change file */
extern boolean input_has_ended; /* if there is no more input */
extern boolean changing; /* if the current line is from |change_file| */
extern boolean web_file_open; /* if the web file is being read */
extern reset_input(); /* initialize to read the web file and change file */
extern get_line(); /* inputs the next line */
extern check_complete(); /* checks that all changes were picked up */

@ Code related to section numbers:
@<Common code...@>=
typedef unsigned short sixteen_bits;
extern sixteen_bits section_count; /* the current section number */
extern boolean changed_section[]; /* is the section changed? */
extern boolean change_pending; /* is a decision about change still unclear? */
extern boolean print_where; /* tells \.{TANGLE} to print line and file info */

@ Code related to command line arguments:
@d show_banner flags['b'] /* should the banner line be printed? */
@d show_progress flags['p'] /* should progress reports be printed? */
@d show_happiness flags['h'] /* should lack of errors be announced? */

@<Common code...@>=
extern int argc; /* copy of |ac| parameter to |main| */
extern char **argv; /* copy of |av| parameter to |main| */
extern boolean flags[]; /* an option for each 7-bit code */

@ Code relating to output:
@d update_terminal fflush(stdout) /* empty the terminal output buffer */
@d new_line putchar('\n') @d putxchar putchar
@d term_write(a,b) fflush(stdout), write(1,a,b) /* write on the standard output */
@d C_printf(c,a) fprintf(C_file,c,a)
@d C_putc(c) putc(c,C_file)

@<Common code...@>=
extern FILE *C_file; /* where output of \.{TANGLE} goes */
extern FILE *tex_file; /* where output of \.{WEAVE} goes */
