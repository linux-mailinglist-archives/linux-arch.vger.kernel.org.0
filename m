Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9532CE4C0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 02:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgLDBM0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 20:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgLDBM0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 20:12:26 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58350C061A53
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 17:11:40 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id 102so3276117qva.0
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pLRRzZdi/63YiDhRi+XJakRixQ1i8h1osfRwCQB8g5M=;
        b=VFGPrKi4ZBMvJ55xiMOEv09Xxz31ymosmHZRUn+Lpe1qlDPzSVpQ4Zf1nATfA6tPHk
         AeU2a1QCciqvolP55/LozsV/Xg9NQmHCvyYw3VVBh20xn82dwtNWIDBB2MfBWO6MrPIf
         WTgXvxZsTgv4BRElBsxbvlepXaUJMd+ff03353yWV2ReImCnaAwnTSeR9YS6DBV2jJwz
         /MEcOmIt/Hm6NYg87KjRcuGjhszCfqJyFG459lK6G5rSg4gZVQ2YJC5ULlExKBXSiNNS
         y1tnakTyZY+swmB5pjVBARPf5Hjsh4dwD4/7X/97+8FsrHM86ARgl48fCXiNTDyxUAWc
         Siwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pLRRzZdi/63YiDhRi+XJakRixQ1i8h1osfRwCQB8g5M=;
        b=UzABNx4GiL6GLeLF1QTvDHBlA4vKJHznZVCBIQq0ubSeUA6jOpDND45C7hAYsUkCtU
         LgB0ePWhkJQJgxaJPE4sP4Fepl3SGKh8EE1yI8oQW0QMsyLYtgOz3Qy5lHk3Tr7esIZ5
         z8ZIeTSuFBBSG+7vN0FWRFgfYyU+mzBH16Lg8HWsVQgwdTvOyffqTuF99K5c4TK3sFTw
         9q29M+BZv4BOl7F5FMgvx/Z6EoBHwrFvY2/6xFL7lFLaI6H6USKWKB34CSopdLRn7Kcm
         IsN+aYQmw/g4pRG7OxMWYb89dq5Wl1aXJgdtAVneOFELF8zs6N7u23/+l4zXrN3DiTMQ
         1XIw==
X-Gm-Message-State: AOAM53089izAmXr8gBwVDQCiykdK4mmPwQqswINm925XzS2n/AuZJeX8
        UFZWVWe6PbY7FLHc5CQkKrPe32fibJaUcrIBlO4=
X-Google-Smtp-Source: ABdhPJyM0adl50ylGky8nCiNz//0uLGCwaPLuzxWr1v4ZsqecKm4FANzDm31yrpU+GcG9OM7gZ4oNhbHY8qfwByvDrU=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:5106:: with SMTP id
 g6mr2373201qvp.1.1607044299523; Thu, 03 Dec 2020 17:11:39 -0800 (PST)
Date:   Thu,  3 Dec 2020 17:11:27 -0800
In-Reply-To: <20201204011129.2493105-1-ndesaulniers@google.com>
Message-Id: <20201204011129.2493105-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v3 2/2] Kbuild: implement support for DWARF v5
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        clang-built-linux@googlegroups.com,
        Nick Clifton <nickc@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Changbin Du <changbin.du@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format.

Feature detection of DWARF5 is onerous, especially given that we've
removed $(AS), so we must query $(CC) for DWARF5 assembler directive
support.  GNU `as` only recently gained support for specifying
-gdwarf-5.

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

Link: http://www.dwarfstd.org/doc/DWARF5.pdf
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Jakub Jelinek <jakub@redhat.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Caroline Tice <cmtice@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile                          |  1 +
 include/asm-generic/vmlinux.lds.h |  6 +++++-
 lib/Kconfig.debug                 | 14 ++++++++++++++
 scripts/test_dwarf5_support.sh    |  9 +++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100755 scripts/test_dwarf5_support.sh

diff --git a/Makefile b/Makefile
index 2430e1ee7c44..45231f6c1935 100644
--- a/Makefile
+++ b/Makefile
@@ -828,6 +828,7 @@ endif
 
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
 # Binutils 2.35+ required for -gdwarf-4+ support.
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..76ce62c77029 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -829,7 +829,11 @@
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
index 04719294a7a3..987815771ad6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -274,6 +274,20 @@ config DEBUG_INFO_DWARF4
 	  It makes the debug information larger, but it significantly
 	  improves the success of resolving variables in gdb on optimized code.
 
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	depends on GCC_VERSION >= 70000 || CC_IS_CLANG
+	depends on $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
+	help
+	  Generate DWARF v5 debug info. Requires binutils 2.35, gcc 7.0+, and
+	  gdb 8.0+. Changes to the structure of debug info in Version 5 allow
+	  for around 15-18% savings in resulting image and debug info section sizes
+	  as compared to DWARF Version 4. DWARF Version 5 standardizes previous
+	  extensions such as accelerators for symbol indexing and the format for
+	  fission (.dwo/.dwp) files. Users may not want to select this config if
+	  they rely on tooling that has not yet been updated to support
+	  DWARF Version 5.
+
 endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
new file mode 100755
index 000000000000..156ad5ec4274
--- /dev/null
+++ b/scripts/test_dwarf5_support.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Test that assembler accepts -gdwarf-5 and .file 0 directives, which were bugs
+# in binutils < 2.35.
+# https://sourceware.org/bugzilla/show_bug.cgi?id=25612
+# https://sourceware.org/bugzilla/show_bug.cgi?id=25614
+set -e
+echo '.file 0 "filename"' | $* -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
-- 
2.29.2.576.ga3fc446d84-goog

