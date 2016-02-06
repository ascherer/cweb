#define tangle 0
#define weave 1 \

#define and_and 04
#define lt_lt 020
#define gt_gt 021
#define plus_plus 013
#define minus_minus 01
#define minus_gt 031
#define not_eq 032
#define lt_eq 034
#define gt_eq 035
#define eq_eq 036
#define or_or 037 \

#define buf_size 100
#define long_buf_size 500 \

#define max_include_depth 10 \

#define max_file_name_length 60
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define cur_line line[include_depth]
#define web_file file[0]
#define web_file_name file_name[0] \

#define lines_dont_match (change_limit-change_buffer!=limit-buffer|| \
strncmp(buffer,change_buffer,limit-buffer)) \

#define if_module_start_make_pending(b){*limit= '!'; \
for(loc= buffer;isspace(*loc);loc++); \
*limit= ' '; \
if(*loc=='@'&&(isspace(*(loc+1))||*(loc+1)=='*'))change_pending= b; \
} \

#define max_modules 2000 \
 \

#define max_bytes 90000 \

#define max_names 4000 \
 \

#define length(c)(c+1)->byte_start-(c)->byte_start
#define print_id(c)term_write((c)->byte_start,length((c))) \
 \

#define hash_size 353 \

#define llink link
#define rlink dummy.Rlink
#define root name_dir->rlink \
 \

#define less 0
#define equal 1
#define greater 2
#define prefix 3
#define extension 4 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless)history= harmless_message;}
#define mark_error history= error_message \

#define fatal(s,t){ \
printf(s);err_print(t); \
history= fatal_message;wrap_up(); \
} \

#define confusion(s)fatal("! This can't happen: ",s) \
 \

#define overflow(t){ \
printf("\n! Sorry, %s capacity exceeded",t);fatal("",""); \
} \
 \

#define show_banner flags['b']
#define show_progress flags['p']
#define show_stats flags['s']
#define show_happiness flags['h'] \

#define update_terminal fflush(stdout) \

#define new_line putchar('\n')
#define putxchar putchar
#define term_write(a,b)fflush(stdout),write(1,a,b)
#define line_write(c)write(fileno(C_file),c)
#define C_printf(c,a)fprintf(C_file,c,a)
#define C_putc(c)putc(c,C_file) \

/*1:*/
#line 56 "common.w"

/*5:*/
#line 98 "common.w"

#include <ctype.h>

/*:5*//*8:*/
#line 154 "common.w"

#include <stdio.h>

/*:8*/
#line 57 "common.w"

/*2:*/
#line 70 "common.w"

typedef short boolean;
boolean program;

/*:2*//*7:*/
#line 148 "common.w"

char buffer[long_buf_size];
char*buffer_end= buffer+buf_size-2;
char*limit= buffer;
char*loc= buffer;

/*:7*//*10:*/
#line 203 "common.w"

int include_depth;
FILE*file[max_include_depth];
FILE*change_file;
char file_name[max_include_depth][max_file_name_length];

char change_file_name[max_file_name_length];
char alt_web_file_name[max_file_name_length];
int line[max_include_depth];
int change_line;
boolean input_has_ended;
boolean changing;
boolean web_file_open= 0;

/*:10*//*21:*/
#line 412 "common.w"

typedef unsigned short sixteen_bits;
sixteen_bits module_count;
boolean changed_module[max_modules];
boolean change_pending;

boolean print_where= 0;

/*:21*//*27:*/
#line 553 "common.w"

typedef struct name_info{
char*byte_start;
/*31:*/
#line 591 "common.w"

struct name_info*link;

/*:31*//*38:*/
#line 681 "common.w"

union{
struct name_info*Rlink;

sixteen_bits Ilk;
}dummy;

/*:38*//*45:*/
#line 821 "common.w"

char*equiv_or_xref;

/*:45*/
#line 556 "common.w"

}name_info;
typedef name_info*name_pointer;
char byte_mem[max_bytes];
char*byte_mem_end= byte_mem+max_bytes-1;
name_info name_dir[max_names];
name_pointer name_dir_end= name_dir+max_names-1;

/*:27*//*29:*/
#line 577 "common.w"

name_pointer name_ptr;
char*byte_ptr;

/*:29*//*32:*/
#line 604 "common.w"

typedef name_pointer*hash_pointer;
name_pointer hash[hash_size];
hash_pointer hash_end= hash+hash_size-1;
hash_pointer h;

/*:32*//*46:*/
#line 841 "common.w"

int history= spotless;

/*:46*//*54:*/
#line 952 "common.w"

int argc;
char**argv;
char C_file_name[max_file_name_length];
char tex_file_name[max_file_name_length];
boolean flags[128];

/*:54*//*63:*/
#line 1082 "common.w"

FILE*C_file;
FILE*tex_file;

/*:63*/
#line 58 "common.w"

/*3:*/
#line 80 "common.w"
int phase;

/*:3*//*11:*/
#line 228 "common.w"

char change_buffer[buf_size];
char*change_limit;

/*:11*//*40:*/
#line 707 "common.w"

name_pointer install_node();

/*:40*/
#line 59 "common.w"

/*4:*/
#line 86 "common.w"

common_init()
{
/*30:*/
#line 581 "common.w"

name_dir->byte_start= byte_ptr= byte_mem;
name_ptr= name_dir+1;
name_ptr->byte_start= byte_mem;

/*:30*//*33:*/
#line 612 "common.w"

for(h= hash;h<=hash_end;*h++= NULL);

/*:33*//*39:*/
#line 688 "common.w"

root= NULL;

/*:39*/
#line 89 "common.w"
;
/*55:*/
#line 963 "common.w"

show_banner= show_happiness= show_progress= 1;

/*:55*/
#line 90 "common.w"
;
/*64:*/
#line 1086 "common.w"

scan_args();
if(program==tangle){
if((C_file= fopen(C_file_name,"w"))==NULL)
fatal("! Cannot open output file ",C_file_name);

}
else{
if((tex_file= fopen(tex_file_name,"w"))==NULL)
fatal("! Cannot open output file ",tex_file_name);
}

/*:64*/
#line 91 "common.w"
;
}

/*:4*//*9:*/
#line 161 "common.w"

input_ln(fp)
FILE*fp;
{
register int c;
register char*k;
if(feof(fp))return(0);
limit= k= buffer;
while(k<=buffer_end&&(c= getc(fp))!=EOF&&c!='\n')
if((*(k++)= c)!=' ')limit= k;
if(k>buffer_end)
if((c= getc(fp))!=EOF&&c!='\n'){
ungetc(c,fp);loc= buffer;err_print("! Input line too long");

}
if(c==EOF&&limit==buffer)return(0);

return(1);
}

/*:9*//*12:*/
#line 238 "common.w"

prime_the_change_buffer()
{
change_limit= change_buffer;
/*13:*/
#line 252 "common.w"

while(1){
change_line++;
if(!input_ln(change_file))return;
if(limit<buffer+2)continue;
if(buffer[0]!='@')continue;
if(isupper(buffer[1]))buffer[1]= tolower(buffer[1]);
/*14:*/
#line 270 "common.w"
{
if(buffer[1]=='i'){
loc= buffer+2;
err_print("! No includes allowed in change file");

}
}

/*:14*/
#line 259 "common.w"
;
if(buffer[1]=='x')break;
if(buffer[1]=='y'||buffer[1]=='z'){
loc= buffer+2;
err_print("! Where is the matching @x?");

}
}

/*:13*/
#line 242 "common.w"
;
/*15:*/
#line 280 "common.w"

do{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended after @x");

return;
}
}while(limit==buffer);

/*:15*/
#line 243 "common.w"
;
/*16:*/
#line 290 "common.w"

{
change_limit= change_buffer-buffer+limit;
strncpy(change_buffer,buffer,limit-buffer+1);
}

/*:16*/
#line 244 "common.w"
;
}

/*:12*//*17:*/
#line 318 "common.w"

check_change()
{
int n= 0;
if(lines_dont_match)return;
change_pending= 0;
if(!changed_module[module_count]){
if_module_start_make_pending(1);
if(!change_pending)changed_module[module_count]= 1;
}
while(1){
changing= 1;print_where= 1;change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended before @y");

change_limit= change_buffer;changing= 0;
return;
}
if(limit>buffer+1&&buffer[0]=='@'){
if(isupper(buffer[1]))buffer[1]= tolower(buffer[1]);
/*18:*/
#line 355 "common.w"

if(buffer[1]=='x'||buffer[1]=='z'){
loc= buffer+2;err_print("! Where is the matching @y?");

}
else if(buffer[1]=='y'){
if(n>0){
loc= buffer+2;
printf("\n! Hmm... %d ",n);
err_print("of the preceding lines failed to match");

}
return;
}

/*:18*/
#line 339 "common.w"
;
}
/*16:*/
#line 290 "common.w"

{
change_limit= change_buffer-buffer+limit;
strncpy(change_buffer,buffer,limit-buffer+1);
}

/*:16*/
#line 341 "common.w"
;
changing= 0;cur_line++;
while(!input_ln(cur_file)){
if(include_depth==0){
err_print("! WEB file ended during a change");

input_has_ended= 1;return;
}
include_depth--;cur_line++;
}
if(lines_dont_match)n++;
}
}

/*:17*//*19:*/
#line 374 "common.w"

reset_input()
{
limit= buffer;loc= buffer+1;buffer[0]= ' ';
/*20:*/
#line 387 "common.w"

if((web_file= fopen(web_file_name,"r"))==NULL){
strcpy(web_file_name,alt_web_file_name);
if((web_file= fopen(web_file_name,"r"))==NULL)
fatal("! Cannot open input file ",web_file_name);
}


web_file_open= 1;
if((change_file= fopen(change_file_name,"r"))==NULL)
fatal("! Cannot open change file ",change_file_name);

/*:20*/
#line 378 "common.w"
;
include_depth= 0;cur_line= 0;change_line= 0;
changing= 1;prime_the_change_buffer();changing= !changing;
limit= buffer;loc= buffer+1;buffer[0]= ' ';input_has_ended= 0;
}

/*:19*//*22:*/
#line 420 "common.w"

get_line()
{
restart:
if(changing)/*25:*/
#line 497 "common.w"
{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended without @z");

buffer[0]= '@';buffer[1]= 'z';limit= buffer+2;
}
if(limit>buffer){
if(change_pending){
if_module_start_make_pending(0);
if(change_pending){
changed_module[module_count]= 1;change_pending= 0;
}
}
*limit= ' ';
if(buffer[0]=='@'){
if(isupper(buffer[1]))buffer[1]= tolower(buffer[1]);
/*14:*/
#line 270 "common.w"
{
if(buffer[1]=='i'){
loc= buffer+2;
err_print("! No includes allowed in change file");

}
}

/*:14*/
#line 514 "common.w"
;
if(buffer[1]=='x'||buffer[1]=='y'){
loc= buffer+2;err_print("! Where is the matching @z?");

}
else if(buffer[1]=='z'){
prime_the_change_buffer();changing= !changing;print_where= 1;
}
}
}
}

/*:25*/
#line 424 "common.w"
;
if(!changing){
/*24:*/
#line 484 "common.w"
{
cur_line++;
while(!input_ln(cur_file)){
print_where= 1;
if(include_depth==0){input_has_ended= 1;break;}
else{fclose(cur_file);include_depth--;cur_line++;}
}
if(!input_has_ended)
if(limit==change_limit-change_buffer+buffer)
if(buffer[0]==change_buffer[0])
if(change_limit>change_buffer)check_change();
}

/*:24*/
#line 426 "common.w"
;
if(changing)goto restart;
}
loc= buffer;*limit= ' ';
if(*buffer=='@'&&(*(buffer+1)=='i'||*(buffer+1)=='I'))
/*23:*/
#line 446 "common.w"
{
char*k,*j;
loc= buffer+2;
while(loc<=limit&&(*loc==' '||*loc=='\t'||*loc=='"'))loc++;
if(loc>=limit)err_print("! Include file name not given");

else{
if(++include_depth<max_include_depth){
k= cur_file_name;j= loc;
while(*loc!=' '&&*loc!='\t'&&*loc!='"')*k++= *loc++;
*k= '\0';
if((cur_file= fopen(cur_file_name,"r"))==NULL){
#ifdef INCLUDEDIR
strcpy(cur_file_name,INCLUDEDIR);
k= cur_file_name+strlen(cur_file_name);
while(*j!=' '&&*j!='\t'&&*j!='"')*k++= *j++;
*k= '\0';
if((cur_file= fopen(cur_file_name,"r"))==NULL){
#endif INCLUDEDIR
include_depth--;
err_print("! Cannot open include file");

}
#ifdef INCLUDEDIR
else{cur_line= 0;print_where= 1;}
}
#endif INCLUDEDIR
else{cur_line= 0;print_where= 1;}
}
else{
include_depth--;
err_print("! Too many nested includes");

}
}
goto restart;
}

/*:23*/
#line 431 "common.w"
;
return(!input_has_ended);
}

/*:22*//*26:*/
#line 529 "common.w"

check_complete(){
if(change_limit!=change_buffer){
strncpy(buffer,change_buffer,change_limit-change_buffer+1);
limit= change_limit-change_buffer+buffer;
changing= 1;loc= buffer;
err_print("! Change file entry did not match");

}
}

/*:26*//*47:*/
#line 851 "common.w"

err_print(s)
char*s;
{
char*k,*l;
printf(*s=='!'?"\n%s":"%s",s);
if(web_file_open)/*48:*/
#line 870 "common.w"

{if(changing)printf(". (l. %d of change file)\n",change_line);
else if(include_depth==0)printf(". (l. %d)\n",cur_line);
else printf(". (l. %d of include file %s)\n",cur_line,cur_file_name);
l= (loc>=limit?limit:loc);
if(l>buffer){
for(k= buffer;k<l;k++)
if(*k=='\t')putchar(' ');
else putchar(*k);
putchar('\n');
for(k= buffer;k<l;k++)putchar(' ');
}
for(k= l;k<limit;k++)putchar(*k);
if(*limit=='|')putchar('|');
putchar(' ');
}

/*:48*/
#line 857 "common.w"
;
update_terminal;mark_error;
}

/*:47*//*52:*/
#line 917 "common.w"

wrap_up(){
putchar('\n');
#ifdef STAT
if(show_stats)print_stats();
#endif
/*53:*/
#line 928 "common.w"

switch(history){
case spotless:if(show_happiness)printf("(No errors were found.)\n");break;
case harmless_message:
printf("(Did you see the warning message above?)\n");break;
case error_message:
printf("(Pardon me, but I think I spotted something wrong.)\n");break;
case fatal_message:printf("(That was a fatal error, my friend.)\n");
}

/*:53*/
#line 923 "common.w"
;
if(history>harmless_message)exit(1);
else exit(0);
}

/*:52*//*56:*/
#line 981 "common.w"

scan_args()
{
char*dot_pos;
char*name_pos;
register char*s;
boolean found_web= 0,found_change= 0,found_out= 0;

boolean flag_change;

while(--argc>0){
if(**(++argv)=='-'||**argv=='+')/*60:*/
#line 1058 "common.w"

{
if(**argv=='-')flag_change= 0;
else flag_change= 1;
for(dot_pos= *argv+1;*dot_pos>'\0';dot_pos++)
flags[*dot_pos]= flag_change;
}

/*:60*/
#line 992 "common.w"

else{
s= name_pos= *argv;dot_pos= NULL;
while(*s){
if(*s=='.')dot_pos= s++;
else if(*s=='/')dot_pos= NULL,name_pos= ++s;
else s++;
}
if(!found_web)/*57:*/
#line 1018 "common.w"

{
if(s-*argv>max_file_name_length-5)
/*62:*/
#line 1077 "common.w"
fatal("! Filename too long\n",*argv);

/*:62*/
#line 1021 "common.w"
;
if(dot_pos==NULL)
sprintf(web_file_name,"%s.w",*argv);
else{
strcpy(web_file_name,*argv);
*dot_pos= 0;
}
sprintf(alt_web_file_name,"%s.web",*argv);
sprintf(tex_file_name,"%s.tex",name_pos);
sprintf(C_file_name,"%s.c",name_pos);
found_web= 1;
}

/*:57*/
#line 1001 "common.w"

else if(!found_change)/*58:*/
#line 1034 "common.w"

{
if(s-*argv>max_file_name_length-4)
/*62:*/
#line 1077 "common.w"
fatal("! Filename too long\n",*argv);

/*:62*/
#line 1037 "common.w"
;
if(dot_pos==NULL)
sprintf(change_file_name,"%s.ch",*argv);
else strcpy(change_file_name,*argv);
found_change= 1;
}

/*:58*/
#line 1002 "common.w"

else if(!found_out)/*59:*/
#line 1044 "common.w"

{
if(s-*argv>max_file_name_length-5)
/*62:*/
#line 1077 "common.w"
fatal("! Filename too long\n",*argv);

/*:62*/
#line 1047 "common.w"
;
if(dot_pos==NULL){
sprintf(tex_file_name,"%s.tex",*argv);
sprintf(C_file_name,"%s.c",*argv);
}else{
strcpy(tex_file_name,*argv);
strcpy(C_file_name,*argv);
}
found_out= 1;
}

/*:59*/
#line 1003 "common.w"

else/*61:*/
#line 1066 "common.w"

{
if(program==tangle)
fatal(
"! Usage: ctangle [options] webfile[.w] [changefile[.ch] [outfile[.c]]]\n"
,"")
else fatal(
"! Usage: cweave [options] webfile[.w] [changefile[.ch] [outfile[.tex]]]\n"
,"");
}

/*:61*/
#line 1004 "common.w"
;
}
}
if(!found_web)/*61:*/
#line 1066 "common.w"

{
if(program==tangle)
fatal(
"! Usage: ctangle [options] webfile[.w] [changefile[.ch] [outfile[.c]]]\n"
,"")
else fatal(
"! Usage: cweave [options] webfile[.w] [changefile[.ch] [outfile[.tex]]]\n"
,"");
}

/*:61*/
#line 1007 "common.w"
;
if(!found_change)strcpy(change_file_name,"/dev/null");
}

/*:56*/
#line 60 "common.w"
;

/*:1*//*34:*/
#line 617 "common.w"
name_pointer
id_lookup(first,last,t)
char*first;
char*last;
sixteen_bits t;
{
char*i= first;
int h;
int l;
name_pointer p;
if(last==NULL)for(last= first;*last!='\0';last++);
l= last-first;
/*35:*/
#line 639 "common.w"

h= *i;while(++i<last)h= (h+h+*i)%hash_size;

/*:35*/
#line 629 "common.w"
;
/*36:*/
#line 645 "common.w"

p= hash[h];
while(p&&!names_match(p,first,l,t))p= p->link;
if(p==NULL){
p= name_ptr;
p->link= hash[h];hash[h]= p;
}

/*:36*/
#line 630 "common.w"
;
if(p==name_ptr)/*37:*/
#line 657 "common.w"
{
if(byte_ptr+l>byte_mem_end)overflow("byte memory");
if(name_ptr>=name_dir_end)overflow("name");
strncpy(byte_ptr,first,l);
(++name_ptr)->byte_start= byte_ptr+= l;
if(program==weave)init_p(p,t);
}

/*:37*/
#line 631 "common.w"
;
return(p);
}

/*:34*//*41:*/
#line 710 "common.w"
name_pointer
mod_lookup(k,l)
char*k;
char*l;
{
short c= greater;
name_pointer p= root;
name_pointer q= name_dir;
while(p){
c= web_strcmp(k,l+1,p->byte_start,(p+1)->byte_start);
q= p;
switch(c){
case less:p= p->llink;continue;
case greater:p= p->rlink;continue;
case equal:return p;
default:err_print("! Incompatible section names");return name_dir;

}
}
return(install_node(q,c,k,l-k+1));
}

/*:41*//*42:*/
#line 735 "common.w"

web_strcmp(j,j1,k,k1)
char*j;
char*j1;
char*k;
char*k1;
{
while(k<k1&&j<j1&&*j==*k)k++,j++;
if(k==k1)if(j==j1)return equal;
else return extension;
else if(j==j1)return prefix;
else if(*j<*k)return less;
else return greater;
}

/*:42*//*43:*/
#line 758 "common.w"
name_pointer
install_node(parent,c,j,name_len)
name_pointer parent;
int c;
char*j;
int name_len;
{
name_pointer node= name_ptr;
if(byte_ptr+name_len>byte_mem_end)overflow("byte memory");
if(name_ptr==name_dir_end)overflow("name");
if(c==less)parent->llink= node;else parent->rlink= node;
node->llink= NULL;node->rlink= NULL;
init_node(node);
strncpy(byte_ptr,j,name_len);
(++name_ptr)->byte_start= byte_ptr+= name_len;
return(node);
}

/*:43*//*44:*/
#line 782 "common.w"
name_pointer
prefix_lookup(k,l)
char*k;
char*l;
{
short c= greater;
short count= 0;
name_pointer p= root;
name_pointer q= NULL;

name_pointer r= name_dir;
while(p){
c= web_strcmp(k,l+1,p->byte_start,(p+1)->byte_start);
switch(c){
case less:p= p->llink;break;
case greater:p= p->rlink;break;
default:r= p;count++;q= p->rlink;p= p->llink;
}
if(p==NULL){
p= q;q= NULL;
}
}
if(count==0)err_print("! Name does not match");

if(count>1)err_print("! Ambiguous prefix");

return(r);
}

/*:44*/
