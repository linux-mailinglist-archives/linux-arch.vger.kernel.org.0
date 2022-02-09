Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A114AFCAB
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiBITBt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbiBITAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73AFC0613C9;
        Wed,  9 Feb 2022 11:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433206; x=1675969206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aNNbbOIO8oCl2L/symLxvLv9Zx7Xic4udN3gqOpiJ0=;
  b=iWvCeLVSAsZPkKsP83qEJdogfaKrsfeTk1Q/KEs/nWzA2tFLoAF5B2IZ
   T0YUrpEJqUah75UhPgzmbi6H2gI1dvG0ajeseg5dzjWVof9Dwwj4MAeHg
   DH3drfJ5CfqSf/xuXwVKvomxgvQT5TUyLlysfDltSJrERwpHjG0FqLLjJ
   Bwumir0YEJCr70oN+NI0hN1XlG2ZU78Pe0IaK6wUhpt7C87RxZub42Y2v
   OoZUDhJ/Z2wP051RgldgQDIdZe14IrpHRYkoAov70L80jPZqOIVyfviYx
   F9+CG4/Oz91i1yVzGXVBEp00lMTwg038AviC2edYPHzqA1rwD2Mgpe+wY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249062925"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249062925"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="633343853"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2022 10:58:57 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQR031082;
        Wed, 9 Feb 2022 18:58:54 GMT
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
Subject: [PATCH v10 04/15] arch: introduce asm function sections
Date:   Wed,  9 Feb 2022 19:57:41 +0100
Message-Id: <20220209185752.1226407-5-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sometimes it can be useful to create a separate section for every
function (symbol in general) to be able then to selectively merge
them back into one or several others. This is how Dead Code
Elimination (DCE, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) and a part
of Link-Time Optimization (LTO, currently CONFIG_LTO_CLANG) work.
Currently, this can only be done for C functions as the compilers
are able to do this automatically when `-ffunction-sections` is
specified.

Add a basic infra for supporting asm function sections, which means
support for putting functions written in assembly into separate
sections. If any of the required build options (DCE, LTO, FG-KASLR
later) is on and the target architecture claims it supports them,
all asm functions and "code" will be placed into separate so-named
("current_section.function_name") sections by default.
This is achieved using `--sectname-subst` GAS flag which will then
substitute "%S" in a .pushsection or .section directive with the
name of the current section. So,

.section .entry.text      # current section is .entry.text
SYM_FUNC_START(foo)
 -> .pushsection %S.foo   # now the section is .entry.text.foo
do_something
SYM_FUNC_END(foo)
 -> .popsection           # back to .entry.text

Now the function "foo" is placed into .entry.text.foo and can be
garbage-collected if there are no consumers for it.
Otherwise, the linker script will merge it back into .entry.text.

Since modpost is being run on vmlinux.o, i.e. before the final
linking, expand its okay-list to cover new potential sections
(which will get processed afterwards).

Suggested-by: Peter Zijlstra <peterz@infradead.org> # always do, then merge
Suggested-by: Nicolas Pitre <nico@fluxnic.net> # --sectname-subst flag
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                          |  18 +++++
 arch/Kconfig                      |   6 ++
 include/asm-generic/vmlinux.lds.h |  21 +++---
 include/linux/linkage.h           | 119 +++++++++++++++++++++++++++++-
 init/Kconfig                      |  10 +++
 scripts/mod/modpost.c             |   6 +-
 6 files changed, 167 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index fa9f947c9839..fbe2d13028f4 100644
--- a/Makefile
+++ b/Makefile
@@ -877,6 +877,24 @@ ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
 KBUILD_LDFLAGS += -z unique-symbol
 endif
 
+# Allow ASM code to generate separate sections for each function. See
+# `include/linux/linkage.h` for explanation. This flag is to enable GAS to
+# insert the name of the previous section instead of `%S` inside .pushsection
+ifdef CONFIG_HAVE_ASM_FUNCTION_SECTIONS
+ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_LTO_CLANG),)
+SECSUBST_AFLAGS := -Wa,--sectname-subst
+KBUILD_AFLAGS_KERNEL += $(SECSUBST_AFLAGS)
+KBUILD_CFLAGS_KERNEL += $(SECSUBST_AFLAGS)
+export SECSUBST_AFLAGS
+endif
+
+# Same for modules. LD DCE doesn't work for them, thus not checking for it
+ifneq ($(CONFIG_LTO_CLANG),)
+KBUILD_AFLAGS_MODULE += -Wa,--sectname-subst
+KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
+endif
+endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
+
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..550f0599e211 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1322,6 +1322,12 @@ config DYNAMIC_SIGFRAME
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
 
+config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
+	bool
+	help
+	  An arch should select this if it can be built and run with its
+	  asm functions placed into separate sections to improve DCE and LTO.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..e7b8a84e0e64 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -84,6 +84,9 @@
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
+/* This is useful for collecting individual sections back into one main */
+#define SECT_WILDCARD(sect)	sect sect.[0-9a-zA-Z_]*
+
 /*
  * LD_DEAD_CODE_DATA_ELIMINATION option enables -fdata-sections, which
  * generates .data.identifier sections, which need to be pulled in with
@@ -97,12 +100,12 @@
  * sections to be brought in with rodata.
  */
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
-#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
-#define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
-#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
-#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
-#define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
+#define TEXT_MAIN SECT_WILDCARD(.text)
+#define DATA_MAIN SECT_WILDCARD(.data) .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
+#define SDATA_MAIN SECT_WILDCARD(.sdata)
+#define RODATA_MAIN SECT_WILDCARD(.rodata) .rodata..L*
+#define BSS_MAIN SECT_WILDCARD(.bss) .bss..compoundliteral*
+#define SBSS_MAIN SECT_WILDCARD(.sbss)
 #else
 #define TEXT_MAIN .text
 #define DATA_MAIN .data
@@ -564,7 +567,7 @@
 #define NOINSTR_TEXT							\
 		ALIGN_FUNCTION();					\
 		__noinstr_text_start = .;				\
-		*(.noinstr.text)					\
+		*(SECT_WILDCARD(.noinstr.text))				\
 		__noinstr_text_end = .;
 
 /*
@@ -621,7 +624,7 @@
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
 		__entry_text_start = .;					\
-		*(.entry.text)						\
+		*(SECT_WILDCARD(.entry.text))				\
 		__entry_text_end = .;
 
 #define IRQENTRY_TEXT							\
@@ -643,7 +646,7 @@
 		__static_call_text_end = .;
 
 /* Section used for early init (in .S files) */
-#define HEAD_TEXT  KEEP(*(.head.text))
+#define HEAD_TEXT  KEEP(*(SECT_WILDCARD(.head.text)))
 
 #define HEAD_TEXT_SECTION							\
 	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {		\
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..f3b966a6427e 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -73,6 +73,38 @@
 #define __ALIGN_STR	".align 4,0x90"
 #endif
 
+/*
+ * Allow ASM symbols to have their own unique sections if they are being
+ * generated by the compiler for C functions (DCE, LTO). Correlates with
+ * the presence of the `-ffunction-section` in KBUILD_CFLAGS.
+ */
+#if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
+    ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
+     (defined(CONFIG_LTO_CLANG)))
+
+#define SYM_PUSH_SECTION(name)				\
+	.pushsection %S.name, "ax"
+
+#define SYM_POP_SECTION()				\
+	.popsection
+
+#define __ASM_PUSH_SECTION(name)			\
+	".pushsection %S." name ", \"ax\""
+
+#else /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
+
+#define SYM_PUSH_SECTION(name)
+#define SYM_POP_SECTION()
+#define __ASM_PUSH_SECTION(name)
+
+#endif /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
+
+#define ASM_PUSH_SECTION(name)				\
+	__ASM_PUSH_SECTION(__stringify(name))
+
+#define ASM_POP_SECTION()				\
+	__stringify(SYM_POP_SECTION())
+
 #ifdef __ASSEMBLY__
 
 /* SYM_T_FUNC -- type used by assembler to mark functions */
@@ -209,6 +241,15 @@
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
+/*
+ * SYM_FUNC_START_WEAK_ALIAS -- use where there are two global names for one
+ * function, and one of them is weak
+ */
+#ifndef SYM_FUNC_START_WEAK_ALIAS
+#define SYM_FUNC_START_WEAK_ALIAS(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)
+#endif
+
 /*
  * SYM_FUNC_START_ALIAS -- use where there are two global names for one
  * function
@@ -225,12 +266,24 @@
  * later.
  */
 #define SYM_FUNC_START(name)				\
+	SYM_PUSH_SECTION(name) ASM_NL			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/*
+ * SYM_FUNC_START_SECT -- use for global functions, will be conditionally
+ * placed into a section specified in the second argument
+ */
+#ifndef SYM_FUNC_START_SECT
+#define SYM_FUNC_START_SECT(name, sect)			\
+	SYM_PUSH_SECTION(sect) ASM_NL			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
 #ifndef SYM_FUNC_START_NOALIGN
 #define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_PUSH_SECTION(name) ASM_NL			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
 #endif
 
@@ -238,24 +291,38 @@
 #ifndef SYM_FUNC_START_LOCAL
 /* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_START_LOCAL(name)			\
+	SYM_PUSH_SECTION(name) ASM_NL			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
 #ifndef SYM_FUNC_START_LOCAL_NOALIGN
 #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_PUSH_SECTION(name) ASM_NL			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
+#endif
+
+/*
+ * SYM_FUNC_START_LOCAL_NOALIGN_SECT -- use for local functions, w/o alignment,
+ * will be conditionally placed into a section specified in the second argument
+ */
+#ifndef SYM_FUNC_START_LOCAL_NOALIGN_SECT
+#define SYM_FUNC_START_LOCAL_NOALIGN_SECT(name, sect)	\
+	SYM_PUSH_SECTION(sect) ASM_NL			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
 #endif
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #ifndef SYM_FUNC_START_WEAK
 #define SYM_FUNC_START_WEAK(name)			\
+	SYM_PUSH_SECTION(name) ASM_NL			\
 	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)
 #endif
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
 #ifndef SYM_FUNC_START_WEAK_NOALIGN
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_PUSH_SECTION(name) ASM_NL			\
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
 #endif
 
@@ -272,24 +339,59 @@
 #ifndef SYM_FUNC_END
 /* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_END(name)				\
-	SYM_END(name, SYM_T_FUNC)
+	SYM_END(name, SYM_T_FUNC) ASM_NL		\
+	SYM_POP_SECTION()
 #endif
 
 /* SYM_CODE_START -- use for non-C (special) functions */
 #ifndef SYM_CODE_START
 #define SYM_CODE_START(name)				\
+	SYM_PUSH_SECTION(name) ASM_NL			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/*
+ * SYM_CODE_START_SECT -- use for non-C (special) functions, will be
+ * conditionally placed into a section specified in the second argument
+ */
+#ifndef SYM_CODE_START_SECT
+#define SYM_CODE_START_SECT(name, sect)			\
+	SYM_PUSH_SECTION(sect) ASM_NL			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
 /* SYM_CODE_START_NOALIGN -- use for non-C (special) functions, w/o alignment */
 #ifndef SYM_CODE_START_NOALIGN
 #define SYM_CODE_START_NOALIGN(name)			\
+	SYM_PUSH_SECTION(name) ASM_NL			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
+#endif
+
+/*
+ * SYM_CODE_START_NOALIGN_SECT -- use for non-C (special) functions,
+ * w/o alignment, will be conditionally placed into a section specified
+ * in the second argument
+ */
+#ifndef SYM_CODE_START_NOALIGN_SECT
+#define SYM_CODE_START_NOALIGN_SECT(name, sect)		\
+	SYM_PUSH_SECTION(sect) ASM_NL			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
 #endif
 
 /* SYM_CODE_START_LOCAL -- use for local non-C (special) functions */
 #ifndef SYM_CODE_START_LOCAL
 #define SYM_CODE_START_LOCAL(name)			\
+	SYM_PUSH_SECTION(name) ASM_NL			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
+#endif
+
+/*
+ * SYM_CODE_START_LOCAL -- use for local non-C (special) functions, will
+ * be conditionally placing into a section specified in the second argument
+ */
+#ifndef SYM_CODE_START_LOCAL_SECT
+#define SYM_CODE_START_LOCAL_SECT(name, sect)		\
+	SYM_PUSH_SECTION(sect) ASM_NL			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
@@ -299,13 +401,26 @@
  */
 #ifndef SYM_CODE_START_LOCAL_NOALIGN
 #define SYM_CODE_START_LOCAL_NOALIGN(name)		\
+	SYM_PUSH_SECTION(name) ASM_NL			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
+#endif
+
+/*
+ * SYM_CODE_START_LOCAL_NOALIGN_SECT -- use for local non-C (special)
+ * functions, w/o alignment, will be conditionally placed into a section
+ * specified in the second argument
+ */
+#ifndef SYM_CODE_START_LOCAL_NOALIGN_SECT
+#define SYM_CODE_START_LOCAL_NOALIGN_SECT(name, sect)	\
+	SYM_PUSH_SECTION(sect) ASM_NL			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
 #endif
 
 /* SYM_CODE_END -- the end of SYM_CODE_START_LOCAL, SYM_CODE_START, ... */
 #ifndef SYM_CODE_END
 #define SYM_CODE_END(name)				\
-	SYM_END(name, SYM_T_NONE)
+	SYM_END(name, SYM_T_NONE) ASM_NL		\
+	SYM_POP_SECTION()
 #endif
 
 /* === data annotations === */
diff --git a/init/Kconfig b/init/Kconfig
index 8e900d17d42b..4acfc80f22df 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1386,6 +1386,16 @@ config CC_OPTIMIZE_FOR_SIZE
 
 endchoice
 
+config HAVE_ASM_FUNCTION_SECTIONS
+	depends on ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
+	depends on $(cc-option,-Wa$(comma)--sectname-subst)
+	def_bool y
+	help
+	  This enables asm function sections if both architecture and
+	  toolchain support it. It allows creating a separate section
+	  for each function written in assembly in order to improve DCE
+	  and LTO (works the same way as -ffunction-sections for C code).
+
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	bool
 	help
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ec521ccebea6..84d2c44f9383 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -960,7 +960,9 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
-		".coldtext", ".softirqentry.text"
+		".coldtext", ".softirqentry.text", ".text.unlikely.*", \
+		".noinstr.text.*", ".head.text.*", ".fixup.*", \
+		".entry.text.*"
 
 #define INIT_SECTIONS      ".init.*"
 #define MEM_INIT_SECTIONS  ".meminit.*"
@@ -1041,7 +1043,7 @@ enum mismatch {
 struct sectioncheck {
 	const char *fromsec[20];
 	const char *bad_tosec[20];
-	const char *good_tosec[20];
+	const char *good_tosec[25];
 	enum mismatch mismatch;
 	const char *symbol_white_list[20];
 	void (*handler)(const char *modname, struct elf_info *elf,
-- 
2.34.1

