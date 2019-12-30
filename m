Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA012CD9A
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2019 09:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfL3IYR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Dec 2019 03:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfL3IYR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:24:17 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49023207FF;
        Mon, 30 Dec 2019 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694256;
        bh=0047v6YAvSeGk5BGivX70RCM3hzgu//kkkKTTd2bYQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WI4QNXqfgv1Tbewn+NwxGfMvUfg7IL3vgfY0QuhBxDZQjZorWugD63yJKVPlLWfXk
         NYisZS/m1rqrTjaDGxNrUdcQD234j7FXMjUKiagu+TLG1m2kzhMUvNvSGIdbIiWOjR
         c9OP8Yhh2ScjlzaHGs+O8C6FuWrGXcQotXozMOFM=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 4/5] csky: Separate fixaddr_init from highmem
Date:   Mon, 30 Dec 2019 16:23:30 +0800
Message-Id: <20191230082331.30976-4-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191230082331.30976-1-guoren@kernel.org>
References: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

After fixaddr_init is separated from highmem, we could use tcm
without highmem selected. (610 (abiv1) don't support highmem,
but it could use tcm now.)

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig               |  1 -
 arch/csky/include/asm/fixmap.h  |  4 +++
 arch/csky/include/asm/memory.h  |  3 ++
 arch/csky/include/asm/pgtable.h |  6 +---
 arch/csky/kernel/setup.c        |  2 ++
 arch/csky/mm/highmem.c          | 64 +++------------------------------
 arch/csky/mm/init.c             | 47 ++++++++++++++++++++++++
 7 files changed, 61 insertions(+), 66 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 77e8e077648a..7f142eecdbfc 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -190,7 +190,6 @@ endchoice
 
 menuconfig HAVE_TCM
 	bool "Tightly-Coupled/Sram Memory"
-	depends on HIGHMEM
 	select GENERIC_ALLOCATOR
 	help
 	  The implementation are not only used by TCM (Tightly-Coupled Meory)
diff --git a/arch/csky/include/asm/fixmap.h b/arch/csky/include/asm/fixmap.h
index 4350578faa1c..81f9477d5330 100644
--- a/arch/csky/include/asm/fixmap.h
+++ b/arch/csky/include/asm/fixmap.h
@@ -27,4 +27,8 @@ enum fixed_addresses {
 
 #include <asm-generic/fixmap.h>
 
+extern void fixrange_init(unsigned long start, unsigned long end,
+	pgd_t *pgd_base);
+extern void __init fixaddr_init(void);
+
 #endif /* __ASM_CSKY_FIXMAP_H */
diff --git a/arch/csky/include/asm/memory.h b/arch/csky/include/asm/memory.h
index cdffbd0a500b..a65c6759f537 100644
--- a/arch/csky/include/asm/memory.h
+++ b/arch/csky/include/asm/memory.h
@@ -9,6 +9,9 @@
 #include <linux/sizes.h>
 
 #define FIXADDR_TOP	_AC(0xffffc000, UL)
+#define PKMAP_BASE	_AC(0xff800000, UL)
+#define VMALLOC_START	_AC(0xc0008000, UL)
+#define VMALLOC_END	(PKMAP_BASE - (PAGE_SIZE * 2))
 
 #ifdef CONFIG_HAVE_TCM
 #ifdef CONFIG_HAVE_DTCM
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 7c21985c60dc..bd86c3fe0733 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -5,6 +5,7 @@
 #define __ASM_CSKY_PGTABLE_H
 
 #include <asm/fixmap.h>
+#include <asm/memory.h>
 #include <asm/addrspace.h>
 #include <abi/pgtable-bits.h>
 #include <asm-generic/pgtable-nopmd.h>
@@ -16,11 +17,6 @@
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0UL
 
-#define PKMAP_BASE		(0xff800000)
-
-#define VMALLOC_START		(0xc0008000)
-#define VMALLOC_END		(PKMAP_BASE - 2*PAGE_SIZE)
-
 /*
  * C-SKY is two-level paging structure:
  */
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 23ee604aafdb..4f7786ccfceb 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -133,6 +133,8 @@ void __init setup_arch(char **cmdline_p)
 
 	sparse_init();
 
+	fixaddr_init();
+
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 3317b774f6dc..813129145f3d 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -117,85 +117,29 @@ struct page *kmap_atomic_to_page(void *ptr)
 	return pte_page(*pte);
 }
 
-static void __init fixrange_init(unsigned long start, unsigned long end,
-				pgd_t *pgd_base)
+static void __init kmap_pages_init(void)
 {
-#ifdef CONFIG_HIGHMEM
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i, j, k;
 	unsigned long vaddr;
-
-	vaddr = start;
-	i = __pgd_offset(vaddr);
-	j = __pud_offset(vaddr);
-	k = __pmd_offset(vaddr);
-	pgd = pgd_base + i;
-
-	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
-		pud = (pud_t *)pgd;
-		for ( ; (j < PTRS_PER_PUD) && (vaddr != end); pud++, j++) {
-			pmd = (pmd_t *)pud;
-			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
-				if (pmd_none(*pmd)) {
-					pte = (pte_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-					if (!pte)
-						panic("%s: Failed to allocate %lu bytes align=%lx\n",
-						      __func__, PAGE_SIZE,
-						      PAGE_SIZE);
-
-					set_pmd(pmd, __pmd(__pa(pte)));
-					BUG_ON(pte != pte_offset_kernel(pmd, 0));
-				}
-				vaddr += PMD_SIZE;
-			}
-			k = 0;
-		}
-		j = 0;
-	}
-#endif
-}
-
-void __init fixaddr_kmap_pages_init(void)
-{
-	unsigned long vaddr;
-	pgd_t *pgd_base;
-#ifdef CONFIG_HIGHMEM
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pud_t *pud;
 	pte_t *pte;
-#endif
-	pgd_base = swapper_pg_dir;
-
-	/*
-	 * Fixed mappings:
-	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
-
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * Permanent kmaps:
-	 */
+
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pud = (pud_t *)pgd;
 	pmd = pmd_offset(pud, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
-#endif
 }
 
 void __init kmap_init(void)
 {
 	unsigned long vaddr;
 
-	fixaddr_kmap_pages_init();
+	kmap_pages_init();
 
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN);
 
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index d4c2292ea46b..322eb7bd7962 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -101,3 +101,50 @@ void __init pre_mmu_init(void)
 	/* Setup page mask to 4k */
 	write_mmu_pagemask(0);
 }
+
+void __init fixrange_init(unsigned long start, unsigned long end,
+			pgd_t *pgd_base)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int i, j, k;
+	unsigned long vaddr;
+
+	vaddr = start;
+	i = __pgd_offset(vaddr);
+	j = __pud_offset(vaddr);
+	k = __pmd_offset(vaddr);
+	pgd = pgd_base + i;
+
+	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
+		pud = (pud_t *)pgd;
+		for ( ; (j < PTRS_PER_PUD) && (vaddr != end); pud++, j++) {
+			pmd = (pmd_t *)pud;
+			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
+				if (pmd_none(*pmd)) {
+					pte = (pte_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+					if (!pte)
+						panic("%s: Failed to allocate %lu bytes align=%lx\n",
+						      __func__, PAGE_SIZE,
+						      PAGE_SIZE);
+
+					set_pmd(pmd, __pmd(__pa(pte)));
+					BUG_ON(pte != pte_offset_kernel(pmd, 0));
+				}
+				vaddr += PMD_SIZE;
+			}
+			k = 0;
+		}
+		j = 0;
+	}
+}
+
+void __init fixaddr_init(void)
+{
+	unsigned long vaddr;
+
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	fixrange_init(vaddr, vaddr + PMD_SIZE, swapper_pg_dir);
+}
-- 
2.17.0

