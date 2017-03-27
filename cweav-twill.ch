@x
% This file is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
@y
% This program by Don Knuth is based on CWEAVE by Levy and Knuth.
% It's somewhat flaky, so you probably shouldn't try to use it.
@z

@x
% (essentially the same as version 3.6, which added
%  recently introduced features of standard C++ to version 3.4)
% (In November 2016 I made minor adjustments but changed no code -- DEK)
@y
@z

@x
% Here is TeX material that gets inserted after \input cwebmac
@y
% Here is TeX material that gets inserted after \input ctwimac
@z

@x
\def\title{CWEAVE (Version 3.64)}
@y
\def\title{CTWILL (Version 3.64)}
@z

@x
  \centerline{\titlefont The {\ttitlefont CWEAVE} processor}
@y
  \centerline{\titlefont The {\ttitlefont CTWILL} processor}
@z

@x
This is the \.{CWEAVE} program by Silvio Levy and Donald E. Knuth,
based on \.{WEAVE} by Knuth.
We are thankful to Steve Avery,
Nelson Beebe, Hans-Hermann Bode (to whom the original \CPLUSPLUS/ adaptation
is due), Klaus Guntermann, Norman Ramsey, Tomas Rokicki, Joachim Schnitter,
Joachim Schrod, Lee Wittenberg, Saroj Mahapatra, Cesar Augusto Rorato
Crusius, and others who have contributed improvements.

The ``banner line'' defined here should be changed whenever \.{CWEAVE}
is modified.

@d banner "This is CWEAVE (Version 3.64)\n"
@y
This is the \.{CTWILL} program by D. E. Knuth, based
on \.{CWEAVE} by Silvio Levy and D.~E. Knuth. It is also based on
\.{TWILL}, a private \.{WEB} program that Knuth wrote to produce
Volumes B and~D of {\sl Computers {\char`\&} Typesetting\/} in 1985.
\.{CTWILL} was hacked together hastily in June, 1992, to generate pages for
Knuth's book about the Stanford GraphBase, and updated even more hastily
in March, 1993 to generate final copy for that book.  The main idea was to
extend \.{CWEAVE} so that ``mini-indexes'' could appear.
No time was available to make \.{CTWILL} into a refined or complete system,
nor even to fully update the program documentation below. Subsequent changes
were made only to maintain compatibility with \.{CWEAVE}. Further information
can be found in Knuth's article ``Mini-indexes for literate programs,''
reprinted in {\sl Digital Typography\/} (1999), 225--245.

The ``banner line'' defined here should be changed whenever \.{CTWILL} is
modified. The version number parallels the corresponding version of \.{CWEAVE}.

@d banner "This is CTWILL (Version 3.64)\n"
@z

@x
extern char* strncpy(); /* copy up to $n$ string characters */
@y
extern char* strncpy(); /* copy up to $n$ string characters */

@ Here is a sort of user manual for \.{CTWILL}---which is exactly like
\.{CWEAVE} except that it produces much better documentation, for which you
must work harder. As with \.{CWEAVE}, input comes from a source file
\.{foo.w} and from an optional (but now almost mandatory) change file
\.{foo.ch}; output goes to \.{foo.tex}, \.{foo.idx}, and \.{foo.scn}.
Unlike \.{CWEAVE}, there is an additional output file, \.{foo.aux},
which records all nonexternal definitions.  The \.{.aux} file also
serves as an input file on subsequent runs. You should run \.{CTWILL}
twice, once to prime the pump and once to get decent answers.

Moreover, you must run the output twice through \TeX. (This double duplicity
suggested the original name \.{TWILL}.) After `\.{tex} \.{foo}' you
will have output that looks like final pages except that the entries
of mini-indexes won't be alphabetized. \TeX\ will say `This is the first
pass', and it will produce a weird file called \.{foo.ref}. Say
$$\.{refsort < foo.ref > foo.sref}$$
and then another `\.{tex} \.{foo}' will produce alphabetized output.
While \TeX\ runs it emits messages filled with numeric data, indicating how
much space is consumed by each program section. If you can decipher these
numbers (see \.{ctwimac.tex}), you can use them to fine-tune the page
layout. You might be tempted to do fine tuning by editing \.{foo.tex}
directly, but it's better to incorporate all changes into \.{foo.ch}.

The mini-indexes list identifiers that are used but not defined on
each two-page spread. At the end of each section, \.{CTWILL} gives
\TeX\ a list of identifiers used in that section and information
about where they are defined. The macros in \.{ctwimac.tex} figure out
which identifiers should go in each mini-index, based on how the pages
break. (Yes, those macros are pretty hairy.)

The information that \.{CTWILL} concocts from \.{foo.w} is not always
correct. Sometimes you'll use an identifier that you don't want
indexed; for example, your exposition might talk about |f(x)| when you
don't mean to refer to program variables |f| or |x|. Sometimes you'll
use an identifier that's defined in a header file, unknown to
\.{CTWILL}. Sometimes you'll define a single identifier in several
different places, and \.{CTWILL} won't know which definition to choose.
But all is not lost. \.{CTWILL} guesses right most of the time, and you can
give it the necessary hints in other places via your change file.

If you think it's easy to write a completely automatic system that doesn't
make \.{CTWILL}'s mistakes and doesn't depend so much on change files,
please do so.

\.{CTWILL} uses a very simple method to generate mini-index info. By
understanding this method, you will understand how to fix it when things
go wrong. Every identifier has a current ``meaning,'' consisting of its
abstract type and the number of the section in which it was most recently
defined. For example, if your \Cee\ program says `|char *s|' in section~3,
the meaning of~|s| gets changed to `\&{char} $*$, \S3' while \.{CTWILL}
is processing that section. If you refer to~|s| in section~10, and if
|s|~hasn't been redefined in the meantime, and if section~10 doesn't
wind up on the same two-page spread as section~3, the mini-index generated
by section~10 will say ``|s|: \&{char}~$*$, \S3.''

The current meaning of every identifier is initially `\.{\\uninitialized}'.
Then \.{CTWILL} reads the \.{.aux} file for your job, if any; this
\.{.aux} file contains all definitions of new meanings in the previous
run, so it tells \.{CTWILL} about definitions that will be occurring
in the future. If all identifiers have a unique definition, they will
have a unique and appropriate meaning in the mini-indexes.

But some identifiers, like parameters to procedures, may be defined
several times. Others may not be defined at all, because they are
defined elsewhere and mentioned in header files included by the \Cee\
preprocessor. To solve this problem, \.{CTWILL} provides mechanisms by which
the current meaning of an identifier can be temporarily or permanently
changed.

For example, the operation
$$\.{@@\$s \{FOO\}3 \\\&\{char\} \$*\$@@>}$$
changes the current meaning of |s| to the \TeX\ output of `\.{\\\&\{char\}}
\.{\$*\$}' in section~3 of program {\sc FOO}. All entries in the \.{.aux}
file are expressed in the form of this \.{@@\$} operator; therefore you
can use a text editor to paste such entries into a \.{.ch} file, whenever
you want to tell \.{CTWILL} about definitions that are out of order
or from other programs.

Before reading the \.{.aux} file, \.{CTWILL} actually looks for a file
called \.{system.bux}, which will be read if present. And after
\.{foo.aux}, a third possibility is \.{foo.bux}. The general
convention is to put definitions of system procedures such as |printf|
into \.{system.bux}, and to put definitions found in specifically
foo-ish header files into \.{foo.bux}. Like the \.{.aux}
files, \.{.bux} files should contain only \.{@@\$} specifications;
this rule corresponds to the fact that `bux' is the plural of `\$'.
The \.{.bux} files may also contain \.{@@i} includes.

A companion operation \.{@@\%} signifies that all \.{@@\$}
specifications from the present point to the beginning of the next
section will define {\it temporary\/} meanings instead of permanent
ones. Temporary meanings are placed into the
mini-index of the current section; the permanent (current) meaning of
the identifier will not be changed, nor will it appear in the
mini-index of the section. If several temporary meanings are assigned
to the same identifier in a section, all will appear in the mini-index.
Each \.{@@\%} toggles the temporary/permanent convention; thus, after
an even number of \.{@@\%} operations in a section, meanings specified
by \.{@@\$} are permanent.

The operation \.{@@-} followed by an identifier followed by \.{@@>}
specifies that the identifier should not generate a mini-index entry
in the current section (unless, of course, a temporary meaning is assigned).

If \.{@@-foo@@>} appears in a section where a new permanent meaning is
later defined by the semantics of~\Cee, the current meaning of \\{foo}
will not be redefined; moreover, this current meaning, which may have
been changed by \.{@@\$foo ...@@>}, will also be written to the
\.{.aux} file. Therefore you can control what \.{CTWILL} outputs; you
can keep it from repeatedly contaminating the \.{.aux} file with
things you don't like.

The meaning specified by \.{@@\$...@@>} generally has four components:
an identifier (followed by space), a program name (enclosed in braces),
a section number (followed by space), and a \TeX\ part. The \TeX\ part
must have fewer than 50 characters. If the \TeX\ part starts
with `\.=', the mini-index entry will contain an equals sign instead
of a colon; for example,
$$\.{@@\$buf\_size \{PROG\}10 =\\T\{200\}@@>}$$
generates either `$\\{buf\_size}=200$, \S10' or
`$\\{buf\_size}=200$, {\sc PROG}\S10', depending on whether
`{\sc PROG}' is or isn't the title of the current program. If the
\TeX\ part is `\.{\\zip}', the mini-index entry will contain neither
colon nor equals, just a comma. The program name and section number
can also be replaced by a string. For example,
$$\.{@@\$printf "<stdio.h>" \\zip@@>}$$
will generate a mini-index entry like `\\{printf}, \.{<stdio.h>}.'.

A special ``proofmode'' is provided so that you can check \.{CTWILL}'s
conclusions about cross-references. Run \.{CTWILL} with the
flag \.{+P}, and \TeX\ will produce a specially formatted document
({\it without\/} mini-indexes)
in which you can check that your specifications are correct.
You should always do this before generating mini-indexes, because
mini-indexes can mask errors if page breaks are favorable but the
errors might reveal themselves later after your program has changed.
The proofmode output is much easier to check than the mini-indexes themselves.

The control code \.{@@r} or \.{@@R} causes \.{CTWILL} to emit
the \TeX\ macro `\.{\\shortpage}' just before starting the next
section of the program. This causes the section to appear at the top of
a right-hand page, if it would ordinarily have appeared near the bottom
of a left-hand page and split across the pages. (The \.{\\shortpage} macro
is fragile and should be used only in cases where it will not mess up
the output; insert it only when fine-tuning a set of pages.) If the
next section is a starred section, the behavior is slightly different
(but still fragile): The starred section will either be postponed to
a left-hand page, if it normally would begin on a right-hand page,
or vice versa. In other words, \.{@@r@@*} inverts the left/right logic.

\.{CTANGLE} does not recognize the operations \.{@@\$}, \.{@@\%}, \.{@@-},
and \.{@@r}, which are unique to \.{CTWILL}. But that is no problem,
since you use them only in change files set up for book publishing,
which are quite different from the change files you set up for tangling.

(End of user manual. We now resume the program for \.{CWEAVE}, with occasional
outbursts of new code.)

@d max_tex_chars 50 /* limit on the \TeX\ part of a meaning */
@z

@x
turned on during the first phase.

@<Global...@>=
boolean change_exists; /* has any section changed? */
@y
turned on during the first phase---NOT!
@z

@x
sixteen_bits xref_switch,section_xref_switch; /* either zero or |def_flag| */
@y
sixteen_bits xref_switch,section_xref_switch; /* either zero or |def_flag| */

@ \.{CTWILL} also has special data structures to keep track of current
and temporary meanings. These structures were not designed for maximum
efficiency; they were designed to be easily grafted into \.{CWEAVE}'s
existing code without major surgery.

@d max_meanings 100 /* max temporary meanings per section */
@d max_titles 100 /* max distinct program or header names in meanings */

@<Type...@>=
typedef struct {
  name_pointer id; /* identifier whose meaning is being recorded */
  sixteen_bits prog_no; /* title of program or header in which defined */
  sixteen_bits sec_no; /* section number in which defined */
  char tex_part[max_tex_chars]; /* \TeX\ part of meaning */
} meaning_struct;

@ @<Glob...@>=
struct perm_meaning {
  meaning_struct perm; /* current meaning of an identifier */
  int stamp; /* last section number in which further output suppressed */
  struct perm_meaning *link; /* another meaning to output in this section */
} cur_meaning[max_names]; /* the current ``permanent'' meanings */
struct perm_meaning *top_usage; /* first meaning to output in this section */
meaning_struct temp_meaning_stack[max_meanings]; /* the current ``temporary'' meanings */
meaning_struct *temp_meaning_ptr; /* first available slot in |temp_meaning_stack| */
meaning_struct *max_temp_meaning_ptr; /* its maximum value so far */
name_pointer title_code[max_titles]; /* program names seen so far */
name_pointer *title_code_ptr; /* first available slot in |title_code| */
char ministring_buf[max_tex_chars]; /* \TeX\ code being generated */
char *ministring_ptr; /* first available slot in |ministring_buf| */
boolean ms_mode; /* are we outputting to |ministring_buf|? */

@ @<Set init...@>=
max_temp_meaning_ptr=temp_meaning_stack;
title_code_ptr=title_code;
ms_mode=0;

@ Here's a routine that converts a program title from the buffer
into an internal number for the |prog_no| field of a meaning.
It advances |loc| past the title found.

@c sixteen_bits title_lookup()
{
  char *first,*last; /* boundaries */
  int balance; /* excess of left over right */
  register name_pointer *p;
  first=loc;
  if (*loc=='"') {
    while (++loc<=limit && *loc!='"') if (*loc=='\\') loc++;
  } else if (*loc=='{') {
    balance=1;
    while (++loc<=limit) {
      if (*loc=='}' && --balance==0) break;
      if (*loc=='{') balance++;
    }
  } else err_print("! Title should be enclosed in braces or doublequotes");
  last=++loc;
  if (last>limit) err_print("! Title name didn't end");
  if (title_code_ptr==&title_code[max_titles]) overflow("titles");
  *title_code_ptr=id_lookup(first,last,title);
  for (p=title_code;;p++) if (*p==*title_code_ptr) break;
  if (p==title_code_ptr) title_code_ptr++;
  return p-title_code;
}

@ @<Give a default title to the program, if necessary@>=
if (title_code_ptr==title_code) { /* no \.{\\def\\title} found in limbo */
  char *saveloc=loc,*savelimit=limit;
  loc=limit+1; limit=loc;
  *limit++='{';
  strncpy(limit,tex_file_name,strlen(tex_file_name)-4);
  limit+=strlen(tex_file_name)-4;
  *limit++='}';
  title_lookup();
  loc=saveloc; limit=savelimit;
}

@ The |new_meaning| routine changes the current ``permanent meaning''
when an identifier is redeclared. It gets the |tex_part| from
|ministring_buf|.

@c
void
new_meaning(p)
  name_pointer p;
{
  struct perm_meaning *q=p-name_dir+cur_meaning;
  ms_mode=0;
  if (q->stamp!=section_count) {
    if (*(ministring_ptr-1)==' ') ministring_ptr--;
    if (ministring_ptr>=&ministring_buf[max_tex_chars])
      strcpy(ministring_buf,"\\zip"); /* ignore |tex_part| if too long */
@.\\zip@>
    else *ministring_ptr='\0';
    q->perm.prog_no=0; /* |q->perm.id=p| */
    q->perm.sec_no=section_count;
    strcpy(q->perm.tex_part,ministring_buf);
  }
  @<Write the new meaning to the \.{.aux} file@>;
}

@ @<Write the new meaning to the \.{.aux} file@>=
{@+int n=q->perm.prog_no;
  fprintf(aux_file,"@@$%.*s %.*s",@|
     (p+1)->byte_start-p->byte_start,p->byte_start,@|
      (title_code[n]+1)->byte_start-title_code[n]->byte_start,
         title_code[n]->byte_start);
  if (*(title_code[n]->byte_start)=='{') fprintf(aux_file,"%d",q->perm.sec_no);
  fprintf(aux_file," %s@@>\n",q->perm.tex_part);
}
@z

@x
  p->ilk=t; p->xref=(char*)xmem;
@y
  struct perm_meaning *q=p-name_dir+cur_meaning;
  p->ilk=t; p->xref=(char*)xmem;
  q->stamp=0;
  q->link=NULL;
  q->perm.id=p;
  q->perm.prog_no=q->perm.sec_no=0;
  strcpy(q->perm.tex_part,"\\uninitialized");
@z

@x
id_lookup("extern",NULL,int_like);
@y
ext_loc=id_lookup("extern",NULL,int_like)-name_dir;
@z

@x
id_lookup("int",NULL,raw_int);
@y
int_loc=id_lookup("int",NULL,raw_int)-name_dir;
@z

@x
id_lookup("make_pair",NULL,func_template);
@y
id_lookup("make_pair",NULL,func_template);

@ @<Glob...@>=
sixteen_bits int_loc, ext_loc; /* locations of special reserved words */
@z

@x
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
@d translit_code 0223 /* control code for `\.{@@l}' */
@d output_defs_code 0224 /* control code for `\.{@@h}' */
@d format_code 0225 /* control code for `\.{@@f}' and `\.{@@s}' */
@d definition 0226 /* control code for `\.{@@d}' */
@d begin_C 0227 /* control code for `\.{@@c}' */
@d section_name 0230 /* control code for `\.{@@<}' */
@d new_section 0231 /* control code for `\.{@@\ }' and `\.{@@*}' */
@y
@d meaning 0207 /* control code for `\.{@@\$}' */
@d suppress 0210 /* control code for `\.{@@-}' */
@d temp_meaning 0211 /* control code for `\.{@@\%}' */
@d right_start 0212 /* control code for `\.{@@r}' */
@d ord 0213 /* control code for `\.{@@'}' */
@d join 0214 /* control code for `\.{@@\&}' */
@d thin_space 0215 /* control code for `\.{@@,}' */
@d math_break 0216 /* control code for `\.{@@\v}' */
@d line_break 0217 /* control code for `\.{@@/}' */
@d big_line_break 0220 /* control code for `\.{@@\#}' */
@d no_line_break 0221 /* control code for `\.{@@+}' */
@d pseudo_semi 0222 /* control code for `\.{@@;}' */
@d macro_arg_open 0224 /* control code for `\.{@@[}' */
@d macro_arg_close 0225 /* control code for `\.{@@]}' */
@d trace 0226 /* control code for `\.{@@0}', `\.{@@1}' and `\.{@@2}' */
@d translit_code 0227 /* control code for `\.{@@l}' */
@d output_defs_code 0230 /* control code for `\.{@@h}' */
@d format_code 0231 /* control code for `\.{@@f}' and `\.{@@s}' */
@d definition 0232 /* control code for `\.{@@d}' */
@d begin_C 0233 /* control code for `\.{@@c}' */
@d section_name 0234 /* control code for `\.{@@<}' */
@d new_section 0235 /* control code for `\.{@@\ }' and `\.{@@*}' */
@z

@x
ccode['\'']=ord;
@y
ccode['\'']=ord;
ccode['$']=meaning; ccode['%']=temp_meaning; ccode['-']=suppress;
ccode['r']=ccode['R']=right_start;
@z

@x
void   skip_limbo();

@ @c
@y
void   skip_limbo();

@ We look for a clue about the program's title, because this will become
part of all meanings.

@c
@z

@x
    if (loc>limit && get_line()==0) return;
@y
    if (loc>limit && get_line()==0) return;
    if (loc==buffer && strncmp(buffer,"\\def\\title{",11)==0) {
      loc=buffer+10;
      title_lookup(); /* this program's title will be code zero */
    }
@z

@x
\yskip\hang |xref_roman|, |xref_wildcard|, |xref_typewriter|, |TeX_string|,
@y
\yskip\hang |xref_roman|, |xref_wildcard|, |xref_typewriter|, |TeX_string|,
|meaning|, |suppress|,
@z

@x
@d right_preproc 0217 /* ends a preprocessor command */
@y
@d right_preproc 0223 /* ends a preprocessor command */
@z

@x
    case underline: xref_switch=def_flag; continue;
@y
    case underline: xref_switch=def_flag; continue;
    case temp_meaning: temp_switch=1-temp_switch; continue;
    case right_start: right_start_switch=1; continue;
@z

@x
    case noop: case TeX_string: c=ccode[c]; skip_restricted(); return(c);
@y
    case meaning: case suppress:
    case noop: case TeX_string: c=ccode[(eight_bits)c]; skip_restricted(); return(c);
@z

@x
skip_restricted()
{
@y
skip_restricted()
{ int c=ccode[(eight_bits)*(loc-1)];
@z

@x
@.Control codes are forbidden...@>
@y
@.Control codes are forbidden...@>
    if (c==meaning && phase==2) @<Process a user-generated meaning@>@;
    else if (c==suppress && phase==2) @<Suppress mini-index entry@>;
  }
}

@ @<Suppress mini-index entry@>=
{ char *first=id_first,*last=id_loc;
  while (xisspace(*first)) first++;
  while (xisspace(*(last-1))) last--;
  if (first<last) {
    struct perm_meaning *q=id_lookup(first,last,normal)-name_dir+cur_meaning;
    q->stamp=section_count; /* this is what actually suppresses output */
  }
}

@ @<Process a user-generated meaning@>=
{ char *first=id_first;
  while (xisspace(*first)) first++;
  loc=first;
  while (xisalpha(*loc)||xisdigit(*loc)||*loc=='_') loc++;
  if (*loc++!=' ')
    err_print("! Identifier in meaning should be followed by space");
  else { name_pointer p=id_lookup(first,loc-1,normal);
    sixteen_bits t; int n=0;
    t=title_lookup();
    if (*(loc-1)=='}')
      while (xisdigit(*loc)) n=10*n+(*loc++)-'0';
    if (*loc++!=' ')
      err_print("! Location in meaning should be followed by space");
    else @<Digest the meaning of |p|, |t|, |n|@>;
  }
  loc=id_loc+2;
}

@ @<Digest...@>=
{ meaning_struct *m;
  struct perm_meaning *q=p-name_dir+cur_meaning;
  if (temp_switch) {
    m=temp_meaning_ptr++;
    if (temp_meaning_ptr>max_temp_meaning_ptr) {
      if (temp_meaning_ptr>&temp_meaning_stack[max_meanings])
        overflow("temp meanings");
      max_temp_meaning_ptr=temp_meaning_ptr;
    }
  } else m=&(q->perm);
  m->id=p;
  m->prog_no=t;
  m->sec_no=n;
  if (id_loc-loc>=max_tex_chars) strcpy(m->tex_part,"\\zip");
@.\\zip@>
  else { char *q=m->tex_part;
    while (loc<id_loc) *q++=*loc++;
    *q='\0';
@z

@x
  skip_limbo(); change_exists=0;
@y
  skip_limbo();
  @<Give a default title to the program, if necessary@>;
@z

@x
  changed_section[section_count]=change_exists;
    /* the index changes if anything does */
@y
@z

@x
  changed_section[section_count]=changing;
     /* it will become 1 if any line changes */
@y
@z

@x
  if (changed_section[section_count]) change_exists=1;
@y
@z

@x
    case xref_roman: case xref_wildcard: case xref_typewriter:
@y
    case xref_roman: case xref_wildcard: case xref_typewriter:
    case meaning: case suppress:
@z

@x
`\.{\\input cwebmac}'.
@y
`\.{\\input ctwimac}'. Or, if the user has specified proofing by
saying \.{+P} on the command line, it's `\.{\\input proofmac}',
a set of macros used when debugging mini-index entries.
@z

@x
*out_ptr='c'; tex_printf("\\input cwebma");
@y
*out_ptr='c';
if (flags['P']) tex_printf("\\input proofma");
else tex_printf("\\input ctwima");
@z

@x
@d out(c) {if (out_ptr>=out_buf_end) break_out(); *(++out_ptr)=c;}
@y
@d out(c)
 {if (ms_mode) { /* outputting to |ministring_buf| */
    if (ministring_ptr<&ministring_buf[max_tex_chars])
      *ministring_ptr++=c;
  } else {
     if (out_ptr>=out_buf_end) break_out();
     *(++out_ptr)=c;
   }
 }
@z

@x
|def_flag|, so it cannot have more than five decimal digits.  If
the section is changed, we output `\.{\\*}' just after the number.
@y
|def_flag|, so it cannot have more than five decimal digits.
@z

@x
  if(changed_section[n]) out_str ("\\*");
@.\\*@>
@y
@z

@x
        default: err_print("! Double @@ should be used in limbo");
@y
        case right_start: right_start_switch=1; break;
        default: err_print("! Double @@ should be used in limbo");
@z

@x
@d end_arg 62 /* \.{@@]} */
@y
@d end_arg 62 /* \.{@@]} */
@d title 63 /* program name or header name in a ``meaning'' */
@z

@x
@i prod.w
@y
@i prod-twill.w
@z

@x
scrap scrap_info[max_scraps]; /* memory array for scraps */
@y
scrap scrap_info[max_scraps]; /* memory array for scraps */
scrap null_scrap; /* a scrap with empty translation */
@z

@x
@ @<Set init...@>=
@y
@ @<Set init...@>=
null_scrap.trans=&tok_start[0];
@z

@x
  fflush(stdout);
}
@y
  printf("|\n"); fflush(stdout);
}
@#
void pr_txt(k)
  int k;
{ print_text(&tok_start[k]); }
@z

@x
the |for| loop below.

@c
void
make_reserved(p) /* make the first identifier in |p->trans| like |int| */
@y
the |for| loop below.

We use the fact that |make_underlined| has been called immediately preceding
|make_reserved|, hence |tok_loc| has been set.

@c
token_pointer tok_loc; /* where the first identifier appears */
void
make_reserved(p) /* make the first identifier in |p->trans| like |int| */
@z

@x
  token_pointer tok_loc; /* pointer to |tok_value| */
  if ((tok_loc=find_first_ident(p->trans))<=operator_found)
    return; /* this should not happen */
@y
  if (tok_loc<=operator_found) return; /* this should not happen */
@z

@x
  token_pointer tok_loc; /* where the first identifier appears */
@y
@z

@x
  r->num=m; /* everything from |q| on is left undisturbed */
@y
  r->num=m; /* everything from |q| on is left undisturbed */

@ \.{CTWILL} needs the following procedure, which appends tokens of a
translated text until coming to |tok_loc|, then suppresses text that may
appear between parentheses or brackets. The calling routine should set
|ident_seen=0| first. (This is admittedly tricky.)

@c boolean ident_seen;
boolean app_supp(p)
  text_pointer p;
{ token_pointer j;
  text_pointer q;
  if (ident_seen && **p>=tok_flag) {
    q=**p-tok_flag+tok_start;
    if (**q=='(') {
      app('(');@+app('\\');@+app(',');@+app(')'); goto catch14;
    }
    if (**q=='[') {
      app('[');@+app('\\');@+app(',');@+app(']'); goto catch14;
    }
  }
  for (j=*p;j<*(p+1);j++) {
    if (*j<tok_flag) {
      if (*j==inserted) return 0;
      if (j==tok_loc) ident_seen=1;
      else app(*j);
    } else if (*j>=inner_tok_flag) confusion("inner");
    else if (app_supp(*j-tok_flag+tok_start)) goto catch14;;
  }
  return 0;
catch14: if (*(*(p+1)-1)=='9') return 1; /* production 14 was used */
  else return 0;
}

@ The trickiest part of \.{CTWILL} is the procedure |make_ministring(l)|,
which tries to figure out a symbolic form of definition after
|make_underlined(pp+l)| has been called. We rely heavily on the
existing productions, which force the translated texts to have a
structure that's decodable even though the underlying |cat| and |mathness|
codes have disappeared.

@c void
make_ministring(l)
  int l; /* 0, 1, or 2 */
{
  text_pointer q,r;
  name_pointer cn;
  token t;
  int ast_count; /* asterisks preceding the expression */
  boolean non_ast_seen; /* have we seen a non-asterisk? */
  if (tok_loc<=operator_found) return;
  cn=((*tok_loc)%id_flag)+name_dir;
  @<Append the type of the declaree; |return| if it begins with \&{extern}@>;
  null_scrap.mathness=(((pp+l)->mathness)%4)*5; big_app1(&null_scrap);
    /* now we're ready for the mathness that follows (I think) */
    /* (without the mod 4 times 5, comments posed a problem) */
    /* (namely in cases like |int a(b,c)| followed by comment) */
  ident_seen=0;@+app_supp((pp+l)->trans);
  null_scrap.mathness=10; big_app1(&null_scrap);
   /* now |cur_mathness==no_math| */
  ms_mode=1; ministring_ptr=ministring_buf;
  if (l==2) *ministring_ptr++='=';
  make_output(); /* translate the current text into a ministring */
  tok_ptr=*(--text_ptr); /* delete that text */
  new_meaning(cn);
  cur_mathness=maybe_math; /* restore it */
}

@ Here we use the fact that a |decl_head| comes from |int_like| only in
production~27, whose translation is fairly easy to recognize. (Well,
production 28 has been added for \CPLUSPLUS/, but we hope that doesn't
mess us up.) And we also use other similar facts.

If an identifier is given an \&{extern} definition, we don't change
its current meaning, but we do suppress mini-index entries to its
current meaning in other sections.

@<Append the type of the declaree; |return| if it begins with \&{extern}@>=
if (l==0) { app(int_loc+res_flag); app(' '); cur_mathness=no_math; }
else {
  q=(pp+l-1)->trans;
  ast_count=0;
  non_ast_seen=0;
  while (1) {
    if (*(q+1)==*q+1) {
      r=q;@+break; /* e.g. \&{struct}; we're doing production 45 or 46 */
    }
    if (**q<tok_flag) confusion("find type");
    r=**q-tok_flag+tok_start;
    if ((t=*(*(q+1)-2))>=tok_flag && **(t-tok_flag+tok_start)=='*') {
           /* production 34 */
      if (!non_ast_seen) ast_count++; /* count immediately preceding |*|'s */
    } else non_ast_seen=1;
    if (*(*q+1)==' ' && *(q+1)==*q+2) break; /* production 27 */
    if (*(*q+1)=='{' && *(*q+2)=='}' && *(*q+3)=='$' && *(*q+4)==' '@|
       && *(q+1)==*q+5) break; /* production 27 in disguise */
    q=r;
  }
  while (**r>=tok_flag) {
    if (*(r+1)>*r+9 && *(*r+1)=='{' && *(*r+2)=='}' && *(*r+3)=='$' @|
        && *(*r+4)==indent) q=**r-tok_flag+tok_start; /* production 49 */
    r=**r-tok_flag+tok_start;
  }
  if (**r==ext_loc+res_flag) return; /* \&{extern} gives no definition */
  @<Append tokens for type |q|@>;
}

@ @<Append tokens for type |q|@>=
cur_mathness=no_math; /* it was |maybe_math| */
if (*(q+1)==*q+8 && *(*q+1)==' ' && *(*q+3)==' ') {
  app(**q);@+app(' ');@+app(*(*q+2)); /* production 46 */
} else if ((t=*(*(q+1)-1))>=tok_flag && **(r=t-tok_flag+tok_start)=='\\'
   && *(*r+1)=='{') app(**q); /* |struct_like| identifier */
else app((q-tok_start)+tok_flag);
while (ast_count) {
  big_app('{');@+app('*');@+app('}');@+ast_count--;
}

@z

@x
  make_underlined(pp); big_app1(pp); big_app(indent); app(indent);
@y
  make_underlined(pp);
  make_ministring(0);
  big_app1(pp); big_app(indent); app(indent);
@z

@x
  make_underlined (pp);  squash(pp,2,tag,-1,7);
@y
  make_underlined (pp);
  if (tok_loc>operator_found) {
    name_pointer cn=((*tok_loc)%id_flag)+name_dir;
    strcpy(ministring_buf,"label");
    new_meaning(cn);
  }
  squash(pp,2,tag,-1,7);
@z

@x
  make_underlined(pp+1); squash(pp,2,decl_head,-1,35);
@y
  make_underlined(pp+1);
  make_ministring(1);
  squash(pp,2,decl_head,-1,35);
@z

@x
    make_underlined(pp+1); make_reserved(pp+1);
@y
    make_underlined(pp+1); make_reserved(pp+1);
    make_ministring(1);
@z

@x
if (cat1==define_like) make_underlined(pp+2);
@y
if (cat1==define_like) { /* \.{\#define} is analogous to \&{extern} */
  make_underlined(pp+2);
  if (tok_loc>operator_found) {
    /* no time to work out this case; I'll handle defines by brute force
       in the \.{aux} file, since they usually don't go in mini-index */
  }
}
@z

@x
if (cat1==prelangle) squash(pp+1,1,langle,1,100);
else squash(pp,1,exp,-2,101);
@y
if (cat1==prelangle) squash(pp+1,1,langle,1,121);
else squash(pp,1,exp,-2,122);
@z

@x
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,else_like,-2,102);
@y
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,else_like,-2,123);
@z

@x
@ @<Cases for |typedef_like|@>=
if ((cat1==int_like || cat1==cast) && (cat2==comma || cat2==semi))
  squash(pp+1,1,exp,-1,115);
else if (cat1==int_like) {
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,typedef_like,0,116);
}
else if (cat1==exp && cat2!=lpar && cat2!=exp && cat2!=cast) {
  make_underlined(pp+1); make_reserved(pp+1);
  big_app1(pp); big_app(' '); big_app1(pp+1); reduce(pp,2,typedef_like,0,117);
}
else if (cat1==comma) {
  big_app2(pp); big_app(' '); reduce(pp,2,typedef_like,0,118);
}
else if (cat1==semi) squash(pp,2,decl,-1,119);
else if (cat1==ubinop && (cat2==ubinop || cat2==cast)) {
  big_app('{'); big_app1(pp+1); big_app('}'); big_app1(pp+2);
  reduce(pp+1,2,cat2,0,120);
}
@y
@ Here \.{CTWILL} deviates from the normal productions introduced in
version 3.6, because those productions bypass |decl_head| (thereby
confusing |make_ministring|, which depends on the |decl_head| productions
to deduce the type). We revert to an older syntax that was
less friendly to \CPLUSPLUS/ but good enough for me.

@<Cases for |typedef_like|@>=
if (cat1==decl_head) {
  if ((cat2==exp&&cat3!=lpar&&cat3!=exp)||cat2==int_like) {
    make_underlined(pp+2); make_reserved(pp+2);
    make_ministring(2);
    big_app2(pp+1); reduce(pp+1,2,decl_head,0,200);
  }
  else if (cat2==semi) {
    big_app1(pp); big_app(' '); big_app2(pp+1); reduce(pp,3,decl,-1,201);
  }
} else if (cat1==int_like && cat2==raw_int &&
    (cat3==semi || cat3==comma)) squash(pp+2,1,exp,1,202);
@z

@x
  case ignore: case xref_roman: case xref_wildcard:
@y
  case ignore: case xref_roman: case xref_wildcard:
  case meaning: case suppress:
@z

@x
      else app_scrap(p->ilk,maybe_math);
    }
  }
@y
      else app_scrap(p->ilk,maybe_math);
    }
  }
  @<Flag the usage of this identifier, for the mini-index@>;
@z

@x
to \.{\\PB}, if the user has invoked \.{CWEAVE} with the \.{+e} flag.
Although \.{cwebmac} ignores \.{\\PB}, other macro packages
@y
to \.{\\PB}, if the user has invoked \.{CTWILL} with the \.{+e} flag.
Although \.{ctwimac} ignores \.{\\PB}, other macro packages
@z

@x
        app(tok_flag+(int)(p-tok_start));
@y
        app(tok_flag+(int)(p-tok_start));
        app(inserted);
@z

@x
section_count=0; format_visible=1; copy_limbo();
@y
temp_switch=0; temp_meaning_ptr=temp_meaning_stack;
@<Read the \.{.aux} file, if present; then open it for output@>;
section_count=0; format_visible=1; right_start_switch=0; copy_limbo();
@z

@x
while (!input_has_ended) @<Translate the current section@>;
}

@y
while (!input_has_ended) @<Translate the current section@>;
}

@ @<Glob...@>=
FILE *aux_file;

@ We clobber |tex_file_name| to make the name of the \.{.aux} and
\.{.bux} files. Too bad if the user has specified an output file that
doesn't end with `\.{.tex}'.  I would have used |alt_web_file_name|,
if \.{common.w} had make that public; but I resisted the temptation to
change \.{common.w}.

@<Read the \.{.aux} file, if present; then open it for output@>=
strcpy(tex_file_name+strlen(tex_file_name)-4,".bux");
include_depth=1; /* we simulate \.{@@i} */
strcpy(cur_file_name,tex_file_name); /* first in, third out */
if ((cur_file=fopen(cur_file_name,"r"))) { cur_line=0; include_depth++; }
strcpy(tex_file_name+strlen(tex_file_name)-4,".aux");
strcpy(cur_file_name,tex_file_name); /* second in, second out */
if ((cur_file=fopen(cur_file_name,"r"))) { cur_line=0; include_depth++; }
strcpy(cur_file_name,"system.bux"); /* third in, first out */
if ((cur_file=fopen(cur_file_name,"r"))) cur_line=0;
else include_depth--;
if (include_depth) { /* at least one new file was opened */
  while (get_next()==meaning) ; /* new meaning is digested */
  if (include_depth) err_print("! Only @@$ is allowed in aux and bux files");
  finish_line(); loc=buffer; /* now reading beginning of line 1 */
}
if ((aux_file=fopen(tex_file_name,"w"))==NULL)
  fatal("! Cannot open aux output file ",tex_file_name);

@z

@x
boolean group_found=0; /* has a starred section occurred? */
@y
boolean group_found=0; /* has a starred section occurred? */
boolean right_start_switch; /* has `\.{@@r}' occurred recently? */
boolean temp_switch; /* has `\.{@@\%}' occurred recently? */
@z

@x
@ @<Translate the current section@>= {
  section_count++;
@y
@ @d usage_sentinel (struct perm_meaning *)1
@<Translate the current section@>= {
  section_count++;
  temp_switch=0; temp_meaning_ptr=temp_meaning_stack;
  top_usage=usage_sentinel;
@z

@x
if (*(loc-1)!='*') out_str("\\M");
@y
if (*(loc-1)!='*') {
  if (right_start_switch) {
    out_str("\\shortpage\n"); right_start_switch=0;
@.\\shortpage@>
  }
  out_str("\\M");
@z

@x
else {
@y
} else {
@z

@x
@.\\N@>
@y
@.\\N@>
  if (right_start_switch) {
    out_str("N"); right_start_switch=0;
@.\\NN@>
  }
@z

@x
out_str("{");out_section(section_count); out_str("}");
@y
out_str("{");out_section(section_count); out_str("}");
flush_buffer(out_ptr,0,0);
@z

@x
    case '@@': out('@@'); break;
@y
    case '@@': out('@@'); break;
    case temp_meaning: temp_switch=1-temp_switch; break;
    case right_start: right_start_switch=1; break;
@z

@x
    case section_name: loc-=2; next_control=get_next(); /* skip to \.{@@>} */
@y
    case meaning: case suppress:
    case section_name: loc-=2; next_control=get_next(); /* reprocess */
@z

@x
  outer_parse(); finish_C(format_visible); format_visible=1;
@y
  outer_parse();
  if (is_macro) @<Make ministring for a new macro@>;
  finish_C(format_visible); format_visible=1;
@z

@x
  doing_format=0;
}

@y
  doing_format=0;
}

@ @<Glob...@>=
boolean is_macro; /* it's a macro def, not a format def */
int def_diff; /* 0 iff the current macro has parameters */
name_pointer id_being_defined; /* the definee */

@z

@x
@<Start a macro...@>= {
@y
@<Start a macro...@>= {
  is_macro=1;
@z

@x
@.Improper macro definition@>
  else {
    app('$'); app_cur_id(0);
@y
@.Improper macro definition@>
  else {
    id_being_defined=id_lookup(id_first,id_loc,normal);
    app('$'); app_cur_id(0);
    def_diff=*loc-'(';
@z

@x
@ @<Start a format...@>= {
  doing_format=1;
@y
@ @<Make ministring for a new macro@>=
{
  ms_mode=1; ministring_ptr=ministring_buf;
  *ministring_ptr++='=';
  if (def_diff) { /* parameterless */
    scrap_pointer s=scrap_ptr;
    text_pointer t;
    token_pointer j;
    while (s->cat==insert) s--;
    if ((s-1)->cat==dead && s->cat==exp && **(t=s->trans)=='\\'
         && *(*t+1)=='T') /* it's just a constant */
      for (j=*t;j<*(t+1);j++) *ministring_ptr++=*j;
    else out_str("macro");
  } else out_str("macro (\\,)");
  new_meaning(id_being_defined);
}

@ @<Start a format...@>= {
  doing_format=1;
  is_macro=0;
@z

@x
out_str("\\fi"); finish_line();
@.\\fi@>
@y
finish_line(); out_str("\\mini"); finish_line();
@.\\mini@>
@<Output information about usage of id's defined in other sections@>;
out_str("}\\FI"); finish_line();
@.\\FI@>
@z

@x
flush_buffer(out_buf,0,0); /* insert a blank line, it looks nice */

@y
flush_buffer(out_buf,0,0); /* insert a blank line, it looks nice */

@ The following code is performed for each identifier parsed during
a section. Variable |top_usage| is always nonzero; it has the sentinel
value~1 initially, then it points to each variable scheduled for
possible citation. A variable is on this list if and only if its
|link| field is nonzero. All variables mentioned in the section are
placed on the list, unless they are reserved and their current
\TeX\ meaning is uninitialized.

@ @<Flag the usage of this identifier, for the mini-index@>=
{ struct perm_meaning *q=p-name_dir+cur_meaning;
  if (!(abnormal(p)) || strcmp(q->perm.tex_part,"\\uninitialized")!=0)
    if (q->link==0) {
      q->link=top_usage;
      top_usage=q;
    }
}

@ @<Output information about usage of id's defined in other sections@>=
{@+struct perm_meaning *q;
  while (temp_meaning_ptr>temp_meaning_stack) {
    out_mini(--temp_meaning_ptr);
    q=temp_meaning_ptr->id-name_dir+cur_meaning;
    q->stamp=section_count; /* suppress output from ``permanent'' data */
  }
  while (top_usage!=usage_sentinel) {
    q=top_usage;
    top_usage=q->link;
    q->link=NULL;
    if (q->stamp!=section_count) out_mini(&(q->perm));
  }
}

@ @<Predec...@>=
void   out_mini();

@ @c void
out_mini(m)
  meaning_struct *m;
{ char s[60];
  name_pointer cur_name=m->id;
  if (m->prog_no==0) { /* reference within current program */
    if (m->sec_no==section_count) return; /* defined in current section */
    sprintf(s,"\\[%d",m->sec_no);
  } else { name_pointer n=title_code[m->prog_no];
    if (*(n->byte_start)=='{')
      sprintf(s,"\\]%.*s%d",(n+1)->byte_start-n->byte_start,n->byte_start,
             m->sec_no);
    else sprintf(s,"\\]%.*s",(n+1)->byte_start-n->byte_start,n->byte_start);
  }
  out_str(s); out(' ');
  @<Mini-output the name at |cur_name|@>;
  out(' '); out_str(m->tex_part); finish_line();
}

@ @<Mini-output...@>=
switch (cur_name->ilk) {
  case normal: case func_template: if (length(cur_name)==1) out_str("\\|");
    else {char *j;
      for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
        if (xislower(*j)) goto lowcase;
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
  case custom: {char *j; out_str("$\\");
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      out(*j=='_'? 'x': *j=='$'? 'X': *j);
    out('$');
    goto name_done;
    }
  default: out_str("\\&");
@.\\\&@>
}
out_name(cur_name,1);
name_done:

@z

@x
If the user has set the |no_xref| flag (the \.{-x} option on the command line),
@y
If the user has set the |no_xref| flag (the |-x| option on the command line),
@z

@x
  if (change_exists) {
    @<Tell about changed sections@>; finish_line(); finish_line();
  }
@y
@z

@x
the index section itself.
@y
the index section itself---NOT!
@z

@x
@ @<Tell about changed sections@>= {
  /* remember that the index is already marked as changed */
  k_section=0;
  while (!changed_section[++k_section]);
  out_str("\\ch ");
@.\\ch@>
  out_section(k_section);
  while (k_section<section_count) {
    while (!changed_section[++k_section]);
    out_str(", "); out_section(k_section);
  }
  out('.');
}

@y
@z

@x
@ @<Output the name...@>=
@y
@ We don't format the index completely; the \.{twinx} program does the
rest of the job.

@<Output the name...@>=
@z

@x
  case normal: case func_template: if (is_tiny(cur_name)) out_str("\\|");
@y
  case normal: if (is_tiny(cur_name)) out_str("\\|");
@z

@x
  case wildcard: out_str("\\9");@+ goto not_an_identifier;
@y
  case roman: out_str("  "); goto not_an_identifier;
  case wildcard: out_str("\\9"); goto not_an_identifier;
@z

@x
  case roman: not_an_identifier: out_name(cur_name,0); goto name_done;
  case custom: {char *j; out_str("$\\");
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++)
      out(*j=='_'? 'x': *j=='$'? 'X': *j);
    out('$');
    goto name_done;
    }
@y
not_an_identifier: out_name(cur_name,0); goto name_done;
  case custom: out_str("\\$"); break;
@.\\\$@>
@z

@x
out_name(cur_name,1);
@y
if (flags['P']) out_name(cur_name,1);
else {
  out('{');
  {char *j;
    for (j=cur_name->byte_start;j<(cur_name+1)->byte_start;j++) out(*j);
  }
  out('}');
}
@z

@x
  printf("%ld bytes (out of %ld)\n",
            (long)(byte_ptr-byte_mem),(long)max_bytes);
@y
  printf("%ld bytes (out of %ld)\n",
            (long)(byte_ptr-byte_mem),(long)max_bytes);
  printf("%ld temp meanings (out of %ld)\n",
            (long)(max_temp_meaning_ptr-temp_meaning_stack),
            (long)max_meanings);
  printf("%ld titles (out of %ld)\n",
            (long)(title_code_ptr-title_code),(long)max_titles);
@z

