Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D2309413
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 11:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhA3B4c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 20:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233067AbhA3ByX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 20:54:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9371364E02;
        Sat, 30 Jan 2021 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611971610;
        bh=2twdufb3WDhkRf6qz92slUmsgv4sr6vzhDCvXDaglWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Di7ermcZdqbyH1BoUTyq+UCIhYaGGtauUKffNM4dO6bIbGeTmbwLCq9KjX9qyitv8
         XaerQkND+MgoN3FZidxycH4G7qaxq0L9ZYTq/UWq+DTaRGWZIUvBO2x7R0vteUmWSg
         tIHPG4fSL877JyEcXVkazPheVHOG6XA9cbm4L3rUufVOelESh9iAfpfY6wsQ4kYlyz
         u51W/XEs7YxABnczptRi0j5/cJnrruFeVkwW4pIy/YRKDV2FC5DrNIRpynTYXq6zp5
         EhkqlhM0VS0gWn2LdaXlmJ1cUT5mMkaBoZfVcacer5hSCzMd4Fc93O6NSwZHvjplCc
         uRKINzaDjtMzg==
Date:   Fri, 29 Jan 2021 18:53:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
Message-ID: <20210130015327.GD2709570@localhost>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130004401.2528717-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 04:44:01PM -0800, Nick Desaulniers wrote:
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
> @@ -831,6 +831,7 @@ KBUILD_AFLAGS	+= -Wa,-gdwarf-2
>  endif
>  
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
>  
>  ifdef CONFIG_DEBUG_INFO_REDUCED
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 34b7e0d2346c..1e7cde4bd3f9 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -842,8 +842,13 @@
>  		/* DWARF 4 */						\
>  		.debug_types	0 : { *(.debug_types) }			\
>  		/* DWARF 5 */						\
> +		.debug_addr	0 : { *(.debug_addr) }			\
> +		.debug_line_str	0 : { *(.debug_line_str) }		\
> +		.debug_loclists	0 : { *(.debug_loclists) }		\
>  		.debug_macro	0 : { *(.debug_macro) }			\
> -		.debug_addr	0 : { *(.debug_addr) }
> +		.debug_names	0 : { *(.debug_names) }			\
> +		.debug_rnglists	0 : { *(.debug_rnglists) }		\
> +		.debug_str_offsets	0 : { *(.debug_str_offsets) }
>  
>  /* Stabs debugging sections. */
>  #define STABS_DEBUG							\
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 94c1a7ed6306..ad6f78989d4f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -268,6 +268,24 @@ config DEBUG_INFO_DWARF4
>  	  It makes the debug information larger, but it significantly
>  	  improves the success of resolving variables in gdb on optimized code.
>  
> +config DEBUG_INFO_DWARF5
> +	bool "Generate DWARF Version 5 debuginfo"
> +	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> +	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> +	depends on !DEBUG_INFO_BTF
> +	help
> +	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> +	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> +	  draft features until 7.0), and gdb 8.0+.
> +
> +	  Changes to the structure of debug info in Version 5 allow for around
> +	  15-18% savings in resulting image and debug info section sizes as
> +	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
> +	  extensions such as accelerators for symbol indexing and the format
> +	  for fission (.dwo/.dwp) files. Users may not want to select this
> +	  config if they rely on tooling that has not yet been updated to
> +	  support DWARF Version 5.
> +
>  endchoice # "DWARF version"
>  
>  config DEBUG_INFO_BTF
> diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
> new file mode 100755
> index 000000000000..c46e2456b47a
> --- /dev/null
> +++ b/scripts/test_dwarf5_support.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with DWARF
> +# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU binutils
> +# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=25611
> +echo '.file 0 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' | \
> +  $* -gdwarf-5 -Wno-unused-command-line-argument -c -x assembler -o /dev/null -
> -- 
> 2.30.0.365.g02bc693789-goog
> 
