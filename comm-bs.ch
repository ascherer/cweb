Changes for code common to CTANGLE and CWEAVE, for MSDOS
and Borland C++ 3.1 using the following options (and perhaps others):

    -mc -w-pro -Ff=5000 -Z- -O-p

The options -Z- and -O-p explicitly turn off optimizations that seem to be
dangerous for the style of code in the CWEB sources.  (See makefile.bs.)

The main purpose of these changes is to support MSDOS with full-size arrays
by using "huge" pointers.

(This file contributed by Barry Schwartz, trashman@crud.mn.org, 28 Jun 94;
 revised 24 Jul 94.)


@x Section 23.
    cur_file_name[l]='/'; /* \UNIX/ pathname separator */
@y
    cur_file_name[l]='/'; /* A valid {\mc MSDOS} pathname separator */
@z


@x Section 27.
@d max_names 10239 /* number of identifiers, strings, section names;
  must be less than 10240 */

@<Common code...@>=
typedef struct name_info {
  char *byte_start; /* beginning of the name in |byte_mem| */
  @<More elements of |name_info| structure@>@;
} name_info; /* contains information about an identifier or section name */
typedef name_info *name_pointer; /* pointer into array of |name_info|s */
char byte_mem[max_bytes]; /* characters of names */
char *byte_mem_end = byte_mem+max_bytes-1; /* end of |byte_mem| */
name_info name_dir[max_names]; /* information about names */
name_pointer name_dir_end = name_dir+max_names-1; /* end of |name_dir| */
@y
@d max_names 10239 /* number of identifiers, strings, section names;
  must be less than 10240 */

@f huge extern

@<Common code...@>=
typedef struct name_info {
  char huge* byte_start; /* beginning of the name in |byte_mem| */
  @<More elements of |name_info| structure@>@;
} name_info; /* contains information about an identifier or section name */
typedef name_info *name_pointer; /* pointer into array of |name_info|s */
char huge byte_mem[max_bytes]; /* characters of names */
char huge* byte_mem_end; /* end of |byte_mem| */
name_info name_dir[max_names]; /* information about names */
name_pointer name_dir_end = name_dir+max_names-1;
@z


@x Section 29.
char *byte_ptr; /* first unused position in |byte_mem| */
@y
char huge* byte_ptr; /* first unused position in |byte_mem| */
@z


@x Section 30.
@ @<Init...@>=
name_dir->byte_start=byte_ptr=byte_mem; /* position zero in both arrays */
name_ptr=name_dir+1; /* |name_dir[0]| will be used only for error recovery */
name_ptr->byte_start=byte_mem; /* this makes name 0 of length zero */
@y
@ @<Init...@>=
name_dir->byte_start=byte_ptr=byte_mem; /* position zero in both arrays */
name_ptr=name_dir+1; /* |name_dir[0]| will be used only for error recovery */
name_ptr->byte_start=byte_mem; /* this makes name 0 of length zero */
byte_mem_end = byte_mem+max_bytes-1;
@z


@x Section 42.
void
print_section_name(
name_pointer p)
{
  char *ss, *s = first_chunk(p);
@y
void
print_section_name(
name_pointer p)
{
  char huge* ss, huge* s = first_chunk(p);
@z


@x Section 43.
void
sprint_section_name(
  char *dest,
  name_pointer p)
{
  char *ss, *s = first_chunk(p);
@y
void
sprint_section_name(
  char *dest,
  name_pointer p)
{
  char huge* ss, huge* s = first_chunk(p);
@z


@x Section 44.
void
print_prefix_name(
name_pointer p)
{
  char *s = first_chunk(p);
@y
void
print_prefix_name(
name_pointer p)
{
  char huge* s = first_chunk(p);
@z


@x Section 47.
static name_pointer
add_section_name(@t\1\1@> /* install a new node in the tree */
name_pointer par, /* parent of new node */
int c, /* right or left? */
char *first, /* first character of section name */
char *last, /* last character of section name, plus one */
int ispref@t\2\2@>) /* are we adding a prefix or a full name? */
{
  name_pointer p=name_ptr; /* new node */
  char *s=first_chunk(p);
@y
static name_pointer
add_section_name(@t\1\1@> /* install a new node in the tree */
name_pointer par, /* parent of new node */
int c, /* right or left? */
char *first, /* first character of section name */
char *last, /* last character of section name, plus one */
int ispref@t\2\2@>) /* are we adding a prefix or a full name? */
{
  name_pointer p=name_ptr; /* new node */
  char huge* s=first_chunk(p);
@z


@x Section 48.
static void
extend_section_name(@t\1\1@>
name_pointer p, /* name to be extended */
char *first, /* beginning of extension text */
char *last, /* one beyond end of extension text */
int ispref@t\2\2@>) /* are we adding a prefix or a full name? */
{
  char *s;
@y
static void
extend_section_name(@t\1\1@>
name_pointer p, /* name to be extended */
char *first, /* beginning of extension text */
char *last, /* one beyond end of extension text */
int ispref@t\2\2@>) /* are we adding a prefix or a full name? */
{
  char huge* s;
@z


@x Section 54.
static int section_name_cmp(@t\1\1@>
char **pfirst, /* pointer to beginning of comparison string */
int len, /* length of string */
name_pointer r@t\2\2@>) /* section name being compared */
{
  char *first=*pfirst; /* beginning of comparison string */
  name_pointer q=r+1; /* access to subsequent chunks */
  char *ss, *s=first_chunk(r);
@y
static int section_name_cmp(@t\1\1@>
char **pfirst, /* pointer to beginning of comparison string */
int len, /* length of string */
name_pointer r@t\2\2@>) /* section name being compared */
{
  char *first=*pfirst; /* beginning of comparison string */
  name_pointer q=r+1; /* access to subsequent chunks */
  char huge* ss, huge* s=first_chunk(r);
@z


@x Section 55.
source files, respectively; here we just declare a common field
|equiv_or_xref| as a pointer to |void|.

@<More elements of |name...@>=
void *equiv_or_xref; /* info corresponding to names */
@y
source files, respectively.  Here we just declare a common field
|ptr_union| as a union of pointers to |void|, which happen to have
different addressing attributes.

@<More elements of |name...@>=
union {
  void *equiv_member;
  void huge* xref_member;
} ptr_union;  /* info corresponding to names */
@z


@x Section 69.
An omitted change file argument means that |"/dev/null"| should be used,
@y
An omitted change file argument means that |"NUL"| should be used,
@z


@x Section 70.
  strcpy(change_file_name,"/dev/null");
@y
  strcpy(change_file_name,"NUL");
@z


@x Section 70.
        else if (*s=='/') dot_pos=NULL,name_pos=++s;
@y
        else if (*s == ':' || *s == '\\' || *s == '/')
	  dot_pos=NULL,name_pos=++s;
@z
