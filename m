Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6213306976
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhA1BHb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 20:07:31 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29054 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhA1A4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:56:39 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIn024172;
        Thu, 28 Jan 2021 09:52:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIn024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795129;
        bh=auDYMtfQRatUyx1FfAGRVS/QREy59NpDWkhykhL36rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udcM4bOLBJAMbKMrr5JXrO26aR5LC0c8THByBm+aM0I5LEm9ynkcoxbPSoCAyI89L
         UxT9f3oRi263fLwnUCUL/PB4ejBqB0Gpr7QKIKb0c1Rl3XodCCv/QKBKoQUCK6mkfR
         7NlRwEDcnZuLc1CPYqIjusbU09YQBETP1YndCccFm7T7mD5vSelRMoGad0isz+egmV
         sQ4Kc//6jzNZjjPYKAhcfzXj9d9vK+/ZevUevxBeWVJ0APrujY3q7hliD7dkbYT8tE
         tzh/Zjeo0/YR/m4BnncO14PhAJP5zhxSIlftLmDV+rT9YY8slKkZPX/HCdKW2QflYv
         kHLMoOFjHO1qg==
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
Subject: [PATCH 18/27] parisc: syscalls: switch to generic syscalltbl.sh
Date:   Thu, 28 Jan 2021 09:51:00 +0900
Message-Id: <20210128005110.2613902-19-masahiroy@kernel.org>
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

This commit converts parisc to use scripts/syscalltbl.sh. This also
unifies syscall_table_64.h and syscall_table_c32.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/include/asm/Kbuild            |  1 -
 arch/parisc/kernel/syscall.S              | 16 +++++-----
 arch/parisc/kernel/syscalls/Makefile      | 19 ++++--------
 arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -----------------------
 4 files changed, 12 insertions(+), 60 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 4406475a2304..e6e7f74c8ac9 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
-generated-y += syscall_table_c32.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += user.h
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 322503780db6..3f24a0af1e04 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -919,24 +919,24 @@ ENTRY(lws_table)
 END(lws_table)
 	/* End of lws table */
 
+#ifdef CONFIG_64BIT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#else
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#endif
 #define __SYSCALL(nr, entry)	ASM_ULONG_INSN entry
 	.align 8
 ENTRY(sys_call_table)
 	.export sys_call_table,data
-#ifdef CONFIG_64BIT
-#include <asm/syscall_table_c32.h>   /* Compat syscalls */
-#else
-#include <asm/syscall_table_32.h>    /* 32-bit native syscalls */
-#endif
+#include <asm/syscall_table_32.h>    /* 32-bit syscalls */
 END(sys_call_table)
 
 #ifdef CONFIG_64BIT
 	.align 8
 ENTRY(sys_call_table64)
-#include <asm/syscall_table_64.h>    /* 64-bit native syscalls */
+#include <asm/syscall_table_64.h>    /* 64-bit syscalls */
 END(sys_call_table64)
 #endif
-#undef __SYSCALL
 
 	/*
 		All light-weight-syscall atomic operations 
@@ -961,5 +961,3 @@ END(lws_lock_start)
 	.previous
 
 .end
-
-
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index 556fe30a6c8f..77fea5beb9be 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
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
diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index f7393a7b18aa..000000000000
--- a/arch/parisc/kernel/syscalls/syscalltbl.sh
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
-- 
2.27.0

