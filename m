Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE930996E
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jan 2021 01:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhAaAi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 19:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhAaAi0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 19:38:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0879C061574
        for <linux-arch@vger.kernel.org>; Sat, 30 Jan 2021 16:37:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y205so9086117pfc.5
        for <linux-arch@vger.kernel.org>; Sat, 30 Jan 2021 16:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Z8qk2uk0aVoBXztWy6EPsG2bISv9aVNWd9thy8ze+I=;
        b=du3xDk4MrMKdZBo0o+kRcNJfSH32uOuhWbakOdoEk9PtltdFaIyZimoOte3CoWyiVe
         NbdaRGhXGUO2VQJvWYg317bsROyXb2+rGZohckbJKrjc5Rnxae2Pq/2D8NDDB5glQaYn
         JdADxEgLaIGxQz388tBqrR9wv3AoQ3r2WUu0+SyUjMLwECYQ90q1IVFQZICv/Fj6D4C0
         czTrhY54OAzywWKMsdJYTi7cDPLchES7ZM/xhLh8DwksplgM0nBhwxj/OXS6R8X0BJpu
         z5nuaZhwHKXIB8fAbvorkQYZH+nH/VqvlAEW0l3NpHffdn2KuroAhxenSJr+6qygOGew
         aPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Z8qk2uk0aVoBXztWy6EPsG2bISv9aVNWd9thy8ze+I=;
        b=LSFYiQKRSfvNB4vgrMRlfQZSV9SLA3FmK2OKWWceodzi2j1ysnKooxBzgwRQUkxnDd
         a8MiclB8J+pU+cYnDs/2LhPX/5RLI4FHrOfx6RjO2zC8HxMidrSm2yDo/D0u8U+OQAWQ
         eBLGlneKELfgN3C1CrtkBrhd7KtJ9PsGDpGfaTxn18DPs0JwrDJY6tUzCMKAEy6qjNPr
         LOkuloSctnC5Fc4FlveL8I4NsUrcWwYM1tb0smGejjm4Rsj8Oc5lSeGd3uV+fpX/htLN
         gm/TkmIATf9E76/vAAr07eJrw7L0Zu+gUEFdGGdKIBFoDw13XN9e1pA+fMq0p5/VgDRW
         +0KQ==
X-Gm-Message-State: AOAM531e7HZd9h4wOYzaW/BKoYj+aqKKmlz7xXtQ2TifMSZV2QK9/rit
        Z+o3K9KNBB3pzOOBTHfx9GhUPX8TY00L51TlH674gg==
X-Google-Smtp-Source: ABdhPJxVDbFUilXK6suDzPJ+ENASPGK8bMDXjoDD15uxsl3sr5LwemI7UsLhFod7qgVO9IRZBdz1nbjA7b9KvB2Q3bg=
X-Received: by 2002:a65:628a:: with SMTP id f10mr10489763pgv.380.1612053465893;
 Sat, 30 Jan 2021 16:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-3-ndesaulniers@google.com> <CA+icZUW8N8La=HX6PT0_gWzPPxqW8EMooYpc4jJx6g44przOnA@mail.gmail.com>
In-Reply-To: <CA+icZUW8N8La=HX6PT0_gWzPPxqW8EMooYpc4jJx6g44przOnA@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Sat, 30 Jan 2021 16:37:34 -0800
Message-ID: <CAFP8O3LaWwa5_Y49fr+PDn6y7NefUDRt=KuVuuo0Gf+kZNkLzA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 3:10 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Jan 30, 2021 at 1:44 AM Nick Desaulniers
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
> > $ readelf --debug-dump=3Dinfo vmlinux 2>/dev/null | grep Version
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
> > Version check GCC so that we don't need to worry about the difference i=
n
> > command line args between GNU readelf and llvm-readelf/llvm-dwarfdump t=
o
> > validate the DWARF Version in the assembler feature detection script.
> >
> > GNU `as` only recently gained support for specifying -gdwarf-5, so when
> > compiling with Clang but without Clang's integrated assembler
> > (LLVM_IAS=3D1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS=
.
> >
> > Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
> > recognize the new additions to the DWARF debug info. Thanks to Sedat fo=
r
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
> >  Makefile                          |  1 +
> >  include/asm-generic/vmlinux.lds.h |  7 ++++++-
> >  lib/Kconfig.debug                 | 18 ++++++++++++++++++
> >  scripts/test_dwarf5_support.sh    |  8 ++++++++
> >  4 files changed, 33 insertions(+), 1 deletion(-)
> >  create mode 100755 scripts/test_dwarf5_support.sh
> >
> > diff --git a/Makefile b/Makefile
> > index d2b4980807e0..5387a6f2f62d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -831,6 +831,7 @@ KBUILD_AFLAGS       +=3D -Wa,-gdwarf-2
> >  endif
> >
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) :=3D 4
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) :=3D 5
> >  DEBUG_CFLAGS   +=3D -gdwarf-$(dwarf-version-y)
> >
> >  ifdef CONFIG_DEBUG_INFO_REDUCED
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 34b7e0d2346c..1e7cde4bd3f9 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -842,8 +842,13 @@
> >                 /* DWARF 4 */                                          =
 \
> >                 .debug_types    0 : { *(.debug_types) }                =
 \
> >                 /* DWARF 5 */                                          =
 \
> > +               .debug_addr     0 : { *(.debug_addr) }                 =
 \
> > +               .debug_line_str 0 : { *(.debug_line_str) }             =
 \
> > +               .debug_loclists 0 : { *(.debug_loclists) }             =
 \
> >                 .debug_macro    0 : { *(.debug_macro) }                =
 \
> > -               .debug_addr     0 : { *(.debug_addr) }
> > +               .debug_names    0 : { *(.debug_names) }                =
 \
> > +               .debug_rnglists 0 : { *(.debug_rnglists) }             =
 \
> > +               .debug_str_offsets      0 : { *(.debug_str_offsets) }
> >
>
> I just looked at binutils 2.36 in the Debian/experimental repositories.
>
> [1] says:
>
> + PR ld/27230
> =EF=BF=BC+ * scripttempl/DWARF.sc: Add DWARF-5 .debug_* sections.
>
> ...
>
> -  /* DWARF Extension.  */
> =EF=BF=BC-  .debug_macro    0 : { *(.debug_macro) }
> +  /* DWARF 5.  */
>    .debug_addr     0 : { *(.debug_addr) }
> +  .debug_line_str 0 : { *(.debug_line_str) }
> +  .debug_loclists 0 : { *(.debug_loclists) }
> +  .debug_macro    0 : { *(.debug_macro) }
> +  .debug_names    0 : { *(.debug_names) }
> +  .debug_rnglists 0 : { *(.debug_rnglists) }
> +  .debug_str_offsets 0 : { *(.debug_str_offsets) }
> =EF=BF=BC+  .debug_sup      0 : { *(.debug_sup) }
>
> The list of DWARF-5 .debug_* sections is alphabetically sorted.
> AFAICS .debug_sup section is missing?
>
> - Sedat -

No compiler produces .debug_sup section. It could be from some
post-processing tool which is unrelated to the linker.
Omitting it is fine.

> [1] https://salsa.debian.org/toolchain-team/binutils/-/commit/f58f3308103=
5672b01a04326a9c8daadbd09a430
>
> >  /* Stabs debugging sections. */
> >  #define STABS_DEBUG                                                   =
 \
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 94c1a7ed6306..ad6f78989d4f 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -268,6 +268,24 @@ config DEBUG_INFO_DWARF4
> >           It makes the debug information larger, but it significantly
> >           improves the success of resolving variables in gdb on optimiz=
ed code.
> >
> > +config DEBUG_INFO_DWARF5
> > +       bool "Generate DWARF Version 5 debuginfo"
> > +       depends on GCC_VERSION >=3D 50000 || CC_IS_CLANG
> > +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf=
5_support.sh $(CC) $(CLANG_FLAGS))
> > +       depends on !DEBUG_INFO_BTF
> > +       help
> > +         Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5=
.0+ (gcc
> > +         5.0+ accepts the -gdwarf-5 flag but only had partial support =
for some
> > +         draft features until 7.0), and gdb 8.0+.
> > +
> > +         Changes to the structure of debug info in Version 5 allow for=
 around
> > +         15-18% savings in resulting image and debug info section size=
s as
> > +         compared to DWARF Version 4. DWARF Version 5 standardizes pre=
vious
> > +         extensions such as accelerators for symbol indexing and the f=
ormat
> > +         for fission (.dwo/.dwp) files. Users may not want to select t=
his
> > +         config if they rely on tooling that has not yet been updated =
to
> > +         support DWARF Version 5.
> > +
> >  endchoice # "DWARF version"
> >
> >  config DEBUG_INFO_BTF
> > diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_suppo=
rt.sh
> > new file mode 100755
> > index 000000000000..c46e2456b47a
> > --- /dev/null
> > +++ b/scripts/test_dwarf5_support.sh
> > @@ -0,0 +1,8 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented wi=
th DWARF
> > +# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU b=
inutils
> > +# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=3D25611
> > +echo '.file 0 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' | \
> > +  $* -gdwarf-5 -Wno-unused-command-line-argument -c -x assembler -o /d=
ev/null -
> > --
> > 2.30.0.365.g02bc693789-goog
> >
