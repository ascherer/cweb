								-*-Web-*-
This file, TREEPRINT.CH, is part of CWEB.  It is a changefile written
by Andreas Scherer, Abt-Wolf-Straﬂe 17, 96215 Lichtenfels, Germany, for
TREEPRINT.W that provides changes appropriate for ANSI-C compilers.

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
The internal routines deserve their declarations.
@x l.17
@c
@<Global definitions@>@;
@<Global include files@>@;
@<Global declarations@>@;
@y
@c
@<Global definitions@>@;
@<Global include files@>@;
@<Global declarations@>@;
@<Prototypes@>@;
@z
------------------------------------------------------------------------------
@x l.55
@c
read_tree (fp, rootptr)
   FILE *fp;
   struct tnode **rootptr;
@y
@c
void read_tree (fp, rootptr)
   FILE *fp;
   struct tnode **rootptr;
@z
------------------------------------------------------------------------------
Some external routines and all the internal routines need prototypes.
@x l.67
@ @<Global include...@>=#include <stdio.h>
@y
@ @<Global include...@>=
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
@z
------------------------------------------------------------------------------
@x l.79
@c
add_tree(rootptr, p)
     struct tnode **rootptr;
     char *p;
@y
@c
void add_tree(rootptr, p)
     struct tnode **rootptr;
     char *p;
@z
------------------------------------------------------------------------------
|malloc| is declared in <stdlib.h>.
@x l.127
       (*rootptr)->data = malloc (strlen(p)+1);

@
@<Global decl...@>= char *malloc();

@ In this simple implementation, we just read from standard input.
@<Read...@>= read_tree(stdin,&root);
@y
       (*rootptr)->data = malloc (strlen(p)+1);

@ |malloc| is already declared in {\tt stdlib.h>}.

@ In this simple implementation, we just read from standard input.
@<Read...@>= read_tree(stdin,&root);
@z
------------------------------------------------------------------------------
@x l.193
@c
print_node(fp, indent_string, node)
     FILE *fp;
     char *indent_string;
     struct tnode *node;
@y
@c
void print_node(fp, indent_string, node)
     FILE *fp;
     char *indent_string;
     struct tnode *node;
@z
------------------------------------------------------------------------------
Correct a typo.
@x l.217
    *is=='\0';
@y
    *is='\0';
@z
------------------------------------------------------------------------------
The module numbering is preserved.
@x l.247
@*Index.
@y
@ At last we declare the function prototypes.

@<Prototypes@>=
int main(int,char **);
void read_tree(FILE *,struct tnode **);
void add_tree(struct tnode **,char *);
void print_node(FILE *,char *,struct tnode *);
@* Index.
@z
------------------------------------------------------------------------------
