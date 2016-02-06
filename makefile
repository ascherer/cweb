# This file, makefile.amiga, is part of CWEB.
# It is distributed WITHOUT ANY WARRANTY, express or implied.
#
# Modified for the SAS/C 6.51 compiler under AmigaOS 2.1 on an AMIGA 2000 by
# Andreas Scherer (Abt-Wolf-Stra�e 17, 96215 Lichtenfels, Germany), March 1993
# Last updated by Andreas Scherer, July 2, 1994

# Copyright (C) 1987,1990,1993 Silvio Levy and Donald E. Knuth
# Copyright (C) 1993,1994 Andreas Scherer

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

# directory for TeX inputs (cwebmac.tex, ccwebmac.tex, or gcwebmac.tex go here)
MACROSDIR= cweb:macros/

# directory for CWEB inputs in @i files
CWEBINPUTS= CWeb:,CWeb:include,CWeb:inputs

# extension for manual pages ("l" distinguishes local from system stuff)
MANEXT= l
#MANEXT= 1

# directory for manual pages (cweb.1 goes here)
MANDIR= cweb:

# destination directory for executables; must end in /
DESTDIR= cweb:bin/

# directory for GNU EMACS Lips code (cweb.el goes here)
EMACSDIR= s:

# directory for language catalogs with message texts of the script file
CATDIR= Locale:catalogs/

# directory for the language header file "cweb.h"
CATINCLUDE= bin/catalogs/

# Set DESTPREF to null if you want to call the executables "tangle" and "weave"
# (probably NOT a good idea; we recommend leaving DESTPREF=c)
DESTPREF=c

# Set COMMONH to the name of the file `common.h' or any alternative to
# the original `common.h'.
COMMONH=comm-p.h

# Set CHCHANGES to comm-foo.hch if you need changes to common.h
CHCHANGES=comm-p.hch

# Set CCHANGES to comm-foo.ch if you need changes to common.w
CCHANGES=common.ch

# Set TCHANGES to ctang-foo.ch if you need changes to ctangle.w
TCHANGES=ctangle.ch

# Set WCHANGES to cweav-foo.ch if you need changes to cweave.w
WCHANGES=cweave.ch

# Set PCHANGES to prod-foo.ch if you need changes to prod.w
PCHANGES=

# Set MCHANGES to wmerge-foo.ch if you need changes to wmerge.w
MCHANGES=wmerge.ch

# These lists of arguments are specific for SC and SLINK.
# Change, add or delete things here to suit your personal conditions.
OBJS = LIB:cres.o
LIBS = LIB:sc.lib+LIB:amiga.lib
CFLAGS = cpu=ANY idir=$(CATINCLUDE) OPTIMIZE \
	def=_STRICT_ANSI def=CWEBINPUTS="$(CWEBINPUTS)" \
	NOSTKCHK NOICONS
LINKFLAGS = VERBOSE NOICONS STRIPDEBUG LIB $(LIBS) FROM $(OBJS)

# By default my version of cweave includes the option for AMIGA keywords
# and the use of German macros.  So you have to switch these off for all
# the CWEB documentation.  Also the `f' flag is turned off to save paper
WFLAGS=-fag

# What C compiler are you using?
CC = SC
LINK = SLink
MAKE = SMake

# RM and CP are used below in case rm and cp are aliased
RM= delete
CP= copy
INSTALL= copy

##########  You shouldn't have to change anything after this point #######

CWEAVE = cweave
CTANGLE = ctangle
WMERGE = wmerge
SOURCES = cweave.w common.w ctangle.w
ALMOSTALL = common.w ctangle.w wmerge.w makefile readme \
	common.c common.h $(COMMONH) ctangle.c wmerge.c \
	cwebman.tex cwebmang.ch cweb.1 cweb.man cweb.el prod.w \
	$(CCHANGES) $(CHCHANGES) $(TCHANGES) $(WCHANGES) $(PCHANGES) \
	comm-vms.ch ctang-vms.ch cweav-vms.ch \
	comm-man.ch ctang-man.ch cweav-man.ch \
	makefile.amiga makefile.pc makefile.unix \
	$(MACROSDIR)cwebmac.tex $(MACROSDIR)ccwebmac.tex $(MACROSDIR)gcwebmac.tex \
	$(CATINCLUDE)cweb.h examples
ALL =  $(ALMOSTALL) cweave.w

.SUFFIXES: .dvi .tex .w

.w.tex:
	$(CWEAVE) $(WFLAGS) $* $*

.tex.dvi:	
	virtex &plain "\language=0 \input " $<

.w.dvi:
	$(MAKE) $*.tex
	$(MAKE) $*.dvi

.c.o:
	$(CC) $(CFLAGS) $*.c

.w.c:
	$(CTANGLE) $* $*

.w.o:
	$(MAKE) $*.c
	$(MAKE) $*.o

# When you say `smake' without any arguments, `smake' will jump to this item
default: ctangle cweave

# The complete set of files contains the two programs `ctangle' and
# `cweave' plus the program `wmerge', the manuals `cwebman' and `cwebmang'
# and the source documentations.
all: progs docs

# The objects of desire
progs: ctangle cweave wmerge

cautiously: ctangle
	$(CP) common.c SAVEcommon.c
	$(CTANGLE) common $(CCHANGES)
	diff common.c SAVEcommon.c
	$(RM) SAVEcommon.c
	$(CP) ctangle.c SAVEctangle.c
	$(CTANGLE) ctangle $(TCHANGES)
	diff ctangle.c SAVEctangle.c
	$(RM) SAVEctangle.c

SAVEctangle.c:
	$(CP) ctangle.c SAVEctangle.c

SAVEcommon.c:
	$(CP) common.c SAVEcommon.c

common.c: common.w $(CCHANGES)
	$(CTANGLE) common $(CCHANGES)

common.o: common.c $(CATINCLUDE)cweb.h

ctangle: ctangle.o common.o
	$(LINK) $(LINKFLAGS) common.o ctangle.o TO ctangle

ctangle.c: ctangle.w $(TCHANGES)
	$(CTANGLE) ctangle $(TCHANGES)

ctangle.o: ctangle.c $(CATINCLUDE)cweb.h $(COMMONH)

cweave: cweave.o common.o
	$(LINK) $(LINKFLAGS) common.o cweave.o TO cweave

cweave.c: cweave.w $(WCHANGES)
	$(CTANGLE) cweave $(WCHANGES)

cweave.o: cweave.c $(CATINCLUDE)cweb.h $(COMMONH)
	$(CC) $(CFLAGS) code=FAR cweave.c

wmerge: wmerge.c
	$(CC) $(CFLAGS) link wmerge.c TO wmerge

wmerge.c: wmerge.w $(MCHANGES)
	$(CTANGLE) wmerge $(MCHANGES)

# additional rules to `wmerge' the remaining files
#
$(COMMONH): common.h $(CHCHANGES)
	$(WMERGE) common.h $(CHCHANGES) $(COMMONH)

# Take a good lecture for bedtime reading
docs: cwebman.dvi cwebmang.dvi common.dvi ctangle.dvi cweave.dvi wmerge.dvi

cwebman.dvi: cwebman.tex
cwebmang.dvi: cwebmang.tex
common.dvi: common.tex
ctangle.dvi: ctangle.tex
cweave.dvi: cweave.tex
wmerge.dvi: wmerge.tex

usermanual: cwebmang.dvi

fullmanual: usermanual $(SOURCES) comm-man.ch ctang-man.ch cweav-man.ch
	$(MAKE) cweave
	$(CWEAVE) common.w comm-man.ch
	$(MAKE) common.dvi
	$(CWEAVE) ctangle.w ctang-man.ch
	$(MAKE) ctangle.dvi
	$(CWEAVE) cweave.w cweav-man.ch
	$(MAKE) cweave.dvi

cwebmang.tex: cwebman.tex cwebmang.ch
	$(WMERGE) cwebman.tex cwebmang.ch cwebmang.tex

# for making the documentation we will have to include the change files
ctangle.tex: ctangle.w $(COMMONH) $(TCHANGES)
	$(CWEAVE) $(WFLAGS) ctangle $(TCHANGES)

cweave.tex: cweave.w $(COMMONH) $(WCHANGES)
	$(CWEAVE) $(WFLAGS) cweave $(WCHANGES)

common.tex: common.w $(CCHANGES)
	$(CWEAVE) $(WFLAGS) common $(CCHANGES)

wmerge.tex: wmerge.w $(MCHANGES)
	$(CWEAVE) $(WFLAGS) wmerge $(MCHANGES)

# be sure to leave ctangle.c and common.c and $(COMMONH) for bootstrapping
clean:
	$(RM) \#?.(o|lnk|bak|log|dvi|toc|idx|scn) \
	common.tex cweave.tex cweave.c ctangle.tex cweave ctangle \
	cwebmang.tex wmerge.tex wmerge

# Install the new program versions where they can be found
install: bin/ctangle bin/cweave bin/wmerge $(MACROSDIR)ccwebmac.tex \
	arexx/catalogs/english/cweb.catalog
	$(INSTALL) cweave $(DESTDIR)$(DESTPREF)weave
	$(INSTALL) ctangle $(DESTDIR)$(DESTPREF)tangle
	$(INSTALL) wmerge $(DESTDIR)wmerge
