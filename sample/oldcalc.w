
% THIS ENTIRE DOCUMENT IS LIMBO TEXT!

% defeat table of contents at end of each source module
\let\con\relax

% This counter is used so that we can have page numbers like "3.2" to
% mean page 2 of the listing for the 3rd module.
\newcount\srcmodnum

\newskip\tocskip
\setbox0=\hbox{000}
\tocskip=\wd0

% This macro takes a module name (without extension) and reads in the
% .toc file for that module, with an appropriate heading.  It is called
% in a loop (via \processmods) to make the combined table of contents.

\def\tocpart#1{%
   \bigskip
   \advance\srcmodnum by 1
   \line{{\bf Source Module \the\srcmodnum: #1}\hfil
      Section\hbox to4em{\hss Pa\rlap{ge}\hskip\tocskip}}%
   \nobreak
   \input #1.toc\relax
}

% This is the macro that makes lines in the table of contents.
% We modify it to include module numbers in the section and page numbers.
\def\Z#1#2#3{\line{\ignorespaces#1
    \leaders\hbox to .5em{.\hfil}\hfil
    \ \number\srcmodnum.\rlap{#2}\hskip\tocskip
    \hbox to4em{\hss\number\srcmodnum\rlap{.#3}\hskip\tocskip}}}


% This defeats attempts to close the ".toc" file, so that
% modules after the first won't spit their output to the terminal.
% Note that the ".toc" file created by TeX'ing this file is *GARBAGE*,
% it isn't even TeX-able.  That doesn't matter, since no document
% (including this one) ever reads it in.  It's simply easier to
% create it and ignore it than it would be to redefine all the macros
% in cwebmac that insist on trying to write to it (especially \inx).
\let\savecloseout\closeout
\def\closeout#1{%
\ifx#1\cont\else\savecloseout#1\fi
}

% This next bit is a grungy hack to prevent cwebmac.tex being input
% several times.  We use the fact that the first line of every ".tex"
% file written by cweave is "\input cwebmac".  We nullify this command
% by redefining the "\" character to be a macro that (1) eats up until
% an end-of-line, (2) throws away what it ate, and (3) restores the
% original meaning of "\".  Nasty, eh?  We don't want "cwebmac.tex"
% reloaded because we redefine many of its macros in this file.

\def\makeCRother{\catcode`\^^M=12 }
\def\makeCRendline{\catcode`\^^M=5 }
\def\makeslashactive{\catcode`\\=13 }
\def\makeslashescape{\catcode`\\=0 }

{\makeCRother %
\gdef\nullifyinput{\makeCRother\makeslashactive}%
\catcode`\|=0 %
\makeslashactive %
|gdef\#1^^M{|makeslashescape|makeCRendline}%
}

% In a similar vein, we want to redefine the first occurrence of \N
% in each file to typeset a chapter title for that file.

\let\temp\N
\def\N{}% to defeat outer-ness so def'ns of \restoreN and \replaceN will work
\def\restoreN{\let\N\saveN}
\def\replaceN{\let\N\newN}
\let\saveN\temp

% A modified version of \N; it typesets a title at the top of the page.
% We redefine the first occurrence of \N in each file to use this definition,
% so that we can get the name of the source module as a title on the first
% page of its listing.
% NOTE: this assumes that the first code section in each module is starred!
% If for some reason a module begins with a non-starred section, we will
% need a \newM as well.
\outer\def\newN#1.#2.{\MN#1.\vfil\eject % beginning of starred section
  \titletrue
  \centerline{\titlefont Source Module \the\srcmodnum: \title}%
  \bigskip
  \restoreN
  \def\rhead{\let\i=I\uppercase{\ignorespaces#2}} % define running headline
  \message{*\modno} % progress report
  \edef\next{\write\cont{\Z{#2}{\modno}{\the\pageno}}}\next % to contents file
  \ifon\startsection{\bf\ignorespaces#2.\quad}\ignorespaces}

% This takes a module name (without extension) as input and loads in
% the .tex file for that module, with appropriate formatting.
\def\codepart#1{%
\mark{1}% the first \topmark won't be null
\par\vfill\break
\setpage
\advance\srcmodnum by 1
\pageno=1
\uppercase{\def\title{#1}}%
\replaceN
\nullifyinput
\input #1\relax
}

% We redefine the running heads to include the source module number
% in the page and section numbers.
\def\lheader{\mainfont\the\srcmodnum.\the\pageno\eightrm\qquad\rhead\hfill
  \title\qquad
  \tensy x\mainfont\the\srcmodnum.\topmark} % top line on left-hand pages
\def\rheader{\tensy x\mainfont\the\srcmodnum.\topmark\eightrm\qquad\title
  \hfill\rhead
  \qquad\mainfont\the\srcmodnum.\the\pageno} % top line on right-hand pages

%%%%%%%%%%%%

% This is where we arrange for a combined index and list of sections.

% We save the old definitions of these macros
\let\saveinx\inx
\let\savefin\fin
\let\saveU\U
\let\saveUs\Us

% We open a file to receive the combined index
\newwrite\inxfile
\immediate\openout\inxfile=\jobname.inx\relax
\immediate\write\inxfile{\string\saveinx}

% We open a file to receive the combined list of sections
\newwrite\secfile
\immediate\openout\secfile=\jobname.sec\relax
\immediate\write\secfile{\string\savefin}

% Our modified \inx, instead of typesetting the index in place, redefines
% the index formatting operator \: to read the index entry and write it
% out (verbatim) to the file \inxfile.
\def\inx{%
The index for this module has been moved to the end of the listing.\par
\immediate\write\inxfile{\string\par\string\bigskip
\string\centerline{Index for Source Module \the\srcmodnum: \title}%
\string\bigskip}%
\makeCRother
\def\:{\setupverbatim\getinxline\:}%
\gobbleCR
}

% Likewise \fin, instead of typesetting the section list, redefines
% the formatting operators \:, \U, \Us to write the lines of the
% section list (verbatim) to the file \secfile.
\def\fin{%
\immediate\write\secfile{\string\par\string\bigskip
\string\centerline{Sections in Source Module \the\srcmodnum: \title}%
\string\bigskip}%
\makeCRother
\def\U{\setupverbatim\getsecline\U}%
\def\Us{\setupverbatim\getsecline\Us}%
\def\:{\setupverbatim\getsecline\:}%
\gobbleCR
}

% We use the \dospecials macro from "plain.tex" to prepare characters
% to be read verbatim
\def\setupverbatim{\begingroup\let\do\makeother\dospecials}
\def\makeother#1{\catcode`#1=12 }

% The \con macro, instead of setting a table of contents, turns off
% the writing-to-file activity initiated by \inx and \fin
\def\con{%
\makeCRendline
\let\U\saveU
\let\Us\saveUs
}%

% These are the macros that actually collect up information and write it out.
{\makeCRother %
\gdef\getinxline#1^^M{\immediate\write\inxfile{\string#1}\endgroup}%
\gdef\getsecline#1^^M{\immediate\write\secfile{\string#1}\endgroup}%
\gdef\gobbleCR^^M{}%
}

%%%%%%%%%%%%

% The following improved loop code is from
% Victor Eijkhout's book TeX by Topic
\long\def\myloop#1\repeat{\def\body{#1}\myiterate}
\def\myiterate{\let\next\relax
   \body  \let\next\myiterate  \fi  \next}

% We read the file \modlistfile to get the list of modules to process
\newread\modlistfile

% This starts out empty, and gets "\dothismod{foo}" added to it for
% each "foo" listed in the \modlistfile
\def\processmods{}

% We initialize \dothismod to \relax so the \edef below will work
\let\dothismod\relax

% We open up the list of modules, and read it one line at a time,
% building the module names into the macro \processmods
% until the end of the file (or, actually, a blank line)
\def\readmodules#1{%
\openin\modlistfile=#1\relax
\begingroup
\endlinechar=-1
\myloop
\read\modlistfile to\modname
\if\modname\par\else
\xdef\processmods{\processmods\dothismod{\modname}}%
\repeat
\endgroup
\closein\modlistfile
}

% The Makefile for this project is responsible for creating and
% maintaining "mod.lst"
\readmodules{mod.lst}

% at this point, if "mod.lst" contained the lines
%
%   foo
%   bar
%   baz
%
% then the expansion of \processmods is
%
%   \dothismod{foo}\dothismod{bar}\dothismod{baz}

%%%%%%%%%%%%

% Everything above was setup.
% From here on down we are actually typesetting text.

\titletrue

\rightskip 0pt \hyphenpenalty 50 \tolerance 200
\setpage

\centerline{\titlefont\title}
\vfill

\srcmodnum=0
\let\dothismod\tocpart
\processmods

\bigskip
\advance\srcmodnum by 1
\line{{\bf Combined Index }\leaders\hbox to .5em{.\hfil}\hfil
Page \the\srcmodnum\rlap{.1}\hskip\tocskip}

\srcmodnum=0
\let\dothismod\codepart
\processmods

\vfill\eject

\titletrue
\centerline{\titlefont Combined Index}
\bigskip
\advance\srcmodnum by 1
\pageno=1

\immediate\savecloseout\inxfile
\immediate\savecloseout\secfile
\input \jobname.inx
\input \jobname.sec

\immediate\savecloseout\cont

\end
