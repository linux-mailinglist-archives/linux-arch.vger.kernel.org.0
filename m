Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61D5ABC22
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 03:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiICBms (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 21:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiICBmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 21:42:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7A883D6;
        Fri,  2 Sep 2022 18:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E22F8B82D27;
        Sat,  3 Sep 2022 01:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2598AC433D6;
        Sat,  3 Sep 2022 01:42:40 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix section mismatch due to acpi_os_ioremap()
Date:   Sat,  3 Sep 2022 09:42:07 +0800
Message-Id: <20220903014207.2312965-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now acpi_os_ioremap() is marked with __init because it calls memblock_
is_memory() which is also marked with __init in the !ARCH_KEEP_MEMBLOCK
case. However, acpi_os_ioremap() is called by ordinary functions such
as acpi_os_{read, write}_memory() and causes section mismatch warnings:

WARNING: modpost: vmlinux.o: section mismatch in reference: acpi_os_read_memory (section: .text) -> acpi_os_ioremap (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: acpi_os_write_memory (section: .text) -> acpi_os_ioremap (section: .init.text)

Fix these warnings by selecting ARCH_KEEP_MEMBLOCK unconditionally and
removing the __init modifier of acpi_os_ioremap(). This can also give a
chance to track "memory" and "reserved" memblocks after early boot.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig            | 1 +
 arch/loongarch/include/asm/acpi.h | 2 +-
 arch/loongarch/kernel/acpi.c      | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3bc5b911ae1a..c7dd6ad779af 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -39,6 +39,7 @@ config LOONGARCH
 	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_SPARSEMEM_ENABLE
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index c5108213876c..17162f494b9b 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -15,7 +15,7 @@ extern int acpi_pci_disabled;
 extern int acpi_noirq;
 
 #define acpi_os_ioremap acpi_os_ioremap
-void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 
 static inline void disable_acpi(void)
 {
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index f1c928648a4a..335398482038 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -48,7 +48,7 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	early_memunmap(map, size);
 }
 
-void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 {
 	if (!memblock_is_memory(phys))
 		return ioremap(phys, size);
-- 
2.31.1

