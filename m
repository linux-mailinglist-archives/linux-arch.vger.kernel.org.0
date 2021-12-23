Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9582447DBED
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbhLWAYR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:24:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:59161 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238271AbhLWAXp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219024; x=1671755024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M+ClnG2JXQETKhE6oHghASQqo8EvKsdBr8Mky4esG5A=;
  b=YQtfOAzuZunz/vi5oU0+bmmMPF9YjuAEopOJWBy8hrjRfohBb6Jv38hp
   ki9200VjIQ7/yPrabo3AtozpbuXTJMZLeM9ppRhp9i1a27K4KRrVm0+aH
   973ZTPPuiqTYJ41XFq4ObtxXHLdk7GJfr5GzbMp85b6pMG2ti3wcSB9la
   QPbz9pX1AbPcXQcEXgdtW8I/1Lk0Nm3JWUk+w0bPXf/4JKVXgJ/D1I5KT
   yest3Y1/KtxrP+aiN91n7NkzCSH9Yd+GSsIOQ1m1bSaPedglQeE7BnqsB
   2ATbxMUTBHl5zP4fcDs1itTRJjPq25F/UsmQFxHOxQ4UJJVOhxJI4Hu2c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="221405044"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="221405044"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="466831979"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 16:23:18 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N799032467;
        Thu, 23 Dec 2021 00:23:15 GMT
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
Subject: [PATCH v9 04/15] arch: introduce ASM function sections
Date:   Thu, 23 Dec 2021 01:21:58 +0100
Message-Id: <20211223002209.1092165-5-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sometimes it is useful to create a separate section for every
function (symbol in general) to be able then to selectively merge
them back into on or several others. This is how DCE and a part of
LTO work.
Currently, only C functions are in scope and the compilers are able
to do this automatically when `-ffunction-section` is specified.

Add a basic infra for supporting ASM function sections. If any of
the required build options (DCE, LTO, FG-KASLR later) is on and
the target architecture claims it supports them, all ASM functions
and "code" will be placed into separate named sections by default.
This is achieved using --sectname-subst GAS flag which will then
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
 include/linux/linkage.h           | 118 +++++++++++++++++++++++++++++-
 init/Kconfig                      |  11 +++
 scripts/mod/modpost.c             |   6 +-
 6 files changed, 167 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 9dc15c67d132..b921b1fabf70 100644
--- a/Makefile
+++ b/Makefile
@@ -888,6 +888,24 @@ ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
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
index d3c4ab249e9c..b31a836bc252 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1312,6 +1312,12 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
 config DYNAMIC_SIGFRAME
 	bool
 
+config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
+	bool
+	help
+	  An arch should select this if it can be built and run with its
+	  ASM functions placed into separate sections to improve DCE and LTO.
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
index dbf8506decca..0c0ddf4429dc 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -73,6 +73,37 @@
 #define __ALIGN_STR	".align 4,0x90"
 #endif
 
+/*
+ * Allow ASM symbols to have their own unique sections if they are being
+ * generated by the compiler for C functions (DCE, LTO).
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
+#else /* Just .text */
+
+#define SYM_PUSH_SECTION(name)
+#define SYM_POP_SECTION()
+#define __ASM_PUSH_SECTION(name)
+
+#endif /* Just .text */
+
+#define ASM_PUSH_SECTION(name)				\
+	__ASM_PUSH_SECTION(__stringify(name))
+
+#define ASM_POP_SECTION()				\
+	__stringify(SYM_POP_SECTION())
+
 #ifdef __ASSEMBLY__
 
 /* SYM_T_FUNC -- type used by assembler to mark functions */
@@ -209,6 +240,15 @@
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
+/*
+ * SYM_FUNC_START_WEAK -- use where there are two global names for one
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
@@ -225,12 +265,24 @@
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
+#define SYM_FUNC_START_SECT(name, to)			\
+	SYM_PUSH_SECTION(to) ASM_NL			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
 #ifndef SYM_FUNC_START_NOALIGN
 #define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_PUSH_SECTION(name) ASM_NL			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
 #endif
 
@@ -238,24 +290,38 @@
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
+#define SYM_FUNC_START_LOCAL_NOALIGN_SECT(name, to)	\
+	SYM_PUSH_SECTION(to) ASM_NL			\
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
 
@@ -272,24 +338,59 @@
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
+#define SYM_CODE_START_SECT(name, to)			\
+	SYM_PUSH_SECTION(to) ASM_NL			\
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
+#define SYM_CODE_START_NOALIGN_SECT(name, to)		\
+	SYM_PUSH_SECTION(to) ASM_NL			\
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
+#define SYM_CODE_START_LOCAL_SECT(name, to)		\
+	SYM_PUSH_SECTION(to) ASM_NL			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
@@ -299,13 +400,26 @@
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
+#define SYM_CODE_START_LOCAL_NOALIGN_SECT(name, to)	\
+	SYM_PUSH_SECTION(to) ASM_NL			\
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
index 37926d19a74a..3babc0aeac61 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1386,6 +1386,17 @@ config CC_OPTIMIZE_FOR_SIZE
 
 endchoice
 
+config HAVE_ASM_FUNCTION_SECTIONS
+	depends on ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
+	depends on $(cc-option,-Wa$(comma)--sectname-subst)
+	def_bool y
+	help
+	  This enables ASM function sections if both architecture
+	  and toolchain supports that. It allows creating a separate
+	  .text section for each ASM function in order to improve
+	  DCE and LTO (works the same way as -ffunction-sections for
+	  C code).
+
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	bool
 	help
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f39cc73a082c..a6e9e75ff3e5 100644
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
2.33.1

