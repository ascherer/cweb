@x l.70
@c @<Include files@>@/
@y
@c
#include <wchar.h>
#include <wctype.h>
#include <limits.h>
#include <locale.h>
@<Include files@>@/
size_t mbsntowcs (wchar_t *, const char *, size_t, size_t);
extern char *encTeX[];
unsigned char enc(char *p)
{
  unsigned char z;
  wchar_t wc;
  char mb[MB_CUR_MAX];

  mbtowc(&wc, p, MB_CUR_MAX);
  if (iswupper(wc)) wc=towlower(wc);
  wctomb(mb, wc);

  for(z = 0x80; z <= 0xff; z++)
    if (encTeX[z] && (strncmp(mb, encTeX[z], strlen(encTeX[z])) == 0))
      break;

  return z;
}
@z

@x l.102
  argc=ac; argv=av;
@y
  setlocale(LC_CTYPE, "en_US.UTF-8");
  argc=ac; argv=av;
@z

@x l.128
@d long_buf_size (buf_size+longest_name)
@y
@d long_buf_size (buf_size*MB_LEN_MAX+longest_name*MB_LEN_MAX)
@z

@x l.143
@i common.h
@y
@i comm-utf8.h
@z

@x l.270
@d is_tiny(p) ((p+1)->byte_start==(p)->byte_start+1)
@y
@d is_tiny(p) ((p+1)->byte_start==(p)->byte_start+mblen((p)->byte_start,MB_CUR_MAX))
@z

@x l.1300
char out_buf[line_length+1]; /* assembled characters */
@y
char out_buf[line_length*MB_LEN_MAX+1]; /* assembled characters */
@z

@x l.1302
char *out_buf_end = out_buf+line_length; /* end of |out_buf| */
@y
char *out_buf_end = out_buf+line_length*MB_LEN_MAX; /* end of |out_buf| */
@z

@x l.1380
@d out(c) {if (out_ptr>=out_buf_end) break_out(); *(++out_ptr)=c;}
@y
@d out(c) {
  if ((ssize_t)mbsntowcs(NULL,out_buf,out_ptr-out_buf+1,0)>line_length) break_out();
  *(++out_ptr)=c;
}
@z

@x l.3359
  if((eight_bits)(*id_first)>0177) {
    app_tok(quoted_char);
    app_tok((eight_bits)(*id_first++));
  }
@y
  if((eight_bits)(*id_first)>0177) {
    for (int w = mblen(id_first,MB_CUR_MAX); w > 0; w--) {
      app_tok(quoted_char);
      app_tok((eight_bits)(*id_first++));
    }
  }
@z

@x l.3696
  char scratch[longest_name]; /* scratch area for section names */
@y
  char scratch[longest_name*MB_LEN_MAX]; /* scratch area for section names */
@z

@x l.3752
      if (xislower(*p)) { /* not entirely uppercase */
         delim='\\'; break;
      }
@y
      {
        wchar_t wc;
        mbtowc(&wc, p, MB_CUR_MAX);
        if (iswlower(wc)) {
          delim='\\'; break;
        }
      }
@z

@x l.3768
  out((cur_name->byte_start)[0]);
@y
  for (int w = 0; w < mblen(cur_name->byte_start,MB_CUR_MAX); w++)
    out(*(cur_name->byte_start + w));
@z

@x l.4388
      if (xisupper(c)) c=tolower(c);
@y
      if (xisupper(c)) c=tolower(c);
      else if (ishigh(c)) c=enc(cur_name->byte_start);
@z

Move 'ё' down next to 'е' and shift the rest of the sequence:

@x l.4453
strcpy(collate+133,"\240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257");
/* 16 characters + 133 = 149 */
strcpy(collate+149,"\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277");
/* 16 characters + 149 = 165 */
strcpy(collate+165,"\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317");
/* 16 characters + 165 = 181 */
strcpy(collate+181,"\320\321\322\323\324\325\326\327\330\331\332\333\334\335\336\337");
/* 16 characters + 181 = 197 */
strcpy(collate+197,"\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357");
/* 16 characters + 197 = 213 */
strcpy(collate+213,"\360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377");
@y
strcpy(collate+133,"\240\241\242\243\244\245\361\246\247\250\251\252\253\254\255\256");
/* 16 characters + 133 = 149 */
strcpy(collate+149,"\257\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276");
/* 16 characters + 149 = 165 */
strcpy(collate+165,"\277\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316");
/* 16 characters + 165 = 181 */
strcpy(collate+181,"\317\320\321\322\323\324\325\326\327\330\331\332\333\334\335\336");
/* 16 characters + 181 = 197 */
strcpy(collate+197,"\337\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356");
/* 16 characters + 197 = 213 */
strcpy(collate+213,"\357\360\362\363\364\365\366\367\370\371\372\373\374\375\376\377");
@z

@x l.4509
    cur_byte=cur_name->byte_start+cur_depth;
    if (cur_byte==(cur_name+1)->byte_start) c=0; /* hit end of the name */
    else {
      c=(eight_bits) *cur_byte;
      if (xisupper(c)) c=tolower(c);
@y
    cur_byte=cur_name->byte_start;
    for (int w = 0; w < cur_depth; w++)
      cur_byte+=mblen(cur_byte,MB_CUR_MAX);
    if (cur_byte==(cur_name+1)->byte_start) c=0; /* hit end of the name */
    else {
      c=(eight_bits) *cur_byte;
      if (xisupper(c)) c=tolower(c);
      else if (ishigh(c)) c=enc(cur_byte);
@z

@x l.4536
        if (xislower(*j)) goto lowcase;
@y
        {
          wchar_t wc;
          mbtowc(&wc, j, MB_CUR_MAX);
          if (iswlower(wc)) goto lowcase;
        }
@z
