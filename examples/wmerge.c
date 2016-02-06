#define buf_size 100 \

#define max_include_depth 10 \

#define max_file_name_length 60
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define cur_line line[include_depth]
#define web_file file[0]
#define web_file_name file_name[0] \

#define lines_dont_match (change_limit-change_buffer!=limit-buffer|| \
strncmp(buffer,change_buffer,limit-buffer)) \

#define max_modules 2000 \
 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless)history= harmless_message;}
#define mark_error history= error_message \

#define fatal(s1,s2){ \
fprintf(stderr,s1);err_print(s2); \
history= fatal_message;wrap_up(); \
} \

#define confusion(s)fatal("! This can't happen: ",s) \
 \

#define overflow(s){ \
fprintf(stderr,"! Sorry, capacity exceeded: ");fatal("",s); \
} \
 \

#define update_terminal fflush(stdout) \

/*1:*/
#line 12 "wmerge.w"

#include <stdio.h>
/*2:*/
#line 26 "wmerge.w"

typedef short boolean;
typedef char unsigned eight_bits;
typedef char ASCII;

/*:2*//*3:*/
#line 49 "wmerge.w"

ASCII buffer[buf_size];
ASCII*buffer_end= buffer+buf_size-2;
ASCII*limit;
ASCII*loc;

/*:3*//*5:*/
#line 117 "wmerge.w"

int include_depth;
FILE*file[max_include_depth];
FILE*change_file;
char file_name[max_include_depth][max_file_name_length];

char change_file_name[max_file_name_length];
int line[max_include_depth];
int change_line;
boolean input_has_ended;
boolean changing;

/*:5*//*6:*/
#line 140 "wmerge.w"

ASCII change_buffer[buf_size];
ASCII*change_limit;

/*:6*//*17:*/
#line 305 "wmerge.w"

typedef unsigned short sixteen_bits;
sixteen_bits module_count;
boolean changed_module[max_modules];
boolean print_where= 0;

/*:17*//*23:*/
#line 438 "wmerge.w"

int history= spotless;

/*:23*/
#line 14 "wmerge.w"

/*4:*/
#line 74 "wmerge.w"

#include <stdio.h>
input_ln(fp)
FILE*fp;
{
register int c;
register ASCII*k;
if(feof(fp))return(0);
limit= k= buffer;
while(k<=buffer_end&&(c= getc(fp))!=EOF&&c!='\n')
if((*(k++)= c)!=32)limit= k;
if(k>buffer_end)
if((c= getc(fp))!=EOF&&c!='\n'){
ungetc(c,fp);loc= buffer;err_print("\n! Input line too long");

}
if(c==EOF&&limit==buffer)return(0);

return(1);
}

/*:4*//*7:*/
#line 150 "wmerge.w"

prime_the_change_buffer()
{
change_limit= change_buffer;
/*8:*/
#line 164 "wmerge.w"

while(1){
change_line++;
if(!input_ln(change_file))return;
if(limit<buffer+2)continue;
if(buffer[0]!=64)continue;
/*9:*/
#line 182 "wmerge.w"

if(buffer[1]>=88&&buffer[1]<=90||buffer[1]==73)buffer[1]+= 122-90;

/*:9*/
#line 170 "wmerge.w"
;
/*10:*/
#line 187 "wmerge.w"
{
if(buffer[1]==105){
loc= buffer+2;
err_print("! No includes allowed in change file");

}
}

/*:10*/
#line 171 "wmerge.w"
;
if(buffer[1]==120)break;
if(buffer[1]==121||buffer[1]==122){
loc= buffer+2;
err_print("! Where is the matching @x?");

}
}

/*:8*/
#line 154 "wmerge.w"
;
/*11:*/
#line 197 "wmerge.w"

do{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended after @x");

return;
}
}while(limit==buffer);

/*:11*/
#line 155 "wmerge.w"
;
/*12:*/
#line 207 "wmerge.w"

{
change_limit= change_buffer-buffer+limit;
strncpy(change_buffer,buffer,limit-buffer+1);
}

/*:12*/
#line 156 "wmerge.w"
;
}

/*:7*//*13:*/
#line 222 "wmerge.w"

check_change()
{
int n= 0;
if(lines_dont_match)return;
while(1){
changing= 1;print_where= 1;change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended before @y");

change_limit= change_buffer;changing= 0;print_where= 1;
return;
}
if(limit>buffer+1&&buffer[0]==64)
/*10:*/
#line 187 "wmerge.w"
{
if(buffer[1]==105){
loc= buffer+2;
err_print("! No includes allowed in change file");

}
}

/*:10*/
#line 236 "wmerge.w"
;
/*14:*/
#line 253 "wmerge.w"

if(limit>buffer+1&&buffer[0]==64){
/*9:*/
#line 182 "wmerge.w"

if(buffer[1]>=88&&buffer[1]<=90||buffer[1]==73)buffer[1]+= 122-90;

/*:9*/
#line 255 "wmerge.w"
;
if(buffer[1]==120||buffer[1]==122){
loc= buffer+2;err_print("! Where is the matching @y?");

}
else if(buffer[1]==121){
if(n>0){
loc= buffer+2;
err_print("! Hmm... some of the preceding lines failed to match");

}
return;
}
}

/*:14*/
#line 238 "wmerge.w"
;
/*12:*/
#line 207 "wmerge.w"

{
change_limit= change_buffer-buffer+limit;
strncpy(change_buffer,buffer,limit-buffer+1);
}

/*:12*/
#line 239 "wmerge.w"
;
changing= 0;print_where= 1;cur_line++;
while(!input_ln(cur_file)){
if(include_depth==0){
err_print("! WEB file ended during a change");

input_has_ended= 1;return;
}
include_depth--;print_where= 1;cur_line++;
}
if(lines_dont_match)n++;
}
}

/*:13*//*15:*/
#line 273 "wmerge.w"

reset_input()
{
limit= buffer;loc= buffer+1;buffer[0]= 32;
/*16:*/
#line 286 "wmerge.w"

if((web_file= fopen(web_file_name,"r"))==NULL)
fatal("! Cannot open input file",web_file_name);
if((change_file= fopen(change_file_name,"r"))==NULL)
fatal("! Cannot open change file",change_file_name);

/*:16*/
#line 277 "wmerge.w"
;
cur_line= 0;change_line= 0;include_depth= 0;
changing= 1;prime_the_change_buffer();changing= !changing;
limit= buffer;loc= buffer+1;buffer[0]= 32;input_has_ended= 0;
}

/*:15*//*18:*/
#line 311 "wmerge.w"

get_line()
{
restart:
if(changing)changed_module[module_count]= 1;
else/*20:*/
#line 373 "wmerge.w"
{
cur_line++;
while(!input_ln(cur_file)){
print_where= 1;
if(include_depth==0){input_has_ended= 1;break;}
else{include_depth--;cur_line++;}
}
if(!input_has_ended)
if(limit==change_limit-change_buffer+buffer)
if(buffer[0]==change_buffer[0])
if(change_limit>change_buffer)check_change();
}

/*:20*/
#line 316 "wmerge.w"
;
if(changing){
/*21:*/
#line 386 "wmerge.w"
{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended without @z");

buffer[0]= 64;buffer[1]= 122;limit= buffer+2;
}
if(limit>buffer+1)
if(buffer[0]==64){
/*9:*/
#line 182 "wmerge.w"

if(buffer[1]>=88&&buffer[1]<=90||buffer[1]==73)buffer[1]+= 122-90;

/*:9*/
#line 395 "wmerge.w"
;
/*10:*/
#line 187 "wmerge.w"
{
if(buffer[1]==105){
loc= buffer+2;
err_print("! No includes allowed in change file");

}
}

/*:10*/
#line 396 "wmerge.w"
;
if(buffer[1]==120||buffer[1]==121){
loc= buffer+2;err_print("! Where is the matching @z?");

}
else if(buffer[1]==122){
prime_the_change_buffer();changing= !changing;print_where= 1;
}
}
}

/*:21*/
#line 318 "wmerge.w"
;
if(!changing){
changed_module[module_count]= 1;goto restart;
}
}
loc= buffer;*limit= 32;
if(*buffer==64&&(*(buffer+1)==105||*(buffer+1)==73))
/*19:*/
#line 345 "wmerge.w"
{
ASCII*k,*j;
loc= buffer+2;
while(loc<=limit&&(*loc==32||*loc==9||*loc==34))loc++;
if(loc>=limit)err_print("! Include file name not given");

else{
if(++include_depth<max_include_depth){
k= cur_file_name;j= loc;
while(*loc!=32&&*loc!=9&&*loc!=34)*k++= *loc++;
*k= '\0';
if((cur_file= fopen(cur_file_name,"r"))==NULL){
loc= j;
include_depth--;
err_print("! Cannot open include file");

}
else{cur_line= 0;print_where= 1;}
}
else{
include_depth--;
err_print("! Too many nested includes");

}
}
goto restart;
}

/*:19*/
#line 325 "wmerge.w"
;
return(!input_has_ended);
}

put_line()
{
char*ptr= buffer;
while(ptr<limit)putchar(*ptr++);
putchar('\n');
}

/*:18*//*22:*/
#line 410 "wmerge.w"

check_complete(){
if(change_limit!=change_buffer){
strncpy(buffer,change_buffer,change_limit-change_buffer+1);
limit= change_limit-change_buffer+buffer;
changing= 1;loc= change_limit;
err_print("! Change file entry did not match");

}
}

/*:22*//*24:*/
#line 452 "wmerge.w"

err_print(s)
char*s;
{
ASCII*k,*l;
fprintf(stderr,"\n%s",s);
/*25:*/
#line 471 "wmerge.w"

if(changing)fprintf(stderr,". (l. %d of change file)\n",change_line);
else if(include_depth==0)fprintf(stderr,". (l. %d)\n",cur_line);
else fprintf(stderr,". (l. %d of include file %s)\n",cur_line,cur_file_name);
l= (loc>=limit?limit:loc);
if(l>buffer){
for(k= buffer;k<l;k++)
if(*k=='\t')putc(' ',stderr);
else putc(*k,stderr);
putc('\n',stderr);
for(k= buffer;k<l;k++)putc(' ',stderr);
}
for(k= l;k<limit;k++)putc(*k,stderr);
if(*limit==124)putc('|',stderr);
putc(' ',stderr);

/*:25*/
#line 458 "wmerge.w"
;
fflush(stdout);mark_error;
}

/*:24*//*29:*/
#line 517 "wmerge.w"

wrap_up(){
putc('\n',stderr);
/*30:*/
#line 525 "wmerge.w"

switch(history){
case spotless:fprintf(stderr,"(No errors were found.)\n");break;
case harmless_message:
fprintf(stderr,"(Did you see the warning message above?)\n");break;
case error_message:
fprintf(stderr,"(Pardon me, but I think I spotted something wrong.)\n");
break;
case fatal_message:fprintf(stderr,"(That was a fatal error, my friend.)\n");
}

/*:30*/
#line 520 "wmerge.w"
;
if(history>harmless_message)exit(1);
else exit(0);
}

/*:29*//*31:*/
#line 549 "wmerge.w"

scan_args(argc,argv)
char**argv;
{
char*dot_pos,*index();
boolean found_web= 0,found_change= 0;
while(--argc>0){
++argv;
if(!found_web)/*32:*/
#line 570 "wmerge.w"

{
if(strlen(*argv)>max_file_name_length-5)
/*36:*/
#line 600 "wmerge.w"
fatal("! Filename %s too long\n",*argv);

/*:36*/
#line 573 "wmerge.w"
;
if((dot_pos= index(*argv,'.'))==NULL)
sprintf(web_file_name,"%s.w",*argv);
else{
sprintf(web_file_name,"%s",*argv);
*dot_pos= 0;
}
found_web= 1;
}

/*:32*/
#line 557 "wmerge.w"

else if(!found_change)/*33:*/
#line 583 "wmerge.w"

{
if(strlen(*argv)>max_file_name_length-5)
/*36:*/
#line 600 "wmerge.w"
fatal("! Filename %s too long\n",*argv);

/*:36*/
#line 586 "wmerge.w"
;
if((dot_pos= index(*argv,'.'))==NULL)
sprintf(change_file_name,"%s.ch",*argv);
else sprintf(change_file_name,"%s",*argv);
found_change= 1;
}

/*:33*/
#line 558 "wmerge.w"

else/*35:*/
#line 595 "wmerge.w"

{
fatal("! Usage: wmerge webfile[.w] [changefile[.ch]]\n","")
}

/*:35*/
#line 559 "wmerge.w"
;
}
if(!found_web)/*35:*/
#line 595 "wmerge.w"

{
fatal("! Usage: wmerge webfile[.w] [changefile[.ch]]\n","")
}

/*:35*/
#line 561 "wmerge.w"
;
if(!found_change)/*34:*/
#line 593 "wmerge.w"
strcpy(change_file_name,"/dev/null");

/*:34*/
#line 562 "wmerge.w"
;
}

/*:31*/
#line 15 "wmerge.w"
;
main(argc,argv)
char**argv;
{
scan_args(argc,argv);
reset_input();
while(get_line())
put_line();
wrap_up();
}

/*:1*/
