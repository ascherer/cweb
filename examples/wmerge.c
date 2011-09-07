#define buf_size 4096 \

#define max_include_depth 10 \

#define max_file_name_length 60
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define cur_line line[include_depth]
#define web_file file[0]
#define web_file_name file_name[0] \

#define lines_dont_match (change_limit-change_buffer!=limit-buffer|| \
strncmp(buffer,change_buffer,limit-buffer) )  \

#define too_long() {include_depth--; \
err_print("! Include file name too long") ;goto restart;} \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless) history= harmless_message;}
#define mark_error history= error_message \

#define fatal(s,t) { \
fprintf(stderr,s) ;err_print(t) ; \
history= fatal_message;exit(wrap_up() ) ; \
} \

#define show_banner flags['b']
#define show_happiness flags['h'] \

#define update_terminal fflush(stderr)  \

/*1:*/
#line 15 "wmerge.w"

#include <stdio.h> 
#include <stdlib.h>  
#include <ctype.h>  
/*2:*/
#line 37 "wmerge.w"

typedef short boolean;
typedef unsigned char eight_bits;
typedef char ASCII;

/*:2*//*5:*/
#line 70 "wmerge.w"

ASCII buffer[buf_size];
ASCII*buffer_end= buffer+buf_size-2;
ASCII*limit;
ASCII*loc;

/*:5*//*7:*/
#line 136 "wmerge.w"

int include_depth;
FILE*file[max_include_depth];
FILE*change_file;
char file_name[max_include_depth][max_file_name_length];

char change_file_name[max_file_name_length];
char alt_web_file_name[max_file_name_length];
int line[max_include_depth];
int change_line;
int change_depth;
boolean input_has_ended;
boolean changing;
boolean web_file_open= 0;

/*:7*//*8:*/
#line 162 "wmerge.w"

char change_buffer[buf_size];
char*change_limit;

/*:8*//*23:*/
#line 486 "wmerge.w"

int history= spotless;

/*:23*//*30:*/
#line 584 "wmerge.w"

int argc;
char**argv;
char out_file_name[max_file_name_length];
boolean flags[128];

/*:30*//*40:*/
#line 700 "wmerge.w"

FILE*out_file;

/*:40*/
#line 19 "wmerge.w"

/*3:*/
#line 47 "wmerge.w"

extern int strlen();
extern char*strcpy();
extern int strncmp();
extern char*strncpy();

/*:3*//*4:*/
#line 53 "wmerge.w"


/*:4*//*24:*/
#line 498 "wmerge.w"

void err_print();

/*:24*//*32:*/
#line 608 "wmerge.w"

void scan_args();

/*:32*/
#line 20 "wmerge.w"

/*6:*/
#line 95 "wmerge.w"

input_ln(fp)
FILE*fp;
{
register int c= EOF;
register char*k;
if(feof(fp))return(0);
limit= k= buffer;
while(k<=buffer_end&&(c= getc(fp))!=EOF&&c!='\n')
if((*(k++)= c)!=' ')limit= k;
if(k> buffer_end)
if((c= getc(fp))!=EOF&&c!='\n'){
ungetc(c,fp);loc= buffer;err_print("! Input line too long");

}
if(c==EOF&&limit==buffer)return(0);

return(1);
}

/*:6*//*9:*/
#line 173 "wmerge.w"

void
prime_the_change_buffer()
{
change_limit= change_buffer;
/*10:*/
#line 187 "wmerge.w"

while(1){
change_line++;
if(!input_ln(change_file))return;
if(limit<buffer+2)continue;
if(buffer[0]!='@')continue;
if(isupper(buffer[1]))buffer[1]= tolower(buffer[1]);
if(buffer[1]=='x')break;
if(buffer[1]=='y'||buffer[1]=='z'||buffer[1]=='i'){
loc= buffer+2;
err_print("! Missing @x in change file");

}
}

/*:10*/
#line 178 "wmerge.w"
;
/*11:*/
#line 204 "wmerge.w"

do{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended after @x");

return;
}
}while(limit==buffer);

/*:11*/
#line 179 "wmerge.w"
;
/*12:*/
#line 214 "wmerge.w"

{
change_limit= change_buffer+(limit-buffer);
strncpy(change_buffer,buffer,limit-buffer+1);
}

/*:12*/
#line 180 "wmerge.w"
;
}

/*:9*//*13:*/
#line 232 "wmerge.w"

void
check_change()
{
int n= 0;
if(lines_dont_match)return;
while(1){
changing= 1;change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended before @y");

change_limit= change_buffer;changing= 0;
return;
}
if(limit> buffer+1&&buffer[0]=='@'){
char xyz_code= isupper(buffer[1])?tolower(buffer[1]):buffer[1];
/*14:*/
#line 265 "wmerge.w"

if(xyz_code=='x'||xyz_code=='z'){
loc= buffer+2;err_print("! Where is the matching @y?");

}
else if(xyz_code=='y'){
if(n> 0){
loc= buffer+2;
fprintf(stderr,"\n! Hmm... %d ",n);
err_print("of the preceding lines failed to match");

}
change_depth= include_depth;
return;
}

/*:14*/
#line 249 "wmerge.w"
;
}
/*12:*/
#line 214 "wmerge.w"

{
change_limit= change_buffer+(limit-buffer);
strncpy(change_buffer,buffer,limit-buffer+1);
}

/*:12*/
#line 251 "wmerge.w"
;
changing= 0;cur_line++;
while(!input_ln(cur_file)){
if(include_depth==0){
err_print("! CWEB file ended during a change");

input_has_ended= 1;return;
}
include_depth--;cur_line++;
}
if(lines_dont_match)n++;
}
}

/*:13*//*15:*/
#line 284 "wmerge.w"

void
reset_input()
{
limit= buffer;loc= buffer+1;buffer[0]= ' ';
/*16:*/
#line 299 "wmerge.w"

if((web_file= fopen(web_file_name,"r"))==NULL){
strcpy(web_file_name,alt_web_file_name);
if((web_file= fopen(web_file_name,"r"))==NULL)
fatal("! Cannot open input file ",web_file_name);
}


web_file_open= 1;
if((change_file= fopen(change_file_name,"r"))==NULL)
fatal("! Cannot open change file ",change_file_name);

/*:16*/
#line 289 "wmerge.w"
;
include_depth= 0;cur_line= 0;change_line= 0;
change_depth= include_depth;
changing= 1;prime_the_change_buffer();changing= !changing;
limit= buffer;loc= buffer+1;buffer[0]= ' ';input_has_ended= 0;
}

/*:15*//*17:*/
#line 317 "wmerge.w"

int get_line()
{
restart:
if(changing&&include_depth==change_depth)
/*21:*/
#line 431 "wmerge.w"
{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended without @z");

buffer[0]= '@';buffer[1]= 'z';limit= buffer+2;
}
if(limit> buffer){
*limit= ' ';
if(buffer[0]=='@'){
if(isupper(buffer[1]))buffer[1]= tolower(buffer[1]);
if(buffer[1]=='x'||buffer[1]=='y'){
loc= buffer+2;
err_print("! Where is the matching @z?");

}
else if(buffer[1]=='z'){
prime_the_change_buffer();changing= !changing;
}
}
}
}

/*:21*/
#line 322 "wmerge.w"
;
if(!changing||include_depth> change_depth){
/*20:*/
#line 415 "wmerge.w"
{
cur_line++;
while(!input_ln(cur_file)){
if(include_depth==0){input_has_ended= 1;break;}
else{
fclose(cur_file);include_depth--;
if(changing&&include_depth==change_depth)break;
cur_line++;
}
}
if(!changing&&!input_has_ended)
if(limit-buffer==change_limit-change_buffer)
if(buffer[0]==change_buffer[0])
if(change_limit> change_buffer)check_change();
}

/*:20*/
#line 324 "wmerge.w"
;
if(changing&&include_depth==change_depth)goto restart;
}
if(input_has_ended)return 0;
loc= buffer;*limit= ' ';
if(buffer[0]=='@'&&(buffer[1]=='i'||buffer[1]=='I')){
loc= buffer+2;*limit= '"';
while(*loc==' '||*loc=='\t')loc++;
if(loc>=limit){
err_print("! Include file name not given");

goto restart;
}
if(include_depth>=max_include_depth-1){
err_print("! Too many nested includes");

goto restart;
}
include_depth++;
/*19:*/
#line 369 "wmerge.w"
{
char temp_file_name[max_file_name_length];
char*cur_file_name_end= cur_file_name+max_file_name_length-1;
char*k= cur_file_name,*kk;
int l;

if(*loc=='"'){
loc++;
while(*loc!='"'&&k<=cur_file_name_end)*k++= *loc++;
if(loc==limit)k= cur_file_name_end+1;
}else
while(*loc!=' '&&*loc!='\t'&&*loc!='"'&&k<=cur_file_name_end)*k++= *loc++;
if(k> cur_file_name_end)too_long();

*k= '\0';
if((cur_file= fopen(cur_file_name,"r"))!=NULL){
cur_line= 0;
goto restart;
}
kk= getenv("CWEBINPUTS");
if(kk!=NULL){
if((l= strlen(kk))> max_file_name_length-2)too_long();
strcpy(temp_file_name,kk);
}
else{
#ifdef CWEBINPUTS
if((l= strlen(CWEBINPUTS))> max_file_name_length-2)too_long();
strcpy(temp_file_name,CWEBINPUTS);
#else
l= 0;
#endif 
}
if(l> 0){
if(k+l+2>=cur_file_name_end)too_long();

for(;k>=cur_file_name;k--)*(k+l+1)= *k;
strcpy(cur_file_name,temp_file_name);
cur_file_name[l]= '/';
if((cur_file= fopen(cur_file_name,"r"))!=NULL){
cur_line= 0;
goto restart;
}
}
include_depth--;err_print("! Cannot open include file");goto restart;
}

/*:19*/
#line 343 "wmerge.w"
;
}
return 1;
}

void put_line()
{
char*ptr= buffer;
while(ptr<limit)putc(*ptr++,out_file);
putc('\n',out_file);
}

/*:17*//*22:*/
#line 457 "wmerge.w"

void
check_complete(){
if(change_limit!=change_buffer){
strncpy(buffer,change_buffer,change_limit-change_buffer+1);
limit= buffer+(int)(change_limit-change_buffer);
changing= 1;change_depth= include_depth;loc= buffer;
err_print("! Change file entry did not match");

}
}

/*:22*//*25:*/
#line 502 "wmerge.w"

void
err_print(s)
char*s;
{
char*k,*l;
fprintf(stderr,*s=='!'?"\n%s":"%s",s);
if(web_file_open)/*26:*/
#line 523 "wmerge.w"

{if(changing&&include_depth==change_depth)
fprintf(stderr,". (l. %d of change file)\n",change_line);
else if(include_depth==0)fprintf(stderr,". (l. %d)\n",cur_line);
else fprintf(stderr,". (l. %d of include file %s)\n",cur_line,cur_file_name);
l= (loc>=limit?limit:loc);
if(l> buffer){
for(k= buffer;k<l;k++)
if(*k=='\t')putc(' ',stderr);
else putc(*k,stderr);
putc('\n',stderr);
for(k= buffer;k<l;k++)putc(' ',stderr);
}
for(k= l;k<limit;k++)putc(*k,stderr);
putc('\n',stderr);
}

/*:26*/
#line 509 "wmerge.w"

else putc('\n',stderr);
update_terminal;mark_error;
}

/*:25*//*28:*/
#line 555 "wmerge.w"

wrap_up(){
/*29:*/
#line 562 "wmerge.w"

switch(history){
case spotless:if(show_happiness)fprintf(stderr,"(No errors were found.)\n");break;
case harmless_message:
fprintf(stderr,"(Did you see the warning message above?)\n");break;
case error_message:
fprintf(stderr,"(Pardon me, but I think I spotted something wrong.)\n");break;
case fatal_message:fprintf(stderr,"(That was a fatal error, my friend.)\n");
}

/*:29*/
#line 557 "wmerge.w"
;
if(history> harmless_message)return(1);
else return(0);
}

/*:28*//*33:*/
#line 612 "wmerge.w"

void
scan_args()
{
char*dot_pos;
register char*s;
boolean found_web= 0,found_change= 0,found_out= 0;

boolean flag_change;

while(--argc> 0){
if(**(++argv)=='-'||**argv=='+')/*37:*/
#line 682 "wmerge.w"

{
if(**argv=='-')flag_change= 0;
else flag_change= 1;
for(dot_pos= *argv+1;*dot_pos> '\0';dot_pos++)
flags[*dot_pos]= flag_change;
}

/*:37*/
#line 623 "wmerge.w"

else{
s= *argv;dot_pos= NULL;
while(*s){
if(*s=='.')dot_pos= s++;
else if(*s=='/')dot_pos= NULL,++s;
else s++;
}
if(!found_web)/*34:*/
#line 648 "wmerge.w"

{
if(s-*argv> max_file_name_length-5)
/*39:*/
#line 695 "wmerge.w"
fatal("! Filename too long\n",*argv);

/*:39*/
#line 651 "wmerge.w"
;
if(dot_pos==NULL)
sprintf(web_file_name,"%s.w",*argv);
else{
strcpy(web_file_name,*argv);
*dot_pos= 0;
}
sprintf(alt_web_file_name,"%s.web",*argv);
*out_file_name= '\0';
found_web= 1;
}

/*:34*/
#line 631 "wmerge.w"

else if(!found_change)/*35:*/
#line 663 "wmerge.w"

{
if(s-*argv> max_file_name_length-4)
/*39:*/
#line 695 "wmerge.w"
fatal("! Filename too long\n",*argv);

/*:39*/
#line 666 "wmerge.w"
;
if(dot_pos==NULL)
sprintf(change_file_name,"%s.ch",*argv);
else strcpy(change_file_name,*argv);
found_change= 1;
}

/*:35*/
#line 632 "wmerge.w"

else if(!found_out)/*36:*/
#line 673 "wmerge.w"

{
if(s-*argv> max_file_name_length-5)
/*39:*/
#line 695 "wmerge.w"
fatal("! Filename too long\n",*argv);

/*:39*/
#line 676 "wmerge.w"
;
if(dot_pos==NULL)sprintf(out_file_name,"%s.out",*argv);
else strcpy(out_file_name,*argv);
found_out= 1;
}

/*:36*/
#line 633 "wmerge.w"

else/*38:*/
#line 690 "wmerge.w"

{
fatal("! Usage: wmerge webfile[.w] [changefile[.ch] [outfile[.out]]]\n","")
}

/*:38*/
#line 634 "wmerge.w"
;
}
}
if(!found_web)/*38:*/
#line 690 "wmerge.w"

{
fatal("! Usage: wmerge webfile[.w] [changefile[.ch] [outfile[.out]]]\n","")
}

/*:38*/
#line 637 "wmerge.w"
;
if(!found_change)strcpy(change_file_name,"/dev/null");
}

/*:33*/
#line 21 "wmerge.w"

main(ac,av)
int ac;char**av;
{
argc= ac;argv= av;
/*31:*/
#line 592 "wmerge.w"

show_banner= show_happiness= 1;

/*:31*/
#line 26 "wmerge.w"
;
/*41:*/
#line 703 "wmerge.w"

scan_args();
if(out_file_name[0]=='\0')out_file= stdout;
else if((out_file= fopen(out_file_name,"w"))==NULL)
fatal("! Cannot open output file ",out_file_name);


/*:41*/
#line 27 "wmerge.w"
;
reset_input();
while(get_line())
put_line();
fflush(out_file);
check_complete();
fflush(out_file);
return wrap_up();
}

/*:1*/
