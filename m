Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4575647DBD4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbhLWAXw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:23:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:60206 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345525AbhLWAXc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219012; x=1671755012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PcmPXXtTCDjMYFYDkqCZO8NUx5fwEmoyK1vh/YR8N/8=;
  b=HgNXFmHiNd9bx3LPtNU63JkRGBOOwWcn2zmcXB2C4PSlsFkJ+BWyJyZa
   FX3IhGZOgIAJ0tON6eKT1T6V+35G3scezecySCYFJS8GFVhy5hJS/6ldT
   9CIUvubPQRXahZ4VObkGLRse80S8cPnwLvQg2VQORio0D+zBBVAavwHwk
   tlXB24j8jIHZarupax+cUabfY+Zy+7lSBnHpic9IF4buMei6DnDKS9mTs
   XygHXQhtk7dFhImmzf8/JrHQfT0DfEbylXr/mOZ0odzHrj7eZX25gIXGk
   hPtnGXWPjtIXs3s4kn8QDaq5MdRGdd5OKAkM/lmdvOfNUhkrm2KG3Ffd7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="228027814"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="228027814"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="522294917"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2021 16:23:23 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79C032467;
        Thu, 23 Dec 2021 00:23:21 GMT
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
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 07/15] Makefile: Add build and config option for CONFIG_FG_KASLR
Date:   Thu, 23 Dec 2021 01:22:01 +0100
Message-Id: <20211223002209.1092165-8-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
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

alobakin:
Improve cflags management in the top Makefile: don't turn on
-f{data,function}-sections with ClangLTO as this is a no-op
provoking a full rebuild.
Add ".symtab_shndx" to the list of known sections since we are going
to support it. Otherwise LD will emit a warning when there are more
than 64k sections and CONFIG_LD_ORPHAN_WARN=y.
Turn ".text" LD script wildcard into ".text.__unused__" to make sure
all kernel code will land into our special sections.
Make FG-KASLR depend on `-z unique-symbol`. With every function being
in a separate section (randomly ordered each boot), position-based
search is impossible. This flag is likely to be widely available.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                          | 17 ++++++++++++++---
 arch/Kconfig                      |  6 +++++-
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++--
 include/linux/linkage.h           |  3 ++-
 init/Kconfig                      | 18 ++++++++++++++++--
 5 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index b921b1fabf70..3346269341d4 100644
--- a/Makefile
+++ b/Makefile
@@ -883,7 +883,7 @@ KBUILD_CFLAGS += -fno-inline-functions-called-once
 endif
 
 # Prefer linking with the `-z unique-symbol` if available, this eliminates
-# position-based search
+# position-based search. Also is a requirement for FG-KASLR
 ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
 KBUILD_LDFLAGS += -z unique-symbol
 endif
@@ -892,7 +892,7 @@ endif
 # `include/linux/linkage.h` for explanation. This flag is to enable GAS to
 # insert the name of the previous section instead of `%S` inside .pushsection
 ifdef CONFIG_HAVE_ASM_FUNCTION_SECTIONS
-ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_LTO_CLANG),)
+ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_LTO_CLANG)$(CONFIG_FG_KASLR),)
 SECSUBST_AFLAGS := -Wa,--sectname-subst
 KBUILD_AFLAGS_KERNEL += $(SECSUBST_AFLAGS)
 KBUILD_CFLAGS_KERNEL += $(SECSUBST_AFLAGS)
@@ -906,8 +906,19 @@ KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
 endif
 endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
 
+# ClangLTO implies `-ffunction-sections -fdata-sections`, no need
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
index b31a836bc252..01c026d090d4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1316,7 +1316,11 @@ config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
 	bool
 	help
 	  An arch should select this if it can be built and run with its
-	  ASM functions placed into separate sections to improve DCE and LTO.
+	  ASM functions placed into separate sections to improve DCE, LTO
+	  and FG-KASLR.
+
+config ARCH_SUPPORTS_FG_KASLR
+	bool
 
 source "kernel/gcov/Kconfig"
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e7b8a84e0e64..586465b2abb2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -100,14 +100,12 @@
  * sections to be brought in with rodata.
  */
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
-#define TEXT_MAIN SECT_WILDCARD(.text)
 #define DATA_MAIN SECT_WILDCARD(.data) .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN SECT_WILDCARD(.sdata)
 #define RODATA_MAIN SECT_WILDCARD(.rodata) .rodata..L*
 #define BSS_MAIN SECT_WILDCARD(.bss) .bss..compoundliteral*
 #define SBSS_MAIN SECT_WILDCARD(.sbss)
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
@@ -115,6 +113,23 @@
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
+#define TEXT_MAIN		SECT_WILDCARD(.text)
+#elif defined(CONFIG_FG_KASLR)
+#define TEXT_MAIN		.text.__unused__
+#else
+#define TEXT_MAIN		.text
+#endif
+
 /*
  * GCC 4.5 and later have a 32 bytes section alignment for structures.
  * Except GCC 4.9, that feels the need to align on 64 bytes.
@@ -843,6 +858,7 @@
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
+		.symtab_shndx 0 : { *(.symtab_shndx) }			\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }
 
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 0c0ddf4429dc..f3c96fb6a534 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -75,10 +75,11 @@
 
 /*
  * Allow ASM symbols to have their own unique sections if they are being
- * generated by the compiler for C functions (DCE, LTO).
+ * generated by the compiler for C functions (DCE, FG-KASLR, LTO).
  */
 #if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
     ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
+     (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
      (defined(CONFIG_LTO_CLANG)))
 
 #define SYM_PUSH_SECTION(name)				\
diff --git a/init/Kconfig b/init/Kconfig
index 3babc0aeac61..a74b3c3acb49 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1394,8 +1394,8 @@ config HAVE_ASM_FUNCTION_SECTIONS
 	  This enables ASM function sections if both architecture
 	  and toolchain supports that. It allows creating a separate
 	  .text section for each ASM function in order to improve
-	  DCE and LTO (works the same way as -ffunction-sections for
-	  C code).
+	  DCE, LTO and FG-KASLR (works the same way as -ffunction-sections
+	  for C code).
 
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	bool
@@ -2065,6 +2065,20 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config FG_KASLR
+	bool "Function Granular Kernel Address Space Layout Randomization"
+	depends on ARCH_SUPPORTS_FG_KASLR
+	depends on $(cc-option,-ffunction-sections)
+	depends on LD_HAS_Z_UNIQUE_SYMBOL || !LIVEPATCH
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

