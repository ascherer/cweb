@* Indentation. ``Classic'' and ``modern'' function headers have a similar
layout with regards to the indentation of parameters. You can suppress
parameter indentation with \.{cweave -i}.

@c
int main() /* No parameter */
{}

@ @c
int main2(void) /* No parameter */
{}

@ @c
int func1(para1) /* One parameter */
   int para1; /* First parameter */
{}

@ @c
int func2(para1,para2) /* Two parameters */
   int para1; /* First parameter */
   int para2; /* Second parameter */
{
}

@ @c
int proc1( /* One parameter */
   int para1) /* First parameter */
{}

@ @c
int proc2( /* Two parameters */
   int para1, /* First parameter */
   int para2) /* Second parameter */
{
}

@* Index.
