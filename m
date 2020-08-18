Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A2248944
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHRPTP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgHRPTD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 11:19:03 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD4E207DE;
        Tue, 18 Aug 2020 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763940;
        bh=HcGhQXcsMUr5cgaYxz1IAZG8e/84FtB6msPEsabRt2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDvoo4F3xdOiwlNaD+/J1ZjOaH7ESbr1hE0fvBsuHz6p6nAtPNWFhz0COXBTbUvIF
         53SKsmr5Ln1OjKfxBEaAMrQw+ZGNnQ/UBuNQs5OESB9PTSnnbm9008JYdxOJMftxSe
         +4akvU6zOG564LseLC5Po/9DcXmlrQ8Xv/698q/8=
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
Subject: [PATCH v3 12/17] arch, drivers: replace for_each_membock() with for_each_mem_range()
Date:   Tue, 18 Aug 2020 18:16:29 +0300
Message-Id: <20200818151634.14343-13-rppt@kernel.org>
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
		start = __pfn_to_phys(memblock_region_memory_base_pfn(reg);
		end = __pfn_to_phys(memblock_region_memory_end_pfn(reg));

		/* do something with start and end */
	}

Using for_each_mem_range() iterator is more appropriate in such cases and
allows simpler and cleaner code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/kernel/setup.c                  | 18 ++++++---
 arch/arm/mm/mmu.c                        | 39 ++++++------------
 arch/arm/mm/pmsa-v7.c                    | 23 ++++++-----
 arch/arm/mm/pmsa-v8.c                    | 17 ++++----
 arch/arm/xen/mm.c                        |  7 ++--
 arch/arm64/mm/kasan_init.c               | 10 ++---
 arch/arm64/mm/mmu.c                      | 11 ++----
 arch/c6x/kernel/setup.c                  |  9 +++--
 arch/microblaze/mm/init.c                |  9 +++--
 arch/mips/cavium-octeon/dma-octeon.c     | 12 +++---
 arch/mips/kernel/setup.c                 | 31 +++++++--------
 arch/openrisc/mm/init.c                  |  8 ++--
 arch/powerpc/kernel/fadump.c             | 50 +++++++++++-------------
 arch/powerpc/kexec/file_load_64.c        | 10 ++---
 arch/powerpc/mm/book3s64/hash_utils.c    | 16 ++++----
 arch/powerpc/mm/book3s64/radix_pgtable.c | 10 ++---
 arch/powerpc/mm/kasan/kasan_init_32.c    |  8 ++--
 arch/powerpc/mm/mem.c                    | 16 +++++---
 arch/powerpc/mm/pgtable_32.c             |  8 ++--
 arch/riscv/mm/init.c                     | 25 +++++-------
 arch/riscv/mm/kasan_init.c               | 10 ++---
 arch/s390/kernel/setup.c                 | 23 +++++++----
 arch/s390/mm/vmem.c                      |  7 ++--
 arch/sparc/mm/init_64.c                  | 12 ++----
 drivers/bus/mvebu-mbus.c                 | 12 +++---
 25 files changed, 194 insertions(+), 207 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d8e18cdd96d3..3f65d0ac9f63 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -843,19 +843,25 @@ early_param("mem", early_mem);
 
 static void __init request_standard_resources(const struct machine_desc *mdesc)
 {
-	struct memblock_region *region;
+	phys_addr_t start, end, res_end;
 	struct resource *res;
+	u64 i;
 
 	kernel_code.start   = virt_to_phys(_text);
 	kernel_code.end     = virt_to_phys(__init_begin - 1);
 	kernel_data.start   = virt_to_phys(_sdata);
 	kernel_data.end     = virt_to_phys(_end - 1);
 
-	for_each_memblock(memory, region) {
-		phys_addr_t start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
-		phys_addr_t end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
+	for_each_mem_range(i, &start, &end) {
 		unsigned long boot_alias_start;
 
+		/*
+		 * In memblock, end points to the first byte after the
+		 * range while in resourses, end points to the last byte in
+		 * the range.
+		 */
+		res_end = end - 1;
+
 		/*
 		 * Some systems have a special memory alias which is only
 		 * used for booting.  We need to advertise this region to
@@ -869,7 +875,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 				      __func__, sizeof(*res));
 			res->name = "System RAM (boot alias)";
 			res->start = boot_alias_start;
-			res->end = phys_to_idmap(end);
+			res->end = phys_to_idmap(res_end);
 			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 			request_resource(&iomem_resource, res);
 		}
@@ -880,7 +886,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 			      sizeof(*res));
 		res->name  = "System RAM";
 		res->start = start;
-		res->end = end;
+		res->end = res_end;
 		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
 		request_resource(&iomem_resource, res);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c36f977b2ccb..698cc740c6b8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1154,9 +1154,8 @@ phys_addr_t arm_lowmem_limit __initdata = 0;
 
 void __init adjust_lowmem_bounds(void)
 {
-	phys_addr_t memblock_limit = 0;
-	u64 vmalloc_limit;
-	struct memblock_region *reg;
+	phys_addr_t block_start, block_end, memblock_limit = 0;
+	u64 vmalloc_limit, i;
 	phys_addr_t lowmem_limit = 0;
 
 	/*
@@ -1172,26 +1171,18 @@ void __init adjust_lowmem_bounds(void)
 	 * The first usable region must be PMD aligned. Mark its start
 	 * as MEMBLOCK_NOMAP if it isn't
 	 */
-	for_each_memblock(memory, reg) {
-		if (!memblock_is_nomap(reg)) {
-			if (!IS_ALIGNED(reg->base, PMD_SIZE)) {
-				phys_addr_t len;
+	for_each_mem_range(i, &block_start, &block_end) {
+		if (!IS_ALIGNED(block_start, PMD_SIZE)) {
+			phys_addr_t len;
 
-				len = round_up(reg->base, PMD_SIZE) - reg->base;
-				memblock_mark_nomap(reg->base, len);
-			}
-			break;
+			len = round_up(block_start, PMD_SIZE) - block_start;
+			memblock_mark_nomap(block_start, len);
 		}
+		break;
 	}
 
-	for_each_memblock(memory, reg) {
-		phys_addr_t block_start = reg->base;
-		phys_addr_t block_end = reg->base + reg->size;
-
-		if (memblock_is_nomap(reg))
-			continue;
-
-		if (reg->base < vmalloc_limit) {
+	for_each_mem_range(i, &block_start, &block_end) {
+		if (block_start < vmalloc_limit) {
 			if (block_end > lowmem_limit)
 				/*
 				 * Compare as u64 to ensure vmalloc_limit does
@@ -1440,19 +1431,15 @@ static void __init kmap_init(void)
 
 static void __init map_lowmem(void)
 {
-	struct memblock_region *reg;
 	phys_addr_t kernel_x_start = round_down(__pa(KERNEL_START), SECTION_SIZE);
 	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+	phys_addr_t start, end;
+	u64 i;
 
 	/* Map all the lowmem memory banks. */
-	for_each_memblock(memory, reg) {
-		phys_addr_t start = reg->base;
-		phys_addr_t end = start + reg->size;
+	for_each_mem_range(i, &start, &end) {
 		struct map_desc map;
 
-		if (memblock_is_nomap(reg))
-			continue;
-
 		if (end > arm_lowmem_limit)
 			end = arm_lowmem_limit;
 		if (start >= end)
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 699fa2e88725..dbb2422321a6 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -231,12 +231,12 @@ static int __init allocate_region(phys_addr_t base, phys_addr_t size,
 void __init pmsav7_adjust_lowmem_bounds(void)
 {
 	phys_addr_t  specified_mem_size = 0, total_mem_size = 0;
-	struct memblock_region *reg;
-	bool first = true;
 	phys_addr_t mem_start;
 	phys_addr_t mem_end;
+	phys_addr_t reg_start, reg_end;
 	unsigned int mem_max_regions;
-	int num, i;
+	int num;
+	u64 i;
 
 	/* Free-up PMSAv7_PROBE_REGION */
 	mpu_min_region_order = __mpu_min_region_order();
@@ -262,20 +262,19 @@ void __init pmsav7_adjust_lowmem_bounds(void)
 	mem_max_regions -= num;
 #endif
 
-	for_each_memblock(memory, reg) {
-		if (first) {
+	for_each_mem_range(i, &reg_start, &reg_end) {
+		if (i == 0) {
 			phys_addr_t phys_offset = PHYS_OFFSET;
 
 			/*
 			 * Initially only use memory continuous from
 			 * PHYS_OFFSET */
-			if (reg->base != phys_offset)
+			if (reg_start != phys_offset)
 				panic("First memory bank must be contiguous from PHYS_OFFSET");
 
-			mem_start = reg->base;
-			mem_end = reg->base + reg->size;
-			specified_mem_size = reg->size;
-			first = false;
+			mem_start = reg_start;
+			mem_end = reg_end
+			specified_mem_size = mem_end - mem_start;
 		} else {
 			/*
 			 * memblock auto merges contiguous blocks, remove
@@ -283,8 +282,8 @@ void __init pmsav7_adjust_lowmem_bounds(void)
 			 * blocks separately while iterating)
 			 */
 			pr_notice("Ignoring RAM after %pa, memory at %pa ignored\n",
-				  &mem_end, &reg->base);
-			memblock_remove(reg->base, 0 - reg->base);
+				  &mem_end, &reg_start);
+			memblock_remove(reg_start, 0 - reg_start);
 			break;
 		}
 	}
diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
index 0d7d5fb59247..2de019f7503e 100644
--- a/arch/arm/mm/pmsa-v8.c
+++ b/arch/arm/mm/pmsa-v8.c
@@ -94,20 +94,19 @@ static __init bool is_region_fixed(int number)
 void __init pmsav8_adjust_lowmem_bounds(void)
 {
 	phys_addr_t mem_end;
-	struct memblock_region *reg;
-	bool first = true;
+	phys_addr_t reg_start, reg_end;
+	u64 i;
 
-	for_each_memblock(memory, reg) {
-		if (first) {
+	for_each_mem_range(i, &reg_start, &reg_end) {
+		if (i == 0) {
 			phys_addr_t phys_offset = PHYS_OFFSET;
 
 			/*
 			 * Initially only use memory continuous from
 			 * PHYS_OFFSET */
-			if (reg->base != phys_offset)
+			if (reg_start != phys_offset)
 				panic("First memory bank must be contiguous from PHYS_OFFSET");
-			mem_end = reg->base + reg->size;
-			first = false;
+			mem_end = reg_end;
 		} else {
 			/*
 			 * memblock auto merges contiguous blocks, remove
@@ -115,8 +114,8 @@ void __init pmsav8_adjust_lowmem_bounds(void)
 			 * blocks separately while iterating)
 			 */
 			pr_notice("Ignoring RAM after %pa, memory at %pa ignored\n",
-				  &mem_end, &reg->base);
-			memblock_remove(reg->base, 0 - reg->base);
+				  &mem_end, &reg_start);
+			memblock_remove(reg_start, 0 - reg_start);
 			break;
 		}
 	}
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 396797ffe2b1..d3ef975a0965 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -25,11 +25,12 @@
 
 unsigned long xen_get_swiotlb_free_pages(unsigned int order)
 {
-	struct memblock_region *reg;
+	phys_addr_t base;
 	gfp_t flags = __GFP_NOWARN|__GFP_KSWAPD_RECLAIM;
+	u64 i;
 
-	for_each_memblock(memory, reg) {
-		if (reg->base < (phys_addr_t)0xffffffff) {
+	for_each_mem_range(i, &base, NULL) {
+		if (base < (phys_addr_t)0xffffffff) {
 			if (IS_ENABLED(CONFIG_ZONE_DMA32))
 				flags |= __GFP_DMA32;
 			else
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 7291b26ce788..b24e43d20667 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -212,8 +212,8 @@ void __init kasan_init(void)
 {
 	u64 kimg_shadow_start, kimg_shadow_end;
 	u64 mod_shadow_start, mod_shadow_end;
-	struct memblock_region *reg;
-	int i;
+	phys_addr_t pa_start, pa_end;
+	u64 i;
 
 	kimg_shadow_start = (u64)kasan_mem_to_shadow(_text) & PAGE_MASK;
 	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(_end));
@@ -246,9 +246,9 @@ void __init kasan_init(void)
 		kasan_populate_early_shadow((void *)mod_shadow_end,
 					    (void *)kimg_shadow_start);
 
-	for_each_memblock(memory, reg) {
-		void *start = (void *)__phys_to_virt(reg->base);
-		void *end = (void *)__phys_to_virt(reg->base + reg->size);
+	for_each_mem_range(i, &pa_start, &pa_end) {
+		void *start = (void *)__phys_to_virt(pa_start);
+		void *end = (void *)__phys_to_virt(pa_end);
 
 		if (start >= end)
 			break;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..64211436629d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -462,8 +462,9 @@ static void __init map_mem(pgd_t *pgdp)
 {
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
-	struct memblock_region *reg;
+	phys_addr_t start, end;
 	int flags = 0;
+	u64 i;
 
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
@@ -482,15 +483,9 @@ static void __init map_mem(pgd_t *pgdp)
 #endif
 
 	/* map all the memory banks */
-	for_each_memblock(memory, reg) {
-		phys_addr_t start = reg->base;
-		phys_addr_t end = start + reg->size;
-
+	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
 			break;
-		if (memblock_is_nomap(reg))
-			continue;
-
 		__map_memblock(pgdp, start, end, PAGE_KERNEL, flags);
 	}
 
diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
index 8ef35131f999..9254c3b794a5 100644
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@ -287,7 +287,8 @@ notrace void __init machine_init(unsigned long dt_ptr)
 
 void __init setup_arch(char **cmdline_p)
 {
-	struct memblock_region *reg;
+	phys_addr_t start, end;
+	u64 i;
 
 	printk(KERN_INFO "Initializing kernel\n");
 
@@ -351,9 +352,9 @@ void __init setup_arch(char **cmdline_p)
 	disable_caching(ram_start, ram_end - 1);
 
 	/* Set caching of external RAM used by Linux */
-	for_each_memblock(memory, reg)
-		enable_caching(CACHE_REGION_START(reg->base),
-			       CACHE_REGION_START(reg->base + reg->size - 1));
+	for_each_mem_range(i, &start, &end)
+		enable_caching(CACHE_REGION_START(start),
+			       CACHE_REGION_START(end - 1));
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/*
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 49e0c241f9b1..15403b5adfcf 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -106,13 +106,14 @@ static void __init paging_init(void)
 void __init setup_memory(void)
 {
 #ifndef CONFIG_MMU
-	struct memblock_region *reg;
 	u32 kernel_align_start, kernel_align_size;
+	phys_addr_t start, end;
+	u64 i;
 
 	/* Find main memory where is the kernel */
-	for_each_memblock(memory, reg) {
-		memory_start = (u32)reg->base;
-		lowmem_size = reg->size;
+	for_each_mem_range(i, &start, &end) {
+		memory_start = start;
+		lowmem_size = end - start;
 		if ((memory_start <= (u32)_text) &&
 			((u32)_text <= (memory_start + lowmem_size - 1))) {
 			memory_size = lowmem_size;
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 14ea680d180e..d938c1f7c1e1 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -190,25 +190,25 @@ char *octeon_swiotlb;
 
 void __init plat_swiotlb_setup(void)
 {
-	struct memblock_region *mem;
+	phys_addr_t start, end;
 	phys_addr_t max_addr;
 	phys_addr_t addr_size;
 	size_t swiotlbsize;
 	unsigned long swiotlb_nslabs;
+	u64 i;
 
 	max_addr = 0;
 	addr_size = 0;
 
-	for_each_memblock(memory, mem) {
+	for_each_mem_range(i, &start, &end) {
 		/* These addresses map low for PCI. */
 		if (mem->base > 0x410000000ull && !OCTEON_IS_OCTEON2())
 			continue;
 
-		addr_size += mem->size;
-
-		if (max_addr < mem->base + mem->size)
-			max_addr = mem->base + mem->size;
+		addr_size += (end - start);
 
+		if (max_addr < end)
+			max_addr = end;
 	}
 
 	swiotlbsize = PAGE_SIZE;
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bf5f5acab0a8..335bd188b8b4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -300,8 +300,9 @@ static void __init bootmem_init(void)
 
 static void __init bootmem_init(void)
 {
-	struct memblock_region *mem;
 	phys_addr_t ramstart, ramend;
+	phys_addr_t start, end;
+	u64 i;
 
 	ramstart = memblock_start_of_DRAM();
 	ramend = memblock_end_of_DRAM();
@@ -338,18 +339,13 @@ static void __init bootmem_init(void)
 
 	min_low_pfn = ARCH_PFN_OFFSET;
 	max_pfn = PFN_DOWN(ramend);
-	for_each_memblock(memory, mem) {
-		unsigned long start = memblock_region_memory_base_pfn(mem);
-		unsigned long end = memblock_region_memory_end_pfn(mem);
-
+	for_each_mem_range(i, &start, &end) {
 		/*
 		 * Skip highmem here so we get an accurate max_low_pfn if low
 		 * memory stops short of high memory.
 		 * If the region overlaps HIGHMEM_START, end is clipped so
 		 * max_pfn excludes the highmem portion.
 		 */
-		if (memblock_is_nomap(mem))
-			continue;
 		if (start >= PFN_DOWN(HIGHMEM_START))
 			continue;
 		if (end > PFN_DOWN(HIGHMEM_START))
@@ -450,13 +446,12 @@ early_param("memmap", early_parse_memmap);
 unsigned long setup_elfcorehdr, setup_elfcorehdr_size;
 static int __init early_parse_elfcorehdr(char *p)
 {
-	struct memblock_region *mem;
+	phys_addr_t start, end;
+	u64 i;
 
 	setup_elfcorehdr = memparse(p, &p);
 
-	 for_each_memblock(memory, mem) {
-		unsigned long start = mem->base;
-		unsigned long end = start + mem->size;
+	for_each_mem_range(i, &start, &end) {
 		if (setup_elfcorehdr >= start && setup_elfcorehdr < end) {
 			/*
 			 * Reserve from the elf core header to the end of
@@ -720,7 +715,8 @@ static void __init arch_mem_init(char **cmdline_p)
 
 static void __init resource_init(void)
 {
-	struct memblock_region *region;
+	phys_addr_t start, end;
+	u64 i;
 
 	if (UNCAC_BASE != IO_BASE)
 		return;
@@ -732,9 +728,7 @@ static void __init resource_init(void)
 	bss_resource.start = __pa_symbol(&__bss_start);
 	bss_resource.end = __pa_symbol(&__bss_stop) - 1;
 
-	for_each_memblock(memory, region) {
-		phys_addr_t start = PFN_PHYS(memblock_region_memory_base_pfn(region));
-		phys_addr_t end = PFN_PHYS(memblock_region_memory_end_pfn(region)) - 1;
+	for_each_mem_range(i, &start, &end) {
 		struct resource *res;
 
 		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
@@ -743,7 +737,12 @@ static void __init resource_init(void)
 			      sizeof(struct resource));
 
 		res->start = start;
-		res->end = end;
+		/*
+		 * In memblock, end points to the first byte after the
+		 * range while in resourses, end points to the last byte in
+		 * the range.
+		 */
+		res->end = end - 1;
 		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 		res->name = "System RAM";
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 3d7c79c7745d..8348feaaf46e 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -64,6 +64,7 @@ extern const char _s_kernel_ro[], _e_kernel_ro[];
  */
 static void __init map_ram(void)
 {
+	phys_addr_t start, end;
 	unsigned long v, p, e;
 	pgprot_t prot;
 	pgd_t *pge;
@@ -71,6 +72,7 @@ static void __init map_ram(void)
 	pud_t *pue;
 	pmd_t *pme;
 	pte_t *pte;
+	u64 i;
 	/* These mark extents of read-only kernel pages...
 	 * ...from vmlinux.lds.S
 	 */
@@ -78,9 +80,9 @@ static void __init map_ram(void)
 
 	v = PAGE_OFFSET;
 
-	for_each_memblock(memory, region) {
-		p = (u32) region->base & PAGE_MASK;
-		e = p + (u32) region->size;
+	for_each_mem_range(i, &start, &end) {
+		p = (u32) start & PAGE_MASK;
+		e = (u32) end;
 
 		v = (u32) __va(p);
 		pge = pgd_offset_k(v);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index e469b150be21..5cdf4168a61a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -191,13 +191,13 @@ int is_fadump_active(void)
  */
 static bool is_fadump_mem_area_contiguous(u64 d_start, u64 d_end)
 {
-	struct memblock_region *reg;
+	phys_addr_t reg_start, reg_end;
 	bool ret = false;
-	u64 start, end;
+	u64 i, start, end;
 
-	for_each_memblock(memory, reg) {
-		start = max_t(u64, d_start, reg->base);
-		end = min_t(u64, d_end, (reg->base + reg->size));
+	for_each_mem_range(i, &reg_start, &reg_end) {
+		start = max_t(u64, d_start, reg_start);
+		end = min_t(u64, d_end, reg_end);
 		if (d_start < end) {
 			/* Memory hole from d_start to start */
 			if (start > d_start)
@@ -422,34 +422,34 @@ static int __init add_boot_mem_regions(unsigned long mstart,
 
 static int __init fadump_get_boot_mem_regions(void)
 {
-	unsigned long base, size, cur_size, hole_size, last_end;
+	unsigned long size, cur_size, hole_size, last_end;
 	unsigned long mem_size = fw_dump.boot_memory_size;
-	struct memblock_region *reg;
+	phys_addr_t reg_start, reg_end;
 	int ret = 1;
+	u64 i;
 
 	fw_dump.boot_mem_regs_cnt = 0;
 
 	last_end = 0;
 	hole_size = 0;
 	cur_size = 0;
-	for_each_memblock(memory, reg) {
-		base = reg->base;
-		size = reg->size;
-		hole_size += (base - last_end);
+	for_each_mem_range(i, &reg_start, &reg_end) {
+		size = reg_end - reg_start;
+		hole_size += (reg_start - last_end);
 
 		if ((cur_size + size) >= mem_size) {
 			size = (mem_size - cur_size);
-			ret = add_boot_mem_regions(base, size);
+			ret = add_boot_mem_regions(reg_start, size);
 			break;
 		}
 
 		mem_size -= size;
 		cur_size += size;
-		ret = add_boot_mem_regions(base, size);
+		ret = add_boot_mem_regions(reg_start, size);
 		if (!ret)
 			break;
 
-		last_end = base + size;
+		last_end = reg_end;
 	}
 	fw_dump.boot_mem_top = PAGE_ALIGN(fw_dump.boot_memory_size + hole_size);
 
@@ -985,9 +985,8 @@ static int fadump_init_elfcore_header(char *bufp)
  */
 static int fadump_setup_crash_memory_ranges(void)
 {
-	struct memblock_region *reg;
-	u64 start, end;
-	int i, ret;
+	u64 i, start, end;
+	int ret;
 
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mrange_info.mem_range_cnt = 0;
@@ -1005,10 +1004,7 @@ static int fadump_setup_crash_memory_ranges(void)
 			return ret;
 	}
 
-	for_each_memblock(memory, reg) {
-		start = (u64)reg->base;
-		end = start + (u64)reg->size;
-
+	for_each_mem_range(i, &start, &end) {
 		/*
 		 * skip the memory chunk that is already added
 		 * (0 through boot_memory_top).
@@ -1242,7 +1238,9 @@ static void fadump_free_reserved_memory(unsigned long start_pfn,
  */
 static void fadump_release_reserved_area(u64 start, u64 end)
 {
-	u64 tstart, tend, spfn, epfn, reg_spfn, reg_epfn, i;
+	unsigned long reg_spfn, reg_epfn;
+	u64 tstart, tend, spfn, epfn;
+	int i;
 
 	spfn = PHYS_PFN(start);
 	epfn = PHYS_PFN(end);
@@ -1685,12 +1683,10 @@ int __init fadump_reserve_mem(void)
 /* Preserve everything above the base address */
 static void __init fadump_reserve_crash_area(u64 base)
 {
-	struct memblock_region *reg;
-	u64 mstart, msize;
+	u64 i, mstart, mend, msize;
 
-	for_each_memblock(memory, reg) {
-		mstart = reg->base;
-		msize  = reg->size;
+	for_each_mem_range(i, &mstart, &mend) {
+		msize  = mend - mstart;
 
 		if ((mstart + msize) < base)
 			continue;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 2c9d908eab96..c69bcf9b547a 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -138,15 +138,13 @@ static int get_usable_memory_ranges(struct crash_mem **mem_ranges)
  */
 static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 {
-	struct memblock_region *reg;
+	phys_addr_t base, end;
 	struct crash_mem *tmem;
+	u64 i;
 	int ret;
 
-	for_each_memblock(memory, reg) {
-		u64 base, size;
-
-		base = (u64)reg->base;
-		size = (u64)reg->size;
+	for_each_mem_range(i, &base, &end) {
+		u64 size = end - base;
 
 		/* Skip backup memory region, which needs a separate entry */
 		if (base == BACKUP_SRC_START) {
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 1da9dbba9217..dc40df065698 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -7,7 +7,7 @@
  *
  * SMP scalability work:
  *    Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
- * 
+ *
  *    Module name: htab.c
  *
  *    Description:
@@ -865,8 +865,8 @@ static void __init htab_initialize(void)
 	unsigned long table;
 	unsigned long pteg_count;
 	unsigned long prot;
-	unsigned long base = 0, size = 0;
-	struct memblock_region *reg;
+	phys_addr_t base = 0, size = 0, end;
+	u64 i;
 
 	DBG(" -> htab_initialize()\n");
 
@@ -882,7 +882,7 @@ static void __init htab_initialize(void)
 	/*
 	 * Calculate the required size of the htab.  We want the number of
 	 * PTEGs to equal one half the number of real pages.
-	 */ 
+	 */
 	htab_size_bytes = htab_get_table_size();
 	pteg_count = htab_size_bytes >> 7;
 
@@ -892,7 +892,7 @@ static void __init htab_initialize(void)
 	    firmware_has_feature(FW_FEATURE_PS3_LV1)) {
 		/* Using a hypervisor which owns the htab */
 		htab_address = NULL;
-		_SDR1 = 0; 
+		_SDR1 = 0;
 #ifdef CONFIG_FA_DUMP
 		/*
 		 * If firmware assisted dump is active firmware preserves
@@ -958,9 +958,9 @@ static void __init htab_initialize(void)
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 	/* create bolted the linear mapping in the hash table */
-	for_each_memblock(memory, reg) {
-		base = (unsigned long)__va(reg->base);
-		size = reg->size;
+	for_each_mem_range(i, &base, &end) {
+		size = end - base;
+		base = (unsigned long)__va(base);
 
 		DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
 		    base, size, prot);
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 28c784976bed..d2dae4d61552 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -329,7 +329,8 @@ static int __meminit create_physical_mapping(unsigned long start,
 static void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
-	struct memblock_region *reg;
+	phys_addr_t start, end;
+	u64 i;
 
 	/* We don't support slb for radix */
 	mmu_slb_size = 0;
@@ -337,20 +338,19 @@ static void __init radix_init_pgtable(void)
 	/*
 	 * Create the linear mapping
 	 */
-	for_each_memblock(memory, reg) {
+	for_each_mem_range(i, &start, &end) {
 		/*
 		 * The memblock allocator  is up at this point, so the
 		 * page tables will be allocated within the range. No
 		 * need or a node (which we don't have yet).
 		 */
 
-		if ((reg->base + reg->size) >= RADIX_VMALLOC_START) {
+		if (end >= RADIX_VMALLOC_START) {
 			pr_warn("Outside the supported range\n");
 			continue;
 		}
 
-		WARN_ON(create_physical_mapping(reg->base,
-						reg->base + reg->size,
+		WARN_ON(create_physical_mapping(start, end,
 						radix_mem_block_size,
 						-1, PAGE_KERNEL));
 	}
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index fb294046e00e..26fda3203320 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -138,11 +138,11 @@ void __init kasan_mmu_init(void)
 
 void __init kasan_init(void)
 {
-	struct memblock_region *reg;
+	phys_addr_t base, end;
+	u64 i;
 
-	for_each_memblock(memory, reg) {
-		phys_addr_t base = reg->base;
-		phys_addr_t top = min(base + reg->size, total_lowmem);
+	for_each_mem_range(i, &base, &end) {
+		phys_addr_t top = min(end, total_lowmem);
 		int ret;
 
 		if (base >= top)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 80df329f180e..5e2e7c0a8f1a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -585,20 +585,24 @@ void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
  */
 static int __init add_system_ram_resources(void)
 {
-	struct memblock_region *reg;
+	phys_addr_t start, end;
+	u64 i;
 
-	for_each_memblock(memory, reg) {
+	for_each_mem_range(i, &start, &end) {
 		struct resource *res;
-		unsigned long base = reg->base;
-		unsigned long size = reg->size;
 
 		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 		WARN_ON(!res);
 
 		if (res) {
 			res->name = "System RAM";
-			res->start = base;
-			res->end = base + size - 1;
+			res->start = start;
+			/*
+			 * In memblock, end points to the first byte after
+			 * the range while in resourses, end points to the
+			 * last byte in the range.
+			 */
+			res->end = end - 1;
 			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 			WARN_ON(request_resource(&iomem_resource, res) < 0);
 		}
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6eb4eab79385..079159e97bca 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -123,11 +123,11 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 
 void __init mapin_ram(void)
 {
-	struct memblock_region *reg;
+	phys_addr_t base, end;
+	u64 i;
 
-	for_each_memblock(memory, reg) {
-		phys_addr_t base = reg->base;
-		phys_addr_t top = min(base + reg->size, total_lowmem);
+	for_each_mem_range(i, &base, &end) {
+		phys_addr_t top = min(end, total_lowmem);
 
 		if (base >= top)
 			continue;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0485cfaacc72..06355716d19a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -145,21 +145,21 @@ static phys_addr_t dtb_early_pa __initdata;
 
 void __init setup_bootmem(void)
 {
-	struct memblock_region *reg;
 	phys_addr_t mem_size = 0;
 	phys_addr_t total_mem = 0;
-	phys_addr_t mem_start, end = 0;
+	phys_addr_t mem_start, start, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
+	u64 i;
 
 	/* Find the memory region containing the kernel */
-	for_each_memblock(memory, reg) {
-		end = reg->base + reg->size;
+	for_each_mem_range(i, &start, &end) {
+		phys_addr_t size = end - start;
 		if (!total_mem)
-			mem_start = reg->base;
-		if (reg->base <= vmlinux_start && vmlinux_end <= end)
-			BUG_ON(reg->size == 0);
-		total_mem = total_mem + reg->size;
+			mem_start = start;
+		if (start <= vmlinux_start && vmlinux_end <= end)
+			BUG_ON(size == 0);
+		total_mem = total_mem + size;
 	}
 
 	/*
@@ -456,7 +456,7 @@ static void __init setup_vm_final(void)
 {
 	uintptr_t va, map_size;
 	phys_addr_t pa, start, end;
-	struct memblock_region *reg;
+	u64 i;
 
 	/* Set mmu_enabled flag */
 	mmu_enabled = true;
@@ -467,14 +467,9 @@ static void __init setup_vm_final(void)
 			   PGDIR_SIZE, PAGE_TABLE);
 
 	/* Map all memory banks */
-	for_each_memblock(memory, reg) {
-		start = reg->base;
-		end = start + reg->size;
-
+	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
 			break;
-		if (memblock_is_nomap(reg))
-			continue;
 		if (start <= __pa(PAGE_OFFSET) &&
 		    __pa(PAGE_OFFSET) < end)
 			start = __pa(PAGE_OFFSET);
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 87b4ab3d3c77..12ddd1f6bf70 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -85,16 +85,16 @@ static void __init populate(void *start, void *end)
 
 void __init kasan_init(void)
 {
-	struct memblock_region *reg;
-	unsigned long i;
+	phys_addr_t _start, _end;
+	u64 i;
 
 	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
 				    (void *)kasan_mem_to_shadow((void *)
 								VMALLOC_END));
 
-	for_each_memblock(memory, reg) {
-		void *start = (void *)__va(reg->base);
-		void *end = (void *)__va(reg->base + reg->size);
+	for_each_mem_range(i, &_start, &_end) {
+		void *start = (void *)_start;
+		void *end = (void *)_end;
 
 		if (start >= end)
 			break;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 68089eabae27..b416a64991b0 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -484,8 +484,9 @@ static struct resource __initdata *standard_resources[] = {
 static void __init setup_resources(void)
 {
 	struct resource *res, *std_res, *sub_res;
-	struct memblock_region *reg;
+	phys_addr_t start, end;
 	int j;
+	u64 i;
 
 	code_resource.start = (unsigned long) _text;
 	code_resource.end = (unsigned long) _etext - 1;
@@ -494,7 +495,7 @@ static void __init setup_resources(void)
 	bss_resource.start = (unsigned long) __bss_start;
 	bss_resource.end = (unsigned long) __bss_stop - 1;
 
-	for_each_memblock(memory, reg) {
+	for_each_mem_range(i, &start, &end) {
 		res = memblock_alloc(sizeof(*res), 8);
 		if (!res)
 			panic("%s: Failed to allocate %zu bytes align=0x%x\n",
@@ -502,8 +503,13 @@ static void __init setup_resources(void)
 		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
 
 		res->name = "System RAM";
-		res->start = reg->base;
-		res->end = reg->base + reg->size - 1;
+		res->start = start;
+		/*
+		 * In memblock, end points to the first byte after the
+		 * range while in resourses, end points to the last byte in
+		 * the range.
+		 */
+		res->end = end - 1;
 		request_resource(&iomem_resource, res);
 
 		for (j = 0; j < ARRAY_SIZE(standard_resources); j++) {
@@ -819,14 +825,15 @@ static void __init reserve_kernel(void)
 
 static void __init setup_memory(void)
 {
-	struct memblock_region *reg;
+	phys_addr_t start, end;
+	u64 i;
 
 	/*
 	 * Init storage key for present memory
 	 */
-	for_each_memblock(memory, reg) {
-		storage_key_init_range(reg->base, reg->base + reg->size);
-	}
+	for_each_mem_range(i, &start, &end)
+		storage_key_init_range(start, end);
+
 	psw_set_key(PAGE_DEFAULT_KEY);
 
 	/* Only cosmetics */
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 1aed1a4dfc2d..67a614a9b77c 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -554,10 +554,11 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
  */
 void __init vmem_map_init(void)
 {
-	struct memblock_region *reg;
+	phys_addr_t base, end;
+	u64 i;
 
-	for_each_memblock(memory, reg)
-		vmem_add_range(reg->base, reg->size);
+	for_each_mem_range(i, &base, &end)
+		vmem_add_range(base, end - base);
 	__set_memory((unsigned long)_stext,
 		     (unsigned long)(_etext - _stext) >> PAGE_SHIFT,
 		     SET_MEMORY_RO | SET_MEMORY_X);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index fad6d3129904..96edf64d4fb3 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1192,18 +1192,14 @@ int of_node_to_nid(struct device_node *dp)
 
 static void __init add_node_ranges(void)
 {
-	struct memblock_region *reg;
+	phys_addr_t start, end;
 	unsigned long prev_max;
+	u64 i;
 
 memblock_resized:
 	prev_max = memblock.memory.max;
 
-	for_each_memblock(memory, reg) {
-		unsigned long size = reg->size;
-		unsigned long start, end;
-
-		start = reg->base;
-		end = start + size;
+	for_each_mem_range(i, &start, &end) {
 		while (start < end) {
 			unsigned long this_end;
 			int nid;
@@ -1211,7 +1207,7 @@ static void __init add_node_ranges(void)
 			this_end = memblock_nid_range(start, end, &nid);
 
 			numadbg("Setting memblock NUMA node nid[%d] "
-				"start[%lx] end[%lx]\n",
+				"start[%llx] end[%lx]\n",
 				nid, start, this_end);
 
 			memblock_set_node(start, this_end - start,
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 5b2a11a88951..2519ceede64b 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -610,23 +610,23 @@ static unsigned int armada_xp_mbus_win_remap_offset(int win)
 static void __init
 mvebu_mbus_find_bridge_hole(uint64_t *start, uint64_t *end)
 {
-	struct memblock_region *r;
-	uint64_t s = 0;
+	phys_addr_t reg_start, reg_end;
+	uint64_t i, s = 0;
 
-	for_each_memblock(memory, r) {
+	for_each_mem_range(i, &reg_start, &reg_end) {
 		/*
 		 * This part of the memory is above 4 GB, so we don't
 		 * care for the MBus bridge hole.
 		 */
-		if (r->base >= 0x100000000ULL)
+		if (reg_start >= 0x100000000ULL)
 			continue;
 
 		/*
 		 * The MBus bridge hole is at the end of the RAM under
 		 * the 4 GB limit.
 		 */
-		if (r->base + r->size > s)
-			s = r->base + r->size;
+		if (reg_end > s)
+			s = reg_end;
 	}
 
 	*start = s;
-- 
2.26.2

