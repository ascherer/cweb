# This file is part of CWEB.
# This program by Silvio Levy is based on a program by D. E. Knuth.
# It is distributed WITHOUT ANY WARRANTY, express or implied.
# Last updated by Don Knuth, August 1992

# Copyright (C) 1987,1990 Silvio Levy and Donald E. Knuth

# Permission is granted to make and distribute verbatim copies of this
# document provided that the copyright notice and this permission notice
# are preserved on all copies.

# Permission is granted to copy and distribute modified versions of this
# document under the conditions for verbatim copying, provided that the
# entire resulting derived work is distributed under the terms of a
# permission notice identical to this one.

# 
# Read the README file, then edit this file to reflect local conditions
#

# directory for TeX inputs (cwebmac.tex goes here)
MACROSDIR= /usr/local/lib/tex/inputs

# directory for CWEB inputs in @i files
INCLUDEDIR= /usr/local/lib/cweb

# extension for manual pages ("l" distinguishes local from system stuff)
MANEXT= l
#MANEXT= 1

# directory for manual pages (cweb.1 goes here)
MANDIR= /u/man/man$(MANEXT)

# destination directory for executables; must end in /
DESTDIR= /usr/local/bin/

# directory for GNU EMACS Lisp code (cweb.el goes here)
EMACSDIR= /usr/local/emacs/lisp

# Set DESTPREF to null if you want to call the executables "tangle" and "weave"
# (probably not a good idea)
DESTPREF=c

# Set CCHANGES to common-foo.ch if you need changes to common.w
CCHANGES=

# Set TCHANGES to ctangle-foo.ch if you need changes to ctangle.w
TCHANGES=

# Set WCHANGES to cweave-foo.ch if you need changes to cweave.w
WCHANGES=

# We keep debugging info around, for fun, but most users don't need it
CFLAGS = -g -DDEBUG -DSTAT
#CFLAGS = -O

# What C compiler are you using?
CC = cc

# RM and CP are used below in case rm and cp are aliased
RM= /bin/rm
CP= /bin/cp
INSTALL= install
#INSTALL= /bin/cp  # use this if `install' isn't available

##########  You shouldn't have to change anything after this point #######

CWEAVE = ./cweave
CTANGLE = ./ctangle
SOURCES = cweave.w common.w ctangle.w
ALMOSTALL =  common.w ctangle.w Makefile README common.c common.h ctangle.c \
	cwebman.tex cwebmac.tex examples common-vms.ch ctangle-vms.ch \
	cweave-vms.ch cweb.1 cweb.el prod.w
ALL =  $(ALMOSTALL) cweave.w

.SUFFIXES: .tex .dvi .w

.w.tex:
	$(CWEAVE) $*

.tex.dvi:	
	tex $*

.w.dvi:
	make $*.tex
	make $*.dvi

.w.c:
	$(CTANGLE) $*

.w.o:
	make $*.c
	make $*.o

all: ctangle cweave

cautiously: ctangle
	$(CP) common.c SAVEcommon.c
	./ctangle common $(CCHANGES)
	diff common.c SAVEcommon.c
	$(RM) SAVEcommon.c
	$(CP) ctangle.c SAVEctangle.c
	./ctangle ctangle $(TCHANGES)
	diff ctangle.c SAVEctangle.c
	$(RM) SAVEctangle.c

SAVEctangle.c:
	$(CP) ctangle.c SAVEctangle.c

SAVEcommon.c:
	$(CP) common.c SAVEcommon.c

common.c: common.w $(CCHANGES)
	$(CTANGLE) common $(CCHANGES)

common.o: common.c
	$(CC) $(CFLAGS) -DINCLUDEDIR=\"$(INCLUDEDIR)/\" -c common.c

ctangle: ctangle.o common.o
	$(CC) $(CFLAGS) -o ctangle ctangle.o common.o 

ctangle.c: ctangle.w $(TCHANGES)
	$(CTANGLE) ctangle $(TCHANGES)

cweave: cweave.o common.o
	$(CC) $(CFLAGS) -o cweave cweave.o common.o

cweave.c: cweave.w $(WCHANGES)
	$(CTANGLE) cweave $(WCHANGES)

doc: $(SOURCES)
	for i in $?; do make `echo $$i | sed "s/web$$/dvi/"`; done
	@touch doc

# be sure to leave ctangle.c and common.c for bootstrapping
clean:
	$(RM) -f -r *~ *.o common.tex cweave.tex cweave.c ctangle.tex \
	  *.log *.dvi *.toc core cweave.w.[12] cweave ctangle

install: all
	$(INSTALL) cweave $(DESTDIR)$(DESTPREF)weave
	$(INSTALL) ctangle $(DESTDIR)$(DESTPREF)tangle
	$(INSTALL) cweb.1 $(MANDIR)/cweb.$(MANEXT)
	$(INSTALL) cwebmac.tex $(MACROSDIR)
	$(INSTALL) cweb.el $(EMACSDIR)

bundle: $(ALL)
	sed -n '1,1500 p' cweave.w > cweave.w.1
	sed -n '1501,$$ p' cweave.w > cweave.w.2
	/usr/local/bin/shar -m100000 -c -v -f cweb $(ALMOSTALL) cweave.w.[12]

floppy: $(ALL)
	bar cvf /dev/rfd0 $(ALL)
	bar tvf /dev/rfd0
	eject
