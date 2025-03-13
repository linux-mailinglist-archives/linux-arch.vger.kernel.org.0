Return-Path: <linux-arch+bounces-10732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0451A5F6D3
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B54171A00
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EA2686BC;
	Thu, 13 Mar 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8Dew2qC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D905FB95;
	Thu, 13 Mar 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873957; cv=none; b=VCZbM2G9R3F7NzWMXqFfJ2t7ZCnPCsYdi6Ujiw+0IUC/CecsI/19anWUe4PhRbeCYFnuOZb7I/5/Iq8q8G/E2Ay+nv0PSit2TdhanmGV3WKSfM1fKmuVPY86hSqWJp6w9qKTJxZIRd8Xy0btkjgC0qdga4GGfltg1gY9MTXqISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873957; c=relaxed/simple;
	bh=AJy7soDO62Dzi3ius9ZjscPriJ9EidlW3P37gpc6oBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfmhfKJvWozv1mINc4T8W1dioznnXOQ28a4C7bg7QbX8P6nIjEO3tSmOajPs1TmLbf2sfOMP38AgmHw3S/9GXss6O3IExl4WTNIgO7gTUfihONPqPL84I9Bdfh1uwRS7j5O4iYh8DVWkPNTJMcJJTstwT0CpGzUr2wI2QK5P4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8Dew2qC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252EEC4CEEF;
	Thu, 13 Mar 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873957;
	bh=AJy7soDO62Dzi3ius9ZjscPriJ9EidlW3P37gpc6oBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8Dew2qCwikkr9LKylOdLOo1BePD6vBt84quP1/KvYoZxzxlZRcB3i/RExMqjS3Vy
	 YMWXLgyGaheY1cCgEwrhW+5HdX99rZqqWo2leOAFfBYEa7B9A/QOmY05M9pc6BMjfp
	 fD5RSO7BJvp7ghHODdMxkxYIwWZc3VxaLqmS3Np48/dp+vRCehkW2TdkTliOvI1CVF
	 a1HmWddzs5ZTUdEOfnWUq/WsgMmZJUvfW1csWM8pi0gurR8CfzpwvjEBHADErqJT1i
	 wkHhCAuNw/YklaxM7TWdU0myoqMm9rsk8wAetp9u1U8Q8q2uav4/D/uqPSXyCwQ3Hk
	 eZVrApQmrACkQ==
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
Subject: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Date: Thu, 13 Mar 2025 15:50:00 +0200
Message-ID: <20250313135003.836600-11-rppt@kernel.org>
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

high_memory defines upper bound on the directly mapped memory.
This bound is defined by the beginning of ZONE_HIGHMEM when a system has
high memory and by the end of memory otherwise.

All this is known to generic memory management initialization code that
can set high_memory while initializing core mm structures.

Add a generic calculation of high_memory to free_area_init() and remove
per-architecture calculation except for the architectures that set and
use high_memory earlier than that.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>	# x86
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/alpha/mm/init.c         |  1 -
 arch/arc/mm/init.c           |  2 --
 arch/arm64/mm/init.c         |  2 --
 arch/csky/mm/init.c          |  1 -
 arch/hexagon/mm/init.c       |  6 ------
 arch/loongarch/kernel/numa.c |  1 -
 arch/loongarch/mm/init.c     |  2 --
 arch/microblaze/mm/init.c    |  2 --
 arch/mips/mm/init.c          |  2 --
 arch/nios2/mm/init.c         |  6 ------
 arch/openrisc/mm/init.c      |  2 --
 arch/parisc/mm/init.c        |  1 -
 arch/riscv/mm/init.c         |  1 -
 arch/s390/mm/init.c          |  2 --
 arch/sh/mm/init.c            |  7 -------
 arch/sparc/mm/init_32.c      |  1 -
 arch/sparc/mm/init_64.c      |  2 --
 arch/um/kernel/um_arch.c     |  1 -
 arch/x86/kernel/setup.c      |  2 --
 arch/x86/mm/init_32.c        |  3 ---
 arch/x86/mm/numa_32.c        |  3 ---
 arch/xtensa/mm/init.c        |  2 --
 mm/memory.c                  |  8 --------
 mm/mm_init.c                 | 30 ++++++++++++++++++++++++++++++
 mm/nommu.c                   |  2 --
 25 files changed, 30 insertions(+), 62 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index ec0eeae9c653..3ab2d2f3c917 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -276,7 +276,6 @@ srm_paging_stop (void)
 void __init
 mem_init(void)
 {
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	memblock_free_all();
 }
 
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 7ef883d58dc1..05025122e965 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -150,8 +150,6 @@ void __init setup_arch_memory(void)
 	 */
 	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
 
-	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
-
 	arch_pfn_offset = min(min_low_pfn, min_high_pfn);
 	kmap_init();
 #endif /* CONFIG_HIGHMEM */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9c0b8d9558fc..a48fcccd67fa 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -314,8 +314,6 @@ void __init arm64_memblock_init(void)
 	}
 
 	early_init_fdt_scan_reserved_mem();
-
-	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
 void __init bootmem_init(void)
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index ba6694d6170a..a22801aa503a 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -47,7 +47,6 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 	unsigned long tmp;
 #endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	memblock_free_all();
 
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 508bb6a8dcc9..d412c2314509 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -100,12 +100,6 @@ static void __init paging_init(void)
 	 * initial kernel segment table's physical address.
 	 */
 	init_mm.context.ptbase = __pa(init_mm.pgd);
-
-	/*
-	 * Start of high memory area.  Will probably need something more
-	 * fancy if we...  get more fancy.
-	 */
-	high_memory = (void *)((bootmem_lastpg + 1) << PAGE_SHIFT);
 }
 
 #ifndef DMA_RESERVE
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 84fe7f854820..8eb489725b1a 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -389,7 +389,6 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 	memblock_free_all();
 }
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 00449df50db1..6affa3609188 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -78,8 +78,6 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-
 	memblock_free_all();
 }
 #endif /* !CONFIG_NUMA */
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 857cd2b44bcf..7e2e342e84c5 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -120,8 +120,6 @@ void __init setup_memory(void)
 
 void __init mem_init(void)
 {
-	high_memory = (void *)__va(memory_start + lowmem_size - 1);
-
 	/* this will put all memory onto the freelists */
 	memblock_free_all();
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index eb61a73520a0..ed9dde6a00f7 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -417,7 +417,6 @@ void __init paging_init(void)
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
 #endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	free_area_init(max_zone_pfns);
 }
@@ -469,7 +468,6 @@ void __init mem_init(void)
 #else  /* CONFIG_NUMA */
 void __init mem_init(void)
 {
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
 	setup_zero_pages();	/* This comes from node 0 */
 	memblock_free_all();
 }
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 3cafa87ead9e..4ba8dfa0d238 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -62,12 +62,6 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	unsigned long end_mem   = memory_end; /* this must not include
-						kernel stack at top */
-
-	end_mem &= PAGE_MASK;
-	high_memory = __va(end_mem);
-
 	/* this will put all memory onto the freelists */
 	memblock_free_all();
 }
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 9093c336e158..72c5952607ac 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -193,8 +193,6 @@ void __init mem_init(void)
 {
 	BUG_ON(!mem_map);
 
-	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
-
 	/* clear the zero-page */
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 2cdfc0b1195c..4fbe354dc9b4 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -562,7 +562,6 @@ void __init mem_init(void)
 	BUILD_BUG_ON(TMPALIAS_MAP_START >= 0x80000000);
 #endif
 
-	high_memory = __va((max_pfn << PAGE_SHIFT));
 	memblock_free_all();
 
 #ifdef CONFIG_PA11
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 157c9ca51541..ac6d41e86243 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -295,7 +295,6 @@ static void __init setup_bootmem(void)
 	phys_ram_end = memblock_end_of_DRAM();
 	min_low_pfn = PFN_UP(phys_ram_base);
 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
-	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
 
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 36fed6dffb38..0c485884d373 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -159,8 +159,6 @@ void __init mem_init(void)
 	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
 	cpumask_set_cpu(0, mm_cpumask(&init_mm));
 
-        high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-
 	pv_init();
 	kfence_split_mapping();
 
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 72aea5cd1b85..6d459ffba4bc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -330,13 +330,6 @@ unsigned int mem_init_done = 0;
 
 void __init mem_init(void)
 {
-	pg_data_t *pgdat;
-
-	high_memory = NULL;
-	for_each_online_pgdat(pgdat)
-		high_memory = max_t(void *, high_memory,
-				    __va(pgdat_end_pfn(pgdat) << PAGE_SHIFT));
-
 	memblock_free_all();
 
 	/* Set this up early, so we can take care of the zero page */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 6b58da14edc6..81a468a9c223 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -275,7 +275,6 @@ void __init mem_init(void)
 
 	taint_real_pages();
 
-	high_memory = __va(max_low_pfn << PAGE_SHIFT);
 	memblock_free_all();
 
 	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 05882bca5b73..34d46adb9571 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2505,8 +2505,6 @@ static void __init register_page_bootmem_info(void)
 }
 void __init mem_init(void)
 {
-	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
-
 	memblock_free_all();
 
 	/*
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 6414cbf00572..f24a3ce37ab7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -385,7 +385,6 @@ int __init linux_main(int argc, char **argv, char **envp)
 
 	high_physmem = uml_physmem + physmem_size;
 	end_iomem = high_physmem + iomem_size;
-	high_memory = (void *) end_iomem;
 
 	start_vm = VMALLOC_START;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..5c9ec876915e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -972,8 +972,6 @@ void __init setup_arch(char **cmdline_p)
 		max_low_pfn = e820__end_of_low_ram_pfn();
 	else
 		max_low_pfn = max_pfn;
-
-	high_memory = (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
 	/* Find and reserve MPTABLE area */
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 6d2f8cb9451e..801b659ead0c 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -643,9 +643,6 @@ void __init initmem_init(void)
 		highstart_pfn = max_low_pfn;
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 		pages_to_mb(highend_pfn - highstart_pfn));
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
-#else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index 65fda406e6f2..442ef3facff0 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -41,9 +41,6 @@ void __init initmem_init(void)
 		highstart_pfn = max_low_pfn;
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 	       pages_to_mb(highend_pfn - highstart_pfn));
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
-#else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 9f1b0d5fccc7..9b662477b3d4 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -164,8 +164,6 @@ void __init mem_init(void)
 {
 	free_highpages();
 
-	high_memory = (void *)__va(max_low_pfn << PAGE_SHIFT);
-
 	memblock_free_all();
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 126fdd3001e3..2351f3f6b9ed 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -113,14 +113,6 @@ static __always_inline bool vmf_orig_pte_uffd_wp(struct vm_fault *vmf)
 	return pte_marker_uffd_wp(vmf->orig_pte);
 }
 
-/*
- * A number of key systems in x86 including ioremap() rely on the assumption
- * that high_memory defines the upper bound on direct map memory, then end
- * of ZONE_NORMAL.
- */
-void *high_memory;
-EXPORT_SYMBOL(high_memory);
-
 /*
  * Randomize the address space (stacks, mmaps, brk, etc.).
  *
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50a93714e1c6..61ac0cea711a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -44,6 +44,13 @@ struct page *mem_map;
 EXPORT_SYMBOL(mem_map);
 #endif
 
+/*
+ * high_memory defines the upper bound on direct map memory, then end
+ * of ZONE_NORMAL.
+ */
+void *high_memory;
+EXPORT_SYMBOL(high_memory);
+
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
 
@@ -1756,6 +1763,27 @@ static bool arch_has_descending_max_zone_pfns(void)
 	return IS_ENABLED(CONFIG_ARC) && !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
 }
 
+static void set_high_memory(void)
+{
+	phys_addr_t highmem = memblock_end_of_DRAM();
+
+	/*
+	 * Some architectures (e.g. ARM) set high_memory very early and
+	 * use it in arch setup code.
+	 * If an architecture already set high_memory don't overwrite it
+	 */
+	if (high_memory)
+		return;
+
+#ifdef CONFIG_HIGHMEM
+	if (arch_has_descending_max_zone_pfns() ||
+	    highmem > PFN_PHYS(arch_zone_lowest_possible_pfn[ZONE_HIGHMEM]))
+		highmem = PFN_PHYS(arch_zone_lowest_possible_pfn[ZONE_HIGHMEM]);
+#endif
+
+	high_memory = phys_to_virt(highmem - 1) + 1;
+}
+
 /**
  * free_area_init - Initialise all pg_data_t and zone data
  * @max_zone_pfn: an array of max PFNs for each zone
@@ -1875,6 +1903,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 
 	/* disable hash distribution for systems with a single node */
 	fixup_hashdist();
+
+	set_high_memory();
 }
 
 /**
diff --git a/mm/nommu.c b/mm/nommu.c
index f0209dd26dfa..b9783638fbd4 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -42,8 +42,6 @@
 #include <asm/mmu_context.h>
 #include "internal.h"
 
-void *high_memory;
-EXPORT_SYMBOL(high_memory);
 unsigned long highest_memmap_pfn;
 int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
 int heap_stack_gap = 0;
-- 
2.47.2


