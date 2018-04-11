# Rtools: GCC 4.9.3

Rtools versions `3.3.x`, `3.4.x` and `3.5.x` ship with a mingw-w64 toolchain
based on gcc 4.9.3. Below some notes on how this toolchain was configured.

## Summary

_The new Rtools compiler for windows is based on GCC 4.9.3 and Mingw-W64 V3. 
It does not support multilib: instead we ship separate compilers targeting
win32 and win64. R already supports this by setting `BINPREF` in `MkRules`.
The main challenge in this update is that the new compilers use another C++
exception model (dwarf/seh instead of sjlj). Therefore static C++ libraries
(`libfoo.a` files) which have been deployed on CRAN (icu, gdal, quantlib, 
etc) will need a rebuild. Shared libraries (DLL files) and plain C libraries
should be unaffected. The good news is that the new tool chain is more 
standard, reliable and performant. This makes porting packages to Windows 
easier than before. Moreover, future upgrades of the tool chain should be 
much less painful than this time._

## Introduction

Rtools <= 3.2 was put together by Brian Ripley. It was configured with:

 - gcc 4.6.3 pre-release
 - mingw-w64 V2
 - sjlj exceptions
 - win32 host with multilib
 - static-gcc

Updating the tool chain in a way that is compatible with the old one has
proven to be challenging. Two major problems:

 - __exceptions__: Rcpp mixes c++ exceptions with R's `setjmp-longjmp` system,
   potentially between multiple Rcpp-module dll files. Unfortunately this 
   does not work well anymore with `sjlj` in recent versions of gcc. Therefore
   we have to switch to another exception model.

 - __math__: the mingw-w64 math implementations have a some peculiarities 
   for e.g. numeric precision or NaN handling. Currently the `V3` runtime 
   gives more consistent results than the `V4` runtime (the latter is only
   needed for gcc 5).

Over the past year, several people have been testing and debugging many 
different variations of the tool chain. As of August 2015 there is a 
special [r-sig-windows][9] mailing list for dicusssing building R and R packages
on Windows.

[9]: https://stat.ethz.ch/pipermail/r-sig-windows/

Some people that have been contributing to the process include:

 - Duncan Murdoch
 - Uwe Ligges
 - Qiang Kou (KK)
 - Kevin Ushey
 - JJ Allaire
 - Avraham Adler 
 - Jeroen Ooms

## The tool chain

The new rtools were compiled using the [*mingw-builds* scripts][1]. These
scripts are thorougly tested and used by the mingw-w64 project itself to 
publish builds on their [sourceforge page][3]. In contrast to the old tool
chain, the new tool chain does not support multilib. Therefore we actually
have two toolchains: one for compiling win32 and one for compiling win64. 
The full conventional names of these toolchains are:

 - [`i686-493-posix-dwarf-rt_v3-s`](http://www.stat.ucla.edu/~jeroen/mingw-w64/archive/gcc-4.9.3/i686-493-posix-dwarf-rt_v3-s.zip) for win32
 - [`x86_64-493-posix-seh-rt_v3-s`](http://www.stat.ucla.edu/~jeroen/mingw-w64/archive/gcc-4.9.3/x86_64-493-posix-seh-rt_v3-s.zip) for win64

A full copy of these tool chains is also included with RTools 3.3.
A breakdown of this naming convention:

 - Target: `i686` or `x86_64`
 - GCC version: `4.9.3`
 - Threading interface: `posix`
 - Exception model: `dwarf` on win32 and `seh` on win64
 - Mingw-w64 runtime version: `rt_v3`
 - The `-s` postfix means `--static-gcc`: software compiled with the tool 
   chain does not depend on external DLL files such as `libgfortran-3.dll`,
   `libstdc++-6.dll`, `libwinpthread-1.dll`, etc. 

To reproduce the tool chain, download the [mingw-builds scripts][1] 
(currently the branch is named 'develop') and run the following command 
inside msys2:

```sh
# Build i686-493-posix-dwarf-rt_v3-s
./build --mode=gcc-4.9.3 --rt-version=v3 --arch=i686 --exceptions=dwarf --static-gcc --threads=posix --enable-languages=c,c++,fortran 

# Build x86_64-493-posix-seh-rt_v3-s
./build --mode=gcc-4.9.3 --rt-version=v3 --arch=x86_64 --exceptions=seh --static-gcc --threads=posix --enable-languages=c,c++,fortran
```

The new chain is larger in size than the old one. This is mostly because
we are shipping two seperate tool chains instead of one multilib. But
another reason is that recent versions of GDB now depend on python, which
again depends on a lot of other libraries. There is little we can do about
this, but with the price of disk space and network these days I don't think
this should be a problem.

[1]: https://github.com/niXman/mingw-builds/tree/develop
[2]: http://bit.ly/mingw32
[3]: http://bit.ly/mingw64
[4]: http://www.stat.ucla.edu/~jeroen/mingw-w64/archive/gcc-4.9.3/

## Exception model

The new tool chain uses a different c++ exception model than the previous
tool chain. The old gcc 4.6.3 tool chain used `sjlj` exceptions which are 
available on both win32 and win64 and therefore allowed for a multilib
tool chain. Unfortunately `sjlj` does not work well with recent features 
in gcc. The mingw-w64 authors recommend to switch to `dwarf` on win32 and 
`seh` on win64. These exception models are the default in mingw-w64 since 
gcc 4.8 because they are more reliable and performant. This also means that
they are much better tested and less buggy. We found all of our exception
related problems disappeared after we switched.

The only disadvantage of switching is that it is impossible to link existing
static c++ libraries that were built using `sjlj` with a the new `dwarf` and
`seh` tool chains. Therefore most C++ libraries that have been deployed on 
CRAN and elsewhere will need a rebuild.

However because our new tool chain is more standard, building these libraries
has become much easier. Many libraries are available in the form of source
packages from [msys2][5]. In fact for most libraries we might be able to 
download prebuilt binaries directly from their [repositories][6].

[5]: https://github.com/Alexpux/MINGW-packages/
[6]: http://repo.msys2.org/
