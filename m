Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A569B6A6C5D
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCAMaw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 07:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCAMaw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 07:30:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A839B98;
        Wed,  1 Mar 2023 04:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EF74B81023;
        Wed,  1 Mar 2023 12:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EA4C433EF;
        Wed,  1 Mar 2023 12:30:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH V2] LoongArch: Mark 3 symbol exports as non-GPL
Date:   Wed,  1 Mar 2023 20:30:32 +0800
Message-Id: <20230301123032.2452817-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

vm_map_base, empty_zero_page and invalid_pmd_table could be accessed
widely by some out-of-tree non-GPL but important file systems or drivers
(e.g. OpenZFS). Let's use EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL()
to export them, so as to avoid build errors.

1, Details about vm_map_base:

This is a LoongArch-specific symbol and may be referenced through macros
PCI_IOBASE, VMALLOC_START and VMALLOC_END.

2, Details about empty_zero_page:

As it stands today, only 3 architectures export empty_zero_page as a GPL 
symbol: IA64, LoongArch and MIPS. LoongArch gets the GPL export by 
inheriting from MIPS, and the MIPS export was first introduced in commit 
497d2adcbf50b ("[MIPS] Export empty_zero_page for sake of the ext4 
module."). The IA64 export was similar: commit a7d57ecf4216e ("[IA64] 
Export three symbols for module use") did so for kvm.

In both IA64 and MIPS, the export of empty_zero_page was done for 
satisfying some in-kernel component built as module (kvm and ext4 
respectively), and given its reasonably low-level nature, GPL is a 
reasonable choice. But looking at the bigger picture it is evident most 
other architectures do not regard it as GPL, so in effect the symbol 
probably should not be treated as such, in favor of consistency.

3, Details about invalid_pmd_table:

Keep consistency with invalid_pte_table and make it be possible by some
modules.

Reviewed-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update commit messages.

 arch/loongarch/kernel/cpu-probe.c | 2 +-
 arch/loongarch/mm/init.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 008b0249905f..001e43dd94ca 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -60,7 +60,7 @@ static inline void set_elf_platform(int cpu, const char *plat)
 
 /* MAP BASE */
 unsigned long vm_map_base;
-EXPORT_SYMBOL_GPL(vm_map_base);
+EXPORT_SYMBOL(vm_map_base);
 
 static void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
 {
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index e018aed34586..3b7d8129570b 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -41,7 +41,7 @@
  * don't have to care about aliases on other CPUs.
  */
 unsigned long empty_zero_page, zero_page_mask;
-EXPORT_SYMBOL_GPL(empty_zero_page);
+EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
 void setup_zero_pages(void)
@@ -270,7 +270,7 @@ pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
-EXPORT_SYMBOL_GPL(invalid_pmd_table);
+EXPORT_SYMBOL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
-- 
2.39.1

