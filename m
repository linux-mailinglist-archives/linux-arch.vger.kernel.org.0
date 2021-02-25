Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBA325301
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 17:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBYQE6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 11:04:58 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:52882 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBYQEh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 11:04:37 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 11PG2sqK028425;
        Fri, 26 Feb 2021 01:02:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11PG2sqK028425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614268978;
        bh=hbYuoiJCqa35JQoeVSvd+1vUo+5YS8+NSbNlWqxYUqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr5yZdLYD+Tga2G/ZsYmDAPhVQd42efp5Jh428SuqJ7TMzTJhQooFn5NmHL9b8gF3
         2Ylexj0e420b0g4u0gX/L3K1YOPBZ9LIOlTQmTDGx7qoGDKWvD90jtwI+1i1WgQU83
         Grx7esyHqSg4/6TJkqEJlu5c6Yrg5FpP/CP/nb5OebZac78tmtRllRTJr8m5qgqPpM
         g92pJL+rGORWCMmOrsea0w+zbQp3oNFtg15feJtm5UaqeGaNrsURps6Wmy8otfohEX
         N7RNxB7H6Wyj4nUPOjI7WbpbPp2KxZAuOCl4a4yKGuVM9TAg3CrsaoIqKhW+Dmq32C
         zzLNi5rXe9UuQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to make it work in one-pass
Date:   Fri, 26 Feb 2021 01:02:46 +0900
Message-Id: <20210225160247.2959903-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210225160247.2959903-1-masahiroy@kernel.org>
References: <20210225160247.2959903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some
guarding") re-enabled this feature, but Linus is still unhappy about
the build time.

The reason of the slowness is the recursion - after updating
<generated/autoksyms.h> (, which contains all symbols needed by modules),
Kbuild begins the second traverse, rebuilding objects whose EXPORT_SYMBOL
needs flipping.

This commit re-implements CONFIG_TRIM_UNUSED_KSYMS to make it work
in one pass. After the tree traverse, a linker script snippet
<generated/keep-ksyms.h> is generated. It feeds the list of necessary
sections to vmlinus.lds.S and modules.lds.S. The other sections fall
into DISCARDS.

There is no more build issue, I believe. I dropped the 'if EXPORT' and
'depends on !COMPILE_TEST' guarding.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                                      | 30 +++-----
 include/asm-generic/export.h                  | 23 ------
 include/asm-generic/vmlinux.lds.h             | 29 +++++--
 include/linux/export.h                        | 54 +++----------
 init/Kconfig                                  |  3 +-
 scripts/Makefile.build                        |  5 --
 scripts/adjust_autoksyms.sh                   | 76 -------------------
 .../{gen_autoksyms.sh => gen-keep-ksyms.sh}   | 34 ++++++---
 scripts/gen_ksymdeps.sh                       | 25 ------
 scripts/module.lds.S                          | 38 +++++++---
 10 files changed, 103 insertions(+), 214 deletions(-)
 delete mode 100755 scripts/adjust_autoksyms.sh
 rename scripts/{gen_autoksyms.sh => gen-keep-ksyms.sh} (78%)
 delete mode 100755 scripts/gen_ksymdeps.sh

diff --git a/Makefile b/Makefile
index 34393fd72fe1..cda800fa2f78 100644
--- a/Makefile
+++ b/Makefile
@@ -1160,29 +1160,23 @@ export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
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
@@ -1194,11 +1188,11 @@ cmd_link-vmlinux =                                                 \
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
@@ -1227,7 +1221,7 @@ scripts: scripts_basic scripts_dtc
 PHONY += prepare archprepare
 
 archprepare: outputmakefile archheaders archscripts scripts include/config/kernel.release \
-	asm-generic $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
+	asm-generic $(version_h) include/generated/utsrelease.h \
 	include/generated/autoconf.h
 
 prepare0: archprepare
@@ -1503,7 +1497,7 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_FILES += include/ksym vmlinux.symvers \
+CLEAN_FILES += vmlinux.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       compile_commands.json
 
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
index 5a2b31890bb8..f2b0990be159 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,24 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#if CONFIG_TRIM_UNUSED_KSYMS
+#include <generated/keep-ksyms.h>
+
+#define KSYM_DISCARDS		*(___ksymtab+*) \
+				*(___ksymtab_gpl+*) \
+				*(___kcrctab+*) \
+				*(___kcrctab_gpl+*) \
+				*(__ksymtab_strings+*)
+
+#else
+#define KSYMTAB			KEEP(*(SORT(___ksymtab+*)))
+#define KSYMTAB_GPL		KEEP(*(SORT(___ksymtab_gpl+*)))
+#define KCRCTAB			KEEP(*(SORT(___kcrctab+*)))
+#define KCRCTAB_GPL		KEEP(*(SORT(___kcrctab_gpl+*)))
+#define KSYMTAB_STRINGS		*(__ksymtab_strings+*)
+#define KSYM_DISCARDS
+#endif
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
@@ -486,34 +504,34 @@
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
@@ -993,6 +1011,7 @@
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
diff --git a/init/Kconfig b/init/Kconfig
index 351161326e3c..e52034f66aeb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2259,8 +2259,7 @@ config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	  If unsure, say N.
 
 config TRIM_UNUSED_KSYMS
-	bool "Trim unused exported kernel symbols" if EXPERT
-	depends on !COMPILE_TEST
+	bool "Trim unused exported kernel symbols"
 	help
 	  The kernel and some modules make many symbols available for
 	  other modules to use via EXPORT_SYMBOL() and variants. Depending
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd573e5ca0b9..fd2d7517a652 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -245,16 +245,12 @@ objtool_dep = $(objtool_obj)					\
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
@@ -264,7 +260,6 @@ endef
 
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
-	$(call cmd,gen_ksymdeps)
 	$(call cmd,objtool)
 	$(call cmd,modversions_S)
 endef
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
deleted file mode 100755
index 2b366d945ccb..000000000000
--- a/scripts/adjust_autoksyms.sh
+++ /dev/null
@@ -1,76 +0,0 @@
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
-# We need access to CONFIG_ symbols
-. include/config/auto.conf
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
similarity index 78%
rename from scripts/gen_autoksyms.sh
rename to scripts/gen-keep-ksyms.sh
index b74d5949fea6..cedb18fac46b 100755
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
@@ -49,15 +59,14 @@ fi
 
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
-cat > "$output_file" << EOT
+cat << EOT
 /*
  * Automatically generated file; DO NOT EDIT.
  */
 
 EOT
 
-[ -f modules.order ] && modlist=modules.order || modlist=/dev/null
-
+syms=$(
 {
 	sed 's/ko$/mod/' $modlist | xargs -n1 sed -n -e '2p'
 	echo "$needed_symbols"
@@ -67,4 +76,11 @@ EOT
 # point addresses.
 sed -e 's/^\.//' |
 sort -u |
-sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
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
index 168cd27e6122..a6d2d96e29f0 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,16 +3,30 @@
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
+#if CONFIG_TRIM_UNUSED_KSYMS
+#include <generated/keep-ksyms.h>
+
+#define KSYM_DISCARDS	*(___ksymtab+*) \
+			*(___ksymtab_gpl+*) \
+			*(___kcrctab+*) \
+			*(___kcrctab_gpl+*) \
+			*(__ksymtab_strings+*)
+#else
+#define KSYMTAB		KEEP(*(SORT(___ksymtab+*)))
+#define KSYMTAB_GPL	KEEP(*(SORT(___ksymtab_gpl+*)))
+#define KCRCTAB		KEEP(*(SORT(___kcrctab+*)))
+#define KCRCTAB_GPL	KEEP(*(SORT(___kcrctab_gpl+*)))
+#define KSYMTAB_STRINGS		*(__ksymtab_strings+*)
+#define KSYM_DISCARDS
+#endif
+
+SECTIONS {
+	__ksymtab		0 : { KSYMTAB }
+	__ksymtab_gpl		0 : { KSYMTAB_GPL }
+	__kcrctab		0 : { KCRCTAB }
+	__kcrctab_gpl		0 : { KCRCTAB_GPL }
+	__ksymtab_strings	0 : { KSYMTAB_STRINGS }
 
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
@@ -41,6 +55,12 @@ SECTIONS {
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

