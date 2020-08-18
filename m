Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBBE248937
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHRPS5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgHRPSu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 11:18:50 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F30A20882;
        Tue, 18 Aug 2020 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763928;
        bh=+7FiPEcgmORvEAotokCpYJjgB4evttBen+IqBIop8W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScbYqqw789PICEHmCAHnroINv9mBBxJqBPSrbeYV0cABCWMu1Uv4M/Yxjgn7NRE08
         ktuSUHln5yh709mlBOPSNDOZlJ/kccLyj5/tmTHTPpSOTfmdxaX31YIfsWQB/zBAad
         sCUx6/ruH0UaM1rAynDFQrqGHkw+lUgP4QEhMLro=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Axtens <dja@axtens.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: [PATCH v3 11/17] arch, mm: replace for_each_memblock() with for_each_mem_pfn_range()
Date:   Tue, 18 Aug 2020 18:16:28 +0300
Message-Id: <20200818151634.14343-12-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818151634.14343-1-rppt@kernel.org>
References: <20200818151634.14343-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are several occurrences of the following pattern:

	for_each_memblock(memory, reg) {
		start_pfn = memblock_region_memory_base_pfn(reg);
		end_pfn = memblock_region_memory_end_pfn(reg);

		/* do something with start_pfn and end_pfn */
	}

Rather than iterate over all memblock.memory regions and each time query
for their start and end PFNs, use for_each_mem_pfn_range() iterator to get
simpler and clearer code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/mm/init.c           | 11 ++++-------
 arch/arm64/mm/init.c         | 11 ++++-------
 arch/powerpc/kernel/fadump.c | 11 ++++++-----
 arch/powerpc/mm/mem.c        | 15 ++++++++-------
 arch/powerpc/mm/numa.c       |  7 ++-----
 arch/s390/mm/page-states.c   |  6 ++----
 arch/sh/mm/init.c            |  9 +++------
 mm/memblock.c                |  6 ++----
 mm/sparse.c                  | 10 ++++------
 9 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 50a5a30a78ff..45f9d5ec2360 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -299,16 +299,14 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
  */
 static void __init free_unused_memmap(void)
 {
-	unsigned long start, prev_end = 0;
-	struct memblock_region *reg;
+	unsigned long start, end, prev_end = 0;
+	int i;
 
 	/*
 	 * This relies on each bank being in address order.
 	 * The banks are sorted previously in bootmem_init().
 	 */
-	for_each_memblock(memory, reg) {
-		start = memblock_region_memory_base_pfn(reg);
-
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
 #ifdef CONFIG_SPARSEMEM
 		/*
 		 * Take care not to free memmap entries that don't exist
@@ -336,8 +334,7 @@ static void __init free_unused_memmap(void)
 		 * memmap entries are valid from the bank end aligned to
 		 * MAX_ORDER_NR_PAGES.
 		 */
-		prev_end = ALIGN(memblock_region_memory_end_pfn(reg),
-				 MAX_ORDER_NR_PAGES);
+		prev_end = ALIGN(end, MAX_ORDER_NR_PAGES);
 	}
 
 #ifdef CONFIG_SPARSEMEM
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 481d22c32a2e..f0bf86d81622 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -471,12 +471,10 @@ static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
  */
 static void __init free_unused_memmap(void)
 {
-	unsigned long start, prev_end = 0;
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg) {
-		start = __phys_to_pfn(reg->base);
+	unsigned long start, end, prev_end = 0;
+	int i;
 
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
 #ifdef CONFIG_SPARSEMEM
 		/*
 		 * Take care not to free memmap entries that don't exist due
@@ -496,8 +494,7 @@ static void __init free_unused_memmap(void)
 		 * memmap entries are valid from the bank end aligned to
 		 * MAX_ORDER_NR_PAGES.
 		 */
-		prev_end = ALIGN(__phys_to_pfn(reg->base + reg->size),
-				 MAX_ORDER_NR_PAGES);
+		prev_end = ALIGN(end, MAX_ORDER_NR_PAGES);
 	}
 
 #ifdef CONFIG_SPARSEMEM
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 10ebb4bf71ad..e469b150be21 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1242,14 +1242,15 @@ static void fadump_free_reserved_memory(unsigned long start_pfn,
  */
 static void fadump_release_reserved_area(u64 start, u64 end)
 {
-	u64 tstart, tend, spfn, epfn;
-	struct memblock_region *reg;
+	u64 tstart, tend, spfn, epfn, reg_spfn, reg_epfn, i;
 
 	spfn = PHYS_PFN(start);
 	epfn = PHYS_PFN(end);
-	for_each_memblock(memory, reg) {
-		tstart = max_t(u64, spfn, memblock_region_memory_base_pfn(reg));
-		tend   = min_t(u64, epfn, memblock_region_memory_end_pfn(reg));
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &reg_spfn, &reg_epfn, NULL) {
+		tstart = max_t(u64, spfn, reg_spfn);
+		tend   = min_t(u64, epfn, reg_epfn);
+
 		if (tstart < tend) {
 			fadump_free_reserved_memory(tstart, tend);
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 42e25874f5a8..80df329f180e 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -184,15 +184,16 @@ void __init initmem_init(void)
 /* mark pages that don't exist as nosave */
 static int __init mark_nonram_nosave(void)
 {
-	struct memblock_region *reg, *prev = NULL;
+	unsigned long spfn, epfn, prev = 0;
+	int i;
 
-	for_each_memblock(memory, reg) {
-		if (prev &&
-		    memblock_region_memory_end_pfn(prev) < memblock_region_memory_base_pfn(reg))
-			register_nosave_region(memblock_region_memory_end_pfn(prev),
-					       memblock_region_memory_base_pfn(reg));
-		prev = reg;
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &spfn, &epfn, NULL) {
+		if (prev && prev < spfn)
+			register_nosave_region(prev, spfn);
+
+		prev = epfn;
 	}
+
 	return 0;
 }
 #else /* CONFIG_NEED_MULTIPLE_NODES */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 1f61fa2148b5..f4e20d8e6c02 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -804,17 +804,14 @@ static void __init setup_nonnuma(void)
 	unsigned long total_ram = memblock_phys_mem_size();
 	unsigned long start_pfn, end_pfn;
 	unsigned int nid = 0;
-	struct memblock_region *reg;
+	int i;
 
 	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
 
-	for_each_memblock(memory, reg) {
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
-
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
 		fake_numa_create_new_node(end_pfn, &nid);
 		memblock_set_node(PFN_PHYS(start_pfn),
 				  PFN_PHYS(end_pfn - start_pfn),
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index fc141893d028..567c69f3069e 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -183,9 +183,9 @@ static void mark_kernel_pgd(void)
 
 void __init cmma_init_nodat(void)
 {
-	struct memblock_region *reg;
 	struct page *page;
 	unsigned long start, end, ix;
+	int i;
 
 	if (cmma_flag < 2)
 		return;
@@ -193,9 +193,7 @@ void __init cmma_init_nodat(void)
 	mark_kernel_pgd();
 
 	/* Set all kernel pages not used for page tables to stable/no-dat */
-	for_each_memblock(memory, reg) {
-		start = memblock_region_memory_base_pfn(reg);
-		end = memblock_region_memory_end_pfn(reg);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
 		page = pfn_to_page(start);
 		for (ix = start; ix < end; ix++, page++) {
 			if (__test_and_clear_bit(PG_arch_1, &page->flags))
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4735176ab811..3348e0c4d769 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -226,15 +226,12 @@ void __init allocate_pgdat(unsigned int nid)
 
 static void __init do_init_bootmem(void)
 {
-	struct memblock_region *reg;
+	unsigned long start_pfn, end_pfn;
+	int i;
 
 	/* Add active regions with valid PFNs. */
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn, end_pfn;
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL)
 		__add_active_range(0, start_pfn, end_pfn);
-	}
 
 	/* All of system RAM sits in node 0 for the non-NUMA case */
 	allocate_pgdat(0);
diff --git a/mm/memblock.c b/mm/memblock.c
index 799513f3d6a9..567e454ce0a1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1660,12 +1660,10 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 phys_addr_t __init memblock_mem_size(unsigned long limit_pfn)
 {
 	unsigned long pages = 0;
-	struct memblock_region *r;
 	unsigned long start_pfn, end_pfn;
+	int i;
 
-	for_each_memblock(memory, r) {
-		start_pfn = memblock_region_memory_base_pfn(r);
-		end_pfn = memblock_region_memory_end_pfn(r);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
 		start_pfn = min_t(unsigned long, start_pfn, limit_pfn);
 		end_pfn = min_t(unsigned long, end_pfn, limit_pfn);
 		pages += end_pfn - start_pfn;
diff --git a/mm/sparse.c b/mm/sparse.c
index fcc3d176f1ea..b25ad8e64839 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -291,13 +291,11 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
  */
 static void __init memblocks_present(void)
 {
-	struct memblock_region *reg;
+	unsigned long start, end;
+	int i, nid;
 
-	for_each_memblock(memory, reg) {
-		memory_present(memblock_get_region_node(reg),
-			       memblock_region_memory_base_pfn(reg),
-			       memblock_region_memory_end_pfn(reg));
-	}
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
+		memory_present(nid, start, end);
 }
 
 /*
-- 
2.26.2

