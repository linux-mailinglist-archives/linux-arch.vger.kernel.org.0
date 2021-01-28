Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB743306931
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 02:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhA1BAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 20:00:32 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29740 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhA1A6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:58:10 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIl024172;
        Thu, 28 Jan 2021 09:52:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIl024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795127;
        bh=mFt0p+z8EW+dT9qV8axQed/XiMVfL+Ih2Q3EFxha4pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whY5ouWcabgT0DRuYEmHgaTDjyR45j2QGgl6+9/D8UinPwm3JUi+rW557NM+7/aD6
         +Br74WkoYkuWhyN1pA0Fbc3YR4IFO4XdZoozuVJbSavIjebfrhjHaNA/orZqWxh/fp
         vJtw5zXNoPVFsY4sVXaDPxjddbQgPgqtqOCklYzCuSvUmH7ZQ8FNqOWOgg4FkVaCDv
         2n7lLj5KIDKyqVTRDiVR7DBM5cCG1vicaCTwYtTBDneKU3Phg0X33SVyqPs8dC2JQA
         l6HdguSfwfHyXYl15cKLOXbWbk0MM8NZQZzaNpSr3I/5qXzf0GTULdLrMeBYypNAy8
         +GbnGLx/uNnYQ==
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
Subject: [PATCH 16/27] mips: syscalls: switch to generic syscalltbl.sh
Date:   Thu, 28 Jan 2021 09:50:58 +0900
Message-Id: <20210128005110.2613902-17-masahiroy@kernel.org>
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

This commit converts mips to use scripts/syscalltbl.sh. This also
unifies syscall_table_32_o32.h and syscall_table_64_o32.h into
syscall_table_o32.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/include/asm/Kbuild            |  7 +++--
 arch/mips/kernel/scall32-o32.S          |  4 +--
 arch/mips/kernel/scall64-n32.S          |  3 +--
 arch/mips/kernel/scall64-n64.S          |  3 +--
 arch/mips/kernel/scall64-o32.S          |  4 +--
 arch/mips/kernel/syscalls/Makefile      | 34 ++++++++---------------
 arch/mips/kernel/syscalls/syscalltbl.sh | 36 -------------------------
 7 files changed, 20 insertions(+), 71 deletions(-)
 delete mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 95b4fa7bd0d1..70b15857369d 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # MIPS headers
-generated-y += syscall_table_32_o32.h
-generated-y += syscall_table_64_n32.h
-generated-y += syscall_table_64_n64.h
-generated-y += syscall_table_64_o32.h
+generated-y += syscall_table_n32.h
+generated-y += syscall_table_n64.h
+generated-y += syscall_table_o32.h
 generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index b449b68662a9..84e8624e83a2 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -217,9 +217,9 @@ einval: li	v0, -ENOSYS
 #define sys_sched_getaffinity	mipsmt_sys_sched_getaffinity
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 #define __SYSCALL(nr, entry) 	PTR entry
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
-#include <asm/syscall_table_32_o32.h>
-#undef __SYSCALL
+#include <asm/syscall_table_o32.h>
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 35d8c86b160e..f650c55a17dc 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -104,5 +104,4 @@ not_n32_scall:
 #define __SYSCALL(nr, entry)	PTR entry
 	.type	sysn32_call_table, @object
 EXPORT(sysn32_call_table)
-#include <asm/syscall_table_64_n32.h>
-#undef __SYSCALL
+#include <asm/syscall_table_n32.h>
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 23b2e2b1609c..c71c13f9fcbc 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -113,5 +113,4 @@ illegal_syscall:
 	.align	3
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
-#include <asm/syscall_table_64_n64.h>
-#undef __SYSCALL
+#include <asm/syscall_table_n64.h>
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 50c9a57e0d3a..cedc8bd88804 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -213,9 +213,9 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys32_syscall)
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
 #define __SYSCALL(nr, entry)	PTR entry
 	.align	3
 	.type	sys32_call_table,@object
 EXPORT(sys32_call_table)
-#include <asm/syscall_table_64_o32.h>
-#undef __SYSCALL
+#include <asm/syscall_table_o32.h>
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index f15842bda464..265dab4253ab 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -10,7 +10,7 @@ syscalln64 := $(srctree)/$(src)/syscall_n64.tbl
 syscallo32 := $(srctree)/$(src)/syscall_o32.tbl
 syshdr := $(srctree)/$(src)/syscallhdr.sh
 sysnr := $(srctree)/$(src)/syscallnr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -25,10 +25,7 @@ quiet_cmd_sysnr = SYSNR   $@
 		  '$(sysnr_offset_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
-		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@ "" $(offset)
 
 syshdr_offset_unistd_n32 := __NR_Linux
 $(uapi)/unistd_n32.h: $(syscalln32) $(syshdr) FORCE
@@ -57,24 +54,16 @@ sysnr_offset_unistd_nr_o32 := 4000
 $(uapi)/unistd_nr_o32.h: $(syscallo32) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-systbl_abi_syscall_table_32_o32 := 32_o32
-systbl_offset_syscall_table_32_o32 := 4000
-$(kapi)/syscall_table_32_o32.h: $(syscallo32) $(systbl) FORCE
+$(kapi)/syscall_table_n32.h: offset := 6000
+$(kapi)/syscall_table_n32.h: $(syscalln32) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abi_syscall_table_64_n32 := 64_n32
-systbl_offset_syscall_table_64_n32 := 6000
-$(kapi)/syscall_table_64_n32.h: $(syscalln32) $(systbl) FORCE
+$(kapi)/syscall_table_n64.h: offset := 5000
+$(kapi)/syscall_table_n64.h: $(syscalln64) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abi_syscall_table_64_n64 := 64_n64
-systbl_offset_syscall_table_64_n64 := 5000
-$(kapi)/syscall_table_64_n64.h: $(syscalln64) $(systbl) FORCE
-	$(call if_changed,systbl)
-
-systbl_abi_syscall_table_64_o32 := 64_o32
-systbl_offset_syscall_table_64_o32 := 4000
-$(kapi)/syscall_table_64_o32.h: $(syscallo32) $(systbl) FORCE
+$(kapi)/syscall_table_o32.h: offset := 4000
+$(kapi)/syscall_table_o32.h: $(syscallo32) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_n32.h			\
@@ -83,10 +72,9 @@ uapisyshdr-y		+= unistd_n32.h			\
 			   unistd_nr_n32.h		\
 			   unistd_nr_n64.h		\
 			   unistd_nr_o32.h
-kapisyshdr-y		+= syscall_table_32_o32.h	\
-			   syscall_table_64_n32.h	\
-			   syscall_table_64_n64.h	\
-			   syscall_table_64_o32.h
+kapisyshdr-y		+= syscall_table_n32.h		\
+			   syscall_table_n64.h		\
+			   syscall_table_o32.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
 kapisyshdr-y	:= $(addprefix $(kapi)/, $(kapisyshdr-y))
diff --git a/arch/mips/kernel/syscalls/syscalltbl.sh b/arch/mips/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 1e2570740c20..000000000000
--- a/arch/mips/kernel/syscalls/syscalltbl.sh
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
-		if [ "$my_abi" = "64_o32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
-		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
-		fi
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
2.27.0

