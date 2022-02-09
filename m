Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683864AFCB8
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiBITBw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbiBITAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB73C03FEC2;
        Wed,  9 Feb 2022 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433217; x=1675969217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKVrmF0CmkdYnGEK7jJ/FW5Neq7dCEF6BeXvTCtlsHY=;
  b=ZCXNrlLdsm0M+rJH8FHpYseeKOeKwvqsZUdqUaw4tJgL99QG58xbWR9Q
   /1WrPXBwX5sE4iVetogwGE19BdlPr7FyhfW9ao4yLK+6028QeLZEl/NWB
   zksdFurHMslwhKV5wAigLJPZmEwXk0PN8b3AkEFgZekjWkGg4cYvWnaVS
   714aupyl5NT8IhxTk3fo4VSytNBypHAP5t3P4JcRYASMLCgUkPqGyICD7
   E4PddVFbalrWnmXDHZYOrvmBqpM58fthrAbRDIVtV/aBv5z3o82fGWz0T
   jqBzs6XcnyqSJiN+8/0/go3xScFRztC2cpTAGT5vM5paunojpqHBoLbcf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="229277088"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229277088"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="482451244"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2022 10:59:03 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQU031082;
        Wed, 9 Feb 2022 18:59:00 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v10 07/15] Makefile: add config options and build scripts for FG-KASLR
Date:   Wed,  9 Feb 2022 19:57:44 +0100
Message-Id: <20220209185752.1226407-8-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Add Kconfig symbols CONFIG_ARCH_SUPPORTS_FG_KASLR and
CONFIG_FG_KASLR. The first is hidden and used to indicate that
a particular architecture supports it, the second allows a user
to enable FG-KASLR when the former is set to 'y'.
Make Kbuild not consolidate function sections back into `.text`
on linking if CONFIG_FG_KASLR is enabled (even with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y) as the feature itself
relies on functions still being separated in the final vmlinux.

Alexander Lobakin:

Improve KBUILD_CFLAGS{,_MODULE} management in the top Makefile:
don't turn on -f{data,function}-sections with ClangLTO as this is a
no-op provoking a full rebuild.
Add ".symtab_shndx" to the list of known sections since it is going
to be supported by the architecture-specific code. Otherwise LD
emits a warning when there are more than 64k sections and
CONFIG_LD_ORPHAN_WARN=y.
Turn ".text" LD script wildcard into ".text.__unused__" to make sure
all kernel code will land into our special sections.
Make FG-KASLR depend on `-z unique-symbol`. With every function being
in a separate section (randomly ordered each boot), position-based
search is impossible. This flag is likely to be widely available
(on non-LLD builds).

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Suggested-by: Kees Cook <keescook@chromium.org> # coexistence with DCE
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                          | 17 ++++++++++++++---
 arch/Kconfig                      |  6 +++++-
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++--
 include/linux/linkage.h           |  9 +++++----
 init/Kconfig                      | 19 +++++++++++++++++--
 5 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index fbe2d13028f4..4328d53d8b25 100644
--- a/Makefile
+++ b/Makefile
@@ -872,7 +872,7 @@ KBUILD_CFLAGS += -fno-inline-functions-called-once
 endif
 
 # Prefer linking with the `-z unique-symbol` if available, this eliminates
-# position-based search
+# position-based search. Also is a requirement for FG-KASLR
 ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
 KBUILD_LDFLAGS += -z unique-symbol
 endif
@@ -881,7 +881,7 @@ endif
 # `include/linux/linkage.h` for explanation. This flag is to enable GAS to
 # insert the name of the previous section instead of `%S` inside .pushsection
 ifdef CONFIG_HAVE_ASM_FUNCTION_SECTIONS
-ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_LTO_CLANG),)
+ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_LTO_CLANG)$(CONFIG_FG_KASLR),)
 SECSUBST_AFLAGS := -Wa,--sectname-subst
 KBUILD_AFLAGS_KERNEL += $(SECSUBST_AFLAGS)
 KBUILD_CFLAGS_KERNEL += $(SECSUBST_AFLAGS)
@@ -895,8 +895,19 @@ KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
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
index 550f0599e211..e06aeeea39f4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1326,7 +1326,11 @@ config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
 	bool
 	help
 	  An arch should select this if it can be built and run with its
-	  asm functions placed into separate sections to improve DCE and LTO.
+	  asm functions placed into separate sections to improve DCE, LTO
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
index f3b966a6427e..95ca162a868c 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -75,11 +75,12 @@
 
 /*
  * Allow ASM symbols to have their own unique sections if they are being
- * generated by the compiler for C functions (DCE, LTO). Correlates with
- * the presence of the `-ffunction-section` in KBUILD_CFLAGS.
+ * generated by the compiler for C functions (DCE, FG-KASLR, LTO). Correlates
+ * with the presence of the `-ffunction-section` in KBUILD_CFLAGS.
  */
 #if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
     ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
+     (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
      (defined(CONFIG_LTO_CLANG)))
 
 #define SYM_PUSH_SECTION(name)				\
@@ -91,13 +92,13 @@
 #define __ASM_PUSH_SECTION(name)			\
 	".pushsection %S." name ", \"ax\""
 
-#else /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
+#else /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || FG_KASLR || LTO)) */
 
 #define SYM_PUSH_SECTION(name)
 #define SYM_POP_SECTION()
 #define __ASM_PUSH_SECTION(name)
 
-#endif /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
+#endif /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || FG_KASLR || LTO)) */
 
 #define ASM_PUSH_SECTION(name)				\
 	__ASM_PUSH_SECTION(__stringify(name))
diff --git a/init/Kconfig b/init/Kconfig
index 4acfc80f22df..26f9a6e52dbd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1393,8 +1393,9 @@ config HAVE_ASM_FUNCTION_SECTIONS
 	help
 	  This enables asm function sections if both architecture and
 	  toolchain support it. It allows creating a separate section
-	  for each function written in assembly in order to improve DCE
-	  and LTO (works the same way as -ffunction-sections for C code).
+	  for each function written in assembly in order to improve DCE,
+	  LTO and FG-KASLR (works the same way as -ffunction-sections
+	  for C code).
 
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	bool
@@ -2061,6 +2062,20 @@ config PROFILING
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
2.34.1

