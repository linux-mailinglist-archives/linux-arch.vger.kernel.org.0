Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8980430694E
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 02:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhA1BCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 20:02:02 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29724 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhA1A6E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:58:04 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIu024172;
        Thu, 28 Jan 2021 09:52:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIu024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795138;
        bh=qJV9Wmz9Vo5i4G5o2neAdG6CkLC6eGQHp1LpJ1geKao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSmvw1K7dt1btJVElhySHrvS8z/oxgJv8F2dz3+i/J7bhe95rmv0QYa4zVj8dzfg/
         9yjrYV8MGcoRyIoNb1gOFJUrfV9QfHKCWZKH+v2y/+ubwP6602Ujm9gZHgMsu1hZU9
         rgeXXaxUF9ckb22dhYS4e74619T7XX3YzMfs/ClgN7PNbOT1nkVuEmTUJMHb2joHGk
         K0fzVbgT1rRje75PIOyyVsziN0Yy/2wWUMIbhvh82t94yI5AN0Z6LGv/O46UeTKBge
         RuuPhDYgTnXndh7/jYOLbfNFX8uIcGA+jwacUGUunypKxS7Ca/1gFutDlvpMosg0bb
         WlUeI6RvaN2qw==
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
Subject: [PATCH 25/27] powerpc: syscalls: switch to generic syscalltbl.sh
Date:   Thu, 28 Jan 2021 09:51:07 +0900
Message-Id: <20210128005110.2613902-26-masahiroy@kernel.org>
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

This commit converts powerpc to use scripts/syscalltbl.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/include/asm/Kbuild             |  1 -
 arch/powerpc/kernel/syscalls/Makefile       | 22 +++----------
 arch/powerpc/kernel/syscalls/syscalltbl.sh  | 36 ---------------------
 arch/powerpc/kernel/systbl.S                |  5 ++-
 arch/powerpc/platforms/cell/spu_callbacks.c |  2 +-
 5 files changed, 10 insertions(+), 56 deletions(-)
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index e1f9b4ea1c53..bcf95ce0964f 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
-generated-y += syscall_table_c32.h
 generated-y += syscall_table_spu.h
 generic-y += export.h
 generic-y += kvm_types.h
diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index d609f0040b2a..ecf1474f8ea5 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
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
 
 syshdr_abis_unistd_32 := common,nospu,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
@@ -29,30 +26,21 @@ syshdr_abis_unistd_64 := common,nospu,64
 $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-systbl_abis_syscall_table_32 := common,nospu,32
-systbl_abi_syscall_table_32 := 32
+$(kapi)/syscall_table_32.h: abis := common,nospu,32
 $(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_64 := common,nospu,64
-systbl_abi_syscall_table_64 := 64
+$(kapi)/syscall_table_64.h: abis := common,nospu,64
 $(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_c32 := common,nospu,32
-systbl_abi_syscall_table_c32 := c32
-$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,systbl)
-
-systbl_abis_syscall_table_spu := common,spu
-systbl_abi_syscall_table_spu := spu
+$(kapi)/syscall_table_spu.h: abis := common,spu
 $(kapi)/syscall_table_spu.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h unistd_64.h
 kapisyshdr-y		+= syscall_table_32.h		\
 			   syscall_table_64.h		\
-			   syscall_table_c32.h		\
 			   syscall_table_spu.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index f7393a7b18aa..000000000000
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
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
-		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
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
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index d34276f3c495..cb3358886203 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -21,6 +21,7 @@
 #define __SYSCALL(nr, entry)	.long entry
 #endif
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 .globl sys_call_table
 sys_call_table:
 #ifdef CONFIG_PPC64
@@ -30,8 +31,10 @@ sys_call_table:
 #endif
 
 #ifdef CONFIG_COMPAT
+#undef __SYSCALL_WITH_COMPAT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
 .globl compat_sys_call_table
 compat_sys_call_table:
 #define compat_sys_sigsuspend	sys_sigsuspend
-#include <asm/syscall_table_c32.h>
+#include <asm/syscall_table_32.h>
 #endif
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index abdef9bcf432..fe0d8797a00a 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -35,9 +35,9 @@
  */
 
 static void *spu_syscall_table[] = {
+#define __SYSCALL_WITH_COMPAT(nr, entry, compat) __SYSCALL(nr, entry)
 #define __SYSCALL(nr, entry) [nr] = entry,
 #include <asm/syscall_table_spu.h>
-#undef __SYSCALL
 };
 
 long spu_sys_callback(struct spu_syscall_block *s)
-- 
2.27.0

