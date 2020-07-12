Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9E21C819
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jul 2020 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGLIbl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 04:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgGLIbk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Jul 2020 04:31:40 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60E020720;
        Sun, 12 Jul 2020 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594542699;
        bh=vY+bMpccFFRmu340eVDf3/CNzfZoMirie9qqpt1QEHk=;
        h=From:To:Cc:Subject:Date:From;
        b=nPbxbP+BxElKxEAnb+9q14JdpYvZTIikTifr9DCGaDI3C9+/J4cj+ndxIsSVopfqj
         4/ddqi/NoL9ZIKvFlWOAC7vzzqd7r3O8DQ5fcXyoL8sK9Yhj9m3Nem7NJnWQXceUkQ
         Kb+AJZQ5bO/YdiPjtrnZjxT1ho4KuZCtyR/pL2B4=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm/sparse: cleanup the code surrounding memory_present()
Date:   Sun, 12 Jul 2020 11:31:30 +0300
Message-Id: <20200712083130.22919-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP we have two equivalent
functions that call memory_present() for each region in memblock.memory:
sparse_memory_present_with_active_regions() and membocks_present().

Moreover, all architectures have a call to either of these functions
preceding the call to sparse_init() and in the most cases they are called
one after the other.

Mark the regions from memblock.memory as present during sparce_init() by
making sparse_init() call memblocks_present(), make memblocks_present() and
memory_present() functions static and remove redundant
sparse_memory_present_with_active_regions() function.

Also remove no longer required HAVE_MEMORY_PRESENT configuration option.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
Hi,

The changes here are trivial so I've trimmed the spam list this time.

--
Sincerely yours,
Mike.

 Documentation/vm/memory-model.rst |  7 ++-----
 arch/arm/mm/init.c                |  9 ++-------
 arch/arm64/mm/init.c              |  6 ++----
 arch/ia64/mm/discontig.c          |  1 -
 arch/microblaze/mm/init.c         |  3 ---
 arch/mips/kernel/setup.c          |  8 --------
 arch/mips/loongson64/numa.c       |  1 -
 arch/mips/sgi-ip27/ip27-memory.c  |  2 --
 arch/parisc/mm/init.c             |  5 -----
 arch/powerpc/mm/mem.c             |  2 --
 arch/powerpc/mm/numa.c            |  1 -
 arch/riscv/mm/init.c              |  1 -
 arch/s390/mm/init.c               |  1 -
 arch/sh/mm/init.c                 |  6 ------
 arch/sh/mm/numa.c                 |  3 ---
 arch/sparc/mm/init_64.c           |  1 -
 arch/x86/mm/init_32.c             |  2 --
 arch/x86/mm/init_64.c             |  1 -
 include/linux/mm.h                |  4 ----
 include/linux/mmzone.h            | 14 --------------
 mm/Kconfig                        |  6 +-----
 mm/page_alloc.c                   | 16 ----------------
 mm/sparse.c                       | 20 ++++++++++++--------
 23 files changed, 19 insertions(+), 101 deletions(-)

diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
index 91228044ed16..c6d77a5ae64b 100644
--- a/Documentation/vm/memory-model.rst
+++ b/Documentation/vm/memory-model.rst
@@ -141,11 +141,8 @@ sections:
   `mem_section` objects and the number of rows is calculated to fit
   all the memory sections.
 
-The architecture setup code should call :c:func:`memory_present` for
-each active memory range or use :c:func:`memblocks_present` or
-:c:func:`sparse_memory_present_with_active_regions` wrappers to
-initialize the memory sections. Next, the actual memory maps should be
-set up using :c:func:`sparse_init`.
+The architecture setup code should call sparse_init() to
+initialize the memory sections and the memory maps.
 
 With SPARSEMEM there are two possible ways to convert a PFN to the
 corresponding `struct page` - a "classic sparse" and "sparse
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 01e18e43b174..000c1b48e973 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -243,13 +243,8 @@ void __init bootmem_init(void)
 		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
 
 	/*
-	 * Sparsemem tries to allocate bootmem in memory_present(),
-	 * so must be done after the fixed reservations
-	 */
-	memblocks_present();
-
-	/*
-	 * sparse_init() needs the bootmem allocator up and running.
+	 * sparse_init() tries to allocate memory from memblock, so must be
+	 * done after the fixed reservations
 	 */
 	sparse_init();
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..2fa9adf975db 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -430,11 +430,9 @@ void __init bootmem_init(void)
 #endif
 
 	/*
-	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
-	 * done after the fixed reservations.
+	 * sparse_init() tries to allocate memory from memblock, so must be
+	 * done after the fixed reservations
 	 */
-	memblocks_present();
-
 	sparse_init();
 	zone_sizes_init(min, max);
 
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index dd8284bcbf16..680855a042fb 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -601,7 +601,6 @@ void __init paging_init(void)
 
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 521b59ba716c..0880a003573d 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -172,9 +172,6 @@ void __init setup_memory(void)
 				  &memblock.memory, 0);
 	}
 
-	/* XXX need to clip this if using highmem? */
-	sparse_memory_present_with_active_regions(0);
-
 	paging_init();
 }
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 7b537fa2035d..29fb0456c342 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -371,14 +371,6 @@ static void __init bootmem_init(void)
 #endif
 	}
 
-
-	/*
-	 * In any case the added to the memblock memory regions
-	 * (highmem/lowmem, available/reserved, etc) are considered
-	 * as present, so inform sparsemem about them.
-	 */
-	memblocks_present();
-
 	/*
 	 * Reserve initrd memory if needed.
 	 */
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 901f5be5ee76..ea8bb1bc667e 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -220,7 +220,6 @@ static __init void prom_meminit(void)
 			cpumask_clear(&__node_cpumask[node]);
 		}
 	}
-	memblocks_present();
 	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
 
 	for (cpu = 0; cpu < loongson_sysconf.nr_cpus; cpu++) {
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 1213215ea965..d411e0a90a5b 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -402,8 +402,6 @@ void __init prom_meminit(void)
 		}
 		__node_data[node] = &null_node;
 	}
-
-	memblocks_present();
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 48d628a1a0af..01d27f265701 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -689,11 +689,6 @@ void __init paging_init(void)
 	flush_cache_all_local(); /* start with known state */
 	flush_tlb_all_local(NULL);
 
-	/*
-	 * Mark all memblocks as present for sparsemem using
-	 * memory_present() and then initialize sparsemem.
-	 */
-	memblocks_present();
 	sparse_init();
 	parisc_bootmem_free();
 }
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c2c11eb8dcfc..ad28c353146d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -184,8 +184,6 @@ void __init mem_topology_setup(void)
 
 void __init initmem_init(void)
 {
-	/* XXX need to clip this if using highmem? */
-	sparse_memory_present_with_active_regions(0);
 	sparse_init();
 }
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9fcf2d195830..03a81d65095b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -949,7 +949,6 @@ void __init initmem_init(void)
 
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 		setup_node_data(nid, start_pfn, end_pfn);
-		sparse_memory_present_with_active_regions(nid);
 	}
 
 	sparse_init();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f4adb3684f3d..1486b9af9398 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -520,7 +520,6 @@ void mark_rodata_ro(void)
 void __init paging_init(void)
 {
 	setup_vm_final();
-	memblocks_present();
 	sparse_init();
 	setup_zero_page();
 	zone_sizes_init();
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 6dc7c3b60ef6..0d282081dc1f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -115,7 +115,6 @@ void __init paging_init(void)
 	__load_psw_mask(psw.mask);
 	kasan_free_early_identity();
 
-	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 	zone_dma_bits = 31;
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a70ba0fdd0b3..62b8f03ffc80 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -240,12 +240,6 @@ static void __init do_init_bootmem(void)
 
 	plat_mem_setup();
 
-	for_each_memblock(memory, reg) {
-		int nid = memblock_get_region_node(reg);
-
-		memory_present(nid, memblock_region_memory_base_pfn(reg),
-			memblock_region_memory_end_pfn(reg));
-	}
 	sparse_init();
 }
 
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index f7e4439deb17..50f0dc1744d0 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -53,7 +53,4 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 
 	/* It's up */
 	node_set_online(nid);
-
-	/* Kick sparsemem */
-	sparse_memory_present_with_active_regions(nid);
 }
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 02e6e5e0f106..fad6d3129904 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1610,7 +1610,6 @@ static unsigned long __init bootmem_init(unsigned long phys_base)
 
 	/* XXX cpu notifier XXX */
 
-	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 
 	return end_pfn;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 8b4afad84f4a..4cb958419fb0 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -678,7 +678,6 @@ void __init initmem_init(void)
 #endif
 
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
-	sparse_memory_present_with_active_regions(0);
 
 #ifdef CONFIG_FLATMEM
 	max_mapnr = IS_ENABLED(CONFIG_HIGHMEM) ? highend_pfn : max_low_pfn;
@@ -718,7 +717,6 @@ void __init paging_init(void)
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
 	olpc_dt_build_devicetree();
-	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 	zone_sizes_init();
 }
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dbae185511cd..d580110a12bb 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -817,7 +817,6 @@ void __init initmem_init(void)
 
 void __init paging_init(void)
 {
-	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 
 	/*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..5f904e8fa825 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2415,9 +2415,6 @@ static inline unsigned long get_num_physpages(void)
  * for_each_valid_physical_page_range()
  * 	memblock_add_node(base, size, nid)
  * free_area_init(max_zone_pfns);
- *
- * sparse_memory_present_with_active_regions() calls memory_present() for
- * each range when SPARSEMEM is enabled.
  */
 void free_area_init(unsigned long *max_zone_pfn);
 unsigned long node_map_pfn_alignment(void);
@@ -2428,7 +2425,6 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 extern unsigned long find_min_pfn_with_active_regions(void);
-extern void sparse_memory_present_with_active_regions(int nid);
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 static inline int early_pfn_to_nid(unsigned long pfn)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f6f884970511..e55dd1462033 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -819,18 +819,6 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
 
 extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
 
-#ifdef CONFIG_HAVE_MEMORY_PRESENT
-void memory_present(int nid, unsigned long start, unsigned long end);
-#else
-static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
-#endif
-
-#if defined(CONFIG_SPARSEMEM)
-void memblocks_present(void);
-#else
-static inline void memblocks_present(void) {}
-#endif
-
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
@@ -1387,8 +1375,6 @@ struct mminit_pfnnid_cache {
 #define early_pfn_valid(pfn)	(1)
 #endif
 
-void memory_present(int nid, unsigned long start, unsigned long end);
-
 /*
  * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
  * need to check pfn validity within that MAX_ORDER_NR_PAGES block.
diff --git a/mm/Kconfig b/mm/Kconfig
index f2104cc0d35c..90766edfdfc7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -88,13 +88,9 @@ config NEED_MULTIPLE_NODES
 	def_bool y
 	depends on DISCONTIGMEM || NUMA
 
-config HAVE_MEMORY_PRESENT
-	def_bool y
-	depends on ARCH_HAVE_MEMORY_PRESENT || SPARSEMEM
-
 #
 # SPARSEMEM_EXTREME (which is the default) does some bootmem
-# allocations when memory_present() is called.  If this cannot
+# allocations when sparse_init() is called.  If this cannot
 # be done on your architecture, select this option.  However,
 # statically allocating the mem_section[] array can potentially
 # consume vast quantities of .bss, so be careful.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..3a40d089391b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6324,22 +6324,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
 	zone->initialized = 1;
 }
 
-/**
- * sparse_memory_present_with_active_regions - Call memory_present for each active range
- * @nid: The node to call memory_present for. If MAX_NUMNODES, all nodes will be used.
- *
- * If an architecture guarantees that all ranges registered contain no holes and may
- * be freed, this function may be used instead of calling memory_present() manually.
- */
-void __init sparse_memory_present_with_active_regions(int nid)
-{
-	unsigned long start_pfn, end_pfn;
-	int i, this_nid;
-
-	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, &this_nid)
-		memory_present(this_nid, start_pfn, end_pfn);
-}
-
 /**
  * get_pfn_range_for_nid - Return the start and end page frames for a node
  * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
diff --git a/mm/sparse.c b/mm/sparse.c
index b2b9a3e34696..93100912a18e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -250,7 +250,7 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
 #endif
 
 /* Record a memory area against a node. */
-void __init memory_present(int nid, unsigned long start, unsigned long end)
+static void __init memory_present(int nid, unsigned long start, unsigned long end)
 {
 	unsigned long pfn;
 
@@ -286,11 +286,11 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 }
 
 /*
- * Mark all memblocks as present using memory_present(). This is a
- * convenience function that is useful for a number of arches
- * to mark all of the systems memory as present during initialization.
+ * Mark all memblocks as present using memory_present().
+ * This is a convenience function that is useful to mark all of the systems
+ * memory as present during initialization.
  */
-void __init memblocks_present(void)
+static void __init memblocks_present(void)
 {
 	struct memblock_region *reg;
 
@@ -575,9 +575,13 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
  */
 void __init sparse_init(void)
 {
-	unsigned long pnum_begin = first_present_section_nr();
-	int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
-	unsigned long pnum_end, map_count = 1;
+	unsigned long pnum_end, pnum_begin, map_count = 1;
+	int nid_begin;
+
+	memblocks_present();
+
+	pnum_begin = first_present_section_nr();
+	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
 
 	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
 	set_pageblock_order();
-- 
2.26.2

