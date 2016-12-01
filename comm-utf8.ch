@x
@<Include files@>@/
@y
#include <wchar.h>
#include <limits.h>
@<Include files@>@/
size_t mbsntowcs (wchar_t *pwcs, const char *s, size_t n, size_t len)
{
  return mbsnrtowcs(pwcs, &s, n, len, NULL);
}
char *encTeX[256];
@z

@x
@c
void
common_init()
{
@y
@c
void
common_init()
{
  /* this mapping table mirrors encTeX definitions */
  encTeX[0x80] = "А";
  encTeX[0xa0] = "а";
  encTeX[0x81] = "Б";
  encTeX[0xa1] = "б";
  encTeX[0x82] = "В";
  encTeX[0xa2] = "в";
  encTeX[0x83] = "Г";
  encTeX[0xa3] = "г";
  encTeX[0x84] = "Д";
  encTeX[0xa4] = "д";
  encTeX[0x85] = "Е";
  encTeX[0xa5] = "е";
  encTeX[0xf0] = "Ё";
  encTeX[0xf1] = "ё";
  encTeX[0x86] = "Ж";
  encTeX[0xa6] = "ж";
  encTeX[0x87] = "З";
  encTeX[0xa7] = "з";
  encTeX[0x88] = "И";
  encTeX[0xa8] = "и";
  encTeX[0x89] = "Й";
  encTeX[0xa9] = "й";
  encTeX[0x8a] = "К";
  encTeX[0xaa] = "к";
  encTeX[0x8b] = "Л";
  encTeX[0xab] = "л";
  encTeX[0x8c] = "М";
  encTeX[0xac] = "м";
  encTeX[0x8d] = "Н";
  encTeX[0xad] = "н";
  encTeX[0x8e] = "О";
  encTeX[0xae] = "о";
  encTeX[0x8f] = "П";
  encTeX[0xaf] = "п";
  encTeX[0x90] = "Р";
  encTeX[0xe0] = "р";
  encTeX[0x91] = "С";
  encTeX[0xe1] = "с";
  encTeX[0x92] = "Т";
  encTeX[0xe2] = "т";
  encTeX[0x93] = "У";
  encTeX[0xe3] = "у";
  encTeX[0x94] = "Ф";
  encTeX[0xe4] = "ф";
  encTeX[0x95] = "Х";
  encTeX[0xe5] = "х";
  encTeX[0x96] = "Ц";
  encTeX[0xe6] = "ц";
  encTeX[0x97] = "Ч";
  encTeX[0xe7] = "ч";
  encTeX[0x98] = "Ш";
  encTeX[0xe8] = "ш";
  encTeX[0x99] = "Щ";
  encTeX[0xe9] = "щ";
  encTeX[0x9a] = "Ъ";
  encTeX[0xea] = "ъ";
  encTeX[0x9b] = "Ы";
  encTeX[0xeb] = "ы";
  encTeX[0x9c] = "Ь";
  encTeX[0xec] = "ь";
  encTeX[0x9d] = "Э";
  encTeX[0xed] = "э";
  encTeX[0x9e] = "Ю";
  encTeX[0xee] = "ю";
  encTeX[0x9f] = "Я";
  encTeX[0xef] = "я";
  encTeX[0xfc] = "№";
@z

@x
@d long_buf_size (buf_size+longest_name) /* for \.{CWEAVE} */
@y
@d long_buf_size (buf_size*MB_LEN_MAX+longest_name*MB_LEN_MAX) /* for \.{CWEAVE} */
@z

@x
char *buffer_end=buffer+buf_size-2; /* end of |buffer| */
@y
char *buffer_end=buffer+buf_size*MB_LEN_MAX-2; /* end of |buffer| */
@z

@x
  while (k<=buffer_end && (c=getc(fp)) != EOF && c!='\n')
    if ((*(k++) = c) != ' ') limit = k;
  if (k>buffer_end)
@y
  while ((ssize_t)mbsntowcs(NULL,buffer,k-buffer,0)<buf_size-1 && (c=getc(fp)) != EOF && c!='\n')
    if ((*(k++) = c) != ' ') limit = k;
  if (mbsntowcs(NULL,buffer,k-buffer,0)>=buf_size-1)
@z

@x
char change_buffer[buf_size]; /* next line of |change_file| */
@y
char change_buffer[buf_size*MB_LEN_MAX]; /* next line of |change_file| */
@z
