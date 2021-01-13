Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8B2F401B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 01:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438149AbhAMAnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 19:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392442AbhAMAeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2021 19:34:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A6C0617A9
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 16:32:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c9so582495ybs.8
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zQ4L+JyR4fS6Zw/UsbG4Lq16kk6cB+cu31P+ux/3yCo=;
        b=ql7lCCLN0Vi4dQcb6GQ6Qrp5gTZNlhpyTebxqOI9UPcv53OutigfkcnE+PEXkZXn5t
         xhUjovlh1+RY36gsZTtiFOolMjGJwV7ckXkY62kXNdpn59bgDYtNAiC6U1EDkJo2dLc7
         1xWLksinunOBKoChx2szDVln2wIdtYG51o+9WXW2cCg6y2IjKMjI0Vj99zjNEXYliMa2
         vUEzOukvGHC4qCaRlZ20gw8JmY9WaY8I2/fhZXxviUj+dBzj2484i5x6R3FvAGrXAPYt
         SM0trZBcHZq9yeF/SsFdPJy5D2t3bW5b+GUdbHS/7/Un9y8x89LyY6qsoWuIJjIIsWPK
         xg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zQ4L+JyR4fS6Zw/UsbG4Lq16kk6cB+cu31P+ux/3yCo=;
        b=aBXnRth6SkdtCbIuBlck5xFtQf3ADOzk9qlurwVlYVO3w5kfxvTkYxUALDdLkxMUaB
         3mniCd27nlgCjW+AWnWe2azYZ976EIvw5yYMINz6Yj6Oxgo6CsYZ/y4NFt3lLAuuRcoN
         QCtEcMQm3/5zKaFypfRe8dN6qUWdAkdVFavVE6twpBLlpTkvNAJin2CDahO+KbjYbS7t
         865C3MRVbtH6kq73pnP5+yCQxs3hylrLKCHANeutjYeAzVJLaj8y1wpgX4Y6ia0c/q8k
         xHyLUv08wQBjGWHJVsGeBbM1tUIZOd4YaFaD8WfvdIVFK6n/E9TqpIfloR69ZdlBbN18
         30zA==
X-Gm-Message-State: AOAM532JxN1HwutDljAZ8v23GQtZwJ6e9eCtP2IhQKXWSv93YeIy/+vQ
        8RH80obtkQY34DCaPq+CinAIhIXH6FhTh8mkVFQ=
X-Google-Smtp-Source: ABdhPJzoumFmS+f0N4/EEA9rkIp1PJMKNYQ3GTLb8hXE1dg30o5aG4Xe6GonfUs5Mq4O//EAy0Rrxc4Fw5WMimqEUMA=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:6b1:: with SMTP id
 j17mr3137592ybt.438.1610497973189; Tue, 12 Jan 2021 16:32:53 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:32:35 -0800
In-Reply-To: <20210113003235.716547-1-ndesaulniers@google.com>
Message-Id: <20210113003235.716547-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 3/3] Kbuild: implement support for DWARF v5
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
        Nick Clifton <nickc@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
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
 lib/Kconfig.debug                 | 17 +++++++++++++++++
 scripts/test_dwarf5_support.sh    |  9 +++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 scripts/test_dwarf5_support.sh

diff --git a/Makefile b/Makefile
index 656fff17b331..1067cfd98249 100644
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
index 49944f00d2b3..37dc4110875e 100644
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
index e80770fac4f0..60a4f5e27ada 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -273,6 +273,23 @@ config DEBUG_INFO_DWARF4
 	  It makes the debug information larger, but it significantly
 	  improves the success of resolving variables in gdb on optimized code.
 
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
+	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
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
index 000000000000..142a1b5c7fa2
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
+echo '.file 0 "filename"' | $* -gdwarf-5 -Wa,-gdwarf-5 -c -x assembler -o /dev/null -
-- 
2.30.0.284.gd98b1dd5eaa7-goog

