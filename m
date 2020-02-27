Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7D171303
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 09:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgB0Is4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 03:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgB0Is4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 03:48:56 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01D724688;
        Thu, 27 Feb 2020 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582793334;
        bh=F0cCXmb/o7liiZO71D4JlF7q0Z7SA6J4fHvegp69+aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YoARMfdjCVgck0l0c6vCbjx7cd13+y+acPDDlGZFlAUTWAMUYLTEv2M6ggkYAaa0j
         i88rDerFv2k34eFxEQbnqfReJw6r6l87uuRNOdX5j+WG794PXnDWd+FNxEP3fkm8ML
         B8WwXGNzu6/Wmfn48PpZc06EkCqi/FhbMHqcaAM0=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 04/14] ia64: add support for folded p4d page tables
Date:   Thu, 27 Feb 2020 10:45:58 +0200
Message-Id: <20200227084608.18223-5-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200227084608.18223-1-rppt@kernel.org>
References: <20200227084608.18223-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Implement primitives necessary for the 4th level folding, add walks of p4d
level where appropriate, remove usage of __ARCH_USE_5LEVEL_HACK and replace
5level-fixup.h with pgtable-nop4d.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/include/asm/pgalloc.h |  4 ++--
 arch/ia64/include/asm/pgtable.h | 17 ++++++++---------
 arch/ia64/mm/fault.c            |  7 ++++++-
 arch/ia64/mm/hugetlbpage.c      | 18 ++++++++++++------
 arch/ia64/mm/init.c             | 28 ++++++++++++++++++++++++----
 5 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
index f4c491044882..2a3050345099 100644
--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -36,9 +36,9 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 #if CONFIG_PGTABLE_LEVELS == 4
 static inline void
-pgd_populate(struct mm_struct *mm, pgd_t * pgd_entry, pud_t * pud)
+p4d_populate(struct mm_struct *mm, p4d_t * p4d_entry, pud_t * pud)
 {
-	pgd_val(*pgd_entry) = __pa(pud);
+	p4d_val(*p4d_entry) = __pa(pud);
 }
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index d602e7c622db..c87f789bc914 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -283,12 +283,12 @@ extern unsigned long VMALLOC_END;
 #define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #if CONFIG_PGTABLE_LEVELS == 4
-#define pgd_none(pgd)			(!pgd_val(pgd))
-#define pgd_bad(pgd)			(!ia64_phys_addr_valid(pgd_val(pgd)))
-#define pgd_present(pgd)		(pgd_val(pgd) != 0UL)
-#define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page_vaddr(pgd)		((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
-#define pgd_page(pgd)			virt_to_page((pgd_val(pgd) + PAGE_OFFSET))
+#define p4d_none(p4d)			(!p4d_val(p4d))
+#define p4d_bad(p4d)			(!ia64_phys_addr_valid(p4d_val(p4d)))
+#define p4d_present(p4d)		(p4d_val(p4d) != 0UL)
+#define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
+#define p4d_page_vaddr(p4d)		((unsigned long) __va(p4d_val(p4d) & _PFN_MASK))
+#define p4d_page(p4d)			virt_to_page((p4d_val(p4d) + PAGE_OFFSET))
 #endif
 
 /*
@@ -388,7 +388,7 @@ pgd_offset (const struct mm_struct *mm, unsigned long address)
 #if CONFIG_PGTABLE_LEVELS == 4
 /* Find an entry in the second-level page table.. */
 #define pud_offset(dir,addr) \
-	((pud_t *) pgd_page_vaddr(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
+	((pud_t *) p4d_page_vaddr(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 #endif
 
 /* Find an entry in the third-level page table.. */
@@ -582,10 +582,9 @@ extern struct page *zero_page_memmap_ptr;
 
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopud.h>
 #endif
-#include <asm-generic/5level-fixup.h>
+#include <asm-generic/pgtable-nop4d.h>
 #include <asm-generic/pgtable.h>
 
 #endif /* _ASM_IA64_PGTABLE_H */
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index c2f299fe9e04..ec994135cb74 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -29,6 +29,7 @@ static int
 mapped_kernel_page_is_present (unsigned long address)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
@@ -37,7 +38,11 @@ mapped_kernel_page_is_present (unsigned long address)
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
 		return 0;
 
-	pud = pud_offset(pgd, address);
+	p4d = p4d_offset(pgd, address);
+	if (p4d_none(*p4d) || p4d_bad(*p4d))
+		return 0;
+
+	pud = pud_offset(p4d, address);
 	if (pud_none(*pud) || pud_bad(*pud))
 		return 0;
 
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index d16e419fd712..32352a73df0c 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -30,12 +30,14 @@ huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, taddr);
-	pud = pud_alloc(mm, pgd, taddr);
+	p4d = p4d_offset(pgd, taddr);
+	pud = pud_alloc(mm, p4d, taddr);
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, taddr);
 		if (pmd)
@@ -49,17 +51,21 @@ huge_pte_offset (struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, taddr);
 	if (pgd_present(*pgd)) {
-		pud = pud_offset(pgd, taddr);
-		if (pud_present(*pud)) {
-			pmd = pmd_offset(pud, taddr);
-			if (pmd_present(*pmd))
-				pte = pte_offset_map(pmd, taddr);
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_present(*p4d)) {
+			pud = pud_offset(p4d, taddr);
+			if (pud_present(*pud)) {
+				pmd = pmd_offset(pud, taddr);
+				if (pmd_present(*pmd))
+					pte = pte_offset_map(pmd, taddr);
+			}
 		}
 	}
 
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index b01d68a2d5d9..4808f58220ac 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -208,6 +208,7 @@ static struct page * __init
 put_kernel_page (struct page *page, unsigned long address, pgprot_t pgprot)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -215,7 +216,10 @@ put_kernel_page (struct page *page, unsigned long address, pgprot_t pgprot)
 	pgd = pgd_offset_k(address);		/* note: this is NOT pgd_offset()! */
 
 	{
-		pud = pud_alloc(&init_mm, pgd, address);
+		p4d = p4d_alloc(&init_mm, pgd, address);
+		if (!p4d)
+			goto out;
+		pud = pud_alloc(&init_mm, p4d, address);
 		if (!pud)
 			goto out;
 		pmd = pmd_alloc(&init_mm, pud, address);
@@ -382,6 +386,7 @@ int vmemmap_find_next_valid_pfn(int node, int i)
 
 	do {
 		pgd_t *pgd;
+		p4d_t *p4d;
 		pud_t *pud;
 		pmd_t *pmd;
 		pte_t *pte;
@@ -392,7 +397,13 @@ int vmemmap_find_next_valid_pfn(int node, int i)
 			continue;
 		}
 
-		pud = pud_offset(pgd, end_address);
+		p4d = p4d_offset(pgd, end_address);
+		if (p4d_none(*p4d)) {
+			end_address += P4D_SIZE;
+			continue;
+		}
+
+		pud = pud_offset(p4d, end_address);
 		if (pud_none(*pud)) {
 			end_address += PUD_SIZE;
 			continue;
@@ -430,6 +441,7 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
 	struct page *map_start, *map_end;
 	int node;
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -444,12 +456,20 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
 	for (address = start_page; address < end_page; address += PAGE_SIZE) {
 		pgd = pgd_offset_k(address);
 		if (pgd_none(*pgd)) {
+			p4d = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!p4d)
+				goto err_alloc;
+			pgd_populate(&init_mm, pgd, p4d);
+		}
+		p4d = p4d_offset(pgd, address);
+
+		if (p4d_none(*p4d)) {
 			pud = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
 			if (!pud)
 				goto err_alloc;
-			pgd_populate(&init_mm, pgd, pud);
+			p4d_populate(&init_mm, p4d, pud);
 		}
-		pud = pud_offset(pgd, address);
+		pud = pud_offset(p4d, address);
 
 		if (pud_none(*pud)) {
 			pmd = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
-- 
2.24.0

