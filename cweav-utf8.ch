@x
@c @<Include files@>@/
@y
@c
#include <wchar.h>
#include <locale.h>
#include <wctype.h>
@<Include files@>@/
@z

@x
  argc=ac; argv=av;
@y
  setlocale(LC_CTYPE, "en_US.UTF-8");
  argc=ac; argv=av;
@z

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
@d is_tiny(p) ((p+1)->byte_start==(p)->byte_start+1)
@y
@d is_tiny(p) ((p+1)->byte_start==(p)->byte_start+mblen((p)->byte_start, MB_CUR_MAX))
@z

@x
@d out(c) {if (out_ptr>=out_buf_end) break_out(); *(++out_ptr)=c;}
@y
@d out(c) {
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
      if (xislower(*p)) { /* not entirely uppercase */
         delim='\\'; break;
      }
@y
      if (xislower(*p)) { /* not entirely uppercase */
         delim='\\'; break;
      }
      else if (ishigh(*p)) {
          wchar_t wc;
          mbtowc(&wc, p, MB_CUR_MAX);
          if (iswlower(wc)) {
            delim = '\\'; break;
          }
        }
@z

@x
  out((cur_name->byte_start)[0]);
@y
  out((cur_name->byte_start)[0]);
  for (int w = 1; w < mblen(cur_name->byte_start, MB_CUR_MAX); w++)
    out((cur_name->byte_start)[w]);
@z

@x
        if (xislower(*j)) goto lowcase;
@y
        if (xislower(*j)) goto lowcase;
        else if (ishigh(*j)) {
          wchar_t wc;
          mbtowc(&wc, j, MB_CUR_MAX);
          if (iswlower(wc))
            goto lowcase;
        }
@z
