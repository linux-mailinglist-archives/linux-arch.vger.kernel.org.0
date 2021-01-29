Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9030904C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhA2Wsh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhA2Wsf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:48:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA082C06174A
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:47:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so6130860plh.12
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gDlO199tXgO9XFqDPXTn4h+a1uDya+oG7sl995qz8CQ=;
        b=iozzAKNokEpYhh/FVOL4wem7KoAZmQdR3XES6x/pH8WkltSlJ+rKac2eqONDkJ+pgF
         EI1hNtYuGxn0ar/W5j5OUep6wHDS/dk2qz6PDkQQ4dM4uOunfKlj0JuRWXseIcY6eThy
         h+EPPdF4tXLIC1GkVSquUPChUpKudLqLzhY42BbrlHMQmsJz0IBe7Xogb6AhbW6jtMwS
         DnrKKexZRPEOHtDDg9J/OUh+GAFtLhDS1QDeJROXw9ST1mPXM0LnX3bTIegPsfzOOzHn
         jmZ+udReN9gGBiG1UMeNQ5qX1OEodM48DJhZL8vQ8C6aFLNWQmrU9vy4Rnz+HAA87qlQ
         orxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDlO199tXgO9XFqDPXTn4h+a1uDya+oG7sl995qz8CQ=;
        b=AMMo7HKOPeI/SFhIE2XfeB8yh+ORvsyqBO4IPgDZHV4S483OpSS3g73MOQQg48c9SY
         z41soreoNCFxRyK3vELo8jTEhp5mhKWy5xYQrpVeF5ELrRivB2yKK27MEYkOTeuI3/8u
         hiXDUb3tZYbeg0qzxwHVycM6uGtQvnnEmiTJM8UAP0O7R+0elkbNLCR8Rvl6Ruu1ma2u
         1pzcAG7rMreU/I4fNq+R9hfPRWNyUIiAPI1QmGjnSIa+Cxj6u77boGumdDSE9LX61lix
         Es9DauPiziTwv5X1CaBDSPxy0D9BznJ+ogHs1CnAd5hTPl9glgumSPq+4E/+bQ47ij+h
         Vz9Q==
X-Gm-Message-State: AOAM5332oiqfyJaXWRM9IROPC4vmLSTY4VxP/XJAJQR0wvMGMWW8K5Bp
        /2E9/scuvWV1Lf8I7kb9EsRHIA==
X-Google-Smtp-Source: ABdhPJwEtDsDBpFJ/hf70CoviuC1sROK+Tel7TKjBRUl4tlzwaIbKXCiQRfCBpp074q3nEZIqJ2x6g==
X-Received: by 2002:a17:902:e98d:b029:de:9a3a:1b8d with SMTP id f13-20020a170902e98db02900de9a3a1b8dmr6500727plb.3.1611960474950;
        Fri, 29 Jan 2021 14:47:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id b26sm9921357pfo.202.2021.01.29.14.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:47:54 -0800 (PST)
Date:   Fri, 29 Jan 2021 14:47:50 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
Message-ID: <20210129224750.tdvr4to7li7rnldv@google.com>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210129194318.2125748-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-29, Nick Desaulniers wrote:
>DWARF v5 is the latest standard of the DWARF debug info format.
>
>Feature detection of DWARF5 is onerous, especially given that we've
>removed $(AS), so we must query $(CC) for DWARF5 assembler directive
>support.
>
>The DWARF version of a binary can be validated with:
>$ llvm-dwarfdump vmlinux | head -n 4 | grep version
>or
>$ readelf --debug-dump=info vmlinux 2>/dev/null | grep Version
>
>DWARF5 wins significantly in terms of size when mixed with compression
>(CONFIG_DEBUG_INFO_COMPRESSED).
>
>363M    vmlinux.clang12.dwarf5.compressed
>434M    vmlinux.clang12.dwarf4.compressed
>439M    vmlinux.clang12.dwarf2.compressed
>457M    vmlinux.clang12.dwarf5
>536M    vmlinux.clang12.dwarf4
>548M    vmlinux.clang12.dwarf2
>
>515M    vmlinux.gcc10.2.dwarf5.compressed
>599M    vmlinux.gcc10.2.dwarf4.compressed
>624M    vmlinux.gcc10.2.dwarf2.compressed
>630M    vmlinux.gcc10.2.dwarf5
>765M    vmlinux.gcc10.2.dwarf4
>809M    vmlinux.gcc10.2.dwarf2
>
>Though the quality of debug info is harder to quantify; size is not a
>proxy for quality.
>
>Jakub notes:
>  All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
>  option that enabled some small DWARF subset (initially only a few
>  DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
>  after DWARF 5 has been finalized) started emitting DWARF5 section
>  headers and got most of the DWARF5 changes in...
>
>Version check GCC so that we don't need to worry about the difference in
>command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
>validate the DWARF Version in the assembler feature detection script.
>
>GNU `as` only recently gained support for specifying -gdwarf-5, so when
>compiling with Clang but without Clang's integrated assembler
>(LLVM_IAS=1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS.
>
>Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
>recognize the new additions to the DWARF debug info. Thanks to Sedat for
>the report.
>
>Link: http://www.dwarfstd.org/doc/DWARF5.pdf
>Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
>Suggested-by: Caroline Tice <cmtice@google.com>
>Suggested-by: Fangrui Song <maskray@google.com>
>Suggested-by: Jakub Jelinek <jakub@redhat.com>
>Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
>Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
> Makefile                          | 12 ++++++++++++
> include/asm-generic/vmlinux.lds.h |  6 +++++-
> lib/Kconfig.debug                 | 18 ++++++++++++++++++
> scripts/test_dwarf5_support.sh    |  8 ++++++++
> 4 files changed, 43 insertions(+), 1 deletion(-)
> create mode 100755 scripts/test_dwarf5_support.sh
>
>diff --git a/Makefile b/Makefile
>index 20141cd9319e..bed8b3b180b8 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -832,8 +832,20 @@ endif
>
> dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
>+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
>
>+# If using clang without the integrated assembler, we need to explicitly tell
>+# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
>+# detect whether the version of GAS supports DWARF v5.
>+ifdef CONFIG_CC_IS_CLANG
>+ifneq ($(LLVM_IAS),1)
>+ifeq ($(dwarf-version-y),5)
>+DEBUG_CFLAGS	+= -Wa,-gdwarf-5
>+endif
>+endif
>+endif
>+
> ifdef CONFIG_DEBUG_INFO_REDUCED
> DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
> 		   $(call cc-option,-fno-var-tracking)
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index 34b7e0d2346c..f8d5455cd87f 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -843,7 +843,11 @@
> 		.debug_types	0 : { *(.debug_types) }			\
> 		/* DWARF 5 */						\
> 		.debug_macro	0 : { *(.debug_macro) }			\
>-		.debug_addr	0 : { *(.debug_addr) }
>+		.debug_addr	0 : { *(.debug_addr) }			\
>+		.debug_line_str	0 : { *(.debug_line_str) }		\
>+		.debug_loclists	0 : { *(.debug_loclists) }		\
>+		.debug_rnglists	0 : { *(.debug_rnglists) }		\
>+		.debug_str_offsets	0 : { *(.debug_str_offsets) }
>
> /* Stabs debugging sections. */
> #define STABS_DEBUG							\
>diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>index 1850728b23e6..09146b1af20d 100644
>--- a/lib/Kconfig.debug
>+++ b/lib/Kconfig.debug
>@@ -273,6 +273,24 @@ config DEBUG_INFO_DWARF4
> 	  It makes the debug information larger, but it significantly
> 	  improves the success of resolving variables in gdb on optimized code.
>
>+config DEBUG_INFO_DWARF5
>+	bool "Generate DWARF Version 5 debuginfo"
>+	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
>+	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
>+	depends on !DEBUG_INFO_BTF
>+	help
>+	  Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
>+	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
>+	  draft features until 7.0), and gdb 8.0+.
>+
>+	  Changes to the structure of debug info in Version 5 allow for around
>+	  15-18% savings in resulting image and debug info section sizes as
>+	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
>+	  extensions such as accelerators for symbol indexing and the format
>+	  for fission (.dwo/.dwp) files. Users may not want to select this
>+	  config if they rely on tooling that has not yet been updated to
>+	  support DWARF Version 5.
>+
> endchoice # "DWARF version"
>
> config DEBUG_INFO_BTF
>diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
>new file mode 100755
>index 000000000000..1a00484d0b2e
>--- /dev/null
>+++ b/scripts/test_dwarf5_support.sh
>@@ -0,0 +1,8 @@
>+#!/bin/sh
>+# SPDX-License-Identifier: GPL-2.0
>+
>+# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
>+# in binutils < 2.35.
>+# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
>+# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
>+echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
>-- 
>2.30.0.365.g02bc693789-goog
>

Since the other thread suggested that you keep just DWARF v4 and v5 and
drop DWARF v2, you'll need v7...

I suggest:

Change the -Wa,-gdwarf-2 logic to add either -Wa,-gdwarf-4 or
-Wa,-gdwarf-5 and drop the CONFIG_CC_IS_CLANG ifdef.
(CONFIG_CC_IS_CLANG is there because clang -Wa,-gdwarf-2 does not allow
DW_AT_ranges which is not in DWARF v2).

GNU as before 2020 did not support -gdwarf-[345]
(https://sourceware.org/bugzilla/show_bug.cgi?id=25612), so you can make
-Wa,-gdwarf-2 a DWARF v4 workaround for older GNU as.
