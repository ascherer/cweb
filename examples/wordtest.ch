								-*-Web-*-
This file, WORDTEST.CH, is part of CWEB.  It is a changefile written by
Andreas Scherer, Abt-Wolf-Straﬂe 17, 96215 Lichtenfels, Germany, for
WORDTEST.W that provides changes appropriate for ANSI-C compilers.

This program is distributed WITHOUT ANY WARRANTY, express or implied.

The following copyright notice extends to this changefile only, not to the
masterfile.

Copyright (c) 1993 Andreas Scherer

Permission is granted to make and distribute verbatim copies of this
document provided that the copyright notice and this permission notice
are preserved on all copies.

Permission is granted to copy and distribute modified versions of this
document under the conditions for verbatim copying, provided that the
entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

Version history:

Version	Date		Author	Comment
p1	1 Sep 1993	AS	First hack.
p2	25 Oct 1993	AS	Updated to CWEB 3.0
p3	18 Nov 1993	AS	Updated to CWEB 3.1
------------------------------------------------------------------------------
Some external routines need prototypes.
@x l.92
@p
#include <stdio.h>
@y
@p
#include <stdio.h>
#include <stdlib.h>
@z
------------------------------------------------------------------------------
