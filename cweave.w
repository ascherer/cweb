% This file is part of CWEB.
% This program by Silvio Levy is based on a program by D. E. Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 2.7 --- Don Knuth, July 1992

% Copyright (C) 1987,1990,1992 Silvio Levy and Donald E. Knuth

% Permission is granted to make and distribute verbatim copies of this
% document provided that the copyright notice and this permission notice
% are preserved on all copies.

% Permission is granted to copy and distribute modified versions of this
% document under the conditions for verbatim copying, provided that the
% entire resulting derived work is distributed under the terms of a
% permission notice identical to this one.

% Here is TeX material that gets inserted after \input webmac
\def\hang{\hangindent 3em\indent\ignorespaces}
\def\Pascal{Pascal}
\def\pb{$\.|\ldots\.|$} % C brackets (|...|)
\def\v{\char'174} % vertical (|) in typewriter font
\def\dleft{[\![} \def\dright{]\!]} % double brackets
\mathchardef\RA="3221 % right arrow
\mathchardef\BA="3224 % double arrow
\def\({} % kludge for alphabetizing certain module names
\def\Ceeref{{\sl C Reference Manual\/}}
\def\TeXxstring{\\{\TeX\_string}}
\def\skipxTeX{\\{skip\_\TeX}}
\def\copyxTeX{\\{copy\_\TeX}}

\def\title{CWEAVE (Version 2.6)}
\def\topofcontents{\null\vfill
  \centerline{\titlefont The {\ttitlefont CWEAVE} processor}
  \vskip 15pt
  \centerline{(Version 2.6)}
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

@* Introduction.
This is the \.{CWEAVE} program by Silvio Levy, based on \.{WEAVE} by
D.~E. Knuth.

The ``banner line'' defined here should be changed whenever \.{CWEAVE}
is modified.

@d banner "This is CWEAVE (Version 2.6)\n"

@ \.{CWEAVE} has a fairly straightforward outline.  It operates in
three phases: First it inputs the source file and stores cross-reference
data, then it inputs the source once again and produces the \TeX\ output
file, finally it sorts and outputs the index.  It can be compiled
with certain optional flags, |DEBUG| and |STAT|, the latter being used
to keep track of how much of \.{WEAVE}'s resources were actually used.

Please read the documentation for \.{common}, the set of routines common
to \.{TANGLE} and \.{WEAVE}, before proceeding further.

@c @<Include files@>@/
@<Common code for \.{WEAVE} and \.{TANGLE}@>@/
@<Typedef declarations@>@/
@<Global variables@>@/

main (ac, av)
int ac; /* argument count */
char **av; /* argument values */
{
  argc=ac; argv=av;
  program=weave;
  make_xrefs=force_lines=1;
  common_init();
  @<Set initial values@>;
  if (show_banner) printf(banner); /* print a ``banner line'' */
  @<Store all the reserved words@>;
  phase_one(); /* read all the user's text and store the cross-references */
  phase_two(); /* read all the text again and translate it to \TeX\ form */
  phase_three(); /* output the cross-reference index */
  wrap_up(); /* and exit gracefully */
}

@ The following parameters were sufficient in the original \.{WEAVE} to
handle \TeX, so they should be sufficient for most applications of \.{CWEAVE}.
If you change |max_bytes|, |max_names|, |hash_size| or |buf_size|
you have to change them also in the file |"common.w"|.

@d max_bytes 90000 /* the number of bytes in identifiers,
  index entries, and module names */
@d max_names 4000 /* number of identifiers, strings, module names;
  must be less than 10240; used in |"common.w"| */
@d max_modules 2000 /* greater than the total number of modules */
@d hash_size 353 /* should be prime */
@d buf_size 100 /* maximum length of input line, plus one */
@d longest_name 400 /* module names and strings shouldn't be longer than this */
@d long_buf_size 500 /* |buf_size+longest_name| */
@d line_length 80 /* lines of \TeX\ output have at most this many characters;
  should be less than 256 */
@d max_refs 20000 /* number of cross-references; must be less than 65536 */
@d max_toks 20000 /* number of symbols in \Cee\ texts being parsed;
  must be less than 65536 */
@d max_texts 2000 /* number of phrases in \Cee\ texts being parsed;
  must be less than 10240 */
@d max_scraps 1000 /* number of tokens in \Cee\ texts being parsed */
@d stack_size 400 /* number of simultaneous output levels */

@ The next few sections contain stuff from the file |"common.w"| that has
to be included in both |"tangle.w"| and |"weave.w"|. It appears in
file |"common.h"|, which needs to be updated when |"common.w"| changes.

@i common.h

@* Data structures exclusive to {\tt WEAVE}.
As explained in \.{common.w}, the field of a |name_info| structure
that contains the |rlink| of a module name is used for a completely
different purpose in the case of identifiers.  It is then called the
|ilk| of the identifier, and it is used to
distinguish between various types of identifiers, as follows:

\yskip\hang |normal| identifiers are part of the \Cee\ program and
will appear in italic type.

\yskip\hang |roman| identifiers are index entries that appear after
\.{@@\^} in the \.{WEB} file.

\yskip\hang |wildcard| identifiers are index entries that appear after
\.{@@:} in the \.{WEB} file.

\yskip\hang |typewriter| identifiers are index entries that appear after
\.{@@.} in the \.{WEB} file.

\yskip\hang |case_like|, \dots, |typedef_like|
identifiers are \Cee\ reserved words whose |ilk| explains how they are
to be treated when \Cee\ code is being formatted.

@d ilk dummy.Ilk
@d normal 0 /* ordinary identifiers have |normal| ilk */
@d roman 1 /* normal index entries have |roman| ilk */
@d wildcard 2 /* user-formatted index entries have |wildcard| ilk */
@d typewriter 3 /* `typewriter type' entries have |typewriter| ilk */
@d reserved(a) (a->ilk>typewriter) /* tells if a name is a reserved word */
@d custom 4 /* identifiers with |custom| ilk have user-given control sequence */
@d unindexed(a) (a->ilk>custom) /* tells if uses of a name are to be indexed */
@d quoted 5 /* \.{NULL} */
@d do_like 46 /* \&{do} */
@d if_like 47 /* \&{if}, \&{while}, \&{for}, \&{switch}, \&{ifdef},
\&{ifndef}, \&{endif} */
@d int_like 48 /* \&{int}, \&{char}, \&{extern}, \dots  */
@d case_like 49 /* \&{return}, \&{goto}, \&{break}, \&{continue} */
@d sizeof_like 50 /* \&{sizeof} */
@d struct_like 51 /* \&{struct} */
@d typedef_like 52 /* \&{typedef} */
@d define_like 53 /* \&{define} */
@d begin_arg 54 /* \.{@@[} */
@d end_arg 55 /* \.{@@]} */

@ We keep track of the current module number in |module_count|, which
is the total number of modules that have started.  Modules which have
been altered by a change file entry have their |changed_module| flag
turned on during the first phase.

@<Global...@>=
boolean change_exists; /* has any module changed? */

@ The other large memory area in \.{CWEAVE} keeps the cross-reference data.
All uses of the name |p| are recorded in a linked list beginning at
|p->xref|, which points into the |xmem| array. The elements of |xmem|
are structures consisting of an integer, |num|, and a pointer |xlink|
to another element of |xmem|.  If |x=p->xref| is a pointer into |xmem|,
the value of |x->num| is either a module number where |p| is used,
or it is |def_flag| plus a module number where |p| is defined;
and |x->xlink| points to the next such cross-reference for |p|,
if any. This list of cross-references is in decreasing order by
module number. The next unused slot in |xmem| is |xref_ptr|.

The global variable |xref_switch| is set either to |def_flag| or to zero,
depending on whether the next cross-reference to an identifier is to be
underlined or not in the index. This switch is set to |def_flag| when
\.{@@!} or \.{@@d} is scanned, and it is cleared to zero when
the next identifier or index entry cross-reference has been made. Similarly,
the global variable |mod_xref_switch| is either |def_flag| or zero, depending
on whether a module name is being defined or used.

@<Type...@>=
typedef struct xref_info {
  sixteen_bits num; /* module number plus zero or |def_flag| */
  struct xref_info *xlink; /* pointer to the previous cross-reference */
} xref_info;
typedef xref_info *xref_pointer;

@ @<Global...@>=
xref_info xmem[max_refs]; /* contains cross-reference information */
xref_pointer xmem_end = xmem+max_refs-1;
xref_pointer xref_ptr; /* the largest occupied position in |xmem| */
sixteen_bits xref_switch,mod_xref_switch; /* either zero or |def_flag| */

@ A module that is used for multi-file output (with the \.{@@(} feature)
has a special first cross-reference whose |num| field is |file_flag|.

@d file_flag 20480
@d def_flag 10240 /* must be strictly larger than |max_modules| */
@d xref equiv_or_xref

@<Set init...@>=
xref_ptr=xmem; name_dir->xref=(char*)xmem; xref_switch=0; mod_xref_switch=0;
xmem->num=0; /* cross-references to undefined modules */

@ A new cross-reference for an identifier is formed by calling |new_xref|,
which discards duplicate entries and ignores non-underlined references
to one-letter identifiers or \Cee's reserved words.

If the user has sent the |no_xref| flag (the \.{-x} option of the command line),
it is unnecessary to keep track of cross-references for identifiers.
If one were careful, one could probably make more changes around module
100 to avoid a lot of identifier looking up.

@d append_xref(c) if (xref_ptr==xmem_end) overflow("cross-reference")@;
  else (++xref_ptr)->num=c;
@d no_xref (flags['x']==0)
@d make_xrefs flags['x'] /* should cross references be output? */
@d force_lines flags['f'] /* should each statement be on its own line? */

@c new_xref(p)
name_pointer p;
{
  xref_pointer q; /* pointer to previous cross-reference */
  sixteen_bits m, n; /* new and previous cross-reference value */
  if (no_xref) return;
  if ((unindexed(p) || length(p)==1) && xref_switch==0) return;
  m=module_count+xref_switch; xref_switch=0; q=(xref_pointer)p->xref;
  if (q != xmem) {
    n=q->num;
    if (n==m || n==m+def_flag) return;
    else if (m==n+def_flag) {
        q->num=m; return;
    }
  }
  append_xref(m); xref_ptr->xlink=q; p->xref=(char*)xref_ptr;
}

@ The cross-reference lists for module names are slightly different. Suppose
that a module name is defined in modules $m_1$, \dots, $m_k$ and used in
modules $n_1$, \dots, $n_l$. Then its list will contain $m_1+|def_flag|{}$,
$m_k+|def_flag|{}$, \dots, $m_2+|def_flag|{}$, $n_l$, \dots, $n_1$, in
this order.  After Phase II, however, the order will be
$m_1+|def_flag|{}$, \dots, $m_k+|def_flag|{}$, $n_1$, \dots, $n_l$.

@c new_mod_xref(p)
name_pointer p;
{
  xref_pointer q,r; /* pointers to previous cross-references */
  q=(xref_pointer)p->xref; r=xmem;
  if (q>xmem) {
    if (mod_xref_switch==0) while (q->num>=def_flag) {
      r=q; q=q->xlink;
    }
    else {
      if (q->num==file_flag) {
      r=q; q=q->xlink;
      }
      if (q->num>=def_flag) {
      r=q; q=q->xlink;
      }
    }
  }
  append_xref(module_count+mod_xref_switch);
  xref_ptr->xlink=q; mod_xref_switch=0;
  if (r==xmem) p->xref=(char*)xref_ptr;
  else r->xlink=xref_ptr;
}

@ The cross-reference list for a module name may also begin with
|file_flag|. Here's how that flag gets put~in.

@c set_file_flag(p)
name_pointer p;
{@+xref_pointer q;
q=(xref_pointer)p->xref;
if (q->num==file_flag) return;
append_xref(file_flag);
xref_ptr->xlink = q;
p->xref = (char *)xref_ptr;
}

@ A third large area of memory is used for sixteen-bit `tokens', which appear
in short lists similar to the strings of characters in |byte_mem|. Token lists
are used to contain the result of \Cee\ code translated into \TeX\ form;
further details about them will be explained later. A |text_pointer| variable
is an index into |tok_start|.

@<Typed...@>=
typedef sixteen_bits token;
typedef token *token_pointer;
typedef token_pointer *text_pointer;

@ The first position of |tok_mem|
that is unoccupied by replacement text is called |tok_ptr|, and the first
unused location of |tok_start| is called |text_ptr|.
Thus, we usually have |tok_start[text_ptr]=tok_ptr|.

@<Global...@>=
token tok_mem[max_toks]; /* tokens */
token_pointer tok_mem_end = tok_mem+max_toks-1; /* end of |tok_mem| */
token_pointer tok_start[max_texts]; /* directory into |tok_mem| */
token_pointer tok_ptr; /* first unused position in |tok_mem| */
text_pointer text_ptr; /* first unused position in |tok_start| */
text_pointer tok_start_end = tok_start+max_texts-1; /* end of |tok_start| */
#ifdef STAT
token_pointer max_tok_ptr; /* largest value of |tok_ptr| */
text_pointer max_text_ptr; /* largest value of |text_ptr| */
#endif STAT

@ @<Set init...@>=
tok_ptr=tok_mem+1; text_ptr=tok_start+1; tok_start[0]=tok_mem+1;
tok_start[1]=tok_mem+1;
#ifdef STAT
max_tok_ptr=tok_mem+1; max_text_ptr=tok_start+1;
#endif STAT

@ Here are the three procedures needed to complete |id_lookup|:
@c names_match(p,first,l,t)
name_pointer p; /* points to the proposed match */
char *first; /* position of first character of string */
int l; /* length of identifier */
eight_bits t; /* desired ilk */
{
  if (length(p)!=l) return 0;
  if (p->ilk!=t && !(t==normal && reserved(p))) return 0;
  return !strncmp(first,p->byte_start,l);
}

init_p(p,t)
name_pointer p;
eight_bits t;
{
  p->ilk=t; p->xref=(char*)xmem;
}

init_node(p)
name_pointer p;
{
  p->xref=(char*)xmem;
}

@ We have to get \Cee's
reserved words into the hash table, and the simplest way to do this is
to insert them every time \.{CWEAVE} is run.  Fortunately there are relatively
few reserved words. (Some of these are not strictly ``reserved,'' but
are defined in header files of the ISO Standard \Cee\ Library.)
@^reserved words@>

@<Store all the reserved words@>=
id_lookup("auto",NULL,int_like);
id_lookup("break",NULL,case_like);
id_lookup("case",NULL,case_like);
id_lookup("char",NULL,int_like);
id_lookup("clock_t",NULL,int_like);
id_lookup("const",NULL,int_like);
id_lookup("continue",NULL,case_like);
id_lookup("default",NULL,case_like);
id_lookup("define",NULL,define_like);
id_lookup("div_t",NULL,int_like);
id_lookup("do",NULL,do_like);
id_lookup("double",NULL,int_like);
id_lookup("endif",NULL,if_like);
id_lookup("else",NULL,else_like);
id_lookup("enum",NULL,struct_like);
id_lookup("extern",NULL,int_like);
id_lookup("FILE",NULL,int_like);
id_lookup("float",NULL,int_like);
id_lookup("for",NULL,if_like);
id_lookup("fpos_t",NULL,int_like);
id_lookup("goto",NULL,case_like);
id_lookup("if",NULL,if_like);
id_lookup("ifdef",NULL,if_like);
id_lookup("ifndef",NULL,if_like);
id_lookup("int",NULL,int_like);
id_lookup("jmp_buf",NULL,int_like);
id_lookup("ldiv_t",NULL,int_like);
id_lookup("long",NULL,int_like);
id_lookup("line",NULL,if_like);
id_lookup("include",NULL,if_like);
id_lookup("offsetof",NULL,sizeof_like);
id_lookup("register",NULL,int_like);
id_lookup("return",NULL,case_like);
id_lookup("short",NULL,int_like);
id_lookup("sig_atomic_t",NULL,int_like);
id_lookup("sizeof",NULL,sizeof_like);
id_lookup("size_t",NULL,int_like);
id_lookup("static",NULL,int_like);
id_lookup("struct",NULL,struct_like);
id_lookup("switch",NULL,if_like);
id_lookup("time_t",NULL,int_like);
id_lookup("typedef",NULL,typedef_like);
id_lookup("union",NULL,struct_like);
id_lookup("undef",NULL,if_like);
id_lookup("unsigned",NULL,int_like);
id_lookup("while",NULL,if_like);
id_lookup("void",NULL,int_like);
id_lookup("va_dcl",NULL,decl); /* Berkeley's variable-arg-list convention */
id_lookup("va_list",NULL,int_like); /* ditto */
id_lookup("wchar_t",NULL,int_like);
id_lookup("NULL",NULL,quoted);
id_lookup("TeX",NULL,custom);

@* Lexical scanning.
Let us now consider the subroutines that read the \.{WEB} source file
and break it into meaningful units. There are four such procedures:
One simply skips to the next `\.{@@\ }' or `\.{@@*}' that begins a
module; another passes over the \TeX\ text at the beginning of a
module; the third passes over the \TeX\ text in a \Cee\ comment;
and the last, which is the most interesting, gets the next token of
a \Cee\ text.  They all use the pointers |limit| and |loc| into
the line of input currently being studied.

@ Control codes in \.{WEB}, which begin with `\.{@@}', are converted
into a numeric code designed to simplify \.{CWEAVE}'s logic; for example,
larger numbers are given to the control codes that denote more significant
milestones, and the code of |new_module| should be the largest of
all. Some of these numeric control codes take the place of |char|
control codes that will not otherwise appear in the output of the
scanning routines.
@^ASCII code dependencies@>

@d ignore 00 /* control code of no interest to \.{CWEAVE} */
@d verbatim 02 /* takes the place of extended ASCII \.{\char2} */
@d begin_comment '\t' /* tab marks will not appear */
@d underline '\n' /* this code will be intercepted without confusion */
@d noop 0177 /* takes the place of ASCII delete */
@d xref_roman 0203 /* control code for `\.{@@\^}' */
@d xref_wildcard 0204 /* control code for `\.{@@:}' */
@d xref_typewriter 0205 /* control code for `\.{@@.}' */
@d TeX_string 0206 /* control code for `\.{@@t}' */
@f TeX_string TeX
@d ord 0207 /* control code for `\.{@@'}' */
@d join 0210 /* control code for `\.{@@\&}' */
@d thin_space 0211 /* control code for `\.{@@,}' */
@d math_break 0212 /* control code for `\.{@@\v}' */
@d line_break 0213 /* control code for `\.{@@/}' */
@d big_line_break 0214 /* control code for `\.{@@\#}' */
@d no_line_break 0215 /* control code for `\.{@@+}' */
@d pseudo_semi 0216 /* control code for `\.{@@;}' */
@d macro_arg_open 0220 /* control code for `\.{@@[}' */
@d macro_arg_close 0221 /* control code for `\.{@@]}' */
@d trace 0222 /* control code for `\.{@@0}', `\.{@@1}' and `\.{@@2}' */
@d format_code 0223 /* control code for `\.{@@f}' and `\.{@@s}' */
@d definition 0224 /* control code for `\.{@@d}' */
@d begin_C 0225 /* control code for `\.{@@c}' */
@d module_name 0226 /* control code for `\.{@@<}' */
@d new_module 0227 /* control code for `\.{@@\ }' and `\.{@@*}' */

@ Control codes are converted to \.{CWEAVE}'s internal
representation by means of the table |ccode|.

@<Global...@>=
eight_bits ccode[128]; /* meaning of a char following \.{@@} */

@ @<Set ini...@>=
{int c; for (c=0; c<=127; c++) ccode[c]=0;}
ccode[' ']=ccode['\t']=ccode['\n']=ccode['\v']=ccode['\r']=ccode['\f']
   =ccode['*']=new_module;
ccode['@@']='@@'; /* `quoted' at sign */
ccode['=']=verbatim;
ccode['d']=ccode['D']=definition;
ccode['f']=ccode['F']=ccode['s']=ccode['S']=format_code;
ccode['c']=ccode['C']=ccode['p']=ccode['P']=begin_C;
ccode['t']=ccode['T']=TeX_string;
ccode['q']=ccode['Q']=noop;
ccode['&']=join; ccode['<']=ccode['(']=module_name;
ccode['!']=underline; ccode['^']=xref_roman;
ccode[':']=xref_wildcard; ccode['.']=xref_typewriter; ccode[',']=thin_space;
ccode['|']=math_break; ccode['/']=line_break; ccode['#']=big_line_break;
ccode['+']=no_line_break; ccode[';']=pseudo_semi;
ccode['[']=macro_arg_open; ccode[']']=macro_arg_close;
ccode['\'']=ord;
@<Special control codes allowed only when debugging@>@;

@ If \.{CWEAVE} is compiled with debugging commands, one can write
\.{@@2}, \.{@@1}, and \.{@@0} to turn tracing fully on, partly on,
and off, respectively.

@<Special control codes...@>=
#ifdef DEBUG
ccode['0']=ccode['1']=ccode['2']=trace;
#endif DEBUG

@ The |skip_limbo| routine is used on the first pass to skip through
portions of the input that are not in any modules, i.e., that precede
the first module. After this procedure has been called, the value of
|input_has_ended| will tell whether or not a module has actually been found.

@c skip_limbo() {
  while(1) {
    if (loc>limit && get_line()==0) return;
    *(limit+1)='@@';
    while (*loc!='@@') loc++; /* look for '@@', then skip two chars */
    if (loc++ <=limit) if (ccode[*loc++]==new_module) return;
  }
}

@ The |skip_TeX| routine is used on the first pass to skip through
the \TeX\ code at the beginning of a module. It returns the next
control code or `\.{\v}' found in the input. A |new_module| is
assumed to exist at the very end of the file.

@f skip_TeX TeX

@c unsigned skip_TeX() /* skip past pure \TeX\ code */
{
  while (1) {
    if (loc>limit && get_line()==0) return(new_module);
    *(limit+1)='@@';
    while (*loc!='@@' && *loc!='|') loc++;
    if (*loc++ =='|') return('|');
    if (loc<=limit) return(ccode[*(loc++)]);
  }
}

@* Inputting the next token.
As stated above, \.{WEAVE}'s most interesting lexical scanning routine is the
|get_next| function that inputs the next token of \Cee\ input. However,
|get_next| is not especially complicated.

The result of |get_next| is either a |char| code for some special character,
or it is a special code representing a pair of characters (e.g., `\.{!=}'),
or it is the numeric value computed by the |ccode|
table, or it is one of the following special codes:

\yskip\hang |identifier|: In this case the global variables |id_first| and
|id_loc| will have been set to the beginning and ending-plus-one locations
in the buffer, as required by the |id_lookup| routine.

\yskip\hang |string|: The string will have been copied into the array
|mod_text|; |id_first| and |id_loc| are set as above (now they are
pointers into |mod_text|).

\yskip\hang |constant|: The constant is copied into |mod_text|, with
slight modifications; |id_first| and |id_loc| are set.

\yskip\noindent Furthermore, some of the control codes cause
|get_next| to take additional actions:

\yskip\hang |xref_roman|, |xref_wildcard|, |xref_typewriter|, |TeX_string|,
|verbatim|: The values of |id_first| and |id_loc| will have been set to
the beginning and ending-plus-one locations in the buffer.

\yskip\hang |module_name|: In this case the global variable |cur_module| will
point to the |byte_start| entry for the module name that has just been scanned.
The value of |cur_module_char| will be |'('| if the module name was
preceded by \.{@@(} instead of \.{@@<}.

\yskip\noindent If |get_next| sees `\.{@@!}'
it sets |xref_switch| to |def_flag| and goes on to the next token.

@d constant 0200 /* \Cee\ string or \.{WEB} precomputed string */
@d string 0201 /* \Cee\ string or \.{WEB} precomputed string */
@d identifier 0202 /* \Cee\ identifier or reserved word */

@<Global...@>=
name_pointer cur_module; /* name of module just scanned */
char cur_module_char; /* the character just before that name */

@ @<Include...@>=
#include "ctype.h"

@ As one might expect, |get_next| consists mostly of a big switch
that branches to the various special cases that can arise.

@d isxalpha(c) ((c)=='_') /* non-alpha character allowed in identifier */

@c eight_bits get_next() /* produces the next input token */
{@+eight_bits c; /* the current character */
  while (1) {
    @<Check if we're at the end of a preprocessor command@>;
    if (loc>limit && get_line()==0) return(new_module);
    c=*(loc++);
    if (isdigit(c) || c=='\\' || c=='.') @<Get a constant@>@;
    else if (isalpha(c) || isxalpha(c)) @<Get an identifier@>@;
    else if (c=='\'' || c=='"' || (c=='<' && sharp_include_line==1)) @<Get a string@>@;
    else if (c=='@@') @<Get control code and possible module name@>@;
    else if (isspace(c)) continue; /* ignore spaces and tabs */
    if (c=='#' && loc==buffer+1) @<Raise preprocessor flag@>;
    mistake: @<Compress two-symbol operator@>@;
    return(c);
  }
}

@ Because preprocessor commands do not fit in with the rest of the syntax of C,
we have to deal with them separately.  One solution is to enclose such
commands between special markers.  Thus, when a \.\# is seen as the
first character of a line, |get_next| returns a special code
\\{left\_preproc} and raises a flag |preprocessing|.

@d left_preproc 0207 /* begins a preprocessor command */
@d right_preproc 0217 /* ends a preprocessor command */

@<Glob...@>=
boolean preprocessing=0; /* are we scanning a preprocessor command? */

@ @<Raise prep...@>= {
  preprocessing=1;
  @<Check if next token is |include|@>;
  return (left_preproc);
}

@ An additional complication is the freakish use of \.< and \.> to delimit
a file name in lines that start with \.{\#include}.  We must treat this file
name as a string.

@<Glob...@>=
boolean sharp_include_line=0; /* are we scanning a |#include| line? */

@ @<Check if next token is |include|@>=
while (loc<=buffer_end-7 & isspace(*loc)) loc++;
if (loc<=buffer_end-6 && strncmp(loc,"include",7)==0) sharp_include_line=1;

@ When we get to the end of a preprocessor line,
we lower the flag and send a code \\{right\_preproc}, unless
the last character was a \.\\. 

@<Check if we're at...@>=
  while (loc==limit-1 && preprocessing && *loc=='\\')
    if (get_line()==0) return(new_module); /* still in preprocessor mode */
  if (loc>=limit && preprocessing) {
    preprocessing=sharp_include_line=0;
    return(right_preproc);
  }

@ The following code assigns values to the combinations \.{++},
\.{--}, \.{->}, \.{>=}, \.{<=}, \.{==}, \.{<<}, \.{>>}, \.{!=}, \.{\v\v}, and
\.{\&\&}.  The compound assignment operators (e.g., \.{+=}) are 
separate tokens, according to the
\Ceeref.

@d compress(c) if (loc++<=limit) return(c)

@<Compress tw...@>=
switch(c) {
  case '/': if (*loc=='*') compress(begin_comment); break;
  case '+': if (*loc=='+') compress(plus_plus); break;
  case '-': if (*loc=='-') {compress(minus_minus);}
    else if (*loc=='>') compress(minus_gt); break;
  case '=': if (*loc=='=') compress(eq_eq); break;
  case '>': if (*loc=='=') {compress(gt_eq);}
    else if (*loc=='>') compress(gt_gt); break;
  case '<': if (*loc=='=') {compress(lt_eq);}
    else if (*loc=='<') compress(lt_lt); break;
  case '&': if (*loc=='&') compress(and_and); break;
  case '|': if (*loc=='|') compress(or_or); break;
  case '!': if (*loc=='=') compress(not_eq); break;
}

@ @<Get an identifier@>= {
  id_first=--loc;
  while (isalpha(*++loc) || isdigit(*loc) || isxalpha(*loc));
  id_loc=loc; return(identifier);
}

@ Different conventions are followed by \TeX\ and \Cee\ to express octal
and hexadecimal numbers; it is reasonable to stick to each convention
within its realm.  Thus the \Cee\ part of a \.{WEB} file has octals
introduced by \.0 and hexadecimals by \.{0x}, but \.{WEAVE} will print
in italics or typewriter font, respectively, and introduced by single
or double quotes.  In order to simplify the \TeX\ macro used to print 
such constants, we replace some of the characters.

Notice that in this section and the next, |id_first| and |id_loc|
are pointers into the array |mod_text|, not into |buffer|.

@<Get a constant@>= {
  id_first=id_loc=mod_text+1;
  if (*(loc-1)=='\\') {*id_loc++='~';
  while (isdigit(*loc)) *id_loc++=*loc++;} /* octal constant */
  else if (*(loc-1)=='0') {
    if (*loc=='x' || *loc=='X') {*id_loc++='^'; loc++;
      while (isxdigit(*loc)) *id_loc++=*loc++;} /* hex constant */
    else if (isdigit(*loc)) {*id_loc++='~';
      while (isdigit(*loc)) *id_loc++=*loc++;} /* octal constant */
    else goto dec; /* decimal constant */
  }
  else { /* decimal constant */
    if (*(loc-1)=='.' && !isdigit(*loc)) goto mistake; /* not a constant */
    dec: *id_loc++=*(loc-1);
    while (isdigit(*loc) || *loc=='.') *id_loc++=*loc++;
    if (*loc=='e' || *loc=='E') { /* float constant */
      *id_loc++='_'; loc++;
      if (*loc=='+' || *loc=='-') *id_loc++=*loc++;
      while (isdigit(*loc)) *id_loc++=*loc++;
    }
  }
  if (*loc=='l' || *loc=='L') {*id_loc++='$'; loc++;}
  return(constant);
}

@ \Cee\ strings and character constants, delimited by double and single
quotes, respectively, can contain newlines or instances of their own
delimiters if they are protected by a backslash.  We follow this
convention, but do not allow the string to be longer than |longest_name|.

@<Get a string@>= {
  char delim = c; /* what started the string */
  id_first = mod_text+1;
  id_loc = mod_text;
  if (delim=='\'' && *(loc-2)=='@@') {*++id_loc='@@'; *++id_loc='@@';}
  *++id_loc=delim;
  if (delim=='<') delim='>'; /* for file names in |#include| lines */
  while (1) {
    if (loc>=limit) {
      if(*(limit-1)!='\\') {
        err_print("! String didn't end"); loc=limit; break;
@.String didn't end@>
      }
      if(get_line()==0) {
        err_print("! Input ended in middle of string"); loc=buffer; break;
@.Input ended in middle of string@>
      }
    }
    if ((c=*loc++)==delim) {
      if (++id_loc<=mod_text_end) *id_loc=c;
      break;
    }
    if (c=='\\') if (loc>=limit) continue;
      else if (++id_loc<=mod_text_end) {
        *id_loc = '\\'; c=*loc++;
      }
    if (++id_loc<=mod_text_end) *id_loc=c;
  }
  if (id_loc>=mod_text_end) {
    printf("\n! String too long: ");
@.String too long@>
    term_write(mod_text+1,25);
    printf("..."); mark_error;
  }
  id_loc++;
  return(string);
}

@ After an \.{@@} sign has been scanned, the next character tells us
whether there is more work to do.

@<Get control code and possible module name@>= {
  c=*loc++;
  switch(ccode[c]) {
    case underline: xref_switch=def_flag; continue;
#ifdef DEBUG
    case trace: tracing=c-'0'; continue;
#endif DEBUG
    case xref_roman: case xref_wildcard: case xref_typewriter:
    case noop: case TeX_string: @<Scan to the next \.{@@>}@>;
    case module_name:
      @<Scan the module name and make |cur_module| point to it@>;
    case verbatim: @<Scan a verbatim string@>;
    case ord: @<Get a string@>;
    default: return(ccode[c]);
  }
}

@ The occurrence of a module name sets |xref_switch| to zero,
because the module name might (for example) follow \&{int}.

@<Scan the module name...@>= {
  char *k; /* pointer into |mod_text| */
  cur_module_char=*(loc-1);
  @<Put module name into |mod_text|@>;
  if (k-mod_text>3 && strncmp(k-2,"...",3)==0) cur_module=prefix_lookup(mod_text+1,k-3);
  else cur_module=mod_lookup(mod_text+1,k);
  xref_switch=0; return(module_name);
}

@ Module names are placed into the |mod_text| array with consecutive spaces,
tabs, and carriage-returns replaced by single spaces. There will be no
spaces at the beginning or the end. (We set |mod_text[0]=' '| to facilitate
this, since the |mod_lookup| routine uses |mod_text[1]| as the first
character of the name.)

@<Set init...@>=mod_text[0]=' ';

@ @<Put module name...@>=
k=mod_text;
while (1) {
  if (loc>limit && get_line()==0) {
    err_print("! Input ended in section name");
@.Input ended in section name@>
    loc=buffer+1; break;
  }
  c=*loc;
  @<If end of name, |break|@>;
  loc++; if (k<mod_text_end) k++;
  if (isspace(c)) {
    c=' '; if (*(k-1)==' ') k--;
  }
*k=c;
}
if (k>=mod_text_end) {
  printf("\n! Section name too long: ");
@.Section name too long@>
  term_write(mod_text+1,25);
  printf("..."); mark_harmless;
}
if (*k==' ' && k>mod_text) k--;

@ @<If end of name,...@>=
if (c=='@@') {
  c=*(loc+1);
  if (c=='>') {
    loc+=2; break;
  }
  if (ccode[c]==new_module) {
    err_print("! Section name didn't end"); break;
@.Section name didn't end@>
  }
  *(++k)='@@'; loc++; /* now |c==*loc| again */
}

@ @<Scan to the next...@>= {
  c=ccode[*(loc-1)]; id_first=loc; *(limit+1)='@@';
  while (*loc!='@@') loc++;
  id_loc=loc;
  if (loc++>limit) {
    err_print("! Control text didn't end"); loc=limit; return(c);
@.Control text didn't end@>
  }
  if (*loc++!='>') err_print("! Control codes are forbidden in control text");
@.Control codes are forbidden...@>
  return(c);
}

@ At the present point in the program we
have |*(loc-1)=verbatim|; we set |id_first| to the beginning
of the string itself, and |id_loc| to its ending-plus-one location in the
buffer.  We also set |loc| to the position just after the ending delimiter.

@<Scan a verbatim string@>= {
  id_first=loc++; *(limit+1)='@@'; *(limit+2)='>';
  while (*loc!='@@' || *(loc+1)!='>') loc++;
  if (loc>=limit) err_print("! Verbatim string didn't end");
@.Verbatim string didn't end@>
  id_loc=loc; loc+=2;
  return (verbatim);
}

@* Phase one processing.
We now have accumulated enough subroutines to make it possible to carry out
\.{WEAVE}'s first pass over the source file. If everything works right,
both phase one and phase two of \.{WEAVE} will assign the same numbers to
modules, and these numbers will agree with what \.{TANGLE} does.

The global variable |next_control| often contains the most recent output of
|get_next|; in interesting cases, this will be the control code that
ended a module or part of a module.

@<Global...@>=
eight_bits next_control; /* control code waiting to be acting upon */

@ The overall processing strategy in phase one has the following
straightforward outline.

@c phase_one() {
phase=1; reset_input(); module_count=0;
skip_limbo(); change_exists=0;
while (!input_has_ended)
  @<Store cross-reference data for the current module@>;
changed_module[module_count]=change_exists;
  /* the index changes if anything does */
phase=2; /* prepare for second phase */
@<Print error messages about unused or undefined module names@>;
}

@ @<Store cross-reference data...@>=
{
  if (++module_count==max_modules) overflow("section number");
  changed_module[module_count]=changing;
     /* it will become 1 if any line changes */
  if (*(loc-1)=='*' && show_progress) {
    printf("*%d",module_count);
    update_terminal; /* print a progress report */
  }
  @<Store cross-references in the \TeX\ part of a module@>;
  @<Store cross-references in the definition part of a module@>;
  @<Store cross-references in the \Cee\ part of a module@>;
  if (changed_module[module_count]) change_exists=1;
}

@ The |C_xref| subroutine stores references to identifiers in
\Cee\ text material beginning with the current value of |next_control|
and continuing until |next_control| is `\.\{' or `\.{\v}', or until the next
``milestone'' is passed (i.e., |next_control>=format_code|). If
|next_control>=format_code| when |C_xref| is called, nothing will happen;
but if |next_control="|"| upon entry, the procedure assumes that this is
the `\.{\v}' preceding \Cee\ text that is to be processed.

The program uses the fact that our internal code numbers satisfy
the relations |xref_roman=identifier+roman| and |xref_wildcard=identifier
+wildcard| and |xref_typewriter=identifier+typewriter| and |normal=0|.

@c C_xref() /* makes cross-references for \Cee\ identifiers */
{
  name_pointer p; /* a referenced name */
  while (next_control<format_code) {
    if (next_control>=identifier && next_control<=xref_typewriter) {
      p=id_lookup(id_first, id_loc,next_control-identifier); new_xref(p);
    }
    next_control=get_next();
    if (next_control=='|' || next_control==begin_comment) return;
  }
}

@ The |outer_xref| subroutine is like |C_xref| except that it begins
with |next_control!='|'| and ends with |next_control>=format_code|. Thus, it
handles \Cee\ text with embedded comments.

@c outer_xref() /* extension of |C_xref| */
{
  int bal; /* brace level in comment */
  while (next_control<format_code)
    if (next_control!=begin_comment) C_xref();
    else {
      bal=copy_comment(1); next_control='|';
      while (bal>0) {
        C_xref();
        if (next_control=='|') bal=copy_comment(bal);
        else bal=0; /* an error message will occur in phase two */
      }
    }
}

@ In the \TeX\ part of a module, cross-reference entries are made only for
the identifiers in \Cee\ texts enclosed in \pb, or for control texts
enclosed in \.{@@\^}$\,\ldots\,$\.{@@>} or \.{@@.}$\,\ldots\,$\.{@@>}
or \.{@@:}$\,\ldots\,$\.{@@>}.

@<Store cross-references in the \T...@>=
while (1) {
  switch (next_control=skip_TeX()) {
    case underline: xref_switch=def_flag; continue;
#ifdef DEBUG
    case trace: tracing=*(loc-1)-'0'; continue;
#endif DEBUG
    case '|': C_xref(); break;
    case xref_roman: case xref_wildcard: case xref_typewriter:
    case noop: case module_name:
      loc-=2; next_control=get_next(); /* scan to \.{@@>} */
      if (next_control!=module_name && next_control!=noop)
        new_xref(id_lookup(id_first, id_loc,next_control-identifier));
      break;
  }
  if (next_control>=format_code) break;
}

@ During the definition and \Cee\ parts of a module, cross-references
are made for all identifiers except reserved words. However, the right
identifier in a format definition is not referenced, and the left
identifier is referenced only if it has been explicitly
underlined (preceded by \.{@@!}).
The \TeX\ code in comments is, of course, ignored, except for
\Cee\ portions enclosed in \pb; the text of a module name is skipped
entirely, even if it contains \pb\ constructions.

The variables |lhs| and |rhs| point to the respective identifiers involved
in a format definition.

@<Global...@>=
name_pointer lhs, rhs; /* pointers to |byte_start| for format identifiers */

@ When we get to the following code we have |next_control>=format_code|.

@<Store cross-references in the d...@>=
while (next_control<=definition) { /* |format_code| or |definition| */
  if (next_control==definition) {
    xref_switch=def_flag; /* implied \.{@@!} */
    next_control=get_next();
  } else @<Process a format definition@>;
  outer_xref();
}

@ Error messages for improper format definitions will be issued in phase
two. Our job in phase one is to define the |ilk| of a properly formatted
identifier, and to remove cross-references to identifiers that we now
discover should be unindexed.

@<Process a form...@>= {
  next_control=get_next();
  if (next_control==identifier) {
    lhs=id_lookup(id_first, id_loc,normal); lhs->ilk=normal;
    if (xref_switch) new_xref(lhs);
    next_control=get_next();
    if (next_control==identifier) {
      rhs=id_lookup(id_first, id_loc,normal);
      lhs->ilk=rhs->ilk;
      if (unindexed(lhs)) { /* retain only underlined entries */
        xref_pointer q,r=NULL;
        for (q=(xref_pointer)lhs->xref;q>xmem;q=q->xlink)
          if (q->num<def_flag)
            if (r) r->xlink=q->xlink;
            else lhs->xref=(char*)q->xlink;
          else r=q;
      }
      next_control=get_next();
    }
  }
}

@ Finally, when the \TeX\ and definition parts have been treated, we have
|next_control>=begin_C|.

@<Store cross-references in the \Cee...@>=
if (next_control<=module_name) {  /* |begin_C| or |module_name| */
  if (next_control==begin_C) mod_xref_switch=0;
  else {
    mod_xref_switch=def_flag;
    if(cur_module_char=='(' && cur_module!=name_dir) set_file_flag(cur_module);
  }
  do {
    if (next_control==module_name && cur_module!=name_dir) new_mod_xref(cur_module);
    next_control=get_next(); outer_xref();
  } while ( next_control<=module_name);
}

@ After phase one has looked at everything, we want to check that each
module name was both defined and used.  The variable |cur_xref| will point
to cross-references for the current module name of interest.

@<Global...@>=
xref_pointer cur_xref; /* temporary cross-reference pointer */
boolean an_output; /* did |file_flag| precede |cur_xref|? */

@ The following recursive procedure
walks through the tree of module names and prints out anomalies.
@^recursion@>

@c mod_check(p) name_pointer p; /* print anomalies in subtree |p| */
{
  if (p) {
    mod_check(p->llink);
    cur_xref=(xref_pointer)p->xref;
    if (cur_xref->num==file_flag) {an_output=1; cur_xref=cur_xref->xlink;}
    else an_output=0;
    if (cur_xref->num <def_flag) {
      printf("\n! Never defined: <"); print_id(p); putchar('>'); mark_harmless;
@.Never defined: <section name>@>
    }
    while (cur_xref->num >=def_flag) cur_xref=cur_xref->xlink;
    if (cur_xref==xmem && !an_output) {
      printf("\n! Never used: <"); print_id(p); putchar('>'); mark_harmless;
@.Never used: <section name>@>
    }
    mod_check(p->rlink);
  }
}

@ @<Print error messages about un...@>=mod_check(root)

@* Low-level output routines.
The \TeX\ output is supposed to appear in lines at most |line_length|
characters long, so we place it into an output buffer. During the output
process, |out_line| will hold the current line number of the line about to
be output.

@<Global...@>=
char out_buf[line_length+1]; /* assembled characters */
char *out_ptr; /* just after last character in |out_buf| */
char *out_buf_end = out_buf+line_length; /* end of |out_buf| */
int out_line; /* number of next line to be output */

@ The |flush_buffer| routine empties the buffer up to a given breakpoint,
and moves any remaining characters to the beginning of the next line.
If the |per_cent| parameter is 1 a |'%'| is appended to the line
that is being output; in this case the breakpoint |b| should be strictly
less than |out_buf_end|. If the |per_cent| parameter is |0|,
trailing blanks are suppressed.
The characters emptied from the buffer form a new line of output;
if the |carryover| parameter is true, a |"%"| in that line will be
carried over to the next line (so that \TeX\ will ignore the completion
of commented-out text).

The same caveat that applies to |term_write| applies to |c_line_write|.

@d c_line_write(c) fflush(tex_file),write(fileno(tex_file),out_buf+1,c)
@d tex_putc(c) putc(c,tex_file)
@d tex_new_line putc('\n',tex_file)
@d tex_printf(c) fprintf(tex_file,c)

@c flush_buffer(b,per_cent,carryover)
char *b;  /* outputs from |out_buf+1| to |b|,where |b<=out_ptr| */
boolean per_cent,carryover;
{
  char *j; j=b; /* pointer into |out_buf| */
  if (! per_cent) /* remove trailing blanks */
    while (j>out_buf && *j==' ') j--;
  c_line_write(j-out_buf);
  if (per_cent) tex_putc('%');
  tex_new_line; out_line++;
  if (carryover)
    while (j>out_buf)
      if (*j--=='%' && (j==out_buf || *j!='\\')) {
        *b--='%'; break;
      }
  if (b<out_ptr) strncpy(out_buf+1,b+1,out_ptr-b);
  out_ptr-=b-out_buf;
}

@ When we are copying \TeX\ source material, we retain line breaks
that occur in the input, except that an empty line is not
output when the \TeX\ source line was nonempty. For example, a line
of the \TeX\ file that contains only an index cross-reference entry
will not be copied. The |finish_line| routine is called just before
|get_line| inputs a new line, and just after a line break token has
been emitted during the output of translated \Cee\ text.

@c finish_line() /* do this at the end of a line */
{
  char *k; /* pointer into |buffer| */
  if (out_ptr>out_buf) flush_buffer(out_ptr,0,0);
  else {
    for (k=buffer; k<=limit; k++)
      if (!(isspace(*k))) return;
    flush_buffer(out_buf,0,0);
  }
}

@ In particular, the |finish_line| procedure is called near the very
beginning of phase two. We initialize the output variables in a slightly
tricky way so that the first line of the output file will be
`\.{\\input cwebmac}'.

@<Set init...@>=
out_ptr=out_buf+1; out_line=1; *out_ptr='c'; tex_printf("\\input cwebma");

@ When we wish to append one character |c| to the output buffer, we write
`|out(c)|'; this will cause the buffer to be emptied if it was already
full.  If we want to append more than one character at once, we say
|out_str(s)|, where |s| is a string containing the characters,
or |out_str_del(s,t)|, where |s| and |t| point to the same array of
characters; characters from |s| to |t-1|, inclusive, are output.

A line break will occur at a space or after a single-nonletter
\TeX\ control sequence.

@d out(c) {if (out_ptr>=out_buf_end) break_out(); *(++out_ptr)=c;}

@c out_str_del(s,t) /* output characters from |s| to |t-1| */
char *s, *t;
{
  while (s<t) out(*s++);
}

out_str(s) /* output characters from |s| to end of string */
char *s;
{
  while (*s) out(*s++);
}

@ The |break_out| routine is called just before the output buffer is about
to overflow. To make this routine a little faster, we initialize position
0 of the output buffer to `\.\\'; this character isn't really output.

@<Set init...@>=
out_buf[0]='\\';

@ A long line is broken at a blank space or just before a backslash that isn't
preceded by another backslash. In the latter case, a |'%'| is output at
the break.

@c break_out() /* finds a way to break the output line */
{
  char *k=out_ptr; /* pointer into |out_buf| */
  while (1) {
    if (k==out_buf) @<Print warning message, break the line, |return|@>;
    if (*k==' ') {
      flush_buffer(k,0,1); return;
    }
    if (*(k--)=='\\' && *k!='\\') { /* we've decreased |k| */
      flush_buffer(k,1,1); return;
    }
  }
}

@ We get to this module only in the unusual case that the entire output line
consists of a string of backslashes followed by a string of nonblank
non-backslashes. In such cases it is almost always safe to break the
line by putting a |'%'| just before the last character.

@<Print warning message...@>=
{
  printf("\n! Line had to be broken (output l. %d):\n",out_line);
@.Line had to be broken@>
  term_write(out_buf+1, out_ptr-out_buf-1);
  new_line; mark_harmless;
  flush_buffer(out_ptr-1,1,1); return;
}

@ Here is a macro that outputs a module number in decimal notation.
The number to be converted by |out_mod| is known to be less than
|def_flag|, so it cannot have more than five decimal digits.  If
the module is changed, we output `\.{\\*}' just after the number.

@c out_mod(n) sixteen_bits n;
{
  char s[6];
  sprintf(s,"%d",n); out_str(s);
  if(changed_module[n]) out_str ("\\*");
@.\\*@>
}

@ The |out_name| procedure is used to output an identifier or index
entry, enclosing it in braces.

@c out_name(p) name_pointer p; {
  char *k, *k_end=(p+1)->byte_start; /* pointers into |byte_mem| */
  out('{');
  for (k=p->byte_start; k<k_end; k++) {
    if (isxalpha(*k)) out('\\');
    out(*k);
  }
  out('}');
}

@* Routines that copy \TeX\ material.
During phase two, we use subroutines |copy_limbo|, |copy_TeX|, and
|copy_comment| in place of the analogous |skip_limbo|, |skip_TeX|, and
|skip_comment| that were used in phase one. (Well, |copy_comment|
was actually written in such a way that it functions as a |skip_comment| routine
in phase one.)


The |copy_limbo| routine, for example, takes \TeX\ material that is not
part of any module and transcribes it almost verbatim to the output file.
No `\.{@@}' signs should occur in such material except in `\.{@@@@}'
pairs; such pairs are replaced by singletons.

@c copy_limbo()
{
  char c;
  while (1) {
    if (loc>limit && (finish_line(), get_line()==0)) return;
    *(limit+1)='@@';
    while (*loc!='@@') out(*(loc++));
    if (loc++<=limit) {
      c=*loc++;
      if (ccode[c]==new_module) break;
      if (c!='z' && c!='Z') {
        out('@@');
        if (c!='@@') err_print("! Double @@ required outside of sections");
@.Double {\AT} required...@>
      }
    }
  }
}


@ The |copy_TeX| routine processes the \TeX\ code at the beginning of a
module; for example, the words you are now reading were copied in this
way. It returns the next control code or `\.{\v}' found in the input.
We don't copy spaces or tab marks into the beginning of a line. This
makes the test for empty lines in |finish_line| work.

@ @f copy_TeX TeX
@c eight_bits copy_TeX()
{
  char c; /* current character being copied */
  while (1) {
    if (loc>limit && (finish_line(), get_line()==0)) return(new_module);
    *(limit+1)='@@';
    while ((c=*(loc++))!='|' && c!='@@') {
      out(c);
      if (out_ptr==out_buf+1 && (isspace(c))) out_ptr--;
    }
    if (c=='|') return('|');
    if (loc<=limit) return(ccode[*(loc++)]);
  }
}

@ The |copy_comment| function issues a warning if more braces are opened than
closed, and in the case of a more serious error it supplies enough
braces to keep \TeX\ from complaining about unbalanced braces.
Instead of copying the \TeX\ material
into the output buffer, this function copies it into the token memory
(in phase two only).
The abbreviation |app_tok(t)| is used to append token |t| to the current
token list, and it also makes sure that it is possible to append at least
one further token without overflow.

@d app_tok(c) {if (tok_ptr+2>tok_mem_end) overflow("token"); *(tok_ptr++)=c;}

@c copy_comment(bal) /* copies \TeX\ code in comments */
int bal; /* brace balance */
{
  char c; /* current character being copied */
  while (1) {
    if (loc>limit) if (get_line()==0) {
        err_print("! Input ended in mid-comment");
@.Input ended in mid-comment@>
        loc=buffer+1; goto done;
      }
    c=*(loc++);
    if (c=='|') return(bal);
    @<Check for end of comment@>;
    if (phase==2) app_tok(c);
    @<Copy special things when |c=='@@', '\\'|@>;
    if (c=='{') bal++;
    else if (c=='}') {
      if(bal>1) bal--;
      else {err_print("! Extra } in comment");
@.Extra \} in comment@>
        if (phase==2) tok_ptr--;
      }
    }
  }
done:@<Clear |bal| and |return|@>;
}

@ @<Check for end of comment@>=
if (c=='*' && *loc=='/') {
  loc++;
  if (bal>1) err_print("! Missing } in comment");
@.Missing \} in comment@>
  goto done;
}

@ @<Copy special things when |c=='@@'...@>=
if (c=='@@') {
  if (*(loc++)!='@@') {
    err_print("! Illegal use of @@ in comment");
@.Illegal use of {\AT}...@>
    loc-=2; if (phase==2) *(tok_ptr-1)=' '; goto done;
  }
}
else if (c=='\\' && *loc!='@@')
  if (phase==2) app_tok(*(loc++)) else loc++;

@ We output
enough right braces to keep \TeX\ happy.

@<Clear |bal|...@>=
if (phase==2) while (bal-- >0) app_tok('}');
return(0);

@* Parsing.
The most intricate part of \.{WEAVE} is its mechanism for converting
\Cee-like code into \TeX\ code, and we might as well plunge into this
aspect of the program now. A ``bottom up'' approach is used to parse the
\Cee-like material, since \.{WEAVE} must deal with fragmentary
constructions whose overall ``part of speech'' is not known.

At the lowest level, the input is represented as a sequence of entities
that we shall call {\it scraps}, where each scrap of information consists
of two parts, its {\it category} and its {\it translation}. The category
is essentially a syntactic class, and the translation is a token list that
represents \TeX\ code. Rules of syntax and semantics tell us how to
combine adjacent scraps into larger ones, and if we are lucky an entire
\Cee\ text that starts out as hundreds of small scraps will join
together into one gigantic scrap whose translation is the desired \TeX\
code. If we are unlucky, we will be left with several scraps that don't
combine; their translations will simply be output, one by one.

The combination rules are given as context-sensitive productions that are
applied from left to right. Suppose that we are currently working on the
sequence of scraps $s_1\,s_2\ldots s_n$. We try first to find the longest
production that applies to an initial substring $s_1\,s_2\ldots\,$; but if
no such productions exist, we find to find the longest production
applicable to the next substring $s_2\,s_3\ldots\,$; and if that fails, we
try to match $s_3\,s_4\ldots\,$, etc.

A production applies if the category codes have a given pattern. For
example, one of the productions (see rule~3) is
$$\hbox{|exp| |binop| |exp| $\RA$ |exp|}$$
and it means that three consecutive scraps whose respective categories are
|exp|, |binop|, and |exp| are converted to one scrap whose category
is |exp|.  The translations of the original
scraps are simply concatenated.  The case of
$$\hbox{|exp| |comma| |exp| $\RA$ |exp|} \hskip4emE_1C\,\\{opt}9\,E_2$$
(rule 4) is only slightly more complicated: here the resulting |exp| translation
consists not only of the three original translations, but also of the
tokens |opt| and 9 between the translations of the
|comma| and the following |exp|.
In the \TeX\ file, this will specify an optional line break after the
comma, with penalty 90.

At each opportunity the longest possible production is applied.
For example, if the current sequence of scraps is |struct_like|
|exp| |lbrace| this is transformed into a |struct_head| by rule
33, but if the sequence is 
|struct_like| |exp| followed by anything other than |lbrace| only
two scraps are used (by rule 34) to form an |int_like|.

Translation rules such as `$E_1C\,\\{opt}9\,E_2$' above use subscripts
to distinguish between translations of scraps whose categories have the
same initial letter; these subscripts are assigned from left to right.

@ Here is a list of the category codes that scraps can have.

@d exp 1 /* denotes an expression, including perhaps a single identifier */
@d unop 2 /* denotes a unary operator */
@d binop 3 /* denotes a binary operator */
@d unorbinop 4
  /* denotes an operator that can be unary or binary, depending on context */
@d cast 5 /* denotes a cast */
@d question 6 /* denotes a question mark and possibly the expressions flanking it */
@d lbrace 7 /* denotes a left brace */
@d rbrace 8 /* denotes a right brace */
@d decl_head 9 /* denotes an incomplete declaration */
@d comma 10 /* denotes a comma */
@d lpar 11 /* denotes a left parenthesis or left bracket */
@d rpar 12 /* denotes a right parenthesis or right bracket */
@d struct_head 21 /* denotes the beginning of a structure specifier */
@d decl 20 /* denotes a complete declaration */
@d stmt 23 /* denotes a complete statement */
@d function 24 /* denotes a complete function */
@d fn_decl 25 /* denotes a function declarator */
@d else_like 26 /* denotes the beginning of a conditional */
@d if_head 30 /* denotes the beginning of a conditional */
@d semi 27 /* denotes a semicolon */
@d colon 28 /* denotes a colon */
@d tag 29 /* denotes a statement label */
@d lproc 35 /* begins a preprocessor command */
@d rproc 36 /* ends a preprocessor command */
@d insert 37 /* a scrap that gets combined with its predecessor */
@d mod_scrap 38 /* module name */
@d dead 39 /* scrap that won't combine */

@<Glo...@>=
#ifdef DEBUG
char cat_name[256][12];
eight_bits cat_index;
#endif DEBUG

@ @<Set in...@>=
#ifdef DEBUG
    for (cat_index=0;cat_index<255;cat_index++)
      strcpy(cat_name[cat_index],"UNKNOWN");
    strcpy(cat_name[exp],"exp");
    strcpy(cat_name[stmt],"stmt");
    strcpy(cat_name[decl],"decl");
    strcpy(cat_name[decl_head],"decl_head");
    strcpy(cat_name[struct_head],"struct_head");
    strcpy(cat_name[function],"function");
    strcpy(cat_name[fn_decl],"fn_decl");
    strcpy(cat_name[else_like],"else_like");
    strcpy(cat_name[if_head],"if_head");
    strcpy(cat_name[unop],"unop");
    strcpy(cat_name[binop],"binop");
    strcpy(cat_name[unorbinop],"unorbinop");
    strcpy(cat_name[semi],";");
    strcpy(cat_name[colon],":");
    strcpy(cat_name[comma],",");
    strcpy(cat_name[question],"?");
    strcpy(cat_name[tag],"tag");
    strcpy(cat_name[cast],"cast");
    strcpy(cat_name[lpar],"(");
    strcpy(cat_name[rpar],")");
    strcpy(cat_name[lbrace],"{");
    strcpy(cat_name[rbrace],"}");
    strcpy(cat_name[lproc],"#{");
    strcpy(cat_name[rproc],"#}");
    strcpy(cat_name[insert],"insert");
    strcpy(cat_name[define_like],"define");
    strcpy(cat_name[do_like],"do");
    strcpy(cat_name[if_like],"if");
    strcpy(cat_name[int_like],"int");
    strcpy(cat_name[case_like],"case");
    strcpy(cat_name[sizeof_like],"sizeof");
    strcpy(cat_name[struct_like],"struct");
    strcpy(cat_name[typedef_like],"typedef");
    strcpy(cat_name[mod_scrap],"mod");
    strcpy(cat_name[dead],"@@d");
    strcpy(cat_name[begin_arg],"@@[");
    strcpy(cat_name[end_arg],"@@]");
    strcpy(cat_name[0],"zero");
#endif DEBUG

@ When \.{CWEAVE} is compiled with the |DEBUG| switch, it can display its
parsing steps.

@c
#ifdef DEBUG
print_cat(c) /* symbolic printout of a category */
eight_bits c;
{
  printf(cat_name[c]);
}
#endif DEBUG

@ The token lists for translated \TeX\ output contain some special control
symbols as well as ordinary characters. These control symbols are
interpreted by \.{WEAVE} before they are written to the output file.

\yskip\hang |break_space| denotes an optional line break or an en space;

\yskip\hang |force| denotes a line break;

\yskip\hang |big_force| denotes a line break with additional vertical space;

\yskip\hang |preproc_line| denotes that the line will be printed flush left;

\yskip\hang |opt| denotes an optional line break (with the continuation
line indented two ems with respect to the normal starting position)---this
code is followed by an integer |n|, and the break will occur with penalty
$10n$;

\yskip\hang |backup| denotes a backspace of one em;

\yskip\hang |cancel| obliterates any |break_space|, |opt|, |force|, or
|big_force| tokens that immediately precede or follow it and also cancels any
|backup| tokens that follow it;

\yskip\hang |indent| causes future lines to be indented one more em;

\yskip\hang |outdent| causes future lines to be indented one less em.

\yskip\noindent All of these tokens are removed from the \TeX\ output that
comes from \Cee\ text between \pb\ signs; |break_space| and |force| and
|big_force| become single spaces in this mode. The translation of other
\Cee\ texts results in \TeX\ control sequences \.{\\1}, \.{\\2},
\.{\\3}, \.{\\4}, \.{\\5}, \.{\\6}, \.{\\7}, \.{\\8}
corresponding respectively to
|indent|, |outdent|, |opt|, |backup|, |break_space|, |force|,
|big_force| and |preproc_line|.
However, a sequence of consecutive `\.\ ', |break_space|,
|force|, and/or |big_force| tokens is first replaced by a single token
(the maximum of the given ones).

The token |math_rel| will be translated into
\.{\\mathrel\{}, and it will get a matching \.\} later.
Other control sequences in the \TeX\ output will be `\.{\\\\\{}$\,\ldots\,$\.\}'
surrounding identifiers, `\.{\\\&\{}$\,\ldots\,$\.\}' surrounding
reserved words, `\.{\\.\{}$\,\ldots\,$\.\}' surrounding strings,
`\.{\\C\{}$\,\ldots\,$\.\}$\,$|force|' surrounding comments, and
`\.{\\X$n$:}$\,\ldots\,$\.{\\X}' surrounding module names, where
|n| is the module number.

@d math_rel 0206
@d big_cancel 0210 /* like |cancel|, also overrides spaces */
@d cancel 0211 /* overrides |backup|, |break_space|, |force|, |big_force| */
@d indent 0212 /* one more tab (\.{\\1}) */
@d outdent 0213 /* one less tab (\.{\\2}) */
@d opt 0214 /* optional break in mid-statement (\.{\\3}) */
@d backup 0215 /* stick out one unit to the left (\.{\\4}) */
@d break_space 0216 /* optional break between statements (\.{\\5}) */
@d force 0217 /* forced break between statements (\.{\\6}) */
@d big_force 0220 /* forced break with additional space (\.{\\7}) */
@d preproc_line 0221 /* forced break with additional space (\.{\\8}) */
@d end_translation 0222 /* special sentinel token at end of list */

@ The raw input is converted into scraps according to the following table,
which gives category codes followed by the translations.
\def\stars {\.{**}}%
The symbol `\stars' stands for `\.{\\\&\{{\rm identifier}\}}',
i.e., the identifier itself treated as a reserved word.
The right-hand column is the so-called |mathness|, which is explained
further below.

An identifier |c| of length 1 is translated as \.{\\\v c} instead of
as \.{\\\\\{c\}}. An identifier \.{CAPS} in all caps is translated as
\.{\\.\{CAPS\}} instead of as \.{\\\\\{CAPS\}}. An identifier that has
become a reserved word via |typedef| is translated with \.{\\\&} replacing
\.{\\\\} and |int_like| replacing |exp|.

A string of length greater than 20 is broken into pieces of size at most~20
with discretionary breaks in between.

\yskip\halign{\quad#\hfil&\quad#\hfil&\quad\hfil#\hfil\cr
\.{!=}&|binop|: \.{\\I}&yes\cr
\.{<=}&|binop|: \.{\\le}&yes\cr
\.{>=}&|binop|: \.{\\G}&yes\cr
\.{==}&|binop|: \.{\\E}&yes\cr
\.{\&\&}&|binop|: \.{\\W}&yes\cr
\.{\v\v}&|binop|: \.{\\V}&yes\cr
\.{++}&|binop|: \.{\\PP}&yes\cr
\.{--}&|binop|: \.{\\MM}&yes\cr
\.{->}&|binop|: \.{\\MG}&yes\cr
\.{>>}&|binop|: \.{\\GG}&yes\cr
\.{<<}&|binop|: \.{\\LL}&yes\cr
\."string\."&|exp|: \.{\\.\{}string with special characters quoted\.\}&maybe\cr
\.{@@=}string\.{@@>}&|exp|: \.{\\vb\{}string with special characters
  quoted\.\}&maybe\cr
\.{@@'7'}&|exp|: \.{\\.\{@@'7'\}}&maybe\cr
\.{077} or \.{\\77}&|exp|: \.{\\T\{\\\~77\}}&maybe\cr
\.{0x7f}&|exp|: \.{\\T\{\\\^7f\}}&maybe\cr
\.{77}&|exp|: \.{\\T\{77\}}&maybe\cr
\.{77L}&|exp|: \.{\\T\{77\\\$\}}&maybe\cr
\.{0.1E5}&|exp|: \.{\\T\{0.1\\\_5\}}&maybe\cr
\.+&|unorbinop|: \.+&yes\cr
\.-&|unorbinop|: \.-&yes\cr
\.*&|unorbinop|: \.*&yes\cr
\./&|binop|: \./&yes\cr
\.<&|binop|: \.<&yes\cr
\.=&|binop|: \.{\\K}&yes\cr
\.>&|binop|: \.>&yes\cr
\..&|binop|: \..&yes\cr
\.{\v}&|binop|: \.{\\OR}&yes\cr
\.\^&|binop|: \.{\\XOR}&yes\cr
\.\%&|binop|: \.{\\MOD}&yes\cr
\.?&|question|: \.{\\?}&yes\cr
\.!&|unop|: \.{\\R}&yes\cr
\.\~&|unop|: \.{\\CM}&yes\cr
\.\&&|unorbinop|: \.{\\AND}&yes\cr
\.(&|lpar|: \.(&maybe\cr
\.[&|lpar|: \.[&maybe\cr
\.)&|rpar|: \.)&maybe\cr
\.]&|rpar|: \.]&maybe\cr
\.\{&|lbrace|: \.\{&yes\cr
\.\}&|lbrace|: \.\}&yes\cr
\.,&|comma|: \.,&yes\cr
\.;&|semi|: \.;&maybe\cr
\.:&|colon|: \.:&maybe\cr
\.\# (within line)&|insert|: \.{\\\#}&maybe\cr
\.\# (at beginning)&|lproc|:  |force| |preproc_line| \.{\\\#}&no\cr
end of \.\# line&|rproc|:  |force|&no\cr
identifier&|exp|: \.{\\\\\{}identifier with underlines quoted\.\}&maybe\cr
\.{auto}&|int_like|: \stars&maybe\cr
\.{break}&|case_like|: \stars&maybe\cr
\.{case}&|case_like|: \stars&maybe\cr
\.{char}&|int_like|: \stars&maybe\cr
\.{continue}&|case_like|: \stars&maybe\cr
\.{default}&|case_like|: \stars&maybe\cr
\.{define}&|define_like|: \stars&maybe\cr
\.{do}&|do_like|: \stars&maybe\cr
\.{double}&|int_like|: \stars&maybe\cr
\.{endif}&|if_like|: \stars&maybe\cr
\.{else}&|else_like|: \stars&maybe\cr
\.{enum}&|struct_like|: \stars&maybe\cr
\.{extern}&|int_like|: \stars&maybe\cr
\.{FILE}&|int_like|: \stars&maybe\cr
\.{float}&|int_like|: \stars&maybe\cr
\.{for}&|if_like|: \stars&maybe\cr
\.{goto}&|case_like|: \stars&maybe\cr
\.{if}&|if_like|: \stars&maybe\cr
\.{ifdef}&|if_like|: \stars&maybe\cr
\.{ifndef}&|if_like|: \stars&maybe\cr
\.{include}&|if_like|: \stars&maybe\cr
\.{int}&|int_like|: \stars&maybe\cr
\.{long}&|int_like|: \stars&maybe\cr
\.{line}&|if_like|: \stars&maybe\cr
\.{NULL}&|exp|: \.{\\NULL}&yes\cr
\.{register}&|int_like|: \stars&maybe\cr
\.{return}&|case_like|: \stars&maybe\cr
\.{short}&|int_like|: \stars&maybe\cr
\.{sizeof}&|sizeof_like|: \stars&maybe\cr
\.{static}&|int_like|: \stars&maybe\cr
\.{struct}&|struct_like|: \stars&maybe\cr
\.{switch}&|if_like|: \stars&maybe\cr
\.{TeX}&|exp|: \.{\\TeX}&yes\cr
\.{typedef}&|typedef_like|: \stars&maybe\cr
\.{union}&|struct_like|: \stars&maybe\cr
\.{undef}&|if_like|: \stars&maybe\cr
\.{unsigned}&|int_like|: \stars&maybe\cr
\.{va\_dcl}&|decl|: \stars&maybe\cr
\.{va\_list}&|int_like|: \stars&maybe\cr
\.{while}&|if_like|: \stars&maybe\cr
\.{void}&|int_like|: \stars&maybe\cr
\.{@@,}&|insert|: \.{\\,}&maybe\cr
\.{@@\v}&|insert|:  |opt| \.0&maybe\cr
\.{@@/}&|insert|:  |force|&no\cr
\.{@@\#}&|insert|:  |big_force|&no\cr
\.{@@+}&|insert|:  |big_cancel| \.{\{\}} |break_space|
  \.{\{\}} |big_cancel|&no\cr
\.{@@;}&|semi|: &maybe\cr
\.{@@[}&|begin_arg|: &maybe\cr
\.{@@]}&|end_arg|: &maybe\cr
\.{@@\&}&|insert|: \.{\\J}&maybe\cr
\.{@@t}\thinspace stuff\/\thinspace\.{@@>}&|exp|: \.{\\hbox\{}\thinspace
 stuff\/\thinspace\.\}&maybe\cr
\.{@@<}\thinspace module name\thinspace\.{@@>}&|mod_scrap|:
 \.{\\X}$n$\.:translated module name\.{\\X}&maybe\cr
\.{@@(}\thinspace module name\thinspace\.{@@>}&|mod_scrap|:
 \.{\\X}$n$\.{:\\.\{}module name with special characters
      quoted\.{\ \}\\X}&maybe\cr
\.{/*}comment\.{*/}&|insert|: \.{\\C\{}translated comment\.\} |force|&no\cr
}

@i prod.w

@* Implementing the productions.
More specifically, a scrap is a structure consisting of a category
|cat| and a |text_pointer| |trans|, which points to the translation in
|tok_start|.  When \Cee\ text is to be processed with the grammar above,
we form an array |scrap_info| containing the initial scraps.
Our production rules have the nice property that the right-hand side is never
longer than the left-hand side. Therefore it is convenient to use sequential
allocation for the current sequence of scraps. Five pointers are used to
manage the parsing:

\yskip\hang |pp| is a pointer into |scrap_info|.  We will try to match
the category codes |pp->cat,@,@,(pp+1)->cat|$,\,\,\ldots\,$
to the left-hand sides of productions.

\yskip\hang |scrap_base|, |lo_ptr|, |hi_ptr|, and |scrap_ptr| are such that
the current sequence of scraps appears in positions |scrap_base| through
|lo_ptr| and |hi_ptr| through |scrap_ptr|, inclusive, in the |cat| and
|trans| arrays. Scraps located between |scrap_base| and |lo_ptr| have
been examined, while those in positions |>=hi_ptr| have not yet been
looked at by the parsing process.

\yskip\noindent Initially |scrap_ptr| is set to the position of the final
scrap to be parsed, and it doesn't change its value. The parsing process
makes sure that |lo_ptr>=pp+3|, since productions have as many as four terms,
by moving scraps from |hi_ptr| to |lo_ptr|. If there are
fewer than |pp+3| scraps left, the positions up to |pp+3| are filled with
blanks that will not match in any productions. Parsing stops when
|pp=lo_ptr+1| and |hi_ptr=scrap_ptr+1|.

Since the |scrap| structure will later be used for other purposes, we
declare its second element as unions.

@<Type...@>=
typedef struct {
  eight_bits cat;
  eight_bits mathness;
  union {
    text_pointer Trans;
    @<Rest of |trans_plus| union@>@;
  } trans_plus;
} scrap;
typedef scrap *scrap_pointer;

@ @d trans trans_plus.Trans /* translation texts of scraps */

@<Global...@>=
scrap scrap_info[max_scraps]; /* memory array for scraps */
scrap_pointer scrap_info_end=scrap_info+max_scraps -1; /* end of |scrap_info| */
scrap_pointer pp; /* current position for reducing productions */
scrap_pointer scrap_base; /* beginning of the current scrap sequence */
scrap_pointer scrap_ptr; /* ending of the current scrap sequence */
scrap_pointer lo_ptr; /* last scrap that has been examined */
scrap_pointer hi_ptr; /* first scrap that has not been examined */
#ifdef STAT
scrap_pointer max_scr_ptr; /* largest value assumed by |scrap_ptr| */
#endif STAT

@ @<Set init...@>=
scrap_base=scrap_info+1;
#ifdef STAT
max_scr_ptr=
#endif STAT
scrap_ptr=scrap_info;

@ Token lists in |@!tok_mem| are composed of the following kinds of
items for \TeX\ output.

\yskip\item{$\bullet$}Character codes and special codes like |force| and
|math_rel| represent themselves;

\item{$\bullet$}|id_flag+p| represents \.{\\\\\{{\rm identifier $p$}\}};

\item{$\bullet$}|res_flag+p| represents \.{\\\&\{{\rm identifier $p$}\}};

\item{$\bullet$}|mod_flag+p| represents module name |p|;

\item{$\bullet$}|tok_flag+p| represents token list number |p|;

\item{$\bullet$}|inner_tok_flag+p| represents token list number |p|, to be
translated without line-break controls.

@d id_flag 10240 /* signifies an identifier */
@d res_flag 2*id_flag /* signifies a reserved word */
@d mod_flag 3*id_flag /* signifies a module name */
@d tok_flag 4*id_flag /* signifies a token list */
@d inner_tok_flag 5*id_flag /* signifies a token list in `\pb' */

@c
#ifdef DEBUG
print_text(p) /* prints a token list for online debugging */
text_pointer p;
{
  token_pointer j; /* index into |tok_mem| */
  sixteen_bits r; /* remainder of token after the flag has been stripped off */
  if (p>=text_ptr) printf("BAD");
  else for (j=*p; j<*(p+1); j++) {
    r=*j%id_flag;
    switch (*j/id_flag) {
      case 1: printf("\\\\{"); print_id((name_dir+r)); printf("}"); break;
        /* |id_flag| */
      case 2: printf("\\&{"); print_id((name_dir+r)); printf("}"); break;
        /* |res_flag| */
      case 3: printf("<"); print_id((name_dir+r)); printf(">"); break;
        /* |mod_flag| */
      case 4: printf("[[%d]]",r); break; /* |tok_flag| */
      case 5: printf("|[[%d]]|",r); break; /* |inner_tok_flag| */
      default: @<Print token |r| in symbolic form@>;
    }
  }
  fflush(stdout);
}
#endif DEBUG

@ @<Print token |r|...@>=
switch (r) {
  case math_rel: printf("\\mathrel{"); break;
  case big_cancel: printf("[ccancel]"); break;
  case cancel: printf("[cancel]"); break;
  case indent: printf("[indent]"); break;
  case outdent: printf("[outdent]"); break;
  case backup: printf("[backup]"); break;
  case opt: printf("[opt]"); break;
  case break_space: printf("[break]"); break;
  case force: printf("[force]"); break;
  case big_force: printf("[fforce]"); break;
  case end_translation: printf("[quit]"); break;
  default: putxchar(r);
}

@ The production rules listed above are embedded directly into the \.{WEAVE}
program, since it is easier to do this than to write an interpretive system
that would handle production systems in general. Several macros are defined
here so that the program for each production is fairly short.

All of our productions conform to the general notion that some |k|
consecutive scraps starting at some position |j| are to be replaced by a
single scrap of some category |c| whose translation is composed from the
translations of the disappearing scraps. After this production has been
applied, the production pointer |pp| should change by an amount |d|. Such
a production can be represented by the quadruple |(j,k,c,d)|. For example,
the production `|exp@,comma@,exp| $\RA$ |exp|' would be represented by
`|(pp,3,exp,-2)|'; in this case the pointer |pp| should decrease by 2
after the production has been applied, because some productions with
|exp| in their second or third positions might now match,
but no productions have
|exp| in the fourth position of their left-hand sides. Note that
the value of |d| is determined by the whole collection of productions, not
by an individual one.
The determination of |d| has been
done by hand in each case, based on the full set of productions but not on
the grammar of \Cee\ or on the rules for constructing the initial
scraps.

We also attach a serial number to each production, so that additional
information is available when debugging. For example, the program below
contains the statement `|reduce(pp,3,exp,-2,4)|' when it implements
the production just mentioned.

Before calling |reduce|, the program should have appended the tokens of
the new translation to the |tok_mem| array. We commonly want to append
copies of several existing translations, and macros are defined to
simplify these common cases. For example, \\{app2}|(pp)| will append the
translations of two consecutive scraps, |pp->trans| and |(pp+1)->trans|, to
the current token list. If the entire new translation is formed in this
way, we write `|squash(j,k,c,d,n)|' instead of `|reduce(j,k,c,d,n)|'. For
example, `|squash(pp,3,exp,-2,3)|' is an abbreviation for `\\{app3}|(pp);
reduce(pp,3,exp,-2,3)|'.

A couple more words of explanation:
both |big_app| and |app| append a token (while |big_app1| to |big_app4|
append the specified number of scrap translations) to the current token list.
The difference between |big_app| and |app| is simply that |big_app|
checks whether there can be a conflict between math and non-math
tokens, and intercalates a `\.{\$}' token if necessary.  When in
doubt what to use, use |big_app|.

The |mathness| is an attribute of scraps that says whether they are
to be printed in a math mode context or not.  It is separate from the
``part of speech'' (the |cat|) because to make each |cat| have
a fixed |mathness| (as in the original \.{WEAVE}) would multiply the
number of necessary production rules.

The low two bits (i.e. |mathness % 4|) control the left boundary.
(We need two bits because we allow cases |yes_math|, |no_math| and
|maybe_math|, which can go either way.)
The next two bits (i.e. |mathness / 4|) control the right boundary.
If we combine two scraps and the right boundary of the first has
a different mathness from the left boundary of the second, we
insert a \.{\$} in between.  Similarly, if at printing time some
irreducible scrap has a |yes_math| boundary the scrap gets preceded
or followed by a \.{\$}. The left boundary is |maybe_math| if and
only if the right boundary is.

The code below is an exact translation of the production rules into
\Cee, using such macros, and the reader should have no difficulty
understanding the format by comparing the code with the symbolic
productions as they were listed earlier.

@d no_math 2 /* should be in horizontal mode */
@d yes_math 1 /* should be in math mode */
@d maybe_math 0 /* works in either horizontal or math mode */
@d big_app2(a) big_app1(a);big_app1(a+1)
@d big_app3(a) big_app2(a);big_app1(a+2)
@d big_app4(a) big_app3(a);big_app1(a+3)
@d app(a) *(tok_ptr++)=a
@d app1(a) *(tok_ptr++)=tok_flag+(a)->trans-tok_start

@<Global...@>=
int cur_mathness, init_mathness;

@ @c app_str(s)
char *s;
{ 
  while (*s) app_tok(*(s++));
}
big_app(a)
token a;
{
        if (a==' ' || a>=big_cancel && a<=big_force) /* non-math token */ {
                if (cur_mathness==maybe_math) init_mathness=no_math;
                else if (cur_mathness==yes_math) app_str("{}$");
                cur_mathness=no_math;
        }
        else {
                if (cur_mathness==maybe_math) init_mathness=yes_math;
                else if (cur_mathness==no_math) app_str("${}");
                cur_mathness=yes_math;
        }
        app(a);
}
big_app1(a)
scrap_pointer a;
{
  switch (a->mathness % 4) { /* left boundary */
  case (no_math):
    if (cur_mathness==maybe_math) init_mathness=no_math;
    else if (cur_mathness==yes_math) app_str("{}$");
    cur_mathness=a->mathness / 4; /* right boundary */
    break;
  case (yes_math):
    if (cur_mathness==maybe_math) init_mathness=yes_math;
    else if (cur_mathness==no_math) app_str("${}");
    cur_mathness=a->mathness / 4; /* right boundary */
    break;
  case (maybe_math): /* no changes */ break;
  }
  app(tok_flag+(a)->trans-tok_start);
}

@ Let us consider the big switch for productions now, before looking
at its context. We want to design the program so that this switch
works, so we might as well not keep ourselves in suspense about exactly what
code needs to be provided with a proper environment.

@d cat1 (pp+1)->cat
@d cat2 (pp+2)->cat
@d cat3 (pp+3)->cat

@<Match a production at |pp|, or increase |pp| if there is no match@>= {
  if (cat1==end_arg)
    if (pp->cat==begin_arg) squash(pp,2,exp,-2,63);
    else squash(pp,2,end_arg,-1,64);
  else if (cat1==insert) squash(pp,2,pp->cat,-2,0);
  else if (cat2==insert) squash(pp+1,2,(pp+1)->cat,-1,0);
  else if (cat3==insert) squash(pp+2,2,(pp+2)->cat,0,0);
  else
  switch (pp->cat) {
    case exp: @<Cases for |exp|@>; @+break;
    case lpar: @<Cases for |lpar|@>; @+break;
    case question: @<Cases for |question|@>; @+break;
    case unop: @<Cases for |unop|@>; @+break;
    case unorbinop: @<Cases for |unorbinop|@>; @+break;
    case binop: @<Cases for |binop|@>; @+break;
    case cast: @<Cases for |cast|@>; @+break;
    case sizeof_like: @<Cases for |sizeof_like|@>; @+break;
    case int_like: @<Cases for |int_like|@>; @+break;
    case decl_head: @<Cases for |decl_head|@>; @+break;
    case decl: @<Cases for |decl|@>; @+break;
    case typedef_like: @<Cases for |typedef_like|@>; @+break;
    case struct_like: @<Cases for |struct_like|@>; @+break;
    case struct_head: @<Cases for |struct_head|@>; @+break;
    case fn_decl: @<Cases for |fn_decl|@>; @+break;
    case function: @<Cases for |function|@>; @+break;
    case lbrace: @<Cases for |lbrace|@>; @+break;
    case do_like: @<Cases for |do_like|@>; @+break;
    case if_like: @<Cases for |if_like|@>; @+break;
    case else_like: @<Cases for |else_like|@>; @+break;
    case if_head: @<Cases for |if_head|@>; @+break;
    case case_like: @<Cases for |case_like|@>; @+break;
    case stmt: @<Cases for |stmt|@>; @+break;
    case tag: @<Cases for |tag|@>; @+break;
    case semi: @<Cases for |semi|@>; @+break;
    case lproc: @<Cases for |lproc|@>; @+break;
    case mod_scrap: @<Cases for |mod_scrap|@>; @+break;
    case insert: @<Cases for |insert|@>; @+break;
  }
  pp++; /* if no match was found, we move to the right */
}

@ In \Cee, new specifier names can be defined via |typedef|, and we want
to make the parser recognize future occurrences of the identifier thus
defined as specifiers.  This is done by the procedure |make_reserved|,
which changes the |ilk| of the relevant identifier.

We first need a procedure to recursively seek the first
identifier in a token list, because the identifier might
be enclosed in parentheses, as when one defines a function
returning a pointer.

@d no_ident_found 0 /* distinct from any identifier token */

@c token_pointer
find_first_ident(p)
text_pointer p;
{
  token_pointer q; /* token to be returned */
  token_pointer j; /* token being looked at */
  sixteen_bits r; /* remainder of token after the flag has been stripped off */
  if (p>=text_ptr) confusion("find_first_ident");
  for (j=*p; j<*(p+1); j++) {
    r=*j%id_flag;
    switch (*j/id_flag) {
      case 1: return j;
      case 4: case 5: /* |tok_flag| or |inner_tok_flag| */
        if ((q=find_first_ident(tok_start+r))!=no_ident_found)
          return q;
      default: ; /* |res_flag|, |mod_flag|, |tok_flag|: move on to next token */
    }
  }
  return no_ident_found;
}

@ The scraps currently being parsed must be inspected for any
occurrence of the identifier that we're making reserved; hence
the |for| loop below.

@c make_reserved(p) /* make the first identifier in |p->trans| like |int| */
scrap_pointer p;
{
  sixteen_bits tok_value; /* the name of this identifier, plus its flag*/
  token_pointer tok_loc; /* pointer to |tok_value| */
  if ((tok_loc=find_first_ident(p->trans))==no_ident_found)
    return; /* this should not happen */
  tok_value=*tok_loc;
  for (;p<=scrap_ptr; p==lo_ptr? p=hi_ptr: p++) {
    if (p->cat==exp) {
      if (**(p->trans)==tok_value) {
        p->cat=int_like;
        **(p->trans)+=res_flag-id_flag;
      }
    }
  }
  (name_dir+tok_value-id_flag)->ilk=int_like;
  *tok_loc=tok_value-id_flag+res_flag;
}

@ In the following situations we want to mark the occurrence of
an identifier as a definition: when |make_reserved| has just been
used; after a specifier, as in |char **argv|;
before a colon, as in \\{found}:; and in the declaration of a function,
as in \\{main}()$\{\ldots;\}$.  This is accomplished by the invocation
of |make_underlined| at appropriate times.  Notice that, in the declaration
of a function, we only find out that the identifier is being defined after
it has been swallowed up by an |exp|.

@c make_underlined(p)
/* underline the entry for the first identifier in |p->trans| */
scrap_pointer p;
{
  token_pointer tok_loc; /* where the first identifier appears */
  if ((tok_loc=find_first_ident(p->trans))==no_ident_found)
    return; /* this happens after parsing the |()| in |double f();| */
  xref_switch=def_flag; underline_xref(*tok_loc-id_flag+name_dir);
}

@ We cannot use |new_xref| to underline a cross-reference at this point
because this would just make a new cross-reference at the end of the list.
We actually have to search through the list for the existing
cross-reference.

@c underline_xref(p)
name_pointer p;
{
  xref_pointer q=(xref_pointer)p->xref; /* pointer to cross-reference being examined */
  xref_pointer r; /* temporary pointer for permuting cross-references */
  sixteen_bits m; /* cross-reference value to be installed */
  sixteen_bits n; /* cross-reference value being examined */
  if (no_xref) return;
  xref_switch=def_flag;
  m=module_count+xref_switch;
  while (q != xmem) {
    n=q->num;
    if (n==m) return;
    else if (m==n+def_flag) {
        q->num=m; return;
    }
    else if (n>=def_flag && n<m) break;
    q=q->xlink;
  }
  @<Insert new cross-reference at |q|, not at beginning of list@>;
}

@ We get to this module only when the identifier is one letter long,
so it didn't get a non-underlined entry during phase one.  But it may
have got some explicitly underlined entries in later modules, so in order
to preserve the numerical order of the entries in the index, we have
to insert the new cross-reference not at the beginning of the list
(namely, at |p->xref|), but rather right before |q|.

@<Insert new cross-reference at |q|...@>=
  append_xref(0); /* this number doesn't matter */
  xref_ptr->xlink=(xref_pointer)p->xref; r=xref_ptr;
  p->xref=(char*)xref_ptr;
  while (r->xlink!=q) {r->num=r->xlink->num; r=r->xlink;}
  r->num=m; /* everything from |q| on is left undisturbed */

@ Now comes the code that tries to match each production starting
with a particular type of scrap. Whenever a match is discovered,
the |squash| or |reduce| macro will cause the appropriate action
to be performed, followed by |goto found|.

@<Cases for |exp|@>=
if (cat1==lbrace || cat1==int_like || cat1==decl) {
  make_underlined(pp); big_app1(pp); big_app(indent); app(indent);
  reduce(pp,1,fn_decl,0,1);
}
else if (cat1==unop) squash(pp,2,exp,-2,2);
else if ((cat1==binop || cat1==unorbinop) && cat2==exp)
        squash(pp,3,exp,-2,3);
else if (cat1==comma && cat2==exp) {
  big_app2(pp);
  app(opt); app('9'); big_app1(pp+2); reduce(pp,3,exp,-2,4);
}
else if (cat1==exp) squash(pp,2,exp,-2,5);
else if (cat1==semi) squash(pp,2,stmt,-1,6);
else if (cat1==colon) {
  make_underlined (pp);  squash(pp,2,tag,0,7);
}

@ @<Cases for |lpar|@>=
if (cat1==exp && cat2==rpar) squash(pp,3,exp,-2,8);
else if (cat1==rpar) {
  big_app1(pp); app('\\'); app(','); big_app1(pp+1);
  reduce(pp,2,exp,-2,9);
}
else if ((cat1==decl_head || cat1==int_like) && cat2==rpar)
  squash(pp,3,cast,-1,10);
else if (cat1==stmt) {
  big_app2(pp); big_app(' '); reduce(pp,2,lpar,0,11);
}

@ @<Cases for |question|@>=
if (cat1==exp && cat2==colon) squash(pp,3,binop,-2,12);

@ @<Cases for |unop|@>=
if (cat1==exp) squash(pp,2,exp,-2,13);

@ @<Cases for |unorbinop|@>=
if (cat1==exp || cat1==int_like) {
  big_app('{'); big_app1(pp); big_app('}'); big_app1(pp+1);
  reduce(pp,2,exp,-2,14);
}
else if (cat1==binop) {
  big_app(math_rel); big_app1(pp); big_app('{'); big_app1(pp+1); big_app('}');
  big_app('}'); reduce(pp,2,binop,-1,15);
}

@ @<Cases for |binop|@>=
if (cat1==binop) {
  big_app(math_rel); big_app('{'); big_app1(pp); big_app('}');
  big_app('{'); big_app1(pp+1); big_app('}');
  big_app('}'); reduce(pp,2,binop,-1,16);
}

@ @<Cases for |cast|@>=
if (cat1==exp) {
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,exp,-2,17);
}

@ @<Cases for |sizeof_like|@>=
if (cat1==cast) squash(pp,2,exp,-2,18);
else if (cat1==exp) {
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,exp,-2,19);
}

@ @<Cases for |int_like|@>=
if (cat1==int_like|| cat1==struct_like) {
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,cat1,-1,20);
}
else if (cat1==exp || cat1==unorbinop || cat1==semi) {
  big_app1(pp);
  if (cat1!=semi) big_app(' ');
  reduce(pp,1,decl_head,-1,21);
}
else if (cat1==comma && cat2==exp) squash(pp,3,int_like,-1,65);

@ @<Cases for |decl_head|@>=
if (cat1==comma) {
  big_app2(pp); big_app(' '); reduce(pp,2,decl_head,-1,22);
}
else if (cat1==unorbinop) {
  big_app1(pp); big_app('{'); big_app1(pp+1); big_app('}');
  reduce(pp,2,decl_head,-1,23);
}
else if (cat1==exp && cat2!=lpar && cat2!=exp) {
  make_underlined(pp+1); squash(pp,2,decl_head,-1,24);
}
else if ((cat1==binop||cat1==colon) && cat2==exp && (cat3==comma || cat3==semi))
  squash(pp,3,decl_head,-1,25);
else if (cat1==lbrace || cat1==int_like || cat1==decl) {
  big_app1(pp); big_app(indent); app(indent); reduce(pp,1,fn_decl,0,26);
}
else if (cat1==semi) squash(pp,2,decl,-1,27);

@ @<Cases for |decl|@>=
if (cat1==decl) {
  big_app1(pp); big_app(force); big_app1(pp+1);
  reduce(pp,2,decl,-1,28);
}
else if (cat1==stmt || cat1==function) {
  big_app1(pp); big_app(big_force); big_app1(pp+1); reduce(pp,2,cat1,-1,29);
}

@ @<Cases for |typedef_like|@>=
if (cat1==decl_head)
  if ((cat2==exp&&cat3!=lpar&&cat3!=exp)||cat2==int_like) {
    make_underlined(pp+2); make_reserved(pp+2);
    big_app2(pp+1); reduce(pp+1,2,decl_head,0,30);
  }
  else if (cat2==semi) {
    big_app1(pp); big_app(' '); big_app2(pp+1); reduce(pp,3,decl,-1,31);
  }

@ @<Cases for |struct_like|@>=
if (cat1==lbrace) {
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,struct_head,0,32);
}
else if (cat1==exp||cat1==int_like) {
  if (cat2==lbrace) {
    make_underlined(pp+1);
    big_app1(pp); big_app(' '); big_app1(pp+1);
    big_app(' '); big_app1(pp+2);reduce(pp,3,struct_head,0,33);
  }
  else {
    big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,int_like,-1,34);
  }
}

@ @<Cases for |struct_head|@>=
if ((cat1==decl || cat1==stmt) && cat2==rbrace) {
  big_app1(pp); big_app(indent); big_app(force); big_app1(pp+1);
  big_app(outdent); big_app(force);  big_app1(pp+2); 
  reduce(pp,3,int_like,-1,35);
}

@ @<Cases for |fn_decl|@>=
if (cat1==decl) {
  big_app1(pp); big_app(force); big_app1(pp+1); reduce(pp,2,fn_decl,0,36);
}
else if (cat1==stmt) {
  big_app1(pp); app(outdent); app(outdent); big_app(force);
  big_app1(pp+1); reduce(pp,2,function,-1,37);
}

@ @<Cases for |function|@>=
if (cat1==function || cat1==decl) {
  big_app1(pp); big_app(big_force); big_app1(pp+1); reduce(pp,2,cat1,0,38);
}

@ @<Cases for |lbrace|@>=
if (cat1==rbrace) {
  big_app1(pp); app('\\'); app(','); big_app1(pp+1); 
  reduce(pp,2,stmt,-1,39);
}
else if (cat1==stmt && cat2==rbrace) {
  big_app(force); big_app1(pp);  big_app(indent); big_app(force);
  big_app1(pp+1); big_app(force); big_app(backup);  big_app1(pp+2); 
  big_app(outdent); big_app(force); reduce(pp,3,stmt,-1,40);
}
else if (cat1==exp) {
  if (cat2==rbrace) squash(pp,3,exp,-2,41);
  else if (cat2==comma && cat3==rbrace) squash(pp,4,exp,-2,41);
}

@ @<Cases for |if_like|@>=
if (cat1==exp) {
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,else_like,-2,42);
}

@ @<Cases for |else_like|@>=
if (cat1==lbrace) squash(pp,1,if_head,0,43);
else if (cat1==stmt ||(cat1==exp && cat2==else_like)) {
  big_app(force); big_app1(pp); big_app(indent); big_app(break_space);
  big_app1(pp+1); big_app(outdent); big_app(force);
  if (cat2==else_like) {
    big_app1(pp+2); big_app(' '); big_app(cancel); reduce(pp,3,else_like,-2,44);
  }
  else reduce(pp,2,stmt,-1,45);
}

@ @<Cases for |if_head|@>=
if (cat1==stmt ||(cat1==exp && cat2==else_like)) {
  big_app(force); big_app1(pp); big_app(break_space);
  app(noop); big_app(cancel); big_app1(pp+1);
  if (cat2==else_like) {
    big_app(break_space); big_app1(pp+2); big_app(' '); big_app(cancel);
    reduce(pp,3,else_like,-2,46);
  }
  else {
    big_app(force); reduce(pp,2,stmt,-1,47);
  }
}

@ @<Cases for |do_like|@>=
if (cat1==stmt && cat2==else_like && cat3==semi) {
  big_app1(pp); big_app(break_space); big_app1(pp+1);
  big_app(break_space); big_app1(pp+2); big_app1(pp+3);
  reduce(pp,4,stmt,-1,48);
}

@ @<Cases for |case_like|@>=
if (cat1==semi) squash(pp,2,stmt,-1,49);
else if (cat1==colon) squash(pp,2,tag,-1,51);
else if (cat1==exp) {
  if (cat2==semi) {
    big_app1(pp); big_app(' ');  big_app1(pp+1);  big_app1(pp+2);
    reduce(pp,3,stmt,-1,50);
  }
  else if (cat2==colon) {
    big_app1(pp); big_app(' ');  big_app1(pp+1);  big_app1(pp+2);
    reduce(pp,3,tag,-1,52);
  }
}

@ @<Cases for |tag|@>=
if (cat1==tag) {
  big_app1(pp); big_app(break_space); big_app1(pp+1); reduce(pp,2,tag,-1,53);
}
else if (cat1==stmt) {
  big_app(force); big_app(backup); big_app1(pp); big_app(break_space);
  big_app1(pp+1); reduce(pp,2,stmt,-1,54);
}

@ @<Cases for |stmt|@>=
if (cat1==stmt) {
  big_app1(pp);
  if (force_lines) big_app(force);
  else big_app(break_space);
  big_app1(pp+1); reduce(pp,2,stmt,-1,55);
}

@ @<Cases for |semi|@>=
big_app(' '); big_app1(pp); reduce(pp,1,stmt,-1,56);

@ @<Cases for |lproc|@>=
if (cat1==define_like) make_underlined(pp+2);
if (cat1==else_like || cat1==if_like ||cat1==define_like)
  squash(pp,2,lproc,0,57);
else if (cat1==rproc) squash(pp,2,insert,-1,58);
else if (cat1==exp || cat1==function) {
  if (cat2==rproc) {
    big_app1(pp); big_app(' '); big_app2(pp+1);
    reduce(pp,3,insert,-1,59);
  }
  else if (cat2==exp && cat3==rproc && cat1==exp) {
    big_app1(pp); big_app(' '); big_app1(pp+1); app_str(" \\5");
    big_app2(pp+2); reduce(pp,4,insert,-1,59);
  }
}

@ @<Cases for |mod_scrap|@>=
if (cat1==semi) {
  big_app2(pp); big_app(force); reduce(pp,2,stmt,-2,60);
}
else squash(pp,1,exp,-2,61);

@ @<Cases for |insert|@>=
if (cat1)
  squash(pp,2,cat1,0,62);

@ The `|freeze_text|' macro is used to give official status to a token list.
Before saying |freeze_text|, items are appended to the current token list,
and we know that the eventual number of this token list will be the current
value of |text_ptr|. But no list of that number really exists as yet,
because no ending point for the current list has been
stored in the |tok_start| array. After saying |freeze_text|, the
old current token list becomes legitimate, and its number is the current
value of |text_ptr-1| since |text_ptr| has been increased. The new
current token list is empty and ready to be appended to.
Note that |freeze_text| does not check to see that |text_ptr| hasn't gotten
too large, since it is assumed that this test was done beforehand.

@d freeze_text *(++text_ptr)=tok_ptr

@ Here's the |reduce| procedure used in our code for productions:

@c reduce(j,k,c,d,n)
scrap_pointer j;
eight_bits c;
short k, d, n;
{
  scrap_pointer i, i1; /* pointers into scrap memory */
  j->cat=c; j->trans=text_ptr;
  j->mathness=4*cur_mathness+init_mathness;
  freeze_text;
  if (k>1) {
    for (i=j+k, i1=j+1; i<=lo_ptr; i++, i1++) {
      i1->cat=i->cat; i1->trans=i->trans;
      i1->mathness=i->mathness;
    }
    lo_ptr=lo_ptr-k+1;
  }
  @<Change |pp| to $\max(|scrap_base|,|pp+d|)$@>;
  @<Print a snapshot of the scrap list if debugging @>;
  pp--; /* we next say |pp++| */
}

@ @<Change |pp| to $\max...@>=
if (pp+d>=scrap_base) pp=pp+d;
else pp=scrap_base;

@ Here's the |squash| procedure, which
takes advantage of the simplification that occurs when |k=1|.

@c squash(j,k,c,d,n)
scrap_pointer j;
eight_bits c;
short k, d, n;
{
  scrap_pointer i; /* pointers into scrap memory */
  if (k==1) {
    j->cat=c; @<Change |pp|...@>;
    @<Print a snapshot...@>;
    pp--; /* we next say |pp++| */
    return;
  }
  for (i=j; i<j+k; i++) big_app1(i);
  reduce(j,k,c,d,n);
}

@ Here now is the code that applies productions as long as possible.
Before applying the production mechanism, we must make sure
it has good input (at least four scraps, the length of the lhs of the
longest rules), and that there is enough room in the memory arrays
to hold the appended tokens and texts.  Here we use a very
conservative test: it's more important to make sure the program
will still work if we change the production rules (within reason)
than to squeeze the last bit of space from the memory arrays.

@d safe_tok_incr 20
@d safe_text_incr 10
@d safe_scrap_incr 10

@<Reduce the scraps using the productions until no more rules apply@>=
while (1) {
  @<Make sure the entries |pp| through |pp+3| of |cat| are defined@>;
  if (tok_ptr+safe_tok_incr>tok_mem_end) {
#ifdef STAT
    if (tok_ptr>max_tok_ptr) max_tok_ptr=tok_ptr;
#endif STAT
    overflow("token");
  }
  if (text_ptr+safe_text_incr>tok_start_end) {
#ifdef STAT
    if (text_ptr>max_text_ptr) max_text_ptr=text_ptr;
#endif STAT
    overflow("text");
  }
  if (pp>lo_ptr) break;
  init_mathness=cur_mathness=maybe_math;
  @<Match a production...@>;
}

@ If we get to the end of the scrap list, category codes equal to zero are
stored, since zero does not match anything in a production.

@<Make sure the entries...@>=
if (lo_ptr<pp+3) {
  while (hi_ptr<=scrap_ptr && lo_ptr!=pp+3) {
    (++lo_ptr)->cat=hi_ptr->cat; lo_ptr->mathness=(hi_ptr)->mathness;
    lo_ptr->trans=(hi_ptr++)->trans;
  }
  for (i=lo_ptr+1;i<=pp+3;i++) i->cat=0;
}

@ If \.{WEAVE} is being run in debugging mode, the production numbers and
current stack categories will be printed out when |tracing| is set to 2;
a sequence of two or more irreducible scraps will be printed out when
|tracing| is set to 1.

@<Global...@>=
#ifdef DEBUG
int tracing; /* can be used to show parsing details */
#endif DEBUG

@ @<Print a snapsh...@>=
#ifdef DEBUG
{ scrap_pointer k; /* pointer into |scrap_info| */
  if (tracing==2) {
    printf("\n%d:",n);
    for (k=scrap_base; k<=lo_ptr; k++) {
      if (k==pp) putxchar('*'); else putxchar(' ');
      if (k->mathness %4 ==  yes_math) putchar('+');
      else if (k->mathness %4 ==  no_math) putchar('-');
      print_cat(k->cat);
      if (k->mathness /4 ==  yes_math) putchar('+');
      else if (k->mathness /4 ==  no_math) putchar('-');
    }
    if (hi_ptr<=scrap_ptr) printf("..."); /* indicate that more is coming */
  }
}
#endif DEBUG

@ The |translate| function assumes that scraps have been stored in
positions |scrap_base| through |scrap_ptr| of |cat| and |trans|. It
applies productions as much as
possible. The result is a token list containing the translation of
the given sequence of scraps.

After calling |translate|, we will have |text_ptr+3<=max_texts| and
|tok_ptr+6<=max_toks|, so it will be possible to create up to three token
lists with up to six tokens without checking for overflow. Before calling
|translate|, we should have |text_ptr<max_texts| and |scrap_ptr<max_scraps|,
since |translate| might add a new text and a new scrap before it checks
for overflow.

@c text_pointer translate() /* converts a sequence of scraps */
{
  scrap_pointer i, /* index into |cat| */
  j; /* runs through final scraps */
  pp=scrap_base; lo_ptr=pp-1; hi_ptr=pp;
  @<If tracing, print an indication of where we are@>;
  @<Reduce the scraps...@>;
  @<Combine the irreducible scraps that remain@>;
}

@ If the initial sequence of scraps does not reduce to a single scrap,
we concatenate the translations of all remaining scraps, separated by
blank spaces, with dollar signs surrounding the translations of scraps
where appropriate.

@<Combine the irreducible...@>= {
  @<If semi-tracing, show the irreducible scraps@>;
  for (j=scrap_base; j<=lo_ptr; j++) {
    if (j!=scrap_base) app(' ');
    if (j->mathness % 4 == yes_math) app('$');
    app1(j);
    if (j->mathness / 4 == yes_math) app('$');
    if (tok_ptr+6>tok_mem_end) overflow("token");
  }
  freeze_text; return(text_ptr-1);
}

@ @<If semi-tracing, show the irreducible scraps@>=
#ifdef DEBUG
if (lo_ptr>scrap_base && tracing==1) {
  printf("\nIrreducible scrap sequence in section %d:",module_count);
@.Irreducible scrap sequence...@>
  mark_harmless;
  for (j=scrap_base; j<=lo_ptr; j++) {
    printf(" "); print_cat(j->cat);
  }
}
#endif DEBUG

@ @<If tracing,...@>=
#ifdef DEBUG
if (tracing==2) {
  printf("\nTracing after l. %d:\n",cur_line); mark_harmless;
@.Tracing after...@>
  if (loc>buffer+50) {
    printf("...");
    term_write(loc-51,51);
  }
  else term_write(buffer,loc-buffer);
}
#endif DEBUG

@* Initializing the scraps.
If we are going to use the powerful production mechanism just developed, we
must get the scraps set up in the first place, given a \Cee\ text. A table
of the initial scraps corresponding to \Cee\ tokens appeared above in the
section on parsing; our goal now is to implement that table. We shall do this
by implementing a subroutine called |C_parse| that is analogous to the
|C_xref| routine used during phase one.

Like |C_xref|, the |C_parse| procedure starts with the current
value of |next_control| and it uses the operation |next_control=get_next()|
repeatedly to read \Cee\ text until encountering the next `\.{\v}' or
`\.{/*}', or until |next_control>=format_code|. The scraps corresponding to what
it reads are appended into the |cat| and |trans| arrays, and |scrap_ptr|
is advanced.

@c C_parse() /* creates scraps from \Cee\ tokens */
{
  name_pointer p; /* identifier designator */
  int count; /* characters remaining before string break */
  while (next_control<format_code) {
    @<Append the scrap appropriate to |next_control|@>;
    next_control=get_next();
    if (next_control=='|' || next_control==begin_comment) return;
  }
}

@ The following macro is used to append a scrap whose tokens have just
been appended:

@d app_scrap(c,b) (++scrap_ptr)->cat=c; scrap_ptr->trans=text_ptr;
scrap_ptr->mathness=5*b; /* no no, yes yes, or maybe maybe */
freeze_text;

@ @<Append the scr...@>=
@<Make sure that there is room for the new scraps, tokens, and texts@>;
switch (next_control) {
  case string: case constant: case verbatim: @<Append a string or constant@>;
   @+break;
  case identifier: @<Append an identifier scrap@>;@+break;
  case TeX_string: @<Append a \TeX\ string scrap@>;@+break;
  case '/': case '<': case '>': case '.':
    app(next_control); app_scrap(binop,yes_math);@+break;
  case '=': app_str("\\K"); app_scrap(binop,yes_math);@+break;
@.\\K@>
  case '|': app_str("\\OR"); app_scrap(binop,yes_math);@+break;
@.\\OR@>
  case '^': app_str("\\XOR"); app_scrap(binop,yes_math);@+break;
@.\\XOR@>
  case '%': app_str("\\MOD"); app_scrap(binop,yes_math);@+break;
@.\\MOD@>
  case '!': app_str("\\R"); app_scrap(unop,yes_math);@+break;
@.\\R@>
  case '~': app_str("\\CM"); app_scrap(unop,yes_math);@+break;
@.\\CM@>
  case '+': case '-': case '*': app(next_control); app_scrap(unorbinop,yes_math);@+break;
  case '&': app_str("\\AND"); app_scrap(unorbinop,yes_math);@+break;
@.\\AND@>
  case '?': app_str("\\?"); app_scrap(question,yes_math);@+break;
@.\\\#@>
  case '#': app_str("\\#"); app_scrap(insert,maybe_math);@+break;
    /* this shouldn't happen in normal \Cee\ programs*/
  case ignore: case xref_roman: case xref_wildcard:
  case xref_typewriter: case noop:@+break;
  case '(': case '[': app(next_control); app_scrap(lpar,maybe_math);@+break;
  case ')': case ']': app(next_control); app_scrap(rpar,maybe_math);@+break;
  case '{': app_str("\\{"); app_scrap(lbrace,yes_math);@+break;
  case '}': app_str("\\}"); app_scrap(rbrace,yes_math);@+break;
  case ',': app(','); app_scrap(comma,yes_math);@+break;
  case ';': app(';'); app_scrap(semi,maybe_math);@+break;
  case ':': app(':'); app_scrap(colon,maybe_math);@+break;@/
  @t\4@>  @<Cases involving nonstandard characters@>@;
  case thin_space: app_str("\\,"); app_scrap(insert,maybe_math);@+break;
@.\\,@>
  case math_break: app(opt); app_str("0");
    app_scrap(insert,maybe_math);@+break;
  case line_break: app(force); app_scrap(insert,no_math);@+break;
  case left_preproc: app(force); app(preproc_line);
    app_str("\\#"); app_scrap(lproc,no_math);@+break;
  case right_preproc: app(force); app_scrap(rproc,no_math);@+break;
  case big_line_break: app(big_force); app_scrap(insert,no_math);@+break;
  case no_line_break: app(big_cancel); app(noop); app(break_space);
    app(noop); app(big_cancel);
    app_scrap(insert,no_math);@+break;
  case pseudo_semi: app_scrap(semi,maybe_math);@+break;
  case macro_arg_open: app_scrap(begin_arg,maybe_math);@+break;
  case macro_arg_close: app_scrap(end_arg,maybe_math);@+break;
  case join: app_str("\\J"); app_scrap(insert,no_math);@+break;
@.\\J@>
  default: app(next_control); app_scrap(insert,maybe_math);@+break;
}

@ @<Make sure that there is room for the new...@>=
if (scrap_ptr+safe_scrap_incr>scrap_info_end ||
  tok_ptr+safe_tok_incr>tok_mem_end @| ||
  text_ptr+safe_text_incr>tok_start_end) {
#ifdef STAT
  if (scrap_ptr>max_scr_ptr) max_scr_ptr=scrap_ptr;
  if (tok_ptr>max_tok_ptr) max_tok_ptr=tok_ptr;
  if (text_ptr>max_text_ptr) max_text_ptr=text_ptr;
#endif STAT
  overflow("scrap/token/text");
}

@ Some nonstandard characters may have entered \.{WEAVE} by means of
standard ones. They are converted to \TeX\ control sequences so that it is
possible to keep \.{WEAVE} from outputting unusual |char| codes.

@<Cases involving nonstandard...@>=
case not_eq: app_str("\\I");@+app_scrap(binop,yes_math);@+break;
@.\\I@>
case lt_eq: app_str("\\le");@+app_scrap(binop,yes_math);@+break;
@.\\le@>
case gt_eq: app_str("\\G");@+app_scrap(binop,yes_math);@+break;
@.\\G@>
case eq_eq: app_str("\\E");@+app_scrap(binop,yes_math);@+break;
@.\\E@>
case and_and: app_str("\\W");@+app_scrap(binop,yes_math);@+break;
@.\\W@>
case or_or: app_str("\\V");@+app_scrap(binop,yes_math);@+break;
@.\\V@>
case plus_plus: app_str("\\PP");@+app_scrap(unop,yes_math);@+break;
@.\\PP@>
case minus_minus: app_str("\\MM");@+app_scrap(unop,yes_math);@+break;
@.\\MM@>
case minus_gt: app_str("\\MG");@+app_scrap(binop,yes_math);@+break;
@.\\MG@>
case gt_gt: app_str("\\GG");@+app_scrap(binop,yes_math);@+break;
@.\\GG@>
case lt_lt: app_str("\\LL");@+app_scrap(binop,yes_math);@+break;
@.\\LL@>

@ The following code must use |app_tok| instead of |app| in order to
protect against overflow. Note that |tok_ptr+1<=max_toks| after |app_tok|
has been used, so another |app| is legitimate before testing again.

Many of the special characters in a string must be prefixed by `\.\\' so that
\TeX\ will print them properly.
@^special string characters@>

@<Append a string or...@>=
count= -1;
if (next_control==constant) app_str("\\T{");
@.\\T@>
else if (next_control==string) {
  count=20; app_str("\\.{");
}
@.\\.@>
else app_str("\\vb{");
@.\\vb@>
while (id_first<id_loc) {
  if (count==0) { /* insert a discretionary break in a long string */
     app_str("}\\)\\.{"); count=20;
@.\\)@>
  }
  switch (*id_first) {
    case  ' ':case '\\':case '#':case '%':case '$':case '^':
    case '{': case '}': case '~': case '&': case '_': app('\\'); break;
    case '@@': if (*(id_first+1)=='@@') id_first++;
      else err_print("! Double @@ should be used in strings");
@.Double {\AT} should be used...@>
  }
  app_tok(*id_first++); count--;
}
app('}');
app_scrap(exp,maybe_math);

@ @<Append a \TeX\ string scrap@>=
app_str("\\hbox{"); while (id_first<id_loc) app_tok(*id_first++);
app('}'); app_scrap(exp,maybe_math);

@ @<Append an identifier scrap@>=
p=id_lookup(id_first, id_loc,normal);
if (!(reserved(p))) {
  app(id_flag+p-name_dir); app_scrap(exp,maybe_math); /* not a reserved word */
}
else if (p->ilk<=quoted) { /* |custom| or |quoted| */
  app('\\');
  while (id_first++<id_loc) {
    if (isxalpha(*(id_first-1))) app_tok('x')
    else app_tok(*(id_first-1));
  }
  app_scrap(exp,yes_math);  
@.\\NULL@>
}  
else {
  app(res_flag+p-name_dir);
  app_scrap(p->ilk,maybe_math);
}

@ When the `\.{\v}' that introduces \Cee\ text is sensed, a call on
|C_translate| will return a pointer to the \TeX\ translation of
that text. If scraps exist in |scrap_info|, they are
unaffected by this translation process.

@c text_pointer C_translate()
{
  text_pointer p; /* points to the translation */
  scrap_pointer save_base; /* holds original value of |scrap_base| */
  save_base=scrap_base; scrap_base=scrap_ptr+1;
  C_parse(); /* get the scraps together */
  if (next_control!='|') err_print("! Missing '|' after C text");
@.Missing '|'...@>
  app_tok(cancel); app_scrap(insert,maybe_math);
        /* place a |cancel| token as a final ``comment'' */
  p=translate(); /* make the translation */
#ifdef STAT
 if (scrap_ptr>max_scr_ptr) max_scr_ptr=scrap_ptr;
#endif STAT
  scrap_ptr=scrap_base-1; scrap_base=save_base; /* scrap the scraps */
  return(p);
}

@ The |outer_parse| routine is to |C_parse| as |outer_xref|
is to |C_xref|: it constructs a sequence of scraps for \Cee\ text
until |next_control>=format_code|. Thus, it takes care of embedded comments.

@c outer_parse() /* makes scraps from \Cee\ tokens and comments */
{
  int bal; /* brace level in comment */
  text_pointer p, q; /* partial comments */
  while (next_control<format_code)
    if (next_control!=begin_comment) C_parse();
    else {
      @<Make sure that there is room for the new...@>;
      app(cancel); app_str("\\C{");
@.\\C@>
      bal=copy_comment(1); next_control=ignore;
      while (bal>0) {
        p=text_ptr; freeze_text; q=C_translate();
         /* at this point we have |tok_ptr+6<=max_toks| */
        app(tok_flag+p-tok_start); app(inner_tok_flag+q-tok_start);
        if (next_control=='|') {
          bal=copy_comment(bal);
          next_control=ignore;
        }
        else bal=0; /* an error has been reported */
      }
      app(force); app_scrap(insert,no_math);
        /* the full comment becomes a scrap */
    }
}

@* Output of tokens.
So far our programs have only built up multi-layered token lists in
\.{WEAVE}'s internal memory; we have to figure out how to get them into
the desired final form. The job of converting token lists to characters in
the \TeX\ output file is not difficult, although it is an implicitly
recursive process. Four main considerations had to be kept in mind when
this part of \.{WEAVE} was designed.  (a) There are two modes of output:
|outer| mode, which translates tokens like |force| into line-breaking
control sequences, and |inner| mode, which ignores them except that blank
spaces take the place of line breaks. (b) The |cancel| instruction applies
to adjacent token or tokens that are output, and this cuts across levels
of recursion since `|cancel|' occurs at the beginning or end of a token
list on one level. (c) The \TeX\ output file will be semi-readable if line
breaks are inserted after the result of tokens like |break_space| and
|force|.  (d) The final line break should be suppressed, and there should
be no |force| token output immediately after `\.{\\Y\\B}'.

@ The output process uses a stack to keep track of what is going on at
different ``levels'' as the token lists are being written out. Entries on
this stack have three parts:

\yskip\hang |end_field| is the |tok_mem| location where the token list of a
particular level will end;

\yskip\hang |tok_field| is the |tok_mem| location from which the next token
on a particular level will be read;

\yskip\hang |mode_field| is the current mode, either |inner| or |outer|.

\yskip\noindent The current values of these quantities are referred to
quite frequently, so they are stored in a separate place instead of in the
|stack| array. We call the current values |cur_end|, |cur_tok|, and
|cur_mode|.

The global variable |stack_ptr| tells how many levels of output are
currently in progress. The end of output occurs when an |end_translation|
token is found, so the stack is never empty except when we first begin the
output process.

@d inner 0 /* value of |mode| for \Cee\ texts within \TeX\ texts */
@d outer 1 /* value of |mode| for \Cee\ texts in modules */

@<Typed...@>= typedef int mode;
typedef struct {
  token_pointer end_field; /* ending location of token list */
  token_pointer tok_field; /* present location within token list */
  boolean mode_field; /* interpretation of control tokens */
} output_state;
typedef output_state *stack_pointer;

@ @d cur_end cur_state.end_field /* current ending location in |tok_mem| */
@d cur_tok cur_state.tok_field /* location of next output token in |tok_mem| */
@d cur_mode cur_state.mode_field /* current mode of interpretation */
@d init_stack stack_ptr=stack;cur_mode=outer /* initialize the stack */

@<Global...@>=
output_state cur_state; /* |cur_end|, |cur_tok|, |cur_mode| */
output_state stack[stack_size]; /* info for non-current levels */
stack_pointer stack_ptr; /* first unused location in the output state stack */
stack_pointer stack_end=stack+stack_size-1; /* end of |stack| */
#ifdef STAT
stack_pointer max_stack_ptr; /* largest value assumed by |stack_ptr| */
#endif STAT

@ @<Set init...@>=
#ifdef STAT
max_stack_ptr=stack;
#endif STAT

@ To insert token-list |p| into the output, the |push_level| subroutine
is called; it saves the old level of output and gets a new one going.
The value of |cur_mode| is not changed.

@c push_level(p) /* suspends the current level */
text_pointer p;
{
  if (stack_ptr==stack_end) overflow("stack");
  if (stack_ptr>stack) { /* save current state */
    stack_ptr->end_field=cur_end;
    stack_ptr->tok_field=cur_tok;
    stack_ptr->mode_field=cur_mode;
  }
  stack_ptr++;
#ifdef STAT
  if (stack_ptr>max_stack_ptr) max_stack_ptr=stack_ptr;
#endif STAT
  cur_tok=*p; cur_end=*(p+1);
}

@ Conversely, the |pop_level| routine restores the conditions that were in
force when the current level was begun. This subroutine will never be
called when |stack_ptr=1|.

@c pop_level()
{
  cur_end=(--stack_ptr)->end_field;
  cur_tok=stack_ptr->tok_field; cur_mode=stack_ptr->mode_field;
}

@ The |get_output| function returns the next byte of output that is not a
reference to a token list. It returns the values |identifier| or |res_word|
or |mod_name| if the next token is to be an identifier (typeset in
italics), a reserved word (typeset in boldface) or a module name (typeset
by a complex routine that might generate additional levels of output).
In these cases |cur_name| points to the identifier or module name in
question.

@<Global...@>=
name_pointer cur_name;

@ @d res_word 0201 /* returned by |get_output| for reserved words */
@d mod_name 0200 /* returned by |get_output| for module names */

@c eight_bits get_output() /* returns the next token of output */
{
  sixteen_bits a; /* current item read from |tok_mem| */
  restart: while (cur_tok==cur_end) pop_level();
  a=*(cur_tok++);
  if (a>=0400) {
    cur_name=a % id_flag + name_dir;
    switch (a / id_flag) {
      case 2: return(res_word); /* |a==res_flag+cur_name| */
      case 3: return(mod_name); /* |a==mod_flag+cur_name| */
      case 4: push_level(a % id_flag + tok_start); goto restart;
        /* |a==tok_flag+cur_name| */
      case 5: push_level(a % id_flag + tok_start); cur_mode=inner; goto restart;
        /* |a==inner_tok_flag+cur_name| */
      default: return(identifier); /* |a==id_flag+cur_name| */
    }
  }
  return(a);
}

@ The real work associated with token output is done by |make_output|.
This procedure appends an |end_translation| token to the current token list,
and then it repeatedly calls |get_output| and feeds characters to the output
buffer until reaching the |end_translation| sentinel. It is possible for
|make_output| to be called recursively, since a module name may include
embedded \Cee\ text; however, the depth of recursion never exceeds one
level, since module names cannot be inside of module names.

A procedure called |output_C| does the scanning, translation, and
output of \Cee\ text within `\pb' brackets, and this procedure uses
|make_output| to output the current token list. Thus, the recursive call
of |make_output| actually occurs when |make_output| calls |output_C|
while outputting the name of a module.
@^recursion@>

@c
output_C() /* outputs the current token list */
{
  token_pointer save_tok_ptr;
  text_pointer save_text_ptr;
  sixteen_bits save_next_control; /* values to be restored */
  text_pointer p; /* translation of the \Cee\ text */
  save_tok_ptr=tok_ptr; save_text_ptr=text_ptr;
  save_next_control=next_control; next_control=ignore; p=C_translate();
  app(p-tok_start+inner_tok_flag);
  make_output(); /* output the list */
#ifdef STAT
  if (text_ptr>max_text_ptr) max_text_ptr=text_ptr;
  if (tok_ptr>max_tok_ptr) max_tok_ptr=tok_ptr;
#endif STAT
  text_ptr=save_text_ptr; tok_ptr=save_tok_ptr; /* forget the tokens */
  next_control=save_next_control; /* restore |next_control| to original state */
}

@ Here is \.{WEAVE}'s major output handler.

@c make_output() /* outputs the equivalents of tokens */
{
  eight_bits a, /* current output byte */
  b; /* next output byte */
  int c; /* count of |indent| and |outdent| tokens */
  char *k, *k_limit; /* indices into |byte_mem| */
  char *j; /* index into |buffer| */
  char delim; /* first and last character of string being copied */
  char *save_loc, *save_limit; /* |loc| and |limit| to be restored */
  name_pointer cur_mod_name; /* name of module being output */
  boolean save_mode; /* value of |cur_mode| before a sequence of breaks */
  app(end_translation); /* append a sentinel */
  freeze_text; push_level(text_ptr-1);
  while (1) {
    a=get_output();
    reswitch: switch(a) {
      case end_translation: return;
      case identifier: case res_word: @<Output an identifier@>; break;
      case mod_name: @<Output a module name@>; break;
      case math_rel: out_str("\\mathrel{");
      case noop: break;
      case cancel: case big_cancel: c=0; b=a;
        while (((a=get_output())>=indent ||(b==big_cancel&&a==' '))@|
              && a<=big_force) {
          if (a==indent) c++; else if (a==outdent) c--;
          else if (a==opt) a=get_output();
        }
        @<Output saved |indent| or |outdent| tokens@>;
        goto reswitch;
      case indent: case outdent: case opt: case backup: case break_space:
      case force: case big_force: case preproc_line: @<Output a control,
        look ahead in case of line breaks, possibly |goto reswitch|@>; break;
      default: out(a); /* otherwise |a| is an ordinary character */
    }
  }
}

@ An identifier of length one does not have to be enclosed in braces, and it
looks slightly better if set in a math-italic font instead of a (slightly
narrower) text-italic font. Thus we output `\.{\\\v}\.{a}' but
`\.{\\\\\{aa\}}'.

@<Output an identifier@>=
out('\\');
if (a==identifier) {
  if (length(cur_name)==1) out('|')
@.\\|@>
  else { delim='.';
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      if (islower(*j)) { /* not entirely uppercase */
         delim='\\'; break;
      }
  out(delim);
  }
@.\\\\@>
@.\\.@>
}
else out('&') /* |a==res_word| */
@.\\\&@>
if (length(cur_name)==1) {
  if (isxalpha((cur_name->byte_start)[0]))
    out('\\');
  out((cur_name->byte_start)[0]);
}
else out_name(cur_name);

@ The current mode does not affect the behavior of \.{WEAVE}'s output routine
except when we are outputting control tokens.

@<Output a control...@>=
if (a<break_space || a==preproc_line) {
  if (cur_mode==outer) {
    out('\\'); out(a-cancel+'0');
@.\\1@>
@.\\2@>
@.\\3@>
@.\\4@>
@.\\8@>
    if (a==opt) out(get_output()); /* |opt| is followed by a digit */
    }
  else if (a==opt) b=get_output(); /* ignore digit following |opt| */
  }
else @<Look ahead for strongest line break, |goto reswitch|@>

@ If several of the tokens |break_space|, |force|, |big_force| occur in a
row, possibly mixed with blank spaces (which are ignored),
the largest one is used. A line break also occurs in the output file,
except at the very end of the translation. The very first line break
is suppressed (i.e., a line break that follows `\.{\\Y\\B}').

@<Look ahead for st...@>= {
  b=a; save_mode=cur_mode; c=0;
  while (1) {
    a=get_output();
    if (a==cancel || a==big_cancel) {
      @<Output saved |indent| or |outdent| tokens@>;
      goto reswitch; /* |cancel| overrides everything */
    }
    if ((a!=' ' && a<indent) || a==backup || a>big_force) {
      if (save_mode==outer) {
        if (out_ptr>out_buf+3 && strncmp(out_ptr-3,"\\Y\\B",4)==0)
          goto reswitch;
        @<Output saved |indent| or |outdent| tokens@>;
        out('\\'); out(b-cancel+'0');
@.\\5@>
@.\\6@>
@.\\7@>
        if (a!=end_translation) finish_line();
      }
      else if (a!=end_translation && cur_mode==inner) out(' ');
      goto reswitch;
    }
    if (a==indent) c++;
    else if (a==outdent) c--;
    else if (a==opt) a=get_output();
    else if (a>b) b=a; /* if |a==' '| we have |a<b| */
  }
}

@ @<Output saved...@>=
  for (;c>0;c--) out_str("\\1");
@.\\1@>
  for (;c<0;c++) out_str("\\2");
@.\\2@>

@ The remaining part of |make_output| is somewhat more complicated. When we
output a module name, we may need to enter the parsing and translation
routines, since the name may contain \Cee\ code embedded in
\pb\ constructions. This \Cee\ code is placed at the end of the active
input buffer and the translation process uses the end of the active
|tok_mem| area.

@<Output a module name@>= {
  out_str("\\X");
@.\\X@>
  cur_xref=(xref_pointer)cur_name->xref;
  if (cur_xref->num==file_flag) {an_output=1; cur_xref=cur_xref->xlink;}
  else an_output=0;
  if (cur_xref->num>=def_flag) {
    out_mod(cur_xref->num-def_flag);
    if (phase==3) {
      cur_xref=cur_xref->xlink;
      while (cur_xref->num>=def_flag) {
        out_str(", ");
        out_mod(cur_xref->num-def_flag);
      cur_xref=cur_xref->xlink;
      }
    }
  }
  else out('0'); /* output the module number, or zero if it was undefined */
  out(':');
  if (an_output) out_str("\\.{");
@.\\.@>
  @<Output the text of the module name@>;
  if (an_output) out_str(" }");
  out_str("\\X");
}

@ @<Output the text...@>=
k=cur_name->byte_start; k_limit=(cur_name+1)->byte_start;
cur_mod_name=cur_name;
while (k<k_limit) {
  b=*(k++);
  if (b=='@@') @<Skip next character, give error if not `\.{@@}'@>;
  if (an_output)
    switch (b) {
 case  ' ':case '\\':case '#':case '%':case '$':case '^':
 case '{': case '}': case '~': case '&': case '_':
    out('\\'); /* falls through */
 default: out(b);
    }
  else if (b!='|') out(b)
  else {
    @<Copy the \Cee\ text into the |buffer| array@>;
    save_loc=loc; save_limit=limit; loc=limit+2; limit=j+1;
    *limit='|'; output_C();
    loc=save_loc; limit=save_limit;
  }
}

@ @<Skip next char...@>=
if (*k++!='@@') {
  printf("\n! Illegal control code in section name: <");
@.Illegal control code...@>
  print_id(cur_mod_name); printf("> "); mark_error;
}

@ The \Cee\ text enclosed in \pb\ should not contain `\.{\v}' characters,
except within strings. We put a `\.{\v}' at the front of the buffer, so that an
error message that displays the whole buffer will look a little bit sensible.
The variable |delim| is zero outside of strings, otherwise it
equals the delimiter that began the string being copied.

@<Copy the \Cee\ text into...@>=
j=limit+1; *j='|'; delim=0;
while (1) {
  if (k>=k_limit) {
    printf("\n! C text in section name didn't end: <");
@.C text...didn't end@>
    print_id(cur_mod_name); printf("> "); mark_error; break;
  }
  b=*(k++);
  if (b=='@@') @<Copy a control code into the buffer@>
  else {
    if (b=='\'' || b=='"')
      if (delim==0) delim=b;
      else if (delim==b) delim=0;
    if (b!='|' || delim!=0) {
      if (j>buffer+long_buf_size-3) overflow("buffer");
      *(++j)=b;
    }
    else break;
  }
}

@ @<Copy a control code into the buffer@>= {
  if (j>buffer+long_buf_size-4) overflow("buffer");
  *(++j)='@@'; *(++j)=*(k++);
}

@* Phase two processing.
We have assembled enough pieces of the puzzle in order to be ready to specify
the processing in \.{WEAVE}'s main pass over the source file. Phase two
is analogous to phase one, except that more work is involved because we must
actually output the \TeX\ material instead of merely looking at the
\.{WEB} specifications.

@c phase_two() {
reset_input(); if (show_progress) printf("\nWriting the output file...");
@.Writing the output file...@>
module_count=0; format_visible=1; copy_limbo();
finish_line(); flush_buffer(out_buf,0,0); /* insert a blank line, it looks nice */
while (!input_has_ended) @<Translate the current module@>;
}

@ The output file will contain the control sequence \.{\\Y} between non-null
sections of a module, e.g., between the \TeX\ and definition parts if both
are nonempty. This puts a little white space between the parts when they are
printed. However, we don't want \.{\\Y} to occur between two definitions
within a single module. The variables |out_line| or |out_ptr| will
change if a section is non-null, so the following macros `|save_position|'
and `|emit_space_if_needed|' are able to handle the situation:

@d save_position save_line=out_line; save_place=out_ptr
@d emit_space_if_needed if (save_line!=out_line || save_place!=out_ptr)
  out_str("\\Y");
  space_checked=1
@.\\Y@>

@<Global...@>=
int save_line; /* former value of |out_line| */
char *save_place; /* former value of |out_ptr| */
boolean space_checked; /* have we done |emit_space_if_needed|? */
boolean format_visible; /* should the next format declaration be output? */

@ @<Translate the current module@>= {
  module_count++;
  @<Output the code for the beginning of a new module@>;
  save_position;
  @<Translate the \TeX\ part of the current module@>;
  @<Translate the definition part of the current module@>;
  @<Translate the \Cee\ part of the current module@>;
  @<Show cross-references to this module@>;
  @<Output the code for the end of a module@>;
}

@ Modules beginning with the \.{WEB} control sequence `\.{@@\ }' start in the
output with the \TeX\ control sequence `\.{\\M}', followed by the module
number. Similarly, `\.{@@*}' modules lead to the control sequence `\.{\\N}'.
If this is a changed module, we put \.{*} just before the module number.

@<Output the code for the beginning...@>=
if (*(loc-1)!='*') out_str("\\M");
@.\\M@>
else {
  out_str("\\N");
@.\\N@>
  if (show_progress)
  printf("*%d",module_count); update_terminal; /* print a progress report */
}
out_mod(module_count); out_str(". ");

@ In the \TeX\ part of a module, we simply copy the source text, except that
index entries are not copied and \Cee\ text within \pb\ is translated.

@<Translate the \T...@>= do {
  next_control=copy_TeX();
  switch (next_control) {
    case '|': init_stack; output_C(); break;
    case '@@': out('@@'); break;
    case TeX_string: case noop:
    case xref_roman: case xref_wildcard: case xref_typewriter:
    case module_name: loc-=2; next_control=get_next(); /* skip to \.{@@>} */
      if (next_control==TeX_string)
        err_print("! TeX string should be in C text only"); break;
@.TeX string should be...@>
    case thin_space: case math_break: case ord:
    case line_break: case big_line_break: case no_line_break: case join:
    case pseudo_semi: case macro_arg_open: case macro_arg_close:
        err_print("! You can't do that in TeX text"); break;
@.You can't do that...@>
  }
} while (next_control<format_code);

@ When we get to the following code we have |next_control>=format_code|, and
the token memory is in its initial empty state.

@<Translate the d...@>=
space_checked=0;
while (next_control<=definition) { /* |format_code| or |definition| */
  init_stack;
  if (next_control==definition) @<Start a macro definition@>@;
  else @<Start a format definition@>;
  outer_parse(); finish_C(format_visible); format_visible=1;
}

@ The |finish_C| procedure outputs the translation of the current
scraps, preceded by the control sequence `\.{\\B}' and followed by the
control sequence `\.{\\par}'. It also restores the token and scrap
memories to their initial empty state.

A |force| token is appended to the current scraps before translation
takes place, so that the translation will normally end with \.{\\6} or
\.{\\7} (the \TeX\ macros for |force| and |big_force|). This \.{\\6} or
\.{\\7} is replaced by the concluding \.{\\par} or by \.{\\Y\\par}.

@c finish_C(visible) /* finishes a definition or a \Cee\ part */
  boolean visible; /* nonzero if we should produce \TeX\ output */
{
  text_pointer p; /* translation of the scraps */
  if (visible) {
    out_str("\\B"); app_tok(force); app_scrap(insert,no_math);
    p=translate();
@.\\B@>
    app(p-tok_start+tok_flag); make_output(); /* output the list */
    if (out_ptr>out_buf+1)
      if (*(out_ptr-1)=='\\')
@.\\6@>
@.\\7@>
@.\\Y@>
        if (*out_ptr=='6') out_ptr-=2;
        else if (*out_ptr=='7') *out_ptr='Y';
    out_str("\\par"); finish_line();
  }
#ifdef STAT
  if (text_ptr>max_text_ptr) max_text_ptr=text_ptr;
  if (tok_ptr>max_tok_ptr) max_tok_ptr=tok_ptr;
  if (scrap_ptr>max_scr_ptr) max_scr_ptr=scrap_ptr;
#endif STAT
  tok_ptr=tok_mem+1; text_ptr=tok_start+1; scrap_ptr=scrap_info;
    /* forget the tokens and the scraps */
}

@ Keeping in line with the conventions of the \Cee\ preprocessor (and
otherwise contrary to the rules of \.{WEB}) we distinguish here
between the case that `\.(' immediately follows an identifier and the
case that the two are separated by a space.  In the latter case, and
if the identifier is not followed by `\.(' at all, the replacement
text starts immediately after the identifier.  In the former case,
it starts after we scan the matching `\.)'.

@<Start a macro...@>= {
  if (save_line!=out_line || save_place!=out_ptr)  app(backup);
  if(!space_checked){emit_space_if_needed;save_position;}
  app_str("\\D"); /* this will produce `\&{define }' */
@.\\D@>
  if ((next_control=get_next())!=identifier)
    err_print("! Improper macro definition");
@.Improper macro definition@>
  else {
    app('$'); app(id_flag+id_lookup(id_first, id_loc,normal)-name_dir);
    if (*loc=='(')
  reswitch: switch (next_control=get_next()) {
      case '(': case ',': app(next_control); goto reswitch;
      case identifier: app(id_flag+id_lookup(id_first, id_loc,normal)-name_dir); goto reswitch;
      case ')': app(next_control); next_control=get_next(); break;
      default: err_print("! Improper macro definition"); break;
    }
    else next_control=get_next();
    app_str("$ "); app(break_space);
    app_scrap(dead,no_math); /* scrap won't take part in the parsing */
  }
}

@ @<Start a format...@>= {
  if(*(loc-1)=='s' || *(loc-1)=='S') format_visible=0;
  if(!space_checked){emit_space_if_needed;save_position;}
  app_str("\\F"); /* this will produce `\&{format }' */
@.\\F@>
  next_control=get_next();
  if (next_control==identifier) {
    app(id_flag+id_lookup(id_first, id_loc,normal)-name_dir);
    app(' ');
    app(break_space); /* this is syntactically separate from what follows */
    next_control=get_next();
    if (next_control==identifier) {
      app(id_flag+id_lookup(id_first, id_loc,normal)-name_dir);
      app_scrap(exp,maybe_math); app_scrap(semi,maybe_math);
      next_control=get_next();
    }
  }
  if (scrap_ptr!=scrap_info+2) err_print("! Improper format definition");
@.Improper format definition@>
}

@ Finally, when the \TeX\ and definition parts have been treated, we have
|next_control>=begin_C|. We will make the global variable |this_module|
point to the current module name, if it has a name.

@<Global...@>=
name_pointer this_module; /* the current module name, or zero */

@ @<Translate the \Cee...@>=
this_module=name_dir;
if (next_control<=module_name) {
  emit_space_if_needed; init_stack;
  if (next_control==begin_C) next_control=get_next();
  else {
    this_module=cur_module;
    @<Check that |=| or |==| follows this module name, and
      emit the scraps to start the module definition@>;
  }
  while  (next_control<=module_name) {
    outer_parse();
    @<Emit the scrap for a module name if present@>;
  }
  finish_C(1);
}

@ @<Check that |=|...@>=
do next_control=get_next();
  while (next_control=='+'); /* allow optional `\.{+=}' */
if (next_control!='=' && next_control!=eq_eq)
  err_print("! You need an = sign after the section name");
@.You need an = sign...@>
  else next_control=get_next();
if (out_ptr>out_buf+1 && *out_ptr=='Y' && *(out_ptr-1)=='\\') app(backup);
    /* the module name will be flush left */
@.\\Y@>
app(mod_flag+this_module-name_dir);
cur_xref=(xref_pointer)this_module->xref;
if(cur_xref->num==file_flag) cur_xref=cur_xref->xlink;
app_str("${}");
if (cur_xref->num!=module_count+def_flag) {
  app_str("\\mathrel+"); /*module name is multiply defined*/
  this_module=name_dir; /*so we won't give cross-reference info here*/
}
app_str("\\E"); /* output an equivalence sign */
@.\\E@>
app_str("{}$");
app(force); app_scrap(stmt,no_math);
 /* this forces a line break unless `\.{@@+}' follows */

@ @<Emit the scrap...@>=
if (next_control<module_name) {
  err_print("! You can't do that in C text");
@.You can't do that...@>
  next_control=get_next();
}
else if (next_control==module_name) {
  app(mod_flag+cur_module-name_dir); app_scrap(mod_scrap,maybe_math);
  next_control=get_next();
}

@ Cross references relating to a named module are given after the module ends.

@<Show cross...@>=
if (this_module>name_dir) {
  @<Rearrange the list pointed to by |cur_xref|@>;
  footnote(def_flag); footnote(0);
}

@ To rearrange the order of the linked list of cross-references, we need
four more variables that point to cross-reference entries.  We'll end up
with a list pointed to by |cur_xref|.

@<Global...@>=
xref_pointer next_xref, this_xref, first_xref, mid_xref;
  /* pointer variables for rearranging a list */

@ We want to rearrange the cross-reference list so that all the entries with
|def_flag| come first, in ascending order; then come all the other
entries, in ascending order.  There may be no entries in either one or both
of these categories.

@<Rearrange the list...@>=
  first_xref=(xref_pointer)this_module->xref;
  if (first_xref->num==file_flag){an_output=1;first_xref=first_xref->xlink;}
  else an_output=0;
  this_xref=first_xref->xlink; /* bypass current module number */
  if (this_xref->num>def_flag) {
    mid_xref=this_xref; cur_xref=0; /* this value doesn't matter */
  do {
    next_xref=this_xref->xlink; this_xref->xlink=cur_xref;
    cur_xref=this_xref; this_xref=next_xref;
  } while (this_xref->num>def_flag);
  first_xref->xlink=cur_xref;
}
else mid_xref=xmem; /* first list null */
cur_xref=xmem;
while (this_xref!=xmem) {
  next_xref=this_xref->xlink; this_xref->xlink=cur_xref;
  cur_xref=this_xref; this_xref=next_xref;
}
if (mid_xref>xmem) mid_xref->xlink=cur_xref;
else first_xref->xlink=cur_xref;
cur_xref=first_xref->xlink;

@ The |footnote| procedure gives cross-reference information about
multiply defined module names (if the |flag| parameter is |def_flag|), or about
the uses of a module name (if the |flag| parameter is zero). It assumes that
|cur_xref| points to the first cross-reference entry of interest, and it
leaves |cur_xref| pointing to the first element not printed.  Typical outputs:
`\.{\\A101.}'; `\.{\\Us 370\\ET1009.}';
`\.{\\As 8, 27\\*, \\ETs64.}'.

@c footnote(flag) /* outputs module cross-references */
sixteen_bits flag;
{
  xref_pointer q; /* cross-reference pointer variable */
  if (cur_xref->num<=flag) return;
  finish_line(); out('\\');
@.\\A@>
@.\\U@>
  if (flag==0) out('U')@+else out('A');
  @<Output all the module numbers on the reference list |cur_xref|@>;
  out('.');
}

@ The following code distinguishes three cases, according as the number
of cross-references is one, two, or more than two. Variable |q| points
to the first cross-reference, and the last link is a zero.

@<Output all the module numbers...@>=
q=cur_xref; if (q->xlink->num>flag) out('s'); /* plural */
while (1) {
  out_mod(cur_xref->num-flag);
  cur_xref=cur_xref->xlink; /* point to the next cross-reference to output */
  if (cur_xref->num<=flag) break;
  if (cur_xref->xlink->num>flag) out_str(", "); /* not the last */
  else {out_str("\\ET"); /* the last */
  if (cur_xref != q->xlink) out('s'); /* the last of more than two */
  }
}

@ @<Output the code for the end of a module@>=
out_str("\\fi"); finish_line();
@.\\fi@>
flush_buffer(out_buf,0,0); /* insert a blank line, it looks nice */

@* Phase three processing.
We are nearly finished! \.{WEAVE}'s only remaining task is to write out the
index, after sorting the identifiers and index entries.

If the user has set the |no_xref| flag (the |-x| option on the command line),
just finish off the page, omitting the index, module name list, and table of
contents.

@c phase_three() {
if (no_xref) {
  finish_line();
  out_str("\\vfill\\end");
  finish_line();
}
else {
  phase=3; if (show_progress) printf("\nWriting the index...");
@.Writing the index...@>
  if (change_exists) {
    finish_line(); @<Tell about changed modules@>;
  }
  finish_line(); out_str("\\inx"); finish_line();
@.\\inx@>
  @<Do the first pass of sorting@>;
  @<Sort and output the index@>;
  out_str("\\fin"); finish_line();
@.\\fin@>
  @<Output all the module names@>;
  out_str("\\con"); finish_line();
@.\\con@>
}
if (show_happiness) printf("\nDone.");
check_complete(); /* was all of the change file used? */
}

@ Just before the index comes a list of all the changed modules, including
the index module itself.

@<Global...@>=
sixteen_bits k_module; /* runs through the modules */

@ @<Tell about changed modules@>= {
  /* remember that the index is already marked as changed */
  k_module=0;
  while (!changed_module[++k_module]);
  out_str("\\ch ");
  out_mod(k_module);
  while (1) {
    while (!changed_module[++k_module]);
    out_str(", "); out_mod(k_module);
    if (k_module==module_count) break;
  }
  out('.');
}

@ A left-to-right radix sorting method is used, since this makes it easy to
adjust the collating sequence and since the running time will be at worst
proportional to the total length of all entries in the index. We put the
identifiers into 102 different lists based on their first characters.
(Uppercase letters are put into the same list as the corresponding lowercase
letters, since we want to have `$t<\\{TeX}<\&{to}$'.) The
list for character |c| begins at location |bucket[c]| and continues through
the |blink| array.

@<Global...@>=
name_pointer bucket[128];
name_pointer next_name; /* successor of |cur_name| when sorting */
hash_pointer h; /* index into |hash| */
name_pointer blink[max_names]; /* links in the buckets */

@ To begin the sorting, we go through all the hash lists and put each entry
having a nonempty cross-reference list into the proper bucket.

@<Do the first pass...@>= {
int c;
for (c=0; c<=127; c++) bucket[c]=NULL;
for (h=hash; h<=hash_end; h++) {
  next_name=*h;
  while (next_name) {
    cur_name=next_name; next_name=cur_name->link;
    if (cur_name->xref!=(char*)xmem) {
      c=(cur_name->byte_start)[0];
      if (isupper(c)) c=tolower(c);
      blink[cur_name-name_dir]=bucket[c]; bucket[c]=cur_name;
    }
  }
}
}

@ During the sorting phase we shall use the |cat| and |trans| arrays from
\.{WEAVE}'s parsing algorithm and rename them |depth| and |head|. They now
represent a stack of identifier lists for all the index entries that have
not yet been output. The variable |sort_ptr| tells how many such lists are
present; the lists are output in reverse order (first |sort_ptr|, then
|sort_ptr-1|, etc.). The |j|th list starts at |head[j]|, and if the first
|k| characters of all entries on this list are known to be equal we have
|depth[j]=k|.

@ @<Rest of |trans_plus| union@>=
name_pointer Head;

@
@d depth cat /* reclaims memory that is no longer needed for parsing */
@d head trans_plus.Head /* ditto */
@f sort_pointer int
@d sort_pointer scrap_pointer /* ditto */
@d sort_ptr scrap_ptr /* ditto */
@d max_sorts max_scraps /* ditto */

@<Global...@>=
eight_bits cur_depth; /* depth of current buckets */
char *cur_byte; /* index into |byte_mem| */
sixteen_bits cur_val; /* current cross-reference number */
#ifdef STAT
sort_pointer max_sort_ptr; /* largest value of |sort_ptr| */
#endif STAT

@ @<Set init...@>=
#ifdef STAT
max_sort_ptr=scrap_info;
#endif STAT


@ The desired alphabetic order is specified by the |collate| array; namely,
|collate[0]<collate[1]<@t$\cdots$@><collate[100]|.

@<Global...@>=
char collate[102]; /* collation order */

@ We use the order $\hbox{null}<\.\ <\hbox{other characters}<{}$\.\_${}<
\.A=\.a<\cdots<\.Z=\.z<\.0<\cdots<\.9.$ Warning: The collation mapping
needs to be changed if ASCII code is not being used.
@^ASCII code dependencies@>

@<Set init...@>=
collate[0]=0; strcpy(collate+1," \1\2\3\4\5\6\7\10\11\12\13\14\15\16\17\
\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37\
!\42#$%&'()*+,-./:;<=>?@@[\\]^`{|}~_\
abcdefghijklmnopqrstuvwxyz0123456789");

@ Procedure |unbucket| goes through the buckets and adds nonempty lists
to the stack, using the collating sequence specified in the |collate| array.
The parameter to |unbucket| tells the current depth in the buckets.
Any two sequences that agree in their first 255 character positions are
regarded as identical.

@d infinity 255 /* $\infty$ (approximately) */

@c unbucket(d) /* empties buckets having depth |d| */
eight_bits d;
{
  int c;  /* index into |bucket|; cannot be a simple |char| because of sign
    comparison below*/
  for (c=100; c>= 0; c--) if (bucket[collate[c]]) {
    if (sort_ptr>=scrap_info_end) overflow("sorting");
    sort_ptr++;
#ifdef STAT
    if (sort_ptr>max_sort_ptr) max_sort_ptr=sort_ptr;
#endif STAT
    if (c==0) sort_ptr->depth=infinity;
    else sort_ptr->depth=d;
    sort_ptr->head=bucket[collate[c]]; bucket[collate[c]]=NULL;
  }
}

@ @<Sort and output...@>=
sort_ptr=scrap_info; unbucket(1);
while (sort_ptr>scrap_info) {
  cur_depth=sort_ptr->depth;
  if (blink[sort_ptr->head-name_dir]==0 || cur_depth==infinity)
    @<Output index entries for the list at |sort_ptr|@>@;
  else @<Split the list at |sort_ptr| into further lists@>;
}

@ @<Split the list...@>= {
  char c;
  next_name=sort_ptr->head;
  do {
    cur_name=next_name; next_name=blink[cur_name-name_dir];
    cur_byte=cur_name->byte_start+cur_depth;
    if (cur_byte==(cur_name+1)->byte_start) c=0; /* hit end of the name */
    else {
      c=*cur_byte;
      if (isupper(c)) c=tolower(c);
    }
  blink[cur_name-name_dir]=bucket[c]; bucket[c]=cur_name;
  } while (next_name);
  --sort_ptr; unbucket(cur_depth+1);
}

@ @<Output index...@>= {
  cur_name=sort_ptr->head;
  do {
    out_str("\\I");
@.\\I@>
    @<Output the name at |cur_name|@>;
    @<Output the cross-references at |cur_name|@>;
    cur_name=blink[cur_name-name_dir];
  } while (cur_name);
  --sort_ptr;
}

@ @<Output the name...@>=
switch (cur_name->ilk) {
  case normal: if (length(cur_name)==1) out_str("\\|");
    else {char *j;
      for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
        if (islower(*j)) goto lowcase;
      out_str("\\."); break;
lowcase: out_str("\\\\");
    }
  break;
@.\\|@>
@.\\.@>
@.\\\\@>
  case roman: break;
  case wildcard: out_str("\\9"); break;
@.\\9@>
  case typewriter: out_str("\\."); break;
@.\\.@>
  case custom: case quoted: {char *j; out_str("$\\");
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      out(isxalpha(*j)? 'x' : *j);
    out('$');
    goto name_done;
    }
  default: out_str("\\&");
@.\\\&@>
}
out_name(cur_name);
name_done:

@ Section numbers that are to be underlined are enclosed in
`\.{\\[}$\,\ldots\,$\.]'.

@<Output the cross-references...@>=
@<Invert the cross-reference list at |cur_name|, making |cur_xref| the head@>;
do {
  out_str(", "); cur_val=cur_xref->num;
  if (cur_val<def_flag) out_mod(cur_val);
  else {out_str("\\["); out_mod(cur_val-def_flag); out(']');}
@.\\[@>
  cur_xref=cur_xref->xlink;
} while (cur_xref!=xmem);
out('.'); finish_line();

@ List inversion is best thought of as popping elements off one stack and
pushing them onto another. In this case |cur_xref| will be the head of
the stack that we push things onto.

@<Invert the cross-reference list at |cur_name|, making |cur_xref| the head@>=
this_xref=(xref_pointer)cur_name->xref; cur_xref=xmem;
do {
  next_xref=this_xref->xlink; this_xref->xlink=cur_xref;
  cur_xref=this_xref; this_xref=next_xref;
} while (this_xref!=xmem);

@ The following recursive procedure walks through the tree of module names and
prints them.
@^recursion@>

@c mod_print(p) /* print all module names in subtree |p| */
name_pointer p;
{
  if (p) {
    mod_print(p->llink); out_str("\\I");
@.\\I@>
    tok_ptr=tok_mem+1; text_ptr=tok_start+1; scrap_ptr=scrap_info; init_stack;
    app(p-name_dir+mod_flag); make_output();
    footnote(0); /* |cur_xref| was set by |make_output| */
    finish_line();@/
    mod_print(p->rlink);
  }
}

@ @<Output all the module names@>=mod_print(root)

@ @c
#ifdef STAT
print_stats() {
  printf("\nMemory usage statistics:\n");
@.Memory usage statistics:@>
  printf("%d names (out of %d)\n",name_ptr-name_dir,max_names);
  printf("%d cross-references (out of %d)\n",xref_ptr-xmem,max_refs);
  printf("%d bytes (out of %d)\n",byte_ptr-byte_mem,max_bytes);
  printf("Parsing:\n");
  printf("%d scraps (out of %d)\n",max_scr_ptr-scrap_info,max_scraps);
  printf("%d texts (out of %d)\n",max_text_ptr-tok_start,max_texts);
  printf("%d tokens (out of %d)\n",max_tok_ptr-tok_mem,max_toks);
  printf("%d levels (out of %d)\n",max_stack_ptr-stack,stack_size);
  printf("Sorting:\n");
  printf("%d levels (out of %d)\n",max_sort_ptr-scrap_info,max_scraps);
}
#endif

@* Index.
If you have read and understood the code for Phase III above, you know what
is in this index and how it got here. All modules in which an identifier is
used are listed with that identifier, except that reserved words are
indexed only when they appear in format definitions, and the appearances
of identifiers in module names are not indexed. Underlined entries
correspond to where the identifier was declared. Error messages, control
sequences put into the output, and a few
other things like ``recursion'' are indexed here too.
