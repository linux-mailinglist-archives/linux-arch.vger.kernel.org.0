Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559A536DD5B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbhD1QrD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 12:47:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50432 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241228AbhD1QrC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 12:47:02 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FVkzW5bBHz9tcd;
        Wed, 28 Apr 2021 18:46:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ignT_pQ-z5aE; Wed, 28 Apr 2021 18:46:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FVkzW4fqhz9tcV;
        Wed, 28 Apr 2021 18:46:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 555F78B837;
        Wed, 28 Apr 2021 18:46:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id z1HHXWlZ7xmI; Wed, 28 Apr 2021 18:46:15 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0AD2A8B831;
        Wed, 28 Apr 2021 18:46:15 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DF8946428C; Wed, 28 Apr 2021 16:46:14 +0000 (UTC)
Message-Id: <15cea17065678a4e9019a20b7d011ca6eb205de6.1619628001.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1619628001.git.christophe.leroy@csgroup.eu>
References: <cover.1619628001.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 4/4] mm/vmalloc: Add support for huge pages on VMAP and
 VMALLOC for powerpc 8xx
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 28 Apr 2021 16:46:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc 8xx has 4 page sizes:
- 4k
- 16k
- 512k
- 8M

At the time being, vmalloc and vmap only support huge pages which are
leaf at PMD level.

Here the PMD level is 4M, it doesn't correspond to any supported
page size.

For the time being, implement use of 16k and 512k pages which is done
at PTE level.

Support of 8M pages will be implemented later, it requires use of
hugepd tables.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig |  3 +-
 mm/vmalloc.c         | 74 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 27e88c38fdf7..b443716f7413 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -188,7 +188,8 @@ config PPC
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMAP		if (PPC_BOOK3S_64 && PPC_RADIX_MMU) || PPC_8xx
+	select HAVE_ARCH_HUGE_VMALLOC		if PPC_8xx
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d96fee17226..1f9f9be8ec01 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -36,6 +36,7 @@
 #include <linux/overflow.h>
 #include <linux/pgtable.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -81,12 +82,55 @@ static void free_work(struct work_struct *w)
 }
 
 /*** Page table manipulation functions ***/
+static int vmap_try_huge_pte(pte_t *ptep, unsigned long addr, unsigned long end,
+			     u64 pfn, pgprot_t prot, unsigned int max_page_shift)
+{
+	unsigned long size = end - addr;
+	pte_t pte;
+
+	if (!IS_ENABLED(CONFIG_PPC_8xx))
+		return 0;
+
+	if (PAGE_SIZE == SZ_16K && size < SZ_512K)
+		return 0;
+
+	if (size < SZ_16K)
+		return 0;
+
+	if (max_page_shift < 14)
+		return 0;
+
+	if (size > SZ_512K)
+		size = SZ_512K;
+
+	if (max_page_shift < 19 && size > SZ_16K)
+		size = SZ_16K;
+
+	if (!IS_ALIGNED(addr, size))
+		return 0;
+
+	if (!IS_ALIGNED(PFN_PHYS(pfn), size))
+		return 0;
+
+	if (pte_present(*ptep))
+		return 0;
+
+	pte = pfn_pte(pfn, prot);
+	pte = pte_mkhuge(pte);
+	pte = arch_make_huge_pte(pte, ilog2(size), 0);
+
+	set_huge_pte_at(&init_mm, addr, ptep, pte);
+
+	return PFN_DOWN(size);
+}
+
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			pgtbl_mod_mask *mask)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 	u64 pfn;
+	int npages;
 
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
@@ -94,9 +138,14 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		return -ENOMEM;
 	do {
 		BUG_ON(!pte_none(*pte));
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+		npages = vmap_try_huge_pte(pte, addr, end, pfn, prot, max_page_shift);
+		if (!npages) {
+			set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
+			npages = 1;
+		}
+		pfn += npages;
+	} while (pte += npages, addr += PAGE_SIZE * npages, addr != end);
 	*mask |= PGTBL_PTE_MODIFIED;
 	return 0;
 }
@@ -145,7 +194,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, max_page_shift, mask))
 			return -ENOMEM;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
@@ -2881,8 +2930,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
-	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP) &&
-			arch_vmap_pmd_supported(prot)) {
+	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
 		unsigned long size_per_node;
 
 		/*
@@ -2895,11 +2943,17 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		size_per_node = size;
 		if (node == NUMA_NO_NODE)
 			size_per_node /= num_online_nodes();
-		if (size_per_node >= PMD_SIZE) {
+		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE) {
 			shift = PMD_SHIFT;
-			align = max(real_align, 1UL << shift);
-			size = ALIGN(real_size, 1UL << shift);
+		} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
+			if (size_per_node >= SZ_512K) {
+				shift = 19;
+			} else if (size_per_node >= SZ_16K) {
+				shift = 14;
+			}
 		}
+		align = max(real_align, 1UL << shift);
+		size = ALIGN(real_size, 1UL << shift);
 	}
 
 again:
-- 
2.25.0

