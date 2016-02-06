								-*-Web-*-
This file, CWEBMANG.CH, is part of CWEB. It is a changefile written by
Andreas Scherer for CWEBMAN.TEX, Version 3.1, that provides changes
appropriate for the German extensions. This change was inspired by
ideas of Carsten Steger from his CWEB ports 2.0 and 2.8.

Run WMERGE with masterfile CWEBMAN.TEX and changefile CWEBMANG.CH
to produce CWEBMANG.TEX.

This program is distributed WITHOUT ANY WARRANTY, express or implied.

The following copyright notice extends to this changefile only, not to
the masterfile CWEBMAN.TEX.

Copyright (C) 1993,1994 Andreas Scherer

Permission is granted to make and distribute verbatim copies of this
document provided that the copyright notice and this permission notice
are preserved on all copies.

Permission is granted to copy and distribute modified versions of this
document under the conditions for verbatim copying, provided that the
entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

Version history:

Version	Date		Author	Comment
a1      15 Mar 1993     AS      Setup of changefile.
a2	05 Sep 1993	AS	Minor changes and corrections.
a3	09 Oct 1993	AS	Updated for cwebman.tex 2.8.
a4	12 Oct 1993	AS	Contents page for the complete manual.
a5	25 Oct 1993	AS	Updated for cwebman.tex 3.0.
a6	18 Nov 1993	AS	Updated for cwebman.tex 3.1.
a7	30 Nov 1993	AS	Minor changes and corrections.
a8	12 Jan 1994	AS	New gcwebmac.tex installed.
a9	18 Jan 1994	AS	New patch level.
a10	24 Jun 1994	AS	New option `m' for ARexx communication.
------------------------------------------------------------------------------
Use the already changed macro file.
@x l.4
\input cwebmac
@y
\input ccwebmac
@z
------------------------------------------------------------------------------
@x l.37
\def\runninghead{{\tentt CWEB} USER MANUAL (VERSION 3.0)}
@y
\def\runninghead{{\tentt CWEB} USER MANUAL (VERSION 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.51
\vskip 18pt\centerline{(Version 3.0)}
@y
\vskip 18pt\centerline{(Version 3.1 [p9d])}
@z
------------------------------------------------------------------------------
@x l.57
The printed form of this manual is copyright \copyright\ 1994
  by Addison-Wesley Publishing Company, Inc.  All rights reserved.
\smallskip\noindent
The electronic form is copyright \copyright\ 1987, 1990, 1993
  by Silvio Levy and Donald E. Knuth.
@y
The printed form of this manual is copyright \copyright\ 1994
  by Addison-Wesley Publishing Company, Inc.  All rights reserved.
\smallskip\noindent
The electronic form is copyright \copyright\ 1987, 1990, 1993
  by Silvio Levy and Donald E. Knuth.
\smallskip\noindent
The changes to the electronic form are copyright \copyright\ 1993, 1994
  by Andreas Scherer
@z
------------------------------------------------------------------------------
Fix a typo.
@x l.149
information that is gathered automatically.  Similarly, if you run the
command `\.{ctangle something}' you will get a \CEE/ file \.{something.c},
with can then be compiled to yield executable code.
@y
information that is gathered automatically.  Similarly, if you run the
command `\.{ctangle something}' you will get a \CEE/ file \.{something.c},
which can then be compiled to yield executable code.
@z
------------------------------------------------------------------------------
Fix another typo.
@x l.164
(Get it? Wow.)  Perhaps there is some deep connection here with the fact
that the German word for ``weave'' is ``{\it web\/}'', and the
corresponding Latin imperative is ``{\it texe\/}''!
@y
(Get it? Wow.)  Perhaps there is some deep connection here with the fact
that the German word for ``weave'' is ``{\it webe\/}'', and the
corresponding Latin imperative is ``{\it texe\/}''!
@z
------------------------------------------------------------------------------
@x l.405 C++ comments are allowed
comments (i.e., between \.{/*} and \.{*/}) is treated as \TEX/ text.
@y
comments (i.e., between \.{/*} and \.{*/} or after \.{//} in \CPLUSPLUS/
programs) is treated as \TEX/ text.
@z
------------------------------------------------------------------------------
The `\.{@@t}' feature has problems when directly before or after the
restricted group stands one of the unequality operators `<' and `>'.
Other operators work fine.  As a work-around put `<' inside the group.
This bug/feature is due to section 179.  TeX strings are no longer made
into a (`exp') scrap.  Pre-3.0 versions of CWEAVE had
`app_scrap(exp,maybe_math);' as the last command and worked fine.
@x l.664
typing `\.{|size < @t\$2\^\{15\}\$@>|}'.
@y
typing `\.{|size < 2@t\$\^\{15\}\$@>|}'.
@z
------------------------------------------------------------------------------
Standard types are set in boldface.
@x l.694
(e.g., `\.{int}~\\{argc}; \.{char}~${**}\\{argv}$; $\{\,\ldots\,\}$').
@y
(e.g., `\&{int}~\\{argc}; \&{char}~${**}\\{argv}$; $\{\,\ldots\,\}$').
@z
------------------------------------------------------------------------------
@x l.856 Correct a typo.
interrupts normal reading and start looking at the file named after the
@y
interrupts normal reading and starts looking at the file named after the
@z
------------------------------------------------------------------------------
@x l.873
\more On UNIX systems (and others that support environment variables),
if the environment variable \.{CWEBINPUTS} is set, or if the compiler flag
of the same name was defined at compile time,
\.{CWEB} will look for include files in the directory thus named, if
it cannot find them in the current directory.
@y
\more If an \.{@i}nclude file can not be found in the current directory
\.{CWEB} will look in standard directories like the \CEE/ preprocessor.
Multiple search paths may be specified in the environment variable
\.{CWEBINPUTS}, concatenated with \.{PATH\_SEPARATOR}s.  If the environment
variable is not set, some decent default paths are used instead.
@z
------------------------------------------------------------------------------
There are additional command line switches available:

    - `a' for support of AMIGA specific key words.
    - `g' for support of German captions and quotes.
    - `i' to suppress indentation of old-style parameter declarations.
    - 'o' to separate parameter declarations and statements.
    - `m' to activate communication between CWEB and the message
          browser of the SAS/C development system via ARexx.

@x l.995
\option b Print a banner line at the beginning of execution. (On
by default.)

\option f Force line breaks after each \CEE/ statement formatted
by \.{CWEAVE}. (On by default; \.{-f} saves paper but looks less \CEE/-like
to some people.) (Has no effect on \.{CTANGLE}.)

\option h Print a happy message at the conclusion of a successful
run. (On by default.)

\option p Give progress reports as the program runs. (On by default.)

\option s Show statistics about memory usage after the program
runs to completion. (Off by default.)
If you
have large \.{CWEB} files or sections, you may need to see
how close you come to exceeding the capacity of \.{CTANGLE} and/or \.{CWEAVE}.

\option x Include indexes and a table of contents in the \TEX/ file
output by \.{CWEAVE}. (On by default.) (Has no effect on \.{CTANGLE}.)
@y
\option a Treat {\mc AMIGA}-defined identifiers (like \&{UWORD} or 
\&{\_\_aligned}) as keywords. (On by default if \.{\_AMIGA} is defined as a
compile-time constant.) (Has no effect on \.{CTANGLE}.)

\option b Print a banner line at the beginning of execution. (On
by default.)

\option f Force line breaks after each \CEE/ statement formatted
by \.{CWEAVE}. (On by default; \.{-f} saves paper but looks less \CEE/-like
to some people.) (Has no effect on \.{CTANGLE}.)

\option g Use the German \.{CWEB} macros \.{gcwebmac.tex} instead of
the English ones. (On by default) (Has no effect on \.{CTANGLE}.)

\option h Print a happy message at the conclusion of a successful
run. (On by default.)

\option i Indent parameters in function declarations.  This causes the
formal parameter declarations in function heads to be indented.  (On by
default; \.{-i} typesets declarations flush left; some people think this
to be more logical than indenting them) (Has no effect on \.{CTANGLE}.)

\option m Install communication between \.{CWEB} and the message browser of
the {\mc SAS/C} development system.  Set the external environment variable
\.{SCMSGOPT} to any legal command line option described in the
documentation by SAS Institute.  (Off by default; works only on the {\mc
AMIGA} system.)

\option o Separate declarations and the first statement in a function block.
\.{CWEAVE} automatically inserts a bit of extra space.  (On by default.)
(Has no effect on \.{CTANGLE}.)

\option p Give progress reports as the program runs. (On by default.)

\option s Show statistics about memory usage after the program
runs to completion. (Off by default.)
If you have large \.{CWEB} files or sections, you may need to see
how close you come to exceeding the capacity of \.{CTANGLE} and/or \.{CWEAVE}.

\option x Include indexes and a table of contents in the \TEX/ file
output by \.{CWEAVE}. (On by default.) (Has no effect on \.{CTANGLE}.)
@z
------------------------------------------------------------------------------
Also relate to this changed macro file and to the German version.
@x l.1417
\def\runninghead{APPENDIX B --- MACROS FOR FORMATTING}
\section Appendix B: The \.{cwebmac.tex} file.
This is the file that extends ``plain \TEX/'' format in order to support the
features needed by the output of \.{CWEAVE}.

\vskip6pt
\begingroup \def\tt{\eighttt} \baselineskip9pt
\def\printmacs{\input cwebmac}
\verbatim
!printmacs
!endgroup
\endgroup
\vfill\eject
@y
\def\runninghead{APPENDIX B --- MACROS FOR FORMATTING}
\section Appendix B: The \.{cwebmac.tex} file.
This is the file that extends ``plain \TEX/'' format in order to support the
features needed by the output of \.{CWEAVE}.

\vskip6pt
\begingroup \def\tt{\eighttt} \baselineskip9pt
\def\printmacs{\input cwebmac}
\verbatim
!printmacs
!endgroup
\endgroup
\vfill\eject
\def\runninghead{APPENDIX B --- MACROS FOR FORMATTING}
\section Appendix B: The \.{ccwebmac.tex} file.
Some of the macros in \.{cwebmac.tex} are changed to give better results.
This file is also included by the following \.{gcwebmac.tex}.

\vskip6pt
\begingroup \def\tt{\eighttt} \baselineskip9pt
\def\printmacs{\input ccwebmac}
\verbatim
!printmacs
!endgroup
\endgroup
\vfill\eject
\def\runninghead{ANHANG B --- MACROS F\"UR DIE FORMATIERUNG}
\section Anhang B: Die \.{gcwebmac.tex} Datei.
Diese Datei erweitert das ``plain \TEX/''-Format um Eigenschaften
zur Unterst\"utzung der Ausgabe von \.{CWEAVE}.

\vskip6pt
\begingroup \def\tt{\eighttt} \baselineskip9pt
\def\printmacs{\input gcwebmac}
\verbatim
!printmacs
!endgroup
\endgroup
\vfill\eject
@z
------------------------------------------------------------------------------
@x l.1505
  \.{ { }\\vskip 15pt \\centerline\{(Version 3.0)\}{ }\\vfill\}}\cr}$$
@y
  \.{ { }\\vskip 15pt \\centerline\{(Version 3.1 [p9c])\}{ }\\vfill\}}\cr}$$
@z
------------------------------------------------------------------------------
@x l.1587
\point 14. To get output in languages other than English, redefine the
macros \.{\\A}, \.{\\ET}, \.{\\Q}, \.{\\U},
\.{\\ch}, \.{\\fin}, and \.{\\con}. \.{CWEAVE} itself need not be changed.
@y
\point 14. To get output in languages other than English, redefine the
macros \.{\\A}, \.{\\ET}, \.{\\Q}, \.{\\U},
\.{\\ch}, \.{\\fin}, and \.{\\con}.  Possibly you want to change the date
and time formats too.  \.{CWEAVE} itself need not be changed.
@z
------------------------------------------------------------------------------
