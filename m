Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0939F204
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFHJQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 05:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhFHJQO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 05:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4ABB61289;
        Tue,  8 Jun 2021 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623143662;
        bh=7lsHIuFlpfTbctW8uOzW90AFU4QqqWrEUTqqBnYaW34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLfKufju2J/x2R9/TF1b/OeaOwlTV0GPjiWSO21zw1Aeddkpkr6PquL4wS2+1pHj/
         P70lEqV+e1W5iyhoNr1F3C87qrdqwEDUXsnYFg5Jyg3jz9qZAeulpXF7FwgM0rsJgB
         BNDBhePYUIef4s1T9wP+lck1zjQtqEguu7n9bDaFD4oKqHspZB97x4J/XEWtFoJc1p
         h7XIYMMxV0CVRHgm9lRKXWDvQ1f1Ly+2/psW+V7w//cKoPecYtE8JURZxX0n+sv/9r
         uOHHJoV14pLe0U3BzU0DMvaP/SS6Nvm5ll9QJFJqcOj4WMvB6qLgh8okxo9AiOv6zj
         ZoEw7LC3Bn7wg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 8/9] mm: replace CONFIG_NEED_MULTIPLE_NODES with CONFIG_NUMA
Date:   Tue,  8 Jun 2021 12:13:15 +0300
Message-Id: <20210608091316.3622-9-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210608091316.3622-1-rppt@kernel.org>
References: <20210608091316.3622-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

After removal of DISCINTIGMEM the NEED_MULTIPLE_NODES and NUMA
configuration options are equivalent.

Drop CONFIG_NEED_MULTIPLE_NODES and use CONFIG_NUMA instead.

Done with

	$ sed -i 's/CONFIG_NEED_MULTIPLE_NODES/CONFIG_NUMA/' \
		$(git grep -wl CONFIG_NEED_MULTIPLE_NODES)
	$ sed -i 's/NEED_MULTIPLE_NODES/NUMA/' \
		$(git grep -wl NEED_MULTIPLE_NODES)

with manual tweaks afterwards.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/ia64/Kconfig                 |  2 +-
 arch/mips/Kconfig                 |  2 +-
 arch/mips/include/asm/mmzone.h    |  2 +-
 arch/mips/include/asm/page.h      |  2 +-
 arch/mips/mm/init.c               |  4 ++--
 arch/powerpc/Kconfig              |  2 +-
 arch/powerpc/include/asm/mmzone.h |  4 ++--
 arch/powerpc/kernel/setup_64.c    |  2 +-
 arch/powerpc/kernel/smp.c         |  2 +-
 arch/powerpc/kexec/core.c         |  4 ++--
 arch/powerpc/mm/Makefile          |  2 +-
 arch/powerpc/mm/mem.c             |  4 ++--
 arch/riscv/Kconfig                |  2 +-
 arch/s390/Kconfig                 |  2 +-
 arch/sh/include/asm/mmzone.h      |  4 ++--
 arch/sh/kernel/topology.c         |  2 +-
 arch/sh/mm/Kconfig                |  2 +-
 arch/sh/mm/init.c                 |  2 +-
 arch/sparc/Kconfig                |  2 +-
 arch/sparc/include/asm/mmzone.h   |  4 ++--
 arch/sparc/kernel/smp_64.c        |  2 +-
 arch/sparc/mm/init_64.c           | 12 ++++++------
 arch/x86/Kconfig                  |  2 +-
 arch/x86/kernel/setup_percpu.c    |  6 +++---
 arch/x86/mm/init_32.c             |  4 ++--
 include/asm-generic/topology.h    |  2 +-
 include/linux/memblock.h          |  6 +++---
 include/linux/mm.h                |  4 ++--
 include/linux/mmzone.h            |  8 ++++----
 kernel/crash_core.c               |  2 +-
 mm/Kconfig                        |  9 ---------
 mm/memblock.c                     |  8 ++++----
 mm/memory.c                       |  3 +--
 mm/page_alloc.c                   |  6 +++---
 35 files changed, 59 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..d01a1545ab8f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1035,7 +1035,7 @@ config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 1 10
 	default "4"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 	help
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 279252e3e0f7..da22a35e6f03 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -302,7 +302,7 @@ config NODES_SHIFT
 	int "Max num nodes shift(3-10)"
 	range 3 10
 	default "10"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 	help
 	  This option specifies the maximum number of nodes in your SSI system.
 	  MAX_NUMNODES will be 2^(This value).
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed51970c08e7..4704a16c2e44 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2867,7 +2867,7 @@ config RANDOMIZE_BASE_MAX_OFFSET
 config NODES_SHIFT
 	int
 	default "6"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index 7649ab45e80c..602a21aee9d4 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -8,7 +8,7 @@
 
 #include <asm/page.h>
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 # include <mmzone.h>
 #endif
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 195ff4e9771f..96bc798c1ec1 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -239,7 +239,7 @@ static inline int pfn_valid(unsigned long pfn)
 
 /* pfn_valid is defined in linux/mmzone.h */
 
-#elif defined(CONFIG_NEED_MULTIPLE_NODES)
+#elif defined(CONFIG_NUMA)
 
 #define pfn_valid(pfn)							\
 ({									\
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 97f6ca341448..19347dc6bbf8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -394,7 +394,7 @@ void maar_init(void)
 	}
 }
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
@@ -473,7 +473,7 @@ void __init mem_init(void)
 				0x80000000 - 4, KCORE_TEXT);
 #endif
 }
-#endif /* !CONFIG_NEED_MULTIPLE_NODES */
+#endif /* !CONFIG_NUMA */
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2afcfe4..14b132cf95e2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -671,7 +671,7 @@ config NODES_SHIFT
 	int
 	default "8" if PPC64
 	default "4"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 6cda76b57c5d..4c6c6dbd182f 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -18,7 +18,7 @@
  *    flags field of the struct page
  */
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 
 extern struct pglist_data *node_data[];
 /*
@@ -41,7 +41,7 @@ u64 memory_hotplug_max(void);
 
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
-#endif /* CONFIG_NEED_MULTIPLE_NODES */
+#endif /* CONFIG_NUMA */
 #ifdef CONFIG_FA_DUMP
 #define __HAVE_ARCH_RESERVED_KERNEL_PAGES
 #endif
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e42b85e4f1aa..a35fbf4d0bce 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -788,7 +788,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 					size_t align)
 {
 	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int node = early_cpu_to_node(cpu);
 	void *ptr;
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2e05c783440a..a5209ea3859e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1047,7 +1047,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			zalloc_cpumask_var_node(&per_cpu(cpu_coregroup_map, cpu),
 						GFP_KERNEL, cpu_to_node(cpu));
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 		/*
 		 * numa_node_id() works after this.
 		 */
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 56da5eb2b923..48525e8b5730 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -68,11 +68,11 @@ void machine_kexec_cleanup(struct kimage *image)
 void arch_crash_save_vmcoreinfo(void)
 {
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
 	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
 #endif
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index c3df3a8501d4..2ffcf540f08b 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -13,7 +13,7 @@ obj-y				:= fault.o mem.o pgtable.o mmap.o maccess.o \
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= nohash/
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s32/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64/
-obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
+obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 043bbeaf407c..7a266991315f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -126,7 +126,7 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 }
 #endif
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 void __init mem_topology_setup(void)
 {
 	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
@@ -161,7 +161,7 @@ static int __init mark_nonram_nosave(void)
 
 	return 0;
 }
-#else /* CONFIG_NEED_MULTIPLE_NODES */
+#else /* CONFIG_NUMA */
 static int __init mark_nonram_nosave(void)
 {
 	return 0;
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a8ad8eb76120..e985dbf9ff27 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -331,7 +331,7 @@ config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 1 10
 	default "2"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 	help
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b4c7c34069f8..707afbcd81c2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -475,7 +475,7 @@ config NUMA
 
 config NODES_SHIFT
 	int
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 	default "1"
 
 config SCHED_SMT
diff --git a/arch/sh/include/asm/mmzone.h b/arch/sh/include/asm/mmzone.h
index 6552a088dc97..7b8dead2723d 100644
--- a/arch/sh/include/asm/mmzone.h
+++ b/arch/sh/include/asm/mmzone.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_MMZONE_H
 #define __ASM_SH_MMZONE_H
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 #include <linux/numa.h>
 
 extern struct pglist_data *node_data[];
@@ -31,7 +31,7 @@ static inline void
 setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 {
 }
-#endif /* CONFIG_NEED_MULTIPLE_NODES */
+#endif /* CONFIG_NUMA */
 
 /* Platform specific mem init */
 void __init plat_mem_setup(void);
diff --git a/arch/sh/kernel/topology.c b/arch/sh/kernel/topology.c
index 7a989eed3b18..76af6db9daa2 100644
--- a/arch/sh/kernel/topology.c
+++ b/arch/sh/kernel/topology.c
@@ -46,7 +46,7 @@ static int __init topology_init(void)
 {
 	int i, ret;
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	for_each_online_node(i)
 		register_one_node(i);
 #endif
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index d551a9cac41e..ba569cfb4368 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -120,7 +120,7 @@ config NODES_SHIFT
 	int
 	default "3" if CPU_SUBTYPE_SHX3
 	default "1"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 168d7d4dd735..ce26c7f8950a 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -211,7 +211,7 @@ void __init allocate_pgdat(unsigned int nid)
 
 	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	NODE_DATA(nid) = memblock_alloc_try_nid(
 				sizeof(struct pglist_data),
 				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..c72f52c704cd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -265,7 +265,7 @@ config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 4 5 if SPARC64
 	default "5"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 	help
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
diff --git a/arch/sparc/include/asm/mmzone.h b/arch/sparc/include/asm/mmzone.h
index 6543fb97a849..a236d8aa893a 100644
--- a/arch/sparc/include/asm/mmzone.h
+++ b/arch/sparc/include/asm/mmzone.h
@@ -2,7 +2,7 @@
 #ifndef _SPARC64_MMZONE_H
 #define _SPARC64_MMZONE_H
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 
 #include <linux/cpumask.h>
 
@@ -13,6 +13,6 @@ extern struct pglist_data *node_data[];
 extern int numa_cpu_lookup_table[];
 extern cpumask_t numa_cpumask_lookup_table[];
 
-#endif /* CONFIG_NEED_MULTIPLE_NODES */
+#endif /* CONFIG_NUMA */
 
 #endif /* _SPARC64_MMZONE_H */
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e38d8bf454e8..c89a5971fb0d 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1546,7 +1546,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 					size_t align)
 {
 	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int node = cpu_to_node(cpu);
 	void *ptr;
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index e454f179cf5d..06e938d03f3b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -903,7 +903,7 @@ struct node_mem_mask {
 static struct node_mem_mask node_masks[MAX_NUMNODES];
 static int num_node_masks;
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 
 struct mdesc_mlgroup {
 	u64	node;
@@ -1059,7 +1059,7 @@ static void __init allocate_node_data(int nid)
 {
 	struct pglist_data *p;
 	unsigned long start_pfn, end_pfn;
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 
 	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
 					     SMP_CACHE_BYTES, nid);
@@ -1080,7 +1080,7 @@ static void __init allocate_node_data(int nid)
 
 static void init_node_masks_nonnuma(void)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int i;
 #endif
 
@@ -1090,7 +1090,7 @@ static void init_node_masks_nonnuma(void)
 	node_masks[0].match = 0;
 	num_node_masks = 1;
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	for (i = 0; i < NR_CPUS; i++)
 		numa_cpu_lookup_table[i] = 0;
 
@@ -1098,7 +1098,7 @@ static void init_node_masks_nonnuma(void)
 #endif
 }
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 struct pglist_data *node_data[MAX_NUMNODES];
 
 EXPORT_SYMBOL(numa_cpu_lookup_table);
@@ -2487,7 +2487,7 @@ int page_in_phys_avail(unsigned long paddr)
 
 static void __init register_page_bootmem_info(void)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int i;
 
 	for_each_online_node(i)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..5d523ff70fe7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1597,7 +1597,7 @@ config NODES_SHIFT
 	default "10" if MAXSMP
 	default "6" if X86_64
 	default "3"
-	depends on NEED_MULTIPLE_NODES
+	depends on NUMA
 	help
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 0941d2f44f2a..78a32b956e81 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(__per_cpu_offset);
  */
 static bool __init pcpu_need_numa(void)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	pg_data_t *last = NULL;
 	unsigned int cpu;
 
@@ -101,7 +101,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 					unsigned long align)
 {
 	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int node = early_cpu_to_node(cpu);
 	void *ptr;
 
@@ -140,7 +140,7 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	if (early_cpu_to_node(from) == early_cpu_to_node(to))
 		return LOCAL_DISTANCE;
 	else
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 21ffb03f6c72..74b78840182d 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -651,7 +651,7 @@ void __init find_low_pfn_range(void)
 		highmem_pfn_init();
 }
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 void __init initmem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -677,7 +677,7 @@ void __init initmem_init(void)
 
 	setup_bootmem_allocator();
 }
-#endif /* !CONFIG_NEED_MULTIPLE_NODES */
+#endif /* !CONFIG_NUMA */
 
 void __init setup_bootmem_allocator(void)
 {
diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 5aa8705df87e..4dbe715be65b 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -45,7 +45,7 @@
 #endif
 
 #ifndef cpumask_of_node
-  #ifdef CONFIG_NEED_MULTIPLE_NODES
+  #ifdef CONFIG_NUMA
     #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
   #else
     #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5984fff3f175..552309342c38 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -50,7 +50,7 @@ struct memblock_region {
 	phys_addr_t base;
 	phys_addr_t size;
 	enum memblock_flags flags;
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int nid;
 #endif
 };
@@ -347,7 +347,7 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
 int memblock_set_node(phys_addr_t base, phys_addr_t size,
 		      struct memblock_type *type, int nid);
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 static inline void memblock_set_region_node(struct memblock_region *r, int nid)
 {
 	r->nid = nid;
@@ -366,7 +366,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 {
 	return 0;
 }
-#endif /* CONFIG_NEED_MULTIPLE_NODES */
+#endif /* CONFIG_NUMA */
 
 /* Flags for memblock allocation APIs */
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..cf66f0ea7956 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -46,7 +46,7 @@ extern int sysctl_page_lock_unfairness;
 
 void init_mm_internals(void);
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES	/* Don't use mapnrs, do it properly */
+#ifndef CONFIG_NUMA		/* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
 
 static inline void set_max_mapnr(unsigned long limit)
@@ -2457,7 +2457,7 @@ extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 extern unsigned long find_min_pfn_with_active_regions(void);
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 static inline int early_pfn_to_nid(unsigned long pfn)
 {
 	return 0;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 700032e99419..acdc51c7b259 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -987,7 +987,7 @@ extern int movable_zone;
 #ifdef CONFIG_HIGHMEM
 static inline int zone_movable_is_highmem(void)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	return movable_zone == ZONE_HIGHMEM;
 #else
 	return (ZONE_MOVABLE - 1) == ZONE_HIGHMEM;
@@ -1043,17 +1043,17 @@ extern int percpu_pagelist_fraction;
 extern char numa_zonelist_order[];
 #define NUMA_ZONELIST_ORDER_LEN	16
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 
 extern struct pglist_data contig_page_data;
 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
 
-#else /* CONFIG_NEED_MULTIPLE_NODES */
+#else /* CONFIG_NUMA */
 
 #include <asm/mmzone.h>
 
-#endif /* !CONFIG_NEED_MULTIPLE_NODES */
+#endif /* !CONFIG_NUMA */
 
 extern struct pglist_data *first_online_pgdat(void);
 extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 825284baaf46..53eb8bc6026d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -455,7 +455,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(_stext);
 	VMCOREINFO_SYMBOL(vmap_area_list);
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(mem_map);
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 218b96ccc84a..bffe4bd859f3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -59,15 +59,6 @@ config FLAT_NODE_MEM_MAP
 	def_bool y
 	depends on !SPARSEMEM
 
-#
-# Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
-# to represent different areas of memory.  This variable allows
-# those dependencies to exist individually.
-#
-config NEED_MULTIPLE_NODES
-	def_bool y
-	depends on NUMA
-
 #
 # SPARSEMEM_EXTREME (which is the default) does some bootmem
 # allocations when sparse_init() is called.  If this cannot
diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..123feef5259d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -92,7 +92,7 @@
  * system initialization completes.
  */
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 struct pglist_data __refdata contig_page_data;
 EXPORT_SYMBOL(contig_page_data);
 #endif
@@ -607,7 +607,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		 * area, insert that portion.
 		 */
 		if (rbase > base) {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
 			WARN_ON(flags != rgn->flags);
@@ -1205,7 +1205,7 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 				      struct memblock_type *type, int nid)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 	int start_rgn, end_rgn;
 	int i, ret;
 
@@ -1849,7 +1849,7 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 		size = rgn->size;
 		end = base + size - 1;
 		flags = rgn->flags;
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 		if (memblock_get_region_node(rgn) != MAX_NUMNODES)
 			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
 				 memblock_get_region_node(rgn));
diff --git a/mm/memory.c b/mm/memory.c
index 730daa00952b..83b0d998a2f1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -90,8 +90,7 @@
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-/* use the per-pgdat data instead for discontigmem - mbligh */
+#ifndef CONFIG_NUMA
 unsigned long max_mapnr;
 EXPORT_SYMBOL(max_mapnr);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6fc22482eaa8..8f08135d3eb4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1596,7 +1596,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
 }
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_NUMA
 
 /*
  * During memory init memblocks map pfns to nids. The search is expensive and
@@ -1646,7 +1646,7 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 
 	return nid;
 }
-#endif /* CONFIG_NEED_MULTIPLE_NODES */
+#endif /* CONFIG_NUMA */
 
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
@@ -7276,7 +7276,7 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 				__func__, pgdat->node_id, (unsigned long)pgdat,
 				(unsigned long)pgdat->node_mem_map);
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifndef CONFIG_NUMA
 	/*
 	 * With no DISCONTIG, the global mem_map is just set as node 0's
 	 */
-- 
2.28.0

