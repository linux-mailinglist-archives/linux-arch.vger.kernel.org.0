Return-Path: <linux-arch+bounces-10734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50DA5F705
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A8E3BEF6A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAB267F69;
	Thu, 13 Mar 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5/3dO7R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A5267B76;
	Thu, 13 Mar 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873984; cv=none; b=u7R9jslS1CcuU/waQJu67+ghfcu80xIS92seZPQzOGl2tlF6/st46rK/nfqRMHnrECQEkTK4HWng9O64LipjdWGobyy/BCvzY4YpqlroWH8rR/eZjO3T9GzwW48psStTDMow7kw3y2OEf3k5IevzuuQ/Q0iFN2imcXcmKuPbw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873984; c=relaxed/simple;
	bh=C+AHAJsoq/CElDMotSWswPqQspDl7apHN1ae7G8sVnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFGGz7jPXgtlP8bcidOusfOTpMz3nzjn7AG5WV0eCyDoATbr+WEz5iNaG5A9R9yBvO5hAn7VI1uKLCob+M3CrC6pgYkgiY2ge0PzEcqK+wuoXpfyKxOLKFCTNDO6w6I4E4Vz4dx9HtlUaYaxHwByt1bM2o3z9wLb+kfKch88JXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5/3dO7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03614C4CEEF;
	Thu, 13 Mar 2025 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873983;
	bh=C+AHAJsoq/CElDMotSWswPqQspDl7apHN1ae7G8sVnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5/3dO7R0xxdVlL801+o40v1bhSr2MBgtqj74nZK5xnDeGTvt+lSB5M84qPJsUGET
	 WulB/xP3RTusR9zaj1PXZK7GwEqkedaal//3W4CYu9gEBDmAdkXAUXy3/yKX10+4EM
	 lPJ1yvODu6pOmhKMFIAO76igp+HVhLn59wVlchbpdXb16o8sefVXcQa/B6Ft6lwpuC
	 DJcQO6diSwpJZCL6cBiVU0po44wpc2oIsNDCZ+XK0DDDe9NxfPYCBX5ZWbnXF+dNSl
	 xhEjE+dTXUCRyRJGZNAylSR6LM3durp3pz91MIGeA9XKFa+3gy00WNRc122dA+Nrfu
	 xT1WD7oR+tcqg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
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
	Mark Brown <broonie@kernel.org>,
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
Subject: [PATCH v2 12/13] arch, mm: introduce arch_mm_preinit
Date: Thu, 13 Mar 2025 15:50:02 +0200
Message-ID: <20250313135003.836600-13-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
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

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>	# x86
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
index 075177e817ac..eec38e7735dd 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -425,7 +425,7 @@ void __init paging_init(void)
 static struct kcore_list kcore_kseg0;
 #endif
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	/*
 	 * When PFN_PTE_SHIFT is greater than PAGE_SHIFT we won't have enough PTE
@@ -435,7 +435,6 @@ void __init mem_init(void)
 
 	maar_init();
 	setup_zero_pages();	/* Setup zeroed pages.  */
-	memblock_free_all();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
@@ -446,13 +445,17 @@ void __init mem_init(void)
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
index 0c485884d373..c496dfa48bdc 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -154,7 +154,7 @@ static void pv_init(void)
 	swiotlb_update_mem_attributes();
 }
 
-void __init mem_init(void)
+void __init arch_mm_preinit(void)
 {
 	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
 	cpumask_set_cpu(0, mm_cpumask(&init_mm));
@@ -163,7 +163,10 @@ void __init mem_init(void)
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
index 61ac0cea711a..57f762c16c02 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2675,11 +2675,16 @@ static void __init mem_init_print_info(void)
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


