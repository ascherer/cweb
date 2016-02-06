#define banner "This is CTANGLE (Version 2.7)\n" \

#define max_bytes 90000 \

#define max_toks 270000
#define max_names 4000 \

#define max_texts 2500
#define hash_size 353
#define longest_name 400
#define stack_size 50
#define buf_size 100 \

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

#define length(c)(c+1)->byte_start-(c)->byte_start
#define print_id(c)term_write((c)->byte_start,length((c))) \

#define llink link
#define rlink dummy.Rlink
#define root name_dir->rlink \
 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless)history= harmless_message;}
#define mark_error history= error_message
#define confusion(s)fatal("! This can't happen: ",s)
#define fatal(s,t){ \
printf(s);err_print(t); \
history= fatal_message;wrap_up(); \
}
#define overflow(t){ \
printf("\n! Sorry, %s capacity exceeded",t);fatal("",""); \
} \

#define max_file_name_length 60
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define web_file_name file_name[0]
#define cur_line line[include_depth] \

#define show_banner flags['b']
#define show_progress flags['p']
#define show_happiness flags['h'] \

#define update_terminal fflush(stdout)
#define new_line putchar('\n')
#define putxchar putchar
#define term_write(a,b)fflush(stdout),write(1,a,b)
#define line_write(c)write(fileno(C_file),c)
#define C_printf(c,a)fprintf(C_file,c,a)
#define C_putc(c)putc(c,C_file) \

#define equiv equiv_or_xref \

#define module_flag max_texts \

#define string 02
#define join 0177 \

#define cur_end cur_state.end_field
#define cur_byte cur_state.byte_field
#define cur_name cur_state.name_field
#define cur_repl cur_state.repl_field
#define cur_mod cur_state.mod_field \

#define module_number 0201
#define identifier 0202 \

#define misc 0
#define num_or_id 1
#define unbreakable 3
#define verbatim 4 \

#define max_files 256
#define ignore 0
#define ord 0302
#define control_text 0303
#define format_code 0304
#define definition 0305
#define begin_C 0306
#define module_name 0307
#define new_module 0310 \

#define constant 03 \

#define isxalpha(c)((c)=='_') \

#define compress(c)if(loc++<=limit)return(c) \

#define macro 0
#define app_repl(c){if(tok_ptr==tok_mem_end)overflow("token");*tok_ptr++= c;} \

/*2:*/
#line 67 "ctangle.w"

/*5:*/
#line 34 "common.h"

#include <stdio.h>

/*:5*//*53:*/
#line 746 "ctangle.w"

#include <ctype.h> 

/*:53*/
#line 68 "ctangle.w"

/*4:*/
#line 28 "common.h"

typedef short boolean;
typedef char unsigned eight_bits;
extern boolean program;
extern int phase;

/*:4*//*6:*/
#line 52 "common.h"

char mod_text[longest_name+1];
char*mod_text_end= mod_text+longest_name;
char*id_first;
char*id_loc;

/*:6*//*7:*/
#line 60 "common.h"

extern char buffer[];
extern char*buffer_end;
extern char*loc;
extern char*limit;

/*:7*//*8:*/
#line 75 "common.h"

typedef struct name_info{
char*byte_start;
struct name_info*link;
union{
struct name_info*Rlink;

char Ilk;
}dummy;
char*equiv_or_xref;
}name_info;
typedef name_info*name_pointer;
typedef name_pointer*hash_pointer;
extern char byte_mem[];
extern char*byte_mem_end;
extern name_info name_dir[];
extern name_pointer name_dir_end;
extern name_pointer name_ptr;
extern char*byte_ptr;
extern name_pointer hash[];
extern hash_pointer hash_end;
extern hash_pointer h;
extern name_pointer id_lookup();
extern name_pointer mod_lookup();
extern name_pointer prefix_lookup();

/*:8*//*9:*/
#line 117 "common.h"

extern history;
extern err_print();
extern wrap_up();

/*:9*//*10:*/
#line 130 "common.h"

extern include_depth;
extern FILE*file[];
extern FILE*change_file;
extern char C_file_name[];
extern char tex_file_name[];
extern char file_name[][max_file_name_length];

extern char change_file_name[];
extern line[];
extern change_line;
extern boolean input_has_ended;
extern boolean changing;
extern boolean web_file_open;
extern reset_input();
extern get_line();
extern check_complete();

/*:10*//*11:*/
#line 149 "common.h"

typedef unsigned short sixteen_bits;
extern sixteen_bits module_count;
extern boolean changed_module[];
extern boolean change_pending;
extern boolean print_where;

/*:11*//*12:*/
#line 161 "common.h"

extern int argc;
extern char**argv;
extern boolean flags[];

/*:12*//*13:*/
#line 174 "common.h"

extern FILE*C_file;
extern FILE*tex_file;
#line 108 "ctangle.w"

/*:13*/
#line 69 "ctangle.w"

/*14:*/
#line 132 "ctangle.w"

typedef struct{
eight_bits*tok_start;
sixteen_bits text_link;
}text;
typedef text*text_pointer;

/*:14*//*25:*/
#line 272 "ctangle.w"

typedef struct{
eight_bits*end_field;
eight_bits*byte_field;
name_pointer name_field;
text_pointer repl_field;
sixteen_bits mod_field;
}output_state;
typedef output_state*stack_pointer;

/*:25*/
#line 70 "ctangle.w"

/*15:*/
#line 139 "ctangle.w"

text text_info[max_texts];
text_pointer text_info_end= text_info+max_texts-1;
text_pointer text_ptr;
eight_bits tok_mem[max_toks];
eight_bits*tok_mem_end= tok_mem+max_toks-1;
eight_bits*tok_ptr;

/*:15*//*21:*/
#line 205 "ctangle.w"

text_pointer last_unnamed;

/*:21*//*26:*/
#line 288 "ctangle.w"

output_state cur_state;

output_state stack[stack_size+1];
stack_pointer stack_ptr;
stack_pointer stack_end= stack+stack_size;

/*:26*//*30:*/
#line 353 "ctangle.w"

int cur_val;

/*:30*//*34:*/
#line 429 "ctangle.w"

eight_bits out_state;
boolean protect;

/*:34*//*36:*/
#line 456 "ctangle.w"

name_pointer output_files[max_files];
name_pointer*cur_out_file,*end_output_files,*an_output_file;
char cur_module_char;
char output_file_name[longest_name];

/*:36*//*47:*/
#line 667 "ctangle.w"

eight_bits ccode[128];

/*:47*//*50:*/
#line 711 "ctangle.w"

boolean comment_continues= 0;

/*:50*//*52:*/
#line 743 "ctangle.w"

name_pointer cur_module;

/*:52*//*66:*/
#line 1009 "ctangle.w"

text_pointer cur_text;
eight_bits next_control;

/*:66*//*73:*/
#line 1130 "ctangle.w"

extern sixteen_bits module_count;

/*:73*/
#line 71 "ctangle.w"


main(ac,av)
int ac;
char**av;
{
argc= ac;argv= av;
program= tangle;
/*16:*/
#line 147 "ctangle.w"

text_info->tok_start= tok_ptr= tok_mem;
text_ptr= text_info+1;text_ptr->tok_start= tok_mem;


/*:16*//*18:*/
#line 157 "ctangle.w"

name_dir->equiv= (char*)text_info;

/*:18*//*22:*/
#line 208 "ctangle.w"
last_unnamed= text_info;text_info->text_link= 0;

/*:22*//*37:*/
#line 466 "ctangle.w"

cur_out_file= end_output_files= output_files+max_files;

/*:37*//*48:*/
#line 670 "ctangle.w"
{
int c;
for(c= 0;c<=127;c++)ccode[c]= ignore;
ccode[' ']= ccode['\t']= ccode['\n']= ccode['\v']= ccode['\r']= ccode['\f']
= ccode['*']= new_module;
ccode['@']= '@';ccode['=']= string;
ccode['d']= ccode['D']= definition;
ccode['f']= ccode['F']= ccode['s']= ccode['S']= format_code;
ccode['c']= ccode['C']= ccode['p']= ccode['P']= begin_C;
ccode['^']= ccode[':']= ccode['.']= ccode['t']= ccode['T']= 
ccode['q']= ccode['Q']= control_text;
ccode['&']= join;
ccode['<']= ccode['(']= module_name;
ccode['\'']= ord;
}

/*:48*//*62:*/
#line 937 "ctangle.w"
mod_text[0]= ' ';

/*:62*/
#line 79 "ctangle.w"
;
common_init();
if(show_banner)printf(banner);
phase_one();
phase_two();
wrap_up();
}

/*:2*//*19:*/
#line 163 "ctangle.w"

names_match(p,first,l)
name_pointer p;
char*first;
int l;
{
if(length(p)!=l)return 0;
return!strncmp(first,p->byte_start,l);
}

/*:19*//*20:*/
#line 178 "ctangle.w"

init_node(node)
name_pointer node;
{
node->equiv= (char*)text_info;
}
init_p(){}

/*:20*//*24:*/
#line 238 "ctangle.w"
store_two_bytes(x)
sixteen_bits x;
{
if(tok_ptr+2>tok_mem_end)overflow("token");
*tok_ptr++= x>>8;
*tok_ptr++= x&0377;
}

/*:24*//*28:*/
#line 312 "ctangle.w"
push_level(p)
name_pointer p;
{
if(stack_ptr==stack_end)overflow("stack");
*stack_ptr= cur_state;
stack_ptr++;
cur_name= p;cur_repl= (text_pointer)p->equiv;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;
cur_mod= 0;
}

/*:28*//*29:*/
#line 327 "ctangle.w"
pop_level()
{
if(cur_repl->text_link<module_flag){
cur_repl= cur_repl->text_link+text_info;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;
return;
}
stack_ptr--;
if(stack_ptr>stack)cur_state= *stack_ptr;
}

/*:29*//*31:*/
#line 359 "ctangle.w"
get_output()
{
sixteen_bits a;
restart:if(stack_ptr==stack)return;
if(cur_byte==cur_end){
cur_val= -((int)cur_mod);
pop_level();
if(cur_val==0)goto restart;
out_char(module_number);return;
}
a= *cur_byte++;
if(a<0200)out_char(a);
else{
a= (a-0200)*0400+*cur_byte++;
switch(a/024000){
case 0:cur_val= a;out_char(identifier);break;
case 1:/*32:*/
#line 385 "ctangle.w"

a-= 024000;
if((a+name_dir)->equiv!=(char*)text_info)push_level(a+name_dir);
else if(a!=0){
printf("\n! Not present: <");print_id(a+name_dir);err_print(">");

}
goto restart;

/*:32*/
#line 375 "ctangle.w"
;
default:cur_val= a-050000;if(cur_val>0)cur_mod= cur_val;
out_char(module_number);
}
}
}

/*:31*//*35:*/
#line 437 "ctangle.w"
flush_buffer()
{
C_putc('\n');
if(cur_line%100==0&&show_progress){
printf(".");
if(cur_line%500==0)printf("%d",cur_line);
update_terminal;
}
cur_line++;
}

/*:35*//*39:*/
#line 487 "ctangle.w"

phase_two(){
web_file_open= 0;
cur_line= 1;
/*41:*/
#line 541 "ctangle.w"
{
sixteen_bits a;
for(cur_text= text_info+1;cur_text<text_ptr;cur_text++)
if(cur_text->text_link==0){
cur_byte= cur_text->tok_start;
cur_end= (cur_text+1)->tok_start;
C_printf("#define ",0);
out_state= misc;
protect= 1;
while(cur_byte<cur_end){
a= *cur_byte++;
if(cur_byte==cur_end&&a=='\n')break;
if(a<0200)out_char(a);
else{
a= (a-0200)*0400+*cur_byte++;
if(a<024000){
cur_val= a;out_char(identifier);
}
else if(a<050000){confusion("macros defs have strange char");}
else{
cur_val= a-050000;cur_mod= cur_val;out_char(module_number);
}

}
}
protect= 0;
flush_buffer();
}
}

/*:41*/
#line 491 "ctangle.w"
;
if(text_info->text_link==0&&cur_out_file==end_output_files){
printf("\n! No program text was specified.");mark_harmless;

}
else{
if(show_progress){
if(cur_out_file==end_output_files)
printf("\nWriting the output file (%s):",C_file_name);
else{printf("\nWriting the output files:");

if(text_info->text_link==0)goto writeloop;
printf(" (%s)",C_file_name);
update_terminal;
}
}
/*27:*/
#line 301 "ctangle.w"

stack_ptr= stack+1;cur_name= name_dir;cur_repl= text_info->text_link+text_info;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;cur_mod= 0;

/*:27*/
#line 507 "ctangle.w"
;
while(stack_ptr>stack)get_output();
flush_buffer();
writeloop:/*40:*/
#line 518 "ctangle.w"

for(an_output_file= end_output_files;an_output_file>cur_out_file;){
an_output_file--;
strncpy(output_file_name,(*an_output_file)->byte_start,longest_name);
output_file_name[length(*an_output_file)]= '\0';
fclose(C_file);
C_file= fopen(output_file_name,"w");
if(C_file==0)fatal("! Cannot open output file:",output_file_name);

printf("\n(%s)",output_file_name);update_terminal;
cur_line= 1;
stack_ptr= stack+1;
cur_name= (*an_output_file);
cur_repl= (text_pointer)cur_name->equiv;
cur_byte= cur_repl->tok_start;
cur_end= (cur_repl+1)->tok_start;
while(stack_ptr>stack)get_output();
flush_buffer();
}

/*:40*/
#line 510 "ctangle.w"
;
if(show_happiness)printf("\nDone.");
}
}

/*:39*//*42:*/
#line 573 "ctangle.w"
out_char(cur_char)
eight_bits cur_char;
{
char*j;
switch(cur_char){
case'\n':if(protect)C_putc(' ');
if(protect||out_state==verbatim)C_putc('\\');
flush_buffer();if(out_state!=verbatim)out_state= misc;break;
/*44:*/
#line 613 "ctangle.w"

case identifier:
if(out_state==num_or_id)C_putc(' ');
for(j= (cur_val+name_dir)->byte_start;j<(name_dir+cur_val+1)->byte_start;
j++)C_putc(*j);
out_state= num_or_id;break;

/*:44*/
#line 581 "ctangle.w"
;
/*45:*/
#line 620 "ctangle.w"

case module_number:
if(cur_val>0)C_printf("/*%d:*/",cur_val);
else if(cur_val<0)C_printf("/*:%d*/",-cur_val);
else{
sixteen_bits a;
a= 0400**cur_byte++;
a+= *cur_byte++;
C_printf("\n#line %d \"",a);
cur_val= *cur_byte++;
cur_val= 0400*(cur_val-0200)+*cur_byte++;
for(j= (cur_val+name_dir)->byte_start;j<(name_dir+cur_val+1)->byte_start;
j++)C_putc(*j);
C_printf("\"\n",0);
}
break;

/*:45*/
#line 582 "ctangle.w"
;
/*43:*/
#line 600 "ctangle.w"

case plus_plus:C_putc('+');C_putc('+');out_state= misc;break;
case minus_minus:C_putc('-');C_putc('-');out_state= misc;break;
case minus_gt:C_putc('-');C_putc('>');out_state= misc;break;
case gt_gt:C_putc('>');C_putc('>');out_state= misc;break;
case eq_eq:C_putc('=');C_putc('=');out_state= misc;break;
case lt_lt:C_putc('<');C_putc('<');out_state= misc;break;
case gt_eq:C_putc('>');C_putc('=');out_state= misc;break;
case lt_eq:C_putc('<');C_putc('=');out_state= misc;break;
case not_eq:C_putc('!');C_putc('=');out_state= misc;break;
case and_and:C_putc('&');C_putc('&');out_state= misc;break;
case or_or:C_putc('|');C_putc('|');out_state= misc;break;

/*:43*/
#line 583 "ctangle.w"
;
case'=':C_putc('=');if(out_state!=verbatim){
C_putc(' ');out_state= misc;
}
break;
case join:out_state= unbreakable;break;
case constant:if(out_state==verbatim){
out_state= num_or_id;break;
}
if(out_state==num_or_id)C_putc(' ');out_state= verbatim;break;
case string:if(out_state==verbatim)out_state= misc;
else out_state= verbatim;break;
default:C_putc(cur_char);if(out_state!=verbatim)out_state= misc;
break;
}
}

/*:42*//*49:*/
#line 689 "ctangle.w"
eight_bits skip_ahead()
{
eight_bits c;
while(1){
if(loc>limit&&(get_line()==0))return(new_module);
*(limit+1)= '@';
while(*loc!='@')loc++;
if(loc<=limit){
loc++;c= ccode[*loc];loc++;
if(c!=ignore||*(loc-1)=='>')return(c);
}
}
}

/*:49*//*51:*/
#line 714 "ctangle.w"

skip_comment()
{
char c;
while(1){
if(loc>limit)
if(get_line())return(comment_continues= 1);
else{
err_print("! Input ended in mid-comment");

return(comment_continues= 0);
}
c= *(loc++);
if(c=='*'&&*loc=='/'){loc++;return(comment_continues= 0);}
if(c=='@'){
if(ccode[*loc]==new_module){
err_print("! Section name ended in mid-comment");loc--;

return(comment_continues= 0);
}
else loc++;
}
}
}

/*:51*//*54:*/
#line 754 "ctangle.w"
eight_bits get_next()
{
static int preprocessing= 0;
eight_bits c;
while(1){
if(loc>limit){
if(preprocessing&&*(limit-1)!='\\')preprocessing= 0;
if(get_line()==0)return(new_module);
else if(print_where){
print_where= 0;
/*68:*/
#line 1034 "ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:68*/
#line 764 "ctangle.w"
;
}
else return('\n');
}
c= *loc;
if(comment_continues||(c=='/'&&*(loc+1)=='*')){
skip_comment();
if(comment_continues)return('\n');
else continue;
}
loc++;
if(isdigit(c)||c=='\\'||c=='.')/*57:*/
#line 818 "ctangle.w"
{
id_first= loc-1;
if(*id_first=='.'&&!isdigit(*loc))goto mistake;
if(*id_first=='\\')while(isdigit(*loc))loc++;
else{
if(*id_first=='0'){
if(*loc=='x'||*loc=='X'){
loc++;while(isxdigit(*loc))loc++;goto found;
}
}
while(isdigit(*loc))loc++;
if(*loc=='.'){
loc++;
while(isdigit(*loc))loc++;
}
if(*loc=='e'||*loc=='E'){
if(*++loc=='+'||*loc=='-')loc++;
while(isdigit(*loc))loc++;
}
}
found:if(*loc=='l'||*loc=='L')loc++;
id_loc= loc;
return(constant);
}

/*:57*/
#line 775 "ctangle.w"

else if(isalpha(c)||isxalpha(c))/*56:*/
#line 812 "ctangle.w"
{
id_first= --loc;
while(isalpha(*++loc)||isdigit(*loc)||isxalpha(*loc));
id_loc= loc;return(identifier);
}

/*:56*/
#line 776 "ctangle.w"

else if(c=='\''||c=='\"')/*58:*/
#line 848 "ctangle.w"
{
char delim= c;
id_first= mod_text+1;
id_loc= mod_text;*++id_loc= delim;
while(1){
if(loc>=limit){
if(*(limit-1)!='\\'){
err_print("! String didn't end");loc= limit;break;

}
if(get_line()==0){
err_print("! Input ended in middle of string");loc= buffer;break;

}
else if(++id_loc<=mod_text_end)*id_loc= '\n';

}
if((c= *loc++)==delim){
if(++id_loc<=mod_text_end)*id_loc= c;
break;
}
if(c=='\\'){
if(loc>=limit)continue;
if(++id_loc<=mod_text_end)*id_loc= '\\';
c= *loc++;
}
if(++id_loc<=mod_text_end)*id_loc= c;
}
if(id_loc>=mod_text_end){
printf("\n! String too long: ");

term_write(mod_text+1,25);
err_print("...");
}
id_loc++;
return(string);
}

/*:58*/
#line 777 "ctangle.w"

else if(c=='@')/*59:*/
#line 889 "ctangle.w"
{
c= ccode[*loc++];
switch(c){
case ignore:continue;
case control_text:while((c= skip_ahead())=='@');

if(*(loc-1)!='>')err_print("! Improper @ within control text");

continue;
case module_name:
cur_module_char= *(loc-1);
/*61:*/
#line 920 "ctangle.w"
{
char*k;
/*63:*/
#line 939 "ctangle.w"

k= mod_text;
while(1){
if(loc>limit&&get_line()==0){
err_print("! Input ended in section name");

loc= buffer+1;break;
}
c= *loc;
/*64:*/
#line 963 "ctangle.w"

if(c=='@'){
c= *(loc+1);
if(c=='>'){
loc+= 2;break;
}
if(ccode[c]==new_module){
err_print("! Section name didn't end");break;

}
*(++k)= '@';loc++;
}

/*:64*/
#line 948 "ctangle.w"
;
loc++;if(k<mod_text_end)k++;
if(isspace(c)){
c= ' ';if(*(k-1)==' ')k--;
}
*k= c;
}
if(k>=mod_text_end){
printf("\n! Section name too long: ");

term_write(mod_text+1,25);
printf("...");mark_harmless;
}
if(*k==' '&&k>mod_text)k--;

/*:63*/
#line 922 "ctangle.w"
;
if(k-mod_text>3&&strncmp(k-2,"...",3)==0)cur_module= prefix_lookup(mod_text+1,k-3);
else cur_module= mod_lookup(mod_text+1,k);
if(cur_module_char=='(')
/*38:*/
#line 470 "ctangle.w"

{
if(cur_out_file>output_files){
for(an_output_file= cur_out_file;
an_output_file<end_output_files;an_output_file++)
if(*an_output_file==cur_module)break;
if(an_output_file==end_output_files)
*--cur_out_file= cur_module;
}else{
overflow("output files");
}
}


/*:38*/
#line 927 "ctangle.w"
;
return(module_name);
}

/*:61*/
#line 900 "ctangle.w"
;
case string:/*65:*/
#line 981 "ctangle.w"
{
id_first= loc++;*(limit+1)= '@';*(limit+2)= '>';
while(*loc!='@'||*(loc+1)!='>')loc++;
if(loc>=limit)err_print("! Verbatim string didn't end");

id_loc= loc;loc+= 2;
return(string);
}

/*:65*/
#line 901 "ctangle.w"
;
case ord:/*60:*/
#line 907 "ctangle.w"

id_first= loc;
if(*loc=='\\')loc++;
while(*loc!='\''){
loc++;
if(loc>limit){
err_print("! String didn't end");loc= limit-1;break;

}
}
loc++;
return(ord);

/*:60*/
#line 902 "ctangle.w"
;
default:return(c);
}
}

/*:59*/
#line 778 "ctangle.w"

else if(isspace(c)){
if(!preprocessing||loc>limit)continue;

else return(' ');
}
else if(c=='#'&&loc==buffer+1)preprocessing= 1;
mistake:/*55:*/
#line 797 "ctangle.w"

switch(c){
case'+':if(*loc=='+')compress(plus_plus);break;
case'-':if(*loc=='-'){compress(minus_minus);}
else if(*loc=='>')compress(minus_gt);break;
case'=':if(*loc=='=')compress(eq_eq);break;
case'>':if(*loc=='='){compress(gt_eq);}
else if(*loc=='>')compress(gt_gt);break;
case'<':if(*loc=='='){compress(lt_eq);}
else if(*loc=='<')compress(lt_lt);break;
case'&':if(*loc=='&')compress(and_and);break;
case'|':if(*loc=='|')compress(or_or);break;
case'!':if(*loc=='=')compress(not_eq);break;
}

/*:55*/
#line 785 "ctangle.w"

return(c);
}
}

/*:54*//*67:*/
#line 1013 "ctangle.w"
scan_repl(t)
eight_bits t;
{
sixteen_bits a;
if(t==module_name){/*68:*/
#line 1034 "ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:68*/
#line 1017 "ctangle.w"
;}
while(1)switch(a= get_next()){
/*69:*/
#line 1044 "ctangle.w"

case identifier:a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);break;
case module_name:if(t!=module_name)goto done;
else{
/*70:*/
#line 1066 "ctangle.w"
{
char*try_loc= loc;
while(*try_loc==' '&&try_loc<limit)try_loc++;
if(*try_loc=='+'&&try_loc<limit)try_loc++;
while(*try_loc==' '&&try_loc<limit)try_loc++;
if(*try_loc=='=')err_print("! Missing `@ ' before a named module");

}

/*:70*/
#line 1049 "ctangle.w"
;
a= cur_module-name_dir;
app_repl((a/0400)+0250);
app_repl(a%0400);
/*68:*/
#line 1034 "ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:68*/
#line 1053 "ctangle.w"
;break;
}
case constant:case string:
/*71:*/
#line 1075 "ctangle.w"

app_repl(a);
while(id_first<id_loc){
if(*id_first=='@'){
if(*(id_first+1)=='@')id_first++;
else err_print("! Double @ should be used in strings");

}
app_repl(*id_first++);
}
app_repl(a);break;

/*:71*/
#line 1056 "ctangle.w"
;
case ord:
/*72:*/
#line 1091 "ctangle.w"
{
int c= *id_first;
if(c=='@'){
if(*(id_first+1)!='@')err_print("! Double @ should be used in strings");

else id_first++;
}
else if(c=='\\'){
c= *++id_first;
switch(c){
case't':c= '\t';break;
case'n':c= '\n';break;
case'b':c= '\b';break;
case'f':c= '\f';break;
case'v':c= '\v';break;
case'r':c= '\r';break;
case'0':c= '\0';break;
case'\\':c= '\\';break;
case'\'':c= '\'';break;
case'\"':c= '\"';break;
default:err_print("! Unrecognized escape sequence");

}
}

app_repl(constant);
if(c>=100)app_repl('0'+c/100);
if(c>=10)app_repl('0'+(c/10)%10);
app_repl('0'+c%10);
app_repl(constant);
}
break;

/*:72*/
#line 1058 "ctangle.w"
;
case definition:case format_code:case begin_C:if(t!=module_name)goto done;
else{
err_print("! @d, @f and @c are ignored in C text");continue;

}
case new_module:goto done;

/*:69*/
#line 1022 "ctangle.w"

default:app_repl(a);
}
done:next_control= (eight_bits)a;
if(text_ptr>text_info_end)overflow("text");
cur_text= text_ptr;(++text_ptr)->tok_start= tok_ptr;
}

/*:67*//*74:*/
#line 1134 "ctangle.w"
scan_module()
{
name_pointer p;
text_pointer q;
sixteen_bits a;
module_count++;
if(*(loc-1)=='*'&&show_progress){
printf("*%d",module_count);update_terminal;
}
/*75:*/
#line 1147 "ctangle.w"

next_control= 0;
while(1){
while(next_control<=format_code)
if((next_control= skip_ahead())==module_name){
loc-= 2;next_control= get_next();
}
if(next_control!=definition)break;
while((next_control= get_next())=='\n');
if(next_control!=identifier){
err_print("! Definition flushed, must start with identifier");

continue;
}
app_repl(((a= id_lookup(id_first,id_loc)-name_dir)/0400)+0200);
app_repl(a%0400);
if(*loc!='('){
app_repl(string);app_repl(' ');app_repl(string);
}
print_where= 0;scan_repl(macro);
cur_text->text_link= 0;
}

/*:75*/
#line 1143 "ctangle.w"
;
/*76:*/
#line 1170 "ctangle.w"

switch(next_control){
case begin_C:p= name_dir;break;
case module_name:p= cur_module;
/*77:*/
#line 1182 "ctangle.w"

while((next_control= get_next())=='+');
if(next_control!='='&&next_control!=eq_eq){
err_print("! C text flushed, = sign is missing");

while((next_control= skip_ahead())!=new_module);
return;
}

/*:77*/
#line 1174 "ctangle.w"
;
break;
default:return;
}
/*78:*/
#line 1191 "ctangle.w"

store_two_bytes((sixteen_bits)(0150000+module_count));


/*:78*/
#line 1178 "ctangle.w"
;
scan_repl(module_name);
/*79:*/
#line 1195 "ctangle.w"

if(p==name_dir||p==0){
(last_unnamed)->text_link= cur_text-text_info;last_unnamed= cur_text;
}
else if(p->equiv==(char*)text_info)p->equiv= (char*)cur_text;

else{
q= (text_pointer)p->equiv;
while(q->text_link<module_flag)q= q->text_link+text_info;
q->text_link= cur_text-text_info;
}
cur_text->text_link= module_flag;

/*:79*/
#line 1180 "ctangle.w"
;

/*:76*/
#line 1144 "ctangle.w"
;
}

/*:74*//*80:*/
#line 1208 "ctangle.w"
phase_one(){
phase= 1;
module_count= 0;
reset_input();
while((next_control= skip_ahead())!=new_module);
while(!input_has_ended)scan_module();
check_complete();
phase= 2;
}

/*:80*//*81:*/
#line 1218 "ctangle.w"

#ifdef STAT
print_stats(){
printf("\nMemory usage statistics:\n");
printf("%d names (out of %d)\n",name_ptr-name_dir,max_names);
printf("%d replacement texts (out of %d)\n",text_ptr-text_info,max_texts);
printf("%d bytes (out of %d)\n",byte_ptr-byte_mem,max_bytes);
printf("%d tokens (out of %d)\n",tok_ptr-tok_mem,max_toks);
}
#endif

/*:81*/
