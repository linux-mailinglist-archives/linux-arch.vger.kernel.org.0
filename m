Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5258337B562
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 07:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELFV0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 01:21:26 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59443 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhELFVZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 May 2021 01:21:25 -0400
X-Greylist: delayed 1157 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 01:21:25 EDT
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fg2gL0zrDz9sf3;
        Wed, 12 May 2021 07:01:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dA1m01dIGbmI; Wed, 12 May 2021 07:01:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fg2gK3TDCz9sdw;
        Wed, 12 May 2021 07:01:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F1538B7D6;
        Wed, 12 May 2021 07:01:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rQhrgmmPfChw; Wed, 12 May 2021 07:01:01 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F18CB8B769;
        Wed, 12 May 2021 07:01:00 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CC0C064164; Wed, 12 May 2021 05:01:00 +0000 (UTC)
Message-Id: <fb3ccc73377832ac6708181ec419128a2f98ce36.1620795204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1620795204.git.christophe.leroy@csgroup.eu>
References: <cover.1620795204.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/5] mm/vmalloc: Enable mapping of huge pages at pte level
 in vmap
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 12 May 2021 05:01:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On some architectures like powerpc, there are huge pages that
are mapped at pte level.

Enable it in vmap.

For that, architectures can provide arch_vmap_pte_range_map_size()
that returns the size of pages to map at pte level.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/vmalloc.h |  8 ++++++++
 mm/vmalloc.c            | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 4d668abb6391..13c9b19ec923 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -104,6 +104,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 }
 #endif
 
+#ifndef arch_vmap_pte_range_map_size
+static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, unsigned long end,
+							 u64 pfn, unsigned int max_page_shift)
+{
+	return PAGE_SIZE;
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a13ac524f6ff..783d23b8c2f7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -36,6 +36,7 @@
 #include <linux/overflow.h>
 #include <linux/pgtable.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -83,10 +84,11 @@ static void free_work(struct work_struct *w)
 /*** Page table manipulation functions ***/
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			pgtbl_mod_mask *mask)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 	u64 pfn;
+	unsigned long size = PAGE_SIZE;
 
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
@@ -94,9 +96,22 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		return -ENOMEM;
 	do {
 		BUG_ON(!pte_none(*pte));
+
+#ifdef CONFIG_HUGETLB_PAGE
+		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
+		if (size != PAGE_SIZE) {
+			pte_t entry = pfn_pte(pfn, prot);
+
+			entry = pte_mkhuge(entry);
+			entry = arch_make_huge_pte(entry, ilog2(size), 0);
+			set_huge_pte_at(&init_mm, addr, pte, entry);
+			pfn += PFN_DOWN(size);
+			continue;
+		}
+#endif
 		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte += PFN_DOWN(size), addr += size, addr != end);
 	*mask |= PGTBL_PTE_MODIFIED;
 	return 0;
 }
@@ -145,7 +160,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, max_page_shift, mask))
 			return -ENOMEM;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
-- 
2.25.0

