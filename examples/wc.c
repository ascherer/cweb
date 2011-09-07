#define OK 0
#define usage_error 1
#define cannot_open_file 2 \

#define READ_ONLY 0 \

#define buf_size BUFSIZ \

#define print_count(n) printf("%8ld",n)  \

/*2:*/
#line 33 "wc.w"

/*3:*/
#line 42 "wc.w"

#include <stdio.h> 

/*:3*/
#line 34 "wc.w"

/*4:*/
#line 53 "wc.w"

int status= OK;
char*prog_name;

/*:4*//*14:*/
#line 162 "wc.w"

long tot_word_count,tot_line_count,tot_char_count;


/*:14*/
#line 35 "wc.w"

/*20:*/
#line 227 "wc.w"

wc_print(which,char_count,word_count,line_count)
char*which;
long char_count,word_count,line_count;
{
while(*which)
switch(*which++){
case'l':print_count(line_count);break;
case'w':print_count(word_count);break;
case'c':print_count(char_count);break;
default:if((status&usage_error)==0){
fprintf(stderr,"\nUsage: %s [-lwc] [filename ...]\n",prog_name);

status|= usage_error;
}
}
}

/*:20*/
#line 36 "wc.w"

/*5:*/
#line 59 "wc.w"

main(argc,argv)
int argc;
char**argv;
{
/*6:*/
#line 85 "wc.w"

int file_count;
char*which;
int silent= 0;

/*:6*//*9:*/
#line 121 "wc.w"

int fd= 0;

/*:9*//*12:*/
#line 144 "wc.w"

char buffer[buf_size];
register char*ptr;
register char*buf_end;
register int c;
int in_word;
long word_count,line_count,char_count;


/*:12*/
#line 64 "wc.w"

prog_name= argv[0];
/*7:*/
#line 90 "wc.w"

which= "lwc";
if(argc> 1&&*argv[1]=='-'){
argv[1]++;
if(*argv[1]=='s')silent= 1,argv[1]++;
if(*argv[1])which= argv[1];
argc--;argv++;
}
file_count= argc-1;

/*:7*/
#line 66 "wc.w"
;
/*8:*/
#line 105 "wc.w"

argc--;
do{
/*10:*/
#line 126 "wc.w"

if(file_count> 0&&(fd= open(*(++argv),READ_ONLY))<0){
fprintf(stderr,"%s: cannot open file %s\n",prog_name,*argv);

status|= cannot_open_file;
file_count--;
continue;
}

/*:10*/
#line 108 "wc.w"
;
/*13:*/
#line 153 "wc.w"

ptr= buf_end= buffer;line_count= word_count= char_count= 0;in_word= 0;

/*:13*/
#line 109 "wc.w"
;
/*15:*/
#line 170 "wc.w"

while(1){
/*16:*/
#line 185 "wc.w"

if(ptr>=buf_end){
ptr= buffer;c= read(fd,ptr,buf_size);
if(c<=0)break;
char_count+= c;buf_end= buffer+c;
}

/*:16*/
#line 172 "wc.w"
;
c= *ptr++;
if(c> ' '&&c<0177){
if(!in_word){word_count++;in_word= 1;}
continue;
}
if(c=='\n')line_count++;
else if(c!=' '&&c!='\t')continue;
in_word= 0;
}

/*:15*/
#line 110 "wc.w"
;
/*17:*/
#line 197 "wc.w"

if(!silent){
wc_print(which,char_count,word_count,line_count);
if(file_count)printf(" %s\n",*argv);
else printf("\n");
}

/*:17*/
#line 111 "wc.w"
;
/*11:*/
#line 135 "wc.w"

close(fd);

/*:11*/
#line 112 "wc.w"
;
/*18:*/
#line 204 "wc.w"

tot_line_count+= line_count;
tot_word_count+= word_count;
tot_char_count+= char_count;

/*:18*/
#line 113 "wc.w"
;
}while(--argc> 0);

/*:8*/
#line 67 "wc.w"
;
/*19:*/
#line 212 "wc.w"

if(file_count> 1||silent){
wc_print(which,tot_char_count,tot_word_count,tot_line_count);
if(!file_count)printf("\n");
else printf(" total in %d file%s\n",file_count,file_count> 1?"s":"");
}

/*:19*/
#line 68 "wc.w"
;
exit(status);
}

/*:5*/
#line 37 "wc.w"


/*:2*/
