Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A089332A25
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 16:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhCIPSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 10:18:54 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31505 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhCIPSs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 10:18:48 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 129FHiTf030658;
        Wed, 10 Mar 2021 00:17:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 129FHiTf030658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615303067;
        bh=REIckjyLxpZ8tXAYyGdiAhFqONKT/V3zE/ei2oQzpJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kmrn9/WNzfcSGTgniONbuXlmXCSs+rv388XnQ1GaG7o21x8ZzLSt8QRdjWlfr1YTi
         FtM5lPlpFt2IGq3BG/6RKHDQtMWYkhbRd55pMtVn3pLrSoJkNoN/ry0cGgrf7yHm1U
         uwYguRCxHAS/QNnK++C9v8v5tywEqqyQSk3hbb4NFBA2ErnOPqq6GylTC58oyM6GE4
         aukUuq+/pFqtH0pi6ke/yE079qjpJrge6li0+tvvfaP0SKhSzkqxTfxDM5Sh8sJGns
         NXz+9giY1cGiEUPMRdoZz2ns17ZCxvCFFYeSIN+Qc2UkJIC+0IqH0G085LME2NGkKh
         ggqQtJfa/Jtyw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 3/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to make it work in one-pass
Date:   Wed, 10 Mar 2021 00:17:36 +0900
Message-Id: <20210309151737.345722-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210309151737.345722-1-masahiroy@kernel.org>
References: <20210309151737.345722-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some
guarding") re-enabled this feature, but Linus is still unhappy about
the build time.

The reason of the slowness is the recursion - this basically works in
two loops.

In the first loop, Kbuild builds the entire tree based on the temporary
autoksyms.h, which contains macro defines to control whether their
corresponding EXPORT_SYMBOL() is enabled or not, and also gathers all
symbols required by modules. After the tree traverse, Kbuild updates
autoksyms.h and triggers the second loop to rebuild source files whose
EXPORT_SYMBOL() needs flipping.

This commit re-implements CONFIG_TRIM_UNUSED_KSYMS to make it work in
one pass. In the new design, unneeded EXPORT_SYMBOL() instances are
trimmed by the linker instead of the preprocessor.

After the tree traverse, a linker script snippet <generated/keep-ksyms.h>
is generated. It feeds the list of necessary sections to vmlinus.lds.S
and modules.lds.S. The other sections fall into /DISCARD/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix build errors
  - Add LC_ALL=C so the script will not be affected by the user's locale

 Makefile                                      | 30 +++-----
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |  1 +
 arch/powerpc/kernel/vdso32/vdso32.lds.S       |  1 +
 arch/powerpc/kernel/vdso64/vdso64.lds.S       |  1 +
 arch/s390/purgatory/purgatory.lds.S           |  1 +
 include/asm-generic/export.h                  | 23 ------
 include/asm-generic/vmlinux.lds.h             | 13 ++--
 include/linux/export.h                        | 54 +++-----------
 include/linux/ksyms.lds.h                     | 22 ++++++
 scripts/Makefile.build                        |  5 --
 scripts/Makefile.lib                          |  1 +
 scripts/adjust_autoksyms.sh                   | 73 -------------------
 .../{gen_autoksyms.sh => gen-keep-ksyms.sh}   | 43 ++++++++---
 scripts/gen_ksymdeps.sh                       | 25 -------
 scripts/module.lds.S                          | 23 +++---
 15 files changed, 105 insertions(+), 211 deletions(-)
 create mode 100644 include/linux/ksyms.lds.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 rename scripts/{gen_autoksyms.sh => gen-keep-ksyms.sh} (66%)
 delete mode 100755 scripts/gen_ksymdeps.sh

diff --git a/Makefile b/Makefile
index 89862b9f45d7..25a5c0c3fb7d 100644
--- a/Makefile
+++ b/Makefile
@@ -1162,29 +1162,23 @@ export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 # used by scripts/Makefile.package
 export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) LICENSES arch include scripts tools)
 
-vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
+targets :=
 
-# Recurse until adjust_autoksyms.sh is satisfied
-PHONY += autoksyms_recursive
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 # For the kernel to actually contain only the needed exported symbols,
 # we have to build modules as well to determine what those symbols are.
 # (this can be evaluated only once include/config/auto.conf has been included)
 KBUILD_MODULES := 1
 
-autoksyms_recursive: descend modules.order
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
-	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
-endif
-
-autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
+quiet_cmd_gen_used_ksyms = GEN     $@
+      cmd_gen_used_ksyms = $(CONFIG_SHELL) $(srctree)/scripts/gen-keep-ksyms.sh $< > $@
 
-quiet_cmd_autoksyms_h = GEN     $@
-      cmd_autoksyms_h = mkdir -p $(dir $@); \
-			$(CONFIG_SHELL) $(srctree)/scripts/gen_autoksyms.sh $@
+include/generated/keep-ksyms.h: modules.order FORCE
+	$(call if_changed,gen_used_ksyms)
+targets += include/generated/keep-ksyms.h
 
-$(autoksyms_h):
-	$(call cmd,autoksyms_h)
+$(KBUILD_LDS) modules_prepare: include/generated/keep-ksyms.h
+endif
 
 $(KBUILD_LDS): prepare FORCE
 	$(Q)$(MAKE) $(build)=$(patsubst %/,%,$(dir $@)) $@
@@ -1196,11 +1190,11 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(KBUILD_LDS) \
+vmlinux: scripts/link-vmlinux.sh $(KBUILD_LDS) \
 			$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
 	+$(call if_changed,link-vmlinux)
 
-targets := vmlinux
+targets += vmlinux
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
@@ -1229,7 +1223,7 @@ scripts: scripts_basic scripts_dtc
 PHONY += prepare archprepare
 
 archprepare: outputmakefile archheaders archscripts scripts include/config/kernel.release \
-	asm-generic $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
+	asm-generic $(version_h) include/generated/utsrelease.h \
 	include/generated/autoconf.h
 
 prepare0: archprepare
@@ -1515,7 +1509,7 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_FILES += include/ksym vmlinux.symvers \
+CLEAN_FILES += vmlinux.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       compile_commands.json .thinlto-cache
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index cd119d82d8e3..0b0407317756 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -6,6 +6,7 @@
  * Linker script used for partial linking of nVHE EL2 object files.
  */
 
+#define NO_TRIM_KSYMS
 #include <asm/hyp_image.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index a4b806b0d618..5c519a1e1538 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -3,6 +3,7 @@
  * This is the infamous ld script for the 32 bits vdso
  * library
  */
+#define NO_TRIM_KSYMS
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 2f3c359cacd3..cab126eff255 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -3,6 +3,7 @@
  * This is the infamous ld script for the 64 bits vdso
  * library
  */
+#define NO_TRIM_KSYMS
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
diff --git a/arch/s390/purgatory/purgatory.lds.S b/arch/s390/purgatory/purgatory.lds.S
index 482eb4fbcef1..09c2d1544081 100644
--- a/arch/s390/purgatory/purgatory.lds.S
+++ b/arch/s390/purgatory/purgatory.lds.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#define NO_TRIM_KSYMS
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index e847f1fde367..b9be5b1dd7e6 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -57,30 +57,7 @@ __kstrtab_\name:
 #endif
 .endm
 
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
 #define __EXPORT_SYMBOL(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
-#endif
 
 #define EXPORT_SYMBOL(name)					\
 	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6ce6dcabdccf..a2c2eb6f70ea 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,8 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <linux/ksyms.lds.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
@@ -486,34 +488,34 @@
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
-		KEEP(*(SORT(___ksymtab+*)))				\
+		KSYMTAB							\
 		__stop___ksymtab = .;					\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
 		__start___ksymtab_gpl = .;				\
-		KEEP(*(SORT(___ksymtab_gpl+*)))				\
+		KSYMTAB_GPL						\
 		__stop___ksymtab_gpl = .;				\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
-		KEEP(*(SORT(___kcrctab+*)))				\
+		KCRCTAB							\
 		__stop___kcrctab = .;					\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
 		__start___kcrctab_gpl = .;				\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
+		KCRCTAB_GPL						\
 		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
-		*(__ksymtab_strings+*)					\
+		KSYMTAB_STRINGS						\
 	}								\
 									\
 	/* __*init sections */						\
@@ -999,6 +1001,7 @@
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
+	KSYM_DISCARDS							\
 	COMMON_DISCARDS							\
 	}
 
diff --git a/include/linux/export.h b/include/linux/export.h
index 01e6ab19b226..f9cc13cd2c8c 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -76,9 +76,18 @@ struct kernel_symbol {
 };
 #endif
 
-#ifdef __GENKSYMS__
+#if !defined(CONFIG_MODULES) || defined(__DISABLE_EXPORTS)
+
+/*
+ * Allow symbol exports to be disabled completely so that C code may
+ * be reused in other execution contexts such as the UEFI stub or the
+ * decompressor.
+ */
+#define __EXPORT_SYMBOL(sym, sec, ns)
+
+#elif defined(__GENKSYMS__)
 
-#define ___EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
+#define __EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
 #else
 
@@ -94,7 +103,7 @@ struct kernel_symbol {
  * section flag requires it. Use '%progbits' instead of '@progbits' since the
  * former apparently works on all arches according to the binutils source.
  */
-#define ___EXPORT_SYMBOL(sym, sec, ns)						\
+#define __EXPORT_SYMBOL(sym, sec, ns)						\
 	extern typeof(sym) sym;							\
 	extern const char __kstrtab_##sym[];					\
 	extern const char __kstrtabns_##sym[];					\
@@ -107,45 +116,6 @@ struct kernel_symbol {
 	    "	.previous						\n");	\
 	__KSYMTAB_ENTRY(sym, sec)
 
-#endif
-
-#if !defined(CONFIG_MODULES) || defined(__DISABLE_EXPORTS)
-
-/*
- * Allow symbol exports to be disabled completely so that C code may
- * be reused in other execution contexts such as the UEFI stub or the
- * decompressor.
- */
-#define __EXPORT_SYMBOL(sym, sec, ns)
-
-#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
-
-#include <generated/autoksyms.h>
-
-/*
- * For fine grained build dependencies, we want to tell the build system
- * about each possible exported symbol even if they're not actually exported.
- * We use a symbol pattern __ksym_marker_<symbol> that the build system filters
- * from the $(NM) output (see scripts/gen_ksymdeps.sh). These symbols are
- * discarded in the final link stage.
- */
-#define __ksym_marker(sym)	\
-	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
-
-#define __EXPORT_SYMBOL(sym, sec, ns)					\
-	__ksym_marker(sym);						\
-	__cond_export_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
-#define __cond_export_sym(sym, sec, ns, conf)				\
-	___cond_export_sym(sym, sec, ns, conf)
-#define ___cond_export_sym(sym, sec, ns, enabled)			\
-	__cond_export_sym_##enabled(sym, sec, ns)
-#define __cond_export_sym_1(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
-#define __cond_export_sym_0(sym, sec, ns) /* nothing */
-
-#else
-
-#define __EXPORT_SYMBOL(sym, sec, ns)	___EXPORT_SYMBOL(sym, sec, ns)
-
 #endif /* CONFIG_MODULES */
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
diff --git a/include/linux/ksyms.lds.h b/include/linux/ksyms.lds.h
new file mode 100644
index 000000000000..fdb7a04053b0
--- /dev/null
+++ b/include/linux/ksyms.lds.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KSYMS_LDS_H
+#define __KSYMS_LDS_H
+
+#if defined(CONFIG_TRIM_UNUSED_KSYMS) && !defined(NO_TRIM_KSYMS)
+#include <generated/keep-ksyms.h>
+
+#define KSYM_DISCARDS		*(___ksymtab+*) \
+				*(___ksymtab_gpl+*) \
+				*(___kcrctab+*) \
+				*(___kcrctab_gpl+*) \
+				*(__ksymtab_strings+*)
+#else
+#define KSYMTAB			KEEP(*(SORT(___ksymtab+*)))
+#define KSYMTAB_GPL		KEEP(*(SORT(___ksymtab_gpl+*)))
+#define KCRCTAB			KEEP(*(SORT(___kcrctab+*)))
+#define KCRCTAB_GPL		KEEP(*(SORT(___kcrctab_gpl+*)))
+#define KSYMTAB_STRINGS		*(__ksymtab_strings+*)
+#define KSYM_DISCARDS
+#endif
+
+#endif /* __KSYMS_LDS_H */
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7df96bfe694e..71ffe1d06265 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -244,16 +244,12 @@ objtool_dep = $(objtool_obj)					\
 			 include/config/stack/validation.h)
 
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_gen_ksymdeps = \
-	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
-
 # List module undefined symbols
 undefined_syms = $(NM) $< | $(AWK) '$$1 == "U" { printf("%s%s", x++ ? " " : "", $$2) }';
 endif
 
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
-	$(call cmd,gen_ksymdeps)
 	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
 	$(call cmd,objtool)
@@ -263,7 +259,6 @@ endef
 
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
-	$(call cmd,gen_ksymdeps)
 	$(call cmd,objtool)
 	$(call cmd,modversions_S)
 endef
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index eee59184de64..f3da140191fb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -311,6 +311,7 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 quiet_cmd_dt_S_dtb= DTB     $@
 cmd_dt_S_dtb=						\
 {							\
+	echo '\#define NO_TRIM_KSYMS';			\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
deleted file mode 100755
index d8f6f9c63043..000000000000
--- a/scripts/adjust_autoksyms.sh
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-only
-
-# Script to update include/generated/autoksyms.h and dependency files
-#
-# Copyright:	(C) 2016  Linaro Limited
-# Created by:	Nicolas Pitre, January 2016
-#
-
-# Update the include/generated/autoksyms.h file.
-#
-# For each symbol being added or removed, the corresponding dependency
-# file's timestamp is updated to force a rebuild of the affected source
-# file. All arguments passed to this script are assumed to be a command
-# to be exec'd to trigger a rebuild of those files.
-
-set -e
-
-cur_ksyms_file="include/generated/autoksyms.h"
-new_ksyms_file="include/generated/autoksyms.h.tmpnew"
-
-info() {
-	if [ "$quiet" != "silent_" ]; then
-		printf "  %-7s %s\n" "$1" "$2"
-	fi
-}
-
-info "CHK" "$cur_ksyms_file"
-
-# Use "make V=1" to debug this script.
-case "$KBUILD_VERBOSE" in
-*1*)
-	set -x
-	;;
-esac
-
-# Generate a new symbol list file
-$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh "$new_ksyms_file"
-
-# Extract changes between old and new list and touch corresponding
-# dependency files.
-changed=$(
-count=0
-sort "$cur_ksyms_file" "$new_ksyms_file" | uniq -u |
-sed -n 's/^#define __KSYM_\(.*\) 1/\1/p' | tr "A-Z_" "a-z/" |
-while read sympath; do
-	if [ -z "$sympath" ]; then continue; fi
-	depfile="include/ksym/${sympath}.h"
-	mkdir -p "$(dirname "$depfile")"
-	touch "$depfile"
-	# Filesystems with coarse time precision may create timestamps
-	# equal to the one from a file that was very recently built and that
-	# needs to be rebuild. Let's guard against that by making sure our
-	# dep files are always newer than the first file we created here.
-	while [ ! "$depfile" -nt "$new_ksyms_file" ]; do
-		touch "$depfile"
-	done
-	echo $((count += 1))
-done | tail -1 )
-changed=${changed:-0}
-
-if [ $changed -gt 0 ]; then
-	# Replace the old list with tne new one
-	old=$(grep -c "^#define __KSYM_" "$cur_ksyms_file" || true)
-	new=$(grep -c "^#define __KSYM_" "$new_ksyms_file" || true)
-	info "KSYMS" "symbols: before=$old, after=$new, changed=$changed"
-	info "UPD" "$cur_ksyms_file"
-	mv -f "$new_ksyms_file" "$cur_ksyms_file"
-	# Then trigger a rebuild of affected source files
-	exec $@
-else
-	rm -f "$new_ksyms_file"
-fi
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen-keep-ksyms.sh
similarity index 66%
rename from scripts/gen_autoksyms.sh
rename to scripts/gen-keep-ksyms.sh
index da320151e7c3..306e9b88aae9 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen-keep-ksyms.sh
@@ -1,13 +1,23 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only
 
-# Create an autoksyms.h header file from the list of all module's needed symbols
-# as recorded on the second line of *.mod files and the user-provided symbol
-# whitelist.
-
 set -e
 
-output_file="$1"
+modlist=$1
+
+emit ()
+{
+	local macro="$1"
+	local prefix="$2"
+	local syms="$3"
+
+	echo "#define $macro \\"
+	for s in $syms
+	do
+		echo "	KEEP(*($prefix$s)) \\"
+	done
+	echo
+}
 
 # Use "make V=1" to debug this script.
 case "$KBUILD_VERBOSE" in
@@ -51,15 +61,14 @@ fi
 
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
-cat > "$output_file" << EOT
+cat << EOF
 /*
  * Automatically generated file; DO NOT EDIT.
  */
 
-EOT
-
-[ -f modules.order ] && modlist=modules.order || modlist=/dev/null
+EOF
 
+syms=$(
 {
 	sed 's/ko$/mod/' $modlist | xargs -n1 sed -n -e '2p'
 	echo "$needed_symbols"
@@ -68,5 +77,17 @@ EOT
 # Remove the dot prefix for ppc64; symbol names with a dot (.) hold entry
 # point addresses.
 sed -e 's/^\.//' |
-sort -u |
-sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
+# Sorting is essential because the module subsystem uses binary search for
+# symbol resolution. For CONFIG_TRIM_UNUSED_KSYMS=n, this is done by the
+# linker's SORT command (an alias of SORT_BY_NAME). For CONFIG_TRIM_UNUSED=y,
+# symbols are linked in the same order as this script outputs.
+# Add LC_ALL=C to make it work irrespective of the build environment.
+LC_ALL=C sort -u |
+sed -e 's/\(.*\)/\1/'
+)
+
+emit "KSYMTAB"		"___ksymtab+"		"$syms"
+emit "KSYMTAB_GPL"	"___ksymtab_gpl+"	"$syms"
+emit "KCRCTAB"		"___kcrctab_gpl+"	"$syms"
+emit "KCRCTAB_GPL"	"___kcrctab_gpl+"	"$syms"
+emit "KSYMTAB_STRINGS"	"__ksymtab_strings+"	"$syms"
diff --git a/scripts/gen_ksymdeps.sh b/scripts/gen_ksymdeps.sh
deleted file mode 100755
index 1324986e1362..000000000000
--- a/scripts/gen_ksymdeps.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-set -e
-
-# List of exported symbols
-ksyms=$($NM $1 | sed -n 's/.*__ksym_marker_\(.*\)/\1/p' | tr A-Z a-z)
-
-if [ -z "$ksyms" ]; then
-	exit 0
-fi
-
-echo
-echo "ksymdeps_$1 := \\"
-
-for s in $ksyms
-do
-	echo $s | sed -e 's:^_*:    $(wildcard include/ksym/:' \
-			-e 's:__*:/:g' -e 's/$/.h) \\/'
-done
-
-echo
-echo "$1: \$(ksymdeps_$1)"
-echo
-echo "\$(ksymdeps_$1):"
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..ab96471141f0 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,16 +3,15 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
-SECTIONS {
-	/DISCARD/ : {
-		*(.discard)
-		*(.discard.*)
-	}
 
-	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : { *(SORT(___ksymtab_gpl+*)) }
-	__kcrctab		0 : { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : { *(SORT(___kcrctab_gpl+*)) }
+#include <linux/ksyms.lds.h>
+
+SECTIONS {
+	__ksymtab		0 : { KSYMTAB }
+	__ksymtab_gpl		0 : { KSYMTAB_GPL }
+	__kcrctab		0 : { KCRCTAB }
+	__kcrctab_gpl		0 : { KCRCTAB_GPL }
+	__ksymtab_strings	0 : { KSYMTAB_STRINGS }
 
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
@@ -41,6 +40,12 @@ SECTIONS {
 	}
 
 	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+
+	/DISCARD/ : {
+		*(.discard)
+		*(.discard.*)
+		KSYM_DISCARDS
+	}
 }
 
 /* bring in arch-specific sections */
-- 
2.27.0

