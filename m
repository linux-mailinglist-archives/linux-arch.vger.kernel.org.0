Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077263068E6
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 01:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhA1AyV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 19:54:21 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:28372 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhA1AyG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:54:06 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIa024172;
        Thu, 28 Jan 2021 09:51:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIa024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795112;
        bh=PghsErXRW5vG8CTmm4U2vcBuX0s3PC2V7r+UFWmFal8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TE41ccIlEprujCIQe7mUsqVl64X/SnM1UJ03rqR92k0FEuTsnz6isl9b6rH5NsyXJ
         x+tyC3KtFXNuGyiu7jmezn1QAiHU7jj/Qui+GFkfl1zSDGBQ7BxVscJiM6M7kXhHp2
         VFezfBjhfOTZNqfblnJoV2ZTOPiifhki/NJ6ddsQEnCLlf8J7wub+SJkxmUTgabz3G
         luTK7UmbdBunhzaQhSpceM3hU+/AzV6M6ln9bdpE/cjbDC3SXoTHgvR0MXwoXVJtxm
         BKRM5a71GLIlWCxpRf/yJL1KNcglrxNr5SFKmqZ3/nc2OOGa/s5N06nLBIbZaVEMay
         RysyMD/EQ0X2g==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arch@vger.kernel.org, x86@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 05/27] x86/syscalls: switch to generic syscalltbl.sh
Date:   Thu, 28 Jan 2021 09:50:47 +0900
Message-Id: <20210128005110.2613902-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128005110.2613902-1-masahiroy@kernel.org>
References: <20210128005110.2613902-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As of v5.11-rc1, 12 architectures duplicate similar shell scripts in
order to generate syscall table headers. My goal is to unify them into
the single scripts/syscalltbl.sh.

This commit converts x86 and UML to use scripts/syscalltbl.sh.

Currently, syscall_64.h mixes up x86_64 and x32 syscalls. This commit
separates syscall_64.h and syscall_x32.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/syscall_32.c           | 12 +++++--
 arch/x86/entry/syscall_64.c           |  9 ++----
 arch/x86/entry/syscall_x32.c          | 15 +++------
 arch/x86/entry/syscalls/Makefile      | 10 ++++--
 arch/x86/entry/syscalls/syscalltbl.sh | 46 ---------------------------
 arch/x86/include/asm/Kbuild           |  1 +
 arch/x86/um/sys_call_table_32.c       |  8 +++--
 arch/x86/um/sys_call_table_64.c       |  9 ++----
 8 files changed, 34 insertions(+), 76 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 86eb0d89d46f..70bf46e73b1c 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -8,12 +8,18 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
+#ifdef CONFIG_IA32_EMULATION
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#else
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#endif
+
+#define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
-#undef __SYSCALL_I386
+#undef __SYSCALL
 
-#define __SYSCALL_I386(nr, sym) [nr] = __ia32_##sym,
+#define __SYSCALL(nr, sym) [nr] = __ia32_##sym,
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 1594ec72bcbb..82670bb10931 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,14 +8,11 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
-#undef __SYSCALL_64
+#undef __SYSCALL
 
-#define __SYSCALL_64(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 3fea8fb9cd6a..6d2ef887d7b6 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,16 +8,11 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym)
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#include <asm/syscalls_x32.h>
+#undef __SYSCALL
 
-#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#include <asm/syscalls_64.h>
-#undef __SYSCALL_X32
-#undef __SYSCALL_COMMON
-
-#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
-#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
@@ -25,5 +20,5 @@ asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	 * when the & below is removed.
 	 */
 	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
-#include <asm/syscalls_64.h>
+#include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index e1c7ddb7546b..4409d148af1e 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -10,7 +10,7 @@ syscall32 := $(srctree)/$(src)/syscall_32.tbl
 syscall64 := $(srctree)/$(src)/syscall_64.tbl
 
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
@@ -18,7 +18,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_pfx_$(basetarget))' \
 		   '$(syshdr_offset_$(basetarget))'
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@ $(abis)
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<,$^)
@@ -46,10 +46,15 @@ syshdr_pfx_unistd_64_x32 := x32_
 $(out)/unistd_64_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
+$(out)/syscalls_32.h: abis := i386
 $(out)/syscalls_32.h: $(syscall32) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_64.h: abis := common,64
 $(out)/syscalls_64.h: $(syscall64) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_x32.h: abis := common,x32
+$(out)/syscalls_x32.h: $(syscall64) $(systbl) FORCE
+	$(call if_changed,systbl)
 
 $(out)/xen-hypercalls.h: $(srctree)/scripts/xen-hypercalls.sh FORCE
 	$(call if_changed,hypercalls)
@@ -60,6 +65,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
+syshdr-$(CONFIG_X86_X32)	+= syscalls_x32.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
deleted file mode 100644
index 929bde120d6b..000000000000
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-
-syscall_macro() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-
-    echo "__SYSCALL_${abi}($nr, $entry)"
-}
-
-emit() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-    local compat="$4"
-
-    if [ "$abi" != "I386" -a -n "$compat" ]; then
-	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
-	exit 1
-    fi
-
-    if [ -z "$compat" ]; then
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-    else
-	echo "#ifdef CONFIG_X86_32"
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-	echo "#else"
-	syscall_macro "$abi" "$nr" "$compat"
-	echo "#endif"
-    fi
-}
-
-grep '^[0-9]' "$in" | sort -n | (
-    while read nr abi name entry compat; do
-	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
-	emit "$abi" "$nr" "$entry" "$compat"
-    done
-) > "$out"
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index b19ec8282d50..1e51650b79d7 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -3,6 +3,7 @@
 
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
+generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 2ed81e581755..e83619c365dc 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -26,11 +26,13 @@
 
 #define old_mmap sys_old_mmap
 
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
 
-#undef __SYSCALL_I386
-#define __SYSCALL_I386(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 2e8544dafbb0..6fb75af7cf54 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,14 +36,11 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 
-#undef __SYSCALL_64
-#define __SYSCALL_64(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
-- 
2.27.0

