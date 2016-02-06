This is the change file for CWEB's COMMON under DOS
(Contributed by Lee Wittenberg, March 1993)

Changes necessary for compiling with Borland C/C++
Use compilation switches -mc -w-pro -Ff=5000

Note: The change to section 27 is not necessary if using a compiler
that allows >64K arrays.

@x section 27
@d max_bytes 90000 /* the number of bytes in identifiers,
@y
@d max_bytes (unsigned)60000 /* the number of bytes in identifiers,
@z

@x section 69
An omitted change file argument means that |"/dev/null"| should be used,
@y
An omitted change file argument means that |"NUL"| should be used,
@z

@x section 70
  if (!found_change) strcpy(change_file_name,"/dev/null");
@y
  if (!found_change) strcpy(change_file_name,"NUL");
@z
