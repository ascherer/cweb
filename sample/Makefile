
###### Please forgive the prolixity of the comments;
###### this is meant as a template for other applications so I thought
###### I should explain everything.

###### The first part of this file is specific to this project

### The groups of files for this project.
### Note: we don't need to list ".c" and ".h" files or ".tex" files;
### they get created automatically when the ".w.o" and ".w.dvi" rules fire.

MODS = main getop stack getch
OBJS = main.o getop.o stack.o getch.o
DVIS = main.dvi getop.dvi stack.dvi getch.dvi
PSS = main.ps getop.ps stack.ps getch.ps
PROG = calc

### The program we're building.  We want this rule to be first;
### otherwise I'd put it down below in the project-invariant part.

$(PROG): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)
#
# On my NeXT, I add the -object flag to the cc command to make
# a smaller binary, but I have no idea whether that's appropriate
# for other systems.
#
#	$(CC) $(CFLAGS) -o $@ $(OBJS) -object

### We need additional rules for the modules that use header files
### generated from other modules.  For example, make can figure out that
### stack.o should be rebuilt if stack.w changes, but it has to be
### told that main.o should be rebuilt as well.

main.o:	main.c getop.h stack.h

getop.o: getop.c getch.h

###### Below here are declarations that would
###### apply equally well to any CWEB-based project.
###### The first time you use this you might have to adjust flags
###### or path names to suit your system's conventions; after that
###### you should just be able to duplicate it for any CWEB project.

### Options for the C compiler (yours may be different)

CFLAGS = -O -s
CFLAGS = -g

### Names for the processors we use;
### you may need to add path names or options or something

CWEAVE = cweave
CTANGLE = ctangle
TEX = tex
DVIPS = dvips

### Suffix rules tell generically how to make
### one kind of file from another kind of file

.SUFFIXES: .ps .dvi .tex .w

.w.tex:
	$(CWEAVE) $*

.tex.dvi:	
	$(TEX) $<

.w.dvi:
	$(CWEAVE) $*
	$(TEX) $*.tex

.dvi.ps:
	$(DVIPS) $< -o $*.ps

.w.c:
	$(CTANGLE) $*

.w.h:
	$(CTANGLE) $*

.w.o:
	make $*.c
	make $*.o

### Special targets for special operations

#
# make all "end-product" files, deleting intermediate files
#
results: $(PROG) doc
	make clean

#
# make all "end-product" files, saving intermediates
#
all: $(PROG) doc
#
# N.B.: if you say "make veryclean" followed by "make all", then ".tex"
# files will get made.  But if you then do (for example) a "make clean"
# (which removes ".tex" files if they're present) and then another
# "make all", the ".tex" files won't be rebuilt, because the all target
# uses the doc target as prerequisite, and doc uses the ".dvi" files,
# and the ".dvi" files (which "make clean" doesn't remove) are current.
# So "make all" doesn't really make *all* files, it just makes all the
# "end-product" files and refrains from deleting whatever other stuff
# gets created along the way.
# If you really want to be sure the ".tex" files get built, you can
# (a) define a TEXS variable similar to OBJS, DVIS, etc. and list it
# as a prerequisite for all, (b) explicitly do "make main.tex" and
# likewise for the other modules (there is a ".w.tex" rule for this),
# or (c) do "make scratch" (but that rebuilds *everything*).
#

#
# Rebuild *everything*, from scratch.
# Everything that may already exist is thrown away (except sources),
# then every end-product is built, and nothing that crops up in the
# process is deleted.
#
scratch:
	make veryclean
	make all

#
# The master ".dvi" file can't be made until other files have been
# created (because it reads in their .toc and .tex files).
#
$(PROG).dvi: $(DVIS) mod.lst

#
# This rule is included so that you can make all the ".dvi" files
# for the project by saying "make doc", although (as you can see)
# it is simply an alias for a command to make the master ".dvi" file
# (since that one has all the others as prerequisites).
#
doc: $(PROG).dvi

mod.lst: Makefile
	echo "$(MODS)" | tr ' ' '\012' > mod.lst
#
#  I hope I haven't made this hopelessly UNIX-dependent, but it
#  is a really neat hack.  The "echo/tr" line writes the module names,
#  one per line, to the file "mod.lst".  If your system doesn't have
#  "echo" and "tr", any other way of doing that is fine.  The file
#  "$(PROG).tex" file reads in "mod.lst"; that way the complete doc file
#  can be made without having to manually edit the current list of source
#  modules into the TeX source.  You only have to maintain this Makefile.
#  Of course, this means that "mod.lst" must be changed whenever the
#  Makefile is edited (because new modules might have been added), which
#  is why the Makefile is the prerequisite for "mod.lst".
#


#
# make PostScript files from the ".dvi" files
#
ps: $(PSS) $(PROG).ps

#
# make PostScript files (if they don't already exist)
# and send them to the printer
#
print: ps
	lpr $(PSS) $(PROG).ps

#
# remove the intermediate files used to create the executable
#
nobin::
	rm -f *.[cho]

#
# remove all documentation-related files (".dvi" files and the
# intermediates that were used to create them)
#
nodoc::
	rm -f *.tex *.dvi *.toc *.log *.sec *.inx *.ps mod.lst

#
# remove all the intermediate files used to build the "result" files
# (the executable for the program, and the ".dvi" files, are considered
# to be the "results" of this project; everything else except the CWEB
# files and the Makefile is considered to be "intermediate")
#
clean:: nobin
	rm -f *.tex *.toc *.log *.sec *.inx mod.lst

#
# remove everything but the sources
#
veryclean:: nobin nodoc
	rm -f $(PROG)
