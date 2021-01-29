Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30840308DB3
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 20:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhA2Tqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhA2Tos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 14:44:48 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A3C06178B
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 11:43:28 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d1so5870708plh.13
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GEKeeKHmAPTG6av/vdrBVpAGk6oSoBQtlWTtIBlm4NE=;
        b=O/MlbpWrVzwE85YBqbu4bab6e/sn9OUJTh2gu3olaKEE7JV8wCBOK1eBgFZw0d9CAO
         KdQDGlLzmMo+Ac6IiPlOYU52gHbP/5+dgxmLfbLFJ33FBfVbKP6e61i9G1Cs+tuh4DP8
         /boP0iylHA9H2Omh7EZVAQlTK8Nseoj2Jze+b5bc3uFhFfvKsaMP5rjNnfNE66kZCV68
         npYEy0IPSJWbZ2Xe+PflWNfVSvrtXGu/M+D+NGUDfSsjlF2rsCT3NAIfwEi2lUv7d88M
         nVN13rHwdT44uWV4YVIev4dZIa5etcxgyJyNcPmDAiyN4K3z6JX4/Zfy/k04GWoRyZu6
         BeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GEKeeKHmAPTG6av/vdrBVpAGk6oSoBQtlWTtIBlm4NE=;
        b=BJ37V8P2iviElKJpZgd7MSLwGxePo2u7jlbEP7sTWWE3psl86oaQdDG0pxYite8buh
         bC2jK5xrKBecnfrGSSYKKiozbMx0i5BxsSnID9EymKr3CmK5qsf38qhghlj0X/5lChS1
         XrHFp/HEWkubVVPOU6k+EcKVIMPryICik13PDA3J9MAdvx8qz/vfj8IAiTst39NDNNwQ
         uRGOEy6kvPFugAm9qXpCZrx2YKCstNb3IYknE/iJEbLyvCyzoQRuaxqTX9PNg92Af920
         iZ4gWx2yoDgzP5b3b+5eFdI+f6WDUr9UQVQN5M/YN2pyFQqiN2NJJQ8wiVL5IZka11ke
         fDeQ==
X-Gm-Message-State: AOAM532Dyv3cu5mR07Rk9nx3rOvHUq2cWMqTU+MAnfA+SKmgSkvH1/Zk
        HDSdOqOTdpmjJ2YE9ZLflBwxOouFSaq3YKi4Hh4=
X-Google-Smtp-Source: ABdhPJzdpg/y8Jsls9v2C/jVstr7a7flmubHPF/IGx6CsDLMwIGtJq/fBysFPY+5TqTuPOpsQN4q2rJdT9BdHFCPtWY=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a17:902:ee14:b029:de:19f0:91b4 with
 SMTP id z20-20020a170902ee14b02900de19f091b4mr5652880plb.78.1611949407609;
 Fri, 29 Jan 2021 11:43:27 -0800 (PST)
Date:   Fri, 29 Jan 2021 11:43:18 -0800
In-Reply-To: <20210129194318.2125748-1-ndesaulniers@google.com>
Message-Id: <20210129194318.2125748-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format.

Feature detection of DWARF5 is onerous, especially given that we've
removed $(AS), so we must query $(CC) for DWARF5 assembler directive
support.

The DWARF version of a binary can be validated with:
$ llvm-dwarfdump vmlinux | head -n 4 | grep version
or
$ readelf --debug-dump=info vmlinux 2>/dev/null | grep Version

DWARF5 wins significantly in terms of size when mixed with compression
(CONFIG_DEBUG_INFO_COMPRESSED).

363M    vmlinux.clang12.dwarf5.compressed
434M    vmlinux.clang12.dwarf4.compressed
439M    vmlinux.clang12.dwarf2.compressed
457M    vmlinux.clang12.dwarf5
536M    vmlinux.clang12.dwarf4
548M    vmlinux.clang12.dwarf2

515M    vmlinux.gcc10.2.dwarf5.compressed
599M    vmlinux.gcc10.2.dwarf4.compressed
624M    vmlinux.gcc10.2.dwarf2.compressed
630M    vmlinux.gcc10.2.dwarf5
765M    vmlinux.gcc10.2.dwarf4
809M    vmlinux.gcc10.2.dwarf2

Though the quality of debug info is harder to quantify; size is not a
proxy for quality.

Jakub notes:
  All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
  option that enabled some small DWARF subset (initially only a few
  DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
  after DWARF 5 has been finalized) started emitting DWARF5 section
  headers and got most of the DWARF5 changes in...

Version check GCC so that we don't need to worry about the difference in
command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
validate the DWARF Version in the assembler feature detection script.

GNU `as` only recently gained support for specifying -gdwarf-5, so when
compiling with Clang but without Clang's integrated assembler
(LLVM_IAS=1 is not set), explicitly add -Wa,-gdwarf-5 to DEBUG_CFLAGS.

Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
recognize the new additions to the DWARF debug info. Thanks to Sedat for
the report.

Link: http://www.dwarfstd.org/doc/DWARF5.pdf
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Caroline Tice <cmtice@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Jakub Jelinek <jakub@redhat.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile                          | 12 ++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 +++++-
 lib/Kconfig.debug                 | 18 ++++++++++++++++++
 scripts/test_dwarf5_support.sh    |  8 ++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 scripts/test_dwarf5_support.sh

diff --git a/Makefile b/Makefile
index 20141cd9319e..bed8b3b180b8 100644
--- a/Makefile
+++ b/Makefile
@@ -832,8 +832,20 @@ endif
 
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 
+# If using clang without the integrated assembler, we need to explicitly tell
+# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
+# detect whether the version of GAS supports DWARF v5.
+ifdef CONFIG_CC_IS_CLANG
+ifneq ($(LLVM_IAS),1)
+ifeq ($(dwarf-version-y),5)
+DEBUG_CFLAGS	+= -Wa,-gdwarf-5
+endif
+endif
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 34b7e0d2346c..f8d5455cd87f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -843,7 +843,11 @@
 		.debug_types	0 : { *(.debug_types) }			\
 		/* DWARF 5 */						\
 		.debug_macro	0 : { *(.debug_macro) }			\
-		.debug_addr	0 : { *(.debug_addr) }
+		.debug_addr	0 : { *(.debug_addr) }			\
+		.debug_line_str	0 : { *(.debug_line_str) }		\
+		.debug_loclists	0 : { *(.debug_loclists) }		\
+		.debug_rnglists	0 : { *(.debug_rnglists) }		\
+		.debug_str_offsets	0 : { *(.debug_str_offsets) }
 
 /* Stabs debugging sections. */
 #define STABS_DEBUG							\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1850728b23e6..09146b1af20d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -273,6 +273,24 @@ config DEBUG_INFO_DWARF4
 	  It makes the debug information larger, but it significantly
 	  improves the success of resolving variables in gdb on optimized code.
 
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
+	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
+	depends on !DEBUG_INFO_BTF
+	help
+	  Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
+	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
+	  draft features until 7.0), and gdb 8.0+.
+
+	  Changes to the structure of debug info in Version 5 allow for around
+	  15-18% savings in resulting image and debug info section sizes as
+	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
+	  extensions such as accelerators for symbol indexing and the format
+	  for fission (.dwo/.dwp) files. Users may not want to select this
+	  config if they rely on tooling that has not yet been updated to
+	  support DWARF Version 5.
+
 endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
new file mode 100755
index 000000000000..1a00484d0b2e
--- /dev/null
+++ b/scripts/test_dwarf5_support.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
+# in binutils < 2.35.
+# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
+# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
+echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
-- 
2.30.0.365.g02bc693789-goog

