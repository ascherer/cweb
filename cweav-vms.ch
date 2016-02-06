This is the change file for CWEB's CWEAVE for VAX/VMS.

created:
    1991 JM (John Mulhollen, Science Applications International Corporation)

modified:
    01-FEB-1992 ST (Stephan Trebels <trebels@ams02.dnet.gwdg.de>)
    > include ctype,stdio from textlibrary SYS$SHARE:VAXCDEF.TLB
    > change banner line to include (VAX/VMS)
    > allow $ in identifiers (*necessary* for VAX/VMS)
    ? will someone eventally make a CLD interface? (should be easy)

(also modified by Don Knuth to keep version numbers uptodate)

@x l.64 section 1 (01-FEB-1992 ST) (18-NOV-1993 AS)
@d banner "This is CWEAVE (Version 3.0)\n"
@y
@d banner "This is CWEAVE (VAX/VMS Version 3.0)\n"
@z

@x l.36 section 6 (from common.h) (01-FEB-1992 ST) (18-NOV-1993 AS)
#include <stdio.h>
@y
#include stdio /* VMS searches Textlibraries faster */
@z

@x l.645 section 38 (1991 JM) (01-FEB-1992 ST) (18-NOV-1993 AS)
#include <ctype.h>
@y
#include ctype /* VMS searches Textlibraries faster */
@z

@x l.651 section 39 (01-FEB-1992 ST) (18-NOV-1993 AS)
@d isxalpha(c) ((c)=='_') /* non-alpha character allowed in identifier */
@y
@d isxalpha(c) ((c)=='_' || (c)=='$') /* non-alpha characters allowed in id */
@z
