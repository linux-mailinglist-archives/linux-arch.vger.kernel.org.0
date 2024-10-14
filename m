Return-Path: <linux-arch+bounces-8074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7A99C838
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EF71C2646C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B21D9A51;
	Mon, 14 Oct 2024 11:02:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6801A7ADD;
	Mon, 14 Oct 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903730; cv=none; b=dJVgbh0Yy4gldKAH1dI1gDAE/UJj0tlmmazQrJsfosLdcpb+KNBmaUdLzoXs3Bt79mUCML9iJOPGLw0+3murbszNdnuTJnb05xr7b9w1dSA+XWwEXUicwgy1y+7rKzlatN0/exrG/wX+HKW9m/lVuxm/cJGHrX/NOoepsrmaNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903730; c=relaxed/simple;
	bh=cdF7k0JsDR53oZjM+CReXrKImAQ0AxOb85WhdpVuhCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heyLcUIgMWjMVXrr6CERGg6onRYoN5o+kMD3YIJyixhONZNbFG/o/XMsYRnQRv3D+fZk5PClmsR/VlOAVAA+yOqIW3Bp75k5eAmao7gLMBWcVSDUQV58SjKkIjn/JxwW3PBr9xkSaP8iu1tzWHQ61zHXo281s3NEm8Ag9nyIuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08F6A1713;
	Mon, 14 Oct 2024 04:02:38 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CBF3F51B;
	Mon, 14 Oct 2024 04:02:05 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Nick Piggin <npiggin@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 53/57] arm64: Runtime-fold pmd level
Date: Mon, 14 Oct 2024 11:59:00 +0100
Message-ID: <20241014105912.3207374-53-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a given VA size, the number of levels of lookup depends on the page
size. With boot-time page size selection, we therefore don't know how
many levels of lookup we require until boot time. So we need to
runtime-fold some levels of lookup.

We already have code to runtime-fold p4d and pud levels; that exists for
LPA2 fallback paths and can be repurposed for our needs. But pmd level
also needs to support runtime folding; for example, 16K/36-bit and
64K/42-bit configs require only 2 levels.

So let's add the required code. However, note that until we actually add
the boot-time page size config, pgtable_l3_enabled() simply returns the
compile-time determined answer.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/pgalloc.h |  16 +++-
 arch/arm64/include/asm/pgtable.h | 123 +++++++++++++++++++++++--------
 arch/arm64/include/asm/tlb.h     |   3 +
 arch/arm64/kernel/cpufeature.c   |   4 +-
 arch/arm64/kvm/mmu.c             |   9 +--
 arch/arm64/mm/fixmap.c           |   2 +-
 arch/arm64/mm/hugetlbpage.c      |  16 ++--
 arch/arm64/mm/init.c             |   2 +-
 arch/arm64/mm/mmu.c              |   2 +-
 arch/arm64/mm/ptdump.c           |   3 +-
 10 files changed, 126 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 8ff5f2a2579e4..51cc2f32931d2 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -15,6 +15,7 @@
 
 #define __HAVE_ARCH_PGD_FREE
 #define __HAVE_ARCH_PUD_FREE
+#define __HAVE_ARCH_PMD_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
@@ -23,7 +24,8 @@
 
 static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 {
-	set_pud(pudp, __pud(__phys_to_pud_val(pmdp) | prot));
+	if (pgtable_l3_enabled())
+		set_pud(pudp, __pud(__phys_to_pud_val(pmdp) | prot));
 }
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
@@ -33,6 +35,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 	pudval |= (mm == &init_mm) ? PUD_TABLE_UXN : PUD_TABLE_PXN;
 	__pud_populate(pudp, __pa(pmdp), pudval);
 }
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
+
+	if (!pgtable_l3_enabled())
+		return;
+
+	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
+	pagetable_pmd_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
 #else
 static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 {
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index fd47f70a42396..8ead41da715b0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -672,15 +672,21 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
 #define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
 
-#if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
-static inline bool pud_sect(pud_t pud) { return false; }
-static inline bool pud_table(pud_t pud) { return true; }
-#else
-#define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
-				 PUD_TYPE_SECT)
-#define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
-				 PUD_TYPE_TABLE)
-#endif
+static inline bool pgtable_l3_enabled(void);
+
+static inline bool pud_sect(pud_t pud)
+{
+	if (PAGE_SIZE == SZ_64K || !pgtable_l3_enabled())
+		return false;
+	return (pud_val(pud) & PUD_TYPE_MASK) == PUD_TYPE_SECT;
+}
+
+static inline bool pud_table(pud_t pud)
+{
+	if (PAGE_SIZE == SZ_64K || !pgtable_l3_enabled())
+		return true;
+	return (pud_val(pud) & PUD_TYPE_MASK) == PUD_TYPE_TABLE;
+}
 
 extern pgd_t init_pg_dir[];
 extern pgd_t init_pg_end[];
@@ -699,12 +705,10 @@ static inline bool in_swapper_pgdir(void *addr)
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-#ifdef __PAGETABLE_PMD_FOLDED
-	if (in_swapper_pgdir(pmdp)) {
+	if (!pgtable_l3_enabled() && in_swapper_pgdir(pmdp)) {
 		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
 		return;
 	}
-#endif /* __PAGETABLE_PMD_FOLDED */
 
 	WRITE_ONCE(*pmdp, pmd);
 
@@ -749,20 +753,27 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
+static __always_inline bool pgtable_l3_enabled(void)
+{
+	return true;
+}
+
+static inline bool mm_pmd_folded(const struct mm_struct *mm)
+{
+	return !pgtable_l3_enabled();
+}
+#define mm_pmd_folded  mm_pmd_folded
+
 #define pmd_ERROR(e)	\
 	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
-#define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!pud_table(pud))
-#define pud_present(pud)	pte_present(pud_pte(pud))
-#ifndef __PAGETABLE_PMD_FOLDED
-#define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
-#else
-#define pud_leaf(pud)		false
-#endif
-#define pud_valid(pud)		pte_valid(pud_pte(pud))
-#define pud_user(pud)		pte_user(pud_pte(pud))
-#define pud_user_exec(pud)	pte_user_exec(pud_pte(pud))
+#define pud_none(pud)		(pgtable_l3_enabled() && !pud_val(pud))
+#define pud_bad(pud)		(pgtable_l3_enabled() && !pud_table(pud))
+#define pud_present(pud)	(!pgtable_l3_enabled() || pte_present(pud_pte(pud)))
+#define pud_leaf(pud)		(pgtable_l3_enabled() && pte_present(pud_pte(pud)) && !pud_table(pud))
+#define pud_valid(pud)		(pgtable_l3_enabled() && pte_valid(pud_pte(pud)))
+#define pud_user(pud)		(pgtable_l3_enabled() && pte_user(pud_pte(pud)))
+#define pud_user_exec(pud)	(pgtable_l3_enabled() && pte_user_exec(pud_pte(pud)))
 
 static inline bool pgtable_l4_enabled(void);
 
@@ -783,7 +794,8 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 
 static inline void pud_clear(pud_t *pudp)
 {
-	set_pud(pudp, __pud(0));
+	if (pgtable_l3_enabled())
+		set_pud(pudp, __pud(0));
 }
 
 static inline phys_addr_t pud_page_paddr(pud_t pud)
@@ -791,25 +803,74 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 	return __pud_to_phys(pud);
 }
 
+#define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
+static inline pmd_t *pud_to_folded_pmd(pud_t *pudp, unsigned long addr)
+{
+	return (pmd_t *)pudp;
+}
+
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return (pmd_t *)__va(pud_page_paddr(pud));
 }
 
-/* Find an entry in the second-level page table. */
-#define pmd_offset_phys(dir, addr)	(pud_page_paddr(READ_ONCE(*(dir))) + pmd_index(addr) * sizeof(pmd_t))
+static inline phys_addr_t pmd_offset_phys(pud_t *pudp, unsigned long addr)
+{
+	BUG_ON(!pgtable_l3_enabled());
+
+	return pud_page_paddr(READ_ONCE(*pudp)) + pmd_index(addr) * sizeof(pmd_t);
+}
+
+static inline pmd_t *pmd_offset_lockless(pud_t *pudp, pud_t pud,
+					 unsigned long addr)
+{
+	if (!pgtable_l3_enabled())
+		return pud_to_folded_pmd(pudp, addr);
+	return (pmd_t *)__va(pud_page_paddr(pud)) + pmd_index(addr);
+}
+#define pmd_offset_lockless pmd_offset_lockless
 
-#define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
-#define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(pud, addr))
-#define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
+static inline pmd_t *pmd_offset(pud_t *pudp, unsigned long addr)
+{
+	return pmd_offset_lockless(pudp, READ_ONCE(*pudp), addr);
+}
+#define pmd_offset pmd_offset
 
-#define pud_page(pud)			phys_to_page(__pud_to_phys(pud))
+static inline pmd_t *pmd_set_fixmap(unsigned long addr)
+{
+	if (!pgtable_l3_enabled())
+		return NULL;
+	return (pmd_t *)set_fixmap_offset(FIX_PMD, addr);
+}
+
+static inline pmd_t *pmd_set_fixmap_offset(pud_t *pudp, unsigned long addr)
+{
+	if (!pgtable_l3_enabled())
+		return pud_to_folded_pmd(pudp, addr);
+	return pmd_set_fixmap(pmd_offset_phys(pudp, addr));
+}
+
+static inline void pmd_clear_fixmap(void)
+{
+	if (pgtable_l3_enabled())
+		clear_fixmap(FIX_PMD);
+}
 
 /* use ONLY for statically allocated translation tables */
-#define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
+static inline pmd_t *pmd_offset_kimg(pud_t *pudp, u64 addr)
+{
+	if (!pgtable_l3_enabled())
+		return pud_to_folded_pmd(pudp, addr);
+	return (pmd_t *)__phys_to_kimg(pmd_offset_phys(pudp, addr));
+}
+
+#define pud_page(pud)			phys_to_page(__pud_to_phys(pud))
 
 #else
 
+static inline bool pgtable_l3_enabled(void) { return false; }
+
 #define pud_valid(pud)		false
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
 #define pud_user_exec(pud)	pud_user(pud) /* Always 0 with folding */
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..527630f0803c6 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -92,6 +92,9 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
+	if (!pgtable_l3_enabled())
+		return;
+
 	pagetable_pmd_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e5618423bb99d..663cc76569a27 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1923,8 +1923,10 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 
 	if (levels == 5 && !pgtable_l5_enabled())
 		levels = 4;
-	else if (levels == 4 && !pgtable_l4_enabled())
+	if (levels == 4 && !pgtable_l4_enabled())
 		levels = 3;
+	if (levels == 3 && !pgtable_l3_enabled())
+		levels = 2;
 
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 248a2d7ad6dbb..146ecdaaaf647 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1370,12 +1370,11 @@ static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
 
 	pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
 
-#ifndef __PAGETABLE_PMD_FOLDED
-	if ((hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
+	if (pgtable_l3_enabled() &&
+	    (hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
 	    ALIGN_DOWN(hva, PUD_SIZE) >= vma->vm_start &&
 	    ALIGN(hva, PUD_SIZE) <= vma->vm_end)
 		return PUD_SHIFT;
-#endif
 
 	if ((hva & (PMD_SIZE - 1)) == (pa & (PMD_SIZE - 1)) &&
 	    ALIGN_DOWN(hva, PMD_SIZE) >= vma->vm_start &&
@@ -1487,12 +1486,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = get_vma_page_shift(vma, hva);
 	}
 
-#ifndef __PAGETABLE_PMD_FOLDED
-	if (vma_shift == PUD_SHIFT) {
+	if (pgtable_l3_enabled() && vma_shift == PUD_SHIFT) {
 		if (!fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
 			vma_shift = PMD_SHIFT;
 	}
-#endif
 	if (vma_shift == CONT_PMD_SHIFT) {
 		vma_shift = PMD_SHIFT;
 	}
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index a0dcf2375ccb4..f2c6678046a96 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -87,7 +87,7 @@ static void __init early_fixmap_init_pud(p4d_t *p4dp, unsigned long addr,
 	p4d_t p4d = READ_ONCE(*p4dp);
 	pud_t *pudp;
 
-	if (CONFIG_PGTABLE_LEVELS > 3 && !p4d_none(p4d) &&
+	if (ptg_pgtable_levels > 3 && !p4d_none(p4d) &&
 	    p4d_page_paddr(p4d) != __pa_symbol(bm_pud)) {
 		/*
 		 * We only end up here if the kernel mapping and the fixmap
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index bc98c20655bba..2add0839179e3 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -51,10 +51,9 @@ void __init arm64_hugetlb_cma_reserve(void)
 
 static bool __hugetlb_valid_size(unsigned long size)
 {
-#ifndef __PAGETABLE_PMD_FOLDED
-	if (size == PUD_SIZE)
+	if (pgtable_l3_enabled() && size == PUD_SIZE)
 		return pud_sect_supported();
-#endif
+
 	if (size == CONT_PMD_SIZE || size == PMD_SIZE || size == CONT_PTE_SIZE)
 		return true;
 
@@ -100,13 +99,10 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 
 	*pgsize = size;
 
-#ifndef __PAGETABLE_PMD_FOLDED
-	if (size == PUD_SIZE) {
+	if (pgtable_l3_enabled() && size == PUD_SIZE) {
 		if (pud_sect_supported())
 			contig_ptes = 1;
-	} else
-#endif
-	if (size == PMD_SIZE) {
+	} else if (size == PMD_SIZE) {
 		contig_ptes = 1;
 	} else if (size == CONT_PMD_SIZE) {
 		*pgsize = PMD_SIZE;
@@ -331,10 +327,8 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 {
 	unsigned long hp_size = huge_page_size(h);
 
-#ifndef __PAGETABLE_PMD_FOLDED
-	if (hp_size == PUD_SIZE)
+	if (pgtable_l3_enabled() && hp_size == PUD_SIZE)
 		return PGDIR_SIZE - PUD_SIZE;
-#endif
 	if (hp_size == CONT_PMD_SIZE)
 		return PUD_SIZE - CONT_PMD_SIZE;
 	if (hp_size == PMD_SIZE)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4d24034418b39..62587104f30d8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -396,7 +396,7 @@ void __init mem_init(void)
 	 * scratch using the virtual address range and page size.
 	 */
 	VM_BUG_ON(ARM64_HW_PGTABLE_LEVELS(CONFIG_ARM64_VA_BITS) !=
-		  CONFIG_PGTABLE_LEVELS);
+		  ptg_pgtable_levels);
 
 	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
 		extern int sysctl_overcommit_memory;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ad7fd3fda705a..b78a341cd9e70 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1046,7 +1046,7 @@ static void free_empty_pmd_table(pud_t *pudp, unsigned long addr,
 		free_empty_pte_table(pmdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 
-	if (CONFIG_PGTABLE_LEVELS <= 2)
+	if (!pgtable_l3_enabled())
 		return;
 
 	if (!pgtable_range_aligned(start, end, floor, ceiling, PUD_MASK))
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 6986827e0d645..045a4188afc10 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -230,7 +230,8 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 
 	/* check if the current level has been folded dynamically */
 	if ((level == 1 && mm_p4d_folded(st->mm)) ||
-	    (level == 2 && mm_pud_folded(st->mm)))
+	    (level == 2 && mm_pud_folded(st->mm)) ||
+	    (level == 3 && mm_pmd_folded(st->mm)))
 		level = 0;
 
 	if (level >= 0)
-- 
2.43.0


