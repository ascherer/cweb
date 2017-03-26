@x
% This file is part of CWEB.
@y
% This file is part of CTWILL, a modification of CWEB.
@z

@x
\advance\midcol-8pt
\+& |typedef_like| \alt|int_like| |cast| \alt|comma| |semi| &
    |typedef_like| |exp| \alt|comma| |semi| & \&{typedef} \&{int} \&I,\cr
\advance\midcol+8pt
\+& |typedef_like| |int_like| & |typedef_like| \hfill $T\.\ I$ &
    \&{typedef} \&{char}\cr
\+\dagit& |typedef_like| |exp| & |typedef_like| \hfill $T\.\ E^{**}$ &
    \&{typedef} \&I \.{@@[@@]} (|*|\&P)\cr
\+& |typedef_like| |comma| & |typedef_like| \hfill $TC\.\ $ &
    \&{typedef} \&{int} \&x,\cr
\+& |typedef_like| |semi| & |decl| & \&{typedef} \&{int} $\&x,\&y$;\cr
\+& |typedef_like| |ubinop| \alt |cast| |ubinop| & 
    |typedef_like| \alt |cast| |ubinop| \hfill
    \alt $C=\.\{U\.\}C$ $U_2=\.\{U_1\.\}U_2$ \unskip &
    \&{typedef} |*|{}|*|(\&{CPtr})\cr
@y
\advance\midcol-3pt
\+\dag200\enspace& |typedef_like| |decl_head| \alt|exp| |int_like| &
      |typedef_like| |decl_head| \hfill $D=D$\alt $E^{**}$ $I^{**}$ \unskip &
          \&{typedef} \&{char} \&{ch};\cr
\advance\midcol+3pt
\+201\enspace& |typedef_like| |decl_head| |semi| & |decl| \hfill $T\.\ D$ &
                                             \&{typedef} \&{int} $\&x,\&y$;\cr
\+\dag202\enspace& |typedef_like| |int_like| |raw_int| & |typedef_like| |int_like| |exp| &
  \&{typedef} \&{int} \&{foo}\cr
\global\prodno=121
@z

@x
Rule 117: The |exp| must not be immediately followed by |lpar|, |exp|,
or |cast|.

Rule 123: The mathness of the |colon| or |base| changes to `yes'.
@y
Rule 123: The mathness of the |colon| or |base| changes to `yes'.
 
Rule 200: The |exp| must not be immediately followed by |lpar| or~|exp|.

Rule 202: The |raw_int| must be immediately followed by |semi| or |comma|.
@z
