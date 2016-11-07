@x
@d buf_size 100 /* for \.{CWEAVE} and \.{CTANGLE} */
@y
@d buf_size 1000 /* for \.{CWEAVE} and \.{CTANGLE} */
@z

@x
  char *j, *k; /* pointer into |byte_mem| */
@y
  char *j, *k; /* pointer into |byte_mem| */
  char *x[256] = {""};
  /* this mapping table mirrors encTeX definitions */
  x[0x80] = "А";
  x[0xa0] = "а";
  x[0x81] = "Б";
  x[0xa1] = "б";
  x[0x82] = "В";
  x[0xa2] = "в";
  x[0x83] = "Г";
  x[0xa3] = "г";
  x[0x84] = "Д";
  x[0xa4] = "д";
  x[0x85] = "Е";
  x[0xa5] = "е";
  x[0xf0] = "Ё";
  x[0xf1] = "ё";
  x[0x86] = "Ж";
  x[0xa6] = "ж";
  x[0x87] = "З";
  x[0xa7] = "з";
  x[0x88] = "И";
  x[0xa8] = "и";
  x[0x89] = "Й";
  x[0xa9] = "й";
  x[0x8a] = "К";
  x[0xaa] = "к";
  x[0x8b] = "Л";
  x[0xab] = "л";
  x[0x8c] = "М";
  x[0xac] = "м";
  x[0x8d] = "Н";
  x[0xad] = "н";
  x[0x8e] = "О";
  x[0xae] = "о";
  x[0x8f] = "П";
  x[0xaf] = "п";
  x[0x90] = "Р";
  x[0xe0] = "р";
  x[0x91] = "С";
  x[0xe1] = "с";
  x[0x92] = "Т";
  x[0xe2] = "т";
  x[0x93] = "У";
  x[0xe3] = "у";
  x[0x94] = "Ф";
  x[0xe4] = "ф";
  x[0x95] = "Х";
  x[0xe5] = "х";
  x[0x96] = "Ц";
  x[0xe6] = "ц";
  x[0x97] = "Ч";
  x[0xe7] = "ч";
  x[0x98] = "Ш";
  x[0xe8] = "ш";
  x[0x99] = "Щ";
  x[0xe9] = "щ";
  x[0x9a] = "Ъ";
  x[0xea] = "ъ";
  x[0x9b] = "Ы";
  x[0xeb] = "ы";
  x[0x9c] = "Ь";
  x[0xec] = "ь";
  x[0x9d] = "Э";
  x[0xed] = "э";
  x[0x9e] = "Ю";
  x[0xee] = "ю";
  x[0x9f] = "Я";
  x[0xef] = "я";
  x[0xfc] = "№";
@z

@x
    else C_printf("%s",translit[(unsigned char)(*j)-0200]);
@y
    else {
      int z;
      for(z = 0x80; z <= 0xff; z++)
        if (x[z] && (strncmp(j, x[z], strlen(x[z])) == 0))
          break;
      C_printf("%s",translit[(unsigned char)z-0200]);
      j+=strlen(x[z])-1;
    }
@z
