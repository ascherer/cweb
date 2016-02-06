#
# Makefile for the example programs EXTEX, OEMACS, TREEPRINT, WC and
# WORDTEST from the original CWEB package.
# Additionally there are the three example programs COMMONWORDS, PRIMES,
# and SAMPLE.  These are originally WEB programs by Donald E. Knuth and
# were translated into CWEB for eductational purposes.
# And there is the example program MATRIX.  This is the first attempt of
# C++ programming in connection with the features of CWEB 3.1 for German
# users.  The program CCT translates text files between different
# character code tables.
# The routines below are suitable for the SAS/C Amiga compiler 6.x by
# SAS Institute Inc., Cary NC.
#
# July 9, 1994, Andreas Scherer.
#

CFLAGS = cpu=ANY math=STANDARD optimize nostackcheck define=_STRICT_ANSI

.SUFFIXES: .tex .dvi .w

.w.tex:
	cweave -fg $*
.tex.dvi:
	virtex &plain "\language=0 \input " $*
.w.c:
	ctangle $*
.c.o:
	sc $(CFLAGS) $*.c

PRG = cct commonwords extex matrix primes sample treeprint wc wordtest

all: $(PRG)

docs: cct.dvi commonwords.dvi extex.dvi oemacs.dvi primes.dvi sample.dvi treeprint.dvi wc.dvi wordtest.dvi

cct: cct.o
	slink FROM lib:c.o cct.o TO cct LIB lib:scnb.lib NOICONS
cct.o: cct.c
cct.c: cct.w
cct.dvi: cct.tex
cct.tex: cct.w

commonwords: commonwords.o
	slink FROM lib:c.o commonwords.o TO commonwords LIB lib:scnb.lib NOICONS
commonwords.o: commonwords.c
	sc $(CFLAGS) data=FAR commonwords.c
commonwords.c: commonwords.w
commonwords.dvi: commonwords.tex
commonwords.tex: commonwords.w

extex: extex.o
	slink FROM lib:c.o extex.o TO extex LIB lib:sc.lib NOICONS
extex.o: extex.c
extex.c: extex.w extex.ch
	ctangle extex.w extex.ch
extex.dvi: extex.tex
extex.tex: extex.w extex.ch
	cweave -fg extex.w extex.ch

matrix: matrix.o
	slink FROM lib:c.o matrix.o TO matrix LIB lib:scm.lib lib:sc.lib NOICONS
matrix.o: matrix.cpp
matrix.cpp: matrix.wpp
	ctangle matrix.wpp - matrix.cpp
matrix.dvi: matrix.tex
matrix.tex: matrix.wpp
	cweave -f matrix.wpp

oemacs: oemacs.o
	slink FROM lib:c.o oemacs.o TO oemacs LIB lib:sc.lib NOICONS
oemacs.o: oemacs.c
oemacs.c: oemacs.w
oemacs.dvi: oemacs.tex
oemacs.tex: oemacs.w

primes: primes.o
	slink FROM lib:c.o primes.o TO primes LIB lib:sc.lib NOICONS
primes.o: primes.c
	sc $(CFLAGS) stackextend $*.c # This is crucial!!!
primes.c: primes.w
primes.dvi: primes.tex
primes.tex: primes.w

sample: sample.o
	slink FROM lib:c.o sample.o TO sample LIB lib:sc.lib lib:scm.lib NOICONS
sample.o: sample.c
sample.c: sample.w
sample.dvi: sample.tex
sample.tex: sample.w

treeprint: treeprint.o
	slink FROM lib:c.o treeprint.o TO treeprint LIB lib:sc.lib NOICONS
treeprint.o: treeprint.c
treeprint.c: treeprint.w treeprint.ch
	ctangle treeprint.w treeprint.ch
treeprint.dvi: treeprint.tex
treeprint.tex: treeprint.w treeprint.ch
	cweave -fg treeprint.w treeprint.ch

wc: wc.o
	slink FROM lib:c.o wc.o TO wc LIB lib:sc.lib NOICONS
wc.o: wc.c
wc.c: wc.w wc.ch
	ctangle wc.w wc.ch
wc.dvi: wc.tex
wc.tex: wc.w wc.ch
	cweave -fg wc.w wc.ch

wordtest: wordtest.o
	slink FROM lib:c.o wordtest.o TO wordtest LIB lib:sc.lib NOICONS
wordtest.o: wordtest.c
wordtest.c: wordtest.w wordtest.ch
	ctangle wordtest.w wordtest.ch
wordtest.dvi: wordtest.tex
wordtest.tex: wordtest.w wordtest.ch
	cweave -fg wordtest.w wordtest.ch

clean:
	delete \#?.(o|lnk|bak|dvi|tex|toc|log|c|cpp|idx|scn)

veryclean: clean
	delete $(PRG)
