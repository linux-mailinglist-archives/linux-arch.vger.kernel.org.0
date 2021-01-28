Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A830692E
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 02:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhA1A7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 19:59:37 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29687 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhA1A5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:57:36 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIt024172;
        Thu, 28 Jan 2021 09:52:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIt024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795137;
        bh=JsW4AefmFWLB04cbPHKLRf+ySMBFBV/y4dlQQ7Rprvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbF1zyKjEAe3Uti7KpSL8Gn7aVPgeWns1ZJGE4PlTDtsdWHjr/VjE1Oy7QuCIKGD/
         YzbESvGNKZD4sx9HFruTcPGvOC//DQTyhQqf8UqEsLr0TBlOk/dTWmUNCQlWFuvCId
         DmcqOK1t5gGkyaUkApkrYdMjeFPdqGlIgzwyVMhooYzvWlWaQAWMVYZ4+BZ7JNcWxs
         p0QQzfm39TLqIn+0Df5YapK1PvmcZ/EzauWiWCgNeNWhQNqx9UKtp3RL9TXusIDIMI
         pT5mgVa4PqoDR2zrQYyZPcu/tV7rJxi85BtZvBruZynX6Dx128V7Or3vhQyxYgcUUM
         SgitQ8r7u9bQw==
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
Subject: [PATCH 24/27] powerpc: add missing FORCE and fix 'targets' to make if_changed work
Date:   Thu, 28 Jan 2021 09:51:06 +0900
Message-Id: <20210128005110.2613902-25-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128005110.2613902-1-masahiroy@kernel.org>
References: <20210128005110.2613902-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The rules in this Makefile cannot detect the command line change because
the prerequisite 'FORCE' is missing.

Adding 'FORCE' will result in the headers being rebuilt every time
because the 'targets' addition is also wrong; the file paths in
'targets' must be relative to the current Makefile.

Fix all of them so the if_changed rules work correctly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/syscalls/Makefile | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index 27b48954808d..d609f0040b2a 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
@@ -22,31 +22,31 @@ quiet_cmd_systbl = SYSTBL  $@
 		   '$(systbl_offset_$(basetarget))'
 
 syshdr_abis_unistd_32 := common,nospu,32
-$(uapi)/unistd_32.h: $(syscall) $(syshdr)
+$(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 syshdr_abis_unistd_64 := common,nospu,64
-$(uapi)/unistd_64.h: $(syscall) $(syshdr)
+$(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 systbl_abis_syscall_table_32 := common,nospu,32
 systbl_abi_syscall_table_32 := 32
-$(kapi)/syscall_table_32.h: $(syscall) $(systbl)
+$(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 systbl_abis_syscall_table_64 := common,nospu,64
 systbl_abi_syscall_table_64 := 64
-$(kapi)/syscall_table_64.h: $(syscall) $(systbl)
+$(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 systbl_abis_syscall_table_c32 := common,nospu,32
 systbl_abi_syscall_table_c32 := c32
-$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
+$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 systbl_abis_syscall_table_spu := common,spu
 systbl_abi_syscall_table_spu := spu
-$(kapi)/syscall_table_spu.h: $(syscall) $(systbl)
+$(kapi)/syscall_table_spu.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h unistd_64.h
@@ -55,9 +55,10 @@ kapisyshdr-y		+= syscall_table_32.h		\
 			   syscall_table_c32.h		\
 			   syscall_table_spu.h
 
-targets	+= $(uapisyshdr-y) $(kapisyshdr-y)
+uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
+kapisyshdr-y	:= $(addprefix $(kapi)/, $(kapisyshdr-y))
+targets		+= $(addprefix ../../../../, $(uapisyshdr-y) $(kapisyshdr-y))
 
 PHONY += all
-all: $(addprefix $(uapi)/,$(uapisyshdr-y))
-all: $(addprefix $(kapi)/,$(kapisyshdr-y))
+all: $(uapisyshdr-y) $(kapisyshdr-y)
 	@:
-- 
2.27.0

