#ifndef CWEB_H
#define CWEB_H


/****************************************************************************/


/* This file was created automatically by CatComp.
 * Do NOT edit by hand!
 */


#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif


/****************************************************************************/


#define MSG_ERROR_CO9 0
#define MSG_ERROR_CO9_STR "! Input line too long"

#define MSG_ERROR_CO13 1
#define MSG_ERROR_CO13_STR "! Missing @x in change file"

#define MSG_ERROR_CO14 2
#define MSG_ERROR_CO14_STR "! Change file ended after @x"

#define MSG_ERROR_CO16_1 3
#define MSG_ERROR_CO16_1_STR "! Change file ended before @y"

#define MSG_ERROR_CO16_2 4
#define MSG_ERROR_CO16_2_STR "! CWEB file ended during a change"

#define MSG_ERROR_CO17_1 5
#define MSG_ERROR_CO17_1_STR "! Where is the matching @y?"

#define MSG_ERROR_CO17_2 6
#define MSG_ERROR_CO17_2_STR "of the preceding lines failed to match"

#define MSG_FATAL_CO19_1 7
#define MSG_FATAL_CO19_1_STR "! Cannot open input file "

#define MSG_FATAL_CO19_2 8
#define MSG_FATAL_CO19_2_STR "! Cannot open change file "

#define MSG_ERROR_CO21_1 9
#define MSG_ERROR_CO21_1_STR "! Include file name not given"

#define MSG_ERROR_CO21_2 10
#define MSG_ERROR_CO21_2_STR "! Too many nested includes"

#define MSG_ERROR_CO22 11
#define MSG_ERROR_CO22_STR "! Include file name too long"

#define MSG_ERROR_CO23 12
#define MSG_ERROR_CO23_STR "! Cannot open include file"

#define MSG_ERROR_CO25_1 13
#define MSG_ERROR_CO25_1_STR "! Change file ended without @z"

#define MSG_ERROR_CO25_2 14
#define MSG_ERROR_CO25_2_STR "! Where is the matching @z?"

#define MSG_ERROR_CO26 15
#define MSG_ERROR_CO26_STR "! Change file entry did not match"

#define MSG_OVERFLOW_CO39_1 16
#define MSG_OVERFLOW_CO39_1_STR "byte memory"

#define MSG_OVERFLOW_CO39_2 17
#define MSG_OVERFLOW_CO39_2_STR "name"

#define MSG_ERROR_CO50_1 18
#define MSG_ERROR_CO50_1_STR "\n! Ambiguous prefix: matches <"

#define MSG_ERROR_CO50_2 19
#define MSG_ERROR_CO50_2_STR ">\n and <"

#define MSG_ERROR_CO52_1 20
#define MSG_ERROR_CO52_1_STR "\n! New name is a prefix of <"

#define MSG_ERROR_CO52_2 21
#define MSG_ERROR_CO52_2_STR "\n! New name extends <"

#define MSG_ERROR_CO52_3 22
#define MSG_ERROR_CO52_3_STR "\n! Section name incompatible with <"

#define MSG_ERROR_CO52_4 23
#define MSG_ERROR_CO52_4_STR ">,\n which abbreviates <"

#define MSG_ERROR_CO59_1 24
#define MSG_ERROR_CO59_1_STR ". (l. %d of change file)\n"

#define MSG_ERROR_CO59_2 25
#define MSG_ERROR_CO59_2_STR ". (l. %d)\n"

#define MSG_ERROR_CO59_3 26
#define MSG_ERROR_CO59_3_STR ". (l. %d of include file %s)\n"

#define MSG_HAPPINESS_CO62 27
#define MSG_HAPPINESS_CO62_STR "(No errors were found.)\n"

#define MSG_WARNING_CO62 28
#define MSG_WARNING_CO62_STR "(Did you see the warning message above?)\n"

#define MSG_ERROR_CO62 29
#define MSG_ERROR_CO62_STR "(Pardon me, but I think I spotted something wrong.)\n"

#define MSG_FATAL_CO62 30
#define MSG_FATAL_CO62_STR "(That was a fatal error, my friend.)\n"

#define MSG_FATAL_CO65 31
#define MSG_FATAL_CO65_STR "\n! Sorry, %s capacity exceeded"

#define MSG_FATAL_CO66 32
#define MSG_FATAL_CO66_STR "! This can't happen: "

#define MSG_FATAL_CO73 33
#define MSG_FATAL_CO73_STR "! Output file name should end with .tex\n"

#define MSG_FATAL_CO75_1 34
#define MSG_FATAL_CO75_1_STR "! Usage: ctangle [options] webfile[.w] [{changefile[.ch]|-} [outfile[.c]]]\nOptions are (+ turns on, - turns off, default in brackets):\nb [+] print banner line\nh [+] print happy message\np [+] give progress reports\ns [-] show statistics\n"

#define MSG_FATAL_CO75_2 35
#define MSG_FATAL_CO75_2_STR "! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\nOptions are (+ turns on, - turns off, default in brackets):\na [+] use AMIGA specific keywords\nb [+] print banner line\nf [+] force line breaks\ng [+] use German macros as of gcwebmac.tex\nh [+] print happy message\ni [+] indent parameter declarations\no [+] separate declarations and statements\np [+] give progress reports\ns [-] show statistics\nx [+] include indexes and table of contents\n"

#define MSG_FATAL_CO75_3 36
#define MSG_FATAL_CO75_3_STR "! Usage: cweave [options] webfile[.w] [{changefile[.ch]|-} [outfile[.tex]]]\nOptions are (+ turns on, - turns off, default in brackets):\nb [+] print banner line\nf [+] force line breaks\ng [+] use German macros as of gcwebmac.tex\nh [+] print happy message\ni [+] indent parameter declarations\no [+] separate declarations and statements\np [+] give progress reports\ns [-] show statistics\nx [+] include indexes and table of contents\n"

#define MSG_FATAL_CO76 37
#define MSG_FATAL_CO76_STR "! File name too long\n"

#define MSG_FATAL_CO78 38
#define MSG_FATAL_CO78_STR "! Cannot open output file "

#define MSG_ERROR_CO82 39
#define MSG_ERROR_CO82_STR "! Include path too long"

#define MSG_FATAL_CO85 40
#define MSG_FATAL_CO85_STR "! Memory allocation failure"

#define MSG_BANNER_CT1 41
#define MSG_BANNER_CT1_STR "This is CTANGLE (Version 3.1 [p9d])\n"

#define MSG_OVERFLOW_CT26 42
#define MSG_OVERFLOW_CT26_STR "token"

#define MSG_OVERFLOW_CT30 43
#define MSG_OVERFLOW_CT30_STR "stack"

#define MSG_ERROR_CT34 44
#define MSG_ERROR_CT34_STR "\n! Not present: <"

#define MSG_OVERFLOW_CT40 45
#define MSG_OVERFLOW_CT40_STR "output files"

#define MSG_WARNING_CT42 46
#define MSG_WARNING_CT42_STR "\n! No program text was specified."

#define MSG_PROGRESS_CT42_1 47
#define MSG_PROGRESS_CT42_1_STR "\nWriting the output file (%s):"

#define MSG_PROGRESS_CT42_2 48
#define MSG_PROGRESS_CT42_2_STR "\nWriting the output files:"

#define MSG_PROGRESS_CT42_3 49
#define MSG_PROGRESS_CT42_3_STR "\nDone."

#define MSG_CONFUSION_CT47 50
#define MSG_CONFUSION_CT47_STR "macro defs have strange char"

#define MSG_ERROR_CT60_1 51
#define MSG_ERROR_CT60_1_STR "! Input ended in mid-comment"

#define MSG_ERROR_CT60_2 52
#define MSG_ERROR_CT60_2_STR "! Section name ended in mid-comment"

#define MSG_ERROR_CT67_1 53
#define MSG_ERROR_CT67_1_STR "! String didn't end"

#define MSG_ERROR_CT67_2 54
#define MSG_ERROR_CT67_2_STR "! Input ended in middle of string"

#define MSG_ERROR_CT67_3 55
#define MSG_ERROR_CT67_3_STR "\n! String too long: "

#define MSG_ERROR_CT68_1 56
#define MSG_ERROR_CT68_1_STR "! Use @l in limbo only"

#define MSG_ERROR_CT68_2 57
#define MSG_ERROR_CT68_2_STR "! Double @ should be used in control text"

#define MSG_ERROR_CT69 58
#define MSG_ERROR_CT69_STR "! Double @ should be used in ASCII constant"

#define MSG_ERROR_CT72_1 59
#define MSG_ERROR_CT72_1_STR "! Input ended in section name"

#define MSG_ERROR_CT72_2 60
#define MSG_ERROR_CT72_2_STR "\n! Section name too long: "

#define MSG_ERROR_CT73_1 61
#define MSG_ERROR_CT73_1_STR "! Section name didn't end"

#define MSG_ERROR_CT73_2 62
#define MSG_ERROR_CT73_2_STR "! Nesting of section names not allowed"

#define MSG_ERROR_CT74 63
#define MSG_ERROR_CT74_STR "! Verbatim string didn't end"

#define MSG_OVERFLOW_CT76 64
#define MSG_OVERFLOW_CT76_STR "text"

#define MSG_ERROR_CT78 65
#define MSG_ERROR_CT78_STR "! @d, @f and @c are ignored in C text"

#define MSG_ERROR_CT79 66
#define MSG_ERROR_CT79_STR "! Missing `@ ' before a named section"

#define MSG_ERROR_CT80 67
#define MSG_ERROR_CT80_STR "! Double @ should be used in string"

#define MSG_ERROR_CT81 68
#define MSG_ERROR_CT81_STR "! Unrecognized escape sequence"

#define MSG_ERROR_CT85 69
#define MSG_ERROR_CT85_STR "! Definition flushed, must start with identifier"

#define MSG_ERROR_CT93 70
#define MSG_ERROR_CT93_STR "! Double @ should be used in limbo"

#define MSG_ERROR_CT94_1 71
#define MSG_ERROR_CT94_1_STR "! Improper hex number following @l"

#define MSG_ERROR_CT94_2 72
#define MSG_ERROR_CT94_2_STR "! Replacement string in @l too long"

#define MSG_STATS_CT95_1 73
#define MSG_STATS_CT95_1_STR "\nMemory usage statistics:\n"

#define MSG_STATS_CT95_2 74
#define MSG_STATS_CT95_2_STR "%ld names (out of %ld)\n"

#define MSG_STATS_CT95_3 75
#define MSG_STATS_CT95_3_STR "%ld replacement texts (out of %ld)\n"

#define MSG_STATS_CT95_4 76
#define MSG_STATS_CT95_4_STR "%ld bytes (out of %ld)\n"

#define MSG_STATS_CT95_5 77
#define MSG_STATS_CT95_5_STR "%ld tokens (out of %ld)\n"

#define MSG_BANNER_CW1 78
#define MSG_BANNER_CW1_STR "This is CWEAVE (Version 3.1 [p9d])\n"

#define MSG_OVERFLOW_CW21 79
#define MSG_OVERFLOW_CW21_STR "cross-reference"

#define MSG_ERROR_CW54 80
#define MSG_ERROR_CW54_STR "! Control codes are forbidden in section name"

#define MSG_ERROR_CW56_1 81
#define MSG_ERROR_CW56_1_STR "! Control text didn't end"

#define MSG_ERROR_CW56_2 82
#define MSG_ERROR_CW56_2_STR "! Control codes are forbidden in control text"

#define MSG_OVERFLOW_CW61 83
#define MSG_OVERFLOW_CW61_STR "section number"

#define MSG_ERROR_CW71_1 84
#define MSG_ERROR_CW71_1_STR "! Missing left identifier of @s"

#define MSG_ERROR_CW71_2 85
#define MSG_ERROR_CW71_2_STR "! Missing right identifier of @s"

#define MSG_WARNING_CW75_1 86
#define MSG_WARNING_CW75_1_STR "\n! Never defined: <"

#define MSG_WARNING_CW75_2 87
#define MSG_WARNING_CW75_2_STR "\n! Never used: <"

#define MSG_WARNING_CW85 88
#define MSG_WARNING_CW85_STR "\n! Line had to be broken (output l. %d):\n"

#define MSG_ERROR_CW92_1 89
#define MSG_ERROR_CW92_1_STR "! Missing } in comment"

#define MSG_ERROR_CW92_2 90
#define MSG_ERROR_CW92_2_STR "! Extra } in comment"

#define MSG_ERROR_CW94 91
#define MSG_ERROR_CW94_STR "! Illegal use of @ in comment"

#define MSG_WARNING_CW171 92
#define MSG_WARNING_CW171_STR "\nIrreducible scrap sequence in section %d:"

#define MSG_WARNING_CW172 93
#define MSG_WARNING_CW172_STR "\nTracing after l. %d:\n"

#define MSG_OVERFLOW_CW176 94
#define MSG_OVERFLOW_CW176_STR "scrap/token/text"

#define MSG_ERROR_CW182 95
#define MSG_ERROR_CW182_STR "! Missing `|' after C text"

#define MSG_ERROR_CW201 96
#define MSG_ERROR_CW201_STR "\n! Illegal control code in section name: <"

#define MSG_ERROR_CW202 97
#define MSG_ERROR_CW202_STR "\n! C text in section name didn't end: <"

#define MSG_OVERFLOW_CW202 98
#define MSG_OVERFLOW_CW202_STR "buffer"

#define MSG_PROGRESS_CW204 99
#define MSG_PROGRESS_CW204_STR "\nWriting the output file..."

#define MSG_ERROR_CW209_1 100
#define MSG_ERROR_CW209_1_STR "! TeX string should be in C text only"

#define MSG_ERROR_CW209_2 101
#define MSG_ERROR_CW209_2_STR "! You can't do that in TeX text"

#define MSG_ERROR_CW213 102
#define MSG_ERROR_CW213_STR "! Improper macro definition"

#define MSG_ERROR_CW214 103
#define MSG_ERROR_CW214_STR "! Improper format definition"

#define MSG_ERROR_CW217 104
#define MSG_ERROR_CW217_STR "! You need an = sign after the section name"

#define MSG_ERROR_CW218 105
#define MSG_ERROR_CW218_STR "! You can't do that in C text"

#define MSG_PROGRESS_CW225 106
#define MSG_PROGRESS_CW225_STR "\nWriting the index..."

#define MSG_FATAL_CW225_1 107
#define MSG_FATAL_CW225_1_STR "! Cannot open index file "

#define MSG_FATAL_CW225_2 108
#define MSG_FATAL_CW225_2_STR "! Cannot open section file "

#define MSG_OVERFLOW_CW237 109
#define MSG_OVERFLOW_CW237_STR "sorting"

#define MSG_STATS_CW248_1 110
#define MSG_STATS_CW248_1_STR "%ld cross-references (out of %ld)\n"

#define MSG_STATS_CW248_2 111
#define MSG_STATS_CW248_2_STR "Parsing:\n"

#define MSG_STATS_CW248_3 112
#define MSG_STATS_CW248_3_STR "%ld scraps (out of %ld)\n"

#define MSG_STATS_CW248_4 113
#define MSG_STATS_CW248_4_STR "%ld texts (out of %ld)\n"

#define MSG_STATS_CW248_5 114
#define MSG_STATS_CW248_5_STR "%ld levels (out of %ld)\n"

#define MSG_STATS_CW248_6 115
#define MSG_STATS_CW248_6_STR "Sorting:\n"


/****************************************************************************/


#ifdef STRINGARRAY

struct AppString
{
    LONG   as_ID;
    STRPTR as_Str;
};

struct AppString AppStrings[] =
{
    {MSG_ERROR_CO9,MSG_ERROR_CO9_STR},
    {MSG_ERROR_CO13,MSG_ERROR_CO13_STR},
    {MSG_ERROR_CO14,MSG_ERROR_CO14_STR},
    {MSG_ERROR_CO16_1,MSG_ERROR_CO16_1_STR},
    {MSG_ERROR_CO16_2,MSG_ERROR_CO16_2_STR},
    {MSG_ERROR_CO17_1,MSG_ERROR_CO17_1_STR},
    {MSG_ERROR_CO17_2,MSG_ERROR_CO17_2_STR},
    {MSG_FATAL_CO19_1,MSG_FATAL_CO19_1_STR},
    {MSG_FATAL_CO19_2,MSG_FATAL_CO19_2_STR},
    {MSG_ERROR_CO21_1,MSG_ERROR_CO21_1_STR},
    {MSG_ERROR_CO21_2,MSG_ERROR_CO21_2_STR},
    {MSG_ERROR_CO22,MSG_ERROR_CO22_STR},
    {MSG_ERROR_CO23,MSG_ERROR_CO23_STR},
    {MSG_ERROR_CO25_1,MSG_ERROR_CO25_1_STR},
    {MSG_ERROR_CO25_2,MSG_ERROR_CO25_2_STR},
    {MSG_ERROR_CO26,MSG_ERROR_CO26_STR},
    {MSG_OVERFLOW_CO39_1,MSG_OVERFLOW_CO39_1_STR},
    {MSG_OVERFLOW_CO39_2,MSG_OVERFLOW_CO39_2_STR},
    {MSG_ERROR_CO50_1,MSG_ERROR_CO50_1_STR},
    {MSG_ERROR_CO50_2,MSG_ERROR_CO50_2_STR},
    {MSG_ERROR_CO52_1,MSG_ERROR_CO52_1_STR},
    {MSG_ERROR_CO52_2,MSG_ERROR_CO52_2_STR},
    {MSG_ERROR_CO52_3,MSG_ERROR_CO52_3_STR},
    {MSG_ERROR_CO52_4,MSG_ERROR_CO52_4_STR},
    {MSG_ERROR_CO59_1,MSG_ERROR_CO59_1_STR},
    {MSG_ERROR_CO59_2,MSG_ERROR_CO59_2_STR},
    {MSG_ERROR_CO59_3,MSG_ERROR_CO59_3_STR},
    {MSG_HAPPINESS_CO62,MSG_HAPPINESS_CO62_STR},
    {MSG_WARNING_CO62,MSG_WARNING_CO62_STR},
    {MSG_ERROR_CO62,MSG_ERROR_CO62_STR},
    {MSG_FATAL_CO62,MSG_FATAL_CO62_STR},
    {MSG_FATAL_CO65,MSG_FATAL_CO65_STR},
    {MSG_FATAL_CO66,MSG_FATAL_CO66_STR},
    {MSG_FATAL_CO73,MSG_FATAL_CO73_STR},
    {MSG_FATAL_CO75_1,MSG_FATAL_CO75_1_STR},
    {MSG_FATAL_CO75_2,MSG_FATAL_CO75_2_STR},
    {MSG_FATAL_CO75_3,MSG_FATAL_CO75_3_STR},
    {MSG_FATAL_CO76,MSG_FATAL_CO76_STR},
    {MSG_FATAL_CO78,MSG_FATAL_CO78_STR},
    {MSG_ERROR_CO82,MSG_ERROR_CO82_STR},
    {MSG_FATAL_CO85,MSG_FATAL_CO85_STR},
    {MSG_BANNER_CT1,MSG_BANNER_CT1_STR},
    {MSG_OVERFLOW_CT26,MSG_OVERFLOW_CT26_STR},
    {MSG_OVERFLOW_CT30,MSG_OVERFLOW_CT30_STR},
    {MSG_ERROR_CT34,MSG_ERROR_CT34_STR},
    {MSG_OVERFLOW_CT40,MSG_OVERFLOW_CT40_STR},
    {MSG_WARNING_CT42,MSG_WARNING_CT42_STR},
    {MSG_PROGRESS_CT42_1,MSG_PROGRESS_CT42_1_STR},
    {MSG_PROGRESS_CT42_2,MSG_PROGRESS_CT42_2_STR},
    {MSG_PROGRESS_CT42_3,MSG_PROGRESS_CT42_3_STR},
    {MSG_CONFUSION_CT47,MSG_CONFUSION_CT47_STR},
    {MSG_ERROR_CT60_1,MSG_ERROR_CT60_1_STR},
    {MSG_ERROR_CT60_2,MSG_ERROR_CT60_2_STR},
    {MSG_ERROR_CT67_1,MSG_ERROR_CT67_1_STR},
    {MSG_ERROR_CT67_2,MSG_ERROR_CT67_2_STR},
    {MSG_ERROR_CT67_3,MSG_ERROR_CT67_3_STR},
    {MSG_ERROR_CT68_1,MSG_ERROR_CT68_1_STR},
    {MSG_ERROR_CT68_2,MSG_ERROR_CT68_2_STR},
    {MSG_ERROR_CT69,MSG_ERROR_CT69_STR},
    {MSG_ERROR_CT72_1,MSG_ERROR_CT72_1_STR},
    {MSG_ERROR_CT72_2,MSG_ERROR_CT72_2_STR},
    {MSG_ERROR_CT73_1,MSG_ERROR_CT73_1_STR},
    {MSG_ERROR_CT73_2,MSG_ERROR_CT73_2_STR},
    {MSG_ERROR_CT74,MSG_ERROR_CT74_STR},
    {MSG_OVERFLOW_CT76,MSG_OVERFLOW_CT76_STR},
    {MSG_ERROR_CT78,MSG_ERROR_CT78_STR},
    {MSG_ERROR_CT79,MSG_ERROR_CT79_STR},
    {MSG_ERROR_CT80,MSG_ERROR_CT80_STR},
    {MSG_ERROR_CT81,MSG_ERROR_CT81_STR},
    {MSG_ERROR_CT85,MSG_ERROR_CT85_STR},
    {MSG_ERROR_CT93,MSG_ERROR_CT93_STR},
    {MSG_ERROR_CT94_1,MSG_ERROR_CT94_1_STR},
    {MSG_ERROR_CT94_2,MSG_ERROR_CT94_2_STR},
    {MSG_STATS_CT95_1,MSG_STATS_CT95_1_STR},
    {MSG_STATS_CT95_2,MSG_STATS_CT95_2_STR},
    {MSG_STATS_CT95_3,MSG_STATS_CT95_3_STR},
    {MSG_STATS_CT95_4,MSG_STATS_CT95_4_STR},
    {MSG_STATS_CT95_5,MSG_STATS_CT95_5_STR},
    {MSG_BANNER_CW1,MSG_BANNER_CW1_STR},
    {MSG_OVERFLOW_CW21,MSG_OVERFLOW_CW21_STR},
    {MSG_ERROR_CW54,MSG_ERROR_CW54_STR},
    {MSG_ERROR_CW56_1,MSG_ERROR_CW56_1_STR},
    {MSG_ERROR_CW56_2,MSG_ERROR_CW56_2_STR},
    {MSG_OVERFLOW_CW61,MSG_OVERFLOW_CW61_STR},
    {MSG_ERROR_CW71_1,MSG_ERROR_CW71_1_STR},
    {MSG_ERROR_CW71_2,MSG_ERROR_CW71_2_STR},
    {MSG_WARNING_CW75_1,MSG_WARNING_CW75_1_STR},
    {MSG_WARNING_CW75_2,MSG_WARNING_CW75_2_STR},
    {MSG_WARNING_CW85,MSG_WARNING_CW85_STR},
    {MSG_ERROR_CW92_1,MSG_ERROR_CW92_1_STR},
    {MSG_ERROR_CW92_2,MSG_ERROR_CW92_2_STR},
    {MSG_ERROR_CW94,MSG_ERROR_CW94_STR},
    {MSG_WARNING_CW171,MSG_WARNING_CW171_STR},
    {MSG_WARNING_CW172,MSG_WARNING_CW172_STR},
    {MSG_OVERFLOW_CW176,MSG_OVERFLOW_CW176_STR},
    {MSG_ERROR_CW182,MSG_ERROR_CW182_STR},
    {MSG_ERROR_CW201,MSG_ERROR_CW201_STR},
    {MSG_ERROR_CW202,MSG_ERROR_CW202_STR},
    {MSG_OVERFLOW_CW202,MSG_OVERFLOW_CW202_STR},
    {MSG_PROGRESS_CW204,MSG_PROGRESS_CW204_STR},
    {MSG_ERROR_CW209_1,MSG_ERROR_CW209_1_STR},
    {MSG_ERROR_CW209_2,MSG_ERROR_CW209_2_STR},
    {MSG_ERROR_CW213,MSG_ERROR_CW213_STR},
    {MSG_ERROR_CW214,MSG_ERROR_CW214_STR},
    {MSG_ERROR_CW217,MSG_ERROR_CW217_STR},
    {MSG_ERROR_CW218,MSG_ERROR_CW218_STR},
    {MSG_PROGRESS_CW225,MSG_PROGRESS_CW225_STR},
    {MSG_FATAL_CW225_1,MSG_FATAL_CW225_1_STR},
    {MSG_FATAL_CW225_2,MSG_FATAL_CW225_2_STR},
    {MSG_OVERFLOW_CW237,MSG_OVERFLOW_CW237_STR},
    {MSG_STATS_CW248_1,MSG_STATS_CW248_1_STR},
    {MSG_STATS_CW248_2,MSG_STATS_CW248_2_STR},
    {MSG_STATS_CW248_3,MSG_STATS_CW248_3_STR},
    {MSG_STATS_CW248_4,MSG_STATS_CW248_4_STR},
    {MSG_STATS_CW248_5,MSG_STATS_CW248_5_STR},
    {MSG_STATS_CW248_6,MSG_STATS_CW248_6_STR},
};


#endif /* STRINGARRAY */


/****************************************************************************/


#endif /* CWEB_H */
