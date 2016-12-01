@x
@<Include files@>@/
@y
#include <locale.h>
@<Include files@>@/
extern char *encTeX[];
@z

@x
  argc=ac; argv=av;
@y
  setlocale(LC_CTYPE, "en_US.UTF-8");
  argc=ac; argv=av;
@z

@x
@i common.h
@y
@i comm-utf8.h
@z

@x
    else C_printf("%s",translit[(unsigned char)(*j)-0200]);
@y
    else {
      unsigned char z;
      for(z = 0x80; z <= 0xff; z++)
        if (encTeX[z] && (strncmp(j, encTeX[z], strlen(encTeX[z])) == 0))
          break;
      C_printf("%s",translit[z-0200]);
      j+=strlen(encTeX[z])-1;
    }
@z
