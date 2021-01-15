Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B662C2F715C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 05:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAOEE6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jan 2021 23:04:58 -0500
Received: from condef-01.nifty.com ([202.248.20.66]:42267 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOEE5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2021 23:04:57 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 23:04:54 EST
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-01.nifty.com with ESMTP id 10F3tq6i029495
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 12:55:52 +0900
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 10F3spac023891;
        Fri, 15 Jan 2021 12:54:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 10F3spac023891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610682892;
        bh=dvrxZUq6ijykTnD91sHJvb7lCcdoTSyu0O0fWTAIYoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XpGecBRfbzNDU1XRdw1oyaJIK3vWxD6xDaUs+7+0sPJwF1P4Top3cwMgfEEOEXrbZ
         g69CJGtjw7ZznqUCcJaDndISi97C5zZV3fynAWMCKXv2Yft+cRH7wYu1AH8F0h5/69
         xG2eEptBC+ocQN7fjNW9Vm2WIrITAeNoUQ2Dv6KmT/pQRneRK88xVLwGZo6KT98MLe
         uIOLlw50mRZTTex7a9YuJKI7Org7OZ1oGs6VP4FHU8o1JjZLfHLM1cpirKQvRDhBkK
         mlC0LaFoLs/OVjj8RlNOEbMnkE61ByFYAewT7jC0xTA2MvaMz6qundc0HyguKEbYww
         xNJdG6fWFrZRw==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id w1so5590902pjc.0;
        Thu, 14 Jan 2021 19:54:51 -0800 (PST)
X-Gm-Message-State: AOAM533yT2HQsa6AohArVXyUrnknzarNJJ3rBrXjcNU89W50kHzplvIj
        pBgKGvDbxwYKleXs/UGOxIga82Wysr4nB0Lz46s=
X-Google-Smtp-Source: ABdhPJw+5aw6ebzdJ+mKRENfXlgdBo73zbYuYnZY3ng8MDzKIn4MxHq2U55gy6kd0YoA6Fb27j1lfF6zZQETnpBdjhs=
X-Received: by 2002:a17:90a:c910:: with SMTP id v16mr8357377pjt.198.1610682890563;
 Thu, 14 Jan 2021 19:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-3-ndesaulniers@google.com> <CA+icZUV6pNP1AN_JEhqon6Hgk3Yfq0_VNghvRX0N9mw6pGtpVw@mail.gmail.com>
 <CAKwvOdm40Z3YutxwWyV922XdchN7Dz+v9kJNjF13vKxNUXrJnQ@mail.gmail.com>
In-Reply-To: <CAKwvOdm40Z3YutxwWyV922XdchN7Dz+v9kJNjF13vKxNUXrJnQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Jan 2021 12:54:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkCbm-075tPrNgR8s-fQ5y4MTjPQXhKO04JT+2X6R-GQ@mail.gmail.com>
Message-ID: <CAK7LNASkCbm-075tPrNgR8s-fQ5y4MTjPQXhKO04JT+2X6R-GQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Kbuild: make DWARF version a choice
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 14, 2021 at 8:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Sedat,
> Thanks for testing, and congrats on https://lwn.net/Articles/839772/.
> I always appreciate you taking the time to help test my work, and
> other Clang+Linux kernel patches!
>
> On Wed, Jan 13, 2021 at 1:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
> >
> > On Wed, Jan 13, 2021 at 1:32 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -826,12 +826,16 @@ else
> > >  DEBUG_CFLAGS   +=3D -g
> > >  endif
> > >
> > > -ifneq ($(LLVM_IAS),1)
> > > -KBUILD_AFLAGS  +=3D -Wa,-gdwarf-2
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) :=3D 2
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) :=3D 4
> > > +DEBUG_CFLAGS   +=3D -gdwarf-$(dwarf-version-y)
>
> ^ DEBUG_CFLAGS are set for everyone (all toolchains) if
> CONFIG_DEBUG_INFO is defined.
>
> > > +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
>
> ^ "If not using dwarf 2 and LLVM_IAS=3D1", ie. CONFIG_DEBUG_INFO_DWARF5
> && CONFIG_CC_IS_GCC
>
> > > +# Binutils 2.35+ required for -gdwarf-4+ support.
> > > +dwarf-aflag    :=3D $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-vers=
ion-y))
> > > +ifdef CONFIG_CC_IS_CLANG
>
> ^ "if clang"
>
> > > +DEBUG_CFLAGS   +=3D $(dwarf-aflag)
> > >  endif
> >
> > Why is that "ifdef CONFIG_CC_IS_CLANG"?
>
> That's what Arvind requested on v2, IIUC:
> https://lore.kernel.org/lkml/X8psgMuL4jMjP%2FOy@rani.riverdale.lan/



If CONFIG_CC_IS_CLANG is set,
both -gdwarf and -Wa,-gdwarf-4 are passed to DEBUG_CFLAGS.

Is it necessary?



IIUC, -Wa,-gdwarf is meaningless
when you build *.c files.


I passed -v option to see
how gas is invoked behind the scene.


See the following results
for [1] GCC + GAS and [2] Clang + GAS cases




[1] GCC + GAS


masahiro@grover:~$ cat test.c
int main(void) { return 0; }
masahiro@grover:~$ gcc -v -gdwarf-4 -c -o test.o test.c
Using built-in specs.
COLLECT_GCC=3Dgcc
OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa:hsa
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu
10.2.0-13ubuntu1'
--with-bugurl=3Dfile:///usr/share/doc/gcc-10/README.Bugs
--enable-languages=3Dc,ada,c++,go,brig,d,fortran,objc,obj-c++,m2
--prefix=3D/usr --with-gcc-major-version-only --program-suffix=3D-10
--program-prefix=3Dx86_64-linux-gnu- --enable-shared
--enable-linker-build-id --libexecdir=3D/usr/lib
--without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib
--enable-nls --enable-clocale=3Dgnu --enable-libstdcxx-debug
--enable-libstdcxx-time=3Dyes --with-default-libstdcxx-abi=3Dnew
--enable-gnu-unique-object --disable-vtable-verify --enable-plugin
--enable-default-pie --with-system-zlib
--enable-libphobos-checking=3Drelease --with-target-system-zlib=3Dauto
--enable-objc-gc=3Dauto --enable-multiarch --disable-werror
--with-arch-32=3Di686 --with-abi=3Dm64 --with-multilib-list=3Dm32,m64,mx32
--enable-multilib --with-tune=3Dgeneric
--enable-offload-targets=3Dnvptx-none=3D/build/gcc-10-JvwpWM/gcc-10-10.2.0/=
debian/tmp-nvptx/usr,amdgcn-amdhsa=3D/build/gcc-10-JvwpWM/gcc-10-10.2.0/deb=
ian/tmp-gcn/usr,hsa
--without-cuda-driver --enable-checking=3Drelease
--build=3Dx86_64-linux-gnu --host=3Dx86_64-linux-gnu
--target=3Dx86_64-linux-gnu
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 10.2.0 (Ubuntu 10.2.0-13ubuntu1)
COLLECT_GCC_OPTIONS=3D'-v' '-gdwarf-4' '-c' '-o' 'test.o'
'-mtune=3Dgeneric' '-march=3Dx86-64'
 /usr/lib/gcc/x86_64-linux-gnu/10/cc1 -quiet -v -imultiarch
x86_64-linux-gnu test.c -quiet -dumpbase test.c -mtune=3Dgeneric
-march=3Dx86-64 -auxbase-strip test.o -gdwarf-4 -version
-fasynchronous-unwind-tables -fstack-protector-strong -Wformat
-Wformat-security -fstack-clash-protection -fcf-protection -o
/tmp/cc4hKJeo.s
GNU C17 (Ubuntu 10.2.0-13ubuntu1) version 10.2.0 (x86_64-linux-gnu)
compiled by GNU C version 10.2.0, GMP version 6.2.0, MPFR version
4.1.0, MPC version 1.2.0-rc1, isl version isl-0.22.1-GMP

GGC heuristics: --param ggc-min-expand=3D100 --param ggc-min-heapsize=3D131=
072
ignoring nonexistent directory "/usr/local/include/x86_64-linux-gnu"
ignoring nonexistent directory "/usr/lib/gcc/x86_64-linux-gnu/10/include-fi=
xed"
ignoring nonexistent directory
"/usr/lib/gcc/x86_64-linux-gnu/10/../../../../x86_64-linux-gnu/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/lib/gcc/x86_64-linux-gnu/10/include
 /usr/local/include
 /usr/include/x86_64-linux-gnu
 /usr/include
End of search list.
GNU C17 (Ubuntu 10.2.0-13ubuntu1) version 10.2.0 (x86_64-linux-gnu)
compiled by GNU C version 10.2.0, GMP version 6.2.0, MPFR version
4.1.0, MPC version 1.2.0-rc1, isl version isl-0.22.1-GMP

GGC heuristics: --param ggc-min-expand=3D100 --param ggc-min-heapsize=3D131=
072
Compiler executable checksum: 4831429547eb0be4fec215fca56ed5cf
COLLECT_GCC_OPTIONS=3D'-v' '-gdwarf-4' '-c' '-o' 'test.o'
'-mtune=3Dgeneric' '-march=3Dx86-64'
 as -v --64 -o test.o /tmp/cc4hKJeo.s
GNU assembler version 2.35.1 (x86_64-linux-gnu) using BFD version (GNU
Binutils for Ubuntu) 2.35.1
COMPILER_PATH=3D/usr/lib/gcc/x86_64-linux-gnu/10/:/usr/lib/gcc/x86_64-linux=
-gnu/10/:/usr/lib/gcc/x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/10/:/=
usr/lib/gcc/x86_64-linux-gnu/
LIBRARY_PATH=3D/usr/lib/gcc/x86_64-linux-gnu/10/:/usr/lib/gcc/x86_64-linux-=
gnu/10/../../../x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/10/../../..=
/../lib/:/lib/x86_64-linux-gnu/:/lib/../lib/:/usr/lib/x86_64-linux-gnu/:/us=
r/lib/../lib/:/usr/lib/gcc/x86_64-linux-gnu/10/../../../:/lib/:/usr/lib/
COLLECT_GCC_OPTIONS=3D'-v' '-gdwarf-4' '-c' '-o' 'test.o'
'-mtune=3Dgeneric' '-march=3Dx86-64'
masahiro@grover:~$ readelf  --debug-dump=3Dinfo test.o
Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x4f (32-bit)
   Version:       4
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <c>   DW_AT_producer    : (indirect string, offset: 0x16): GNU C17
10.2.0 -mtune=3Dgeneric -march=3Dx86-64 -gdwarf-4
-fasynchronous-unwind-tables -fstack-protector-strong
-fstack-clash-protection -fcf-protection
    <10>   DW_AT_language    : 12 (ANSI C99)
    <11>   DW_AT_name        : (indirect string, offset: 0xf): test.c
    <15>   DW_AT_comp_dir    : (indirect string, offset: 0x0): /home/masahi=
ro
    <19>   DW_AT_low_pc      : 0x0
    <21>   DW_AT_high_pc     : 0xf
    <29>   DW_AT_stmt_list   : 0x0
 <1><2d>: Abbrev Number: 2 (DW_TAG_subprogram)
    <2e>   DW_AT_external    : 1
    <2e>   DW_AT_name        : (indirect string, offset: 0xab): main
    <32>   DW_AT_decl_file   : 1
    <33>   DW_AT_decl_line   : 1
    <34>   DW_AT_decl_column : 5
    <35>   DW_AT_prototyped  : 1
    <35>   DW_AT_type        : <0x4b>
    <39>   DW_AT_low_pc      : 0x0
    <41>   DW_AT_high_pc     : 0xf
    <49>   DW_AT_frame_base  : 1 byte block: 9c (DW_OP_call_frame_cfa)
    <4b>   DW_AT_GNU_all_call_sites: 1
 <1><4b>: Abbrev Number: 3 (DW_TAG_base_type)
    <4c>   DW_AT_byte_size   : 4
    <4d>   DW_AT_encoding    : 5 (signed)
    <4e>   DW_AT_name        : int
 <1><52>: Abbrev Number: 0





[2] Clang + GAS

masahiro@grover:~$ clang -v -fno-integrated-as -gdwarf-4 -c -o test.o test.=
c
Ubuntu clang version 11.0.0-2
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/10
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/8
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/10
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/8
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/9
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/10
Candidate multilib: .;@m64
Selected multilib: .;@m64
 "/usr/lib/llvm-11/bin/clang" -cc1 -triple x86_64-pc-linux-gnu -S
-disable-free -disable-llvm-verifier -discard-value-names
-main-file-name test.c -mrelocation-model static -mframe-pointer=3Dall
-fmath-errno -fno-rounding-math -no-integrated-as
-mconstructor-aliases -munwind-tables -target-cpu x86-64
-fno-split-dwarf-inlining -debug-info-kind=3Dlimited -dwarf-version=3D4
-debugger-tuning=3Dgdb -v -resource-dir
/usr/lib/llvm-11/lib/clang/11.0.0 -internal-isystem /usr/local/include
-internal-isystem /usr/lib/llvm-11/lib/clang/11.0.0/include
-internal-externc-isystem /usr/include/x86_64-linux-gnu
-internal-externc-isystem /include -internal-externc-isystem
/usr/include -fno-dwarf-directory-asm -fdebug-compilation-dir
/home/masahiro -ferror-limit 19 -fgnuc-version=3D4.2.1
-fcolor-diagnostics -o /tmp/test-f43580.s -x c test.c
clang -cc1 version 11.0.0 based upon LLVM 11.0.0 default target
x86_64-pc-linux-gnu
ignoring nonexistent directory "/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/local/include
 /usr/lib/llvm-11/lib/clang/11.0.0/include
 /usr/include/x86_64-linux-gnu
 /usr/include
End of search list.
 "/usr/bin/as" --64 -o test.o /tmp/test-f43580.s
masahiro@grover:~$ readelf  --debug-dump=3Dinfo test.o
Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x47 (32-bit)
   Version:       4
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <c>   DW_AT_producer    : (indirect string, offset: 0x0): Ubuntu
clang version 11.0.0-2
    <10>   DW_AT_language    : 12 (ANSI C99)
    <12>   DW_AT_name        : (indirect string, offset: 0x1e): test.c
    <16>   DW_AT_stmt_list   : 0x0
    <1a>   DW_AT_comp_dir    : (indirect string, offset: 0x25): /home/masah=
iro
    <1e>   DW_AT_low_pc      : 0x0
    <26>   DW_AT_high_pc     : 0xf
 <1><2a>: Abbrev Number: 2 (DW_TAG_subprogram)
    <2b>   DW_AT_low_pc      : 0x0
    <33>   DW_AT_high_pc     : 0xf
    <37>   DW_AT_frame_base  : 1 byte block: 56 (DW_OP_reg6 (rbp))
    <39>   DW_AT_name        : (indirect string, offset: 0x34): main
    <3d>   DW_AT_decl_file   : 1
    <3e>   DW_AT_decl_line   : 1
    <3f>   DW_AT_prototyped  : 1
    <3f>   DW_AT_type        : <0x43>
    <43>   DW_AT_external    : 1
 <1><43>: Abbrev Number: 3 (DW_TAG_base_type)
    <44>   DW_AT_name        : (indirect string, offset: 0x39): int
    <48>   DW_AT_encoding    : 5 (signed)
    <49>   DW_AT_byte_size   : 4
 <1><4a>: Abbrev Number: 0






In [1],  "as -v --64 -o test.o /tmp/cc4hKJeo.s"
is the command that invoked gas.

There is no -gdwarf-4 option passed to gas here,
but the produced object has the correct dwarf4 info.




In [2],   "/usr/bin/as" --64 -o test.o /tmp/test-f43580.s
is the command that invoked gas.

Again, no -gdwarf-4 option here,
but the produced object has the correct dwarf4 info.




So, when you build *.c -> *.o,
passing -gdwarf-* is enough.

The debug info is generated in the compile stage (i.e. by cc1)
and included in the intermediate /tmp/*.s file.

All gas needs to do is to transform the debug sections
in the intermediate /tmp/*.s file
into the binary stream in the .o file.
GAS does it without being instructed by the
explicit -Wa,-gdwarf-* option.


In my understanding, passing -Wa,-gdwarf
makes sense only when you build *.S -> *.o


This is why I think
  DEBUG_CFLAGS +=3D -gdwarf-4   (for source debug of .c files)
and
  KBUILD_AFLAGS +=3D -Wa,gdwarf-4  (for source debug of .S files)

are basically orthogonal (and they can be even controlled by
separate CONFIG options).


As stated above,  DEBUG_CFLAGS +=3D -Wa,gdward-4
does not make sense.


I am not a compiler expert, but
that is what I understood from some experiments.

Please correct me if I am wrong.






> > When I use GCC v10.2.1 DEBUG_CFLAGS are not set.
>
> You should have -gdwarf-4 (and not -Wa,-gwarf-4) set for DEBUG_CFLAGS
> when compiling with GCC and enabling CONFIG_DEBUG_INFO_DWARF4. Can you
> please confirm? (Perhaps you may have accidentally disabled
> CONFIG_DEBUG_INFO by rerunning `make defconfig`?)
> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards


Masahiro Yamada
