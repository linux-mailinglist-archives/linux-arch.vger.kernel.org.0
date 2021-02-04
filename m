Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6F30ECA0
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 07:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBDGmJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhBDGmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:42:08 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAB6C061794
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 22:40:48 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s66so1745968qkh.10
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 22:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1kYL5naolZq/u7s+YLc6NTOf19bf1kc+RN2+cQNmUto=;
        b=Y5YEpMRPKYsYhwk1F0T4sK2BAViMrQNkAniQFRCL61EPw8WHxOBYqn+JTtVmpkIscY
         1ZwqGeyx0PgMAsEMUlx3n7PhwO3zzlLWhIQdjj7Grn3q7WWUYL9VMdJ83Dlgba16VFdi
         JRkZFiRuTQ9KrZdtSqhIp9JyCUhDV+HEe746ZeQSTvzApEppIH58fMJ12OZ/fMIFn2hL
         pj2R1DOK0yVyrY0ZSAz+//Nh8k2O50F8yI/VXNOqke9oy9fIB+Vu+oP85B4BpdiOcVmK
         sZ/2b4gNe0eNUV5HOPmrF9qKvZgW68NuDLz3kCkdv6CswZ4kBt4wiDwzxWN4UoNYHz4Q
         VMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1kYL5naolZq/u7s+YLc6NTOf19bf1kc+RN2+cQNmUto=;
        b=HdB/8i7oHohYoVmW9fGaOUr/655izKtlS0JZA0U+FcpcyNY7DDN0a8TeC3IbimUBUf
         MRe//R0MCHygvXBfKNTvsEv7kj4CM3Lb9mk6naHAV6+66nqcyfhJZ53H9Vqi4c4emSjz
         QwYT++7KCSjRmiN1k1mP5rbSxz0BNRU2+9AR1X/uRIOChHxGadZBMlBsZGoNqXMBMLkJ
         LCPOS7qoBxyOs9vVChd5yn+SeOnKbNbDxMX3bA3NaAE6fBvpoFbekAYmpoogwjnIdctC
         QA9KkjYLUeiufLE4TJbYDPuuZzqB7GlYHfXxVQOD9eaBdW1mFsHJQU168gbblQBtUi9Z
         tVtQ==
X-Gm-Message-State: AOAM5329NRSNzJf07ho2mpSWWt4tp3hzrd6PdnH7GfTti3haNY6ZJYVe
        87V+GDgoXfAR8WCl9amIG1pDtWVXXoylMEXcv0s=
X-Google-Smtp-Source: ABdhPJyTMwEyQuOJejDqtO+KEQ9wfJM71Sduo9lyX51iJrTq8R9JEV1C5MiU6xMUHj/q7mP7Iyv39j5gNv4jw/RW590=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:e070:bc84:c4fd:eb02])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:2ee:: with SMTP id
 h14mr6477655qvu.34.1612420847819; Wed, 03 Feb 2021 22:40:47 -0800 (PST)
Date:   Wed,  3 Feb 2021 22:40:37 -0800
In-Reply-To: <20210204064037.1281726-1-ndesaulniers@google.com>
Message-Id: <20210204064037.1281726-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210204064037.1281726-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v8 2/2] Kbuild: implement support for DWARF v5
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format. GCC 11
will change the implicit default DWARF version, if left unspecified, to
DWARF v5.

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
  One thing is GCC DWARF-5 support, that is whether the compiler will
  support -gdwarf-5 flag, and that support should be there from GCC 7
  onwards.

  All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
  option that enabled some small DWARF subset (initially only a few
  DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
  after DWARF 5 has been finalized) started emitting DWARF5 section
  headers and got most of the DWARF5 changes in...

  Another separate thing is whether the assembler does support
  the -gdwarf-5 option (i.e. if you can compile assembler files
  with -Wa,-gdwarf-5) ... That option is about whether the assembler
  will emit DWARF5 or DWARF2 .debug_line.  It is fine to compile C sources
  with -gdwarf-5 and use DWARF2 .debug_line for assembler files if as
  doesn't support it.

Version check GCC so that we don't need to worry about the difference in
command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
validate the DWARF Version in the assembler feature detection script.

Most issues with clang produced assembler were fixed in binutils 2.35.1,
but 2.35.2 fixed issues related to requiring the flag -Wa,-gdwarf-5
explicitly. The added shell script test checks for the latter, and is
only required when using clang without its integrated assembler, though
we use for clang regardless as we do not yet have a way to query the
assembler from Kconfig.

Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
recognize the new additions to the DWARF debug info.

This only modifies the DWARF version emitted by the compiler, not the
assembler.

The DWARF version of a binary can be validated with:
$ llvm-dwarfdump <object file> | head -n 4 | grep version
or
$ readelf --debug-dump=info <object file> 2>/dev/null | grep Version

Parts of the tree don't reuse DEBUG_CFLAGS as they should; such cleanup
is left as a follow up.

Link: http://www.dwarfstd.org/doc/DWARF5.pdf
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1922707
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Chris Murphy <bugzilla@colorremedies.com>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Caroline Tice <cmtice@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Jakub Jelinek <jakub@redhat.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile                          |  1 +
 include/asm-generic/vmlinux.lds.h |  7 ++++++-
 lib/Kconfig.debug                 | 18 ++++++++++++++++++
 scripts/test_dwarf5_support.sh    |  8 ++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100755 scripts/test_dwarf5_support.sh

diff --git a/Makefile b/Makefile
index bed5cc150009..8b2deca568ee 100644
--- a/Makefile
+++ b/Makefile
@@ -831,6 +831,7 @@ KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 34b7e0d2346c..1e7cde4bd3f9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -842,8 +842,13 @@
 		/* DWARF 4 */						\
 		.debug_types	0 : { *(.debug_types) }			\
 		/* DWARF 5 */						\
+		.debug_addr	0 : { *(.debug_addr) }			\
+		.debug_line_str	0 : { *(.debug_line_str) }		\
+		.debug_loclists	0 : { *(.debug_loclists) }		\
 		.debug_macro	0 : { *(.debug_macro) }			\
-		.debug_addr	0 : { *(.debug_addr) }
+		.debug_names	0 : { *(.debug_names) }			\
+		.debug_rnglists	0 : { *(.debug_rnglists) }		\
+		.debug_str_offsets	0 : { *(.debug_str_offsets) }
 
 /* Stabs debugging sections. */
 #define STABS_DEBUG							\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 94c1a7ed6306..ad6f78989d4f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -268,6 +268,24 @@ config DEBUG_INFO_DWARF4
 	  It makes the debug information larger, but it significantly
 	  improves the success of resolving variables in gdb on optimized code.
 
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
+	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
+	depends on !DEBUG_INFO_BTF
+	help
+	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
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
index 000000000000..c46e2456b47a
--- /dev/null
+++ b/scripts/test_dwarf5_support.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with DWARF
+# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU binutils
+# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=25611
+echo '.file 0 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' | \
+  $* -gdwarf-5 -Wno-unused-command-line-argument -c -x assembler -o /dev/null -
-- 
2.30.0.365.g02bc693789-goog

