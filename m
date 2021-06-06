Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3539CE4A
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFFJH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbhFFJHU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5DFC61445;
        Sun,  6 Jun 2021 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970330;
        bh=ImFn70PLgXUHSxXz/kYrTQSzz2TKvLSmtoIrB/isbsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTU1FSyzc5fcybOhyi+u8t+br3DWkuLwmupadD/Yomq3S6+lWcUikjVV54ATWVgn+
         redgdfL7kRxmeHtrDf3J/PkBf+SqRJU9OUPkBFZ88JpuSsmzZqBnEC5vtCwbVmdLOT
         RMzGI8bHicLzQIoIa94hBcAaXqONFnEQyBNccAc3ANs3YUdXsL7H8goFtTvcOKSzri
         9390z8bnrXbtNFVMGsY109+L44AgY15cyXeVXb7i/a/J3EgrsNWSUyAzEbFb4N9ulU
         dahA1uihDqbh3Fowr4I81ebUEkwGMDwh6moZDYEx50U+1RCA07yU1HaPBt1/P23bsu
         zjul+x/c5bT9A==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH v2 06/11] riscv: pgtable: Add DMA_COHERENT with custom PTE attributes
Date:   Sun,  6 Jun 2021 09:04:04 +0000
Message-Id: <1622970249-50770-10-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The dma-noncoherent SOCs need different virtual memory mappings
with different attributes:
 - noncached + Strong Order (for IO/DMA descriptor)
 - noncached + Weak Order (for writecombine usage, eg: frame
   buffer)

All above base on PTE attributes by MMU hardware. That means
address attributes are determined by PTE entry, not PMA. RISC-V
soc vendors have defined their own custom PTE attributes for
dma-noncoherency.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime@cerno.tech>
---
 arch/riscv/include/asm/pgtable-bits.h  | 20 +++++++++++++++++++-
 arch/riscv/include/asm/pgtable.h       | 11 ++++-------
 arch/riscv/include/asm/soc.h           |  1 +
 arch/riscv/include/asm/vendorid_list.h |  1 +
 arch/riscv/kernel/soc.c                | 22 ++++++++++++++++++++++
 arch/riscv/mm/init.c                   |  4 ++++
 6 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index bbaeb5d..080a9eb 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -24,6 +24,11 @@
 #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
 #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
 
+#define _PAGE_DMA_MASK	__riscv_custom_pte.mask
+#define _PAGE_DMA_CACHE	__riscv_custom_pte.cache
+#define _PAGE_DMA_IO	__riscv_custom_pte.io
+#define _PAGE_DMA_WC	__riscv_custom_pte.wc
+
 #define _PAGE_SPECIAL   _PAGE_SOFT
 #define _PAGE_TABLE     _PAGE_PRESENT
 
@@ -35,9 +40,22 @@
 
 #define _PAGE_PFN_SHIFT 10
 
+#ifndef __ASSEMBLY__
+
+struct riscv_custom_pte {
+	unsigned long cache;
+	unsigned long mask;
+	unsigned long io;
+	unsigned long wc;
+};
+
+extern struct riscv_custom_pte __riscv_custom_pte;
+
 /* Set of bits to preserve across pte_modify() */
 #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
 					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL))
+					  _PAGE_USER | _PAGE_GLOBAL |	\
+					  _PAGE_DMA_MASK))
+#endif
 
 #endif /* _ASM_RISCV_PGTABLE_BITS_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 13a79643..6ddeb49 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -114,7 +114,7 @@
 #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
 
 /* Page protection bits */
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER | _PAGE_DMA_CACHE)
 
 #define PAGE_NONE		__pgprot(_PAGE_PROT_NONE)
 #define PAGE_READ		__pgprot(_PAGE_BASE | _PAGE_READ)
@@ -135,7 +135,8 @@
 				| _PAGE_PRESENT \
 				| _PAGE_ACCESSED \
 				| _PAGE_DIRTY \
-				| _PAGE_GLOBAL)
+				| _PAGE_GLOBAL \
+				| _PAGE_DMA_CACHE)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
@@ -145,11 +146,7 @@
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
-/*
- * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
- * change the properties of memory regions.
- */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_DMA_MASK) | _PAGE_DMA_IO)
 
 extern pgd_t swapper_pg_dir[];
 
diff --git a/arch/riscv/include/asm/soc.h b/arch/riscv/include/asm/soc.h
index f494066..fc587d7 100644
--- a/arch/riscv/include/asm/soc.h
+++ b/arch/riscv/include/asm/soc.h
@@ -17,6 +17,7 @@
 		 = { .compatible = compat, .data = fn  }
 
 void soc_early_init(void);
+void soc_setup_vm(void);
 
 extern unsigned long __soc_early_init_table_start;
 extern unsigned long __soc_early_init_table_end;
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 9d93421..c2710f3 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -6,5 +6,6 @@
 #define ASM_VENDOR_LIST_H
 
 #define SIFIVE_VENDOR_ID	0x489
+#define  THEAD_VENDOR_ID	0x401
 
 #endif
diff --git a/arch/riscv/kernel/soc.c b/arch/riscv/kernel/soc.c
index a051617..05fa764 100644
--- a/arch/riscv/kernel/soc.c
+++ b/arch/riscv/kernel/soc.c
@@ -3,8 +3,10 @@
  * Copyright (C) 2020 Western Digital Corporation or its affiliates.
  */
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/libfdt.h>
 #include <linux/pgtable.h>
+#include <asm/image.h>
 #include <asm/soc.h>
 
 /*
@@ -26,3 +28,23 @@ void __init soc_early_init(void)
 		}
 	}
 }
+
+static void __init thead_init(void)
+{
+	__riscv_custom_pte.cache = 0x7000000000000000;
+	__riscv_custom_pte.mask  = 0xf800000000000000;
+	__riscv_custom_pte.io    = BIT(63);
+	__riscv_custom_pte.wc    = 0;
+}
+
+void __init soc_setup_vm(void)
+{
+	unsigned long vendor_id =
+		((struct riscv_image_header *)(&_start))->res1;
+
+	switch (vendor_id) {
+	case THEAD_VENDOR_ID:
+		thead_init();
+		break;
+	}
+};
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4b398c6..fb70c49 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -524,6 +524,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pmd_t fix_bmap_spmd, fix_bmap_epmd;
 #endif
 
+	soc_setup_vm();
 	setup_protection_map();
 
 #ifdef CONFIG_XIP_KERNEL
@@ -911,3 +912,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return vmemmap_populate_basepages(start, end, node, NULL);
 }
 #endif
+
+struct riscv_custom_pte __riscv_custom_pte __ro_after_init;
+EXPORT_SYMBOL(__riscv_custom_pte);
-- 
2.7.4

