Return-Path: <linux-arch+bounces-10552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6032A555ED
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466A11739F0
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8245926FDA6;
	Thu,  6 Mar 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjFBQxFu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA326BDB6;
	Thu,  6 Mar 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287251; cv=none; b=U20fkjAizb/PE6AFTDZ+v5ZQeB4tyACVFkrIKe1qttD7De8k0bbRlhbzk22eTgRiF9Za2i+C5TfwW/X1HtrjZi9/cvYt8vdWm9jlUE2VWwIcRvCgPaM6i/0tCVzTlhEa70TJZX2uWFuTT4VUv+rZKisjtM1tMkNzrgIWxmPoPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287251; c=relaxed/simple;
	bh=DneiROlCoHGV4ifZ5RS2tqXbkizidYqYiepJ/XJs4u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exHM1w6Lk5cG5cvQJcCsSVhpsYCBkEkvIvhBcVhtQAkSKUG0i7P9R5E9KoITDKfZfZEscOYTGOoA72s5GFIngXhzUASw4kVZw+NBLf7uJ3m9dV1/loK6UGWE4ADzuqXobV9WLZ6IZt8mTFKxtSN9novvhoJsrCWT2oGNyGo4p20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjFBQxFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161A0C4CEE9;
	Thu,  6 Mar 2025 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287249;
	bh=DneiROlCoHGV4ifZ5RS2tqXbkizidYqYiepJ/XJs4u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjFBQxFugxhbXU3Nj7ff8bsxbfYqlFC6eLvUFcovxhCEXxdfqomIndh6uyghPN5Zh
	 K51wVzOKZXwQN+w8tL9srsjWFP3caoZKVo8xzX+Rv6SjCTBNoKEDsLPwrFviZyG3sj
	 kkkCpMi8x4815tM0IDh+mckBYDEQPYUBxVB89B8KxYsuSRBmXeCfjvLWKKI+sYGzcQ
	 Clh/Vw6CDp0Owls0KUmQEC1AN6ZEJ7ffWWzbnL+olKNGOIy8yv8oAqrZmniATfsXll
	 J0l9GdHpOZ9jrEQab2d0IkZceZqtUXTqIbr4t+LYSk2U/u99shMVz2ordAgMNBmeNT
	 zy2CFySHPRbVQ==
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
Subject: [PATCH 11/13] arch, mm: streamline HIGHMEM freeing
Date: Thu,  6 Mar 2025 20:51:21 +0200
Message-ID: <20250306185124.3147510-12-rppt@kernel.org>
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

All architectures that support HIGHMEM have their code that frees high
memory pages to the buddy allocator while __free_memory_core() is limited
to freeing only low memory.

There is no actual reason for that. The memory map is completely ready
by the time memblock_free_all() is called and high pages can be released to
the buddy allocator along with low memory.

Remove low memory limit from __free_memory_core() and drop per-architecture
code that frees high memory pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arc/mm/init.c             |  6 +-----
 arch/arm/mm/init.c             | 29 -----------------------------
 arch/csky/mm/init.c            | 14 --------------
 arch/microblaze/mm/init.c      | 16 ----------------
 arch/mips/mm/init.c            | 20 --------------------
 arch/powerpc/mm/mem.c          | 14 --------------
 arch/sparc/mm/init_32.c        | 25 -------------------------
 arch/x86/include/asm/highmem.h |  3 ---
 arch/x86/include/asm/numa.h    |  4 ----
 arch/x86/include/asm/numa_32.h | 13 -------------
 arch/x86/mm/Makefile           |  2 --
 arch/x86/mm/highmem_32.c       | 34 ----------------------------------
 arch/x86/mm/init_32.c          | 28 ----------------------------
 arch/xtensa/mm/init.c          | 29 -----------------------------
 include/linux/mm.h             |  1 -
 mm/memblock.c                  |  3 +--
 16 files changed, 2 insertions(+), 239 deletions(-)
 delete mode 100644 arch/x86/include/asm/numa_32.h
 delete mode 100644 arch/x86/mm/highmem_32.c

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 05025122e965..11ce638731c9 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -160,11 +160,7 @@ void __init setup_arch_memory(void)
 static void __init highmem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-	unsigned long tmp;
-
 	memblock_phys_free(high_mem_start, high_mem_sz);
-	for (tmp = min_high_pfn; tmp < max_high_pfn; tmp++)
-		free_highmem_page(pfn_to_page(tmp));
 #endif
 }
 
@@ -176,8 +172,8 @@ static void __init highmem_init(void)
  */
 void __init mem_init(void)
 {
-	memblock_free_all();
 	highmem_init();
+	memblock_free_all();
 
 	BUILD_BUG_ON((PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE);
 	BUILD_BUG_ON((PTRS_PER_PUD * sizeof(pud_t)) > PAGE_SIZE);
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index d4bcc745a044..7bb5ce02b9b5 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -237,33 +237,6 @@ static inline void poison_init_mem(void *s, size_t count)
 		*p++ = 0xe7fddef0;
 }
 
-static void __init free_highpages(void)
-{
-#ifdef CONFIG_HIGHMEM
-	unsigned long max_low = max_low_pfn;
-	phys_addr_t range_start, range_end;
-	u64 i;
-
-	/* set highmem page free */
-	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
-				&range_start, &range_end, NULL) {
-		unsigned long start = PFN_UP(range_start);
-		unsigned long end = PFN_DOWN(range_end);
-
-		/* Ignore complete lowmem entries */
-		if (end <= max_low)
-			continue;
-
-		/* Truncate partial highmem entries */
-		if (start < max_low)
-			start = max_low;
-
-		for (; start < end; start++)
-			free_highmem_page(pfn_to_page(start));
-	}
-#endif
-}
-
 /*
  * mem_init() marks the free areas in the mem_map and tells us how much
  * memory is free.  This is done after various parts of the system have
@@ -283,8 +256,6 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
-	free_highpages();
-
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
 	 * be detected at build time already.
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index a22801aa503a..3914c2b873da 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -44,21 +44,7 @@ EXPORT_SYMBOL(empty_zero_page);
 
 void __init mem_init(void)
 {
-#ifdef CONFIG_HIGHMEM
-	unsigned long tmp;
-#endif
-
 	memblock_free_all();
-
-#ifdef CONFIG_HIGHMEM
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = pfn_to_page(tmp);
-
-		/* FIXME not sure about */
-		if (!memblock_is_reserved(tmp << PAGE_SHIFT))
-			free_highmem_page(page);
-	}
-#endif
 }
 
 void free_initmem(void)
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 7e2e342e84c5..3e664e0efc33 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -52,19 +52,6 @@ static void __init highmem_init(void)
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
 }
-
-static void __meminit highmem_setup(void)
-{
-	unsigned long pfn;
-
-	for (pfn = max_low_pfn; pfn < max_pfn; ++pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		/* FIXME not sure about */
-		if (!memblock_is_reserved(pfn << PAGE_SHIFT))
-			free_highmem_page(page);
-	}
-}
 #endif /* CONFIG_HIGHMEM */
 
 /*
@@ -122,9 +109,6 @@ void __init mem_init(void)
 {
 	/* this will put all memory onto the freelists */
 	memblock_free_all();
-#ifdef CONFIG_HIGHMEM
-	highmem_setup();
-#endif
 
 	mem_init_done = 1;
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 99cefb58fba3..e7882874ba2f 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -427,25 +427,6 @@ void __init paging_init(void)
 static struct kcore_list kcore_kseg0;
 #endif
 
-static inline void __init mem_init_free_highmem(void)
-{
-#ifdef CONFIG_HIGHMEM
-	unsigned long tmp;
-
-	if (cpu_has_dc_aliases)
-		return;
-
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = pfn_to_page(tmp);
-
-		if (!memblock_is_memory(PFN_PHYS(tmp)))
-			SetPageReserved(page);
-		else
-			free_highmem_page(page);
-	}
-#endif
-}
-
 void __init mem_init(void)
 {
 	/*
@@ -456,7 +437,6 @@ void __init mem_init(void)
 
 	maar_init();
 	setup_zero_pages();	/* Setup zeroed pages.  */
-	mem_init_free_highmem();
 	memblock_free_all();
 
 #ifdef CONFIG_64BIT
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c7708c8fad29..1bc94bca9944 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -297,20 +297,6 @@ void __init mem_init(void)
 
 	memblock_free_all();
 
-#ifdef CONFIG_HIGHMEM
-	{
-		unsigned long pfn, highmem_mapnr;
-
-		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
-		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
-			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
-			struct page *page = pfn_to_page(pfn);
-			if (memblock_is_memory(paddr) && !memblock_is_reserved(paddr))
-				free_highmem_page(page);
-		}
-	}
-#endif /* CONFIG_HIGHMEM */
-
 #if defined(CONFIG_PPC_E500) && !defined(CONFIG_SMP)
 	/*
 	 * If smp is enabled, next_tlbcam_idx is initialized in the cpu up
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 81a468a9c223..043e9b6fadd0 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -232,18 +232,6 @@ static void __init taint_real_pages(void)
 	}
 }
 
-static void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
-{
-	unsigned long tmp;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	printk("mapping high region %08lx - %08lx\n", start_pfn, end_pfn);
-#endif
-
-	for (tmp = start_pfn; tmp < end_pfn; tmp++)
-		free_highmem_page(pfn_to_page(tmp));
-}
-
 void __init mem_init(void)
 {
 	int i;
@@ -276,19 +264,6 @@ void __init mem_init(void)
 	taint_real_pages();
 
 	memblock_free_all();
-
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
-
-		if (end_pfn <= highstart_pfn)
-			continue;
-
-		if (start_pfn < highstart_pfn)
-			start_pfn = highstart_pfn;
-
-		map_high_region(start_pfn, end_pfn);
-	}
 }
 
 void sparc_flush_page_to_ram(struct page *page)
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 731ee7cc40a5..585bdadba47d 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -69,9 +69,6 @@ extern unsigned long highstart_pfn, highend_pfn;
 		arch_flush_lazy_mmu_mode();		\
 	} while (0)
 
-extern void add_highpages_with_active_regions(int nid, unsigned long start_pfn,
-					unsigned long end_pfn);
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_HIGHMEM_H */
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 5469d7a7c40f..53ba39ce010c 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -41,10 +41,6 @@ static inline int numa_cpu_node(int cpu)
 }
 #endif	/* CONFIG_NUMA */
 
-#ifdef CONFIG_X86_32
-# include <asm/numa_32.h>
-#endif
-
 #ifdef CONFIG_NUMA
 extern void numa_set_node(int cpu, int node);
 extern void numa_clear_node(int cpu);
diff --git a/arch/x86/include/asm/numa_32.h b/arch/x86/include/asm/numa_32.h
deleted file mode 100644
index 9c8e9e85be77..000000000000
--- a/arch/x86/include/asm/numa_32.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_NUMA_32_H
-#define _ASM_X86_NUMA_32_H
-
-#ifdef CONFIG_HIGHMEM
-extern void set_highmem_pages_init(void);
-#else
-static inline void set_highmem_pages_init(void)
-{
-}
-#endif
-
-#endif /* _ASM_X86_NUMA_32_H */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 690fbf48e853..52fbf0a60858 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -42,8 +42,6 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= dump_pagetables.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= debug_pagetables.o
 
-obj-$(CONFIG_HIGHMEM)		+= highmem_32.o
-
 KASAN_SANITIZE_kasan_init_$(BITS).o := n
 obj-$(CONFIG_KASAN)		+= kasan_init_$(BITS).o
 
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
deleted file mode 100644
index d9efa35711ee..000000000000
--- a/arch/x86/mm/highmem_32.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/highmem.h>
-#include <linux/export.h>
-#include <linux/swap.h> /* for totalram_pages */
-#include <linux/memblock.h>
-#include <asm/numa.h>
-
-void __init set_highmem_pages_init(void)
-{
-	struct zone *zone;
-	int nid;
-
-	/*
-	 * Explicitly reset zone->managed_pages because set_highmem_pages_init()
-	 * is invoked before memblock_free_all()
-	 */
-	reset_all_zones_managed_pages();
-	for_each_zone(zone) {
-		unsigned long zone_start_pfn, zone_end_pfn;
-
-		if (!is_highmem(zone))
-			continue;
-
-		zone_start_pfn = zone->zone_start_pfn;
-		zone_end_pfn = zone_start_pfn + zone->spanned_pages;
-
-		nid = zone_to_nid(zone);
-		printk(KERN_INFO "Initializing %s for node %d (%08lx:%08lx)\n",
-				zone->name, nid, zone_start_pfn, zone_end_pfn);
-
-		add_highpages_with_active_regions(nid, zone_start_pfn,
-				 zone_end_pfn);
-	}
-}
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 801b659ead0c..9ee8ec2bc5d1 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -394,23 +394,6 @@ static void __init permanent_kmaps_init(pgd_t *pgd_base)
 
 	pkmap_page_table = virt_to_kpte(vaddr);
 }
-
-void __init add_highpages_with_active_regions(int nid,
-			 unsigned long start_pfn, unsigned long end_pfn)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &start, &end, NULL) {
-		unsigned long pfn = clamp_t(unsigned long, PFN_UP(start),
-					    start_pfn, end_pfn);
-		unsigned long e_pfn = clamp_t(unsigned long, PFN_DOWN(end),
-					      start_pfn, end_pfn);
-		for ( ; pfn < e_pfn; pfn++)
-			if (pfn_valid(pfn))
-				free_highmem_page(pfn_to_page(pfn));
-	}
-}
 #else
 static inline void permanent_kmaps_init(pgd_t *pgd_base)
 {
@@ -715,17 +698,6 @@ void __init mem_init(void)
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif
-	/*
-	 * With CONFIG_DEBUG_PAGEALLOC initialization of highmem pages has to
-	 * be done before memblock_free_all(). Memblock use free low memory for
-	 * temporary data (see find_range_array()) and for this purpose can use
-	 * pages that was already passed to the buddy allocator, hence marked as
-	 * not accessible in the page tables when compiled with
-	 * CONFIG_DEBUG_PAGEALLOC. Otherwise order of initialization is not
-	 * important here.
-	 */
-	set_highmem_pages_init();
-
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
 
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 9b662477b3d4..47ecbe28263e 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -129,41 +129,12 @@ void __init zones_init(void)
 	print_vm_layout();
 }
 
-static void __init free_highpages(void)
-{
-#ifdef CONFIG_HIGHMEM
-	unsigned long max_low = max_low_pfn;
-	phys_addr_t range_start, range_end;
-	u64 i;
-
-	/* set highmem page free */
-	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
-				&range_start, &range_end, NULL) {
-		unsigned long start = PFN_UP(range_start);
-		unsigned long end = PFN_DOWN(range_end);
-
-		/* Ignore complete lowmem entries */
-		if (end <= max_low)
-			continue;
-
-		/* Truncate partial highmem entries */
-		if (start < max_low)
-			start = max_low;
-
-		for (; start < end; start++)
-			free_highmem_page(pfn_to_page(start));
-	}
-#endif
-}
-
 /*
  * Initialize memory pages.
  */
 
 void __init mem_init(void)
 {
-	free_highpages();
-
 	memblock_free_all();
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fdf20503850e..6fccd3b3248c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3172,7 +3172,6 @@ extern void reserve_bootmem_region(phys_addr_t start,
 
 /* Free the reserved page into the buddy system, so it gets managed. */
 void free_reserved_page(struct page *page);
-#define free_highmem_page(page) free_reserved_page(page)
 
 static inline void mark_page_reserved(struct page *page)
 {
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..64ae678cd1d1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2164,8 +2164,7 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 				 phys_addr_t end)
 {
 	unsigned long start_pfn = PFN_UP(start);
-	unsigned long end_pfn = min_t(unsigned long,
-				      PFN_DOWN(end), max_low_pfn);
+	unsigned long end_pfn = PFN_DOWN(end);
 
 	if (start_pfn >= end_pfn)
 		return 0;
-- 
2.47.2


