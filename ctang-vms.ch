This is the change file for CWEB's CTANGLE for VAX/VMS.

created:
    01-FEB-1992 ST (Stephan Trebels <trebels@ams02.dnet.gwdg.de>)
    > include ctype,stdio from textlibrary SYS$SHARE:VAXCDEF.TLB
    > change banner line to include (VAX/VMS)
    ? will someone make a CLD interface? (should be easy)

(also modified by Don Knuth to keep version numbers uptodate)
(these changes not necessary for initial bootstrapping)

@x l.59 section 1 (01-FEB-1992 ST) (18-NOV-1993 AS)
@d banner "This is CTANGLE (Version 3.1)\n"
@y
@d banner "This is CTANGLE (VAX/VMS Version 3.1)\n"
@z

@x l.36 section 6 common.h (01-FEB-1992 ST) (18-NOV-1993 AS)
#include <stdio.h>
@y
#include stdio /* VMS searches Textlibraries faster */
@z

@x l.874 section 62 (01-FEB-1992 ST) (18-NOV-1993 AS)
#include <ctype.h> /* definition of |isalpha|, |isdigit| and so on */
@y
#include ctype /* definition of |isalpha|, |isdigit| and so on */
               /* VMS searches text libraries faster */
@z

@x l.880 section 83 (01-FEB-1992 ST) (18-NOV-1993 AS)
@d isxalpha(c) ((c)=='_') /* non-alpha character allowed in identifier */
@y
@d isxalpha(c) ((c)=='_' || (c)=='$') /* non-alpha characters allowed in id */
@z
