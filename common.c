/*1:*/
#line 66 "common.w"

/*5:*/
#line 110 "common.w"

#include <ctype.h> 

/*:5*//*8:*/
#line 173 "common.w"

#include <stdio.h>  
#include <stddef.h>  
#include <stdbool.h>  
#include <stdint.h>  

/*:8*//*22:*/
#line 483 "common.w"

#include <stdlib.h>  

/*:22*//*81:*/
#line 1423 "common.w"

#include <string.h> 

/*:81*/
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

#define buf_size 1000
#define longest_name 10000
#define long_buf_size (buf_size+longest_name) 
#define xisspace(c) (isspace((eight_bits) c) &&((eight_bits) c<0200) ) 
#define xisupper(c) (isupper((eight_bits) c) &&((eight_bits) c<0200) )  \

#define max_include_depth 10 \

#define max_file_name_length 1024
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define cur_line line[include_depth]
#define web_file file[0]
#define web_file_name file_name[0] \

#define lines_dont_match (change_limit-change_buffer!=limit-buffer|| \
strncmp(buffer,change_buffer,(size_t) (limit-buffer) ) )  \

#define if_section_start_make_pending(b) {*limit= '!'; \
for(loc= buffer;xisspace(*loc) ;loc++) ; \
*limit= ' '; \
if(*loc=='@'&&(xisspace(*(loc+1) ) ||*(loc+1) =='*') ) change_pending= b; \
} \

#define max_sections 10239 \
 \

#define too_long() {include_depth--; \
err_print("! Include file name too long") ;goto restart;} \

#define max_bytes 1000000 \

#define max_names 10239 \
 \

#define length(c) (size_t) ((c+1) ->byte_start-(c) ->byte_start) 
#define print_id(c) term_write((c) ->byte_start,length((c) ) )  \

#define hash_size 8501 \

#define llink link
#define rlink dummy.Rlink
#define root name_dir->rlink \
 \

#define first_chunk(p) ((p) ->byte_start+2) 
#define prefix_length(p) (int) ((unsigned char) *((p) ->byte_start) *256+ \
(unsigned char) *((p) ->byte_start+1) ) 
#define set_prefix_length(p,m) (*((p) ->byte_start) = (m) /256, \
*((p) ->byte_start+1) = (m) %256)  \

#define less 0
#define equal 1
#define greater 2
#define prefix 3
#define extension 4 \

#define bad_extension 5 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless) history= harmless_message;}
#define mark_error history= error_message \

#define confusion(s) fatal("! This can't happen: ",s)  \
 \

#define show_banner flags['b']
#define show_progress flags['p']
#define show_stats flags['s']
#define show_happiness flags['h'] \

#define flag_change (**argv!='-') 
#define update_terminal fflush(stdout)  \

#define new_line putchar('\n') 
#define putxchar putchar
#define term_write(a,b) fflush(stdout) ,fwrite(a,sizeof(char) ,b,stdout) 
#define C_printf(c,a) fprintf(C_file,c,a) 
#define C_putc(c) putc(c,C_file)  \


#line 68 "common.w"

/*2:*/
#line 81 "common.w"

typedef bool boolean;
boolean program;

/*:2*//*7:*/
#line 167 "common.w"

char buffer[long_buf_size];
char*buffer_end= buffer+buf_size-2;
char*limit= buffer;
char*loc= buffer;

/*:7*//*10:*/
#line 225 "common.w"

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

/*:10*//*20:*/
#line 429 "common.w"

typedef uint8_t eight_bits;
typedef uint16_t sixteen_bits;
sixteen_bits section_count;
boolean changed_section[max_sections];
boolean change_pending;

boolean print_where= 0;

/*:20*//*27:*/
#line 606 "common.w"

typedef struct name_info{
char*byte_start;
/*31:*/
#line 643 "common.w"

struct name_info*link;

/*:31*//*40:*/
#line 742 "common.w"

union{
struct name_info*Rlink;

char Ilk;
}dummy;

/*:40*//*55:*/
#line 1076 "common.w"

void*equiv_or_xref;

/*:55*/
#line 609 "common.w"

}name_info;
typedef name_info*name_pointer;
char byte_mem[max_bytes];
char*byte_mem_end= byte_mem+max_bytes-1;
name_info name_dir[max_names];
name_pointer name_dir_end= name_dir+max_names-1;

/*:27*//*29:*/
#line 629 "common.w"

name_pointer name_ptr;
char*byte_ptr;

/*:29*//*32:*/
#line 656 "common.w"

typedef name_pointer*hash_pointer;
name_pointer hash[hash_size];
hash_pointer hash_end= hash+hash_size-1;
hash_pointer h;

/*:32*//*56:*/
#line 1096 "common.w"

int history= spotless;

/*:56*//*67:*/
#line 1235 "common.w"

int argc;
char**argv;
char C_file_name[max_file_name_length];
char tex_file_name[max_file_name_length];
char idx_file_name[max_file_name_length];
char scn_file_name[max_file_name_length];
boolean flags[128];

/*:67*//*77:*/
#line 1383 "common.w"

FILE*C_file;
FILE*tex_file;
FILE*idx_file;
FILE*scn_file;
FILE*active_file;

/*:77*/
#line 69 "common.w"

/*3:*/
#line 91 "common.w"
int phase;

/*:3*//*11:*/
#line 251 "common.w"

char change_buffer[buf_size];
char*change_limit;

/*:11*/
#line 70 "common.w"

/*33:*/
#line 662 "common.w"

extern boolean names_match(name_pointer,const char*,size_t,eight_bits);

/*:33*//*38:*/
#line 715 "common.w"

extern void init_p(name_pointer,eight_bits);

/*:38*//*46:*/
#line 866 "common.w"

extern void init_node(name_pointer);

/*:46*//*53:*/
#line 1031 "common.w"

static int section_name_cmp(char**,int,name_pointer);

/*:53*//*57:*/
#line 1106 "common.w"

extern void err_print(const char*);

/*:57*//*60:*/
#line 1154 "common.w"

extern int wrap_up(void);
extern void print_stats(void);

/*:60*//*63:*/
#line 1187 "common.w"

extern void fatal(const char*,const char*);
extern void overflow(const char*);

/*:63*//*69:*/
#line 1267 "common.w"

static void scan_args(void);

/*:69*//*82:*/
#line 1430 "common.w"

boolean get_line(void);
name_pointer id_lookup(const char*,const char*,char);
name_pointer section_lookup(char*,char*,int);
void check_complete(void);
void common_init(void);
void print_prefix_name(name_pointer);
void print_section_name(name_pointer);
void reset_input(void);
void sprint_section_name(char*,name_pointer);

/*:82*//*83:*/
#line 1443 "common.w"

static boolean input_ln(FILE*);
static int web_strcmp(char*,int,char*,int);
static name_pointer add_section_name(name_pointer,int,char*,char*,int);
static void extend_section_name(name_pointer,char*,char*,int);
static void check_change(void);
static void prime_the_change_buffer(void);

/*:83*/
#line 71 "common.w"


/*:1*//*4:*/
#line 97 "common.w"

void
common_init(void)
{
/*30:*/
#line 633 "common.w"

name_dir->byte_start= byte_ptr= byte_mem;
name_ptr= name_dir+1;
name_ptr->byte_start= byte_mem;

/*:30*//*34:*/
#line 667 "common.w"

for(h= hash;h<=hash_end;*h++= NULL);

/*:34*//*41:*/
#line 749 "common.w"

root= NULL;

/*:41*/
#line 101 "common.w"

/*68:*/
#line 1248 "common.w"

show_banner= show_happiness= show_progress= true;
show_stats= false;

/*:68*/
#line 102 "common.w"

/*78:*/
#line 1390 "common.w"

scan_args();
if(program==ctangle){
if((C_file= fopen(C_file_name,"wb"))==NULL)
fatal("! Cannot open output file ",C_file_name);

}
else{
if((tex_file= fopen(tex_file_name,"wb"))==NULL)
fatal("! Cannot open output file ",tex_file_name);
}

/*:78*/
#line 103 "common.w"

}

/*:4*//*9:*/
#line 183 "common.w"

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

/*:9*//*12:*/
#line 262 "common.w"

static void
prime_the_change_buffer(void)
{
change_limit= change_buffer;
/*13:*/
#line 276 "common.w"

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

/*:13*/
#line 267 "common.w"

/*14:*/
#line 293 "common.w"

do{
change_line++;
if(!input_ln(change_file)){
err_print("! Change file ended after @x");

return;
}
}while(limit==buffer);

/*:14*/
#line 268 "common.w"

/*15:*/
#line 303 "common.w"

{
change_limit= change_buffer+(ptrdiff_t)(limit-buffer);
strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
}

/*:15*/
#line 269 "common.w"

}

/*:12*//*16:*/
#line 331 "common.w"

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
/*17:*/
#line 369 "common.w"

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

/*:17*/
#line 353 "common.w"

}
/*15:*/
#line 303 "common.w"

{
change_limit= change_buffer+(ptrdiff_t)(limit-buffer);
strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
}

/*:15*/
#line 355 "common.w"

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

/*:16*//*18:*/
#line 389 "common.w"

void
reset_input(void)
{
limit= buffer;loc= buffer+1;buffer[0]= ' ';
/*19:*/
#line 404 "common.w"

if((web_file= fopen(web_file_name,"r"))==NULL){
strcpy(web_file_name,alt_web_file_name);
if((web_file= fopen(web_file_name,"r"))==NULL)
fatal("! Cannot open input file ",web_file_name);
}


web_file_open= 1;
if((change_file= fopen(change_file_name,"r"))==NULL)
fatal("! Cannot open change file ",change_file_name);

/*:19*/
#line 394 "common.w"

include_depth= 0;cur_line= 0;change_line= 0;
change_depth= include_depth;
changing= 1;prime_the_change_buffer();changing= !changing;
limit= buffer;loc= buffer+1;buffer[0]= ' ';input_has_ended= 0;
}

/*:18*//*21:*/
#line 438 "common.w"

boolean get_line(void)
{
restart:
if(changing&&include_depth==change_depth)
/*25:*/
#line 549 "common.w"
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

/*:25*/
#line 443 "common.w"

if(!changing||include_depth> change_depth){
/*24:*/
#line 532 "common.w"
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

/*:24*/
#line 445 "common.w"

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
/*23:*/
#line 486 "common.w"
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

/*:23*/
#line 464 "common.w"

}
return 1;
}

/*:21*//*26:*/
#line 581 "common.w"

void
check_complete(void){
if(change_limit!=change_buffer){
strncpy(buffer,change_buffer,(size_t)(change_limit-change_buffer+1));
limit= buffer+(ptrdiff_t)(change_limit-change_buffer);
changing= 1;change_depth= include_depth;loc= buffer;
err_print("! Change file entry did not match");

}
}

/*:26*//*35:*/
#line 672 "common.w"

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
/*36:*/
#line 695 "common.w"

h= (unsigned char)*i;
while(++i<last)h= (h+h+(int)((unsigned char)*i))%hash_size;


/*:36*/
#line 685 "common.w"

/*37:*/
#line 703 "common.w"

p= hash[h];
while(p&&!names_match(p,first,l,t))p= p->link;
if(p==NULL){
p= name_ptr;
p->link= hash[h];hash[h]= p;
}

/*:37*/
#line 686 "common.w"

if(p==name_ptr)/*39:*/
#line 718 "common.w"
{
if(byte_ptr+l> byte_mem_end)overflow("byte memory");
if(name_ptr>=name_dir_end)overflow("name");
strncpy(byte_ptr,first,l);
(++name_ptr)->byte_start= byte_ptr+= l;
if(program==cweave)init_p(p,t);
}

/*:39*/
#line 687 "common.w"

return(p);
}

/*:35*//*42:*/
#line 776 "common.w"

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

/*:42*//*43:*/
#line 795 "common.w"

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

/*:43*//*44:*/
#line 816 "common.w"

void
print_prefix_name(
name_pointer p)
{
char*s= first_chunk(p);
int l= prefix_length(p);
term_write(s,l);
if(s+l<(p+1)->byte_start)term_write("...",3);
}

/*:44*//*45:*/
#line 837 "common.w"

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

/*:45*//*47:*/
#line 869 "common.w"

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

/*:47*//*48:*/
#line 898 "common.w"

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

/*:48*//*49:*/
#line 926 "common.w"

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
/*50:*/
#line 950 "common.w"

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

/*:50*/
#line 940 "common.w"

/*51:*/
#line 975 "common.w"

if(r==NULL)
return add_section_name(par,c,first,last+1,ispref);

/*:51*/
#line 941 "common.w"

/*52:*/
#line 983 "common.w"

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

/*:52*/
#line 942 "common.w"

}

/*:49*//*54:*/
#line 1034 "common.w"

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

/*:54*//*58:*/
#line 1109 "common.w"

void
err_print(
const char*s)
{
char*k,*l;
printf(*s=='!'?"\n%s":"%s",s);
if(web_file_open)/*59:*/
#line 1129 "common.w"

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

/*:59*/
#line 1116 "common.w"

update_terminal;mark_error;
}

/*:58*//*61:*/
#line 1164 "common.w"

int wrap_up(void){
if(show_progress)new_line;
if(show_stats)
print_stats();
/*62:*/
#line 1174 "common.w"

switch(history){
case spotless:if(show_happiness)puts("(No errors were found.)");break;
case harmless_message:
puts("(Did you see the warning message above?)");break;
case error_message:
puts("(Pardon me, but I think I spotted something wrong.)");break;
case fatal_message:puts("(That was a fatal error, my friend.)");
}

/*:62*/
#line 1169 "common.w"

if(history> harmless_message)return(1);
else return(0);
}

/*:61*//*64:*/
#line 1194 "common.w"
void
fatal(
const char*s,const char*t)
{
if(*s)fputs(s,stdout);
err_print(t);
history= fatal_message;exit(wrap_up());
}

/*:64*//*65:*/
#line 1205 "common.w"
void
overflow(
const char*t)
{
printf("\n! Sorry, %s capacity exceeded",t);fatal("","");
}


/*:65*//*70:*/
#line 1270 "common.w"

static void
scan_args(void)
{
char*dot_pos;
char*name_pos;
register char*s;
boolean found_web= 0,found_change= 0,found_out= 0;


strcpy(change_file_name,"/dev/null");
while(--argc> 0){
if((**(++argv)=='-'||**argv=='+')&&*(*argv+1))/*74:*/
#line 1359 "common.w"

{
for(dot_pos= *argv+1;*dot_pos> '\0';dot_pos++)
flags[(eight_bits)*dot_pos]= flag_change;
}

/*:74*/
#line 1282 "common.w"

else{
s= name_pos= *argv;dot_pos= NULL;
while(*s){
if(*s=='.')dot_pos= s++;
else if(*s=='/')dot_pos= NULL,name_pos= ++s;
else s++;
}
if(!found_web)/*71:*/
#line 1307 "common.w"

{
if(s-*argv> max_file_name_length-5)
/*76:*/
#line 1377 "common.w"
fatal("! Filename too long\n",*argv);


/*:76*/
#line 1310 "common.w"

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

/*:71*/
#line 1291 "common.w"

else if(!found_change)/*72:*/
#line 1325 "common.w"

{
if(strcmp(*argv,"-")!=0){
if(s-*argv> max_file_name_length-4)
/*76:*/
#line 1377 "common.w"
fatal("! Filename too long\n",*argv);


/*:76*/
#line 1329 "common.w"

if(dot_pos==NULL)
sprintf(change_file_name,"%s.ch",*argv);
else strcpy(change_file_name,*argv);
}
found_change= 1;
}

/*:72*/
#line 1292 "common.w"

else if(!found_out)/*73:*/
#line 1337 "common.w"

{
if(s-*argv> max_file_name_length-5)
/*76:*/
#line 1377 "common.w"
fatal("! Filename too long\n",*argv);


/*:76*/
#line 1340 "common.w"

if(dot_pos==NULL){
sprintf(tex_file_name,"%s.tex",*argv);
sprintf(idx_file_name,"%s.idx",*argv);
sprintf(scn_file_name,"%s.scn",*argv);
sprintf(C_file_name,"%s.c",*argv);
}else{
strcpy(tex_file_name,*argv);
strcpy(C_file_name,*argv);
if(flags['x']){
*dot_pos= 0;
sprintf(idx_file_name,"%s.idx",*argv);
sprintf(scn_file_name,"%s.scn",*argv);
}
}
found_out= 1;
}

/*:73*/
#line 1293 "common.w"

else/*75:*/
#line 1365 "common.w"

{
if(program==ctangle)
fatal(
"! Usage: ctangle [options] webfile[.w] [{changefile[.ch]|-} [outfile[.c]]]\n"
,"");

else fatal(
"! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\n"
,"");
}

/*:75*/
#line 1294 "common.w"

}
}
if(!found_web)/*75:*/
#line 1365 "common.w"

{
if(program==ctangle)
fatal(
"! Usage: ctangle [options] webfile[.w] [{changefile[.ch]|-} [outfile[.c]]]\n"
,"");

else fatal(
"! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\n"
,"");
}

/*:75*/
#line 1297 "common.w"

}

/*:70*/
