This file describes the Rtools/bin collection, a set of tools to help
build and test R for Windows.

basename cat cmp comm cp cut cygpath date diff du echo expr gzip ls makeinfo
mkdir mv rm rsync sed sort texindex touch uniq

These are extracted from the cygwin collection
(http://sources.redhat.com/cygwin and several mirrors). 

file is compiled from the sources, to look for the "magic" file in 
the same directory as file.exe.

sh is an older version of the Cygwin sh, from before they started
to require Unix-style line endings in scripts.

make is compiled from the sources, altered to use sh.exe in the path 
if this exists (rather than /bin/sh.exe).

tar is compiled from the sources, altered to accept Windows drives
in the path specification.

zip, unzip from the Info-ZIP collection.

texinfo5 (Perl source) is compiled from the sources.

gdb and gdb64 were compiled for inclusion with the gcc 4.6.3 compiler;
both 32 and 64 bit versions are named gdb with the gcc 4.9.3 compiler.

Please note that find and sort have the same names as Windows
utilities; if you want to access the Windows ones while ours are on
the path, you could rename our utilities and edit the FIND and SORT
macros in src/gnuwin32/MkRules, but note that this option is rarely
tested:  we prefer the Rtools utilities to the Windows ones.


Extras
======

Also included are egrep, find, gawk, grep, head and wc (which used to be
needed), as well as ln, od, rmdir and tr which are needed by some
configure scripts.

md5sum can be used to create checksums, or check checksum files.

pedump is very useful for examining DLLs for imports and exports.


Sources
=======

The current version of this archive will be at

<CRAN mirror>/bin/windows/Rtools

where <CRAN mirror> is your local CRAN mirror from the list at
http://cran.r-project.org/mirrors.html.


License
=======

Many of these files are licensed under the GPL; see the file
COPYING.  For the specific license for any particular file, 
see the source.
