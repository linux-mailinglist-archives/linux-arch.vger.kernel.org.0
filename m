Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8197715C3
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjHFPKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjHFPKI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA4E49;
        Sun,  6 Aug 2023 08:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205CA61191;
        Sun,  6 Aug 2023 15:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD511C433C7;
        Sun,  6 Aug 2023 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691334605;
        bh=MphpIhD3thEdHZ/rHZRWdlhY2fLCRpb5BviGtAQTVrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSt2zt1zDpq9nQjvrVAKamZrlO4ccN/pr08P2+H66sWYoAigzXj791hNw4nl5oXto
         sJoQjnJQ4YorNLDqz+/67iRCsUYT8Q8tSEnz5gj0tr69Jyoy+vHE6ujeNbUGuu69Zz
         1OaztbIrHZQONY9j4ebpPSnMip1yO2bJ2jVbzC08y6A+uFJFCR+F5sjEn+5/aYbtVk
         E34LHqrPu8867MWH9qQVPDo42nPjZozngFkJI6q4+OvDyy+OEDuqABQoM5huBPswtR
         AsjaSIaW6jhhLpOM87AOsos2Xgmnu7PO1zJ6NORm5FbKK2oU8o8zSoTLmI9cxfYuFF
         oz9j4rzvL6mAA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] powerpc: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Mon,  7 Aug 2023 00:09:53 +0900
Message-Id: <20230806150954.394189-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806150954.394189-1-masahiroy@kernel.org>
References: <20230806150954.394189-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.

Replace #include <asm/export.h> with #include <linux/export.h>.

After all the <asm/export.h> lines are converted, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/epapr_hcalls.S      | 2 +-
 arch/powerpc/kernel/fpu.S               | 2 +-
 arch/powerpc/kernel/misc.S              | 2 +-
 arch/powerpc/kernel/misc_32.S           | 2 +-
 arch/powerpc/kernel/misc_64.S           | 2 +-
 arch/powerpc/kernel/tm.S                | 2 +-
 arch/powerpc/kernel/trace/ftrace_low.S  | 2 +-
 arch/powerpc/kernel/ucall.S             | 2 +-
 arch/powerpc/kernel/vector.S            | 2 +-
 arch/powerpc/kvm/book3s_64_entry.S      | 2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 +-
 arch/powerpc/kvm/tm.S                   | 2 +-
 arch/powerpc/lib/checksum_32.S          | 2 +-
 arch/powerpc/lib/checksum_64.S          | 2 +-
 arch/powerpc/lib/copy_32.S              | 2 +-
 arch/powerpc/lib/copy_mc_64.S           | 2 +-
 arch/powerpc/lib/copypage_64.S          | 2 +-
 arch/powerpc/lib/copyuser_64.S          | 2 +-
 arch/powerpc/lib/hweight_64.S           | 2 +-
 arch/powerpc/lib/mem_64.S               | 2 +-
 arch/powerpc/lib/memcmp_32.S            | 2 +-
 arch/powerpc/lib/memcmp_64.S            | 2 +-
 arch/powerpc/lib/memcpy_64.S            | 2 +-
 arch/powerpc/lib/string.S               | 2 +-
 arch/powerpc/lib/string_32.S            | 2 +-
 arch/powerpc/lib/string_64.S            | 2 +-
 arch/powerpc/lib/strlen_32.S            | 2 +-
 arch/powerpc/mm/book3s32/hash_low.S     | 2 +-
 arch/powerpc/sysdev/dcr-low.S           | 2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 033116e465d0..1a9b5ae8ccb2 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  */
 
+#include <linux/export.h>
 #include <linux/threads.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/reg.h>
@@ -12,7 +13,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 
 #ifndef CONFIG_PPC64
 /* epapr_ev_idle() was derived from e500_idle() */
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index f71f2bbd4de6..6a9acfb690c9 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -9,6 +9,7 @@
  *    Copyright (C) 1997 Dan Malek (dmalek@jlc.net).
  */
 
+#include <linux/export.h>
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -18,7 +19,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
-#include <asm/export.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index fb7de3543c03..29e1440d14cc 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -10,11 +10,11 @@
  *
  * setjmp/longjmp code by Paul Mackerras.
  */
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
 #include <asm/unistd.h>
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 
 	.text
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index daf8f87d2372..2eabb15687a6 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/export.h>
 #include <linux/sys.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
@@ -22,7 +23,6 @@
 #include <asm/processor.h>
 #include <asm/bug.h>
 #include <asm/ptrace.h>
-#include <asm/export.h>
 #include <asm/feature-fixups.h>
 
 	.text
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 2c9ac70aaf0c..1a8cdafd68e8 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -9,6 +9,7 @@
  * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <asm/unistd.h>
@@ -23,7 +24,6 @@
 #include <asm/kexec.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
-#include <asm/export.h>
 #include <asm/feature-fixups.h>
 
 	.text
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 9feab5e0485b..a9cd6507163a 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -6,13 +6,13 @@
  * Copyright 2012 Matt Evans & Michael Neuling, IBM Corporation.
  */
 
+#include <linux/export.h>
 #include <asm/asm-offsets.h>
 #include <asm/ppc_asm.h>
 #include <asm/ppc-opcode.h>
 #include <asm/ptrace.h>
 #include <asm/reg.h>
 #include <asm/bug.h>
-#include <asm/export.h>
 #include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
diff --git a/arch/powerpc/kernel/trace/ftrace_low.S b/arch/powerpc/kernel/trace/ftrace_low.S
index 294d1e05958a..5e271f87f799 100644
--- a/arch/powerpc/kernel/trace/ftrace_low.S
+++ b/arch/powerpc/kernel/trace/ftrace_low.S
@@ -3,12 +3,12 @@
  * Split from entry_64.S
  */
 
+#include <linux/export.h>
 #include <linux/magic.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
 #include <asm/ppc-opcode.h>
-#include <asm/export.h>
 
 #ifdef CONFIG_PPC64
 .pushsection ".tramp.ftrace.text","aw",@progbits;
diff --git a/arch/powerpc/kernel/ucall.S b/arch/powerpc/kernel/ucall.S
index 07296bc39166..80a1f9a4300a 100644
--- a/arch/powerpc/kernel/ucall.S
+++ b/arch/powerpc/kernel/ucall.S
@@ -5,8 +5,8 @@
  * Copyright 2019, IBM Corporation.
  *
  */
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 
 _GLOBAL(ucall_norets)
 EXPORT_SYMBOL_GPL(ucall_norets)
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index fcc0ad6d9c7b..4094e4c4c77a 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
@@ -8,7 +9,6 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
-#include <asm/export.h>
 #include <asm/asm-compat.h>
 
 /*
diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
index 6c2b1d17cb63..3b361af87313 100644
--- a/arch/powerpc/kvm/book3s_64_entry.S
+++ b/arch/powerpc/kvm/book3s_64_entry.S
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/export.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/code-patching-asm.h>
 #include <asm/exception-64s.h>
-#include <asm/export.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_book3s_asm.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 870110e3d9b1..ea7ad200b330 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -10,6 +10,7 @@
  * Authors: Alexander Graf <agraf@suse.de>
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/objtool.h>
 #include <asm/ppc_asm.h>
@@ -24,7 +25,6 @@
 #include <asm/exception-64s.h>
 #include <asm/kvm_book3s_asm.h>
 #include <asm/book3s/64/mmu-hash.h>
-#include <asm/export.h>
 #include <asm/tm.h>
 #include <asm/opal.h>
 #include <asm/thread_info.h>
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index 2158f61e317f..b506c4d9a8d9 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -6,10 +6,10 @@
  * Copyright 2011 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  */
 
+#include <linux/export.h>
 #include <asm/reg.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/tm.h>
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 4541e8e29467..cd00b9bdd772 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -8,12 +8,12 @@
  * Severely hacked about by Paul Mackerras (paulus@cs.anu.edu.au).
  */
 
+#include <linux/export.h>
 #include <linux/sys.h>
 #include <asm/processor.h>
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 
 	.text
 
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 98ff51bd2f7d..d53d8f09a2c2 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -8,11 +8,11 @@
  * Severely hacked about by Paul Mackerras (paulus@cs.anu.edu.au).
  */
 
+#include <linux/export.h>
 #include <linux/sys.h>
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 
 /*
  * Computes the checksum of a memory block at buff, length len,
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 3e9c27c46331..933b685e7ab6 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -4,11 +4,11 @@
  *
  * Copyright (C) 1996-2005 Paul Mackerras.
  */
+#include <linux/export.h>
 #include <asm/processor.h>
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/code-patching-asm.h>
 #include <asm/kasan.h>
 
diff --git a/arch/powerpc/lib/copy_mc_64.S b/arch/powerpc/lib/copy_mc_64.S
index 88d46c471493..bf1014b28fe8 100644
--- a/arch/powerpc/lib/copy_mc_64.S
+++ b/arch/powerpc/lib/copy_mc_64.S
@@ -4,9 +4,9 @@
  * Derived from copyuser_power7.s by Anton Blanchard <anton@au.ibm.com>
  * Author - Balbir Singh <bsingharora@gmail.com>
  */
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
 #include <asm/errno.h>
-#include <asm/export.h>
 
 	.macro err1
 100:
diff --git a/arch/powerpc/lib/copypage_64.S b/arch/powerpc/lib/copypage_64.S
index 5d09a029b556..f33a2e6088e5 100644
--- a/arch/powerpc/lib/copypage_64.S
+++ b/arch/powerpc/lib/copypage_64.S
@@ -2,11 +2,11 @@
 /*
  * Copyright (C) 2008 Mark Nelson, IBM Corp.
  */
+#include <linux/export.h>
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/feature-fixups.h>
 
 _GLOBAL_TOC(copy_page)
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index db8719a14846..9af969d2cc0c 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -2,9 +2,9 @@
 /*
  * Copyright (C) 2002 Paul Mackerras, IBM Corp.
  */
+#include <linux/export.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 
diff --git a/arch/powerpc/lib/hweight_64.S b/arch/powerpc/lib/hweight_64.S
index 09af29561314..151875050da9 100644
--- a/arch/powerpc/lib/hweight_64.S
+++ b/arch/powerpc/lib/hweight_64.S
@@ -5,9 +5,9 @@
  *
  * Author: Anton Blanchard <anton@au.ibm.com>
  */
+#include <linux/export.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/feature-fixups.h>
 
 /* Note: This code relies on -mminimal-toc */
diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index 9351ffab409c..6fd06cd20faa 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -4,10 +4,10 @@
  *
  * Copyright (C) 1996 Paul Mackerras.
  */
+#include <linux/export.h>
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/kasan.h>
 
 #ifndef CONFIG_KASAN
diff --git a/arch/powerpc/lib/memcmp_32.S b/arch/powerpc/lib/memcmp_32.S
index 5010e376f7b8..f6fca5664e91 100644
--- a/arch/powerpc/lib/memcmp_32.S
+++ b/arch/powerpc/lib/memcmp_32.S
@@ -7,8 +7,8 @@
  *
  */
 
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 
 	.text
 
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 0b9b1685a33d..142c666d3897 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -3,8 +3,8 @@
  * Author: Anton Blanchard <anton@au.ibm.com>
  * Copyright 2015 IBM Corporation.
  */
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/ppc-opcode.h>
 
 #define off8	r6
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 016c91e958d8..b5a67e20143f 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -2,9 +2,9 @@
 /*
  * Copyright (C) 2002 Paul Mackerras, IBM Corp.
  */
+#include <linux/export.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 #include <asm/kasan.h>
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 2752b1cc1d45..daa72061dc0c 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -4,8 +4,8 @@
  *
  * Copyright (C) 1996 Paul Mackerras.
  */
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/cache.h>
 
 	.text
diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 1ddb26394e8a..3ee45619a3f8 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -7,8 +7,8 @@
  *
  */
 
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/cache.h>
 
 	.text
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index df41ce06f86b..a25eb8588434 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -6,10 +6,10 @@
  * Author: Anton Blanchard <anton@au.ibm.com>
  */
 
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 
 /**
  * __arch_clear_user: - Zero a block of memory in user space, with less checking.
diff --git a/arch/powerpc/lib/strlen_32.S b/arch/powerpc/lib/strlen_32.S
index 0a8d3f64d493..bbd24feb233f 100644
--- a/arch/powerpc/lib/strlen_32.S
+++ b/arch/powerpc/lib/strlen_32.S
@@ -6,8 +6,8 @@
  *
  * Inspired from glibc implementation
  */
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
-#include <asm/export.h>
 #include <asm/cache.h>
 
 	.text
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index a5a21d444e72..8b804e1a9fa4 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -14,6 +14,7 @@
  *  hash table, so this file is not used on them.)
  */
 
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <linux/init.h>
 #include <asm/reg.h>
@@ -22,7 +23,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/feature-fixups.h>
 #include <asm/code-patching-asm.h>
 
diff --git a/arch/powerpc/sysdev/dcr-low.S b/arch/powerpc/sysdev/dcr-low.S
index 329b9c4ae542..e8401b205d38 100644
--- a/arch/powerpc/sysdev/dcr-low.S
+++ b/arch/powerpc/sysdev/dcr-low.S
@@ -5,10 +5,10 @@
  * Copyright (c) 2004 Eugene Surovegin <ebs@ebshome.net>
  */
 
+#include <linux/export.h>
 #include <asm/ppc_asm.h>
 #include <asm/processor.h>
 #include <asm/bug.h>
-#include <asm/export.h>
 
 #define DCR_ACCESS_PROLOG(table) \
 	cmplwi	cr0,r3,1024;	 \
-- 
2.39.2

