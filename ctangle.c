#define banner "This is CTANGLE (Version 2.8)\n" \

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
#define print_id(c)term_write((c)->byte_start,length((c)))
#define llink link
#define rlink dummy.Rlink
#define root name_dir->rlink \

#define chunk_marker 0 \

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
#define C_printf(c,a)fprintf(C_file,c,a)
#define C_putc(c)putc(c,C_file) \

#define equiv equiv_or_xref \

#define section_flag max_texts \

#define string 02
#define join 0177 \

#define cur_end cur_state.end_field
#define cur_byte cur_state.byte_field
#define cur_name cur_state.name_field
#define cur_repl cur_state.repl_field
#define cur_section cur_state.section_field \

#define section_number 0201
#define identifier 0202 \

#define normal 0
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
#define section_name 0307
#define new_section 0310 \

#define constant 03 \

#define isxalpha(c)((c)=='_') \

#define compress(c)if(loc++<=limit)return(c) \

#define macro 0
#define app_repl(c){if(tok_ptr==tok_mem_end)overflow("token");*tok_ptr++= c;} \

/*2:*/
#line 68 "ctangle.w"

/*5:*/
#line 35 "common.h"

#include <stdio.h>

/*:5*//*53:*/
#line 747 "ctangle.w"

#include <ctype.h> 

/*:53*/
#line 69 "ctangle.w"

/*4:*/
#line 29 "common.h"

typedef short boolean;
typedef char unsigned eight_bits;
extern boolean program;
extern int phase;

/*:4*//*6:*/
#line 53 "common.h"

char section_text[longest_name+1];
char*section_text_end= section_text+longest_name;
char*id_first;
char*id_loc;

/*:6*//*7:*/
#line 61 "common.h"

extern char buffer[];
extern char*buffer_end;
extern char*loc;
extern char*limit;

/*:7*//*8:*/
#line 76 "common.h"

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
extern name_pointer section_lookup();
extern name_pointer prefix_lookup();

/*:8*//*9:*/
#line 118 "common.h"

extern history;
extern err_print();
extern wrap_up();

/*:9*//*10:*/
#line 131 "common.h"

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
#line 150 "common.h"

typedef unsigned short sixteen_bits;
extern sixteen_bits section_count;
extern boolean changed_section[];
extern boolean change_pending;
extern boolean print_where;

/*:11*//*12:*/
#line 162 "common.h"

extern int argc;
extern char**argv;
extern boolean flags[];

/*:12*//*13:*/
#line 174 "common.h"

extern FILE*C_file;
extern FILE*tex_file;
#line 109 "ctangle.w"

/*:13*/
#line 70 "ctangle.w"

/*14:*/
#line 133 "ctangle.w"

typedef struct{
eight_bits*tok_start;
sixteen_bits text_link;
}text;
typedef text*text_pointer;

/*:14*//*25:*/
#line 273 "ctangle.w"

typedef struct{
eight_bits*end_field;
eight_bits*byte_field;
name_pointer name_field;
text_pointer repl_field;
sixteen_bits section_field;
}output_state;
typedef output_state*stack_pointer;

/*:25*/
#line 71 "ctangle.w"

/*15:*/
#line 140 "ctangle.w"

text text_info[max_texts];
text_pointer text_info_end= text_info+max_texts-1;
text_pointer text_ptr;
eight_bits tok_mem[max_toks];
eight_bits*tok_mem_end= tok_mem+max_toks-1;
eight_bits*tok_ptr;

/*:15*//*21:*/
#line 206 "ctangle.w"

text_pointer last_unnamed;

/*:21*//*26:*/
#line 289 "ctangle.w"

output_state cur_state;

output_state stack[stack_size+1];
stack_pointer stack_ptr;
stack_pointer stack_end= stack+stack_size;

/*:26*//*30:*/
#line 354 "ctangle.w"

int cur_val;

/*:30*//*34:*/
#line 430 "ctangle.w"

eight_bits out_state;
boolean protect;

/*:34*//*36:*/
#line 457 "ctangle.w"

name_pointer output_files[max_files];
name_pointer*cur_out_file,*end_output_files,*an_output_file;
char cur_section_name_char;
char output_file_name[longest_name];

/*:36*//*47:*/
#line 668 "ctangle.w"

eight_bits ccode[128];

/*:47*//*50:*/
#line 712 "ctangle.w"

boolean comment_continues= 0;

/*:50*//*52:*/
#line 744 "ctangle.w"

name_pointer cur_section_name;

/*:52*//*66:*/
#line 1023 "ctangle.w"

text_pointer cur_text;
eight_bits next_control;

/*:66*//*73:*/
#line 1146 "ctangle.w"

extern sixteen_bits section_count;

/*:73*/
#line 72 "ctangle.w"


main(ac,av)
int ac;
char**av;
{
argc= ac;argv= av;
program= tangle;
/*16:*/
#line 148 "ctangle.w"

text_info->tok_start= tok_ptr= tok_mem;
text_ptr= text_info+1;text_ptr->tok_start= tok_mem;


/*:16*//*18:*/
#line 158 "ctangle.w"

name_dir->equiv= (char*)text_info;

/*:18*//*22:*/
#line 209 "ctangle.w"
last_unnamed= text_info;text_info->text_link= 0;

/*:22*//*37:*/
#line 467 "ctangle.w"

cur_out_file= end_output_files= output_files+max_files;

/*:37*//*48:*/
#line 671 "ctangle.w"
{
int c;
for(c= 0;c<=127;c++)ccode[c]= ignore;
ccode[' ']= ccode['\t']= ccode['\n']= ccode['\v']= ccode['\r']= ccode['\f']
= ccode['*']= new_section;
ccode['@']= '@';ccode['=']= string;
ccode['d']= ccode['D']= definition;
ccode['f']= ccode['F']= ccode['s']= ccode['S']= format_code;
ccode['c']= ccode['C']= ccode['p']= ccode['P']= begin_C;
ccode['^']= ccode[':']= ccode['.']= ccode['t']= ccode['T']= 
ccode['q']= ccode['Q']= control_text;
ccode['&']= join;
ccode['<']= ccode['(']= section_name;
ccode['\'']= ord;
}

/*:48*//*62:*/
#line 947 "ctangle.w"
section_text[0]= ' ';

/*:62*/
#line 80 "ctangle.w"
;
common_init();
if(show_banner)printf(banner);
phase_one();
phase_two();
wrap_up();
}

/*:2*//*19:*/
#line 164 "ctangle.w"

names_match(p,first,l)
name_pointer p;
char*first;
int l;
{
if(length(p)!=l)return 0;
return!strncmp(first,p->byte_start,l);
}

/*:19*//*20:*/
#line 179 "ctangle.w"

init_node(node)
name_pointer node;
{
node->equiv= (char*)text_info;
}
init_p(){}

/*:20*//*24:*/
#line 239 "ctangle.w"
store_two_bytes(x)
sixteen_bits x;
{
if(tok_ptr+2>tok_mem_end)overflow("token");
*tok_ptr++= x>>8;
*tok_ptr++= x&0377;
}

/*:24*//*28:*/
#line 313 "ctangle.w"
push_level(p)
name_pointer p;
{
if(stack_ptr==stack_end)overflow("stack");
*stack_ptr= cur_state;
stack_ptr++;
cur_name= p;cur_repl= (text_pointer)p->equiv;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;
cur_section= 0;
}

/*:28*//*29:*/
#line 328 "ctangle.w"
pop_level()
{
if(cur_repl->text_link<section_flag){
cur_repl= cur_repl->text_link+text_info;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;
return;
}
stack_ptr--;
if(stack_ptr>stack)cur_state= *stack_ptr;
}

/*:29*//*31:*/
#line 360 "ctangle.w"
get_output()
{
sixteen_bits a;
restart:if(stack_ptr==stack)return;
if(cur_byte==cur_end){
cur_val= -((int)cur_section);
pop_level();
if(cur_val==0)goto restart;
out_char(section_number);return;
}
a= *cur_byte++;
if(a<0200)out_char(a);
else{
a= (a-0200)*0400+*cur_byte++;
switch(a/024000){
case 0:cur_val= a;out_char(identifier);break;
case 1:/*32:*/
#line 386 "ctangle.w"

a-= 024000;
if((a+name_dir)->equiv!=(char*)text_info)push_level(a+name_dir);
else if(a!=0){
printf("\n! Not present: <");print_section_name(a+name_dir);err_print(">");

}
goto restart;

/*:32*/
#line 376 "ctangle.w"
;
default:cur_val= a-050000;if(cur_val>0)cur_section= cur_val;
out_char(section_number);
}
}
}

/*:31*//*35:*/
#line 438 "ctangle.w"
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
#line 488 "ctangle.w"

phase_two(){
web_file_open= 0;
cur_line= 1;
/*41:*/
#line 542 "ctangle.w"
{
sixteen_bits a;
for(cur_text= text_info+1;cur_text<text_ptr;cur_text++)
if(cur_text->text_link==0){
cur_byte= cur_text->tok_start;
cur_end= (cur_text+1)->tok_start;
C_printf("#define ",0);
out_state= normal;
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
cur_val= a-050000;cur_section= cur_val;out_char(section_number);
}

}
}
protect= 0;
flush_buffer();
}
}

/*:41*/
#line 492 "ctangle.w"
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
#line 302 "ctangle.w"

stack_ptr= stack+1;cur_name= name_dir;cur_repl= text_info->text_link+text_info;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;cur_section= 0;

/*:27*/
#line 508 "ctangle.w"
;
while(stack_ptr>stack)get_output();
flush_buffer();
writeloop:/*40:*/
#line 520 "ctangle.w"

for(an_output_file= end_output_files;an_output_file>cur_out_file;){
an_output_file--;
sprint_section_name(output_file_name,*an_output_file);
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
#line 511 "ctangle.w"
;
if(show_happiness)printf("\nDone.");
}
}

/*:39*//*42:*/
#line 574 "ctangle.w"
out_char(cur_char)
eight_bits cur_char;
{
char*j,*k;
switch(cur_char){
case'\n':if(protect)C_putc(' ');
if(protect||out_state==verbatim)C_putc('\\');
flush_buffer();if(out_state!=verbatim)out_state= normal;break;
/*44:*/
#line 614 "ctangle.w"

case identifier:
if(out_state==num_or_id)C_putc(' ');
for(j= (cur_val+name_dir)->byte_start,k= (cur_val+name_dir+1)->byte_start;
j<k;j++)C_putc(*j);
out_state= num_or_id;break;

/*:44*/
#line 582 "ctangle.w"
;
/*45:*/
#line 621 "ctangle.w"

case section_number:
if(cur_val>0)C_printf("/*%d:*/",cur_val);
else if(cur_val<0)C_printf("/*:%d*/",-cur_val);
else{
sixteen_bits a;
a= 0400**cur_byte++;
a+= *cur_byte++;
C_printf("\n#line %d \"",a);
cur_val= *cur_byte++;
cur_val= 0400*(cur_val-0200)+*cur_byte++;
for(j= (cur_val+name_dir)->byte_start,k= (cur_val+name_dir+1)->byte_start;
j<k;j++)C_putc(*j);
C_printf("\"\n",0);
}
break;

/*:45*/
#line 583 "ctangle.w"
;
/*43:*/
#line 601 "ctangle.w"

case plus_plus:C_putc('+');C_putc('+');out_state= normal;break;
case minus_minus:C_putc('-');C_putc('-');out_state= normal;break;
case minus_gt:C_putc('-');C_putc('>');out_state= normal;break;
case gt_gt:C_putc('>');C_putc('>');out_state= normal;break;
case eq_eq:C_putc('=');C_putc('=');out_state= normal;break;
case lt_lt:C_putc('<');C_putc('<');out_state= normal;break;
case gt_eq:C_putc('>');C_putc('=');out_state= normal;break;
case lt_eq:C_putc('<');C_putc('=');out_state= normal;break;
case not_eq:C_putc('!');C_putc('=');out_state= normal;break;
case and_and:C_putc('&');C_putc('&');out_state= normal;break;
case or_or:C_putc('|');C_putc('|');out_state= normal;break;

/*:43*/
#line 584 "ctangle.w"
;
case'=':C_putc('=');if(out_state!=verbatim){
C_putc(' ');out_state= normal;
}
break;
case join:out_state= unbreakable;break;
case constant:if(out_state==verbatim){
out_state= num_or_id;break;
}
if(out_state==num_or_id)C_putc(' ');out_state= verbatim;break;
case string:if(out_state==verbatim)out_state= normal;
else out_state= verbatim;break;
default:C_putc(cur_char);if(out_state!=verbatim)out_state= normal;
break;
}
}

/*:42*//*49:*/
#line 690 "ctangle.w"
eight_bits skip_ahead()
{
eight_bits c;
while(1){
if(loc>limit&&(get_line()==0))return(new_section);
*(limit+1)= '@';
while(*loc!='@')loc++;
if(loc<=limit){
loc++;c= ccode[*loc];loc++;
if(c!=ignore||*(loc-1)=='>')return(c);
}
}
}

/*:49*//*51:*/
#line 715 "ctangle.w"

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
if(ccode[*loc]==new_section){
err_print("! Section name ended in mid-comment");loc--;

return(comment_continues= 0);
}
else loc++;
}
}
}

/*:51*//*54:*/
#line 755 "ctangle.w"
eight_bits get_next()
{
static int preprocessing= 0;
eight_bits c;
while(1){
if(loc>limit){
if(preprocessing&&*(limit-1)!='\\')preprocessing= 0;
if(get_line()==0)return(new_section);
else if(print_where){
print_where= 0;
/*68:*/
#line 1048 "ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:68*/
#line 765 "ctangle.w"
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
#line 819 "ctangle.w"
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
#line 776 "ctangle.w"

else if(isalpha(c)||isxalpha(c))/*56:*/
#line 813 "ctangle.w"
{
id_first= --loc;
while(isalpha(*++loc)||isdigit(*loc)||isxalpha(*loc));
id_loc= loc;return(identifier);
}

/*:56*/
#line 777 "ctangle.w"

else if(c=='\''||c=='\"')/*58:*/
#line 849 "ctangle.w"
{
char delim= c;
id_first= section_text+1;
id_loc= section_text;*++id_loc= delim;
while(1){
if(loc>=limit){
if(*(limit-1)!='\\'){
err_print("! String didn't end");loc= limit;break;

}
if(get_line()==0){
err_print("! Input ended in middle of string");loc= buffer;break;

}
else if(++id_loc<=section_text_end)*id_loc= '\n';

}
if((c= *loc++)==delim){
if(++id_loc<=section_text_end)*id_loc= c;
break;
}
if(c=='\\'){
if(loc>=limit)continue;
if(++id_loc<=section_text_end)*id_loc= '\\';
c= *loc++;
}
if(++id_loc<=section_text_end)*id_loc= c;
}
if(id_loc>=section_text_end){
printf("\n! String too long: ");

term_write(section_text+1,25);
err_print("...");
}
id_loc++;
return(string);
}

/*:58*/
#line 778 "ctangle.w"

else if(c=='@')/*59:*/
#line 890 "ctangle.w"
{
c= ccode[*loc++];
switch(c){
case ignore:continue;
case control_text:while((c= skip_ahead())=='@');

if(*(loc-1)!='>')err_print("! Improper @ within control text");

continue;
case section_name:
cur_section_name_char= *(loc-1);
/*61:*/
#line 929 "ctangle.w"
{
char*k;
/*63:*/
#line 949 "ctangle.w"

k= section_text;
while(1){
if(loc>limit&&get_line()==0){
err_print("! Input ended in section name");

loc= buffer+1;break;
}
c= *loc;
/*64:*/
#line 973 "ctangle.w"

if(c=='@'){
c= *(loc+1);
if(c=='>'){
loc+= 2;break;
}
if(ccode[c]==new_section){
err_print("! Section name didn't end");break;

}
if(ccode[c]==section_name){
err_print("! Nesting of section names not allowed");break;

}
*(++k)= '@';loc++;
}

/*:64*/
#line 958 "ctangle.w"
;
loc++;if(k<section_text_end)k++;
if(isspace(c)){
c= ' ';if(*(k-1)==' ')k--;
}
*k= c;
}
if(k>=section_text_end){
printf("\n! Section name too long: ");

term_write(section_text+1,25);
printf("...");mark_harmless;
}
if(*k==' '&&k>section_text)k--;

/*:63*/
#line 931 "ctangle.w"
;
if(k-section_text>3&&strncmp(k-2,"...",3)==0)
cur_section_name= section_lookup(section_text+1,k-3,1);
else cur_section_name= section_lookup(section_text+1,k,0);
if(cur_section_name_char=='(')
/*38:*/
#line 471 "ctangle.w"

{
if(cur_out_file>output_files){
for(an_output_file= cur_out_file;
an_output_file<end_output_files;an_output_file++)
if(*an_output_file==cur_section_name)break;
if(an_output_file==end_output_files)
*--cur_out_file= cur_section_name;
}else{
overflow("output files");
}
}


/*:38*/
#line 937 "ctangle.w"
;
return(section_name);
}

/*:61*/
#line 901 "ctangle.w"
;
case string:/*65:*/
#line 995 "ctangle.w"
{
id_first= loc++;*(limit+1)= '@';*(limit+2)= '>';
while(*loc!='@'||*(loc+1)!='>')loc++;
if(loc>=limit)err_print("! Verbatim string didn't end");

id_loc= loc;loc+= 2;
return(string);
}

/*:65*/
#line 902 "ctangle.w"
;
case ord:/*60:*/
#line 914 "ctangle.w"

id_first= loc;
if(*loc=='\\'){
if(*++loc=='\'')loc++;
}
while(*loc!='\''){
loc++;
if(loc>limit){
err_print("! String didn't end");loc= limit-1;break;

}
}
loc++;
return(ord);

/*:60*/
#line 903 "ctangle.w"
;
default:return(c);
}
}

/*:59*/
#line 779 "ctangle.w"

else if(isspace(c)){
if(!preprocessing||loc>limit)continue;

else return(' ');
}
else if(c=='#'&&loc==buffer+1)preprocessing= 1;
mistake:/*55:*/
#line 798 "ctangle.w"

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
#line 786 "ctangle.w"

return(c);
}
}

/*:54*//*67:*/
#line 1027 "ctangle.w"
scan_repl(t)
eight_bits t;
{
sixteen_bits a;
if(t==section_name){/*68:*/
#line 1048 "ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:68*/
#line 1031 "ctangle.w"
;}
while(1)switch(a= get_next()){
/*69:*/
#line 1058 "ctangle.w"

case identifier:a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);break;
case section_name:if(t!=section_name)goto done;
else{
/*70:*/
#line 1080 "ctangle.w"
{
char*try_loc= loc;
while(*try_loc==' '&&try_loc<limit)try_loc++;
if(*try_loc=='+'&&try_loc<limit)try_loc++;
while(*try_loc==' '&&try_loc<limit)try_loc++;
if(*try_loc=='=')err_print("! Missing `@ ' before a named section");



}

/*:70*/
#line 1063 "ctangle.w"
;
a= cur_section_name-name_dir;
app_repl((a/0400)+0250);
app_repl(a%0400);
/*68:*/
#line 1048 "ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:68*/
#line 1067 "ctangle.w"
;break;
}
case constant:case string:
/*71:*/
#line 1091 "ctangle.w"

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
#line 1070 "ctangle.w"
;
case ord:
/*72:*/
#line 1107 "ctangle.w"
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
#line 1072 "ctangle.w"
;
case definition:case format_code:case begin_C:if(t!=section_name)goto done;
else{
err_print("! @d, @f and @c are ignored in C text");continue;

}
case new_section:goto done;

/*:69*/
#line 1036 "ctangle.w"

default:app_repl(a);
}
done:next_control= (eight_bits)a;
if(text_ptr>text_info_end)overflow("text");
cur_text= text_ptr;(++text_ptr)->tok_start= tok_ptr;
}

/*:67*//*74:*/
#line 1153 "ctangle.w"
scan_section()
{
name_pointer p;
text_pointer q;
sixteen_bits a;
boolean def_flag= 0;
section_count++;
if(*(loc-1)=='*'&&show_progress){
printf("*%d",section_count);update_terminal;
}
next_control= 0;
while(1){
/*75:*/
#line 1190 "ctangle.w"

while(next_control<definition)

if((next_control= skip_ahead())==section_name){
loc-= 2;next_control= get_next();
}

/*:75*/
#line 1166 "ctangle.w"
;
if(next_control==definition){
/*76:*/
#line 1197 "ctangle.w"
{
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

/*:76*/
#line 1168 "ctangle.w"

continue;
}
if(next_control==begin_C){
p= name_dir;break;
}
if(next_control==section_name){
p= cur_section_name;
/*77:*/
#line 1222 "ctangle.w"

while((next_control= get_next())=='+');
if(next_control!='='&&next_control!=eq_eq)
continue;

/*:77*/
#line 1176 "ctangle.w"
;
break;
}
return;
}
/*78:*/
#line 1227 "ctangle.w"

/*79:*/
#line 1232 "ctangle.w"

store_two_bytes((sixteen_bits)(0150000+section_count));


/*:79*/
#line 1228 "ctangle.w"
;
scan_repl(section_name);
/*80:*/
#line 1236 "ctangle.w"

if(p==name_dir||p==0){
(last_unnamed)->text_link= cur_text-text_info;last_unnamed= cur_text;
}
else if(p->equiv==(char*)text_info)p->equiv= (char*)cur_text;

else{
q= (text_pointer)p->equiv;
while(q->text_link<section_flag)q= q->text_link+text_info;
q->text_link= cur_text-text_info;
}
cur_text->text_link= section_flag;

/*:80*/
#line 1230 "ctangle.w"
;

/*:78*/
#line 1181 "ctangle.w"
;
}

/*:74*//*81:*/
#line 1249 "ctangle.w"
phase_one(){
phase= 1;
section_count= 0;
reset_input();
while((next_control= skip_ahead())!=new_section);
while(!input_has_ended)scan_section();
check_complete();
phase= 2;
}

/*:81*//*82:*/
#line 1259 "ctangle.w"

#ifdef STAT
print_stats(){
printf("\nMemory usage statistics:\n");
printf("%d names (out of %d)\n",name_ptr-name_dir,max_names);
printf("%d replacement texts (out of %d)\n",text_ptr-text_info,max_texts);
printf("%d bytes (out of %d)\n",byte_ptr-byte_mem,max_bytes);
printf("%d tokens (out of %d)\n",tok_ptr-tok_mem,max_toks);
}
#endif 

/*:82*/
