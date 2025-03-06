Return-Path: <linux-arch+bounces-10551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B57A555DC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973363A6DDC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1B271284;
	Thu,  6 Mar 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHBmfR60"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CE26FDA6;
	Thu,  6 Mar 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287236; cv=none; b=SjEjl4CZrLAOYQvs/lpm1vWrWti22F09E/jid1Pyir0NrQApHWsL/5A2hj+rSowPOU+KcV6EeQgqhYAemW6qw/szyuH7AxxiX6Q5lpzac7XyVIIaxIQyXdjURfjB6Tbzx2U1yLO+HfTR6oPk42ABZJHaaZqdgY0v7iHF6oB3u8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287236; c=relaxed/simple;
	bh=N82KtXPTFRyks1M44cPPRNwY3qzMhZjfhHPDkzfY8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQsiy5mLa1QIPy4EeiHBmSFRsO7b/jowLQ28pGLsmoPYOOPKpHEbDSTSnBXCrY6bWJjJFGqaYks4quqkLHjJ03PVmXi9p6JMp0/tDEi+XNdifeLMgI04QRrf7slFqtfmyXl7H0OVD0VOhlSF1YWtGZIFoV5O2sQelFDPkU+ZSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHBmfR60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2AFC4CEE0;
	Thu,  6 Mar 2025 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287236;
	bh=N82KtXPTFRyks1M44cPPRNwY3qzMhZjfhHPDkzfY8rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHBmfR60iylGj76PcT5SR7iJdsxbhA2Op+45b52Rs6V3kvzzkbh7AD6HEff+L65Hh
	 xV0sL9zAxkHRgn2L9BsKzOGu3B/4Z0X1T/iAyacvyctkIjJOG4pG91QEtBsGACBUg8
	 nU35JgjU4cUQEzRF+SZgMrTeY64fMzNGDm2r6hZWXBdNPRBOi5QSkoA2qThxQvajNu
	 fmWs3Nb6Wt2+0q0UN7j2wVSLURdOagBUsixRBdAqyIFyK5FmhDQI0oLDouhgQERSL1
	 vd5xfzqJGRd07zHsmoNtbnlpkmmbxEcGXST9cCCGirN8KhrhPFUgVkjm8Wfik22qcU
	 T4FkPG9Lanq/g==
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
Subject: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Date: Thu,  6 Mar 2025 20:51:20 +0200
Message-ID: <20250306185124.3147510-11-rppt@kernel.org>
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

high_memory defines upper bound on the directly mapped memory.
This bound is defined by the beginning of ZONE_HIGHMEM when a system has
high memory and by the end of memory otherwise.

All this is known to generic memory management initialization code that
can set high_memory while initializing core mm structures.

Remove per-architecture calculation of high_memory and add a generic
version to free_area_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/alpha/mm/init.c               |  1 -
 arch/arc/mm/init.c                 |  2 --
 arch/arm/mm/mmu.c                  |  2 --
 arch/arm/mm/nommu.c                |  1 -
 arch/arm64/mm/init.c               |  2 --
 arch/csky/mm/init.c                |  1 -
 arch/hexagon/mm/init.c             |  6 ------
 arch/loongarch/kernel/numa.c       |  1 -
 arch/loongarch/mm/init.c           |  2 --
 arch/m68k/mm/init.c                |  2 --
 arch/m68k/mm/mcfmmu.c              |  1 -
 arch/m68k/mm/motorola.c            |  2 --
 arch/m68k/sun3/config.c            |  1 -
 arch/microblaze/mm/init.c          |  2 --
 arch/mips/mm/init.c                |  2 --
 arch/nios2/mm/init.c               |  6 ------
 arch/openrisc/mm/init.c            |  2 --
 arch/parisc/mm/init.c              |  1 -
 arch/powerpc/kernel/setup-common.c |  1 -
 arch/riscv/mm/init.c               |  1 -
 arch/s390/mm/init.c                |  2 --
 arch/sh/mm/init.c                  |  7 -------
 arch/sparc/mm/init_32.c            |  1 -
 arch/sparc/mm/init_64.c            |  2 --
 arch/um/kernel/um_arch.c           |  1 -
 arch/x86/kernel/setup.c            |  2 --
 arch/x86/mm/init_32.c              |  3 ---
 arch/x86/mm/numa_32.c              |  3 ---
 arch/xtensa/mm/init.c              |  2 --
 mm/memory.c                        |  8 --------
 mm/mm_init.c                       | 23 +++++++++++++++++++++++
 mm/nommu.c                         |  2 --
 32 files changed, 23 insertions(+), 72 deletions(-)

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
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f02f872ea8a9..e492d58a0386 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1250,8 +1250,6 @@ void __init adjust_lowmem_bounds(void)
 
 	arm_lowmem_limit = lowmem_limit;
 
-	high_memory = __va(arm_lowmem_limit - 1) + 1;
-
 	if (!memblock_limit)
 		memblock_limit = arm_lowmem_limit;
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 1a8f6914ee59..65903ed5e80d 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -146,7 +146,6 @@ void __init adjust_lowmem_bounds(void)
 	phys_addr_t end;
 	adjust_lowmem_bounds_mpu();
 	end = memblock_end_of_DRAM();
-	high_memory = __va(end - 1) + 1;
 	memblock_set_current_limit(end);
 }
 
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
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 8b11d0d545aa..e03ac556c59e 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -66,8 +66,6 @@ void __init paging_init(void)
 	unsigned long end_mem = memory_end & PAGE_MASK;
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
 
-	high_memory = (void *) end_mem;
-
 	empty_zero_page = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
 	max_zone_pfn[ZONE_DMA] = end_mem >> PAGE_SHIFT;
 	free_area_init(max_zone_pfn);
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 19a75029036c..1750cf9f0369 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -168,7 +168,6 @@ void __init cf_bootmem_alloc(void)
 	memstart = PAGE_ALIGN(_ramstart);
 	min_low_pfn = PFN_DOWN(_rambase);
 	max_pfn = max_low_pfn = PFN_DOWN(_ramend);
-	high_memory = (void *)_ramend;
 
 	/* Reserve kernel text/data/bss */
 	memblock_reserve(_rambase, memstart - _rambase);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 73651e093c4d..312efcd4b353 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -472,8 +472,6 @@ void __init paging_init(void)
 	module_fixup(NULL, __start_fixup, __stop_fixup);
 	flush_icache();
 
-	high_memory = phys_to_virt(max_addr) + 1;
-
 	min_low_pfn = availmem >> PAGE_SHIFT;
 	max_pfn = max_low_pfn = (max_addr >> PAGE_SHIFT) + 1;
 
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index cd8af809e0ca..925818278e34 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -115,7 +115,6 @@ static void __init sun3_bootmem_alloc(unsigned long memory_start,
 
 	max_pfn = num_pages = __pa(memory_end) >> PAGE_SHIFT;
 
-	high_memory = (void *)memory_end;
 	availmem = memory_start;
 
 	m68k_setup_node(0);
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
index 338b3c9fc5bc..99cefb58fba3 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -419,7 +419,6 @@ void __init paging_init(void)
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
 #endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	free_area_init(max_zone_pfns);
 }
@@ -471,7 +470,6 @@ void __init mem_init(void)
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
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 68d47c53876c..de34c40ccb21 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -957,7 +957,6 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Parse memory topology */
 	mem_topology_setup();
-	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
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
index 7e64243693c9..08ebc9a9344a 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -161,8 +161,6 @@ void __init mem_init(void)
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
index 50a93714e1c6..5e5f6ba73757 100644
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
 
@@ -1756,6 +1763,20 @@ static bool arch_has_descending_max_zone_pfns(void)
 	return IS_ENABLED(CONFIG_ARC) && !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
 }
 
+static void set_high_memory(void)
+{
+	phys_addr_t highmem = memblock_end_of_DRAM();
+
+#ifdef CONFIG_HIGHMEM
+	unsigned long pfn = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
+
+	if (arch_has_descending_max_zone_pfns() || highmem > PFN_PHYS(pfn))
+		highmem = PFN_PHYS(pfn);
+#endif
+
+	high_memory = phys_to_virt(highmem - 1) + 1;
+}
+
 /**
  * free_area_init - Initialise all pg_data_t and zone data
  * @max_zone_pfn: an array of max PFNs for each zone
@@ -1875,6 +1896,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 
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


