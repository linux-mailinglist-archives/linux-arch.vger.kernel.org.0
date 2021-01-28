Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8607C30690A
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 01:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhA1A5R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 19:57:17 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:28847 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhA1A4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:56:04 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIs024172;
        Thu, 28 Jan 2021 09:52:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIs024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795136;
        bh=sXMNoBLv9j0N7QwQXmd6ibc1V/AGKUC1JkcC/Dod730=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwn/xjqGwQTFsgDua5MXR1/bEPE+7A4fs3oO5oga8kla9IoxTuH2R0SaBHNAh+ED5
         ButttMdR+1P4fVQEY0AKvCEo9HACSBLs3dCE5AK1ZNngcT+iS1kMpuDcu59eTWZXFA
         IkmyaPFhByXq3WUQAnblP7UVmiuih939SXnqMLB5yv0jIcg20ViqxS19AXwWG3ZUBP
         gFaDa1EdndIxTMLc+xvTZZu3nDcGWnd+YH2QEqFJqhg+BwhXSq6TtA110wvt35rzp5
         DcP2Bz5F9KhAdffAa3Rw5Pk10gJPRh47tqEqFMaUtHQfCOSBI8yWgaMovL0oZxpe1Y
         4mqqCS972v45g==
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
Subject: [PATCH 23/27] sparc: syscalls: switch to generic syscalltbl.sh
Date:   Thu, 28 Jan 2021 09:51:05 +0900
Message-Id: <20210128005110.2613902-24-masahiroy@kernel.org>
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

This commit converts sparc to use scripts/syscalltbl.sh. This also
unifies syscall_table_64.h and syscall_table_c32.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/include/asm/Kbuild            |  1 -
 arch/sparc/kernel/syscalls/Makefile      | 19 ++++---------
 arch/sparc/kernel/syscalls/syscalltbl.sh | 36 ------------------------
 arch/sparc/kernel/systbls_32.S           |  4 +--
 arch/sparc/kernel/systbls_64.S           |  8 ++++--
 5 files changed, 12 insertions(+), 56 deletions(-)
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index aec20406145e..0b9d98ced34a 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
-generated-y += syscall_table_c32.h
 generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
index 556fe30a6c8f..77fea5beb9be 100644
--- a/arch/sparc/kernel/syscalls/Makefile
+++ b/arch/sparc/kernel/syscalls/Makefile
@@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 
 syscall := $(srctree)/$(src)/syscall.tbl
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_offset_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
-		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@ $(abis)
 
 syshdr_abis_unistd_32 := common,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
@@ -29,23 +26,17 @@ syshdr_abis_unistd_64 := common,64
 $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-systbl_abis_syscall_table_32 := common,32
+$(kapi)/syscall_table_32.h: abis := common,32
 $(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_64 := common,64
+$(kapi)/syscall_table_64.h: abis := common,64
 $(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_c32 := common,32
-systbl_abi_syscall_table_c32 := c32
-$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,systbl)
-
 uapisyshdr-y		+= unistd_32.h unistd_64.h
 kapisyshdr-y		+= syscall_table_32.h		\
-			   syscall_table_64.h		\
-			   syscall_table_c32.h
+			   syscall_table_64.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
 kapisyshdr-y	:= $(addprefix $(kapi)/, $(kapisyshdr-y))
diff --git a/arch/sparc/kernel/syscalls/syscalltbl.sh b/arch/sparc/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 77cf0143ba19..000000000000
--- a/arch/sparc/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-my_abi="$4"
-offset="$5"
-
-emit() {
-	t_nxt="$1"
-	t_nr="$2"
-	t_entry="$3"
-
-	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_nis_syscall, )\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry compat ; do
-		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
-		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
-		fi
-		nxt=$((nr+1))
-	done
-) > "$out"
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index ab9e4d57685a..3aaffa017706 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -9,10 +9,10 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#define __SYSCALL(nr, entry) .long entry
 	.data
 	.align 4
 	.globl sys_call_table
 sys_call_table:
 #include <asm/syscall_table_32.h>	/* 32-bit native syscalls */
-#undef __SYSCALL
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index a27394bf7d7f..398fe449dd34 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -10,18 +10,20 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
-#define __SYSCALL(nr, entry, nargs) .word entry
+#define __SYSCALL(nr, entry) .word entry
 	.text
 	.align	4
 #ifdef CONFIG_COMPAT
 	.globl sys_call_table32
 sys_call_table32:
-#include <asm/syscall_table_c32.h>	/* Compat syscalls */
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#include <asm/syscall_table_32.h>	/* Compat syscalls */
+#undef __SYSCALL_WITH_COMPAT
 #endif /* CONFIG_COMPAT */
 
 	.align	4
 	.globl sys_call_table64, sys_call_table
 sys_call_table64:
 sys_call_table:
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 #include <asm/syscall_table_64.h>	/* 64-bit native syscalls */
-#undef __SYSCALL
-- 
2.27.0

