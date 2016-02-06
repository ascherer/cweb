/*1:*/
#line 57 "common.w"

#line 161 "common.ch"
/*5:*/
#line 101 "common.w"

#include <ctype.h>

/*:5*//*8:*/
#line 163 "common.w"

#include <stdio.h>

/*:8*//*22:*/
#line 428 "common.ch"

#include <stdlib.h> 
#include <stddef.h> 

#ifdef _AMIGA
#define PATH_SEPARATOR   ','
#define DIR_SEPARATOR    '/'
#define DEVICE_SEPARATOR ':'
#else
#ifdef __TURBOC__
#define PATH_SEPARATOR   ';'
#define DIR_SEPARATOR    '\\'
#define DEVICE_SEPARATOR ':'
#else
#define PATH_SEPARATOR   ':'
#define DIR_SEPARATOR    '/'
#define DEVICE_SEPARATOR '/'
#endif
#endif
#line 470 "common.w"

/*:22*//*81:*/
#line 1384 "common.ch"

#include <string.h>

/*:81*//*87:*/
#line 1455 "common.ch"

#ifdef __TURBOC__
#include <alloc.h> 
#include <io.h> 
#endif


/*:87*//*89:*/
#line 1481 "common.ch"

#ifdef _AMIGA
#include <libraries/locale.h>
#include <proto/locale.h>
#include <proto/exec.h>

struct Library*LocaleBase;
struct Catalog*catalog;
int i;
#else 
typedef long int LONG;
typedef char*STRPTR;
#define EXEC_TYPES_H 1 
#endif

#define STRINGARRAY 1 
#define get_string(n) AppStrings[n].as_Str 

#include "cweb.h"

/*:89*//*92:*/
#line 1541 "common.ch"

#ifdef _AMIGA
#include <exec/types.h>
#include <libraries/dos.h>
#include <clib/alib_protos.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>
#include <pragmas/exec_pragmas.h>
#include <pragmas/dos_pragmas.h>

#include <string.h>
#include <dos.h>

#include <rexx/rxslib.h>
#include <rexx/errors.h>
#endif

/*:92*/
#line 161 "common.ch"

/*88:*/
#line 1462 "common.ch"

#ifdef __TURBOC__
#define HUGE huge
#else
#define HUGE
#endif


/*:88*/
#line 162 "common.ch"

#line 59 "common.w"
#define ctangle 0
#define cweave 1 \

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
#define or_or 037
#define dot_dot_dot 016
#define colon_colon 06
#define period_ast 026
#define minus_gt_ast 027 \

#define buf_size 100
#define long_buf_size 500
#define xisspace(c) (isspace(c) &&((unsigned char) c<0200) ) 
#define xisupper(c) (isupper(c) &&((unsigned char) c<0200) )  \

#define max_include_depth 10 \
 \

#define max_file_name_length 256 \

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

#define max_sections 2000 \
 \

#define too_long() {include_depth--; \
err_print(get_string(MSG_ERROR_CO22) ) ;goto restart;} \

#define max_bytes 90000 \

#define max_names 4000 \
 \

#define length(c) (size_t) ((c+1) ->byte_start-(c) ->byte_start)  \

#define print_id(c) term_write((c) ->byte_start,length((c) ) )  \

#define alloc_object(object,size,type)  \
if(!(object= (type*) calloc(size,sizeof(type) ) ) )  \
fatal("",get_string(MSG_FATAL_CO85) ) ; \

#define hash_size 353 \

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
 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless) history= harmless_message;}
#define mark_error history= error_message \

#define RETURN_OK 0
#define RETURN_WARN 5
#define RETURN_ERROR 10
#define RETURN_FAIL 20 \

#define confusion(s) fatal(get_string(MSG_FATAL_CO66) ,s)  \
 \

#define show_banner flags['b']
#define show_progress flags['p']
#define show_stats flags['s']
#define show_happiness flags['h']
#define use_amiga_keywords flags['a']
#define use_german_macros flags['g']
#define indent_param_decl flags['i']
#define send_error_messages flags['m']
#define order_decl_stmt flags['o'] \

#define update_terminal fflush(stdout)  \

#define new_line putchar('\n') 
#define putxchar putchar
#define term_write(a,b) fflush(stdout) ,fwrite(a,sizeof(char) ,b,stdout) 
#define C_printf(c,a) fprintf(C_file,c,a) 
#define C_putc(c) putc(c,C_file)  \
 \

#define max_path_length 4095 \


#line 59 "common.w"

/*2:*/
#line 72 "common.w"

typedef short boolean;
boolean program;

/*:2*//*7:*/
#line 157 "common.w"

#line 197 "common.ch"
char*buffer;
char*buffer_end;
char*limit;
char*loc;
#line 162 "common.w"

/*:7*//*10:*/
#line 212 "common.w"

int include_depth;
#line 236 "common.ch"
FILE**file;
FILE*change_file;
char**file_name;
char*change_file_name;
char*alt_web_file_name;
int*line;
#line 221 "common.w"
int change_line;
int change_depth;
boolean input_has_ended;
boolean changing;
boolean web_file_open= 0;

/*:10*//*20:*/
#line 416 "common.w"

#line 360 "common.ch"
typedef unsigned char eight_bits;
typedef unsigned short sixteen_bits;
#line 418 "common.w"
sixteen_bits section_count;
#line 368 "common.ch"
boolean*changed_section;
#line 420 "common.w"
boolean change_pending;

boolean print_where= 0;

/*:20*//*27:*/
#line 586 "common.w"

typedef struct name_info{
#line 549 "common.ch"
char HUGE*byte_start;
#line 589 "common.w"
/*31:*/
#line 623 "common.w"

#line 622 "common.ch"
struct name_info HUGE*link;
#line 625 "common.w"

/*:31*//*40:*/
#line 722 "common.w"

union{
#line 702 "common.ch"
struct name_info HUGE*Rlink;

#line 726 "common.w"
char Ilk;
}dummy;

/*:40*//*55:*/
#line 990 "common.ch"

#line 991 "common.ch"
void HUGE*equiv_or_xref;
#line 1056 "common.w"

/*:55*/
#line 589 "common.w"

}name_info;
#line 560 "common.ch"
typedef name_info HUGE*name_pointer;
char HUGE*byte_mem;
char HUGE*byte_mem_end;
name_info HUGE*name_dir;
name_pointer name_dir_end;
#line 596 "common.w"

/*:27*//*29:*/
#line 609 "common.w"

name_pointer name_ptr;
#line 578 "common.ch"
char HUGE*byte_ptr;
#line 612 "common.w"

#line 586 "common.ch"
/*:29*//*32:*/
#line 636 "common.w"

typedef name_pointer*hash_pointer;
#line 630 "common.ch"
name_pointer*hash;
hash_pointer hash_end;
#line 640 "common.w"
hash_pointer h;

#line 639 "common.ch"
/*:32*//*56:*/
#line 1074 "common.w"

int history= spotless;

/*:56*//*67:*/
#line 1212 "common.w"

int argc;
char**argv;
#line 1229 "common.ch"
char*C_file_name;
char*tex_file_name;
char*idx_file_name;
char*scn_file_name;
boolean flags[256];
#line 1220 "common.w"

/*:67*//*77:*/
#line 1366 "common.w"

FILE*C_file;
FILE*tex_file;
FILE*idx_file;
FILE*scn_file;
FILE*active_file;

/*:77*/
#line 60 "common.w"

/*3:*/
#line 82 "common.w"
int phase;

/*:3*//*11:*/
#line 238 "common.w"

#line 257 "common.ch"
char*change_buffer;
#line 240 "common.w"
char*change_limit;

/*:11*//*83:*/
#line 1415 "common.ch"

char*include_path;
char*p,*path_prefix,*next_path_prefix;

/*:83*//*93:*/
#line 1563 "common.ch"

#ifdef _AMIGA
extern struct ExecBase*SysBase;
extern struct DOSBase*DOSBase;

STRPTR CreateArgstring(STRPTR,long);
void DeleteArgstring(STRPTR);
struct RexxMsg*CreateRexxMsg(struct MsgPort*,STRPTR,STRPTR);
void DeleteRexxMsg(struct RexxMsg*);

long result= 20;
char msg_string[BUFSIZ];
char pth_buffer[BUFSIZ];
char cur_buffer[BUFSIZ];

struct RexxMsg*rm;
struct MsgPort*rp;

#pragma libcall RexxSysBase CreateArgstring 7e 0802
#pragma libcall RexxSysBase DeleteArgstring 84 801
#pragma libcall RexxSysBase CreateRexxMsg   90 09803
#pragma libcall RexxSysBase DeleteRexxMsg   96 801

#define MSGPORT  "SC_SCMSG"
#define PORTNAME "CWEBPORT"
#define RXEXTENS "rexx"

struct RxsLib*RexxSysBase= NULL;
#endif

/*:93*/
#line 61 "common.w"

/*33:*/
#line 639 "common.ch"

extern int names_match(name_pointer,char*,int,eight_bits);
#line 644 "common.w"

/*:33*//*38:*/
#line 685 "common.ch"

#line 686 "common.ch"
extern void init_p(name_pointer,eight_bits);
#line 697 "common.w"

/*:38*//*46:*/
#line 798 "common.ch"

#line 799 "common.ch"
extern void init_node(name_pointer);
#line 846 "common.w"

/*:46*//*53:*/
#line 942 "common.ch"

static int section_name_cmp(char**,int,name_pointer);
#line 1011 "common.w"

/*:53*//*57:*/
#line 1003 "common.ch"

#line 1004 "common.ch"
extern void err_print(char*);
#line 1086 "common.w"

/*:57*//*60:*/
#line 1045 "common.ch"

#line 1046 "common.ch"
extern int wrap_up(void);
extern void print_stats(void);
#line 1135 "common.w"

#line 1068 "common.ch"
/*:60*//*63:*/
#line 1139 "common.ch"

#line 1140 "common.ch"
extern void fatal(char*,char*);
extern void overflow(char*);
#line 1167 "common.w"

/*:63*//*69:*/
#line 1265 "common.ch"

#line 1266 "common.ch"
static void scan_args(void);
#line 1245 "common.w"

/*:69*//*85:*/
#line 1437 "common.ch"

#ifdef __TURBOC__
extern void far*allocsafe(unsigned long,unsigned long);
#endif


/*:85*//*96:*/
#line 1684 "common.ch"

#ifdef _AMIGA
static int PutRexxMsg(struct MsgPort*,long,STRPTR,struct RexxMsg*);
int __stdargs call_rexx(char*,long*);
#endif

/*:96*//*102:*/
#line 1795 "common.ch"

int get_line(void);
name_pointer add_section_name(name_pointer,int,char*,char*,int);
name_pointer id_lookup(char*,char*,char);
name_pointer section_lookup(char*,char*,int);
void check_complete(void);
void common_init(void);
void extend_section_name(name_pointer,char*,char*,int);
void print_prefix_name(name_pointer);
void print_section_name(name_pointer);
void reset_input(void);
void sprint_section_name(char*,name_pointer);

/*:102*//*103:*/
#line 1810 "common.ch"

static boolean set_path(char*,char*);
static int input_ln(FILE*);
static int web_strcmp(char HUGE*,int,char HUGE*,int);
static void check_change(void);
static void prime_the_change_buffer(void);

/*:103*/
#line 62 "common.w"


/*:1*//*4:*/
#line 88 "common.w"

#line 175 "common.ch"
void common_init(void)
{
/*30:*/
#line 592 "common.ch"

alloc_object(buffer,long_buf_size,char);
buffer_end= buffer+buf_size-2;
limit= loc= buffer;
alloc_object(file,max_include_depth,FILE*);
alloc_object(file_name,max_include_depth,char*);
for(phase= 0;phase<max_include_depth;phase++)
alloc_object(file_name[phase],max_file_name_length,char);
alloc_object(change_file_name,max_file_name_length,char);
alloc_object(alt_web_file_name,max_file_name_length,char);
alloc_object(line,max_include_depth,int);
alloc_object(change_buffer,buf_size,char);
alloc_object(changed_section,max_sections,boolean);
#ifdef __TURBOC__
byte_mem= allocsafe(max_bytes,sizeof(*byte_mem));
name_dir= allocsafe(max_names,sizeof(*name_dir));
#else
alloc_object(byte_mem,max_bytes,char);
alloc_object(name_dir,max_names,name_info);
#endif
byte_mem_end= byte_mem+max_bytes-1;
name_dir_end= name_dir+max_names-1;
name_dir->byte_start= byte_ptr= byte_mem;

#line 615 "common.w"
name_ptr= name_dir+1;
name_ptr->byte_start= byte_mem;

/*:30*//*34:*/
#line 648 "common.ch"

#line 649 "common.ch"
alloc_object(hash,hash_size,name_pointer);
hash_end= hash+hash_size-1;
for(h= hash;h<=hash_end;*h++= NULL);
alloc_object(C_file_name,max_file_name_length,char);
alloc_object(tex_file_name,max_file_name_length,char);
alloc_object(idx_file_name,max_file_name_length,char);
alloc_object(scn_file_name,max_file_name_length,char);
#line 649 "common.w"

/*:34*//*41:*/
#line 729 "common.w"

root= NULL;

/*:41*//*84:*/
#line 1419 "common.ch"

alloc_object(include_path,max_path_length+1,char);
strcpy(include_path,CWEBINPUTS);

/*:84*/
#line 177 "common.ch"
;
/*90:*/
#line 1506 "common.ch"

#ifdef _AMIGA
if(LocaleBase= OpenLibrary("locale.library",38L)){
if(catalog= OpenCatalog(NULL,"cweb.catalog",
OC_BuiltInLanguage,"english",TAG_DONE)){
for(i= MSG_ERROR_CO9;i<=MSG_STATS_CW248_6;++i)
AppStrings[i].as_Str= GetCatalogStr(catalog,i,AppStrings[i].as_Str);
}
}
#endif

/*:90*/
#line 178 "common.ch"
;
/*68:*/
#line 1241 "common.ch"

#line 1242 "common.ch"
show_banner= show_happiness= show_progress= 1;
#ifdef _AMIGA
use_amiga_keywords= 
#endif
use_german_macros= indent_param_decl= order_decl_stmt= 1;

#line 1227 "common.w"

/*:68*/
#line 179 "common.ch"
;
/*78:*/
#line 1373 "common.w"

scan_args();
if(program==ctangle){
if((C_file= fopen(C_file_name,"w"))==NULL)
#line 1352 "common.ch"
fatal(get_string(MSG_FATAL_CO78),C_file_name);
#line 1378 "common.w"

}
else{
if((tex_file= fopen(tex_file_name,"w"))==NULL)
#line 1359 "common.ch"
fatal(get_string(MSG_FATAL_CO78),tex_file_name);
#line 1383 "common.w"
}

/*:78*/
#line 180 "common.ch"
;
}
#line 96 "common.w"

/*:4*//*9:*/
#line 170 "common.w"

#line 208 "common.ch"
static int input_ln(FILE*fp)

#line 173 "common.w"
{
register int c= EOF;
register char*k;
if(feof(fp))return(0);
limit= k= buffer;
while(k<=buffer_end&&(c= getc(fp))!=EOF&&c!='\n')
if((*(k++)= c)!=' ')limit= k;
if(k>buffer_end)
if((c= getc(fp))!=EOF&&c!='\n'){
#line 216 "common.ch"
ungetc(c,fp);loc= buffer;err_print(get_string(MSG_ERROR_CO9));
#line 183 "common.w"

}
if(c==EOF&&limit==buffer)return(0);

return(1);
}

/*:9*//*12:*/
#line 249 "common.w"

#line 265 "common.ch"
static void prime_the_change_buffer(void)
#line 252 "common.w"
{
change_limit= change_buffer;
/*13:*/
#line 263 "common.w"

while(1){
change_line++;
if(!input_ln(change_file))return;
if(limit<buffer+2)continue;
if(buffer[0]!='@')continue;
if(xisupper(buffer[1]))buffer[1]= tolower(buffer[1]);
if(buffer[1]=='x')break;
if(buffer[1]=='y'||buffer[1]=='z'||buffer[1]=='i'){
loc= buffer+2;
#line 272 "common.ch"
err_print(get_string(MSG_ERROR_CO13));
#line 274 "common.w"

}
}

/*:13*/
#line 254 "common.w"
;
/*14:*/
#line 280 "common.w"

do{
change_line++;
if(!input_ln(change_file)){
#line 279 "common.ch"
err_print(get_string(MSG_ERROR_CO14));
#line 285 "common.w"

return;
}
}while(limit==buffer);

/*:14*/
#line 255 "common.w"
;
/*15:*/
#line 290 "common.w"

{
#line 287 "common.ch"
change_limit= change_buffer+(ptrdiff_t)(limit-buffer);
strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
#line 294 "common.w"
}

/*:15*/
#line 256 "common.w"
;
}

/*:12*//*16:*/
#line 318 "common.w"

#line 296 "common.ch"
static void check_change(void)
#line 321 "common.w"
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
#line 303 "common.ch"
err_print(get_string(MSG_ERROR_CO16_1));
#line 333 "common.w"

change_limit= change_buffer;changing= 0;
return;
}
if(limit>buffer+1&&buffer[0]=='@'){
if(xisupper(buffer[1]))buffer[1]= tolower(buffer[1]);
/*17:*/
#line 356 "common.w"

if(buffer[1]=='x'||buffer[1]=='z'){
#line 317 "common.ch"
loc= buffer+2;err_print(get_string(MSG_ERROR_CO17_1));
#line 359 "common.w"

}
else if(buffer[1]=='y'){
if(n>0){
loc= buffer+2;
printf("\n! Hmm... %d ",n);
#line 324 "common.ch"
err_print(get_string(MSG_ERROR_CO17_2));
#line 366 "common.w"

}
change_depth= include_depth;
return;
}

/*:17*/
#line 340 "common.w"
;
}
/*15:*/
#line 290 "common.w"

{
#line 287 "common.ch"
change_limit= change_buffer+(ptrdiff_t)(limit-buffer);
strncpy(change_buffer,buffer,(size_t)(limit-buffer+1));
#line 294 "common.w"
}

/*:15*/
#line 342 "common.w"
;
changing= 0;cur_line++;
while(!input_ln(cur_file)){
if(include_depth==0){
#line 310 "common.ch"
err_print(get_string(MSG_ERROR_CO16_2));
#line 347 "common.w"

input_has_ended= 1;return;
}
include_depth--;cur_line++;
}
if(lines_dont_match)n++;
}
}

/*:16*//*18:*/
#line 376 "common.w"

#line 332 "common.ch"
void reset_input(void)
#line 379 "common.w"
{
limit= buffer;loc= buffer+1;buffer[0]= ' ';
/*19:*/
#line 391 "common.w"

if((web_file= fopen(web_file_name,"r"))==NULL){
strcpy(web_file_name,alt_web_file_name);
if((web_file= fopen(web_file_name,"r"))==NULL)
#line 339 "common.ch"
fatal(get_string(MSG_FATAL_CO19_1),web_file_name);
#line 396 "common.w"
}


web_file_open= 1;
#line 351 "common.ch"
/*97:*/
#line 1705 "common.ch"

#ifdef _AMIGA
if(send_error_messages){
Forbid();
if((rp= FindPort(MSGPORT))!=NULL);
Permit();

if(!rp){
strcpy(msg_string,"run <nil: >nil: scmsg ");
strcat(msg_string,getenv("SCMSGOPT"));
system(msg_string);
}

if(GetCurrentDirName(cur_buffer,BUFSIZ)&&
AddPart(cur_buffer,web_file_name,BUFSIZ)){
sprintf(msg_string,"newbld \"%s\"",cur_buffer);
call_rexx(msg_string,&result);
}
}
#endif

/*:97*/
#line 351 "common.ch"

if((change_file= fopen(change_file_name,"r"))==NULL)
fatal(get_string(MSG_FATAL_CO19_2),change_file_name);
#line 402 "common.w"

/*:19*/
#line 381 "common.w"
;
include_depth= 0;cur_line= 0;change_line= 0;
change_depth= include_depth;
changing= 1;prime_the_change_buffer();changing= !changing;
limit= buffer;loc= buffer+1;buffer[0]= ' ';input_has_ended= 0;
}

/*:18*//*21:*/
#line 424 "common.w"

#line 375 "common.ch"
int get_line(void)
#line 426 "common.w"
{
restart:
if(changing&&include_depth==change_depth)
/*25:*/
#line 529 "common.w"
{
change_line++;
if(!input_ln(change_file)){
#line 514 "common.ch"
err_print(get_string(MSG_ERROR_CO25_1));
#line 533 "common.w"

buffer[0]= '@';buffer[1]= 'z';limit= buffer+2;
}
if(limit>buffer){
if(change_pending){
if_section_start_make_pending(0);
if(change_pending){
changed_section[section_count]= 1;change_pending= 0;
}
}
*limit= ' ';
if(buffer[0]=='@'){
if(xisupper(buffer[1]))buffer[1]= tolower(buffer[1]);
if(buffer[1]=='x'||buffer[1]=='y'){
loc= buffer+2;
#line 521 "common.ch"
err_print(get_string(MSG_ERROR_CO25_2));
#line 549 "common.w"

}
else if(buffer[1]=='z'){
prime_the_change_buffer();changing= !changing;print_where= 1;
}
}
}
}

/*:25*/
#line 429 "common.w"
;
if(!changing||include_depth>change_depth){
/*24:*/
#line 512 "common.w"
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
if(change_limit>change_buffer)check_change();
}

/*:24*/
#line 431 "common.w"
;
if(changing&&include_depth==change_depth)goto restart;
}
loc= buffer;*limit= ' ';
if(*buffer=='@'&&(*(buffer+1)=='i'||*(buffer+1)=='I')){
loc= buffer+2;
while(loc<=limit&&(*loc==' '||*loc=='\t'||*loc=='"'))loc++;
if(loc>=limit){
#line 382 "common.ch"
err_print(get_string(MSG_ERROR_CO21_1));
#line 440 "common.w"

goto restart;
}
if(include_depth>=max_include_depth-1){
#line 389 "common.ch"
err_print(get_string(MSG_ERROR_CO21_2));
#line 445 "common.w"

goto restart;
}
include_depth++;
/*23:*/
#line 471 "common.w"
{
char temp_file_name[max_file_name_length];
char*cur_file_name_end= cur_file_name+max_file_name_length-1;
char*k= cur_file_name,*kk;
int l;

while(*loc!=' '&&*loc!='\t'&&*loc!='"'&&k<=cur_file_name_end)*k++= *loc++;
if(k>cur_file_name_end)too_long();

*k= '\0';
if((cur_file= fopen(cur_file_name,"r"))!=NULL){
cur_line= 0;print_where= 1;
goto restart;
}
#line 480 "common.ch"
if(0==set_path(include_path,getenv("CWEBINPUTS"))){
include_depth--;goto restart;
}
path_prefix= include_path;
while(path_prefix){
for(kk= temp_file_name,p= path_prefix,l= 0;
p&&*p&&*p!=PATH_SEPARATOR;
*kk++= *p++,l++);
if(path_prefix&&*path_prefix&&*path_prefix!=PATH_SEPARATOR&&
*--p!=DEVICE_SEPARATOR&&*p!=DIR_SEPARATOR){
*kk++= DIR_SEPARATOR;l++;
}
if(k+l+2>=cur_file_name_end)too_long();
strcpy(kk,cur_file_name);
if(cur_file= fopen(temp_file_name,"r")){
cur_line= 0;print_where= 1;goto restart;
}
if(next_path_prefix= strchr(path_prefix,PATH_SEPARATOR))
path_prefix= next_path_prefix+1;
else break;
}
#line 507 "common.ch"
include_depth--;err_print(get_string(MSG_ERROR_CO23));goto restart;
#line 510 "common.w"
}

/*:23*/
#line 449 "common.w"
;
}
return(!input_has_ended);
}

#line 412 "common.ch"
/*:21*//*26:*/
#line 561 "common.w"

#line 532 "common.ch"
void check_complete(void){
if(change_limit!=change_buffer){
strncpy(buffer,change_buffer,(size_t)(change_limit-change_buffer+1));
limit= buffer+(ptrdiff_t)(change_limit-change_buffer);
#line 567 "common.w"
changing= 1;change_depth= include_depth;loc= buffer;
#line 542 "common.ch"
err_print(get_string(MSG_ERROR_CO26));
#line 569 "common.w"

}
}

/*:26*//*35:*/
#line 652 "common.w"

#line 666 "common.ch"
name_pointer id_lookup(char*first,char*last,char t)




#line 658 "common.w"
{
char*i= first;
int h;
int l;
name_pointer p;
if(last==NULL)for(last= first;*last!='\0';last++);
#line 677 "common.ch"
l= (int)(last-first);
#line 665 "common.w"
/*36:*/
#line 675 "common.w"

h= (unsigned char)*i;
while(++i<last)h= (h+h+(int)((unsigned char)*i))%hash_size;


/*:36*/
#line 665 "common.w"
;
/*37:*/
#line 683 "common.w"

p= hash[h];
while(p&&!names_match(p,first,l,t))p= p->link;
if(p==NULL){
p= name_ptr;
p->link= hash[h];hash[h]= p;
}

/*:37*/
#line 666 "common.w"
;
if(p==name_ptr)/*39:*/
#line 698 "common.w"
{
#line 694 "common.ch"
if(byte_ptr+l>byte_mem_end)overflow(get_string(MSG_OVERFLOW_CO39_1));
if(name_ptr>=name_dir_end)overflow(get_string(MSG_OVERFLOW_CO39_2));
#line 701 "common.w"
strncpy(byte_ptr,first,l);
(++name_ptr)->byte_start= byte_ptr+= l;
if(program==cweave)init_p(p,t);
}

/*:39*/
#line 667 "common.w"
;
return(p);
}

/*:35*//*42:*/
#line 756 "common.w"

#line 711 "common.ch"
void print_section_name(name_pointer p)
#line 760 "common.w"
{
#line 718 "common.ch"
char HUGE*ss;
char HUGE*s= first_chunk(p);
#line 762 "common.w"
name_pointer q= p+1;
while(p!=name_dir){
ss= (p+1)->byte_start-1;
if(*ss==' '&&ss>=s){
#line 728 "common.ch"
term_write(s,(size_t)(ss-s));p= q->link;q= p;
}else{
term_write(s,(size_t)(ss+1-s));p= name_dir;q= NULL;
#line 769 "common.w"
}
s= p->byte_start;
}
if(q)term_write("...",3);
}

/*:42*//*43:*/
#line 775 "common.w"

#line 740 "common.ch"
void sprint_section_name(char*dest,name_pointer p)
#line 780 "common.w"
{
#line 747 "common.ch"
char HUGE*ss;
char HUGE*s= first_chunk(p);
#line 782 "common.w"
name_pointer q= p+1;
while(p!=name_dir){
ss= (p+1)->byte_start-1;
if(*ss==' '&&ss>=s){
p= q->link;q= p;
}else{
ss++;p= name_dir;
}
#line 755 "common.ch"
strncpy(dest,s,(size_t)(ss-s)),dest+= ss-s;
#line 791 "common.w"
s= p->byte_start;
}
*dest= '\0';
}

/*:43*//*44:*/
#line 796 "common.w"

#line 764 "common.ch"
void print_prefix_name(name_pointer p)
#line 800 "common.w"
{
#line 771 "common.ch"
char HUGE*s= first_chunk(p);
#line 802 "common.w"
int l= prefix_length(p);
term_write(s,l);
if(s+l<(p+1)->byte_start)term_write("...",3);
}

/*:44*//*45:*/
#line 817 "common.w"

#line 782 "common.ch"
static int web_strcmp(char HUGE*j,int j_len,char HUGE*k,int k_len)





{
char HUGE*j1= j+j_len;
char HUGE*k1= k+k_len;
#line 823 "common.w"
while(k<k1&&j<j1&&*j==*k)k++,j++;
if(k==k1)if(j==j1)return equal;
else return extension;
else if(j==j1)return prefix;
else if(*j<*k)return less;
else return greater;
}

/*:45*//*47:*/
#line 847 "common.w"

#line 812 "common.ch"
name_pointer add_section_name(name_pointer par,int c,
char*first,char*last,int ispref)






#line 855 "common.w"
{
name_pointer p= name_ptr;
#line 829 "common.ch"
char HUGE*s= first_chunk(p);
int name_len= (int)(last-first)+ispref;
if(s+name_len>byte_mem_end)overflow(get_string(MSG_OVERFLOW_CO39_1));
if(name_ptr+1>=name_dir_end)overflow(get_string(MSG_OVERFLOW_CO39_2));
#line 861 "common.w"
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
#line 876 "common.w"

#line 844 "common.ch"
void extend_section_name(name_pointer p,char*first,char*last,int ispref)




#line 883 "common.w"
{
#line 858 "common.ch"
char HUGE*s;
name_pointer q= p+1;
int name_len= (int)(last-first)+ispref;
if(name_ptr>=name_dir_end)overflow(get_string(MSG_OVERFLOW_CO39_2));
#line 888 "common.w"
while(q->link!=name_dir)q= q->link;
q->link= name_ptr;
s= name_ptr->byte_start;
name_ptr->link= name_dir;
#line 868 "common.ch"
if(s+name_len>byte_mem_end)overflow(get_string(MSG_OVERFLOW_CO39_1));
#line 893 "common.w"
(++name_ptr)->byte_start= byte_ptr= s+name_len;
strncpy(s,first,name_len);
if(ispref)*(byte_ptr-1)= ' ';
}

/*:48*//*49:*/
#line 904 "common.w"

#line 884 "common.ch"
name_pointer section_lookup(char*first,char*last,int ispref)



#line 909 "common.w"
{
int c= 0;
name_pointer p= root;
name_pointer q= NULL;
name_pointer r= NULL;
name_pointer par= NULL;

#line 894 "common.ch"
int name_len= (int)(last-first)+1;
#line 917 "common.w"
/*50:*/
#line 928 "common.w"

while(p){
c= web_strcmp(first,name_len,first_chunk(p),prefix_length(p));
if(c==less||c==greater){
if(r==NULL)
par= p;
p= (c==less?p->llink:p->rlink);
}else{
if(r!=NULL){
#line 904 "common.ch"
printf(get_string(MSG_ERROR_CO50_1));

print_prefix_name(p);
printf(get_string(MSG_ERROR_CO50_2));
#line 941 "common.w"
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
#line 918 "common.w"
;
/*51:*/
#line 953 "common.w"

if(r==NULL)
return add_section_name(par,c,first,last+1,ispref);

/*:51*/
#line 919 "common.w"
;
/*52:*/
#line 961 "common.w"

switch(section_name_cmp(&first,name_len,r)){

case prefix:
if(!ispref){
#line 914 "common.ch"
printf(get_string(MSG_ERROR_CO52_1));
#line 967 "common.w"

print_section_name(r);
err_print(">");
}
else if(name_len<prefix_length(r))set_prefix_length(r,name_len);

case equal:return r;
case extension:if(!ispref||first<=last)
extend_section_name(r,first,last+1,ispref);
return r;
case bad_extension:
#line 921 "common.ch"
printf(get_string(MSG_ERROR_CO52_2));
#line 979 "common.w"

print_section_name(r);
err_print(">");
return r;
default:
#line 931 "common.ch"
printf(get_string(MSG_ERROR_CO52_3));

print_prefix_name(r);
printf(get_string(MSG_ERROR_CO52_4));
#line 988 "common.w"
print_section_name(r);
err_print(">");
return r;
}

/*:52*/
#line 920 "common.w"
;
}

/*:49*//*54:*/
#line 1012 "common.w"

#line 953 "common.ch"
static int section_name_cmp(char**pfirst,int len,name_pointer r)



#line 1017 "common.w"
{
char*first= *pfirst;
name_pointer q= r+1;
#line 963 "common.ch"
char HUGE*ss;
char HUGE*s= first_chunk(r);
#line 1021 "common.w"
int c;
int ispref;
while(1){
ss= (r+1)->byte_start-1;
if(*ss==' '&&ss>=r->byte_start)ispref= 1,q= q->link;
else ispref= 0,ss++,q= name_dir;
switch(c= web_strcmp(first,len,s,ss-s)){
case equal:if(q==name_dir)
if(ispref){
#line 971 "common.ch"
*pfirst= first+(ptrdiff_t)(ss-s);
#line 1031 "common.w"
return extension;
}else return equal;
else return(q->byte_start==(q+1)->byte_start)?equal:prefix;
case extension:
if(!ispref)return bad_extension;
first+= ss-s;
#line 978 "common.ch"
if(q!=name_dir){len-= (int)(ss-s);s= q->byte_start;r= q;continue;}
#line 1038 "common.w"
*pfirst= first;return extension;
default:return c;
}
}
}

/*:54*//*58:*/
#line 1087 "common.w"

#line 1013 "common.ch"
void err_print(char*s)
#line 1091 "common.w"
{
char*k,*l;
printf(*s=='!'?"\n%s":"%s",s);
if(web_file_open)/*59:*/
#line 1107 "common.w"

#line 1023 "common.ch"
{if(changing&&include_depth==change_depth){
printf(get_string(MSG_ERROR_CO59_1),change_line);
/*98:*/
#line 1736 "common.ch"

#ifdef _AMIGA
if(send_error_messages){
if(GetCurrentDirName(cur_buffer,BUFSIZ)&&
AddPart(cur_buffer,web_file_name,BUFSIZ)&&
GetCurrentDirName(pth_buffer,BUFSIZ)&&
AddPart(pth_buffer,change_file_name,BUFSIZ))
sprintf(msg_string,"newmsg \"%s\" \"%s\" %d 0 \"\" 0 Error 997 %s",
cur_buffer,pth_buffer,change_line,s);
}
#endif

/*:98*/
#line 1025 "common.ch"

}
else if(include_depth==0){
printf(get_string(MSG_ERROR_CO59_2),cur_line);
/*99:*/
#line 1752 "common.ch"

#ifdef _AMIGA
if(send_error_messages){
if(GetCurrentDirName(cur_buffer,BUFSIZ)&&
AddPart(cur_buffer,cur_file_name,BUFSIZ))
sprintf(msg_string,"newmsg \"%s\" \"%s\" %d 0 \"\" 0 Error 998 %s",
cur_buffer,cur_buffer,cur_line,s);
}
#endif

/*:99*/
#line 1029 "common.ch"

}
else{
printf(get_string(MSG_ERROR_CO59_3),cur_line,cur_file_name);
/*100:*/
#line 1767 "common.ch"

#ifdef _AMIGA
if(send_error_messages){
strcpy(msg_string,"\0");
if(GetCurrentDirName(cur_buffer,BUFSIZ)&&
AddPart(cur_buffer,cur_file_name,BUFSIZ)&&
GetCurrentDirName(pth_buffer,BUFSIZ)&&
AddPart(pth_buffer,web_file_name,BUFSIZ))
sprintf(msg_string,"newmsg \"%s\" \"%s\" %d 0 \"\" 0 Error 999 %s",
pth_buffer,cur_buffer,cur_line,s);
}
#endif

/*:100*/
#line 1033 "common.ch"

}

/*101:*/
#line 1785 "common.ch"

#ifdef _AMIGA
if(send_error_messages&&msg_string)
call_rexx(msg_string,&result);
#endif

/*:101*/
#line 1036 "common.ch"

#line 1112 "common.w"
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

/*:59*/
#line 1094 "common.w"
;
update_terminal;mark_error;
}

/*:58*//*61:*/
#line 1082 "common.ch"

#ifndef __TURBOC__
int wrap_up(void){
putchar('\n');
if(show_stats)print_stats();
/*62:*/
#line 1152 "common.w"

switch(history){
#line 1124 "common.ch"
case spotless:
if(show_happiness)printf(get_string(MSG_HAPPINESS_CO62));break;
case harmless_message:
printf(get_string(MSG_WARNING_CO62));break;
case error_message:
printf(get_string(MSG_ERROR_CO62));break;
case fatal_message:
printf(get_string(MSG_FATAL_CO62));
#line 1160 "common.w"
}

/*:62*/
#line 1087 "common.ch"
;
/*91:*/
#line 1521 "common.ch"

#ifdef _AMIGA
if(LocaleBase){
CloseCatalog(catalog);
CloseLibrary(LocaleBase);
}
#endif

/*:91*/
#line 1088 "common.ch"
;
switch(history){
case harmless_message:return(RETURN_WARN);break;
case error_message:return(RETURN_ERROR);break;
case fatal_message:return(RETURN_FAIL);break;
default:return(RETURN_OK);
}
}
#else
int wrap_up(void){
int return_val;

putchar('\n');
if(show_stats)print_stats();
/*62:*/
#line 1152 "common.w"

switch(history){
#line 1124 "common.ch"
case spotless:
if(show_happiness)printf(get_string(MSG_HAPPINESS_CO62));break;
case harmless_message:
printf(get_string(MSG_WARNING_CO62));break;
case error_message:
printf(get_string(MSG_ERROR_CO62));break;
case fatal_message:
printf(get_string(MSG_FATAL_CO62));
#line 1160 "common.w"
}

/*:62*/
#line 1102 "common.ch"
;
/*91:*/
#line 1521 "common.ch"

#ifdef _AMIGA
if(LocaleBase){
CloseCatalog(catalog);
CloseLibrary(LocaleBase);
}
#endif

/*:91*/
#line 1103 "common.ch"
;
switch(history){
case harmless_message:return_val= RETURN_WARN;break;
case error_message:return_val= RETURN_ERROR;break;
case fatal_message:return_val= RETURN_FAIL;break;
default:return_val= RETURN_OK;
}
return(return_val);
}
#endif
#line 1151 "common.w"

/*:61*//*64:*/
#line 1150 "common.ch"
void fatal(char*s,char*t)
#line 1174 "common.w"
{
if(*s)printf(s);
err_print(t);
history= fatal_message;exit(wrap_up());
}

/*:64*//*65:*/
#line 1159 "common.ch"
void overflow(char*t)
#line 1185 "common.w"
{
#line 1166 "common.ch"
printf(get_string(MSG_FATAL_CO65),t);fatal("","");
#line 1187 "common.w"
}


/*:65*//*70:*/
#line 1246 "common.w"

#line 1274 "common.ch"
static void scan_args(void)
#line 1249 "common.w"
{
char*dot_pos;
char*name_pos;
register char*s;
boolean found_web= 0,found_change= 0,found_out= 0;

boolean flag_change;

while(--argc>0){
if((**(++argv)=='-'||**argv=='+')&&*(*argv+1))/*74:*/
#line 1340 "common.w"

{
if(**argv=='-')flag_change= 0;
else flag_change= 1;
for(dot_pos= *argv+1;*dot_pos>'\0';dot_pos++)
flags[*dot_pos]= flag_change;
}

/*:74*/
#line 1258 "common.w"

else{
s= name_pos= *argv;dot_pos= NULL;
#line 1285 "common.ch"
while(*s){
if(*s=='.')dot_pos= s++;
#ifdef _AMIGA
else if((*s==DIR_SEPARATOR)||(*s==DEVICE_SEPARATOR))dot_pos= NULL,name_pos= ++s;
#else
else if(*s==DIR_SEPARATOR)dot_pos= NULL,name_pos= ++s;
#endif
else s++;
}

#line 1266 "common.w"
if(!found_web)/*71:*/
#line 1284 "common.w"

{
if(s-*argv>max_file_name_length-5)
/*76:*/
#line 1345 "common.ch"
fatal(get_string(MSG_FATAL_CO76),*argv);
#line 1361 "common.w"


/*:76*/
#line 1287 "common.w"
;
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
#line 1267 "common.w"

else if(!found_change)/*72:*/
#line 1302 "common.w"

{
if(strcmp(*argv,"-")==0)found_change= -1;
else{
if(s-*argv>max_file_name_length-4)
/*76:*/
#line 1345 "common.ch"
fatal(get_string(MSG_FATAL_CO76),*argv);
#line 1361 "common.w"


/*:76*/
#line 1307 "common.w"
;
if(dot_pos==NULL)
sprintf(change_file_name,"%s.ch",*argv);
else strcpy(change_file_name,*argv);
found_change= 1;
}
}

/*:72*/
#line 1268 "common.w"

else if(!found_out)/*73:*/
#line 1315 "common.w"

{
if(s-*argv>max_file_name_length-5)
/*76:*/
#line 1345 "common.ch"
fatal(get_string(MSG_FATAL_CO76),*argv);
#line 1361 "common.w"


/*:76*/
#line 1318 "common.w"
;
if(dot_pos==NULL){
sprintf(tex_file_name,"%s.tex",*argv);
sprintf(idx_file_name,"%s.idx",*argv);
sprintf(scn_file_name,"%s.scn",*argv);
sprintf(C_file_name,"%s.c",*argv);
}else{
strcpy(tex_file_name,*argv);
if(flags['x']){
if(program==cweave&&strcmp(*argv+strlen(*argv)-4,".tex")!=0)
#line 1317 "common.ch"
fatal(get_string(MSG_FATAL_CO73),*argv);
#line 1329 "common.w"

strcpy(idx_file_name,*argv);
strcpy(idx_file_name+strlen(*argv)-4,".idx");
strcpy(scn_file_name,*argv);
strcpy(scn_file_name+strlen(*argv)-4,".scn");
}
strcpy(C_file_name,*argv);
}
found_out= 1;
}

/*:73*/
#line 1269 "common.w"

else/*75:*/
#line 1348 "common.w"

{
if(program==ctangle)
#line 1331 "common.ch"
fatal(get_string(MSG_FATAL_CO75_1),"");

#ifdef _AMIGA
else fatal(get_string(MSG_FATAL_CO75_2),"");
#else
else fatal(get_string(MSG_FATAL_CO75_3),"");
#endif

#line 1358 "common.w"
}

#line 1345 "common.ch"
/*:75*/
#line 1270 "common.w"
;
}
}
if(!found_web)/*75:*/
#line 1348 "common.w"

{
if(program==ctangle)
#line 1331 "common.ch"
fatal(get_string(MSG_FATAL_CO75_1),"");

#ifdef _AMIGA
else fatal(get_string(MSG_FATAL_CO75_2),"");
#else
else fatal(get_string(MSG_FATAL_CO75_3),"");
#endif

#line 1358 "common.w"
}

#line 1345 "common.ch"
/*:75*/
#line 1273 "common.w"
;
#line 1301 "common.ch"
#if defined( _AMIGA )
if(found_change<=0)strcpy(change_file_name,"NIL:");
#else
#if defined( __TURBOC__ )
if(found_change<=0)strcpy(change_file_name,"nul");
#else
if(found_change<=0)strcpy(change_file_name,"/dev/null");
#endif
#endif

#line 1275 "common.w"
}

/*:70*//*82:*/
#line 1394 "common.ch"

static boolean set_path(char*ptr,char*override)
{
if(override){
if(strlen(override)>=max_path_length){
err_print("! Include path too long");return(0);

}
else strcpy(ptr,override);
}
return(1);
}

/*:82*//*86:*/
#line 1443 "common.ch"

#ifdef __TURBOC__
void far*allocsafe(unsigned long nunits,unsigned long unitsz)
{
void far*p= farcalloc(nunits,unitsz);
if(p==NULL)fatal("",get_string(MSG_FATAL_CO85));

return p;
}
#endif


/*:86*//*94:*/
#line 1597 "common.ch"

#ifdef _AMIGA
static int PutRexxMsg(struct MsgPort*mp,long action,STRPTR arg0,
struct RexxMsg*arg1)
{
if((rm= CreateRexxMsg(mp,RXEXTENS,mp->mp_Node.ln_Name))!=NULL){
rm->rm_Action= action;
rm->rm_Args[0]= arg0;
rm->rm_Args[1]= (STRPTR)arg1;

Forbid();
if((rp= FindPort(MSGPORT))!=NULL)
PutMsg(rp,(struct Message*)rm);
Permit();

if(rp==NULL)
DeleteRexxMsg(rm);
}
return(rm!=NULL&&rp!=NULL);
}
#endif

/*:94*//*95:*/
#line 1624 "common.ch"

#ifdef _AMIGA
int __stdargs call_rexx(char*str,long*result)
{
char*arg;
struct MsgPort*mp;
struct RexxMsg*rm,*rm2;
int ret= FALSE;
int pend;

if(!(RexxSysBase= (struct RxsLib*)OpenLibrary(RXSNAME,0)))
return(ret);

Forbid();
if(FindPort(PORTNAME)==NULL)
mp= CreatePort(PORTNAME,0);
Permit();

if(mp!=NULL){
if((arg= CreateArgstring(str,strlen(str)))!=NULL){
if(PutRexxMsg(mp,RXCOMM|RXFF_STRING,arg,NULL)){

for(pend= 1;pend!=0;)
if(WaitPort(mp)!=NULL)
while((rm= (struct RexxMsg*)GetMsg(mp))!=NULL)
if(rm->rm_Node.mn_Node.ln_Type==NT_REPLYMSG){
ret= TRUE;
*result= rm->rm_Result1;
if((rm2= (struct RexxMsg*)rm->rm_Args[1])!=NULL){
rm2->rm_Result1= rm->rm_Result1;
rm2->rm_Result2= 0;
ReplyMsg((struct Message*)rm2);
}
DeleteRexxMsg(rm);
pend--;
}
else{
rm->rm_Result2= 0;
if(PutRexxMsg(mp,rm->rm_Action,rm->rm_Args[0],rm))
pend++;
else{
rm->rm_Result1= RC_FATAL;
ReplyMsg((struct Message*)rm);
}
}
}
DeleteArgstring(arg);
}
DeletePort(mp);
}

CloseLibrary((struct Library*)RexxSysBase);

return(ret);
}
#endif

/*:95*/
