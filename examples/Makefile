#
# generic Makefile to use when you've got CWEB
# (add it to, or add to it, whatever you like)
#

CFLAGS = -g
MLIB = -lm

.SUFFIXES: .tex .dvi .w .run

.w.tex:
	cweave $*

.tex.dvi:	
	tex $*

.w.dvi:
	make $*.tex
	make $*.dvi

.w.c:
	ctangle $*

.w.o:
	make $*.c
	make $*.o

.c.o:
	cc $(CFLAGS) -c $*.c

.w.run:
	make $*.c
	cc $(CFLAGS) $*.c -o $*
