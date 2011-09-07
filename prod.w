% This file is part of CWEB.
% This program by Silvio Levy and Donald E. Knuth
% is based on a program by Knuth.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
% Version 3.0 --- June 1993
%
@
\def\v{\char'174} 
\mathchardef\RA="3221 % right arrow
\mathchardef\BA="3224 % double arrow
Here is a table of all the productions.  Each production that
combines two or more consecutive scraps implicitly inserts a {\tt \$}
where necessary, that is, between scraps whose abutting boundaries
have different |mathness|.  In this way we never get double {\tt\$\$}.

A translation is provided when the resulting scrap is not merely a
juxtaposition of the scraps it comes from.  An asterisk$^*$ next to a scrap
means that its first identifier gets an underlined entry in the index,
via the function |make_underlined|.  Two asterisks$^{**}$ means that both
|make_underlined| and |make_reserved| are called; that is, the
identifier's ilk becomes |raw_int|.  A dagger \dag\ before the
production number refers to the notes at the end of this section,
which deal with various exceptional cases.

We use \\{in}, \\{out}, \\{back} and
\\{bsp} as shorthands for |indent|, |outdent|, |backup| and
|break_space|, respectively.

\begingroup \lineskip=4pt
\def\alt #1 #2
{$\displaystyle\Bigl\{\!\matrix{\strut\hbox{#1}\cr
   \strut\hbox{#2}\cr}\!\Bigr\}$ }
\def\altt #1 #2 #3
{$\displaystyle\Biggl\{\!\matrix{\strut\hbox{#1}\cr\hbox{#2}\cr
   \strut\hbox{#3}\cr}\!\Biggr\}$ }
\def\malt #1 #2
{$\displaystyle\matrix{\strut\hbox{#1}\hfill\cr\strut\hbox{#2}\hfill\cr}$}
\def\maltt #1 #2 #3
{$\displaystyle\matrix{\strut\hbox{#1}\hfill\cr\hbox{#2}\hfill\cr
   \strut\hbox{#3}\hfill\cr}$}
\yskip\newcount\prodno\prodno=0
\newdimen\midcol \midcol=2.5in
\def\theprodno{\number\prodno \global\advance\prodno by1\enspace}
\def\+#1&#2&#3&#4\cr{\def\next{#1}%
 \line{\hbox to 2em{\hss
  \ifx\next\empty\theprodno\else\next\fi}\strut
  \ignorespaces#2\hfil\hbox to\midcol{$\RA$
  \ignorespaces#3\hfil}\quad \hbox to1.45in{\ignorespaces#4\hfil}}}
\+\relax & LHS & RHS \hfill Translation & Example\cr
\yskip
\+& \altt\\{any} {\\{any} \\{any}} {\\{any} \\{any} \\{any}}
|insert| & \altt\\{any} {\\{any} \\{any}} {\\{any} \\{any} \\{any}}
& stmt; \ /$\ast\,$comment$\,*$/\cr
\+& |exp| \altt|lbrace| |int_like| |decl|
    & |fn_decl| \altt|lbrace| |int_like| |decl|
        \hfill $F=E^*\,|in|\,|in|$ & \malt {\\{main}()$\{$}
           {\\{main}$(\\{ac},\\{av})$ \&{int} \\{ac};} \cr
\+& |exp| |unop| & |exp| & |x++|\cr
\+& |exp| \alt |binop| |unorbinop| |exp| & |exp| & \malt {|x/y|} {|x+y|} \cr
\+& |exp| |comma| |exp| & |exp| \hfill $EC\,|opt|9\,E$& |f(x,y)|\cr
\+& |exp| \alt |exp| |cast| & |exp| & |time()|\cr
\+& |exp| |semi| & |stmt| & |x=0;|\cr
\+& |exp| |colon| & |tag| \hfill $E^*C$ & |found:|\cr
\+& |exp| |base| |int_like| |comma| & |base| \hfill $B\.\ IC$\,|opt|9
 & \&D : \&C,\cr
\+& |exp| |base| |int_like| |lbrace| & |exp| |lbrace| \hfill
     $E=E\.\ B\.\ I$ & \&D : \&C $\{$\cr
\+& |exp| |rbrace| & |stmt| |rbrace| & end of \&{enum} list\cr
\+& |lpar| \alt |exp| |unorbinop| |rpar| & |exp| & \malt{|(x)|} {|(*)|} \cr
\+& |lpar| |rpar| & |exp| \hfill $L\.{\\,}R$ & functions, declarations\cr
\+& |lpar| \alt |decl_head| |int_like| |rpar| & |cast| & |(char*)|\cr
\+& |lpar| \altt |decl_head| |int_like| |exp| |comma| & |lpar| \hfill
     $L$\,\altt $D$ $I$ $E$ C\,|opt|9 & |(int,|\cr
\+& |lpar| \alt |stmt| |decl| & |lpar| \hfill \alt {$LS\.\ $} {$LD\.\ $} &
    \alt {|(k=5;|} {|(int k=5;|} \cr
\+& |question| |exp| |colon| & |binop| & |?x:|\cr
\+& |unop| \alt |exp| |int_like| & \alt |exp| |int_like| &
  \malt |!x| |~|\&C \cr
\+& |unorbinop| \alt|exp| |int_like| & \alt|exp| |int_like| \hfill
  $\.\{U\.\}E$ & |*x|\cr
\+& |unorbinop| |binop| & |binop| \hfill $|math_rel|\,U\.\{B\.\}\.\}$ & |*=|\cr
\+& |binop| |binop| & |binop| \hfill
                        $|math_rel|\,\.\{B_1\.\}\.\{B_2\.\}\.\}$ & |>>=|\cr
\+& |cast| |exp| & |exp| \hfill $C\.\ E$ & |(double)x|\cr
\+& |cast| |semi| & |exp| |semi| & |(int);|\cr
\+& |sizeof_like| |cast| & |exp| & |sizeof (double)|\cr
\+& |sizeof_like| |exp| & |exp| \hfill $S\.\ E$ & |sizeof x|\cr
\+& |int_like| \alt|int_like| |struct_like| &
        \alt|int_like| |struct_like| \hfill $I\.\ $\alt $I$ $S$
        \unskip& |extern char|\cr
\+& |int_like| |exp| \alt|raw_int| |struct_like| &
         |int_like| \alt|int_like| |struct_like| & |extern "Ada" int|\cr
\+& |int_like| \altt|exp| |unorbinop| |semi| & |decl_head|
                    \altt|exp| |unorbinop| |semi| \hfill
                   $D=I$\altt{\.\ } {\.\ } {} \unskip & |int x|\cr
\+& |int_like| |colon| & |decl_head| |colon| \hfill $D=I\.\ $ & |unsigned:|\cr
\+& |int_like| |prelangle| & |int_like| |langle| & \&C$\langle$\cr
\+& |int_like| |colcol| \alt |exp| |int_like| & \alt |exp| |int_like| &
   \malt {\&C\DC$x$} {\&C\DC\&B} \cr
\+& |int_like| |cast| |lbrace| & |fn_decl| |lbrace| \hfill $IC\,|in|\,|in|$&
    \&C$\langle\&{void}\ast\rangle\{$\cr
\+& |int_like| |cast| & |int_like| & \&C$\langle\&{class}\ \&T\rangle$\cr
\+& |decl_head| |comma| & |decl_head| \hfill $DC\.\ $ & |int x,|\cr
\+& |decl_head| |unorbinop| & |decl_head| \hfill $D\.\{U\.\}$ & |int *|\cr
\+\dag\theprodno& |decl_head| |exp| & |decl_head| \hfill $DE^*$ & |int x|\cr
\+& |decl_head| \alt|binop| |colon| |exp| \altt|comma| |semi| |rpar| &
     |decl_head| \altt|comma| |semi| |rpar| \hfill
     $D=D$\alt $B$ $C$ \unskip$E$ & \maltt initialization {fields or}
       {default argument} \cr
\+& |decl_head| |cast| & |decl_head| & |int f(int)|\cr
\+\dag\theprodno& |decl_head| \altt|int_like| |lbrace| |decl| & |fn_decl|
                   \altt|int_like| |lbrace| |decl| \hfill $F=D\,|in|\,|in|$
                             & |long time () {|\cr
\+& |decl_head| |semi| & |decl| & |int n;|\cr
\+& |decl| |decl| & |decl| \hfill $D\,|force|\,D$ & |int n;double x;|\cr
\+& |decl| \alt|stmt| |function| & \alt|stmt| |function|
        \hfill $D\,|big_force|\,$\alt $S$ $F$ \unskip& \&{extern} $n$;
            \\{main} ()|{}|\cr
\+\dag\theprodno& |typedef_like| |decl_head| \alt|exp| |int_like| &
      |typedef_like| |decl_head| \hfill $D=D$\alt $E^{**}$ $I^{**}$ \unskip &
          \&{typedef} \&{char} \&{ch};\cr
\+& |typedef_like| |decl_head| |semi| & |decl| \hfill $T\.\ D$ &
                                             \&{typedef} \&{int} $\&x,\&y$;\cr
\+& |struct_like| |lbrace| & |struct_head| \hfill $S\.\ L$ & |struct {|\cr
\+& |struct_like| \alt|exp| |int_like| |semi| & |decl_head|
     \hfill $S\.\ $\alt $E^{**}$ $I^{**}$ & \&{struct} \&{forward};\cr
\+& |struct_like| \alt|exp| |int_like| |lbrace| & |struct_head| \hfill
     $S\.\ $\alt $E^{**}$ $I^{**}$ \unskip $\.\ L$ &
              \&{struct} \&{name\_info} $\{$\cr
\+& |struct_like| \alt|exp| |int_like| |colon| &
    |struct_like| \alt|exp| |int_like| |base| & |class| \&C :\cr
\+\dag\theprodno& |struct_like| \alt|exp| |int_like| & |int_like|
        \hfill $S\.\ $\alt$E$ $I$ & \&{struct} \&{name\_info} $z$;\cr
\+& |struct_head| \altt|decl| |stmt| |function| |rbrace| & |int_like|\hfill
         $S\,\\{in}\,|force|\,D\,\\{out}\,|force|\,R$ &
                                        |struct {| declaration |}|\cr
\+& |struct_head| |rbrace| & |int_like|\hfill $S\.{\\,}R$ & |class C{}|\cr
\+& |fn_decl| |decl| & |fn_decl| \hfill $F\,|force|\,D$
                                       & $f(z)$ \&{double} $z$; \cr
\+& |fn_decl| |stmt| & |function| \hfill $F\,|out|\,|out|\,|force|\,S$
                                       & \\{main}() {\dots}\cr
\+& |function| \altt|stmt| |decl| |function| & \altt |stmt| |decl| |function|
   \hfill $F\,|big_force|\,$\altt $S$ $D$ $F$ & outer block\cr
\+& |lbrace| |rbrace| & |stmt| \hfill $L\.{\\,}R$ & empty statement\cr
\advance\midcol35pt
\+& |lbrace| \altt|stmt| |decl| |function| |rbrace| & |stmt| \hfill
     $|force|\,L\,\\{in}\,|force|\,S\,
                |force|\,\\{back}\,R\,\\{out}\,|force|$ & compound statement\cr
\advance\midcol-20pt
\+& |lbrace| |exp| [|comma|] |rbrace| & |exp| & initializer\cr
\+& |if_like| |exp| & |if_clause| \hfill $I\.{\ }E$ & |if (z)|\cr
\+& |for_like| |exp| & |else_like| \hfill $F\.{\ }E$ & |while (1)|\cr
\+& |else_like| |lbrace| & |else_head| |lbrace| & \&{else} $\{$\cr
\+& |else_like| |stmt| & |stmt| \hfill
       $|force|\,E\,\\{in}\,\\{bsp}\,S\,\\{out}\,|force|$ & |else x=0;|\cr
\+& |else_head| \alt|stmt| |exp|  & |stmt| \hfill
      $|force|\,E\,\\{bsp}\,|noop|\,|cancel|\,S\,\\{bsp}$ & |else{x=0;}|\cr
\+& |if_clause| |lbrace| & |if_head| |lbrace| & |if (x) {|\cr
\+& |if_clause| |stmt| |else_like| |if_like| & |if_like| \hfill
    $|force|\,I\,\\{in}\,\\{bsp}\,S\,\\{out}\,|force|\,E\,\.\ I$ &
     |if (x) y; else if|\cr
\+& |if_clause| |stmt| |else_like| & |else_like| \hfill
    $|force|\,I\,\\{in}\,\\{bsp}\,S\,\\{out}\,|force|\,E$ &
   |if (x) y; else|\cr
\+& |if_clause| |stmt| & |else_like| |stmt| & |if (x)|\cr
\+& |if_head| \alt|stmt| |exp| |else_like| |if_like| & |if_like| \hfill
    $|force|\,I\,\\{bsp}\,|noop|\,|cancel|\,S\,|force|\,E\,\.\ I$ &
     |if (x){y;}else if|\cr
\+& |if_head| \alt|stmt| |exp| |else_like| & |else_like| \hfill
    $|force|\,I\,\\{bsp}\,|noop|\,|cancel|\,S\,|force|\,E$ &
   |if (x){y;}else|\cr
\+& |if_head| \alt|stmt| |exp| & |else_head| \alt|stmt| |exp| & |if (x){y;}|\cr
\advance\midcol20pt
\+& |do_like| |stmt| |else_like| |semi| & |stmt| \hfill
      $D\,\\{bsp}\,|noop|\,|cancel|\,S\,|cancel|\,|noop|\,\\{bsp}\,ES$%
      &       |do f(x); while (g(x));|\cr
\advance\midcol-20pt
\+& |case_like| |semi| & |stmt| & |return;|\cr
\+& |case_like| |colon| & |tag| & |default:|\cr
\+& |case_like| |exp| |semi| & |stmt| \hfill $C\.\ ES$ & |return 0;|\cr
\+& |case_like| |exp| |colon| & |tag| \hfill $C\.\ EC$ & |case 0:|\cr
\+& |tag| |tag| & |tag| \hfill $T_1\,\\{bsp}\,T_2$ & |case 0: case 1:|\cr
\+& |tag| \altt|stmt| |decl| |function| & \altt|stmt| |decl| |function|
       \hfill $|force|\,\\{back}\,T\,\\{bsp}\,S$ & |case 0: z=0;|\cr
\+\dag\theprodno& |stmt| \altt|stmt| |decl| |function| &
   \altt|stmt| |decl| |function|
      \hfill $S\,$\altt$|force|\,S$ $|big_force|\,D$ $|big_force|\,F$ &
      |x=1;y=2;|\cr
\+& |semi| & |stmt| \hfill \.\ $S$& empty statement\cr
\+\dag\theprodno& |lproc| \altt |if_like| |else_like| |define_like| & |lproc| &
         \maltt {{\bf \#include}} {\bf\#else} {\bf\#define} \cr
\+& |lproc| |rproc| & |insert| & {\bf\#endif} \cr
\+& |lproc| \alt {|exp| [|exp|]} |function| |rproc| & |insert| \hfill
    $I$\.\ \alt {$E{[\.{\ \\5}E]}$} {$F$} &
 \malt{{\bf\#define} $a$\enspace 1} {{\bf\#define} $a$\enspace$\{\,b;\,\}$} \cr
\+& |section_scrap| |semi| & |stmt|\hfill $MS$ |force|
   &$\langle\,$section name$\,\rangle$;\cr
\+& |section_scrap| & |exp| &$\langle\,$section name$\,\rangle$\cr
\+& |insert| |any| & |any| & \.{\v\#include\v}\cr
\+& |prelangle| & |binop| \hfill \.< & $<$ not in template\cr
\+& |prerangle| & |binop| \hfill \.> & $>$ not in template\cr
\+& |langle| |exp| |prerangle| & |cast| & $\langle\,0\,\rangle$\cr
\+& |langle| |prerangle| & |cast| \hfill $L\.{\\,}P$ & $\langle\,\rangle$\cr
\+& |langle| \alt|decl_head| |int_like| |prerangle| & |cast| &
     $\langle\&{class}\,\&C\rangle$\cr
\+& |langle| \alt|decl_head| |int_like| |comma| & |langle| \hfill
     $L$\,\alt $D$ $I$ C\,|opt|9 & $\langle\&{class}\,\&C,$\cr
\+& |public_like| |colon| & |tag| & \&{private}:\cr
\+& |public_like| & |int_like| & \&{private}\cr
\+& |colcol| \alt|exp| |int_like| & \alt|exp| |int_like| & |::x|\cr
\+\dag\theprodno&
     |new_like| \alt|exp| |raw_int| & |new_like| \hfill $N\.\ E$ & |new(1)|\cr
\+& |new_like| \alt|raw_unorbin| |colcol| & |new_like| & |new ::*|\cr
\+& |new_like| |cast| & |exp| & |new(*)|\cr
\+\dag\theprodno& |new_like| & |exp| & |new|\cr
\+\dag\theprodno& |operator_like| \altt|binop| |unop| |unorbinop| & |exp|
    \hfill $O$\.\{\altt $B$ $U$ $U$\unskip \.\} & |operator+|\cr
\+& |operator_like| \alt|new_like| |sizeof_like| & |exp| \hfill $O\.\ N$
    & |operator delete|\cr
\+& |operator_like| & |new_like| & conversion operator\cr
\+& |catch_like| \alt|cast| |exp| & |fn_decl| \hfill $CE\,\\{in}\,\\{in}$ &
    |catch (...)|\cr
\+& |base| |public_like| |exp| |comma| & |base| \hfill $BP\.\ EC$ &
     : \&{public} $a$,\cr
\+& |base| |public_like| |exp| & |base| |int_like| \hfill $I=P\.\ E$ &
     : \&{public} $a$\cr
\+\dag\theprodno& |raw_rpar| |const_like| & |raw_rpar| \hfill $R\.\ C$ &
     ) \&{const};\cr
\+& |raw_rpar| & |rpar| & );\cr
\+& |raw_unorbin| |const_like| & |raw_unorbin| \hfill $RC$\.{\\\ }
     & $*$\&{const} |x|\cr
\+& |raw_unorbin| & |unorbinop| & $*$ |x|\cr
\+& |const_like| & |int_like| & \&{const} |x|\cr
\+& |raw_int| |lpar| & |exp| & \&{complex}$(x,y)$\cr
\+& |raw_int| & |int_like|   & \&{complex} |z|\cr
\+& |begin_arg| |end_arg| & |exp| & \.{@@[}\&{char}$*$\.{@@]}\cr
\+& |any_other| |end_arg| & |end_arg| &    \&{char}$*$\.{@@]}\cr
\yskip
\yskip
\yskip
\parindent=0pt
\dag{\bf Notes}
\yskip
Rule 35: The |exp| must not be immediately followed by |lpar| or~|exp|.

Rule 38: The |int_like| must not be immediately followed by |colcol|.

Rule 42: The |exp| must not be immediately followed by |lpar| or~|exp|.

Rule 48: The |exp| or |int_like| must not be immediately followed by |base|.

Rule 76: The |force| in the |stmt| line becomes \\{bsp} if \.{CWEAVE} has
been invoked with the \.{-f} option.

Rule 78: The |define_like| case calls |make_underlined| on the following scrap.

Rule 93: The |raw_int| must not be immediately followed by
|prelangle| or |langle|.

Rule 96: The |new_like| must not be immediately followed by |lpar|,
|raw_int|, or |struct_like|.

Rule 97: The operator after |operator_like|
must not be immediately followed by a |binop|.

Rule 103: The operator after |const_like| must be |semi|, |lbrace|, |comma|,
|binop|, or |const_like|.

\endgroup
