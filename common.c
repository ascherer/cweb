/*1:*/
#line 66 "common.w"

/*3:*/
#line 46 "common.h"

#include <ctype.h>  
#include <stdbool.h>  
#include <stddef.h>  
#include <stdint.h>  
#include <stdlib.h>  
#include <stdio.h>  
#include <string.h>  

/*:3*/
#line 67 "common.w"

#define ctangle 0
#define cweave 1 \

#define and_and 04
#define lt_lt 020
#define gt_gt 021
#define plus_plus 013
#define minus_minus 01
#define minus_gt 031
#define non_eq 032
#define lt_eq 034
#define gt_eq 035
#define eq_eq 036
#define or_or 037
#define dot_dot_dot 016
#define colon_colon 06
#define period_ast 026
#define minus_gt_ast 027 \

#define xisalpha(c) (isalpha((eight_bits) c) &&((eight_bits) c<0200) ) 
#define xisdigit(c) (isdigit((eight_bits) c) &&((eight_bits) c<0200) ) 
#define xisspace(c) (isspace((eight_bits) c) &&((eight_bits) c<0200) ) 
#define xislower(c) (islower((eight_bits) c) &&((eight_bits) c<0200) ) 
#define xisupper(c) (isupper((eight_bits) c) &&((eight_bits) c<0200) ) 
#define xisxdigit(c) (isxdigit((eight_bits) c) &&((eight_bits) c<0200) )  \

#define length(c) (size_t) ((c+1) ->byte_start-(c) ->byte_start) 
#define print_id(c) term_write((c) ->byte_start,length((c) ) ) 
#define llink link
#define rlink dummy.Rlink
#define root name_dir->rlink \

#define chunk_marker 0 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless) history= harmless_message;}
#define mark_error history= error_message
#define confusion(s) fatal("! This can't happen: ",s)  \
 \

#define max_include_depth 10 \

#define max_file_name_length 1024
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define cur_line line[include_depth]
#define web_file file[0]
#define web_file_name file_name[0] \

#define show_banner flags['b']
#define show_progress flags['p']
#define show_stats flags['s']
#define show_happiness flags['h']
#define make_xrefs flags['x'] \

#define update_terminal fflush(stdout) 
#define new_line putchar('\n') 
#define putxchar putchar
#define term_write(a,b) fflush(stdout) ,fwrite(a,sizeof(char) ,b,stdout) 
#define C_printf(c,a) fprintf(C_file,c,a) 
#define C_putc(c) putc(c,C_file)  \

#define max_bytes 1000000 \

#define max_toks 1000000
#define max_names 10239 \

#define max_sections 10239 \
 \

#define max_texts 10239
#define hash_size 8501
#define longest_name 10000
#define stack_size 500
#define buf_size 1000
#define long_buf_size (buf_size+longest_name)  \

#define lines_dont_match (change_limit-change_buffer!=limit-buffer|| \
strncmp(buffer,change_buffer,(size_t) (limit-buffer) ) )  \

#define if_section_start_make_pending(b) {*limit= '!'; \
for(loc= buffer;xisspace(*loc) ;loc++) ; \
*limit= ' '; \
if(*loc=='@'&&(xisspace(*(loc+1) ) ||*(loc+1) =='*') ) change_pending= b; \
} \

#define too_long() {include_depth--; \
err_print("! Include file name too long") ;goto restart;} \

#define first_chunk(p) ((p) ->byte_start+2) 
#define prefix_length(p) (int) ((eight_bits) *((p) ->byte_start) *256+ \
(eight_bits) *((p) ->byte_start+1) ) 
#define set_prefix_length(p,m) (*((p) ->byte_start) = (m) /256, \
*((p) ->byte_start+1) = (m) %256)  \

#define less 0
#define equal 1
#define greater 2
#define prefix 3
#define extension 4 \

#define bad_extension 5 \

#define flag_change (**argv!='-') 

#line 68 "common.w"

/*2:*/
#line 37 "common.h"

typedef bool boolean;
typedef uint8_t eight_bits;
typedef uint16_t sixteen_bits;
extern boolean program;
extern int phase;

/*:2*//*4:*/
#line 74 "common.h"

extern char section_text[];
extern char*section_text_end;
extern char*id_first;
extern char*id_loc;

/*:4*//*5:*/
#line 88 "common.h"

extern char buffer[];
extern char*buffer_end;
extern char*loc;
extern char*limit;

/*:5*//*6:*/
#line 103 "common.h"

typedef struct name_info{
char*byte_start;
struct name_info*link;
union{
struct name_info*Rlink;

char Ilk;
}dummy;
void*equiv_or_xref;
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

/*:6*//*8:*/
#line 148 "common.h"

extern int history;

/*:8*//*10:*/
#line 168 "common.h"

extern int include_depth;
extern FILE*file[];
extern FILE*change_file;
extern char C_file_name[];
extern char tex_file_name[];
extern char idx_file_name[];
extern char scn_file_name[];
extern char file_name[][max_file_name_length];

extern char change_file_name[];
extern int line[];
extern int change_line;
extern int change_depth;
extern boolean input_has_ended;
extern boolean changing;
extern boolean web_file_open;

/*:10*//*12:*/
#line 192 "common.h"

extern sixteen_bits section_count;
extern boolean changed_section[];
extern boolean change_pending;
extern boolean print_where;

/*:12*//*13:*/
#line 205 "common.h"

extern int argc;
extern char**argv;
extern boolean flags[];

/*:13*//*14:*/
#line 217 "common.h"

extern FILE*C_file;
extern FILE*tex_file;
extern FILE*idx_file;
extern FILE*scn_file;
extern FILE*active_file;

/*:14*/
#line 69 "common.w"

/*18:*/
#line 85 "common.w"

boolean program;

/*:18*//*19:*/
#line 94 "common.w"
int phase;

/*:19*//*21:*/
#line 131 "common.w"

char section_text[longest_name+1];
char*section_text_end= section_text+longest_name;
char*id_first;
char*id_loc;

/*:21*//*22:*/
#line 151 "common.w"

char buffer[long_buf_size];
char*buffer_end= buffer+buf_size-2;
char*limit= buffer;
char*loc= buffer;

/*:22*//*24:*/
#line 193 "common.w"

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

/*:24*//*25:*/
#line 219 "common.w"

char change_buffer[buf_size];
char*change_limit;

/*:25*//*34:*/
#line 394 "common.w"

sixteen_bits section_count;
boolean changed_section[max_sections];
boolean change_pending;

boolean print_where= 0;

/*:34*//*40:*/
#line 591 "common.w"

char byte_mem[max_bytes];
char*byte_mem_end= byte_mem+max_bytes-1;
name_info name_dir[max_names];
name_pointer name_dir_end= name_dir+max_names-1;

/*:40*//*41:*/
#line 602 "common.w"

name_pointer name_ptr;
char*byte_ptr;

/*:41*//*43:*/
#line 621 "common.w"

name_pointer hash[hash_size];
hash_pointer hash_end= hash+hash_size-1;
hash_pointer h;

/*:43*//*61:*/
#line 1004 "common.w"

int history= spotless;

/*:61*//*69:*/
#line 1125 "common.w"

int argc;
char**argv;
char C_file_name[max_file_name_length];
char tex_file_name[max_file_name_length];
char idx_file_name[max_file_name_length];
char scn_file_name[max_file_name_length];
boolean flags[128];

/*:69*//*79:*/
#line 1273 "common.w"

FILE*C_file;
FILE*tex_file;
FILE*idx_file;
FILE*scn_file;
FILE*active_file;

/*:79*/
#line 70 "common.w"

/*7:*/
#line 126 "common.h"

extern boolean names_match(name_pointer,const char*,size_t,eight_bits);
extern name_pointer id_lookup(const char*,const char*,char);

extern name_pointer prefix_lookup(char*,char*);
extern name_pointer section_lookup(char*,char*,int);
extern void init_node(name_pointer);
extern void init_p(name_pointer,eight_bits);
extern void print_prefix_name(name_pointer);
extern void print_section_name(name_pointer);
extern void sprint_section_name(char*,name_pointer);

/*:7*//*9:*/
#line 151 "common.h"

extern int wrap_up(void);
extern void err_print(const char*);
extern void fatal(const char*,const char*);
extern void overflow(const char*);

/*:9*//*11:*/
#line 186 "common.h"

extern boolean get_line(void);
extern void check_complete(void);
extern void reset_input(void);

/*:11*//*15:*/
#line 225 "common.h"

extern void common_init(void);
extern void print_stats(void);

/*:15*//*59:*/
#line 959 "common.w"

static int section_name_cmp(char**,int,name_pointer);

/*:59*//*71:*/
#line 1157 "common.w"

static void scan_args(void);

/*:71*//*81:*/
#line 1294 "common.w"

static boolean input_ln(FILE*);
static int web_strcmp(char*,int,char*,int);
static name_pointer add_section_name(name_pointer,int,char*,char*,int);
static void extend_section_name(name_pointer,char*,char*,int);
static void check_change(void);
static void prime_the_change_buffer(void);

/*:81*/
#line 71 "common.w"


/*:1*//*20:*/
#line 100 "common.w"

void
common_init(void)
{
/*42:*/
#line 606 "common.w"

name_dir->byte_start= byte_ptr= byte_mem;
name_ptr= name_dir+1;
name_ptr->byte_start= byte_mem;
root= NULL;


/*:42*//*44:*/
#line 628 "common.w"

for(h= hash;h<=hash_end;*h++= NULL);

/*:44*/
#line 104 "common.w"

/*70:*/
#line 1138 "common.w"

show_banner= show_happiness= show_progress= make_xrefs= true;
show_stats= false;

/*:70*/
#line 105 "common.w"

/*80:*/
#line 1280 "common.w"

scan_args();
if(program==ctangle){
if((C_file= fopen(C_file_name,"wb"))==NULL)
fatal("! Cannot open output file ",C_file_name);

}
else{
if((tex_file= fopen(tex_file_name,"wb"))==NULL)
fatal("! Cannot open output file ",tex_file_name);
}

/*:80*/
#line 106 "common.w"

}

/*:20*//*23:*/
#line 161 "common.w"

static boolean input_ln(
FILE*fp)
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

/*:23*//*26:*/
#line 230 "common.w"

static void
prime_the_change_buffer(void)
{
change_limit= change_buffer;
/*27:*/
#line 244 "common.w"

while(1){
change_line++;
if(!input_ln(change_file))return;
if(limit<buffer+2)continue;
if(buffer[0]!='@')continue;
if(xisupper(buffer[1]))buffer[1]= tolower((eight_bits)buffer[1]);
if(buffer[1]=='x')break;
if(buffer[1]=='y'||buffer[1]=='z'||buffer[1]=='i'){
loc= buffer+2;
err_print("! Missing @x in change file");

}
}

/*:27*/
#line 235 "common.w"

/*28:*/
#line 261 "common.w"

do{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended after @x");

return;
}
}while(limit==buffer);

/*:28*/
#line 236 "common.w"

/*29:*/
#line 271 "common.w"

{
change_limit= change_buffer+(ptrdiff_t)(limit-buffer);
strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
}

/*:29*/
#line 237 "common.w"

}

/*:26*//*30:*/
#line 299 "common.w"

static void
check_change(void)
{
int n= 0;
if(lines_dont_match)return;
change_pending= 0;
if(!changed_section[section_count]){
if_section_start_make_pending(1);
if(!change_pending)changed_section[section_count]= 1;
}
while(1){
changing= 1;print_where= 1;change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended before @y");

change_limit= change_buffer;changing= 0;
return;
}
if(limit> buffer+1&&buffer[0]=='@'){
char xyz_code= xisupper(buffer[1])?tolower((eight_bits)buffer[1]):buffer[1];
/*31:*/
#line 337 "common.w"

if(xyz_code=='x'||xyz_code=='z'){
loc= buffer+2;err_print("! Where is the matching @y?");

}
else if(xyz_code=='y'){
if(n> 0){
loc= buffer+2;
printf("\n! Hmm... %d ",n);
err_print("of the preceding lines failed to match");

}
change_depth= include_depth;
return;
}

/*:31*/
#line 321 "common.w"

}
/*29:*/
#line 271 "common.w"

{
change_limit= change_buffer+(ptrdiff_t)(limit-buffer);
strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
}

/*:29*/
#line 323 "common.w"

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

/*:30*//*32:*/
#line 357 "common.w"

void
reset_input(void)
{
limit= buffer;loc= buffer+1;buffer[0]= ' ';
/*33:*/
#line 372 "common.w"

if((web_file= fopen(web_file_name,"r"))==NULL){
strcpy(web_file_name,alt_web_file_name);
if((web_file= fopen(web_file_name,"r"))==NULL)
fatal("! Cannot open input file ",web_file_name);
}


web_file_open= 1;
if((change_file= fopen(change_file_name,"r"))==NULL)
fatal("! Cannot open change file ",change_file_name);

/*:33*/
#line 362 "common.w"

include_depth= 0;cur_line= 0;change_line= 0;
change_depth= include_depth;
changing= 1;prime_the_change_buffer();changing= !changing;
limit= buffer;loc= buffer+1;buffer[0]= ' ';input_has_ended= 0;
}

/*:32*//*35:*/
#line 401 "common.w"

boolean get_line(void)
{
restart:
if(changing&&include_depth==change_depth)
/*38:*/
#line 509 "common.w"
{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended without @z");

buffer[0]= '@';buffer[1]= 'z';limit= buffer+2;
}
if(limit> buffer){
if(change_pending){
if_section_start_make_pending(0);
if(change_pending){
changed_section[section_count]= 1;change_pending= 0;
}
}
*limit= ' ';
if(buffer[0]=='@'){
if(xisupper(buffer[1]))buffer[1]= tolower((eight_bits)buffer[1]);
if(buffer[1]=='x'||buffer[1]=='y'){
loc= buffer+2;
err_print("! Where is the matching @z?");

}
else if(buffer[1]=='z'){
prime_the_change_buffer();changing= !changing;print_where= 1;
}
}
}
}

/*:38*/
#line 406 "common.w"

if(!changing||include_depth> change_depth){
/*37:*/
#line 492 "common.w"
{
cur_line++;
while(!input_ln(cur_file)){
print_where= 1;
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

/*:37*/
#line 408 "common.w"

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
/*36:*/
#line 446 "common.w"
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
cur_line= 0;print_where= 1;
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
cur_line= 0;print_where= 1;
goto restart;
}
}
include_depth--;err_print("! Cannot open include file");goto restart;
}

/*:36*/
#line 427 "common.w"

}
return 1;
}

/*:35*//*39:*/
#line 541 "common.w"

void
check_complete(void){
if(change_limit!=change_buffer){
strncpy(buffer,change_buffer,(size_t)(change_limit-change_buffer+1));
limit= buffer+(ptrdiff_t)(change_limit-change_buffer);
changing= 1;change_depth= include_depth;loc= buffer;
err_print("! Change file entry did not match");

}
}

/*:39*//*45:*/
#line 633 "common.w"

name_pointer
id_lookup(
const char*first,
const char*last,
char t)
{
const char*i= first;
int h;
int l;
name_pointer p;
if(last==NULL)for(last= first;*last!='\0';last++);
l= (int)(last-first);
/*46:*/
#line 656 "common.w"

h= (eight_bits)*i;
while(++i<last)h= (h+h+(int)((eight_bits)*i))%hash_size;


/*:46*/
#line 646 "common.w"

/*47:*/
#line 664 "common.w"

p= hash[h];
while(p&&!names_match(p,first,l,t))p= p->link;
if(p==NULL){
p= name_ptr;
p->link= hash[h];hash[h]= p;
}

/*:47*/
#line 647 "common.w"

if(p==name_ptr)/*48:*/
#line 675 "common.w"
{
if(byte_ptr+l> byte_mem_end)overflow("byte memory");
if(name_ptr>=name_dir_end)overflow("name");
strncpy(byte_ptr,first,l);
(++name_ptr)->byte_start= byte_ptr+= l;
init_p(p,t);
}

/*:48*/
#line 648 "common.w"

return(p);
}

/*:45*//*49:*/
#line 707 "common.w"

void
print_section_name(
name_pointer p)
{
char*ss,*s= first_chunk(p);
name_pointer q= p+1;
while(p!=name_dir){
ss= (p+1)->byte_start-1;
if(*ss==' '&&ss>=s){
term_write(s,(size_t)(ss-s));p= q->link;q= p;
}else{
term_write(s,(size_t)(ss+1-s));p= name_dir;q= NULL;
}
s= p->byte_start;
}
if(q)term_write("...",3);
}

/*:49*//*50:*/
#line 726 "common.w"

void
sprint_section_name(
char*dest,
name_pointer p)
{
char*ss,*s= first_chunk(p);
name_pointer q= p+1;
while(p!=name_dir){
ss= (p+1)->byte_start-1;
if(*ss==' '&&ss>=s){
p= q->link;q= p;
}else{
ss++;p= name_dir;
}
strncpy(dest,s,(size_t)(ss-s)),dest+= ss-s;
s= p->byte_start;
}
*dest= '\0';
}

/*:50*//*51:*/
#line 747 "common.w"

void
print_prefix_name(
name_pointer p)
{
char*s= first_chunk(p);
int l= prefix_length(p);
term_write(s,l);
if(s+l<(p+1)->byte_start)term_write("...",3);
}

/*:51*//*52:*/
#line 768 "common.w"

static int web_strcmp(
char*j,
int j_len,
char*k,
int k_len)
{
char*j1= j+j_len,*k1= k+k_len;
while(k<k1&&j<j1&&*j==*k)k++,j++;
if(k==k1)if(j==j1)return equal;
else return extension;
else if(j==j1)return prefix;
else if(*j<*k)return less;
else return greater;
}

/*:52*//*53:*/
#line 797 "common.w"

static name_pointer
add_section_name(
name_pointer par,
int c,
char*first,
char*last,
int ispref)
{
name_pointer p= name_ptr;
char*s= first_chunk(p);
int name_len= (int)(last-first)+ispref;
if(s+name_len> byte_mem_end)overflow("byte memory");
if(name_ptr+1>=name_dir_end)overflow("name");
(++name_ptr)->byte_start= byte_ptr= s+name_len;
if(ispref){
*(byte_ptr-1)= ' ';
name_len--;
name_ptr->link= name_dir;
(++name_ptr)->byte_start= byte_ptr;
}
set_prefix_length(p,name_len);
strncpy(s,first,name_len);
p->llink= NULL;
p->rlink= NULL;
init_node(p);
return par==NULL?(root= p):c==less?(par->llink= p):(par->rlink= p);
}

/*:53*//*54:*/
#line 826 "common.w"

static void
extend_section_name(
name_pointer p,
char*first,
char*last,
int ispref)
{
char*s;
name_pointer q= p+1;
int name_len= (int)(last-first)+ispref;
if(name_ptr>=name_dir_end)overflow("name");
while(q->link!=name_dir)q= q->link;
q->link= name_ptr;
s= name_ptr->byte_start;
name_ptr->link= name_dir;
if(s+name_len> byte_mem_end)overflow("byte memory");
(++name_ptr)->byte_start= byte_ptr= s+name_len;
strncpy(s,first,name_len);
if(ispref)*(byte_ptr-1)= ' ';
}

/*:54*//*55:*/
#line 854 "common.w"

name_pointer
section_lookup(
char*first,char*last,
int ispref)
{
int c= 0;
name_pointer p= root;
name_pointer q= NULL;
name_pointer r= NULL;
name_pointer par= NULL;

int name_len= (int)(last-first)+1;
/*56:*/
#line 878 "common.w"

while(p){
c= web_strcmp(first,name_len,first_chunk(p),prefix_length(p));
if(c==less||c==greater){
if(r==NULL)
par= p;
p= (c==less?p->llink:p->rlink);
}else{
if(r!=NULL){
fputs("\n! Ambiguous prefix: matches <",stdout);

print_prefix_name(p);
fputs(">\n and <",stdout);
print_prefix_name(r);
err_print(">");
return name_dir;
}
r= p;
p= p->llink;
q= r->rlink;
}
if(p==NULL)
p= q,q= NULL;
}

/*:56*/
#line 868 "common.w"

/*57:*/
#line 903 "common.w"

if(r==NULL)
return add_section_name(par,c,first,last+1,ispref);

/*:57*/
#line 869 "common.w"

/*58:*/
#line 911 "common.w"

switch(section_name_cmp(&first,name_len,r)){

case prefix:
if(!ispref){
fputs("\n! New name is a prefix of <",stdout);

print_section_name(r);
err_print(">");
}
else if(name_len<prefix_length(r))set_prefix_length(r,name_len);

case equal:return r;
case extension:if(!ispref||first<=last)
extend_section_name(r,first,last+1,ispref);
return r;
case bad_extension:
fputs("\n! New name extends <",stdout);

print_section_name(r);
err_print(">");
return r;
default:
fputs("\n! Section name incompatible with <",stdout);

print_prefix_name(r);
fputs(">,\n which abbreviates <",stdout);
print_section_name(r);
err_print(">");
return r;
}

/*:58*/
#line 870 "common.w"

}

/*:55*//*60:*/
#line 962 "common.w"

static int section_name_cmp(
char**pfirst,
int len,
name_pointer r)
{
char*first= *pfirst;
name_pointer q= r+1;
char*ss,*s= first_chunk(r);
int c;
int ispref;
while(1){
ss= (r+1)->byte_start-1;
if(*ss==' '&&ss>=r->byte_start)ispref= 1,q= q->link;
else ispref= 0,ss++,q= name_dir;
switch(c= web_strcmp(first,len,s,ss-s)){
case equal:if(q==name_dir)
if(ispref){
*pfirst= first+(ptrdiff_t)(ss-s);
return extension;
}else return equal;
else return(q->byte_start==(q+1)->byte_start)?equal:prefix;
case extension:
if(!ispref)return bad_extension;
first+= ss-s;
if(q!=name_dir){len-= (int)(ss-s);s= q->byte_start;r= q;continue;}
*pfirst= first;return extension;
default:return c;
}
}
}

/*:60*//*62:*/
#line 1014 "common.w"

void
err_print(
const char*s)
{
char*k,*l;
printf(*s=='!'?"\n%s":"%s",s);
if(web_file_open)/*63:*/
#line 1034 "common.w"

{if(changing&&include_depth==change_depth)
printf(". (l. %d of change file)\n",change_line);
else if(include_depth==0)printf(". (l. %d)\n",cur_line);
else printf(". (l. %d of include file %s)\n",cur_line,cur_file_name);
l= (loc>=limit?limit:loc);
if(l> buffer){
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

/*:63*/
#line 1021 "common.w"

update_terminal;mark_error;
}

/*:62*//*64:*/
#line 1066 "common.w"

int wrap_up(void){
if(show_progress)new_line;
if(show_stats)
print_stats();
/*65:*/
#line 1076 "common.w"

switch(history){
case spotless:if(show_happiness)puts("(No errors were found.)");break;
case harmless_message:
puts("(Did you see the warning message above?)");break;
case error_message:
puts("(Pardon me, but I think I spotted something wrong.)");break;
case fatal_message:puts("(That was a fatal error, my friend.)");
}

/*:65*/
#line 1071 "common.w"

if(history> harmless_message)return(1);
else return(0);
}

/*:64*//*66:*/
#line 1092 "common.w"
void
fatal(
const char*s,const char*t)
{
if(*s)err_print(s);
err_print(t);
history= fatal_message;exit(wrap_up());
}

/*:66*//*67:*/
#line 1103 "common.w"
void
overflow(
const char*t)
{
printf("\n! Sorry, %s capacity exceeded",t);fatal("","");
}


/*:67*//*72:*/
#line 1160 "common.w"

static void
scan_args(void)
{
char*dot_pos;
char*name_pos;
register char*s;
boolean found_web= 0,found_change= 0,found_out= 0;


strcpy(change_file_name,"/dev/null");
while(--argc> 0){
if((**(++argv)=='-'||**argv=='+')&&*(*argv+1))/*76:*/
#line 1249 "common.w"

{
for(dot_pos= *argv+1;*dot_pos> '\0';dot_pos++)
flags[(eight_bits)*dot_pos]= flag_change;
}

/*:76*/
#line 1172 "common.w"

else{
s= name_pos= *argv;dot_pos= NULL;
while(*s){
if(*s=='.')dot_pos= s++;
else if(*s=='/')dot_pos= NULL,name_pos= ++s;
else s++;
}
if(!found_web)/*73:*/
#line 1197 "common.w"

{
if(s-*argv> max_file_name_length-5)
/*78:*/
#line 1267 "common.w"
fatal("! Filename too long\n",*argv);


/*:78*/
#line 1200 "common.w"

if(dot_pos==NULL)
sprintf(web_file_name,"%s.w",*argv);
else{
strcpy(web_file_name,*argv);
*dot_pos= 0;
}
sprintf(alt_web_file_name,"%s.web",*argv);
sprintf(tex_file_name,"%s.tex",name_pos);
sprintf(idx_file_name,"%s.idx",name_pos);
sprintf(scn_file_name,"%s.scn",name_pos);
sprintf(C_file_name,"%s.c",name_pos);
found_web= 1;
}

/*:73*/
#line 1181 "common.w"

else if(!found_change)/*74:*/
#line 1215 "common.w"

{
if(strcmp(*argv,"-")!=0){
if(s-*argv> max_file_name_length-4)
/*78:*/
#line 1267 "common.w"
fatal("! Filename too long\n",*argv);


/*:78*/
#line 1219 "common.w"

if(dot_pos==NULL)
sprintf(change_file_name,"%s.ch",*argv);
else strcpy(change_file_name,*argv);
}
found_change= 1;
}

/*:74*/
#line 1182 "common.w"

else if(!found_out)/*75:*/
#line 1227 "common.w"

{
if(s-*argv> max_file_name_length-5)
/*78:*/
#line 1267 "common.w"
fatal("! Filename too long\n",*argv);


/*:78*/
#line 1230 "common.w"

if(dot_pos==NULL){
sprintf(tex_file_name,"%s.tex",*argv);
sprintf(idx_file_name,"%s.idx",*argv);
sprintf(scn_file_name,"%s.scn",*argv);
sprintf(C_file_name,"%s.c",*argv);
}else{
strcpy(tex_file_name,*argv);
strcpy(C_file_name,*argv);
if(make_xrefs){
*dot_pos= 0;
sprintf(idx_file_name,"%s.idx",*argv);
sprintf(scn_file_name,"%s.scn",*argv);
}
}
found_out= 1;
}

/*:75*/
#line 1183 "common.w"

else/*77:*/
#line 1255 "common.w"

{
if(program==ctangle)
fatal(
"! Usage: ctangle [options] webfile[.w] [{changefile[.ch]|-} [outfile[.c]]]\n"
,"");

else fatal(
"! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\n"
,"");
}

/*:77*/
#line 1184 "common.w"

}
}
if(!found_web)/*77:*/
#line 1255 "common.w"

{
if(program==ctangle)
fatal(
"! Usage: ctangle [options] webfile[.w] [{changefile[.ch]|-} [outfile[.c]]]\n"
,"");

else fatal(
"! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\n"
,"");
}

/*:77*/
#line 1187 "common.w"

}

/*:72*/
