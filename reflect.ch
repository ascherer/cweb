% change file for ``stripped down'' version of reflect.w ($B_n$ only)
@x
\nocon
@y
\nocon
\let\maybe=\iffalse
\def\title{RFL}
@z
@x
to enumerate only $B_n$ when $n=9$.
@y
to enumerate only $B_n$ when $n=9$. In fact, this program is that stripped
down version, contrary to what is said above. This program does $n=7$ in
4~seconds, $n=8$ in 4:42 minutes, and I think it will do $n=9$ in about
10 hours. I tried several experiments for benchmarking, since this program
is clearly compute-bound: Compiling with \.{-g} instead of with \.{-O}
increased the running time for $n=8$ to 6:19; if I also removed the
|register| hints on variables |i,ii,iii,j|, it went up to 9:09.
With optimization and no register hints it took 6:38.
(When I actually computed $B_9=112018190$, I used the slowest version,
with no register hints and the \.{-g} switch; that took 19:50:37.)
@z
@x
int j; /* current place in array */
int l; /* current choice level */
int c[npairs]; /* code for choices made */
int t[npairs]; /* |j| values where choices were made */
int i,ii,iii; /* general-purpose indices */
@y
int l; /* current choice level */
int c[npairs]; /* code for choices made */
int t[npairs]; /* |j| values where choices were made */
@z
@x
  char** argv; /* the args */
{
@y
  char** argv; /* the args */
{@+register int j; /* current place in array */
  register int i,ii,iii; /* general-purpose indices */
@z
@x
  printf("B=%d, C=%d, D=%d, E=%d\n",bn,cn,dn,en);
  printf("scores min=%d, max=%d, mean=%.1f\n",smin,smax,stot/(float)dn);
@y
  printf("B=%d\n",bn);
@z
@x
  if (k==0) @<Print a solution@>;
@y
  if (k==0)
    if ((++bn % 1000000)==0) {
      for (i=1;i<l;i++)
        if (c[i]) putchar('0'-1+t[i]);
      putchar('\n');
    }
@z
