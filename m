Return-Path: <linux-arch+bounces-11319-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5EA7FACF
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190FB19E25C1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F426A1B6;
	Tue,  8 Apr 2025 09:53:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2BD26A0FA;
	Tue,  8 Apr 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105997; cv=none; b=oOd4QsDEhYfoWj4phG1bhoQGnuv0r3w4e8dW1hM8T/jsfT6vjgxYNSQOAxawwLqZKhTNCBFd7GLhL3f+bw4G1H28MbUdqfxbQqGLpfNJUpg8XWyRbR3N6LnLkjRtOjdMBB9zZufL9PzpadZeQ+XCYNs9wOcqonssixawXoyVle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105997; c=relaxed/simple;
	bh=9COnY9MgMYvWeHxVeJt5wo7kY5HaPYC+gDNPQHXKBbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4A27ErlOgTBZGsKidSGSFTBzSo7zJjGIxbWyB62mqZ8uyEFd4gzlluz8DkQIoUvfGPhTneKOKr6yb0Rw31xOTC5gBAo4bdKb5Q5aROxD2gCLGNtENkNLtFw1sAUWxKC0z9e7G62cGmwbuG6qJGbZ5IlmalYdyQAb9c58oYc60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 021EA1691;
	Tue,  8 Apr 2025 02:53:16 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98B8B3F6A8;
	Tue,  8 Apr 2025 02:53:10 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 01/12] mm: Pass mm down to pagetable_{pte,pmd}_ctor
Date: Tue,  8 Apr 2025 10:52:11 +0100
Message-ID: <20250408095222.860601-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408095222.860601-1-kevin.brodsky@arm.com>
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for calling constructors for all kernel page tables
while eliding unnecessary ptlock initialisation, let's pass down the
associated mm to the PTE/PMD level ctors. (These are the two levels
where ptlocks are used.)

In most cases the mm is already around at the point of calling the
ctor so we simply pass it down. This is however not the case for
special page table allocators:

* arch/arm/mm/mmu.c
* arch/arm64/mm/mmu.c
* arch/riscv/mm/init.c

In those cases, the page tables being allocated are either for
standard kernel memory (init_mm) or special page directories, which
may not be associated to any mm. For now let's pass NULL as mm; this
will be refined where possible in future patches.

No functional change in this patch.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/mm/mmu.c                        |  2 +-
 arch/arm64/mm/mmu.c                      |  4 ++--
 arch/loongarch/include/asm/pgalloc.h     |  2 +-
 arch/m68k/include/asm/mcf_pgalloc.h      |  2 +-
 arch/m68k/include/asm/motorola_pgalloc.h | 10 +++++-----
 arch/m68k/mm/motorola.c                  |  6 +++---
 arch/mips/include/asm/pgalloc.h          |  2 +-
 arch/parisc/include/asm/pgalloc.h        |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c       |  2 +-
 arch/powerpc/mm/pgtable-frag.c           |  2 +-
 arch/riscv/mm/init.c                     |  4 ++--
 arch/s390/include/asm/pgalloc.h          |  2 +-
 arch/s390/mm/pgalloc.c                   |  2 +-
 arch/sparc/mm/init_64.c                  |  2 +-
 arch/sparc/mm/srmmu.c                    |  2 +-
 arch/x86/mm/pgtable.c                    |  2 +-
 include/asm-generic/pgalloc.h            |  4 ++--
 include/linux/mm.h                       |  6 ++++--
 18 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f02f872ea8a9..edb7f56b7c91 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -735,7 +735,7 @@ static void *__init late_alloc(unsigned long sz)
 	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM,
 			get_order(sz));
 
-	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
+	if (!ptdesc || !pagetable_pte_ctor(NULL, ptdesc))
 		BUG();
 	return ptdesc_to_virt(ptdesc);
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ea6695d53fb9..8c5c471cfb06 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -494,9 +494,9 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 	 * folded, and if so pagetable_pte_ctor() becomes nop.
 	 */
 	if (shift == PAGE_SHIFT)
-		BUG_ON(!pagetable_pte_ctor(ptdesc));
+		BUG_ON(!pagetable_pte_ctor(NULL, ptdesc));
 	else if (shift == PMD_SHIFT)
-		BUG_ON(!pagetable_pmd_ctor(ptdesc));
+		BUG_ON(!pagetable_pmd_ctor(NULL, ptdesc));
 
 	return pa;
 }
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index b58f587f0f0a..1c63a9d9a6d3 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -69,7 +69,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	if (!ptdesc)
 		return NULL;
 
-	if (!pagetable_pmd_ctor(ptdesc)) {
+	if (!pagetable_pmd_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 4c648b51e7fd..465a71101b7d 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -48,7 +48,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pte_ctor(ptdesc)) {
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index 5abe7da8ac5a..1091fb0affbe 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -15,7 +15,7 @@ enum m68k_table_types {
 };
 
 extern void init_pointer_table(void *table, int type);
-extern void *get_pointer_table(int type);
+extern void *get_pointer_table(struct mm_struct *mm, int type);
 extern int free_pointer_table(void *table, int type);
 
 /*
@@ -26,7 +26,7 @@ extern int free_pointer_table(void *table, int type);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return get_pointer_table(TABLE_PTE);
+	return get_pointer_table(mm, TABLE_PTE);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -36,7 +36,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return get_pointer_table(TABLE_PTE);
+	return get_pointer_table(mm, TABLE_PTE);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
@@ -53,7 +53,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return get_pointer_table(TABLE_PMD);
+	return get_pointer_table(mm, TABLE_PMD);
 }
 
 static inline int pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -75,7 +75,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return get_pointer_table(TABLE_PGD);
+	return get_pointer_table(mm, TABLE_PGD);
 }
 
 
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 73651e093c4d..6ab3ef39ba7a 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -139,7 +139,7 @@ void __init init_pointer_table(void *table, int type)
 	return;
 }
 
-void *get_pointer_table(int type)
+void *get_pointer_table(struct mm_struct *mm, int type)
 {
 	ptable_desc *dp = ptable_list[type].next;
 	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
@@ -164,10 +164,10 @@ void *get_pointer_table(int type)
 			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
 			 * SMP.
 			 */
-			pagetable_pte_ctor(virt_to_ptdesc(page));
+			pagetable_pte_ctor(mm, virt_to_ptdesc(page));
 			break;
 		case TABLE_PMD:
-			pagetable_pmd_ctor(virt_to_ptdesc(page));
+			pagetable_pmd_ctor(mm, virt_to_ptdesc(page));
 			break;
 		case TABLE_PGD:
 			pagetable_pgd_ctor(virt_to_ptdesc(page));
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index bbca420c96d3..942af87f1cdd 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -62,7 +62,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	if (!ptdesc)
 		return NULL;
 
-	if (!pagetable_pmd_ctor(ptdesc)) {
+	if (!pagetable_pmd_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 2ca74a56415c..3b84ee93edaa 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -39,7 +39,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	ptdesc = pagetable_alloc(gfp, PMD_TABLE_ORDER);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pmd_ctor(ptdesc)) {
+	if (!pagetable_pmd_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 8f7d41ce2ca1..a282233c8785 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -422,7 +422,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pmd_ctor(ptdesc)) {
+	if (!pagetable_pmd_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 713268ccb1a0..387e9b1fe12c 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -61,7 +61,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 		ptdesc = pagetable_alloc(PGALLOC_GFP | __GFP_ACCOUNT, 0);
 		if (!ptdesc)
 			return NULL;
-		if (!pagetable_pte_ctor(ptdesc)) {
+		if (!pagetable_pte_ctor(mm, ptdesc)) {
 			pagetable_free(ptdesc);
 			return NULL;
 		}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ab475ec6ca42..e5ef693fc778 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -442,7 +442,7 @@ static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	BUG_ON(!ptdesc || !pagetable_pte_ctor(ptdesc));
+	BUG_ON(!ptdesc || !pagetable_pte_ctor(NULL, ptdesc));
 	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
@@ -522,7 +522,7 @@ static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	BUG_ON(!ptdesc || !pagetable_pmd_ctor(ptdesc));
+	BUG_ON(!ptdesc || !pagetable_pmd_ctor(NULL, ptdesc));
 	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 005497ffebda..5345398df653 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -97,7 +97,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 	if (!table)
 		return NULL;
 	crst_table_init(table, _SEGMENT_ENTRY_EMPTY);
-	if (!pagetable_pmd_ctor(virt_to_ptdesc(table))) {
+	if (!pagetable_pmd_ctor(mm, virt_to_ptdesc(table))) {
 		crst_table_free(mm, table);
 		return NULL;
 	}
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index e3a6f8ae156c..619d6917e3b7 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -145,7 +145,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pte_ctor(ptdesc)) {
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 760818950464..5c8eabda1d17 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2895,7 +2895,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pte_ctor(ptdesc)) {
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index dd32711022f5..f8fb4911d360 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -350,7 +350,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_inc_return(page) == 2 &&
-			!pagetable_pte_ctor(page_ptdesc(page))) {
+			!pagetable_pte_ctor(mm, page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a05fcddfc811..7930f234c5f6 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -205,7 +205,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 
 		if (!ptdesc)
 			failed = true;
-		if (ptdesc && !pagetable_pmd_ctor(ptdesc)) {
+		if (ptdesc && !pagetable_pmd_ctor(mm, ptdesc)) {
 			pagetable_free(ptdesc);
 			ptdesc = NULL;
 			failed = true;
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 892ece4558a2..e164ca66f0f6 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -70,7 +70,7 @@ static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
 	ptdesc = pagetable_alloc_noprof(gfp, 0);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pte_ctor(ptdesc)) {
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
@@ -137,7 +137,7 @@ static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
 	ptdesc = pagetable_alloc_noprof(gfp, 0);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pmd_ctor(ptdesc)) {
+	if (!pagetable_pmd_ctor(mm, ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954..f9b793cce2c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3100,7 +3100,8 @@ static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
 	pagetable_free(ptdesc);
 }
 
-static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_pte_ctor(struct mm_struct *mm,
+				      struct ptdesc *ptdesc)
 {
 	if (!ptlock_init(ptdesc))
 		return false;
@@ -3206,7 +3207,8 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
+				      struct ptdesc *ptdesc)
 {
 	if (!pmd_ptlock_init(ptdesc))
 		return false;
-- 
2.47.0


