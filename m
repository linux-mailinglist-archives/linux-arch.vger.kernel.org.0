Return-Path: <linux-arch+bounces-11327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2BA7FAF3
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DAE189A16B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9DA26E148;
	Tue,  8 Apr 2025 09:53:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0E26772C;
	Tue,  8 Apr 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106035; cv=none; b=b6/8MUoLTDf45YXHmPlj/ygi5lou19xnwadzkGuS28qHLyK5yhcwHRMtrp9hTbM+8G1RF1RvQSXCi3NQUKN9Y3pAXKLlcq4gc2VgfsbaSLr4L5WQiBqdOZ66oT2Sm49ipZADI7YTqsB5y3PyW6Fa3mIGn+wZsTsuRcR6fvf/P3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106035; c=relaxed/simple;
	bh=6kjKXHXbhvBMXvy4g/euZFA2lZRoKizvPFulVhiYDHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o46QbBiVtWgTj7S+/WKpnRPQkXe0HOFyQ6hRLrwwLwBh66V0uDeXDkgg1sNvQYS9QIZTDsASqsFeOdvmhVTYeFv6oVleUBwd2d+KnJifATYDbPV4Y9KP+NfetAwLcItTO3MGWg9Ail1r0cIFNvDW+G8u2X/lKp0O/T5x0wdrcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D9F1691;
	Tue,  8 Apr 2025 02:53:53 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64C983F6A8;
	Tue,  8 Apr 2025 02:53:48 -0700 (PDT)
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
Subject: [PATCH v2 09/12] arm64: mm: Always call PTE/PMD ctor in __create_pgd_mapping()
Date: Tue,  8 Apr 2025 10:52:19 +0100
Message-ID: <20250408095222.860601-10-kevin.brodsky@arm.com>
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

TL;DR: always call the PTE/PMD ctor, passing the appropriate mm to
skip ptlock_init() if unneeded.

__create_pgd_mapping() is used for creating different kinds of
mappings, and may allocate page table pages if passed an allocator
callback. There are currently three such cases:

1. create_pgd_mapping(), which is used to create the EFI mapping
2. arch_add_memory()
3. map_entry_trampoline()

1. uses pgd_pgtable_alloc() as allocator callback, which calls the
PTE/PMD ctor, while 2. and 3. use __pgd_pgtable_alloc(), which does
not. The rationale is most likely that pgtables associated with
init_mm do not make use of split page table locks, and it is
therefore unnecessary to initialise them by calling the ctor. 2.
operates on swapper_pg_dir so the allocated pgtables are clearly
associated with init_mm, this is arguably the case for 3. too (the
trampoline mapping is never modified so ptlocks are anyway
irrelevant). 1. corresponds to efi_mm so ptlocks need to be
initialised in that case.

We are now moving towards calling the ctor for all page tables, even
those associated with init_mm. pagetable_{pte,pmd}_ctor() have
become aware of the associated mm so that the ptlock initialisation
can be skipped for init_mm. This patch therefore amends the
allocator callbacks so that the PTE/PMD ctor are always called, with
an appropriate mm pointer to avoid unnecessary ptlock overhead.

Modifying the prototype of the allocator callbacks to take the mm
and propagating that pointer all the way down would be pretty
invasive. Instead:

* __pgd_pgtable_alloc() (cases 2. and 3. above) is replaced with
  pgd_pgtable_alloc_init_mm(), resulting in the ctors being called
  with &init_mm. This is the main functional change in this patch;
  the ptlock still isn't initialised, but other ctor actions (e.g.
  accounting-related) are now carried out for those allocated
  pgtables.

* pgd_pgtable_alloc() (case 1. above) is replaced with
  pgd_pgtable_alloc_special_mm(), resulting in the ctors being
  called with NULL as mm. No functional change here; NULL
  essentially means "not init_mm", and the ptlock is still
  initialised.

__pgd_pgtable_alloc() is now the common implementation of those two
helpers. While at it we switch it to using pagetable_alloc() like
standard pgtable allocator functions and remove the comment
regarding ctor calls (ctors are now always expected to be called).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/mmu.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index eca324b3a6fc..51cfc891f6a1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -480,31 +480,22 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 			     int flags);
 #endif
 
-static phys_addr_t __pgd_pgtable_alloc(enum pgtable_type pgtable_type)
+static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
+				       enum pgtable_type pgtable_type)
 {
 	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
-	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
+	phys_addr_t pa;
 
-	BUG_ON(!ptr);
-	return __pa(ptr);
-}
-
-static phys_addr_t pgd_pgtable_alloc(enum pgtable_type pgtable_type)
-{
-	phys_addr_t pa = __pgd_pgtable_alloc(pgtable_type);
-	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
+	BUG_ON(!ptdesc);
+	pa = page_to_phys(ptdesc_page(ptdesc));
 
-	/*
-	 * Call proper page table ctor in case later we need to
-	 * call core mm functions like apply_to_page_range() on
-	 * this pre-allocated page table.
-	 */
 	switch (pgtable_type) {
 	case TABLE_PTE:
-		BUG_ON(!pagetable_pte_ctor(NULL, ptdesc));
+		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
 		break;
 	case TABLE_PMD:
-		BUG_ON(!pagetable_pmd_ctor(NULL, ptdesc));
+		BUG_ON(!pagetable_pmd_ctor(mm, ptdesc));
 		break;
 	default:
 		break;
@@ -513,6 +504,18 @@ static phys_addr_t pgd_pgtable_alloc(enum pgtable_type pgtable_type)
 	return pa;
 }
 
+static phys_addr_t __maybe_unused
+pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
+{
+	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
+}
+
+static phys_addr_t
+pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
+{
+	return __pgd_pgtable_alloc(NULL, pgtable_type);
+}
+
 /*
  * This function can only be used to modify existing table entries,
  * without allocating new levels of table. Note that this permits the
@@ -542,7 +545,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
-			     pgd_pgtable_alloc, flags);
+			     pgd_pgtable_alloc_special_mm, flags);
 }
 
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
@@ -756,7 +759,7 @@ static int __init map_entry_trampoline(void)
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
 			     entry_tramp_text_size(), prot,
-			     __pgd_pgtable_alloc, NO_BLOCK_MAPPINGS);
+			     pgd_pgtable_alloc_init_mm, NO_BLOCK_MAPPINGS);
 
 	/* Map both the text and data into the kernel page table */
 	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++)
@@ -1362,7 +1365,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, params->pgprot, __pgd_pgtable_alloc,
+			     size, params->pgprot, pgd_pgtable_alloc_init_mm,
 			     flags);
 
 	memblock_clear_nomap(start, size);
-- 
2.47.0


