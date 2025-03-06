Return-Path: <linux-arch+bounces-10553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3980A555F5
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CA81736A4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4249F270EBF;
	Thu,  6 Mar 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAhao/GT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256E26BDB3;
	Thu,  6 Mar 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287263; cv=none; b=f7i03WJvBh4PFmJLsppWJ6+VzLD0vjga7BztEhr4Kh0fwUNpFO6Utjh4WrAtQIm8RR0q+L4SIOu6RfEC7wVUGBj1PTizdl5T+wdU5oIr9fVSNx9Mo6hHexV53I3OPEt1EzSkzlZ8G5XhdYmwMdFcsAvBTC/lF7Snk1S+wurZh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287263; c=relaxed/simple;
	bh=V81Qe73ywRGOa4P4lYmmCebVskMbjgLcVHgS3/FNKb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li0TjYcO3JeKILMLjaNLPx/T035N4L93RKbXjwTxYYDPTqcdHNWiqPuRKfKROZ4cKTZtzuC3WZBFazGCFUH9jhx6Waa73tWhaO7LPOYvQCdtSqhE11g5y0ZXJnbfSwsjVUpxq5UMBXgppWckWFckjQjullDTXnEtE8P9Z9B1kJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAhao/GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38629C4CEEB;
	Thu,  6 Mar 2025 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287262;
	bh=V81Qe73ywRGOa4P4lYmmCebVskMbjgLcVHgS3/FNKb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAhao/GTaASroRPSjezNsogKfXXuvqmRVJI+/+lxYofZ0aHb7va4mm5DZz38ZXAPx
	 iZhsaGzSpPO/5oGJDT4jg6ck2Q1ItRjAc9wV2GCvcPzcGNOuUiHFOtJHFgRRARYn9l
	 WvNp0VppaXJtOmKXr9ljVB12Q364WscbA7MM0yQyKtoK5zArJ7MkcjlIHEAACk4t/n
	 Qd3Qxs6BKso9T8cQXLp3KTY4YALs2Y1rfn3giJLbxTgX5EVjcvqh0u/C+5H1PNqprm
	 zEkWaGLRDT1W7i4v6z/pQyo0g5j5YTy1Rf/Yjv2XHIXp7ENlt7cOKhhXFy3pvRDgpw
	 aHbo4bB0HWLnA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 12/13] arch, mm: introduce arch_mm_preinit
Date: Thu,  6 Mar 2025 20:51:22 +0200
Message-ID: <20250306185124.3147510-13-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Currently, implementation of mem_init() in every architecture consists of
one or more of the following:

* initializations that must run before page allocator is active, for
  instance swiotlb_init()
* a call to memblock_free_all() to release all the memory to the buddy
  allocator
* initializations that must run after page allocator is ready and there is
  no arch-specific hook other than mem_init() for that, like for example
  register_page_bootmem_info() in x86 and sparc64 or simple setting of
  mem_init_done = 1 in several architectures
* a bunch of semi-related stuff that apparently had no better place to
  live, for example a ton of BUILD_BUG_ON()s in parisc.

Introduce arch_mm_preinit() that will be the first thing called from
mm_core_init(). On architectures that have initializations that must happen
before the page allocator is ready, move those into arch_mm_preinit() along
with the code that does not depend on ordering with page allocator setup.

On several architectures this results in reduction of mem_init() to a
single call to memblock_free_all() that allows its consolidation next.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arc/mm/init.c      | 13 ++++++-------
 arch/arm/mm/init.c      | 21 ++++++++++++---------
 arch/arm64/mm/init.c    | 21 ++++++++++++---------
 arch/mips/mm/init.c     | 11 +++++++----
 arch/powerpc/mm/mem.c   |  9 ++++++---
 arch/riscv/mm/init.c    |  8 ++++++--
 arch/s390/mm/init.c     |  5 ++++-
 arch/sparc/mm/init_32.c |  5 ++++-
 arch/um/kernel/mem.c    |  7 +++++--
 arch/x86/mm/init_32.c   |  6 +++++-
 arch/x86/mm/init_64.c   |  5 ++++-
 include/linux/mm.h      |  1 +
 mm/mm_init.c            |  5 +++++
 13 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 11ce638731c9..90715b4a0bfa 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -157,11 +157,16 @@ void __init setup_arch_memory(void)
 	free_area_init(max_zone_pfn);
 }
 
-static void __init highmem_init(void)
+void __init arch_mm_preinit(void)
 {
 #ifdef CONFIG_HIGHMEM
 	memblock_phys_free(high_mem_start, high_mem_sz);
 #endif
+
+	BUILD_BUG_ON((PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE);
+	BUILD_BUG_ON((PTRS_PER_PUD * sizeof(pud_t)) > PAGE_SIZE);
+	BUILD_BUG_ON((PTRS_PER_PMD * sizeof(pmd_t)) > PAGE_SIZE);
+	BUILD_BUG_ON((PTRS_PER_PTE * sizeof(pte_t)) > PAGE_SIZE);
 }
 
 /*
@@ -172,13 +177,7 @@ static void __init highmem_init(void)
  */
 void __init mem_init(void)
 {
-	highmem_init();
 	memblock_free_all();
-
-	BUILD_BUG_ON((PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE);
-	BUILD_BUG_ON((PTRS_PER_PUD * sizeof(pud_t)) > PAGE_SIZE);
-	BUILD_BUG_ON((PTRS_PER_PMD * sizeof(pmd_t)) > PAGE_SIZE);
-	BUILD_BUG_ON((PTRS_PER_PTE * sizeof(pte_t)) > PAGE_SIZE);
 }
 
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7bb5ce02b9b5..7222100b0631 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -237,12 +237,7 @@ static inline void poison_init_mem(void *s, size_t count)
 		*p++ = 0xe7fddef0;
 }
 
-/*
- * mem_init() marks the free areas in the mem_map and tells us how much
- * memory is free.  This is done after various parts of the system have
- * claimed their memory after the kernel image.
- */
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 #ifdef CONFIG_ARM_LPAE
 	swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
@@ -253,9 +248,6 @@ void __init mem_init(void)
 	memblock_phys_free(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 #endif
 
-	/* this will put all unused low memory onto the freelists */
-	memblock_free_all();
-
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
 	 * be detected at build time already.
@@ -271,6 +263,17 @@ void __init mem_init(void)
 #endif
 }
 
+/*
+ * mem_init() marks the free areas in the mem_map and tells us how much
+ * memory is free.  This is done after various parts of the system have
+ * claimed their memory after the kernel image.
+ */
+void __init mem_init(void)
+{
+	/* this will put all unused low memory onto the freelists */
+	memblock_free_all();
+}
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 struct section_perm {
 	const char *name;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a48fcccd67fa..8eff6a6eb11e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -362,12 +362,7 @@ void __init bootmem_init(void)
 	memblock_dump_all();
 }
 
-/*
- * mem_init() marks the free areas in the mem_map and tells us how much memory
- * is free.  This is done after various parts of the system have claimed their
- * memory after the kernel image.
- */
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
@@ -391,9 +386,6 @@ void __init mem_init(void)
 	swiotlb_init(swiotlb, flags);
 	swiotlb_update_mem_attributes();
 
-	/* this will put all unused low memory onto the freelists */
-	memblock_free_all();
-
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
 	 * detected at build time already.
@@ -419,6 +411,17 @@ void __init mem_init(void)
 	}
 }
 
+/*
+ * mem_init() marks the free areas in the mem_map and tells us how much memory
+ * is free.  This is done after various parts of the system have claimed their
+ * memory after the kernel image.
+ */
+void __init mem_init(void)
+{
+	/* this will put all unused low memory onto the freelists */
+	memblock_free_all();
+}
+
 void free_initmem(void)
 {
 	void *lm_init_begin = lm_alias(__init_begin);
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index e7882874ba2f..619e2e394392 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -427,7 +427,7 @@ void __init paging_init(void)
 static struct kcore_list kcore_kseg0;
 #endif
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	/*
 	 * When PFN_PTE_SHIFT is greater than PAGE_SHIFT we won't have enough PTE
@@ -437,7 +437,6 @@ void __init mem_init(void)
 
 	maar_init();
 	setup_zero_pages();	/* Setup zeroed pages.  */
-	memblock_free_all();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
@@ -448,13 +447,17 @@ void __init mem_init(void)
 #endif
 }
 #else  /* CONFIG_NUMA */
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	setup_zero_pages();	/* This comes from node 0 */
-	memblock_free_all();
 }
 #endif /* !CONFIG_NUMA */
 
+void __init mem_init(void)
+{
+	memblock_free_all();
+}
+
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
 	unsigned long pfn;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1bc94bca9944..68efdaf14e58 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -273,7 +273,7 @@ void __init paging_init(void)
 	mark_nonram_nosave();
 }
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	/*
 	 * book3s is limited to 16 page sizes due to encoding this in
@@ -295,8 +295,6 @@ void __init mem_init(void)
 
 	kasan_late_init();
 
-	memblock_free_all();
-
 #if defined(CONFIG_PPC_E500) && !defined(CONFIG_SMP)
 	/*
 	 * If smp is enabled, next_tlbcam_idx is initialized in the cpu up
@@ -329,6 +327,11 @@ void __init mem_init(void)
 #endif /* CONFIG_PPC32 */
 }
 
+void __init mem_init(void)
+{
+	memblock_free_all();
+}
+
 void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ac6d41e86243..9efadabf6be1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -171,7 +171,7 @@ static void __init print_vm_layout(void)
 static void print_vm_layout(void) { }
 #endif /* CONFIG_DEBUG_VM */
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
 #ifdef CONFIG_FLATMEM
@@ -192,11 +192,15 @@ void __init mem_init(void)
 	}
 
 	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
-	memblock_free_all();
 
 	print_vm_layout();
 }
 
+void __init mem_init(void)
+{
+	memblock_free_all();
+}
+
 /* Limit the memory size via mem. */
 static phys_addr_t memory_limit;
 #ifdef CONFIG_XIP_KERNEL
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 08ebc9a9344a..6741b38fc864 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -156,7 +156,7 @@ static void pv_init(void)
 	swiotlb_update_mem_attributes();
 }
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
 	cpumask_set_cpu(0, mm_cpumask(&init_mm));
@@ -165,7 +165,10 @@ void __init mem_init(void)
 	kfence_split_mapping();
 
 	setup_zero_pages();	/* Setup zeroed pages. */
+}
 
+void __init mem_init(void)
+{
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
 }
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 043e9b6fadd0..e16c32c5728f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -232,7 +232,7 @@ static void __init taint_real_pages(void)
 	}
 }
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	int i;
 
@@ -262,7 +262,10 @@ void __init mem_init(void)
 	memset(sparc_valid_addr_bitmap, 0, i << 2);
 
 	taint_real_pages();
+}
 
+void __init mem_init(void)
+{
 	memblock_free_all();
 }
 
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index befed230aac2..cce387438e60 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -54,7 +54,7 @@ int kmalloc_ok = 0;
 /* Used during early boot */
 static unsigned long brk_end;
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
@@ -66,10 +66,13 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	max_pfn = max_low_pfn;
+}
 
+void __init mem_init(void)
+{
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-	max_pfn = max_low_pfn;
 	kmalloc_ok = 1;
 }
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 9ee8ec2bc5d1..16664c5464b5 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -691,13 +691,17 @@ static void __init test_wp_bit(void)
 	panic("Linux doesn't support CPUs with broken WP.");
 }
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	pci_iommu_alloc();
 
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif
+}
+
+void __init mem_init(void)
+{
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..f8981e29633c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1348,10 +1348,13 @@ static void __init preallocate_vmalloc_pages(void)
 	panic("Failed to pre-allocate %s pages for vmalloc area\n", lvl);
 }
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	pci_iommu_alloc();
+}
 
+void __init mem_init(void)
+{
 	/* clear_bss() already clear the empty_zero_page */
 
 	/* this will put all memory onto the freelists */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6fccd3b3248c..ae9cfb9612ea 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -42,6 +42,7 @@ struct folio_batch;
 
 extern int sysctl_page_lock_unfairness;
 
+void arch_mm_preinit(void);
 void mm_core_init(void);
 void init_mm_internals(void);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5e5f6ba73757..9cca3d497bf8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2668,11 +2668,16 @@ static void __init mem_init_print_info(void)
 		);
 }
 
+void __init __weak arch_mm_preinit(void)
+{
+}
+
 /*
  * Set up kernel memory allocators
  */
 void __init mm_core_init(void)
 {
+	arch_mm_preinit();
 	/* Initializations relying on SMP setup */
 	BUILD_BUG_ON(MAX_ZONELISTS > 2);
 	build_all_zonelists(NULL);
-- 
2.47.2


