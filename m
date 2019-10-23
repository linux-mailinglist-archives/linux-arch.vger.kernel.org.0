Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEEDE238B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 21:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbfJWT7R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 15:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfJWT7Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 15:59:16 -0400
Received: from rapoport-lnx (unknown [87.70.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B4921872;
        Wed, 23 Oct 2019 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571860755;
        bh=Jf0FZ9koYKPsk8yKRCE9l43q+ohhw2zYv3Wmu8yClek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qhsko5tlFKT09SJQijphuf3rKlN52ZKF4gE+IDs6GYHNlkcdadcR7sgGp0sVtm8rZ
         shO12nGS4xds4STRxHbwQt8johDjslCxsIrC01a4gW3przARTbZJ4v9jsOPN267eQx
         AFk3aBh63zsTIPHO8Srhhh1mUFBTtsd4I6WkexDQ=
Date:   Wed, 23 Oct 2019 22:59:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 09/12] sparc32: use pgtable-nopud instead of 4level-fixup
Message-ID: <20191023195859.GA24394@rapoport-lnx>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-10-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571822941-29776-10-git-send-email-rppt@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I've just discovered that I've booted qemu-sparc with the wrong kernel and
this patch crashes miserably :(

The better version that does allow qemu-sparc to boot with folded page
tables is below:


From a90e1d157b7f8786a4276ffc8553f2167c8bc0e7 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 1 Oct 2019 17:14:38 +0300
Subject: [PATCH v2] sparc32: use pgtable-nopud instead of 4level-fixup

32-bit version of sparc has three-level page tables and can use
pgtable-nopud and folding of the upper layers.

Replace usage of include/asm-generic/4level-fixup.h with
include/asm-generic/pgtable-nopud.h and adjust page table manipulation
macros and functions accordingly.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/include/asm/pgalloc_32.h |  6 ++---
 arch/sparc/include/asm/pgtable_32.h | 28 ++++++++++----------
 arch/sparc/mm/fault_32.c            | 11 ++++++--
 arch/sparc/mm/highmem.c             |  6 ++++-
 arch/sparc/mm/io-unit.c             |  6 ++++-
 arch/sparc/mm/iommu.c               |  6 ++++-
 arch/sparc/mm/srmmu.c               | 51 +++++++++++++++++++++++++++++--------
 7 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 10538a4..eae0c92 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -26,14 +26,14 @@ static inline void free_pgd_fast(pgd_t *pgd)
 #define pgd_free(mm, pgd)	free_pgd_fast(pgd)
 #define pgd_alloc(mm)	get_pgd_fast()
 
-static inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
+static inline void pud_set(pud_t * pudp, pmd_t * pmdp)
 {
 	unsigned long pa = __nocache_pa(pmdp);
 
-	set_pte((pte_t *)pgdp, __pte((SRMMU_ET_PTD | (pa >> 4))));
+	set_pte((pte_t *)pudp, __pte((SRMMU_ET_PTD | (pa >> 4))));
 }
 
-#define pgd_populate(MM, PGD, PMD)      pgd_set(PGD, PMD)
+#define pud_populate(MM, PGD, PMD)      pud_set(PGD, PMD)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm,
 				   unsigned long address)
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 31da448..6d6f44c 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -12,7 +12,7 @@
 #include <linux/const.h>
 
 #ifndef __ASSEMBLY__
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopud.h>
 
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
@@ -132,12 +132,12 @@ static inline struct page *pmd_page(pmd_t pmd)
 	return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
 }
 
-static inline unsigned long pgd_page_vaddr(pgd_t pgd)
+static inline unsigned long pud_page_vaddr(pud_t pud)
 {
-	if (srmmu_device_memory(pgd_val(pgd))) {
+	if (srmmu_device_memory(pud_val(pud))) {
 		return ~0;
 	} else {
-		unsigned long v = pgd_val(pgd) & SRMMU_PTD_PMASK;
+		unsigned long v = pud_val(pud) & SRMMU_PTD_PMASK;
 		return (unsigned long)__nocache_va(v << 4);
 	}
 }
@@ -184,24 +184,24 @@ static inline void pmd_clear(pmd_t *pmdp)
 		set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
 }
 
-static inline int pgd_none(pgd_t pgd)          
+static inline int pud_none(pud_t pud)
 {
-	return !(pgd_val(pgd) & 0xFFFFFFF);
+	return !(pud_val(pud) & 0xFFFFFFF);
 }
 
-static inline int pgd_bad(pgd_t pgd)
+static inline int pud_bad(pud_t pud)
 {
-	return (pgd_val(pgd) & SRMMU_ET_MASK) != SRMMU_ET_PTD;
+	return (pud_val(pud) & SRMMU_ET_MASK) != SRMMU_ET_PTD;
 }
 
-static inline int pgd_present(pgd_t pgd)
+static inline int pud_present(pud_t pud)
 {
-	return ((pgd_val(pgd) & SRMMU_ET_MASK) == SRMMU_ET_PTD);
+	return ((pud_val(pud) & SRMMU_ET_MASK) == SRMMU_ET_PTD);
 }
 
-static inline void pgd_clear(pgd_t *pgdp)
+static inline void pud_clear(pud_t *pudp)
 {
-	set_pte((pte_t *)pgdp, __pte(0));
+	set_pte((pte_t *)pudp, __pte(0));
 }
 
 /*
@@ -319,9 +319,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /* Find an entry in the second-level page table.. */
-static inline pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
+static inline pmd_t *pmd_offset(pud_t * dir, unsigned long address)
 {
-	return (pmd_t *) pgd_page_vaddr(*dir) +
+	return (pmd_t *) pud_page_vaddr(*dir) +
 		((address >> PMD_SHIFT) & (PTRS_PER_PMD - 1));
 }
 
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 8d69de1..89976c9 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -351,6 +351,8 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 		 */
 		int offset = pgd_index(address);
 		pgd_t *pgd, *pgd_k;
+		p4d_t *p4d, *p4d_k;
+		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
 
 		pgd = tsk->active_mm->pgd + offset;
@@ -363,8 +365,13 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 			return;
 		}
 
-		pmd = pmd_offset(pgd, address);
-		pmd_k = pmd_offset(pgd_k, address);
+		p4d = p4d_offset(pgd, address);
+		pud = pud_offset(p4d, address);
+		pmd = pmd_offset(pud, address);
+
+		p4d_k = p4d_offset(pgd_k, address);
+		pud_k = pud_offset(p4d_k, address);
+		pmd_k = pmd_offset(pud_k, address);
 
 		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
 			goto bad_area_nosemaphore;
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index 86bc2a5..d4a80ad 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -39,10 +39,14 @@ static pte_t *kmap_pte;
 void __init kmap_init(void)
 {
 	unsigned long address;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *dir;
 
 	address = __fix_to_virt(FIX_KMAP_BEGIN);
-	dir = pmd_offset(pgd_offset_k(address), address);
+	p4d = p4d_offset(pgd_offset_k(address), address);
+	pud = pud_offset(p4d, address);
+	dir = pmd_offset(pud, address);
 
         /* cache the first kmap pte */
         kmap_pte = pte_offset_kernel(dir, address);
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index f770ee7..33a0fac 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -239,12 +239,16 @@ static void *iounit_alloc(struct device *dev, size_t len,
 		page = va;
 		{
 			pgd_t *pgdp;
+			p4d_t *p4dp;
+			pud_t *pudp;
 			pmd_t *pmdp;
 			pte_t *ptep;
 			long i;
 
 			pgdp = pgd_offset(&init_mm, addr);
-			pmdp = pmd_offset(pgdp, addr);
+			p4dp = p4d_offset(pgdp, addr);
+			pudp = pud_offset(p4dp, addr);
+			pmdp = pmd_offset(pudp, addr);
 			ptep = pte_offset_map(pmdp, addr);
 
 			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 71ac353..4d3c699 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -343,6 +343,8 @@ static void *sbus_iommu_alloc(struct device *dev, size_t len,
 		page = va;
 		{
 			pgd_t *pgdp;
+			p4d_t *p4dp;
+			pud_t *pudp;
 			pmd_t *pmdp;
 			pte_t *ptep;
 
@@ -354,7 +356,9 @@ static void *sbus_iommu_alloc(struct device *dev, size_t len,
 				__flush_page_to_ram(page);
 
 			pgdp = pgd_offset(&init_mm, addr);
-			pmdp = pmd_offset(pgdp, addr);
+			p4dp = p4d_offset(pgdp, addr);
+			pudp = pud_offset(p4dp, addr);
+			pmdp = pmd_offset(pudp, addr);
 			ptep = pte_offset_map(pmdp, addr);
 
 			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cc3ad64..f56c3c9 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -296,6 +296,8 @@ static void __init srmmu_nocache_init(void)
 	void *srmmu_nocache_bitmap;
 	unsigned int bitmap_bits;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long paddr, vaddr;
@@ -329,6 +331,8 @@ static void __init srmmu_nocache_init(void)
 
 	while (vaddr < srmmu_nocache_end) {
 		pgd = pgd_offset_k(vaddr);
+		p4d = p4d_offset(__nocache_fix(pgd), vaddr);
+		pud = pud_offset(__nocache_fix(p4d), vaddr);
 		pmd = pmd_offset(__nocache_fix(pgd), vaddr);
 		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
 
@@ -516,13 +520,17 @@ static inline void srmmu_mapioaddr(unsigned long physaddr,
 				   unsigned long virt_addr, int bus_type)
 {
 	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 	unsigned long tmp;
 
 	physaddr &= PAGE_MASK;
 	pgdp = pgd_offset_k(virt_addr);
-	pmdp = pmd_offset(pgdp, virt_addr);
+	p4dp = p4d_offset(pgdp, virt_addr);
+	pudp = pud_offset(p4dp, virt_addr);
+	pmdp = pmd_offset(pudp, virt_addr);
 	ptep = pte_offset_kernel(pmdp, virt_addr);
 	tmp = (physaddr >> 4) | SRMMU_ET_PTE;
 
@@ -551,11 +559,16 @@ void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
 static inline void srmmu_unmapioaddr(unsigned long virt_addr)
 {
 	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+
 	pgdp = pgd_offset_k(virt_addr);
-	pmdp = pmd_offset(pgdp, virt_addr);
+	p4dp = p4d_offset(pgdp, virt_addr);
+	pudp = pud_offset(p4dp, virt_addr);
+	pmdp = pmd_offset(pudp, virt_addr);
 	ptep = pte_offset_kernel(pmdp, virt_addr);
 
 	/* No need to flush uncacheable page. */
@@ -693,20 +706,24 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 							unsigned long end)
 {
 	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
 	while (start < end) {
 		pgdp = pgd_offset_k(start);
-		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
+		p4dp = p4d_offset(pgdp, start);
+		pudp = pud_offset(p4dp, start);
+		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(
 			    SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
 				early_pgtable_allocfail("pmd");
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
-			pgd_set(__nocache_fix(pgdp), pmdp);
+			pud_set(__nocache_fix(pudp), pmdp);
 		}
-		pmdp = pmd_offset(__nocache_fix(pgdp), start);
+		pmdp = pmd_offset(__nocache_fix(pudp), start);
 		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep == NULL)
@@ -724,19 +741,23 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 						  unsigned long end)
 {
 	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
 	while (start < end) {
 		pgdp = pgd_offset_k(start);
-		if (pgd_none(*pgdp)) {
+		p4dp = p4d_offset(pgdp, start);
+		pudp = pud_offset(p4dp, start);
+		if (pud_none(*pudp)) {
 			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
 				early_pgtable_allocfail("pmd");
 			memset(pmdp, 0, SRMMU_PMD_TABLE_SIZE);
-			pgd_set(pgdp, pmdp);
+			pud_set((pud_t *)pgdp, pmdp);
 		}
-		pmdp = pmd_offset(pgdp, start);
+		pmdp = pmd_offset(pudp, start);
 		if (srmmu_pmd_none(*pmdp)) {
 			ptep = __srmmu_get_nocache(PTE_SIZE,
 							     PTE_SIZE);
@@ -779,6 +800,8 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 	unsigned long probed;
 	unsigned long addr;
 	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 	int what; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
@@ -810,18 +833,20 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		}
 
 		pgdp = pgd_offset_k(start);
+		p4dp = p4d_offset(pgdp, start);
+		pudp = pud_offset(p4dp, start);
 		if (what == 2) {
 			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
 			start += SRMMU_PGDIR_SIZE;
 			continue;
 		}
-		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
+		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
 						   SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
 				early_pgtable_allocfail("pmd");
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
-			pgd_set(__nocache_fix(pgdp), pmdp);
+			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pgdp), start);
 		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
@@ -906,6 +931,8 @@ void __init srmmu_paging_init(void)
 	phandle cpunode;
 	char node_str[128];
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long pages_avail;
@@ -967,7 +994,9 @@ void __init srmmu_paging_init(void)
 	srmmu_allocate_ptable_skeleton(PKMAP_BASE, PKMAP_END);
 
 	pgd = pgd_offset_k(PKMAP_BASE);
-	pmd = pmd_offset(pgd, PKMAP_BASE);
+	p4d = p4d_offset(pgd, PKMAP_BASE);
+	pud = pud_offset(p4d, PKMAP_BASE);
+	pmd = pmd_offset(pud, PKMAP_BASE);
 	pte = pte_offset_kernel(pmd, PKMAP_BASE);
 	pkmap_page_table = pte;
 
-- 
2.7.4

