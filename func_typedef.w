@* Pointer-to-function types.

@s MP int
@s mp_number int

@c @2
typedef void @[@] (*print_func) (MP mp, mp_number A);

@ @c
typedef @[char *@] (*tostring_func) (MP mp, mp_number A);

@* Index.
