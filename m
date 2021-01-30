Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7D3098C0
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jan 2021 00:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhA3XK4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 18:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3XK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 18:10:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59805C061573;
        Sat, 30 Jan 2021 15:10:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e133so2554889iof.8;
        Sat, 30 Jan 2021 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eUMkCHvaS5XtjP3wfPbJa/kaRkQN+NS5RoVd5CpPEk8=;
        b=qqbBISE720uIwajkwyb3XHkorF6lGdTOu/QqSxgkot6jv3+R1p1PpqE5Qwq/8dHI6r
         i0zJMsd2MDN6ziPS/+7UX/cQf5D5z9cqI8QaVIjmegi/A1J6i5GMqqVrDZfTTJGugBbR
         f/7dcPisDdstVrHVVItxKggs/3rFkj7CNxVZa7LCVQRfFBdDf1Ie7W5jfd/vzGF0YsFu
         IaXGrPG7+TeQVr5ADcHw9+qizrq3FdrQA77L4ITUpuyo13uIIOAVcPxih61rwKZW1zc/
         HZCQ0ov86rF7GZZ+WBLkLYc/oDrZGhPYa3KeFT9pq6jCH/xHFaMf1pTxxKBkuafghIAo
         SK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eUMkCHvaS5XtjP3wfPbJa/kaRkQN+NS5RoVd5CpPEk8=;
        b=EneO4JSbovC+a8Nt7bOVMwIZO/FI47taTs35DWZ+c1IOJ276234z+qh2wlz2trcxib
         ct8G+9gWceuGVGBTQDsOOc4lczgFB9oNvtCyZfAHjEzdK/qEfT3PJ+PWyzhxKHS52qpr
         9b/WtABTuoucUtRd8rDSQyJHGXf6tY8Z1HzCBtjtupqs6Mic++aK0udy09l7Dxqm+YoI
         IqU9CbJ/L2k+a+oiJj5gBaE0ssiC81JfN33wl4EbAOfVsJTV8hSH+VK6ttujkWLWYN0v
         J3iDptNdViVLzjlsntgPS2ICsnlHKBQcFJHI1bdc8yh9jrc/lk46Dh0UBS7wTw3WkJlS
         521Q==
X-Gm-Message-State: AOAM5323eRPydyIGbsx6YQ0MVh1j7F0Q+GhEOMBwZYuokvYvHPz987SH
        THLyMlSZgWah+re4h63JvqQk70m6rgErEneYpR1dq1VkGyyG+g==
X-Google-Smtp-Source: ABdhPJxjQ3Mrxd312k+X5Sr51T5D5g/Ha+3zMsRyuXqfsowmmZ0xsG2pnO0B0/6ZjDBsZF7skM58SGwpdaU6RQu4Nfg=
X-Received: by 2002:a5e:dd42:: with SMTP id u2mr5266437iop.57.1612048215456;
 Sat, 30 Jan 2021 15:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com> <20210130004401.2528717-3-ndesaulniers@google.com>
In-Reply-To: <20210130004401.2528717-3-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 31 Jan 2021 00:10:04 +0100
Message-ID: <CA+icZUW8N8La=HX6PT0_gWzPPxqW8EMooYpc4jJx6g44przOnA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
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

On Sat, Jan 30, 2021 at 1:44 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> DWARF v5 is the latest standard of the DWARF debug info format.
>
> Feature detection of DWARF5 is onerous, especially given that we've
> removed $(AS), so we must query $(CC) for DWARF5 assembler directive
> support.
>
> The DWARF version of a binary can be validated with:
> $ llvm-dwarfdump vmlinux | head -n 4 | grep version
> or
> $ readelf --debug-dump=3Dinfo vmlinux 2>/dev/null | grep Version
>
> DWARF5 wins significantly in terms of size when mixed with compression
> (CONFIG_DEBUG_INFO_COMPRESSED).
>
> 363M    vmlinux.clang12.dwarf5.compressed
> 434M    vmlinux.clang12.dwarf4.compressed
> 439M    vmlinux.clang12.dwarf2.compressed
> 457M    vmlinux.clang12.dwarf5
> 536M    vmlinux.clang12.dwarf4
> 548M    vmlinux.clang12.dwarf2
>
> 515M    vmlinux.gcc10.2.dwarf5.compressed
> 599M    vmlinux.gcc10.2.dwarf4.compressed
> 624M    vmlinux.gcc10.2.dwarf2.compressed
> 630M    vmlinux.gcc10.2.dwarf5
> 765M    vmlinux.gcc10.2.dwarf4
> 809M    vmlinux.gcc10.2.dwarf2
>
> Though the quality of debug info is harder to quantify; size is not a
> proxy for quality.
>
> Jakub notes:
>   All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
>   option that enabled some small DWARF subset (initially only a few
>   DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
>   after DWARF 5 has been finalized) started emitting DWARF5 section
>   headers and got most of the DWARF5 changes in...
>
> Version check GCC so that we don't need to worry about the difference in
> command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
> validate the DWARF Version in the assembler feature detection script.
>
> GNU `as` only recently gained support for specifying -gdwarf-5, so when
> compiling with Clang but without Clang's integrated assembler
> (LLVM_IAS=3D1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS.
>
> Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
> recognize the new additions to the DWARF debug info. Thanks to Sedat for
> the report.
>
> Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Caroline Tice <cmtice@google.com>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Jakub Jelinek <jakub@redhat.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Makefile                          |  1 +
>  include/asm-generic/vmlinux.lds.h |  7 ++++++-
>  lib/Kconfig.debug                 | 18 ++++++++++++++++++
>  scripts/test_dwarf5_support.sh    |  8 ++++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
>
> diff --git a/Makefile b/Makefile
> index d2b4980807e0..5387a6f2f62d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -831,6 +831,7 @@ KBUILD_AFLAGS       +=3D -Wa,-gdwarf-2
>  endif
>
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) :=3D 4
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) :=3D 5
>  DEBUG_CFLAGS   +=3D -gdwarf-$(dwarf-version-y)
>
>  ifdef CONFIG_DEBUG_INFO_REDUCED
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 34b7e0d2346c..1e7cde4bd3f9 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -842,8 +842,13 @@
>                 /* DWARF 4 */                                           \
>                 .debug_types    0 : { *(.debug_types) }                 \
>                 /* DWARF 5 */                                           \
> +               .debug_addr     0 : { *(.debug_addr) }                  \
> +               .debug_line_str 0 : { *(.debug_line_str) }              \
> +               .debug_loclists 0 : { *(.debug_loclists) }              \
>                 .debug_macro    0 : { *(.debug_macro) }                 \
> -               .debug_addr     0 : { *(.debug_addr) }
> +               .debug_names    0 : { *(.debug_names) }                 \
> +               .debug_rnglists 0 : { *(.debug_rnglists) }              \
> +               .debug_str_offsets      0 : { *(.debug_str_offsets) }
>

I just looked at binutils 2.36 in the Debian/experimental repositories.

[1] says:

+ PR ld/27230
=EF=BF=BC+ * scripttempl/DWARF.sc: Add DWARF-5 .debug_* sections.

...

-  /* DWARF Extension.  */
=EF=BF=BC-  .debug_macro    0 : { *(.debug_macro) }
+  /* DWARF 5.  */
   .debug_addr     0 : { *(.debug_addr) }
+  .debug_line_str 0 : { *(.debug_line_str) }
+  .debug_loclists 0 : { *(.debug_loclists) }
+  .debug_macro    0 : { *(.debug_macro) }
+  .debug_names    0 : { *(.debug_names) }
+  .debug_rnglists 0 : { *(.debug_rnglists) }
+  .debug_str_offsets 0 : { *(.debug_str_offsets) }
=EF=BF=BC+  .debug_sup      0 : { *(.debug_sup) }

The list of DWARF-5 .debug_* sections is alphabetically sorted.
AFAICS .debug_sup section is missing?

- Sedat -

[1] https://salsa.debian.org/toolchain-team/binutils/-/commit/f58f330810356=
72b01a04326a9c8daadbd09a430

>  /* Stabs debugging sections. */
>  #define STABS_DEBUG                                                    \
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 94c1a7ed6306..ad6f78989d4f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -268,6 +268,24 @@ config DEBUG_INFO_DWARF4
>           It makes the debug information larger, but it significantly
>           improves the success of resolving variables in gdb on optimized=
 code.
>
> +config DEBUG_INFO_DWARF5
> +       bool "Generate DWARF Version 5 debuginfo"
> +       depends on GCC_VERSION >=3D 50000 || CC_IS_CLANG
> +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_=
support.sh $(CC) $(CLANG_FLAGS))
> +       depends on !DEBUG_INFO_BTF
> +       help
> +         Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0=
+ (gcc
> +         5.0+ accepts the -gdwarf-5 flag but only had partial support fo=
r some
> +         draft features until 7.0), and gdb 8.0+.
> +
> +         Changes to the structure of debug info in Version 5 allow for a=
round
> +         15-18% savings in resulting image and debug info section sizes =
as
> +         compared to DWARF Version 4. DWARF Version 5 standardizes previ=
ous
> +         extensions such as accelerators for symbol indexing and the for=
mat
> +         for fission (.dwo/.dwp) files. Users may not want to select thi=
s
> +         config if they rely on tooling that has not yet been updated to
> +         support DWARF Version 5.
> +
>  endchoice # "DWARF version"
>
>  config DEBUG_INFO_BTF
> diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support=
.sh
> new file mode 100755
> index 000000000000..c46e2456b47a
> --- /dev/null
> +++ b/scripts/test_dwarf5_support.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with=
 DWARF
> +# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU bin=
utils
> +# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=3D25611
> +echo '.file 0 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' | \
> +  $* -gdwarf-5 -Wno-unused-command-line-argument -c -x assembler -o /dev=
/null -
> --
> 2.30.0.365.g02bc693789-goog
>
