Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B456A691B
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjCAIv0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAIvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 03:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7C39BA3;
        Wed,  1 Mar 2023 00:51:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DDE3611B6;
        Wed,  1 Mar 2023 08:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE49C433D2;
        Wed,  1 Mar 2023 08:51:20 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Export some symbols without GPL
Date:   Wed,  1 Mar 2023 16:51:09 +0800
Message-Id: <20230301085109.2373524-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some symbols, i.e., vm_map_base, empty_zero_page and invalid_pmd_table,
could be accessed widely by some out-of-tree non-GPL but important file
systems or drivers (e.g., OpenZFS). Let's use EXPORT_SYMBOL() instead of
EXPORT_SYMBOL_GPL() to export them, so as to avoid build errors.

Details about vm_map_base: may be referenced through macros PCI_IOBASE,
VMALLOC_START and VMALLOC_END.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
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

