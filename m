Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BC2F5186
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbhAMRzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 12:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbhAMRzq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 12:55:46 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1BC061786;
        Wed, 13 Jan 2021 09:55:06 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 186so2989981qkj.3;
        Wed, 13 Jan 2021 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+hfHoNO0I8KH/ocWW18bIfM/5TPtJSym5RVhTD/3ic4=;
        b=O5MT405bKjrTH7i3pchDFPTaWtmoF37VLhqyQWeF1I2s4knT4Q7H4qjAV29LVX+LOb
         ipTKy+j8dp/nErKfNOGKBJJ6id7b1GcJB/fMDTAbxfCJ6Uf4zqJa52vlZwghfEnTysrJ
         8pItPKgLgj8qZRA6+VCv6zQUAt+f07+cPCno6FX3IqE+bz4Qi/uNIaKendURniZHRLNk
         clnJuG+cfKNFECa0H2OanZRxudh0FV2/aYKr8Ql04Gq7i+EZpe1OpPPTr3WlThEUxhrb
         XdbMlhoDsf9eOEvc0dYjk/JvWwb5e/yWakrNC/kyviUFTuPxzfqq1nt3qH3E50SigvHd
         1KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+hfHoNO0I8KH/ocWW18bIfM/5TPtJSym5RVhTD/3ic4=;
        b=cr1chDrLRGsDDcYZKi5JJJRqPtEdJBTI2F3ubyLkKDEFNFtzcLu1iCRxRjzyZfU73G
         PXzFV+02hPUaokgEx0O7H4KaDmugpFOd1H/Il6P/AqkGJ4qeuXv6cvq6wZ9Mvb1OMEnQ
         WV5IKUaYkwLMWJmyzWCxcLPb9oWfHczqBPsGHxpVSdf+vUkKi9Ot8aVz0EwAdPMITBwm
         Imp9mI+1yAntAC0WwId3nsrNRYUlSDmn1M7QnkkPoVKL7IPF74hK3Ffnt6lGfDrjwxYy
         4ZjFEmSU5euD9TPt+OV0EO6ORJLOWDWMwKNBLJaj2bdm4bbi0mc/Pglu7smIuDJ2LQHi
         O35Q==
X-Gm-Message-State: AOAM531dHh9/F0eKZ9hUBMdJnKk3wJnU3ymacEk6jy7NGDckEIHAb2jW
        EXroQe1/Ly1C242GkFIuJWc=
X-Google-Smtp-Source: ABdhPJzS3kF14lLxHytdFtsIsOuvTcYochgub0U1iYP+1975xDMMf1MT2+NpPvnL1l4w0VjyIHvdDw==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr3120897qkd.393.1610560505104;
        Wed, 13 Jan 2021 09:55:05 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id n14sm1385094qtr.9.2021.01.13.09.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:55:04 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:55:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v4 3/3] Kbuild: implement support for DWARF v5
Message-ID: <20210113175502.GC4158893@ubuntu-m3-large-x86>
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113003235.716547-4-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 12, 2021 at 04:32:35PM -0800, Nick Desaulniers wrote:
> DWARF v5 is the latest standard of the DWARF debug info format.
> 
> Feature detection of DWARF5 is onerous, especially given that we've
> removed $(AS), so we must query $(CC) for DWARF5 assembler directive
> support.  GNU `as` only recently gained support for specifying
> -gdwarf-5.
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
> Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Jakub Jelinek <jakub@redhat.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Caroline Tice <cmtice@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

One small nit below.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Makefile                          |  1 +
>  include/asm-generic/vmlinux.lds.h |  6 +++++-
>  lib/Kconfig.debug                 | 17 +++++++++++++++++
>  scripts/test_dwarf5_support.sh    |  9 +++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
> 
> diff --git a/Makefile b/Makefile
> index 656fff17b331..1067cfd98249 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -828,6 +828,7 @@ endif
>  
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
>  ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
>  # Binutils 2.35+ required for -gdwarf-4+ support.
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 49944f00d2b3..37dc4110875e 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -843,7 +843,11 @@
>  		.debug_types	0 : { *(.debug_types) }			\
>  		/* DWARF 5 */						\
>  		.debug_macro	0 : { *(.debug_macro) }			\
> -		.debug_addr	0 : { *(.debug_addr) }
> +		.debug_addr	0 : { *(.debug_addr) }			\
> +		.debug_line_str	0 : { *(.debug_line_str) }		\
> +		.debug_loclists	0 : { *(.debug_loclists) }		\
> +		.debug_rnglists	0 : { *(.debug_rnglists) }		\
> +		.debug_str_offsets	0 : { *(.debug_str_offsets) }
>  
>  /* Stabs debugging sections. */
>  #define STABS_DEBUG							\
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e80770fac4f0..60a4f5e27ada 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -273,6 +273,23 @@ config DEBUG_INFO_DWARF4
>  	  It makes the debug information larger, but it significantly
>  	  improves the success of resolving variables in gdb on optimized code.
>  
> +config DEBUG_INFO_DWARF5
> +	bool "Generate DWARF Version 5 debuginfo"
> +	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> +	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> +	help
> +	  Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
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
> index 000000000000..142a1b5c7fa2
> --- /dev/null
> +++ b/scripts/test_dwarf5_support.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
> +# in binutils < 2.35.
> +# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
> +# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
> +set -e

This is unnecessary, clang will error without this and a script's exit
code is the exit code of its last command.

> +echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
