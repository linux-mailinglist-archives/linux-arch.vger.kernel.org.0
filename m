Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7E5EEB80
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 04:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiI2COE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiI2CNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 22:13:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2741231F0;
        Wed, 28 Sep 2022 19:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CC18B822C8;
        Thu, 29 Sep 2022 02:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38951C433D7;
        Thu, 29 Sep 2022 02:13:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Weihao Li <liweihao@loongson.cn>
Subject: [PATCH] LoongArch: Support access filter to /dev/mem interface
Date:   Thu, 29 Sep 2022 10:12:26 +0800
Message-Id: <20220929021226.318152-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
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

Accidental access to /dev/mem is obviously disastrous, but specific
access can be used by people debugging the kernel. So select GENERIC_
LIB_DEVMEM_IS_ALLOWED, as well as define ARCH_HAS_VALID_PHYS_ADDR_RANGE
and related helpers, to support access filter to /dev/mem interface.

Signed-off-by: Weihao Li <liweihao@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig          |  1 +
 arch/loongarch/include/asm/io.h |  4 ++++
 arch/loongarch/mm/mmap.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fcb5f9489ffd..9c36eb29096a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -70,6 +70,7 @@ config LOONGARCH
 	select GENERIC_LIB_CMPDI2
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 999944ea1cea..398d1a7b3dd6 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -107,4 +107,8 @@ extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t
 
 #include <asm-generic/io.h>
 
+#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
+extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
+extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
+
 #endif /* _ASM_IO_H */
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 381a569635a9..71d45bdffc9e 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/export.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 
@@ -116,3 +117,30 @@ int __virt_addr_valid(volatile void *kaddr)
 	return pfn_valid(PFN_DOWN(PHYSADDR(kaddr)));
 }
 EXPORT_SYMBOL_GPL(__virt_addr_valid);
+
+/*
+ * You really shouldn't be using read() or write() on /dev/mem.  This might go
+ * away in the future.
+ */
+int valid_phys_addr_range(phys_addr_t addr, size_t size)
+{
+	/*
+	 * Check whether addr is covered by a memory region without the
+	 * MEMBLOCK_NOMAP attribute, and whether that region covers the
+	 * entire range. In theory, this could lead to false negatives
+	 * if the range is covered by distinct but adjacent memory regions
+	 * that only differ in other attributes. However, few of such
+	 * attributes have been defined, and it is debatable whether it
+	 * follows that /dev/mem read() calls should be able traverse
+	 * such boundaries.
+	 */
+	return memblock_is_region_memory(addr, size) && memblock_is_map_memory(addr);
+}
+
+/*
+ * Do not allow /dev/mem mappings beyond the supported physical range.
+ */
+int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
+{
+	return !(((pfn << PAGE_SHIFT) + size) & ~(GENMASK_ULL(cpu_pabits, 0)));
+}
-- 
2.31.1

