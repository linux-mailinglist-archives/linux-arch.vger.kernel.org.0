Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C56308E99
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhA2UmG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhA2UmF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:42:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DCBC06174A;
        Fri, 29 Jan 2021 12:41:25 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p72so10671418iod.12;
        Fri, 29 Jan 2021 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ghs3w1DK8bK62apoXNRIgaDmo4mtYv4++XqH5FO8a1U=;
        b=YkPpKYC2szva4mxzX3Ds7sba2cn6q9gCHqesIo7T3Ofe/BYTCQycl6DJefajEtALOb
         q1PIW5kfKaS/3Ai9/2NyXxn0avog+NeU8Rlqkl1GH5gGdFkVC+cfEC7eGioV3o2zIyAp
         Wa8jzQaFjHH/oeJCTJpXQyQ+15PaaQVectY+uucQ1UUH+yM8VMDdFp7JplP4Ca4sjK4q
         BII3gCi+5NqlqiryHeRURHgQbrnWkBMYrREMatQEcy3tuU/czdBcf5Na+Rd2UJgV3t48
         Nw9jjA1S9kEPgBJoKbAa/mDTlQL0sY5OIgSld/55xzGICzAywQW9lGc3d4SZgaiKq20r
         uyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ghs3w1DK8bK62apoXNRIgaDmo4mtYv4++XqH5FO8a1U=;
        b=f1HwVoeU8GYBX9vpy9AuIBp5MbCQ5/1Ur2tRApBsyoPbqTBH4XD4SuZJrpQAAvOE41
         7qt87ITSEJexGNwQ+YwuDtZWutfhZ3F0dGN2SaAgIqOIfL7MIcASvqGH+WMtAIW55Lzq
         uAlZyZjYn/wLudQJTxOgVtNs03iOW8H5XPAx1TFkdEbFWUFUHNuK1I7ZmTJgFhThbEWP
         gmOiEfO26gZkmd95l9l7Qwe/dHQ+L39qWwGG88rTDER/G0c8Eh4mjgkviz8PDQvu+aP9
         5nnz2S5PVMYjTAgQXj4eP6Qu3lRJL7x/rCvn4AWBOeV6HGEtFkCiyuxaTnCPTpsEcy4t
         7gzA==
X-Gm-Message-State: AOAM530SdvNVbKjZ8dJuQhNGQ7Pn6HYItpZvIlWVua8lEH569zn+UUgz
        hh5BfNeVPNBwuRA61JBh7zKboyJ5Awq6O4yo7Fc=
X-Google-Smtp-Source: ABdhPJzSSgqI25YAkm8JsGux8fYxiPCuz8YjbOM01Qt5CklAvrUizR1424po1R6NfNqSUTPeOSGNYwtLnvYnuhktO4Y=
X-Received: by 2002:a6b:90c4:: with SMTP id s187mr4928826iod.75.1611952884560;
 Fri, 29 Jan 2021 12:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com> <20210129194318.2125748-3-ndesaulniers@google.com>
In-Reply-To: <20210129194318.2125748-3-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 21:41:12 +0100
Message-ID: <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
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
> $ readelf --debug-dump=info vmlinux 2>/dev/null | grep Version
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
> (LLVM_IAS=1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS.
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
>  Makefile                          | 12 ++++++++++++
>  include/asm-generic/vmlinux.lds.h |  6 +++++-
>  lib/Kconfig.debug                 | 18 ++++++++++++++++++
>  scripts/test_dwarf5_support.sh    |  8 ++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
>
> diff --git a/Makefile b/Makefile
> index 20141cd9319e..bed8b3b180b8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -832,8 +832,20 @@ endif
>
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
>
> +# If using clang without the integrated assembler, we need to explicitly tell
> +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> +# detect whether the version of GAS supports DWARF v5.
> +ifdef CONFIG_CC_IS_CLANG
> +ifneq ($(LLVM_IAS),1)
> +ifeq ($(dwarf-version-y),5)
> +DEBUG_CFLAGS   += -Wa,-gdwarf-5

I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
that's why I looked again into the top-level Makefile.

Should this be...?

KBUILD_AFLAGS += -Wa,-gdwarf-5

- Sedat -

> +endif
> +endif
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
>                    $(call cc-option,-fno-var-tracking)
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 34b7e0d2346c..f8d5455cd87f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -843,7 +843,11 @@
>                 .debug_types    0 : { *(.debug_types) }                 \
>                 /* DWARF 5 */                                           \
>                 .debug_macro    0 : { *(.debug_macro) }                 \
> -               .debug_addr     0 : { *(.debug_addr) }
> +               .debug_addr     0 : { *(.debug_addr) }                  \
> +               .debug_line_str 0 : { *(.debug_line_str) }              \
> +               .debug_loclists 0 : { *(.debug_loclists) }              \
> +               .debug_rnglists 0 : { *(.debug_rnglists) }              \
> +               .debug_str_offsets      0 : { *(.debug_str_offsets) }
>
>  /* Stabs debugging sections. */
>  #define STABS_DEBUG                                                    \
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1850728b23e6..09146b1af20d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -273,6 +273,24 @@ config DEBUG_INFO_DWARF4
>           It makes the debug information larger, but it significantly
>           improves the success of resolving variables in gdb on optimized code.
>
> +config DEBUG_INFO_DWARF5
> +       bool "Generate DWARF Version 5 debuginfo"
> +       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> +       depends on !DEBUG_INFO_BTF
> +       help
> +         Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
> +         5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> +         draft features until 7.0), and gdb 8.0+.
> +
> +         Changes to the structure of debug info in Version 5 allow for around
> +         15-18% savings in resulting image and debug info section sizes as
> +         compared to DWARF Version 4. DWARF Version 5 standardizes previous
> +         extensions such as accelerators for symbol indexing and the format
> +         for fission (.dwo/.dwp) files. Users may not want to select this
> +         config if they rely on tooling that has not yet been updated to
> +         support DWARF Version 5.
> +
>  endchoice # "DWARF version"
>
>  config DEBUG_INFO_BTF
> diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
> new file mode 100755
> index 000000000000..1a00484d0b2e
> --- /dev/null
> +++ b/scripts/test_dwarf5_support.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
> +# in binutils < 2.35.
> +# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
> +# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
> +echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
> --
> 2.30.0.365.g02bc693789-goog
>
