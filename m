Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB53FCA11
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhHaOnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:10930 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238442AbhHaOnF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:43:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218496832"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="218496832"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="427495065"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2021 07:42:05 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfX002209;
        Tue, 31 Aug 2021 15:42:02 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org
Cc:     "Kristen C Accardi" <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        "Marta A Plantykow" <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v6 kspp-next 07/22] x86: Makefile: Add build and config option for CONFIG_FG_KASLR
Date:   Tue, 31 Aug 2021 16:40:59 +0200
Message-Id: <20210831144114.154-8-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Allow user to select CONFIG_FG_KASLR if dependencies are met. Change
the make file to build with -ffunction-sections if CONFIG_FG_KASLR.

While the only architecture that supports CONFIG_FG_KASLR does not
currently enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION, make sure these
2 features play nicely together for the future by ensuring that if
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is selected when used with
CONFIG_FG_KASLR the function sections will not be consolidated back
into .text. Thanks to Kees Cook for the dead code elimination changes.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Tony Luck <tony.luck@intel.com>
[ alobakin:
 - improve cflags management in the top Makefile
 - move ARCH_HAS_FG_KASLR to the top arch/Kconfig
 - add symtab_shndx to the list of known sections ]
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                          | 13 ++++++++++++-
 arch/Kconfig                      |  3 +++
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++--
 init/Kconfig                      | 12 ++++++++++++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 61741e9d9c6e..283876e170f7 100644
--- a/Makefile
+++ b/Makefile
@@ -918,8 +918,19 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
 KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
+# ClangLTO implies -ffunction-sections -fdata-sections, no need
+# to specify them manually and trigger a pointless full rebuild
+ifndef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_FG_KASLR),)
+KBUILD_CFLAGS_KERNEL += -ffunction-sections
+endif
+
+ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
+KBUILD_CFLAGS_KERNEL += -fdata-sections
+endif
+endif # CONFIG_LTO_CLANG
+
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
 endif
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 129df498a8e1..e7a9a43eee90 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1282,6 +1282,9 @@ config ARCH_SPLIT_ARG64
 config ARCH_HAS_ELFCORE_COMPAT
 	bool
 
+config ARCH_HAS_FG_KASLR
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 62669b36a772..5d6da19b02bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -97,14 +97,12 @@
  * sections to be brought in with rodata.
  */
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
-#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
@@ -112,6 +110,23 @@
 #define SBSS_MAIN .sbss
 #endif
 
+/*
+ * LTO_CLANG, LD_DEAD_CODE_DATA_ELIMINATION and FG_KASLR options enable
+ * -ffunction-sections, which produces separately named .text sections. In
+ * the case of CONFIG_FG_KASLR, they need to stay distict so they can be
+ * separately randomized. Without CONFIG_FG_KASLR, the separate .text
+ * sections can be collected back into a common section, which makes the
+ * resulting image slightly smaller
+ */
+#if (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
+     defined(CONFIG_LTO_CLANG)) && !defined(CONFIG_FG_KASLR)
+#define TEXT_MAIN		.text .text.[0-9a-zA-Z_]*
+#elif defined(CONFIG_FG_KASLR)
+#define TEXT_MAIN		.text.__unused__
+#else
+#define TEXT_MAIN		.text
+#endif
+
 /*
  * GCC 4.5 and later have a 32 bytes section alignment for structures.
  * Except GCC 4.9, that feels the need to align on 64 bytes.
@@ -842,6 +857,7 @@
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
+		.symtab_shndx 0 : { *(.symtab_shndx) }			\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }
 
diff --git a/init/Kconfig b/init/Kconfig
index 55f9f7738ebb..cd1440b6a566 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2021,6 +2021,18 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config FG_KASLR
+	bool "Function Granular Kernel Address Space Layout Randomization"
+	depends on ARCH_HAS_FG_KASLR
+	help
+	  This option improves the randomness of the kernel text
+	  over basic Kernel Address Space Layout Randomization (KASLR)
+	  by reordering the kernel text at boot time. This feature
+	  uses information generated at compile time to re-layout the
+	  kernel text section at boot time at function level granularity.
+
+	  If unsure, say N.
+
 endmenu		# General setup
 
 source "arch/Kconfig"
-- 
2.31.1

