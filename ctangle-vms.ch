This is the change file for CWEB's CTANGLE for VAX/VMS.

created:
    01-FEB-1992 ST (Stephan Trebels <trebels@ams02.dnet.gwdg.de>)
    > include ctype,stdio from textlibrary SYS$SHARE:VAXCDEF.TLB
    > change banner line to include (VAX/VMS)
    ? will someone make a CLD interface? (should be easy)

(also modified by Don Knuth to keep version numbers uptodate)
(these changes not necessary for initial bootstrapping)

@x l.54 (01-FEB-1992 ST)
@d banner "This is CTANGLE (Version 2.3)\n"
@y
@d banner "This is CTANGLE (VAX/VMS) (Version 2.3)\n"
@z

@x l.35 common.h (01-FEB-1992 ST)
#include <stdio.h>
@y
#include stdio /* VMS searches Textlibraries faster */
@z

@x l.744 (01-FEB-1992 ST)
#include <ctype.h> /* definition of |isalpha|, |isdigit| and so on */
@y
#include ctype /* definition of |isalpha|, |isdigit| and so on */
               /* VMS searches text libraries faster */
@z

@x l.750 (01-FEB-1992 ST)
@d isxalpha(c) ((c)=='_') /* non-alpha character allowed in identifier */
@y
@d isxalpha(c) ((c)=='_' || (c)=='$') /* non-alpha characters allowed in id */
@z
