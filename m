Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944C92EA081
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 00:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbhADXLz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 18:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADXLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 18:11:55 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB90C061793;
        Mon,  4 Jan 2021 15:11:14 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id h6so15420470vsr.6;
        Mon, 04 Jan 2021 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nZJG52DxHM8NxYEaACeWBEq/7egLrC9ZK8TAPAUC9Tw=;
        b=bsAS2U5frW0z20sukfGBmeBZd50Frv6sTH0dmHyLmWie751Euilrw1VEXr+I4buBsY
         CFmFofP7b47XSYyOCFHJvYbNcqUTVIbLHsYlxSaP6QGGipxwfMm9RZJ1Ns0X5Pf3oTol
         JkuqIEf1PSfCUf00PRmuU60qMh1cDaP8jL/Z6B84dBXckskWxrHeFkRp7sTDsF3uRab3
         i3Y7wGZG3YktDKV6qkIyoty6V7duCEKW7sWqriyl6JeFkw6HXBVrAuOj1svnOSOwjx8M
         P/LvDVjbvYhm/77s8YLyDADC9G5l8Qm3DiIlVqBomOepwqDtiRQUv6zl/OrPV8y4kq5A
         ckcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nZJG52DxHM8NxYEaACeWBEq/7egLrC9ZK8TAPAUC9Tw=;
        b=fXcWsPH4BMku64PKe1FyMbPJHMBYen66KU3WfSnJEJZYexQQs7I3iXH7Y1XGEM35Mt
         QGEdC+PDZcsKper7vjRWPA+BaN+EaIb4QIe++m+QXs5+sPMMxV7/0wXEWI/Pm1hd3ABa
         9l0NPThVrnvnaTkYMy+VVhj0AQYUDvsG3bNvJHCbTfIkEhOkao6dpBCKRTOuoh/fVo/v
         bnNd7lPoM8OTPd2DQq2BadC4e7voEZ5XxS1XAy4ghBI6t8rmhdNVeCcn7NOUQyEsYELg
         PMPXFjiDg8NGscyDnsQSCEp3pmkkYMpExo/1sAvATSFTPFK3tKVUGvMaWc1mPbuwq2mj
         jLSg==
X-Gm-Message-State: AOAM530VLrsBKcoW67t0jXjquff8im7mf3mGqC+QC0x9ixPJ+0vOf/d7
        t/3PFnEJh1iaxgd2yyBZ4/RpcL/JnthrQg==
X-Google-Smtp-Source: ABdhPJw751wkgYmEj0+hrixadDSPrbP+NJnOALKJQAU32Zzh0Xr5LV3XehzV4PEqUfmWRn635VdNnQ==
X-Received: by 2002:a05:6214:20a7:: with SMTP id 7mr78391783qvd.59.1609798351740;
        Mon, 04 Jan 2021 14:12:31 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id k19sm37992586qkh.6.2021.01.04.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:12:30 -0800 (PST)
Date:   Mon, 4 Jan 2021 15:12:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        clang-built-linux@googlegroups.com,
        Nick Clifton <nickc@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Changbin Du <changbin.du@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Kbuild: implement support for DWARF v5
Message-ID: <20210104221229.GB1405526@ubuntu-m3-large-x86>
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204011129.2493105-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 03, 2020 at 05:11:27PM -0800, Nick Desaulniers wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Makefile                          |  1 +
>  include/asm-generic/vmlinux.lds.h |  6 +++++-
>  lib/Kconfig.debug                 | 14 ++++++++++++++
>  scripts/test_dwarf5_support.sh    |  9 +++++++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
> 
> diff --git a/Makefile b/Makefile
> index 2430e1ee7c44..45231f6c1935 100644
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
> index b2b3d81b1535..76ce62c77029 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -829,7 +829,11 @@
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
> index 04719294a7a3..987815771ad6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -274,6 +274,20 @@ config DEBUG_INFO_DWARF4
>  	  It makes the debug information larger, but it significantly
>  	  improves the success of resolving variables in gdb on optimized code.
>  
> +config DEBUG_INFO_DWARF5
> +	bool "Generate DWARF Version 5 debuginfo"
> +	depends on GCC_VERSION >= 70000 || CC_IS_CLANG
> +	depends on $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> +	help
> +	  Generate DWARF v5 debug info. Requires binutils 2.35, gcc 7.0+, and
> +	  gdb 8.0+. Changes to the structure of debug info in Version 5 allow
> +	  for around 15-18% savings in resulting image and debug info section sizes
> +	  as compared to DWARF Version 4. DWARF Version 5 standardizes previous
> +	  extensions such as accelerators for symbol indexing and the format for
> +	  fission (.dwo/.dwp) files. Users may not want to select this config if
> +	  they rely on tooling that has not yet been updated to support
> +	  DWARF Version 5.
> +
>  endchoice # "DWARF version"
>  
>  config DEBUG_INFO_BTF
> diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
> new file mode 100755
> index 000000000000..156ad5ec4274
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
> +echo '.file 0 "filename"' | $* -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
