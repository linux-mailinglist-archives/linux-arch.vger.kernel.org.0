Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8A2F87E8
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAOVu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbhAOVuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:50:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDEC0613D3
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:49:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q7so6860676pgm.5
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGVH2uCGPuPlwMOlNT3CDJKyEfM+KsF79H4rZzySSdQ=;
        b=QA5h/3gPl6BKxSHRs3I991qLswKkugy5B7c7lubkg8MlR6/4k86EVrIPNRlbyfPnRl
         CkpGlhUf/vtCm6W1+1n2qhg9fta64j/WL7+5GKXWFxNukHoDkdlcrcAm46xuo2BFDbIm
         PFw+Mf4IacfLFvsI7QlCsAkeH5WBvt0I8x0GZVS60C0xyMGfmyv+3ipwuE+kJ0F1aDgy
         lZmAvqWYyEipn1DUJQkzFRxI5quVoxHAlYUN/RJ/ftqyJieUfaeepkbCoScfbgxlePYJ
         grP8Nhd57CXNGWN5y86p1UXqOWNs88+/kzyd331mSdikwTGPiywLxS5ZZuulTBMJNaof
         zJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGVH2uCGPuPlwMOlNT3CDJKyEfM+KsF79H4rZzySSdQ=;
        b=YfStDrLlbixEbPfJ/r94edIs0cIqjiiS/Az3ZTuhPKZZb8RuFN4GWWdatWOPjPjGFF
         o2U00o7sQ5IdFV6vJ06HZBzXAoePoXJYrQvmVWkBO+UZcnYqsCgJrm27b5i9vrJ8XiMH
         Ktq6rXQ8C3lkZlRYcmKEe2uI4dc5fxrCFpmDNqPpuR7dZndLONZSlhX0n2UqOGluPrHV
         DizRkq0gBzKKd1CJnNuuLfKtTTonkqAd+TXL+xKNmV834loY8WGkjElcpFDxwHTGhW7d
         wKvlwqwxCx0k9/99a+5gVag2DbK0q4XBUumw/sy1qUbLRaJo/ljxMUvTj51W2lN1eBfX
         NqDg==
X-Gm-Message-State: AOAM532c4bUQsaNajlJ/G4TvoW6o9GS8q+Wbwo5tuafCePRz352lAnmm
        488cahTVS7v09o+f87JaTPU8nVuM1ju+x6vASntxdA==
X-Google-Smtp-Source: ABdhPJzFxN7YPVj1uiwS3A9CYUAQG8zYN3EQpdGvTCm8cekeqRH8xuA2ktOgrrygeYoMxRVAEVKaANeRyN+xgkQnW8w=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr14724049pgm.10.1610747384869;
 Fri, 15 Jan 2021 13:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-4-ndesaulniers@google.com> <CA+icZUVWPgbMQAgHaRa7emxyzN+SMc6hZ1UNtkkO80-RH6-yNg@mail.gmail.com>
In-Reply-To: <CA+icZUVWPgbMQAgHaRa7emxyzN+SMc6hZ1UNtkkO80-RH6-yNg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jan 2021 13:49:33 -0800
Message-ID: <CAKwvOdmR_g7R3wEngsTReAmTZTP9s5PBPg-QC5339FMUVeLfJw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Kbuild: implement support for DWARF v5
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Fri, Jan 15, 2021 at 1:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > DWARF v5 is the latest standard of the DWARF debug info format.
> >
> > Feature detection of DWARF5 is onerous, especially given that we've
> > removed $(AS), so we must query $(CC) for DWARF5 assembler directive
> > support.
> >
> > The DWARF version of a binary can be validated with:
> > $ llvm-dwarfdump vmlinux | head -n 4 | grep version
> > or
> > $ readelf --debug-dump=info vmlinux 2>/dev/null | grep Version
> >
> > DWARF5 wins significantly in terms of size when mixed with compression
> > (CONFIG_DEBUG_INFO_COMPRESSED).
> >
> > 363M    vmlinux.clang12.dwarf5.compressed
> > 434M    vmlinux.clang12.dwarf4.compressed
> > 439M    vmlinux.clang12.dwarf2.compressed
> > 457M    vmlinux.clang12.dwarf5
> > 536M    vmlinux.clang12.dwarf4
> > 548M    vmlinux.clang12.dwarf2
> >
> > 515M    vmlinux.gcc10.2.dwarf5.compressed
> > 599M    vmlinux.gcc10.2.dwarf4.compressed
> > 624M    vmlinux.gcc10.2.dwarf2.compressed
> > 630M    vmlinux.gcc10.2.dwarf5
> > 765M    vmlinux.gcc10.2.dwarf4
> > 809M    vmlinux.gcc10.2.dwarf2
> >
> > Though the quality of debug info is harder to quantify; size is not a
> > proxy for quality.
> >
> > Jakub notes:
> >   All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
> >   option that enabled some small DWARF subset (initially only a few
> >   DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
> >   after DWARF 5 has been finalized) started emitting DWARF5 section
> >   headers and got most of the DWARF5 changes in...
> >
> > Version check GCC so that we don't need to worry about the difference in
> > command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
> > validate the DWARF Version in the assembler feature detection script.
> >
> > GNU `as` only recently gained support for specifying -gdwarf-5, so when
> > compiling with Clang but without Clang's integrated assembler
> > (LLVM_IAS=1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS.
> >
> > Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
> > recognize the new additions to the DWARF debug info. Thanks to Sedat for
> > the report.
> >
> > Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Suggested-by: Caroline Tice <cmtice@google.com>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Suggested-by: Jakub Jelinek <jakub@redhat.com>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile                          |  6 ++++++
> >  include/asm-generic/vmlinux.lds.h |  6 +++++-
> >  lib/Kconfig.debug                 | 18 ++++++++++++++++++
> >  scripts/test_dwarf5_support.sh    |  8 ++++++++
> >  4 files changed, 37 insertions(+), 1 deletion(-)
> >  create mode 100755 scripts/test_dwarf5_support.sh
> >
> > diff --git a/Makefile b/Makefile
> > index 4eb3bf7ee974..1dcea03861ef 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -828,10 +828,16 @@ endif
> >
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> >  # Binutils 2.35+ required for -gdwarf-4+ support.
> >  dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> >  KBUILD_AFLAGS  += $(dwarf-aflag)
> > +ifdef CONFIG_CC_IS_CLANG
> > +ifneq ($(LLVM_IAS),1)
> > +DEBUG_CFLAGS   += $(dwarf-aflag)
> > +endif
> > +endif
> >
> >  ifdef CONFIG_DEBUG_INFO_REDUCED
> >  DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 49944f00d2b3..37dc4110875e 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -843,7 +843,11 @@
> >                 .debug_types    0 : { *(.debug_types) }                 \
> >                 /* DWARF 5 */                                           \
> >                 .debug_macro    0 : { *(.debug_macro) }                 \
> > -               .debug_addr     0 : { *(.debug_addr) }
> > +               .debug_addr     0 : { *(.debug_addr) }                  \
> > +               .debug_line_str 0 : { *(.debug_line_str) }              \
> > +               .debug_loclists 0 : { *(.debug_loclists) }              \
> > +               .debug_rnglists 0 : { *(.debug_rnglists) }              \
> > +               .debug_str_offsets      0 : { *(.debug_str_offsets) }
> >
> >  /* Stabs debugging sections. */
> >  #define STABS_DEBUG                                                    \
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e80770fac4f0..658f32ec0c05 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -273,6 +273,24 @@ config DEBUG_INFO_DWARF4
> >           It makes the debug information larger, but it significantly
> >           improves the success of resolving variables in gdb on optimized code.
> >
> > +config DEBUG_INFO_DWARF5
> > +       bool "Generate DWARF Version 5 debuginfo"
> > +       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> > +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
>
> Better keep GCC depends in one line:
>
> +       depends on CC_IS_GCC && GCC_VERSION >= 50000 || CC_IS_CLANG
> +       depends on $(success,$(srctree)/scripts/test_dwarf5_support.sh
> $(CC) $(CLANG_FLAGS))

It's intentional, if a bit obtuse:
We don't want to check the assembler support for -Wa,-gdwarf-5 via
compiler driver when CC=gcc; instead, we'll rely on how GCC was
configured as per Arvind.

>
> As said in the other patch:
>
> Use consistently: s/DWARF Version/DWARF version/g

Ah right, and I forget your point about kbuild/Kbuild.  Will wait for
more feedback then send a v6 next week.  Thanks as always for the
feedback.

>
> - Sedat -
>
> > +       depends on !DEBUG_INFO_BTF
> > +       help
> > +         Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
> > +         5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > +         draft features until 7.0), and gdb 8.0+.
> > +
> > +         Changes to the structure of debug info in Version 5 allow for around
> > +         15-18% savings in resulting image and debug info section sizes as
> > +         compared to DWARF Version 4. DWARF Version 5 standardizes previous
> > +         extensions such as accelerators for symbol indexing and the format
> > +         for fission (.dwo/.dwp) files. Users may not want to select this
> > +         config if they rely on tooling that has not yet been updated to
> > +         support DWARF Version 5.
> > +
> >  endchoice # "DWARF version"
> >
> >  config DEBUG_INFO_BTF
> > diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
> > new file mode 100755
> > index 000000000000..1a00484d0b2e
> > --- /dev/null
> > +++ b/scripts/test_dwarf5_support.sh
> > @@ -0,0 +1,8 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
> > +# in binutils < 2.35.
> > +# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
> > +# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
> > +echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >



-- 
Thanks,
~Nick Desaulniers
