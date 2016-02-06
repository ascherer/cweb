@ 
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
identifier's ilk becomes |int_like|.  We use \\{in}, \\{out}, \\{back} and
\\{bsp} as shorthands for |indent|, |outdent|, |backup| and
|break_space|, respectively.

\begingroup \lineskip=4pt
\def\tspan{\omit&&\omit\hfil\hskip-300pt}
\def\alt #1 #2
{$\displaystyle\Bigl\{\!\matrix{\strut\hbox{#1}\cr
   \strut\hbox{#2}\cr}\!\Bigr\}$ }
\def\altt #1 #2 #3
{$\displaystyle\Biggl\{\!\matrix{\strut\hbox{#1}\cr\hbox{#2}\cr
   \strut\hbox{#3}\cr}\!\Biggl\}$ }
\def\malt #1 #2
{$\displaystyle\matrix{\strut\hbox{#1}\hfill\cr\strut\hbox{#2}\hfill\cr}$}
\def\maltt #1 #2 #3
{$\displaystyle\matrix{\strut\hbox{#1}\hfill\cr\hbox{#2}\hfill\cr
   \strut\hbox{#3}\hfill\cr}$}
{
\yskip\newcount\prodno\prodno=0\def\ignore#1{}
\halign to\hsize{\hfil\it\number\prodno \global\advance\prodno by1
 \ignore{#}\enspace&\strut#\hfil\tabskip 0pt plus 200pt&%
$\RA$ #\hfil&$\quad$#\hfil\tabskip0pt\cr
\omit & LHS & RHS \hfill Translation & Example\cr
\noalign{\yskip}
& \altt\\{any} {\\{any} \\{any}} {\\{any} \\{any} \\{any}}
|insert| & \altt\\{any} {\\{any} \\{any}} {\\{any} \\{any} \\{any}}
& stmt; \ /$\ast\,$comment$\,*$/\cr
& |exp| \altt|lbrace| |int_like| |decl|
    & |fn_decl| \altt|lbrace| |int_like| |decl|
        \hfill $F=E^*\,|in|\,|in|$ & \malt {\\{main}()$\{$} 
           {\\{main}$(\\{ac},\\{av})$ \&{int} \\{ac};} \cr
& |exp| |unop| & |exp| & |x++|\cr
& |exp| \alt |binop| |unorbinop| |exp| & |exp| & \malt {|x+y|} {|x*y|} \cr
& |exp| |comma| |exp| & |exp| \hfill $E_1C\,|opt|9\,E_2$& |f(x,y)|\cr
& |exp| |exp| & |exp| & |time()|\cr
& |exp| |semi| & |stmt| & |x=0;|\cr
& |exp| |colon| & |tag| \hfill $E^*C$ & |found:|\cr
& |lpar| |exp| |rpar| & |exp| & |(x+y)|\cr
& |lpar| |rpar| & |exp| \hfill $L\.{\\,}R$ & functions, declarations\cr
& |lpar| \alt |decl_head| |int_like| |rpar| & |cast| & |(char*)|\cr
& |lpar| |stmt| & |lpar| \hfill $LS\.\ $ & |for| constructions\cr
& |question| |exp| |colon| & |binop| & |x==y?x+1:0|\cr
& |unop| |exp| & |exp| & |!x|\cr
& |unorbinop| \alt|exp| |int_like| & |exp| \hfill $\.\{U\.\}E$ & |*x|\cr
& |unorbinop| |binop| & |binop| \hfill $|math_rel|\,U\.\{B\.\}\.\}$ & |*=|\cr
& |binop| |binop| & |binop| \hfill
                        $|math_rel|\,\.\{B_1\.\}\.\{B_2\.\}\.\}$ & |x>>=y|\cr
& |cast| |exp| & |exp| \hfill $C\.\ E$ & |(double)x|\cr
& |sizeof_like| |cast| & |exp| & |sizeof (double)|\cr
& |sizeof_like| |exp| & |exp| \hfill $S\.\ E$ & |sizeof x|\cr
& |int_like| \alt|int_like| |struct_like| &
        \alt|int_like| |struct_like| \hfill $I\.\ $\alt $I$ $S$
        \unskip& |extern char|\cr
& |int_like| \altt|exp| |unorbinop| |semi| & |decl_head| 
                    \altt|exp| |unorbinop| |semi| \hfill
                   $D=I$\altt{\.\ } {\.\ } {} \unskip & |int x|\cr
& |decl_head| |comma| & |decl_head| \hfill $DC\.\ $ & |int x,y|\cr
& |decl_head| |unorbinop| & |decl_head| \hfill $D\.\{U\.\}$ & |int *x|\cr
& |decl_head| |exp| & |decl_head| \hfill $DE^*$ & |int x|\cr
& |decl_head| \alt|binop| |colon| |exp| \alt|comma| |semi| &
     |decl_head| \alt|comma| |semi| \quad
     $D=D$\alt $B$ $C$ \unskip$E$ & \malt initialization fields \cr
& |decl_head| \altt|int_like| |lbrace| |decl| & |fn_decl| 
                   \altt|int_like| |lbrace| |decl| \hfill $F=D\,|in|\,|in|$
                             & |long time () {|\cr
& |decl_head| |semi| & |decl| & |int n;|\cr
& |decl| |decl| & |decl| \hfill $D_1\,|force|\,D_2$ & |int n;double x;|\cr
& |decl| \alt|stmt| |function| & \alt|stmt| |function| 
        \hfill $D\,|big_force|\,$\alt $S$ $F$ \unskip& \&{extern} $n$;
            \\{main} ()|{}|\cr
& |typedef_like| |decl_head| \alt|exp| |int_like| & |typedef_like| |decl_head|
                        \hfill $D=DE^{**}$ & \&{typedef} \&{char} \&{ch};\cr
& |typedef_like| |decl_head| |semi| & |decl| \hfill $T\.\ D$ &
                                             \&{typedef} \&{int} $\&x,\&y$;\cr
& |struct_like| |lbrace| & |struct_head| \hfill $S\.\ L$ & |struct {|\cr
& |struct_like| \alt|exp| |int_like|
 |lbrace| & |struct_head| \hfill $S\.\ E^*\.\ L$
                                            & \&{struct} \&{name\_info} $\{$\cr
& |struct_like| \alt|exp| |int_like| & |int_like| \hfill $S\.\ E$
                                          & \&{struct} \&{name\_info} $z$;\cr
& |struct_head| \alt|decl| |stmt| |rbrace| & |int_like|\hfill
         $S\,\\{in}\,|force|\,D\,\\{out}\,|force|\,R$ &
                                        |struct {| declaration |}|\cr
& |fn_decl| |decl| & |fn_decl| \hfill $F\,|force|\,D$
                                       & $f(z)$ \&{double} $z$; \cr
& |fn_decl| |stmt| & |function| \hfill $F\,|out|\,|out|\,|force|\,S$
                                       & \\{main}() {\dots}\cr
& |function| \alt |decl| |function| & \alt |decl| |function| \hfill
  $F\,|big_force|\,$\alt $D$ $F$ & outer block\cr
& |lbrace| |rbrace| & |stmt| \hfill $L\.{\\,}R$ & empty statement\cr
& |lbrace| |stmt| |rbrace| & |stmt|\cr
        \tspan $|force|\,L\,\\{in}\,|force|\,S\,
                |force|\,\\{back}\,R\,\\{out}\,|force|$ & compound statement\cr
& |lbrace| |exp| [|comma|] |rbrace| & |exp| & initializer\cr
& |if_like| |exp| & |else_like| \hfill $I\.{\ }E$ & |if (z)|\cr
& |else_like| |lbrace| & |if_head| |lbrace| & compound statement\cr
& |else_like| \alt|stmt| |exp| |else_like| & |else_like|\cr
\noalign{\vskip-6pt}
\tspan $|force|\,E\,\\{in}\,\\{bsp}\,S\,\\{out}\,|force|\,E\,\.\ \,|cancel|$ &
                                                        |if|-|else| clause\cr
& |else_like| |stmt| & |stmt|\hfill
   $|force|\,E\,\\{in}\,\\{bsp}\,S\,\\{out}\,|force|$ & |else|-less |if|\cr
& |if_head| \alt|stmt| |exp| |else_like| & |else_like|\cr
\noalign{\vskip-6pt}
\tspan $|force|\,I\,\\{bsp}\,|noop|\,|cancel|\,S\,\\{bsp}\,E\,\.\ \,|cancel|$ &
                                                        |if|-|else| clause\cr
& |if_head| |stmt| & |stmt| \hfill
 $|force|\,I\,\\{bsp}\,|noop|\,|cancel|\,S\,|force|$ & |else|-less |if|\cr
& |do_like| |stmt| |else_like| |semi| & |stmt| \hfill 
                        $D\,\\{bsp}\,S\,\\{bsp}\,E\,S$ & |do| statement\cr
& |case_like| |semi| & |stmt| & |return;|\cr
& |case_like| |exp| |semi| & |stmt| \hfill $C\.\ ES$ & |return 0;|\cr
& |case_like| |colon| & |tag| & |default:|\cr
& |case_like| |exp| |colon| & |tag| \hfill $C\.\ EC$ & |case 0:|\cr
& |tag| |tag| & |tag| \hfill $T_1\,\\{bsp}\,T_2$ & |case 0: case 1:|\cr
& |tag| |stmt| & |stmt| \hfill
        $|force|\,\\{back}\,T\,\\{bsp}\,S$ & |case 0: z=0;|\cr
& |stmt| |stmt| & |stmt| \hfill $S_1\,|force|\,S_2$ & compound statement\cr
& |semi| & |stmt| \hfill \.\ $S$& empty statement\cr
& |lproc| \altt |if_like| |else_like| |define_like| & |lproc| &
         \maltt {{\bf \#include}} {\bf\#else} {\bf\#define} \cr
& |lproc| |rproc| & |insert| & {\bf\#endif} \cr
& |lproc| \alt {|exp| [|exp|]} |function| |rproc| & |insert| \hfill
    $I$\.\ \alt {$E{[\.{\ \\5}E]}$} {$F$} &
 \malt {{\bf\#define} $a$\enspace 1} {{\bf\#define} $a$\enspace$\{\,b;\,\}$} \cr
& |mod_scrap| |semi| & |stmt|\hfill $MS$ |force|
   &$\langle\,$mod name$\,\rangle$;\cr
& |mod_scrap| & |exp| &$\langle\,$mod name$\,\rangle$\cr
& |insert| |any| & |any| & \.{\v\#include\v}\cr
& |begin_arg| |end_arg| & |exp| & \.{@@[}\&{char}$*$\.{@@]}\cr
& |any_other| |end_arg| & |end_arg| &    \&{char}$*$\.{@@]}\cr
& |int_like| |comma| |exp| & |int_like| & \&{struct} |t|, |f|\cr % for offsetof
}
}
\endgroup
\yskip
\yskip\noindent The |force| in rule 55 becomes \\{bsp} if the \.{-f} option
is used when invoking \.{CWEAVE}.
The |define_like| case of production 57 also calls
|make_underlined| on the following scrap.
The |exp| in rules 24 and 30 should not be immediately followed by
|lpar| or~|exp|.
