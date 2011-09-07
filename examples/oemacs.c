#define LED_NUM_LOCK 0x1 \
 \

/*2:*/
#line 60 "oemacs.w"

/*3:*/
#line 92 "oemacs.w"

#include <string.h> 
#include <stdio.h> 
#include <xview/xview.h> 

/*:3*//*5:*/
#line 128 "oemacs.w"

#include <xview/cms.h> 

/*:5*//*10:*/
#line 311 "oemacs.w"

#include <xview/tty.h> 

/*:10*//*14:*/
#line 362 "oemacs.w"

#include <xview/cursor.h>  

/*:14*//*19:*/
#line 430 "oemacs.w"

#include <xview/font.h>  

/*:19*//*33:*/
#line 764 "oemacs.w"

#include <sys/file.h>  
#include <sundev/kbio.h>  

/*:33*/
#line 61 "oemacs.w"


Frame frame;
/*7:*/
#line 144 "oemacs.w"

unsigned short icon_bits[]= {
0x0000,0x0000,0x0000,0x1E00,
0x0000,0x0000,0x0000,0x0900,
0x001E,0x0000,0x0000,0x0880,
0x0064,0x0000,0x0000,0x0440,
0x0088,0x0000,0x0000,0x0420,
0x0110,0x0000,0x0000,0x0210,
0x0220,0x0000,0x0000,0x0210,
0x0420,0x0FCF,0x01C0,0x0108,
0x0840,0x1030,0x8620,0x0088,
0x1080,0x00C0,0x5810,0x0084,
0x1080,0x1F00,0x2008,0x0044,
0x2100,0xE200,0x1004,0x0044,
0x4103,0x0400,0x0002,0x0042,
0x4204,0x080E,0x0001,0x0042,
0x8200,0x7830,0x0020,0x8082,
0x8203,0x9040,0x0018,0x4102,
0x8204,0x2080,0x07C6,0x3E04,
0x8108,0x410C,0x0021,0x8004,
0x8080,0x8210,0x03D0,0x6008,
0x4041,0x0420,0x0008,0x1810,
0x403E,0x0820,0x0FFC,0x0620,
0x2000,0x1040,0x0002,0x01C0,
0x1000,0x608C,0x0FFF,0x0060,
0x0801,0x8110,0x0080,0x8118,
0x0406,0x0220,0x1FFF,0x66E0,
0x0238,0x044F,0x0000,0xD800,
0x01C0,0x0890,0x8FFF,0x4000,
0x0300,0x10A6,0x4041,0x6000,
0x1C00,0x2026,0x4FFF,0x6000,
0x60CC,0x4026,0x4001,0x6000,
0x1F33,0x8010,0x8FFF,0x4000,
0x0012,0x000F,0x0040,0xC000,
0x0022,0x4000,0x07FF,0x4000,
0x0024,0x4000,0x0000,0x2000,
0x0024,0x4818,0x8FFF,0xE000,
0x0024,0x4907,0x0040,0x2000,
0x0044,0x4900,0x1FFF,0xE000,
0x0044,0x4900,0x0000,0x2000,
0x0044,0x4900,0x07FF,0xE000,
0x0044,0x4880,0x0020,0x2000,
0x0044,0x4880,0x07FF,0xE000,
0x0044,0x4840,0x0000,0x2000,
0x0044,0x2A20,0x07FF,0xE000,
0x0044,0x2410,0x0020,0x2000,
0x0042,0x2448,0x0FFF,0xE000,
0x0042,0x2948,0x0000,0x2000,
0x0041,0x1144,0x07FF,0xA000,
0x0041,0x1144,0x2010,0x1000,
0x0021,0x1126,0x20FA,0x1000,
0x0024,0x8925,0x2600,0x1000,
0x0014,0x8924,0xA138,0x7000,
0x0016,0x88A4,0x9090,0x6000,
0x000A,0x44A4,0x4880,0xA000,
0x0002,0x44A2,0x4401,0x2000,
0x0003,0x4492,0x2001,0x4000,
0x0001,0x2451,0x3002,0x8000,
0x0000,0xA251,0x1E05,0x0000,
0x0000,0x2248,0xA1F9,0x8000,
0x0000,0x1648,0x9002,0x8000,
0x0000,0x1A28,0x4C02,0x8000,
0x0000,0x1220,0x43FC,0x8000,
0x0000,0x0120,0x2000,0x8000,
0x0000,0x0120,0x2003,0x0000,
0x0000,0x0150,0x1FFC,0x0000
};
unsigned short mask_bits[]= {
0x0000,0x0000,0x0000,0x1E00,
0x0000,0x0000,0x0000,0x0F00,
0x001E,0x0000,0x0000,0x0F80,
0x007C,0x0000,0x0000,0x07C0,
0x00F8,0x0000,0x0000,0x07E0,
0x01F0,0x0000,0x0000,0x03F0,
0x03E0,0x0000,0x0000,0x03F0,
0x07E0,0x0FCF,0x01C0,0x01F8,
0x0FC0,0x103F,0x87F0,0x00F8,
0x1F80,0x00FF,0xDFF0,0x00FC,
0x1F80,0x1FFF,0xFFF8,0x007C,
0x3F00,0xE3FF,0xFFFC,0x007C,
0x7F03,0x07FF,0xFFFE,0x007E,
0x7E04,0x0FFF,0xFFFF,0x007E,
0xFE00,0x7FFF,0xFFFF,0x80FE,
0xFE03,0x9FFF,0xFFFF,0xC1FE,
0xFE04,0x3FFF,0xFFFF,0xFFFC,
0xFF08,0x7FFF,0xFFFF,0xFFFC,
0xFF80,0xFFFF,0xFFFF,0xFFF8,
0x7FC1,0xFFFF,0xFFFF,0xFFF0,
0x7FFF,0xFFFF,0xFFFF,0xFFE0,
0x3FFF,0xFFFF,0xFFFF,0xFFC0,
0x1FFF,0xFFFF,0xFFFF,0xFFE0,
0x0FFF,0xFFFF,0xFFFF,0xFFF8,
0x07FF,0xFFFF,0xFFFF,0xFEE0,
0x03FF,0xFFFF,0xFFFF,0xF800,
0x01FF,0xFFFF,0xFFFF,0xE000,
0x03FF,0xFFFF,0xFFFF,0xE000,
0x1FFF,0xFFFF,0xFFFF,0xE000,
0x7FFF,0xFFFF,0xFFFF,0xE000,
0x1F7F,0xFFFF,0xFFFF,0xC000,
0x001F,0xFFFF,0xFFFF,0xC000,
0x003F,0xFFFF,0xFFFF,0xC000,
0x003F,0xFFFF,0xFFFF,0xE000,
0x003F,0xFFFF,0xFFFF,0xE000,
0x003F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xE000,
0x007F,0xFFFF,0xFFFF,0xF000,
0x003F,0xFFFF,0xFFFF,0xF000,
0x003F,0xFFFF,0xFFFF,0xF000,
0x001F,0xFFFF,0xFFFF,0xF000,
0x001F,0xFFFF,0xFFFF,0xE000,
0x000B,0xFFFF,0xFFFF,0xE000,
0x0003,0xFFFF,0xFFFF,0xE000,
0x0003,0xFFFF,0xFFFF,0xC000,
0x0001,0xFFFF,0xFFFF,0x8000,
0x0000,0xBFF1,0xFFFF,0x0000,
0x0000,0x3FF8,0xFFFF,0x8000,
0x0000,0x1FF8,0xFFFF,0x8000,
0x0000,0x1FF8,0x7FFF,0x8000,
0x0000,0x13E0,0x7FFF,0x8000,
0x0000,0x01E0,0x3FFF,0x8000,
0x0000,0x01E0,0x3FFF,0x0000,
0x0000,0x0150,0x1FFC,0x0000
};

/*:7*//*9:*/
#line 308 "oemacs.w"

Tty tty;

/*:9*//*12:*/
#line 340 "oemacs.w"

Xv_window window;

/*:12*//*16:*/
#line 375 "oemacs.w"

int rv;

/*:16*//*18:*/
#line 427 "oemacs.w"

int char_width,char_height;

/*:18*//*30:*/
#line 733 "oemacs.w"

char buf[]= "\030*??\021";

/*:30*//*32:*/
#line 759 "oemacs.w"

int num_lock_state;
char turnon[]= "\370turn-numlock-on\r",turnoff[]= "\370turn-numlock-off\r";
int keyboard;

/*:32*//*37:*/
#line 843 "oemacs.w"

char mouse_buf[24]= "\030";

/*:37*//*39:*/
#line 866 "oemacs.w"

struct timeval prev_mouse_time;

/*:39*/
#line 64 "oemacs.w"


/*21:*/
#line 490 "oemacs.w"

Notify_value filter(window,event,arg,type)
Xv_window window;
Event*event;
Notify_arg arg;
Notify_event_type type;
{register int id= event_id(event);
#ifdef DEBUG
printf("event %d%s, action %d, shift %x, mouse(%d,%d)\n",
event_id(event),event_is_up(event)?"UP":"DOWN",event->action,
event_shiftmask(event),event_x(event),event_y(event));
#endif
/*34:*/
#line 771 "oemacs.w"

{char leds;
ioctl(keyboard,KIOCGLED,&leds);
if((leds&LED_NUM_LOCK)!=num_lock_state){
num_lock_state= leds&LED_NUM_LOCK;
if(num_lock_state)ttysw_input(window,turnon,17);
else ttysw_input(window,turnoff,18);
}
}

/*:34*/
#line 502 "oemacs.w"
;
if(id==LOC_WINENTER)/*22:*/
#line 514 "oemacs.w"

{
win_set_kbd_focus(window,xv_get(window,XV_XID));
return NOTIFY_DONE;
}

/*:22*/
#line 503 "oemacs.w"
;
if(event_is_button(event))/*36:*/
#line 828 "oemacs.w"

{register int button_code,elapsed_time;
button_code= (id==MS_LEFT?1:id==MS_MIDDLE?2:4);
if(event_shift_is_down(event))button_code+= 8;
if(event_ctrl_is_down(event))button_code+= 16;
if(event_meta_is_down(event))button_code+= 32;
if(event_is_up(event))button_code+= 128;
/*38:*/
#line 853 "oemacs.w"

{struct timeval now;
long delta_sec,delta_usec;

now= event_time(event);
delta_sec= now.tv_sec-prev_mouse_time.tv_sec;
delta_usec= now.tv_usec-prev_mouse_time.tv_usec;
if(delta_usec<0)delta_usec+= 1000000,delta_sec--;
if(delta_sec>=10)elapsed_time= 9999;
else elapsed_time= (delta_sec*1000)+(delta_usec/1000);
prev_mouse_time= now;
}

/*:38*/
#line 835 "oemacs.w"
;
sprintf(mouse_buf+2,"(%d %d %d %d)\r",button_code,
event_x(event)/char_width,event_y(event)/char_height,
elapsed_time);
ttysw_input(window,mouse_buf,12+strlen(mouse_buf+12));
return NOTIFY_DONE;
}

/*:36*/
#line 504 "oemacs.w"
;
if(event_is_up(event))return NOTIFY_DONE;
/*26:*/
#line 678 "oemacs.w"

{register int bank= 'b';
register int n;
if(id>=KEY_LEFT(1))/*27:*/
#line 696 "oemacs.w"

{
if(id<KEY_RIGHT(1)){
bank= 'l';n= id-KEY_LEFT(0);
}else if(id<KEY_TOP(1)){
bank= 'r';n= id-KEY_RIGHT(0);
}else if(id<KEY_BOTTOM(1)){
bank= 't';n= id-KEY_TOP(0);
}else n= id-KEY_BOTTOM(0);
goto emit_function_key;
}

/*:27*/
#line 681 "oemacs.w"

else if(id>=256)/*28:*/
#line 711 "oemacs.w"

if(id==SHIFT_ALT){
n= 2;goto emit_function_key;
}else if(id==SHIFT_ALTG){
n= 3;goto emit_function_key;
}else goto non_function;

/*:28*/
#line 682 "oemacs.w"

else if(id>=128)
/*31:*/
#line 736 "oemacs.w"

switch(id){
case 190:bank= 'r';n= 2;goto emit_function_key;
case 189:n= 8;goto emit_function_key;
case 188:n= 7;goto emit_function_key;
case 179:n= 6;goto emit_function_key;
case 178:n= 5;goto emit_function_key;
case 185:n= 4;goto emit_function_key;
default:buf[5]= id;
ttysw_input(window,buf+4,2);
return NOTIFY_DONE;
}

/*:31*/
#line 684 "oemacs.w"

else if(id> 0||
(event_action(event)==0&&event_shiftmask(event)==CTRLMASK))
goto non_function;
else n= 1;
emit_function_key:/*29:*/
#line 722 "oemacs.w"

{
if(event_shift_is_down(event))bank-= 32;
if(event_ctrl_is_down(event))bank-= 64;
if(event_meta_is_down(event))bank+= 128;
buf[2]= n+'a'-1;
buf[3]= bank;
ttysw_input(window,buf,4);
return NOTIFY_DONE;
}

/*:29*/
#line 689 "oemacs.w"
;
non_function:;
}

/*:26*/
#line 506 "oemacs.w"
;
/*23:*/
#line 530 "oemacs.w"

if(id<128)
if(event_meta_is_down(event))event_set_id(event,id+128);
else event_set_action(event,ACTION_NULL_EVENT);

/*:23*/
#line 507 "oemacs.w"
;
return notify_next_event_func(window,event,arg,type);
}

/*:21*/
#line 66 "oemacs.w"


main(argc,argv)
int argc;char*argv[];
{
/*35:*/
#line 785 "oemacs.w"

keyboard= open("/dev/kbd",O_RDWR);
if(keyboard<0){
fprintf(stderr,"%s: Can't open /dev/kbd!\n",argv[0]);
exit(1);
}

/*:35*/
#line 71 "oemacs.w"
;
/*20:*/
#line 446 "oemacs.w"

/*15:*/
#line 368 "oemacs.w"

rv= 0;
{int k= argc;
while(--k> 0)if(strcmp(argv[k],"-rv")==0||
strcmp(argv[k],"-reverse")==0)rv= 1;
}

/*:15*/
#line 447 "oemacs.w"
;
xv_init(XV_INIT_ARGC_PTR_ARGV,&argc,argv,NULL);

/*4:*/
#line 115 "oemacs.w"

{Server_image icon_image= (Server_image)xv_create(NULL,SERVER_IMAGE,
XV_WIDTH,64,XV_HEIGHT,64,SERVER_IMAGE_BITS,icon_bits,NULL);
Server_image mask_image= (Server_image)xv_create(NULL,SERVER_IMAGE,
XV_WIDTH,64,XV_HEIGHT,64,SERVER_IMAGE_BITS,mask_bits,NULL);
Cms cms= (Cms)xv_create(NULL,CMS,CMS_SIZE,2,
CMS_NAMED_COLORS,"yellow","black",NULL,NULL);
Icon icon= (Icon)xv_create(NULL,ICON,
ICON_IMAGE,icon_image,ICON_MASK_IMAGE,mask_image,
WIN_CMS,cms,NULL);
frame= xv_create(NULL,FRAME,FRAME_ICON,icon,NULL);
}

/*:4*/
#line 450 "oemacs.w"
;
/*6:*/
#line 136 "oemacs.w"

if(xv_get(frame,XV_LABEL)==NULL)
xv_set(frame,FRAME_SHOW_HEADER,FALSE,XV_LABEL,"OEMACS",NULL);

/*:6*/
#line 451 "oemacs.w"
;
/*8:*/
#line 301 "oemacs.w"

argv[0]= "emacs";
putenv("TERM=sun");
tty= (Tty)xv_create(frame,TTY,WIN_IS_CLIENT_PANE,
TTY_QUIT_ON_CHILD_DEATH,TRUE,
TTY_ARGV,argv,NULL);

/*:8*/
#line 452 "oemacs.w"
;
/*11:*/
#line 336 "oemacs.w"

window= (Xv_window)xv_get(tty,OPENWIN_NTH_VIEW,0);
xv_set(window,WIN_CONSUME_EVENT,LOC_WINENTER,NULL);

/*:11*/
#line 453 "oemacs.w"
;
/*13:*/
#line 351 "oemacs.w"

if(rv){Xv_singlecolor white,black;
Xv_cursor cursor;
white.red= white.green= white.blue= 255;
black.red= black.green= black.blue= 0;
cursor= (Xv_cursor)xv_create(NULL,CURSOR,
CURSOR_SRC_CHAR,OLC_BASIC_PTR,CURSOR_MASK_CHAR,OLC_BASIC_MASK_PTR,
CURSOR_FOREGROUND_COLOR,&white,CURSOR_BACKGROUND_COLOR,&black,NULL);
xv_set(window,WIN_CURSOR,cursor,NULL);
}

/*:13*/
#line 454 "oemacs.w"
;
/*17:*/
#line 411 "oemacs.w"

{
Xv_font font= (Xv_font)xv_get(frame,XV_FONT);
Xv_font dfont= (Xv_font)xv_find(NULL,FONT,FONT_FAMILY,
FONT_FAMILY_DEFAULT,NULL);
if(strcmp((char*)xv_get(font,FONT_NAME),
(char*)xv_get(dfont,FONT_NAME))==0){

dfont= (Xv_font)xv_find(NULL,FONT,FONT_FAMILY,
FONT_FAMILY_DEFAULT_FIXEDWIDTH,NULL);

}else dfont= font;
char_width= (int)xv_get(dfont,FONT_DEFAULT_CHAR_WIDTH);
char_height= (int)xv_get(dfont,FONT_DEFAULT_CHAR_HEIGHT);
}

/*:17*/
#line 455 "oemacs.w"
;
notify_interpose_event_func(window,filter,NOTIFY_SAFE);

/*:20*/
#line 72 "oemacs.w"
;
xv_main_loop(frame);
exit(0);
}

/*:2*/
