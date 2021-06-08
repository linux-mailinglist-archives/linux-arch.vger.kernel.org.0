Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0339F1C2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFHJP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 05:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhFHJP1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 05:15:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B3506124B;
        Tue,  8 Jun 2021 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623143615;
        bh=GuleUPp5E53TELsDwENixxJn0tFxM+w/kQiS3vDmk8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvpU8aMcDhX+fmAcftfUBUPbk5m524PicBOL2cvE99QFIZlvRknj60h3Tqa4yjYDK
         +I2BI5eQj0DFWdbsi6QSGeK3e0Bjnn4jR3xzVXlKpgNu9QbFjVa/RbiXxKP/YIxev8
         iYl/E2cMbNz3rXimJldwKm8PzDXrpsV8kKpGW63vvupXXtGSWug1aPpefVg7aMbXPZ
         xKvYD1nAwZJynfk+2dGXPbCjohohlFlZd1J2Sv+p6RtZ1tsjpJadu2lIpXSFU3rsdI
         GJERi/TJ5hhBd7+xbuRxwXkF+4ILpCrbHFApnZHh1/jeivJxdug8HdNybUiDdXghCr
         LIp5en/SRso/g==
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
Subject: [PATCH v3 1/9] alpha: remove DISCONTIGMEM and NUMA
Date:   Tue,  8 Jun 2021 12:13:08 +0300
Message-Id: <20210608091316.3622-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210608091316.3622-1-rppt@kernel.org>
References: <20210608091316.3622-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

NUMA is marked broken on alpha for more than 15 years and DISCONTIGMEM was
replaced with SPARSEMEM in v5.11.

Remove both NUMA and DISCONTIGMEM support from alpha.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/Kconfig                |  22 ---
 arch/alpha/include/asm/machvec.h  |   6 -
 arch/alpha/include/asm/mmzone.h   | 100 --------------
 arch/alpha/include/asm/pgtable.h  |   4 -
 arch/alpha/include/asm/topology.h |  39 ------
 arch/alpha/kernel/core_marvel.c   |  53 +------
 arch/alpha/kernel/core_wildfire.c |  29 +---
 arch/alpha/kernel/pci_iommu.c     |  29 ----
 arch/alpha/kernel/proto.h         |   8 --
 arch/alpha/kernel/setup.c         |  16 ---
 arch/alpha/kernel/sys_marvel.c    |   5 -
 arch/alpha/kernel/sys_wildfire.c  |   5 -
 arch/alpha/mm/Makefile            |   2 -
 arch/alpha/mm/init.c              |   3 -
 arch/alpha/mm/numa.c              | 223 ------------------------------
 15 files changed, 4 insertions(+), 540 deletions(-)
 delete mode 100644 arch/alpha/include/asm/mmzone.h
 delete mode 100644 arch/alpha/mm/numa.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5998106faa60..8954216b9956 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -549,29 +549,12 @@ config NR_CPUS
 	  MARVEL support can handle a maximum of 32 CPUs, all the others
 	  with working support have a maximum of 4 CPUs.
 
-config ARCH_DISCONTIGMEM_ENABLE
-	bool "Discontiguous Memory Support"
-	depends on BROKEN
-	help
-	  Say Y to support efficient handling of discontiguous physical memory,
-	  for architectures which are either NUMA (Non-Uniform Memory Access)
-	  or have huge holes in the physical address space for other reasons.
-	  See <file:Documentation/vm/numa.rst> for more.
-
 config ARCH_SPARSEMEM_ENABLE
 	bool "Sparse Memory Support"
 	help
 	  Say Y to support efficient handling of discontiguous physical memory,
 	  for systems that have huge holes in the physical address space.
 
-config NUMA
-	bool "NUMA Support (EXPERIMENTAL)"
-	depends on DISCONTIGMEM && BROKEN
-	help
-	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
-	  Access).  This option is for configuring high-end multiprocessor
-	  server machines.  If in doubt, say N.
-
 config ALPHA_WTINT
 	bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
 	default y if ALPHA_QEMU
@@ -596,11 +579,6 @@ config ALPHA_WTINT
 
 	  If unsure, say N.
 
-config NODES_SHIFT
-	int
-	default "7"
-	depends on NEED_MULTIPLE_NODES
-
 # LARGE_VMALLOC is racy, if you *really* need it then fix it first
 config ALPHA_LARGE_VMALLOC
 	bool
diff --git a/arch/alpha/include/asm/machvec.h b/arch/alpha/include/asm/machvec.h
index a4e96e2bec74..e49fabce7b33 100644
--- a/arch/alpha/include/asm/machvec.h
+++ b/arch/alpha/include/asm/machvec.h
@@ -99,12 +99,6 @@ struct alpha_machine_vector
 
 	const char *vector_name;
 
-	/* NUMA information */
-	int (*pa_to_nid)(unsigned long);
-	int (*cpuid_to_nid)(int);
-	unsigned long (*node_mem_start)(int);
-	unsigned long (*node_mem_size)(int);
-
 	/* System specific parameters.  */
 	union {
 	    struct {
diff --git a/arch/alpha/include/asm/mmzone.h b/arch/alpha/include/asm/mmzone.h
deleted file mode 100644
index 86644604d977..000000000000
--- a/arch/alpha/include/asm/mmzone.h
+++ /dev/null
@@ -1,100 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Written by Kanoj Sarcar (kanoj@sgi.com) Aug 99
- * Adapted for the alpha wildfire architecture Jan 2001.
- */
-#ifndef _ASM_MMZONE_H_
-#define _ASM_MMZONE_H_
-
-#ifdef CONFIG_DISCONTIGMEM
-
-#include <asm/smp.h>
-
-/*
- * Following are macros that are specific to this numa platform.
- */
-
-extern pg_data_t node_data[];
-
-#define alpha_pa_to_nid(pa)		\
-        (alpha_mv.pa_to_nid 		\
-	 ? alpha_mv.pa_to_nid(pa)	\
-	 : (0))
-#define node_mem_start(nid)		\
-        (alpha_mv.node_mem_start 	\
-	 ? alpha_mv.node_mem_start(nid) \
-	 : (0UL))
-#define node_mem_size(nid)		\
-        (alpha_mv.node_mem_size 	\
-	 ? alpha_mv.node_mem_size(nid) 	\
-	 : ((nid) ? (0UL) : (~0UL)))
-
-#define pa_to_nid(pa)		alpha_pa_to_nid(pa)
-#define NODE_DATA(nid)		(&node_data[(nid)])
-
-#define node_localnr(pfn, nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
-
-#if 1
-#define PLAT_NODE_DATA_LOCALNR(p, n)	\
-	(((p) >> PAGE_SHIFT) - PLAT_NODE_DATA(n)->gendata.node_start_pfn)
-#else
-static inline unsigned long
-PLAT_NODE_DATA_LOCALNR(unsigned long p, int n)
-{
-	unsigned long temp;
-	temp = p >> PAGE_SHIFT;
-	return temp - PLAT_NODE_DATA(n)->gendata.node_start_pfn;
-}
-#endif
-
-/*
- * Following are macros that each numa implementation must define.
- */
-
-/*
- * Given a kernel address, find the home node of the underlying memory.
- */
-#define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
-
-/*
- * Given a kaddr, LOCAL_BASE_ADDR finds the owning node of the memory
- * and returns the kaddr corresponding to first physical page in the
- * node's mem_map.
- */
-#define LOCAL_BASE_ADDR(kaddr)						  \
-    ((unsigned long)__va(NODE_DATA(kvaddr_to_nid(kaddr))->node_start_pfn  \
-			 << PAGE_SHIFT))
-
-/* XXX: FIXME -- nyc */
-#define kern_addr_valid(kaddr)	(0)
-
-#define mk_pte(page, pgprot)						     \
-({								 	     \
-	pte_t pte;                                                           \
-	unsigned long pfn;                                                   \
-									     \
-	pfn = page_to_pfn(page) << 32; \
-	pte_val(pte) = pfn | pgprot_val(pgprot);			     \
-									     \
-	pte;								     \
-})
-
-#define pte_page(x)							\
-({									\
-       	unsigned long kvirt;						\
-	struct page * __xx;						\
-									\
-	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
-	__xx = virt_to_page(kvirt);					\
-									\
-	__xx;                                                           \
-})
-
-#define pfn_to_nid(pfn)		pa_to_nid(((u64)(pfn) << PAGE_SHIFT))
-#define pfn_valid(pfn)							\
-	(((pfn) - node_start_pfn(pfn_to_nid(pfn))) <			\
-	 node_spanned_pages(pfn_to_nid(pfn)))					\
-
-#endif /* CONFIG_DISCONTIGMEM */
-
-#endif /* _ASM_MMZONE_H_ */
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 8d856c62e22a..e1757b7cfe3d 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -206,7 +206,6 @@ extern unsigned long __zero_page(void);
 #define page_to_pa(page)	(page_to_pfn(page) << PAGE_SHIFT)
 #define pte_pfn(pte)	(pte_val(pte) >> 32)
 
-#ifndef CONFIG_DISCONTIGMEM
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 #define mk_pte(page, pgprot)						\
 ({									\
@@ -215,7 +214,6 @@ extern unsigned long __zero_page(void);
 	pte_val(pte) = (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\
 	pte;								\
 })
-#endif
 
 extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
 { pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
@@ -330,9 +328,7 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
-#endif
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
diff --git a/arch/alpha/include/asm/topology.h b/arch/alpha/include/asm/topology.h
index 5a77a40567fa..7d393036aa8f 100644
--- a/arch/alpha/include/asm/topology.h
+++ b/arch/alpha/include/asm/topology.h
@@ -7,45 +7,6 @@
 #include <linux/numa.h>
 #include <asm/machvec.h>
 
-#ifdef CONFIG_NUMA
-static inline int cpu_to_node(int cpu)
-{
-	int node;
-	
-	if (!alpha_mv.cpuid_to_nid)
-		return 0;
-
-	node = alpha_mv.cpuid_to_nid(cpu);
-
-#ifdef DEBUG_NUMA
-	BUG_ON(node < 0);
-#endif
-
-	return node;
-}
-
-extern struct cpumask node_to_cpumask_map[];
-/* FIXME: This is dumb, recalculating every time.  But simple. */
-static const struct cpumask *cpumask_of_node(int node)
-{
-	int cpu;
-
-	if (node == NUMA_NO_NODE)
-		return cpu_all_mask;
-
-	cpumask_clear(&node_to_cpumask_map[node]);
-
-	for_each_online_cpu(cpu) {
-		if (cpu_to_node(cpu) == node)
-			cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
-	}
-
-	return &node_to_cpumask_map[node];
-}
-
-#define cpumask_of_pcibus(bus)	(cpu_online_mask)
-
-#endif /* !CONFIG_NUMA */
 # include <asm-generic/topology.h>
 
 #endif /* _ASM_ALPHA_TOPOLOGY_H */
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index 4485b77f8658..1efca79ac83c 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -287,8 +287,7 @@ io7_init_hose(struct io7 *io7, int port)
 	/*
 	 * Set up window 0 for scatter-gather 8MB at 8MB.
 	 */
-	hose->sg_isa = iommu_arena_new_node(marvel_cpuid_to_nid(io7->pe),
-					    hose, 0x00800000, 0x00800000, 0);
+	hose->sg_isa = iommu_arena_new_node(0, hose, 0x00800000, 0x00800000, 0);
 	hose->sg_isa->align_entry = 8;	/* cache line boundary */
 	csrs->POx_WBASE[0].csr = 
 		hose->sg_isa->dma_base | wbase_m_ena | wbase_m_sg;
@@ -305,8 +304,7 @@ io7_init_hose(struct io7 *io7, int port)
 	/*
 	 * Set up window 2 for scatter-gather (up-to) 1GB at 3GB.
 	 */
-	hose->sg_pci = iommu_arena_new_node(marvel_cpuid_to_nid(io7->pe),
-					    hose, 0xc0000000, 0x40000000, 0);
+	hose->sg_pci = iommu_arena_new_node(0, hose, 0xc0000000, 0x40000000, 0);
 	hose->sg_pci->align_entry = 8;	/* cache line boundary */
 	csrs->POx_WBASE[2].csr = 
 		hose->sg_pci->dma_base | wbase_m_ena | wbase_m_sg;
@@ -843,53 +841,8 @@ EXPORT_SYMBOL(marvel_ioportmap);
 EXPORT_SYMBOL(marvel_ioread8);
 EXPORT_SYMBOL(marvel_iowrite8);
 #endif
-
-/*
- * NUMA Support
- */
-/**********
- * FIXME - for now each cpu is a node by itself 
- *              -- no real support for striped mode 
- **********
- */
-int
-marvel_pa_to_nid(unsigned long pa)
-{
-	int cpuid;
 
-	if ((pa >> 43) & 1) 	/* I/O */ 
-		cpuid = (~(pa >> 35) & 0xff);
-	else			/* mem */
-		cpuid = ((pa >> 34) & 0x3) | ((pa >> (37 - 2)) & (0x1f << 2));
-
-	return marvel_cpuid_to_nid(cpuid);
-}
-
-int
-marvel_cpuid_to_nid(int cpuid)
-{
-	return cpuid;
-}
-
-unsigned long
-marvel_node_mem_start(int nid)
-{
-	unsigned long pa;
-
-	pa = (nid & 0x3) | ((nid & (0x1f << 2)) << 1);
-	pa <<= 34;
-
-	return pa;
-}
-
-unsigned long
-marvel_node_mem_size(int nid)
-{
-	return 16UL * 1024 * 1024 * 1024; /* 16GB */
-}
-
-
-/* 
+/*
  * AGP GART Support.
  */
 #include <linux/agp_backend.h>
diff --git a/arch/alpha/kernel/core_wildfire.c b/arch/alpha/kernel/core_wildfire.c
index e8d3b033018d..3a804b67f9da 100644
--- a/arch/alpha/kernel/core_wildfire.c
+++ b/arch/alpha/kernel/core_wildfire.c
@@ -434,39 +434,12 @@ wildfire_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-struct pci_ops wildfire_pci_ops = 
+struct pci_ops wildfire_pci_ops =
 {
 	.read =		wildfire_read_config,
 	.write =	wildfire_write_config,
 };
 
-
-/*
- * NUMA Support
- */
-int wildfire_pa_to_nid(unsigned long pa)
-{
-	return pa >> 36;
-}
-
-int wildfire_cpuid_to_nid(int cpuid)
-{
-	/* assume 4 CPUs per node */
-	return cpuid >> 2;
-}
-
-unsigned long wildfire_node_mem_start(int nid)
-{
-	/* 64GB per node */
-	return (unsigned long)nid * (64UL * 1024 * 1024 * 1024);
-}
-
-unsigned long wildfire_node_mem_size(int nid)
-{
-	/* 64GB per node */
-	return 64UL * 1024 * 1024 * 1024;
-}
-
 #if DEBUG_DUMP_REGS
 
 static void __init
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index d84b19aa8e9d..35d7b3096d6e 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -71,33 +71,6 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 	if (align < mem_size)
 		align = mem_size;
 
-
-#ifdef CONFIG_DISCONTIGMEM
-
-	arena = memblock_alloc_node(sizeof(*arena), align, nid);
-	if (!NODE_DATA(nid) || !arena) {
-		printk("%s: couldn't allocate arena from node %d\n"
-		       "    falling back to system-wide allocation\n",
-		       __func__, nid);
-		arena = memblock_alloc(sizeof(*arena), SMP_CACHE_BYTES);
-		if (!arena)
-			panic("%s: Failed to allocate %zu bytes\n", __func__,
-			      sizeof(*arena));
-	}
-
-	arena->ptes = memblock_alloc_node(sizeof(*arena), align, nid);
-	if (!NODE_DATA(nid) || !arena->ptes) {
-		printk("%s: couldn't allocate arena ptes from node %d\n"
-		       "    falling back to system-wide allocation\n",
-		       __func__, nid);
-		arena->ptes = memblock_alloc(mem_size, align);
-		if (!arena->ptes)
-			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-			      __func__, mem_size, align);
-	}
-
-#else /* CONFIG_DISCONTIGMEM */
-
 	arena = memblock_alloc(sizeof(*arena), SMP_CACHE_BYTES);
 	if (!arena)
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
@@ -107,8 +80,6 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, mem_size, align);
 
-#endif /* CONFIG_DISCONTIGMEM */
-
 	spin_lock_init(&arena->lock);
 	arena->hose = hose;
 	arena->dma_base = base;
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 701a05090141..5816a31c1b38 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -49,10 +49,6 @@ extern void marvel_init_arch(void);
 extern void marvel_kill_arch(int);
 extern void marvel_machine_check(unsigned long, unsigned long);
 extern void marvel_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
-extern int marvel_pa_to_nid(unsigned long);
-extern int marvel_cpuid_to_nid(int);
-extern unsigned long marvel_node_mem_start(int);
-extern unsigned long marvel_node_mem_size(int);
 extern struct _alpha_agp_info *marvel_agp_info(void);
 struct io7 *marvel_find_io7(int pe);
 struct io7 *marvel_next_io7(struct io7 *prev);
@@ -101,10 +97,6 @@ extern void wildfire_init_arch(void);
 extern void wildfire_kill_arch(int);
 extern void wildfire_machine_check(unsigned long vector, unsigned long la_ptr);
 extern void wildfire_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
-extern int wildfire_pa_to_nid(unsigned long);
-extern int wildfire_cpuid_to_nid(int);
-extern unsigned long wildfire_node_mem_start(int);
-extern unsigned long wildfire_node_mem_size(int);
 
 /* console.c */
 #ifdef CONFIG_VGA_HOSE
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 03dda3beb3bd..5f6858e9dc28 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -79,11 +79,6 @@ int alpha_l3_cacheshape;
 unsigned long alpha_verbose_mcheck = CONFIG_VERBOSE_MCHECK_ON;
 #endif
 
-#ifdef CONFIG_NUMA
-struct cpumask node_to_cpumask_map[MAX_NUMNODES] __read_mostly;
-EXPORT_SYMBOL(node_to_cpumask_map);
-#endif
-
 /* Which processor we booted from.  */
 int boot_cpuid;
 
@@ -305,7 +300,6 @@ move_initrd(unsigned long mem_limit)
 }
 #endif
 
-#ifndef CONFIG_DISCONTIGMEM
 static void __init
 setup_memory(void *kernel_end)
 {
@@ -389,9 +383,6 @@ setup_memory(void *kernel_end)
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
-#else
-extern void setup_memory(void *);
-#endif /* !CONFIG_DISCONTIGMEM */
 
 int __init
 page_is_ram(unsigned long pfn)
@@ -618,13 +609,6 @@ setup_arch(char **cmdline_p)
 	       "VERBOSE_MCHECK "
 #endif
 
-#ifdef CONFIG_DISCONTIGMEM
-	       "DISCONTIGMEM "
-#ifdef CONFIG_NUMA
-	       "NUMA "
-#endif
-#endif
-
 #ifdef CONFIG_DEBUG_SPINLOCK
 	       "DEBUG_SPINLOCK "
 #endif
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 83d6c53d6d4d..1f99b03effc2 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -461,10 +461,5 @@ struct alpha_machine_vector marvel_ev7_mv __initmv = {
 	.kill_arch		= marvel_kill_arch,
 	.pci_map_irq		= marvel_map_irq,
 	.pci_swizzle		= common_swizzle,
-
-	.pa_to_nid		= marvel_pa_to_nid,
-	.cpuid_to_nid		= marvel_cpuid_to_nid,
-	.node_mem_start		= marvel_node_mem_start,
-	.node_mem_size		= marvel_node_mem_size,
 };
 ALIAS_MV(marvel_ev7)
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index 2c54d707142a..3cee05443f07 100644
--- a/arch/alpha/kernel/sys_wildfire.c
+++ b/arch/alpha/kernel/sys_wildfire.c
@@ -337,10 +337,5 @@ struct alpha_machine_vector wildfire_mv __initmv = {
 	.kill_arch		= wildfire_kill_arch,
 	.pci_map_irq		= wildfire_map_irq,
 	.pci_swizzle		= common_swizzle,
-
-	.pa_to_nid		= wildfire_pa_to_nid,
-	.cpuid_to_nid		= wildfire_cpuid_to_nid,
-	.node_mem_start		= wildfire_node_mem_start,
-	.node_mem_size		= wildfire_node_mem_size,
 };
 ALIAS_MV(wildfire)
diff --git a/arch/alpha/mm/Makefile b/arch/alpha/mm/Makefile
index 08ac6612edad..bd770302eb82 100644
--- a/arch/alpha/mm/Makefile
+++ b/arch/alpha/mm/Makefile
@@ -6,5 +6,3 @@
 ccflags-y := -Werror
 
 obj-y	:= init.o fault.o
-
-obj-$(CONFIG_DISCONTIGMEM) += numa.o
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index a97650a618f1..f6114d03357c 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -235,8 +235,6 @@ callback_init(void * kernel_end)
 	return kernel_end;
 }
 
-
-#ifndef CONFIG_DISCONTIGMEM
 /*
  * paging_init() sets up the memory map.
  */
@@ -257,7 +255,6 @@ void __init paging_init(void)
 	/* Initialize the kernel's ZERO_PGE. */
 	memset((void *)ZERO_PGE, 0, PAGE_SIZE);
 }
-#endif /* CONFIG_DISCONTIGMEM */
 
 #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_SRM)
 void
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
deleted file mode 100644
index 0636e254a22f..000000000000
--- a/arch/alpha/mm/numa.c
+++ /dev/null
@@ -1,223 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/arch/alpha/mm/numa.c
- *
- *  DISCONTIGMEM NUMA alpha support.
- *
- *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/memblock.h>
-#include <linux/swap.h>
-#include <linux/initrd.h>
-#include <linux/pfn.h>
-#include <linux/module.h>
-
-#include <asm/hwrpb.h>
-#include <asm/sections.h>
-
-pg_data_t node_data[MAX_NUMNODES];
-EXPORT_SYMBOL(node_data);
-
-#undef DEBUG_DISCONTIG
-#ifdef DEBUG_DISCONTIG
-#define DBGDCONT(args...) printk(args)
-#else
-#define DBGDCONT(args...)
-#endif
-
-#define for_each_mem_cluster(memdesc, _cluster, i)		\
-	for ((_cluster) = (memdesc)->cluster, (i) = 0;		\
-	     (i) < (memdesc)->numclusters; (i)++, (_cluster)++)
-
-static void __init show_mem_layout(void)
-{
-	struct memclust_struct * cluster;
-	struct memdesc_struct * memdesc;
-	int i;
-
-	/* Find free clusters, and init and free the bootmem accordingly.  */
-	memdesc = (struct memdesc_struct *)
-	  (hwrpb->mddt_offset + (unsigned long) hwrpb);
-
-	printk("Raw memory layout:\n");
-	for_each_mem_cluster(memdesc, cluster, i) {
-		printk(" memcluster %2d, usage %1lx, start %8lu, end %8lu\n",
-		       i, cluster->usage, cluster->start_pfn,
-		       cluster->start_pfn + cluster->numpages);
-	}
-}
-
-static void __init
-setup_memory_node(int nid, void *kernel_end)
-{
-	extern unsigned long mem_size_limit;
-	struct memclust_struct * cluster;
-	struct memdesc_struct * memdesc;
-	unsigned long start_kernel_pfn, end_kernel_pfn;
-	unsigned long start, end;
-	unsigned long node_pfn_start, node_pfn_end;
-	unsigned long node_min_pfn, node_max_pfn;
-	int i;
-	int show_init = 0;
-
-	/* Find the bounds of current node */
-	node_pfn_start = (node_mem_start(nid)) >> PAGE_SHIFT;
-	node_pfn_end = node_pfn_start + (node_mem_size(nid) >> PAGE_SHIFT);
-	
-	/* Find free clusters, and init and free the bootmem accordingly.  */
-	memdesc = (struct memdesc_struct *)
-	  (hwrpb->mddt_offset + (unsigned long) hwrpb);
-
-	/* find the bounds of this node (node_min_pfn/node_max_pfn) */
-	node_min_pfn = ~0UL;
-	node_max_pfn = 0UL;
-	for_each_mem_cluster(memdesc, cluster, i) {
-		/* Bit 0 is console/PALcode reserved.  Bit 1 is
-		   non-volatile memory -- we might want to mark
-		   this for later.  */
-		if (cluster->usage & 3)
-			continue;
-
-		start = cluster->start_pfn;
-		end = start + cluster->numpages;
-
-		if (start >= node_pfn_end || end <= node_pfn_start)
-			continue;
-
-		if (!show_init) {
-			show_init = 1;
-			printk("Initializing bootmem allocator on Node ID %d\n", nid);
-		}
-		printk(" memcluster %2d, usage %1lx, start %8lu, end %8lu\n",
-		       i, cluster->usage, cluster->start_pfn,
-		       cluster->start_pfn + cluster->numpages);
-
-		if (start < node_pfn_start)
-			start = node_pfn_start;
-		if (end > node_pfn_end)
-			end = node_pfn_end;
-
-		if (start < node_min_pfn)
-			node_min_pfn = start;
-		if (end > node_max_pfn)
-			node_max_pfn = end;
-	}
-
-	if (mem_size_limit && node_max_pfn > mem_size_limit) {
-		static int msg_shown = 0;
-		if (!msg_shown) {
-			msg_shown = 1;
-			printk("setup: forcing memory size to %ldK (from %ldK).\n",
-			       mem_size_limit << (PAGE_SHIFT - 10),
-			       node_max_pfn    << (PAGE_SHIFT - 10));
-		}
-		node_max_pfn = mem_size_limit;
-	}
-
-	if (node_min_pfn >= node_max_pfn)
-		return;
-
-	/* Update global {min,max}_low_pfn from node information. */
-	if (node_min_pfn < min_low_pfn)
-		min_low_pfn = node_min_pfn;
-	if (node_max_pfn > max_low_pfn)
-		max_pfn = max_low_pfn = node_max_pfn;
-
-#if 0 /* we'll try this one again in a little while */
-	/* Cute trick to make sure our local node data is on local memory */
-	node_data[nid] = (pg_data_t *)(__va(node_min_pfn << PAGE_SHIFT));
-#endif
-	printk(" Detected node memory:   start %8lu, end %8lu\n",
-	       node_min_pfn, node_max_pfn);
-
-	DBGDCONT(" DISCONTIG: node_data[%d]   is at 0x%p\n", nid, NODE_DATA(nid));
-
-	/* Find the bounds of kernel memory.  */
-	start_kernel_pfn = PFN_DOWN(KERNEL_START_PHYS);
-	end_kernel_pfn = PFN_UP(virt_to_phys(kernel_end));
-
-	if (!nid && (node_max_pfn < end_kernel_pfn || node_min_pfn > start_kernel_pfn))
-		panic("kernel loaded out of ram");
-
-	memblock_add_node(PFN_PHYS(node_min_pfn),
-			  (node_max_pfn - node_min_pfn) << PAGE_SHIFT, nid);
-
-	/* Zone start phys-addr must be 2^(MAX_ORDER-1) aligned.
-	   Note that we round this down, not up - node memory
-	   has much larger alignment than 8Mb, so it's safe. */
-	node_min_pfn &= ~((1UL << (MAX_ORDER-1))-1);
-
-	NODE_DATA(nid)->node_start_pfn = node_min_pfn;
-	NODE_DATA(nid)->node_present_pages = node_max_pfn - node_min_pfn;
-
-	node_set_online(nid);
-}
-
-void __init
-setup_memory(void *kernel_end)
-{
-	unsigned long kernel_size;
-	int nid;
-
-	show_mem_layout();
-
-	nodes_clear(node_online_map);
-
-	min_low_pfn = ~0UL;
-	max_low_pfn = 0UL;
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
-		setup_memory_node(nid, kernel_end);
-
-	kernel_size = virt_to_phys(kernel_end) - KERNEL_START_PHYS;
-	memblock_reserve(KERNEL_START_PHYS, kernel_size);
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	initrd_start = INITRD_START;
-	if (initrd_start) {
-		extern void *move_initrd(unsigned long);
-
-		initrd_end = initrd_start+INITRD_SIZE;
-		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		       (void *) initrd_start, INITRD_SIZE);
-
-		if ((void *)initrd_end > phys_to_virt(PFN_PHYS(max_low_pfn))) {
-			if (!move_initrd(PFN_PHYS(max_low_pfn)))
-				printk("initrd extends beyond end of memory "
-				       "(0x%08lx > 0x%p)\ndisabling initrd\n",
-				       initrd_end,
-				       phys_to_virt(PFN_PHYS(max_low_pfn)));
-		} else {
-			nid = kvaddr_to_nid(initrd_start);
-			memblock_reserve(virt_to_phys((void *)initrd_start),
-					 INITRD_SIZE);
-		}
-	}
-#endif /* CONFIG_BLK_DEV_INITRD */
-}
-
-void __init paging_init(void)
-{
-	unsigned long   max_zone_pfn[MAX_NR_ZONES] = {0, };
-	unsigned long	dma_local_pfn;
-
-	/*
-	 * The old global MAX_DMA_ADDRESS per-arch API doesn't fit
-	 * in the NUMA model, for now we convert it to a pfn and
-	 * we interpret this pfn as a local per-node information.
-	 * This issue isn't very important since none of these machines
-	 * have legacy ISA slots anyways.
-	 */
-	dma_local_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-
-	max_zone_pfn[ZONE_DMA] = dma_local_pfn;
-	max_zone_pfn[ZONE_NORMAL] = max_pfn;
-
-	free_area_init(max_zone_pfn);
-
-	/* Initialize the kernel's ZERO_PGE. */
-	memset((void *)ZERO_PGE, 0, PAGE_SIZE);
-}
-- 
2.28.0

