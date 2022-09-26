Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AA5EB243
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 22:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIZUh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIZUhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 16:37:53 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904909E882;
        Mon, 26 Sep 2022 13:37:51 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28QKaWu1018737;
        Tue, 27 Sep 2022 05:36:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28QKaWu1018737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664224594;
        bh=yCb6Dol7u5zeqemMeSYfgpDFkRAmK+1W2KSFszpgWOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ag6L+QrdRfmi4HvEHJPPp0QbeYgv65pZBGhwWayIPsH6kzuQiXpdg/BbAPvheYQRF
         IWR8buPedfzstaSN1PWiHBH2O3hEwmITIIJ4Xd3AnWmYWUpKFEGCe2/GeTinBPy6+o
         FEOrGIJSjX7GluaBfnNxurL140wBKdeQkdAO4HGYvtkRkSUMV1ln0XlRSHJk6Cif3Y
         zZB85xG6gfEijLacEdBztyqsc8SkrrCCCZN8XX1QaTy2v/akdodlzyW69koJ/BRETX
         hKR1SoXxI2h2vA+bof4SNcU4quXAgfFpTqg09GnFbT326fc/7KTvGfXy4R+6Gnpcd3
         JMpCMjw7rmHFQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-modules@vger.kernel.org
Subject: [PATCH v2 1/7] kbuild: generate KSYMTAB entries by modpost
Date:   Tue, 27 Sep 2022 05:36:19 +0900
Message-Id: <20220926203625.1117261-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926203625.1117261-1-masahiroy@kernel.org>
References: <20220926203625.1117261-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
whether the EXPORT_SYMBOL() is placed in *.c or *.S.

This commit applies a similar approach to the entire data structure of
EXPORT_SYMBOL() for further cleanups. The EXPORT_SYMBOL() compilation
is split into two stages.

When a source file is compiled, EXPORT_SYMBOL() is converted into a
dummy symbol in the .discard.export_symbol section.

For example,

    EXPORT_SYMBOL(foo);
    EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);

will be encoded into the following assembly code:

    .section .discard.export_symbol
    __export_symbol.foo:
            .asciz ""
    .previous

    .section .discard.export_symbol
    __export_symbol_gpl.bar:
            .asciz "BAR_NAMESPACE"
    .previous

They are just markers to tell modpost the name, license, and namespace
of the symbols. They will be dropped from the final vmlinux and modules
because the section name starts with ".discard.".

Then, modpost extracts all the information about EXPORT_SYMBOL() from the
.discard.export_symbol section, then generates C code:

    KSYMTAB_FUNC(foo, "", "");
    KSYMTAB_FUNC(bar, "_gpl", "BAR_NAMESPACE");

KSYMTAB_FUNC() (or KSYMTAB_DATA() if it is data) is expanded to struct
kernel_symbol that will be linked to the vmlinux or a module.

With this change, EXPORT_SYMBOL() works in the same way for *.c and *.S
files, providing the following benefits.

[1] Deprecate EXPORT_DATA_SYMBOL()

In the old days, EXPORT_SYMBOL() was only available in C files. To export
a symbol in *.S, EXPORT_SYMBOL() was placed in a separate *.c file.
arch/arm/kernel/armksyms.c is one example written in the classic manner.

Commit 22823ab419d8 ("EXPORT_SYMBOL() for asm") removed this limitation.
Since then, EXPORT_SYMBOL() can be placed close to the symbol definition
in *.S files. It was a nice improvement.

However, as that commit mentioned, you need to use EXPORT_DATA_SYMBOL()
for data objects on some architectures.

In the new approach, modpost checks symbol's type (STT_FUNC or not),
and outputs KSYMTAB_FUNC() or KSYMTAB_DATA() accordingly.

There are only two users of EXPORT_DATA_SYMBOL:

  EXPORT_DATA_SYMBOL_GPL(empty_zero_page)    (arch/ia64/kernel/head.S)
  EXPORT_DATA_SYMBOL(ia64_ivt)               (arch/ia64/kernel/ivt.S)

They are transformed as follows and output into .vmlinux.export.c

  KSYMTAB_DATA(empty_zero_page, "_gpl", "");
  KSYMTAB_DATA(ia64_ivt, "", "");

The other EXPORT_SYMBOL users in ia64 assembly are output as
KSYMTAB_FUNC().

EXPORT_DATA_SYMBOL() is now deprecated.

[2] merge <linux/export.h> and <asm-generic/export.h>

There are two similar header implementations:

  include/linux/export.h        for .c files
  include/asm-generic/export.h  for .S files

Ideally, the functionality should be consistent between them, but they
tend to diverge.

Commit 8651ec01daed ("module: add support for symbol namespaces.") did
not support the namespace for *.S files.

This commit shifts the essential implementation part to C, which supports
EXPORT_SYMBOL_NS() for *.S files.

<asm/export.h> and <asm-generic/export.h> will remain as a wrapper of
<linux/export.h> for a while.

They will be removed after #include <asm/export.h> directives are all
replaced with #include <linux/export.h>.

[3] Implement CONFIG_TRIM_UNUSED_KSYMS in one-pass algorithm

When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
the directory tree to determine which EXPORT_SYMBOL to trim. If an
EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
second traverse, where some source files are recompiled with their
EXPORT_SYMBOL() tuned into a no-op.

We can do this better now; modpost can selectively emit KSYMTAB entries
that are really referenced by modules.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Use KSYMTAB_FUNC and KSYMTAB_DATA for functions and data, respectively
    This distinction is needed for ia64.

 arch/ia64/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/export.h  |  3 -
 include/asm-generic/export.h    | 84 ++--------------------------
 include/linux/export-internal.h | 67 ++++++++++++++++++++++-
 include/linux/export.h          | 97 +++++++++++----------------------
 kernel/module/internal.h        |  1 +
 kernel/module/main.c            |  1 -
 scripts/Makefile.build          |  8 +--
 scripts/check-local-export      |  4 +-
 scripts/mod/modpost.c           | 81 +++++++++++++++++----------
 scripts/mod/modpost.h           |  1 +
 11 files changed, 164 insertions(+), 184 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index f994c1daf9d4..fc998339c405 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
+generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += vtime.h
diff --git a/arch/ia64/include/asm/export.h b/arch/ia64/include/asm/export.h
deleted file mode 100644
index ad18c6583252..000000000000
--- a/arch/ia64/include/asm/export.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* EXPORT_DATA_SYMBOL != EXPORT_SYMBOL here */
-#define KSYM_FUNC(name) @fptr(name)
-#include <asm-generic/export.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 5e4b1f2369d2..0ae9f38a904c 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -3,86 +3,12 @@
 #define __ASM_GENERIC_EXPORT_H
 
 /*
- * This comment block is used by fixdep. Please do not remove.
- *
- * When CONFIG_MODVERSIONS is changed from n to y, all source files having
- * EXPORT_SYMBOL variants must be re-compiled because genksyms is run as a
- * side effect of the *.o build rule.
+ * <asm/export.h> and <asm-generic/export.h> are deprecated.
+ * Please include <linux/export.h> directly.
  */
+#include <linux/export.h>
 
-#ifndef KSYM_FUNC
-#define KSYM_FUNC(x) x
-#endif
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define KSYM_ALIGN 4
-#elif defined(CONFIG_64BIT)
-#define KSYM_ALIGN 8
-#else
-#define KSYM_ALIGN 4
-#endif
-
-.macro __put, val, name
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-	.long	\val - ., \name - ., 0
-#elif defined(CONFIG_64BIT)
-	.quad	\val, \name, 0
-#else
-	.long	\val, \name, 0
-#endif
-.endm
-
-/*
- * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
- * section flag requires it. Use '%progbits' instead of '@progbits' since the
- * former apparently works on all arches according to the binutils source.
- */
-
-.macro ___EXPORT_SYMBOL name,val,sec
-#if defined(CONFIG_MODULES) && !defined(__DISABLE_EXPORTS)
-	.section ___ksymtab\sec+\name,"a"
-	.balign KSYM_ALIGN
-__ksymtab_\name:
-	__put \val, __kstrtab_\name
-	.previous
-	.section __ksymtab_strings,"aMS",%progbits,1
-__kstrtab_\name:
-	.asciz "\name"
-	.previous
-#endif
-.endm
-
-#if defined(CONFIG_TRIM_UNUSED_KSYMS)
-
-#include <linux/kconfig.h>
-#include <generated/autoksyms.h>
-
-.macro __ksym_marker sym
-	.section ".discard.ksym","a"
-__ksym_marker_\sym:
-	 .previous
-.endm
-
-#define __EXPORT_SYMBOL(sym, val, sec)				\
-	__ksym_marker sym;					\
-	__cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
-#define __cond_export_sym(sym, val, sec, conf)			\
-	___cond_export_sym(sym, val, sec, conf)
-#define ___cond_export_sym(sym, val, sec, enabled)		\
-	__cond_export_sym_##enabled(sym, val, sec)
-#define __cond_export_sym_1(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
-#define __cond_export_sym_0(sym, val, sec) /* nothing */
-
-#else
-#define __EXPORT_SYMBOL(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
-#endif
-
-#define EXPORT_SYMBOL(name)					\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
-#define EXPORT_SYMBOL_GPL(name) 				\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name), _gpl)
-#define EXPORT_DATA_SYMBOL(name)				\
-	__EXPORT_SYMBOL(name, name,)
-#define EXPORT_DATA_SYMBOL_GPL(name)				\
-	__EXPORT_SYMBOL(name, name,_gpl)
+#define EXPORT_DATA_SYMBOL(name)	EXPORT_SYMBOL(name)
+#define EXPORT_DATA_SYMBOL_GPL(name)	EXPORT_SYMBOL_GPL(name)
 
 #endif
diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index fe7e6ba918f1..8d921cde1b33 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Please do not include this explicitly.
+ * Please do not include this except from kernel/module/.
  * This is used by C files generated by modpost.
  */
 
@@ -10,6 +10,71 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+/*
+ * This struct is used in kernel/module/, but placed in this header
+ * to force rebuilding vmlinux when this header is updated.
+ */
+struct kernel_symbol {
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	int value_offset;
+	int name_offset;
+	int namespace_offset;
+#else
+	unsigned long value;
+	const char *name;
+	const char *namespace;
+#endif
+};
+
+#if defined(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
+/*
+ * relative reference: this reduces the size by half on 64-bit architectures,
+ * and eliminates the need for absolute relocations that require runtime
+ * processing on relocatable kernels.
+ */
+#define __KSYM_REF(sym)		".long " #sym "- ."
+#elif defined(CONFIG_64BIT)
+#define __KSYM_REF(sym)		".quad " #sym
+#else
+#define __KSYM_REF(sym)		".long " #sym
+#endif
+
+/*
+ * For every exported symbol, do the following:
+ *
+ * - Put the name of the symbol and namespace (empty string "" for none) in
+ *   __ksymtab_strings.
+ * - Place a struct kernel_symbol entry in the __ksymtab section.
+ *
+ * Note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
+ * former apparently works on all arches according to the binutils source.
+ */
+#define __KSYMTAB(name, sym, sec, ns)						\
+	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
+	    "__kstrtab_" #name ":"					"\n"	\
+	    "	.asciz \"" #name "\""					"\n"	\
+	    "__kstrtabns_" #name ":"					"\n"	\
+	    "	.asciz \"" ns "\""					"\n"	\
+	    "	.previous"						"\n"	\
+	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
+	    "	.balign	4"						"\n"	\
+	    "__ksymtab_" #name ":"					"\n"	\
+		__KSYM_REF(sym)						"\n"	\
+		__KSYM_REF(__kstrtab_ ##name)				"\n"	\
+		__KSYM_REF(__kstrtabns_ ##name)				"\n"	\
+	    "	.previous"						"\n"	\
+	)
+
+#ifdef CONFIG_IA64
+#define KSYM_FUNC(name)		@fptr(name)
+#else
+#define KSYM_FUNC(name)		name
+#endif
+
+#define KSYMTAB_FUNC(name, sec, ns)	__KSYMTAB(name, KSYM_FUNC(name), sec, ns)
+#define KSYMTAB_DATA(name, sec, ns)	__KSYMTAB(name, name, sec, ns)
+
 #define SYMBOL_CRC(sym, crc, sec)   \
 	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
 	    "__crc_" #sym ":"					"\n" \
diff --git a/include/linux/export.h b/include/linux/export.h
index 3f31ced0d977..0c71577cf8bb 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_EXPORT_H
 #define _LINUX_EXPORT_H
 
+#include <linux/compiler.h>
 #include <linux/stringify.h>
 
 /*
@@ -28,72 +29,28 @@ extern struct module __this_module;
 #else
 #define THIS_MODULE ((struct module *)0)
 #endif
-
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#include <linux/compiler.h>
-/*
- * Emit the ksymtab entry as a pair of relative references: this reduces
- * the size by half on 64-bit architectures, and eliminates the need for
- * absolute relocations that require runtime processing on relocatable
- * kernels.
- */
-#define __KSYMTAB_ENTRY(sym, sec)					\
-	__ADDRESSABLE(sym)						\
-	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.balign	4					\n"	\
-	    "__ksymtab_" #sym ":				\n"	\
-	    "	.long	" #sym "- .				\n"	\
-	    "	.long	__kstrtab_" #sym "- .			\n"	\
-	    "	.long	__kstrtabns_" #sym "- .			\n"	\
-	    "	.previous					\n")
-
-struct kernel_symbol {
-	int value_offset;
-	int name_offset;
-	int namespace_offset;
-};
-#else
-#define __KSYMTAB_ENTRY(sym, sec)					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
-
-struct kernel_symbol {
-	unsigned long value;
-	const char *name;
-	const char *namespace;
-};
-#endif
+#endif /* __ASSEMBLY__ */
 
 #ifdef __GENKSYMS__
 
 #define ___EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
+#elif defined(__ASSEMBLY__)
+
+#define ___EXPORT_SYMBOL(sym, sec, ns)				\
+	.section .discard.export_symbol ;			\
+	__export_symbol##sec##.sym: ;				\
+	.asciz ns ;						\
+	.previous
+
 #else
 
-/*
- * For every exported symbol, do the following:
- *
- * - Put the name of the symbol and namespace (empty string "" for none) in
- *   __ksymtab_strings.
- * - Place a struct kernel_symbol entry in the __ksymtab section.
- *
- * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
- * section flag requires it. Use '%progbits' instead of '@progbits' since the
- * former apparently works on all arches according to the binutils source.
- */
-#define ___EXPORT_SYMBOL(sym, sec, ns)						\
-	extern typeof(sym) sym;							\
-	extern const char __kstrtab_##sym[];					\
-	extern const char __kstrtabns_##sym[];					\
-	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1	\n"	\
-	    "__kstrtab_" #sym ":					\n"	\
-	    "	.asciz 	\"" #sym "\"					\n"	\
-	    "__kstrtabns_" #sym ":					\n"	\
-	    "	.asciz 	\"" ns "\"					\n"	\
-	    "	.previous						\n");	\
-	__KSYMTAB_ENTRY(sym, sec)
+#define ___EXPORT_SYMBOL(sym, sec, ns)				\
+	__ADDRESSABLE(sym)					\
+	asm(".section .discard.export_symbol		\n"	\
+	    "__export_symbol" #sec "." #sym ":		\n"	\
+	    ".asciz " "\"" ns "\"" "			\n"	\
+	    ".previous					\n")
 
 #endif
 
@@ -117,9 +74,21 @@ struct kernel_symbol {
  * from the $(NM) output (see scripts/gen_ksymdeps.sh). These symbols are
  * discarded in the final link stage.
  */
+
+#ifdef __ASSEMBLY__
+
+#define __ksym_marker(sym)					\
+	.section ".discard.ksym","a" ;				\
+__ksym_marker_##sym: ;						\
+	.previous
+
+#else
+
 #define __ksym_marker(sym)	\
 	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
 
+#endif
+
 #define __EXPORT_SYMBOL(sym, sec, ns)					\
 	__ksym_marker(sym);						\
 	__cond_export_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
@@ -147,11 +116,9 @@ struct kernel_symbol {
 #define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, "")
 #endif
 
-#define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym, "")
-#define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym, "_gpl")
-#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", __stringify(ns))
-#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", __stringify(ns))
-
-#endif /* !__ASSEMBLY__ */
+#define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym,)
+#define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym,_gpl)
+#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym,, __stringify(ns))
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym,_gpl, __stringify(ns))
 
 #endif /* _LINUX_EXPORT_H */
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 680d980a4fb2..fc2bf6c6ba05 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -7,6 +7,7 @@
 
 #include <linux/elf.h>
 #include <linux/compiler.h>
+#include <linux/export-internal.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4e4d84b6f4e..776aad90b3c6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -6,7 +6,6 @@
 
 #define INCLUDE_VERMAGIC
 
-#include <linux/export.h>
 #include <linux/extable.h>
 #include <linux/moduleloader.h>
 #include <linux/module_signature.h>
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 91d2e5461a3e..4c1d0bd1bc03 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -164,7 +164,7 @@ quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
 ifdef CONFIG_MODVERSIONS
 # When module versioning is enabled the following steps are executed:
 # o compile a <file>.o from <file>.c
-# o if <file>.o doesn't contain a __ksymtab version, i.e. does
+# o if <file>.o doesn't contain a __export_symbol*, i.e. does
 #   not export symbols, it's done.
 # o otherwise, we calculate symbol versions using the good old
 #   genksyms on the preprocessed source and dump them into the .cmd file.
@@ -172,7 +172,7 @@ ifdef CONFIG_MODVERSIONS
 #   be compiled and linked to the kernel and/or modules.
 
 gen_symversions =								\
-	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
+	if $(NM) $@ 2>/dev/null | grep -q '__export_symbol.*\.'; then		\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
 			>> $(dot-target).cmd;					\
 	fi
@@ -288,9 +288,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 cmd_gensymtypes_S =                                                         \
    { echo "\#include <linux/kernel.h>" ;                                    \
      echo "\#include <asm/asm-prototypes.h>" ;                              \
-    $(CPP) $(a_flags) $< |                                                  \
-     grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
+     $(NM) $@ | sed -n 's/.*__export_symbol.*\.\(.*\)/EXPORT_SYMBOL(\1);/p' ; } | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
diff --git a/scripts/check-local-export b/scripts/check-local-export
index 0c049ff44aca..e07534880fbf 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -45,9 +45,9 @@ BEGIN {
 { symbol_types[$3]=$2 }
 
 # append the exported symbol to the array
-($3 ~ /^__ksymtab_/) {
+($3 ~ /^__export_symbol.*\..*/) {
 	export_symbols[i] = $3
-	sub(/^__ksymtab_/, "", export_symbols[i])
+	sub(/^__export_symbol.*\./, "", export_symbols[i])
 	i++
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..13fff6e92aef 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -214,6 +214,7 @@ struct symbol {
 	unsigned int crc;
 	bool crc_valid;
 	bool weak;
+	bool is_func;
 	bool is_gpl_only;	/* exported by EXPORT_SYMBOL_GPL */
 	char name[];
 };
@@ -531,6 +532,8 @@ static int parse_elf(struct elf_info *info, const char *filename)
 				fatal("%s has NOBITS .modinfo\n", filename);
 			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
 			info->modinfo_len = sechdrs[i].sh_size;
+		} else if (!strcmp(secname, ".discard.export_symbol")) {
+			info->export_symbol_sec = i;
 		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
@@ -653,17 +656,20 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 				   ELF_ST_BIND(sym->st_info) == STB_WEAK);
 		break;
 	default:
-		/* All exported symbols */
-		if (strstarts(symname, "__ksymtab_")) {
-			const char *name, *secname;
+		if (sym->st_shndx == info->export_symbol_sec) {
+			const char *name;
 
-			name = symname + strlen("__ksymtab_");
-			secname = sec_name(info, get_secindex(info, sym));
-
-			if (strstarts(secname, "___ksymtab_gpl+"))
+			if (strstarts(symname, "__export_symbol_gpl.")) {
+				name = symname + strlen("__export_symbol_gpl.");
 				sym_add_exported(name, mod, true);
-			else if (strstarts(secname, "___ksymtab+"))
+				sym_update_namespace(name, sym_get_data(info, sym));
+			} else if (strstarts(symname, "__export_symbol.")) {
+				name = symname + strlen("__export_symbol.");
 				sym_add_exported(name, mod, false);
+				sym_update_namespace(name, sym_get_data(info, sym));
+			}
+
+			break;
 		}
 		if (strcmp(symname, "init_module") == 0)
 			mod->has_init = true;
@@ -865,7 +871,6 @@ enum mismatch {
 	XXXEXIT_TO_SOME_EXIT,
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
-	EXPORT_TO_INIT_EXIT,
 	EXTABLE_TO_NON_TEXT,
 };
 
@@ -960,12 +965,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = ANY_INIT_TO_ANY_EXIT,
 },
-/* Do not export init/exit functions or data */
-{
-	.fromsec = { "___ksymtab*", NULL },
-	.bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
-	.mismatch = EXPORT_TO_INIT_EXIT,
-},
 {
 	.fromsec = { "__ex_table", NULL },
 	/* If you're adding any new black-listed sections in here, consider
@@ -1256,10 +1255,6 @@ static void report_sec_mismatch(const char *modname,
 		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
 		     modname, fromsym, fromsec, tosym, tosec);
 		break;
-	case EXPORT_TO_INIT_EXIT:
-		warn("%s: EXPORT_SYMBOL used for init/exit symbol: %s (section: %s)\n",
-		     modname, tosym, tosec);
-		break;
 	case EXTABLE_TO_NON_TEXT:
 		fatal("There's a special handler for this mismatch type, we should never get here.\n");
 		break;
@@ -1634,6 +1629,36 @@ static void section_rel(const char *modname, struct elf_info *elf,
 	}
 }
 
+static void check_export_symbols(struct module *mod, struct elf_info *elf)
+{
+	Elf_Sym *sym;
+
+	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		const char *symname = sym_name(elf, sym);
+		const char *secname;
+		struct symbol *s;
+
+		s = sym_find_with_module(symname, mod);
+		if (!s)
+			continue;	/* This is not an exported symbol */
+
+		/*
+		 * We need to be aware whether we are exporting a function or
+		 * a data on some architectures.
+		 */
+		s->is_func = (ELF_ST_TYPE(sym->st_info) == STT_FUNC);
+
+		secname = sec_name(elf, get_secindex(elf, sym));
+
+		if (match(secname, PATTERNS(INIT_SECTIONS)))
+			error("%s: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.\n",
+			      symname);
+		else if (match(secname, PATTERNS(EXIT_SECTIONS)))
+			error("%s: EXPORT_SYMBOL used for exit symbol. Remove __exit or EXPORT_SYMBOL.\n",
+			      symname);
+	}
+}
+
 /**
  * A module includes a number of sections that are discarded
  * either when loaded or when used as built-in.
@@ -1820,16 +1845,8 @@ static void read_symbols(const char *modname)
 		handle_moddevtable(mod, &info, sym, symname);
 	}
 
-	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
-		symname = remove_dot(info.strtab + sym->st_name);
-
-		/* Apply symbol namespaces from __kstrtabns_<symbol> entries. */
-		if (strstarts(symname, "__kstrtabns_"))
-			sym_update_namespace(symname + strlen("__kstrtabns_"),
-					     sym_get_data(&info, sym));
-	}
-
 	check_sec_ref(modname, &info);
+	check_export_symbols(mod, &info);
 
 	if (!mod->is_vmlinux) {
 		version = get_modinfo(&info, "version");
@@ -2015,6 +2032,14 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 {
 	struct symbol *sym;
 
+	/* generate struct for exported symbols */
+	buf_printf(buf, "\n");
+	list_for_each_entry(sym, &mod->exported_symbols, list)
+		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
+			   sym->is_func ? "FUNC" : "DATA", sym->name,
+			   sym->is_gpl_only ? "_gpl" : "",
+			   sym->namespace ?: "");
+
 	if (!modversions)
 		return;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1178f40a73f3..6f7a5c2d37b9 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -137,6 +137,7 @@ struct elf_info {
 	Elf_Shdr     *sechdrs;
 	Elf_Sym      *symtab_start;
 	Elf_Sym      *symtab_stop;
+	unsigned int export_symbol_sec;	/* .discard.export_symbol section */
 	char         *strtab;
 	char	     *modinfo;
 	unsigned int modinfo_len;
-- 
2.34.1

