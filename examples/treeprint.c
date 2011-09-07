#define sibling left
#define child right \

#define is_last(S) (S->sibling==NULL)  \

/*1:*/
#line 17 "treeprint.w"

/*12:*/
#line 140 "treeprint.w"

#define svert '|'
#define shoriz '-'
#define scross '+'
#define scorner '\\' 

#define pvert '|'
#define phoriz '-'
#define pcross '+'
#define pcorner '\\' 

/*:12*/
#line 18 "treeprint.w"

/*5:*/
#line 67 "treeprint.w"

#include <stdio.h> 

/*:5*/
#line 19 "treeprint.w"

/*2:*/
#line 41 "treeprint.w"

typedef struct tnode{
struct tnode*left,*right;
char*data;
}TNODE;
/*:2*//*10:*/
#line 129 "treeprint.w"
char*malloc();

/*:10*//*13:*/
#line 152 "treeprint.w"

char vert= svert;
char horiz= shoriz;
char cross= scross;
char corner= scorner;

/*:13*//*15:*/
#line 183 "treeprint.w"

char indent_string[100]= "";

/*:15*/
#line 20 "treeprint.w"



main(argc,argv)
int argc;
char**argv;
{
/*3:*/
#line 46 "treeprint.w"

struct tnode*root= NULL;



/*:3*/
#line 27 "treeprint.w"
;
/*14:*/
#line 159 "treeprint.w"

while(--argc> 0){
if(**++argv=='-'){
switch(*++(*argv)){
case'p':
vert= pvert;
horiz= phoriz;
cross= pcross;
corner= pcorner;
break;
default:
fprintf(stderr,"treeprint: bad option -%c\n",**argv);
break;
}
}
}

/*:14*/
#line 28 "treeprint.w"
;
/*11:*/
#line 132 "treeprint.w"
read_tree(stdin,&root);

/*:11*/
#line 29 "treeprint.w"
;
/*18:*/
#line 246 "treeprint.w"
print_node(stdout,indent_string,root);

/*:18*/
#line 30 "treeprint.w"

exit(0);
}

/*:1*//*4:*/
#line 55 "treeprint.w"

read_tree(fp,rootptr)
FILE*fp;
struct tnode**rootptr;
{
char buf[255],*p;

while((fgets(buf,255,fp))!=NULL){
/*6:*/
#line 71 "treeprint.w"

p= buf;while(*p!='\0'&&*p!='\n')p++;

*p= '\0';

/*:6*/
#line 63 "treeprint.w"
;
add_tree(rootptr,buf);
}
}
/*:4*//*7:*/
#line 80 "treeprint.w"

add_tree(rootptr,p)
struct tnode**rootptr;
char*p;
{
char*s;
int slashed;

if(*p=='\0')return;

/*8:*/
#line 115 "treeprint.w"

for(s= p;*s!='\0'&&*s!='/';)s++;
if(*s=='/'){
slashed= 1;
*s= '\0';
}else slashed= 0;

/*:8*/
#line 92 "treeprint.w"
;

if(*rootptr==NULL){
/*9:*/
#line 123 "treeprint.w"

*rootptr= (struct tnode*)malloc(sizeof(struct tnode));
(*rootptr)->left= (*rootptr)->right= NULL;
(*rootptr)->data= malloc(strlen(p)+1);

/*:9*/
#line 95 "treeprint.w"
;
strcpy((*rootptr)->data,p);
}
if(strcmp((*rootptr)->data,p)==0){
if(slashed)++s;
add_tree(&((*rootptr)->child),s);
}
else{
if(slashed)*s= '/';
add_tree(&((*rootptr)->sibling),p);
}
}

/*:7*//*16:*/
#line 194 "treeprint.w"

print_node(fp,indent_string,node)
FILE*fp;
char*indent_string;
struct tnode*node;
{
char string[255];
int i;
char*p,*is;

if(node==NULL){
}
else{
*string= '\0';
for(i= strlen(indent_string);i> 0;i--)
strcat(string," |  ");
strcat(string," +--");
/*17:*/
#line 234 "treeprint.w"

is= indent_string;
for(p= string;*p!='\0';p++)switch(*p){
case'|':*p= *is++;break;
case'+':*p= (is_last(node)?corner:cross);break;
case'-':*p= horiz;break;
default:break;
}


/*:17*/
#line 212 "treeprint.w"
;
fprintf(fp,"%s%s\n",string,node->data);



*is++= (is_last(node)?' ':vert);
*is= '\0';

print_node(fp,indent_string,node->child);
*--is= '\0';
print_node(fp,indent_string,node->sibling);
}

}
/*:16*/
