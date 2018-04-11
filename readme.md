# Rtools 3.5 [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rwinlib/rtools35)](https://ci.appveyor.com/project/jeroen/rtools35)

> Windows Toolchain and Build Utilities for R

This repository contains the source files for building the Rtools installer. Official releases can be downloaded from the [Rtools homepage on CRAN](https://cran.r-project.org/bin/windows/Rtools/). The original collection was put together by Prof. Brian Ripley and Duncan Murdoch; it is currently maintained by Jeroen Ooms.

## Contents

The same Rtools bundle is used both for building R itself as well as compiling R packages from source. Most users only need the latter, so the standard installation type will install:

 - 32 and 64 bit mingw-w64 [toolchains](toolchains/#readme) based on gcc 4.9.3
 - Build [utilities](https://github.com/rwinlib/utils): make, bash, tar, etc

In addition, Rtools has optional extras for building R itself:

 - [TexInfo5](https://github.com/rwinlib/texinfo5) for building manuals
 - A copy of [libicu55](https://github.com/rwinlib/icu) static libs
 - [TclTK 8.6](https://github.com/rwinlib/tcltk) required for building the base R package tcltk

For more information about building R itself see the [rwinlib/base](https://github.com/rwinlib/base#readme) repository.

## Build Rtools

The Rtools installer can be built from [rtools.iss](rtools.iss) using [InnoSetup](http://www.jrsoftware.org/isdl.php#stable). Either use the GUI or build from the command line:

```bat
"C:\Program Files (x86)\Inno Setup 5\iscc.exe" rtools.iss
```

All of this is automated on [AppVeyor](https://ci.appveyor.com/project/jeroen/rtools35).
