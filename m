Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B06466CC1
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 23:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbhLBWgX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 17:36:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:50399 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238812AbhLBWgX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235592792"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="235592792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="576948096"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2021 14:32:52 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYS028552;
        Thu, 2 Dec 2021 22:32:50 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v8 01/14] x86: Makefile: Add build and config option for CONFIG_FG_KASLR
Date:   Thu,  2 Dec 2021 23:32:01 +0100
Message-Id: <20211202223214.72888-2-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
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
index 0a6ecc8bb2d2..a4d2eac5f81f 100644
--- a/Makefile
+++ b/Makefile
@@ -882,8 +882,19 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
 KBUILD_CFLAGS += -fno-inline-functions-called-once
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
index d3c4ab249e9c..602b67162e53 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1312,6 +1312,9 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
 config DYNAMIC_SIGFRAME
 	bool
 
+config ARCH_HAS_FG_KASLR
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..96fbedcbf7c8 100644
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
@@ -840,6 +855,7 @@
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
+		.symtab_shndx 0 : { *(.symtab_shndx) }			\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }
 
diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d..5cb8f8230915 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2051,6 +2051,18 @@ config PROFILING
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
2.33.1

