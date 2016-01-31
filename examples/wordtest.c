#define MAX_LENGTH_DEFAULT 50
#define MAX_LENGTH_LIMIT 1000 \

#define PHICLONE 2654435769 \

#define NODES_PER_BLOCK 100
#define CHARS_PER_BLOCK 1000
#define out_of_mem(x) {fprintf(stderr,"%s: Memory exhausted!\n",*argv) ; \
return x;} \

/*3:*/
#line 92 "./wordtest.w"

#include <stdio.h> 
#include <stdlib.h> 

/*4:*/
#line 108 "./wordtest.w"

typedef unsigned char byte;

/*:4*//*9:*/
#line 196 "./wordtest.w"

typedef struct node_struct{
struct node_struct*left,*right;
byte*keyword;
unsigned long rank;
}node;

/*:9*//*20:*/
#line 392 "./wordtest.w"

typedef struct filenode_struct{
struct filenode_struct*link;
FILE*dfile;
byte buf[BUFSIZ+1],curword[MAX_LENGTH_LIMIT+1];
byte*pos;
byte*limit;
byte*endword;
}filenode;

/*:20*/
#line 96 "./wordtest.w"

int main(argc,argv)
int argc;
char*argv[];
{
/*5:*/
#line 111 "./wordtest.w"

int targc;
byte**targv;
unsigned delta;
unsigned max_length= MAX_LENGTH_DEFAULT;
byte breakchar;
int ord[256];
register int c;
register byte*u,*v;

/*:5*//*12:*/
#line 252 "./wordtest.w"

unsigned long current_rank= 0;

/*:12*//*16:*/
#line 310 "./wordtest.w"

node*next_node= NULL,*bad_node= NULL;
byte*next_string= NULL,*bad_string= NULL;
node*root= NULL;
byte*buffer;
int l;

/*:16*//*22:*/
#line 410 "./wordtest.w"

filenode*curfile;
filenode*f;

/*:22*/
#line 101 "./wordtest.w"
;
/*6:*/
#line 123 "./wordtest.w"

for(c= 0;c<256;c++)ord[c]= c;
delta= 0;
targc= argc-1;targv= (byte**)argv+1;
while(targc&&**targv=='-'){
/*7:*/
#line 140 "./wordtest.w"

switch((*targv)[1]){
case'a':for(c= delta,u= *targv+2;*u;u++)ord[*u]= ++c;break;
case'b':if((*targv)[2])for(u= *targv+2;*u;u++)ord[*u]= -1;
else for(c= 1;c<256;c++)ord[c]= -1;
break;
case'n':if((*targv)[2])for(u= *targv+2;*u;u++)ord[*u]= 0;
else for(c= 1;c<256;c++)ord[c]= 0;
break;
case'd':if(sscanf((char*)*targv+2,"%u",&delta)==1&&delta<256)break;
goto print_usage;
case'm':if(sscanf((char*)*targv+2,"%u",&max_length)==1&
max_length<=MAX_LENGTH_LIMIT)break;
goto print_usage;
default:print_usage:fprintf(stderr,
"Usage: %s {-{{a|b|n}string|{d|m}number}}* dictionaryname*\n",*argv);
return-1;
}

/*:7*/
#line 128 "./wordtest.w"
;
targc--;targv++;
}
if(ord['\n']<0)breakchar= '\n';
else{
breakchar= '\0';
for(c= 255;c;c--)if(ord[c]<0)breakchar= c;
if(!breakchar)/*8:*/
#line 159 "./wordtest.w"

{
ord['\n']= -1;
breakchar= '\n';
for(c= 1;c<=26;c++)ord['a'-1+c]= 'A'-1+c;
}

/*:8*/
#line 135 "./wordtest.w"
;
}
/*21:*/
#line 402 "./wordtest.w"

if(targc){
curfile= (filenode*)calloc(targc,sizeof(filenode));
if(curfile==NULL)out_of_mem(-7);
for(f= curfile;f<curfile+targc-1;f++)f->link= f+1;
f->link= curfile;
}else curfile= NULL;

/*:21*/
#line 137 "./wordtest.w"
;
for(;targc;targc--,targv++)/*23:*/
#line 414 "./wordtest.w"

{
curfile->dfile= fopen((char*)*targv,"r");
if(curfile->dfile==NULL){
fprintf(stderr,"%s: Can't open dictionary file %s!\n",*argv,(char*)*targv);
return-8;
}
curfile->pos= curfile->limit= curfile->buf;
curfile->buf[0]= '\0';
curfile->endword= curfile->curword;
curfile->curword[0]= breakchar;
curfile= curfile->link;
}

/*:23*/
#line 138 "./wordtest.w"
;

/*:6*/
#line 102 "./wordtest.w"
;
/*17:*/
#line 320 "./wordtest.w"

buffer= (byte*)malloc(max_length+1);
if(buffer==NULL)out_of_mem(-5);
while(1){
/*18:*/
#line 333 "./wordtest.w"

u= buffer;l= 0;
while(l<max_length){
c= getchar();
if(c==EOF){
if(ferror(stdin)){
fprintf(stderr,"%s: File read error on standard input!\n",*argv);
return-6;
}
goto done;
}
if(ord[c]<=0){
if(ord[c]<0)break;
}else{
*u++= (byte)c;
l++;
}
}
*u= breakchar;

/*:18*/
#line 324 "./wordtest.w"
;
if(l){
/*10:*/
#line 214 "./wordtest.w"

{register node*p= root;
while(p){
for(u= buffer,v= p->keyword;ord[*u]==ord[*v];u++,v++);
if(*v=='\0'&&*u==breakchar)goto found;
if(ord[*u]<ord[*v])p= p->left;
else p= p->right;
}
}

/*:10*/
#line 326 "./wordtest.w"
;
/*11:*/
#line 236 "./wordtest.w"

{register node*p,**q,**qq,*r;
current_rank+= PHICLONE;
p= root;q= &root;
while(p){
if(p->rank> current_rank)break;
for(u= buffer,v= p->keyword;ord[*u]==ord[*v];u++,v++);
if(ord[*u]<ord[*v])q= &(p->left),p= *q;
else q= &(p->right),p= *q;
}
/*14:*/
#line 286 "./wordtest.w"

if(next_node==bad_node){
next_node= (node*)calloc(NODES_PER_BLOCK,sizeof(node));
if(next_node==NULL)out_of_mem(-2);
bad_node= next_node+NODES_PER_BLOCK;
}
r= next_node++;
/*15:*/
#line 296 "./wordtest.w"

if(next_string+l+1>=bad_string){int block_size= CHARS_PER_BLOCK+l+1;
next_string= (byte*)malloc(block_size);
if(next_string==NULL)out_of_mem(-3);
bad_string= next_string+block_size;
}
r->keyword= next_string;
for(u= buffer,v= next_string;ord[*u]> 0;u++,v++)*v= *u;
*v= '\0';
next_string= v+1;

/*:15*/
#line 294 "./wordtest.w"
;

/*:14*/
#line 246 "./wordtest.w"
;
r->rank= current_rank;
*q= r;
/*13:*/
#line 260 "./wordtest.w"

q= &(r->left);qq= &(r->right);
while(p){
for(u= buffer,v= p->keyword;ord[*u]==ord[*v];u++,v++);
if(ord[*u]<ord[*v]){
*qq= p;
qq= &(p->left);
p= *qq;
}else{
*q= p;
q= &(p->right);
p= *q;
}
}
*q= *qq= NULL;

/*:13*/
#line 249 "./wordtest.w"
;
}

/*:11*/
#line 327 "./wordtest.w"
;
found:;
}
}
done:;

/*:17*/
#line 103 "./wordtest.w"
;
/*19:*/
#line 359 "./wordtest.w"

if(root!=NULL){register node*p,*q;
p= root;
root= NULL;
while(1){
while(p->left!=NULL){
q= p->left;
p->left= root;
root= p;
p= q;
}
visit:/*25:*/
#line 438 "./wordtest.w"

while(curfile!=NULL){
for(u= p->keyword,v= curfile->curword;ord[*u]==ord[*v];u++,v++);
if(*u=='\0'&&*v==breakchar)goto word_done;

if(ord[*u]<ord[*v])break;
/*27:*/
#line 453 "./wordtest.w"

/*28:*/
#line 473 "./wordtest.w"

v= curfile->curword;
l= max_length;
while(1){register byte*w= curfile->limit;
u= curfile->pos;
if(u+l>=w)
while(ord[*u]> 0)*v++= *u++;
else{
w= u+l;
c= *w;
*w= '\0';
while(ord[*u]> 0)*v++= *u++;
*w= c;
}
if(ord[*u]<0){
curfile->pos= u+1;
break;
}
l-= u-curfile->pos;
if(l==0){
curfile->pos= u;
break;
}
if(u==w){
/*29:*/
#line 505 "./wordtest.w"

if(ferror(curfile->dfile)){
fprintf(stderr,"%s: File read error on dictionary file!\n",*argv);
return-9;
}
if(feof(curfile->dfile)){
f= curfile->link;
if(f==curfile)curfile= NULL;
else{
while(f->link!=curfile)f= f->link;
f->link= curfile->link;
curfile= f;
}
goto update_done;
}
curfile->limit= curfile->buf+fread(curfile->buf,1,BUFSIZ,curfile->dfile);
*curfile->limit= '\0';
curfile->pos= curfile->buf;

/*:29*/
#line 498 "./wordtest.w"
;
}else curfile->pos= u+1;
}
curfile->endword= v;
*v= breakchar;
update_done:;

/*:28*/
#line 454 "./wordtest.w"
;
/*30:*/
#line 524 "./wordtest.w"

if(curfile!=NULL){filenode*sentinel= curfile;
for(f= curfile->link;f!=sentinel;f= f->link)
/*31:*/
#line 530 "./wordtest.w"

{
*f->endword= '\0';
for(u= f->curword,v= curfile->curword;ord[*u]==ord[*v];u++,v++);
if(ord[*u]<ord[*v])curfile= f;
*f->endword= breakchar;
}

/*:31*/
#line 527 "./wordtest.w"
;
}

/*:30*/
#line 456 "./wordtest.w"
;

/*:27*/
#line 444 "./wordtest.w"
;
}
/*26:*/
#line 449 "./wordtest.w"

for(u= p->keyword;*u;u++)putchar(*u);
putchar(breakchar);

/*:26*/
#line 446 "./wordtest.w"

word_done:;

/*:25*/
#line 370 "./wordtest.w"
;
if(p->right==NULL){
if(root==NULL)break;
p= root;
root= root->left;
goto visit;
}else p= p->right;
}
}

/*:19*/
#line 104 "./wordtest.w"
;
return 0;
}

/*:3*/
