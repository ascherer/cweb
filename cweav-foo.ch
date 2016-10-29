@x
@d buf_size 100 /* maximum length of input line, plus one */
@y
@d buf_size 1000 /* maximum length of input line, plus one */
@z

@x
@d line_length 80 /* lines of \TEX/ output have at most this many characters;
@y
@d line_length 255 /* lines of \TEX/ output have at most this many characters;
@z

@x
@d out(c) {if (out_ptr>=out_buf_end) break_out(); *(++out_ptr)=c;}
@y
@<Predecl...@>=
void out(char c);
@ @c
void out(char c)
{
  int utf8count = 0;
  for (char *i = out_buf; i<=out_ptr; i++) {
    if ((((eight_bits)(*i) & (1<<7)) &&
          ((eight_bits)(*i) & (1<<6))) ||
          (~((eight_bits)(*i)) & (1<<7))) /* increase if 0x or 11x */
      utf8count++;
  }
  if (utf8count>80) break_out();
  *(++out_ptr)=c;
}
@ Dummy.
@z

@x
  int count; /* characters remaining before string break */
@y
  int count; /* characters remaining before string break */
  int finish_symbol;
@z

@x
  if (count==0) { /* insert a discretionary break in a long string */
     app_str(@q(@>@q{@>"}\\)\\.{"@q}@>); count=20;
@q(@>@.\\)@>
  }
@y
  if (count==0) {
     if (((eight_bits)(*id_first) & (1<<7)) &&
        (~((eight_bits)(*id_first)) & (1<<6))) { /* if we see 10x, move on */
       count=1;
       finish_symbol = 1;
     }
     else {
       finish_symbol = 0;
       app_str("}\\)\\.{");
       count=20;
     }
  }
@z

@x
  count--;
@y
  if (finish_symbol == 1) count--;
  else if ((((eight_bits)(*(id_first - 1)) & (1<<7)) &&
          ((eight_bits)(*(id_first - 1)) & (1<<6))) ||
          (~((eight_bits)(*(id_first - 1))) & (1<<7))) /* decrease only when we see 11x or 0x */
         count--;
@z

@x
  } else if (is_tiny(cur_name)) out('|')@;
@y
  } else if (is_tiny(cur_name)) out('|');
@z

@x
      if (b!='0' || force_lines==0) out(b)@;
@y
      if (b!='0' || force_lines==0) out(b);
@z

@x
  else if (b!='|') out(b)
@y
  else if (b!='|') out(b);
@z
