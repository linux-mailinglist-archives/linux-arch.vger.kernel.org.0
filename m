Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C282F8808
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 23:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAOV6O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbhAOV6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:58:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4FC061757;
        Fri, 15 Jan 2021 13:57:33 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z5so20990986iob.11;
        Fri, 15 Jan 2021 13:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FBVMRQdBC9ScDW4bAdh6zPVr4kliTneT+ezPPvG5nok=;
        b=You9Bm0li6MgFfVhMHXqZ2DqgNVwXoPx/W5xKy89L/ePxiAdjKb5686doRj85u0g1I
         O/WAKbUCujypZ713Gz8c1sMXtYYtmAzbqCkJkn8WN7qpKuD8/ZPs0XqXBBq34mAeZdox
         mnffpCLyz+Ih+k48byEusGW7SDTe6WNjoqQago/i5DVlsVFA4tF3IBpvpT+EXEpZZz9x
         9kNxB80UGCkXANcvRCAr5v0ugDIG+WUheX8ikeTI60rTwuk9NF1HHgvPt7I5IEjTgZ1c
         yoKC+bNry+uVyKacm1oZGb5Ind/5i7vvDUoPXXEa24BeAIJIyp/JZqgMbmmuQYLTjMd1
         k+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FBVMRQdBC9ScDW4bAdh6zPVr4kliTneT+ezPPvG5nok=;
        b=AnthSqZBSV9yvwWdB3F44qZU7QMknTXBl9wJeTuyZ1VFEmiazYggJ3E7VXWyx6WMv1
         9rFzRYKyrht4BEegfkSLlklvUeTRZT2kgCkJbNFnsGGZA9XO0TyTWZi71U5vL6vyMowA
         A9ei9lTmqcSg3mIA70477hbM6Zgml3dNWTStTN2dBJ6cMXuAk+khDQVmdl1eVcB9ErC/
         HW4NKpN6kTQ7hK6jYPHbfYOGAsLUXSOZI7x46S24+PfPiqn1vJ33BGmQbGYmHt+FB78c
         DGDeXpVcU3x4jblrthY1Z0DnhBG9Kg2oUvjPJykn4mR+yrFpxuV9CJwOKzkgR73zykRc
         ntrg==
X-Gm-Message-State: AOAM5311TUWJlIct+earoyIBA/V/SHnjtWg+kHRxq0qNJ8vgiT9VSAS/
        NJz7IPfjRDCcXj2b/olD4RGXfIXgWWZwMGAJDeA=
X-Google-Smtp-Source: ABdhPJw+fBVQq9bKd8eGxl1VNEOmQ+nmjVRTD6rtfvIE/yClPeTLnf+tP6nC7L3/ZqiRySBU67l59heXGuCGJPADQNo=
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr10090198iok.171.1610747852337;
 Fri, 15 Jan 2021 13:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-4-ndesaulniers@google.com> <CA+icZUVWPgbMQAgHaRa7emxyzN+SMc6hZ1UNtkkO80-RH6-yNg@mail.gmail.com>
 <CAKwvOdmR_g7R3wEngsTReAmTZTP9s5PBPg-QC5339FMUVeLfJw@mail.gmail.com>
In-Reply-To: <CAKwvOdmR_g7R3wEngsTReAmTZTP9s5PBPg-QC5339FMUVeLfJw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 22:57:21 +0100
Message-ID: <CA+icZUVYgRZ7V6FiE2xUGAMz7_ozULdL0zqZAipo4KRAd0_Q+A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Kbuild: implement support for DWARF v5
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 10:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 1:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > DWARF v5 is the latest standard of the DWARF debug info format.
> > >
> > > Feature detection of DWARF5 is onerous, especially given that we've
> > > removed $(AS), so we must query $(CC) for DWARF5 assembler directive
> > > support.
> > >
> > > The DWARF version of a binary can be validated with:
> > > $ llvm-dwarfdump vmlinux | head -n 4 | grep version
> > > or
> > > $ readelf --debug-dump=info vmlinux 2>/dev/null | grep Version
> > >
> > > DWARF5 wins significantly in terms of size when mixed with compression
> > > (CONFIG_DEBUG_INFO_COMPRESSED).
> > >
> > > 363M    vmlinux.clang12.dwarf5.compressed
> > > 434M    vmlinux.clang12.dwarf4.compressed
> > > 439M    vmlinux.clang12.dwarf2.compressed
> > > 457M    vmlinux.clang12.dwarf5
> > > 536M    vmlinux.clang12.dwarf4
> > > 548M    vmlinux.clang12.dwarf2
> > >
> > > 515M    vmlinux.gcc10.2.dwarf5.compressed
> > > 599M    vmlinux.gcc10.2.dwarf4.compressed
> > > 624M    vmlinux.gcc10.2.dwarf2.compressed
> > > 630M    vmlinux.gcc10.2.dwarf5
> > > 765M    vmlinux.gcc10.2.dwarf4
> > > 809M    vmlinux.gcc10.2.dwarf2
> > >
> > > Though the quality of debug info is harder to quantify; size is not a
> > > proxy for quality.
> > >
> > > Jakub notes:
> > >   All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
> > >   option that enabled some small DWARF subset (initially only a few
> > >   DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
> > >   after DWARF 5 has been finalized) started emitting DWARF5 section
> > >   headers and got most of the DWARF5 changes in...
> > >
> > > Version check GCC so that we don't need to worry about the difference in
> > > command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
> > > validate the DWARF Version in the assembler feature detection script.
> > >
> > > GNU `as` only recently gained support for specifying -gdwarf-5, so when
> > > compiling with Clang but without Clang's integrated assembler
> > > (LLVM_IAS=1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS.
> > >
> > > Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
> > > recognize the new additions to the DWARF debug info. Thanks to Sedat for
> > > the report.
> > >
> > > Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Suggested-by: Caroline Tice <cmtice@google.com>
> > > Suggested-by: Fangrui Song <maskray@google.com>
> > > Suggested-by: Jakub Jelinek <jakub@redhat.com>
> > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  Makefile                          |  6 ++++++
> > >  include/asm-generic/vmlinux.lds.h |  6 +++++-
> > >  lib/Kconfig.debug                 | 18 ++++++++++++++++++
> > >  scripts/test_dwarf5_support.sh    |  8 ++++++++
> > >  4 files changed, 37 insertions(+), 1 deletion(-)
> > >  create mode 100755 scripts/test_dwarf5_support.sh
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 4eb3bf7ee974..1dcea03861ef 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -828,10 +828,16 @@ endif
> > >
> > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> > >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> > >  # Binutils 2.35+ required for -gdwarf-4+ support.
> > >  dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> > >  KBUILD_AFLAGS  += $(dwarf-aflag)
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +ifneq ($(LLVM_IAS),1)
> > > +DEBUG_CFLAGS   += $(dwarf-aflag)
> > > +endif
> > > +endif
> > >
> > >  ifdef CONFIG_DEBUG_INFO_REDUCED
> > >  DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > index 49944f00d2b3..37dc4110875e 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -843,7 +843,11 @@
> > >                 .debug_types    0 : { *(.debug_types) }                 \
> > >                 /* DWARF 5 */                                           \
> > >                 .debug_macro    0 : { *(.debug_macro) }                 \
> > > -               .debug_addr     0 : { *(.debug_addr) }
> > > +               .debug_addr     0 : { *(.debug_addr) }                  \
> > > +               .debug_line_str 0 : { *(.debug_line_str) }              \
> > > +               .debug_loclists 0 : { *(.debug_loclists) }              \
> > > +               .debug_rnglists 0 : { *(.debug_rnglists) }              \
> > > +               .debug_str_offsets      0 : { *(.debug_str_offsets) }
> > >
> > >  /* Stabs debugging sections. */
> > >  #define STABS_DEBUG                                                    \
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index e80770fac4f0..658f32ec0c05 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -273,6 +273,24 @@ config DEBUG_INFO_DWARF4
> > >           It makes the debug information larger, but it significantly
> > >           improves the success of resolving variables in gdb on optimized code.
> > >
> > > +config DEBUG_INFO_DWARF5
> > > +       bool "Generate DWARF Version 5 debuginfo"
> > > +       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> > > +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> >
> > Better keep GCC depends in one line:
> >
> > +       depends on CC_IS_GCC && GCC_VERSION >= 50000 || CC_IS_CLANG
> > +       depends on $(success,$(srctree)/scripts/test_dwarf5_support.sh
> > $(CC) $(CLANG_FLAGS))
>
> It's intentional, if a bit obtuse:
> We don't want to check the assembler support for -Wa,-gdwarf-5 via
> compiler driver when CC=gcc; instead, we'll rely on how GCC was
> configured as per Arvind.
>

Hmm, OK.
I have not tested my diff in diverse setup/combination of compiler and
"bin"utils.
So, I did not want to have a different behaviour.
Can you comment on this intentional setting in v6?

Thanks.

- Sedat -

> >
> > As said in the other patch:
> >
> > Use consistently: s/DWARF Version/DWARF version/g
>
> Ah right, and I forget your point about kbuild/Kbuild.  Will wait for
> more feedback then send a v6 next week.  Thanks as always for the
> feedback.
>
> >
> > - Sedat -
> >
> > > +       depends on !DEBUG_INFO_BTF
> > > +       help
> > > +         Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
> > > +         5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > > +         draft features until 7.0), and gdb 8.0+.
> > > +
> > > +         Changes to the structure of debug info in Version 5 allow for around
> > > +         15-18% savings in resulting image and debug info section sizes as
> > > +         compared to DWARF Version 4. DWARF Version 5 standardizes previous
> > > +         extensions such as accelerators for symbol indexing and the format
> > > +         for fission (.dwo/.dwp) files. Users may not want to select this
> > > +         config if they rely on tooling that has not yet been updated to
> > > +         support DWARF Version 5.
> > > +
> > >  endchoice # "DWARF version"
> > >
> > >  config DEBUG_INFO_BTF
> > > diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
> > > new file mode 100755
> > > index 000000000000..1a00484d0b2e
> > > --- /dev/null
> > > +++ b/scripts/test_dwarf5_support.sh
> > > @@ -0,0 +1,8 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
> > > +# in binutils < 2.35.
> > > +# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
> > > +# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
> > > +echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
> > > --
> > > 2.30.0.284.gd98b1dd5eaa7-goog
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
