@x
@ @<Output index...@>= {
@y
@ If current list has more than one element, sort it alphabetically.
(Note that strings of bytes signified by the |name_pointer|s, contained in the
list, have equal length.)

@<Output index...@>= {
if (blink[sort_ptr->head-name_dir]!=NULL)
  @<Sort the list at |sort_ptr| before output@>@;
@z

@x
@ @<Output the name...@>=
@y
@ @<Sort the list...@>= {
loop:
  next_name=sort_ptr->head;
  do {
    cur_name=next_name;
    next_name=blink[cur_name-name_dir];
    if (strncmp(cur_name->byte_start,next_name->byte_start,
	      length(cur_name)) > 0) {
	    @<Swap neighbour elements@>@;
	    goto loop;
    }
  } while (blink[next_name-name_dir]!=NULL);
}

@ @<Swap...@>=
if (cur_name==sort_ptr->head)
  sort_ptr->head=next_name;
else {
  @<Find link to |cur_name|@>@;
  blink[cur_link-name_dir]=next_name;
}
blink[cur_name-name_dir]=blink[next_name-name_dir];
blink[next_name-name_dir]=cur_name;

@ @<Find link...@>=
name_pointer cur_link=sort_ptr->head;
while (blink[cur_link-name_dir]!=cur_name) cur_link=blink[cur_link-name_dir];

@ @<Output the name...@>=
@z
