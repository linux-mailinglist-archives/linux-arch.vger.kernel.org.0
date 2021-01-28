Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A90306937
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhA1BAk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 20:00:40 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29736 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhA1A6I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:58:08 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIk024172;
        Thu, 28 Jan 2021 09:52:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIk024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795125;
        bh=4ZenFWWjMwiEnwQD+VnDQheVfxi1y/5KimgQE4NLnQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKtiHyjHsYe9u5ri0K9prFcwTl4Bu2c/ZztMNtcYtVPAQARxtyi4eBxNF1EAEn4Tj
         8B5t6MgqLiD3v9YEkZ8C+xCVVG2/9D7KvftmX9XZ696fogvkawfmp/oU43+NJeJuQ2
         b37yyIHcbTSFxO6RddsBhC5l3I8VmTxbFF/QjSD/MyCE5FR+/rSLec2ixwvptvbtUg
         tZl/DpRD7MkiwOA77aOsNkqjYGxyyhpGsCPv9myVExs2Tk4NLqLPWgHDgwUWw2UHnN
         QPxvVsN+Q0M9AK0hO66OjoKnSVvDP+l2GRRWPrfOOcFamvz44AwX0HLrpC1/IOfImK
         lDZlmx2kV35qA==
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
Subject: [PATCH 15/27] mips: add missing FORCE and fix 'targets' to make if_changed work
Date:   Thu, 28 Jan 2021 09:50:57 +0900
Message-Id: <20210128005110.2613902-16-masahiroy@kernel.org>
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

 arch/mips/kernel/syscalls/Makefile | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index 6efb2f6889a7..f15842bda464 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -31,50 +31,50 @@ quiet_cmd_systbl = SYSTBL  $@
 		   '$(systbl_offset_$(basetarget))'
 
 syshdr_offset_unistd_n32 := __NR_Linux
-$(uapi)/unistd_n32.h: $(syscalln32) $(syshdr)
+$(uapi)/unistd_n32.h: $(syscalln32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 syshdr_offset_unistd_n64 := __NR_Linux
-$(uapi)/unistd_n64.h: $(syscalln64) $(syshdr)
+$(uapi)/unistd_n64.h: $(syscalln64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 syshdr_offset_unistd_o32 := __NR_Linux
-$(uapi)/unistd_o32.h: $(syscallo32) $(syshdr)
+$(uapi)/unistd_o32.h: $(syscallo32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 sysnr_pfx_unistd_nr_n32 := N32
 sysnr_offset_unistd_nr_n32 := 6000
-$(uapi)/unistd_nr_n32.h: $(syscalln32) $(sysnr)
+$(uapi)/unistd_nr_n32.h: $(syscalln32) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
 sysnr_pfx_unistd_nr_n64 := 64
 sysnr_offset_unistd_nr_n64 := 5000
-$(uapi)/unistd_nr_n64.h: $(syscalln64) $(sysnr)
+$(uapi)/unistd_nr_n64.h: $(syscalln64) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
 sysnr_pfx_unistd_nr_o32 := O32
 sysnr_offset_unistd_nr_o32 := 4000
-$(uapi)/unistd_nr_o32.h: $(syscallo32) $(sysnr)
+$(uapi)/unistd_nr_o32.h: $(syscallo32) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
 systbl_abi_syscall_table_32_o32 := 32_o32
 systbl_offset_syscall_table_32_o32 := 4000
-$(kapi)/syscall_table_32_o32.h: $(syscallo32) $(systbl)
+$(kapi)/syscall_table_32_o32.h: $(syscallo32) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 systbl_abi_syscall_table_64_n32 := 64_n32
 systbl_offset_syscall_table_64_n32 := 6000
-$(kapi)/syscall_table_64_n32.h: $(syscalln32) $(systbl)
+$(kapi)/syscall_table_64_n32.h: $(syscalln32) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 systbl_abi_syscall_table_64_n64 := 64_n64
 systbl_offset_syscall_table_64_n64 := 5000
-$(kapi)/syscall_table_64_n64.h: $(syscalln64) $(systbl)
+$(kapi)/syscall_table_64_n64.h: $(syscalln64) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 systbl_abi_syscall_table_64_o32 := 64_o32
 systbl_offset_syscall_table_64_o32 := 4000
-$(kapi)/syscall_table_64_o32.h: $(syscallo32) $(systbl)
+$(kapi)/syscall_table_64_o32.h: $(syscallo32) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_n32.h			\
@@ -88,9 +88,10 @@ kapisyshdr-y		+= syscall_table_32_o32.h	\
 			   syscall_table_64_n64.h	\
 			   syscall_table_64_o32.h
 
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

