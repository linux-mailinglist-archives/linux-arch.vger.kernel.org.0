Return-Path: <linux-arch+bounces-5551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28815938C8F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91D2281FB0
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E0177999;
	Mon, 22 Jul 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ABRoUeK4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout146.security-mail.net (smtpout146.security-mail.net [85.31.212.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5B16CD22
	for <linux-arch@vger.kernel.org>; Mon, 22 Jul 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641518; cv=none; b=UFG42J/Jil7ecYp+eiCbSYzcAvRIsqLIVmVWLD+eBk8dA6W80C+PT9zQFHo5qjRTHifyot9k4HHCmghy5FUgndPljPhYPhNE8mSpr6LMgeX9YcaeZ4fU/9AmP0BoQxKjNrzHKftQ3Y52yvrJtLLbx1ije5xyPI3V0D9NDh+xGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641518; c=relaxed/simple;
	bh=sArPv2pizZJv40btN4vo4Ix7RS3PDwEomgr+mFdpbV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9JDFGnHgm45gqZv5phpU8Oeq4yHg2BKkNJxjti5TuA9KFNT0qGablojjgisqTcgemX5NawJa1lGhr9xTT/fw9Bl/KE7Vde/9KTdU1hqzWBdRHfMCqGOm7JBgWzyARLNEz2sid/xhHDJMcdhgFnp/Ssafav/sskxcnw0FuipAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ABRoUeK4; arc=none smtp.client-ip=85.31.212.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id B6EBA349671
	for <linux-arch@vger.kernel.org>; Mon, 22 Jul 2024 11:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641422;
	bh=sArPv2pizZJv40btN4vo4Ix7RS3PDwEomgr+mFdpbV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABRoUeK479alcv2RpuD1/Fjyq7fnZdYgpbxfrpWM6AFzra66bQgCVXr8h+Mpf4JrG
	 BKceFG2lu8PAUDfwvISPpUPosGojkS+1wnvDyHhi/Aaam3giyYKOKTxvTaRrHxCy+z
	 JaCmZCzUSEJdByg/6jeJAOlPIdyeGUj1SaVnly74=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 880D4349627; Mon, 22 Jul
 2024 11:43:42 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id B46413495C0; Mon, 22 Jul
 2024 11:43:41 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 6C83F40317; Mon, 22 Jul
 2024 11:43:41 +0200 (CEST)
X-Secumail-id: <11c82.669e29cd.b16c3.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Jean-Christophe Pince <jcpince@gmail.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, Julien Hascoet <jhascoet@kalrayinc.com>, Louis Morhet
 <lmorhet@kalrayinc.com>, Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
 Marius Gligor <mgligor@kalrayinc.com>, Vincent Chardon
 <vincent.chardon@elsys-design.com>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v3 24/37] kvx: Add memory management
Date: Mon, 22 Jul 2024 11:41:35 +0200
Message-ID: <20240722094226.21602-25-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add memory management support for kvx, including: cache and tlb
management, page fault handling, ioremap/mmap and streaming dma support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Jean-Christophe Pince <jcpince@gmail.com>
Signed-off-by: Jean-Christophe Pince <jcpince@gmail.com>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Julien Hascoet <jhascoet@kalrayinc.com>
Signed-off-by: Julien Hascoet <jhascoet@kalrayinc.com>
Co-developed-by: Louis Morhet <lmorhet@kalrayinc.com>
Signed-off-by: Louis Morhet <lmorhet@kalrayinc.com>
Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: removed L2 cache management
V2 -> V3:
- replace KVX_PFN by KVX_PTE
- fix dcache inval when virt range spans several VMAs
- replace BUGS with WARN_ON_ONCE
- setup_bootmem: memblock_reserve() all smem at boot
---
 arch/kvx/include/asm/cache.h        |  44 +++
 arch/kvx/include/asm/cacheflush.h   | 158 ++++++++++
 arch/kvx/include/asm/fixmap.h       |  47 +++
 arch/kvx/include/asm/hugetlb.h      |  36 +++
 arch/kvx/include/asm/mem_map.h      |  44 +++
 arch/kvx/include/asm/mmu.h          | 289 +++++++++++++++++
 arch/kvx/include/asm/mmu_context.h  | 156 ++++++++++
 arch/kvx/include/asm/mmu_stats.h    |  38 +++
 arch/kvx/include/asm/page.h         | 172 ++++++++++
 arch/kvx/include/asm/page_size.h    |  29 ++
 arch/kvx/include/asm/pgalloc.h      |  70 +++++
 arch/kvx/include/asm/pgtable-bits.h | 105 +++++++
 arch/kvx/include/asm/pgtable.h      | 468 ++++++++++++++++++++++++++++
 arch/kvx/include/asm/sparsemem.h    |  15 +
 arch/kvx/include/asm/symbols.h      |  16 +
 arch/kvx/include/asm/tlb.h          |  24 ++
 arch/kvx/include/asm/tlb_defs.h     | 132 ++++++++
 arch/kvx/include/asm/tlbflush.h     |  60 ++++
 arch/kvx/include/asm/vmalloc.h      |  10 +
 arch/kvx/mm/cacheflush.c            | 158 ++++++++++
 arch/kvx/mm/dma-mapping.c           |  83 +++++
 arch/kvx/mm/extable.c               |  24 ++
 arch/kvx/mm/fault.c                 | 270 ++++++++++++++++
 arch/kvx/mm/init.c                  | 297 ++++++++++++++++++
 arch/kvx/mm/mmap.c                  |  31 ++
 arch/kvx/mm/mmu.c                   | 202 ++++++++++++
 arch/kvx/mm/mmu_stats.c             |  94 ++++++
 arch/kvx/mm/tlb.c                   | 445 ++++++++++++++++++++++++++
 28 files changed, 3517 insertions(+)
 create mode 100644 arch/kvx/include/asm/cache.h
 create mode 100644 arch/kvx/include/asm/cacheflush.h
 create mode 100644 arch/kvx/include/asm/fixmap.h
 create mode 100644 arch/kvx/include/asm/hugetlb.h
 create mode 100644 arch/kvx/include/asm/mem_map.h
 create mode 100644 arch/kvx/include/asm/mmu.h
 create mode 100644 arch/kvx/include/asm/mmu_context.h
 create mode 100644 arch/kvx/include/asm/mmu_stats.h
 create mode 100644 arch/kvx/include/asm/page.h
 create mode 100644 arch/kvx/include/asm/page_size.h
 create mode 100644 arch/kvx/include/asm/pgalloc.h
 create mode 100644 arch/kvx/include/asm/pgtable-bits.h
 create mode 100644 arch/kvx/include/asm/pgtable.h
 create mode 100644 arch/kvx/include/asm/sparsemem.h
 create mode 100644 arch/kvx/include/asm/symbols.h
 create mode 100644 arch/kvx/include/asm/tlb.h
 create mode 100644 arch/kvx/include/asm/tlb_defs.h
 create mode 100644 arch/kvx/include/asm/tlbflush.h
 create mode 100644 arch/kvx/include/asm/vmalloc.h
 create mode 100644 arch/kvx/mm/cacheflush.c
 create mode 100644 arch/kvx/mm/dma-mapping.c
 create mode 100644 arch/kvx/mm/extable.c
 create mode 100644 arch/kvx/mm/fault.c
 create mode 100644 arch/kvx/mm/init.c
 create mode 100644 arch/kvx/mm/mmap.c
 create mode 100644 arch/kvx/mm/mmu.c
 create mode 100644 arch/kvx/mm/mmu_stats.c
 create mode 100644 arch/kvx/mm/tlb.c

diff --git a/arch/kvx/include/asm/cache.h b/arch/kvx/include/asm/cache.h
new file mode 100644
index 0000000000000..f95792883622b
--- /dev/null
+++ b/arch/kvx/include/asm/cache.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ */
+
+#ifndef _ASM_KVX_CACHE_H
+#define _ASM_KVX_CACHE_H
+
+/**
+ * On KVX I$ and D$ have the same size (16KB).
+ * Caches are 16KB big, 4-way set associative, true lru, with 64-byte
+ * lines. The D$ is also write-through.
+ */
+#define KVX_ICACHE_WAY_COUNT	4
+#define KVX_ICACHE_SET_COUNT	64
+#define KVX_ICACHE_LINE_SHIFT	6
+#define KVX_ICACHE_LINE_SIZE	(1 << KVX_ICACHE_LINE_SHIFT)
+#define KVX_ICACHE_SIZE	\
+	(KVX_ICACHE_WAY_COUNT * KVX_ICACHE_SET_COUNT * KVX_ICACHE_LINE_SIZE)
+
+/**
+ * Invalidate the whole I-cache if the size to flush is more than this value
+ */
+#define KVX_ICACHE_INVAL_SIZE	(KVX_ICACHE_SIZE)
+
+/* D-Cache */
+#define KVX_DCACHE_WAY_COUNT	4
+#define KVX_DCACHE_SET_COUNT	64
+#define KVX_DCACHE_LINE_SHIFT	6
+#define KVX_DCACHE_LINE_SIZE	(1 << KVX_DCACHE_LINE_SHIFT)
+#define KVX_DCACHE_SIZE	\
+	(KVX_DCACHE_WAY_COUNT * KVX_DCACHE_SET_COUNT * KVX_DCACHE_LINE_SIZE)
+
+/**
+ * Same for I-cache
+ */
+#define KVX_DCACHE_INVAL_SIZE	(KVX_DCACHE_SIZE)
+
+#define L1_CACHE_SHIFT	KVX_DCACHE_LINE_SHIFT
+#define L1_CACHE_BYTES	KVX_DCACHE_LINE_SIZE
+
+#endif	/* _ASM_KVX_CACHE_H */
diff --git a/arch/kvx/include/asm/cacheflush.h b/arch/kvx/include/asm/cacheflush.h
new file mode 100644
index 0000000000000..256a201e423a7
--- /dev/null
+++ b/arch/kvx/include/asm/cacheflush.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_CACHEFLUSH_H
+#define _ASM_KVX_CACHEFLUSH_H
+
+#include <linux/mm.h>
+#include <linux/io.h>
+
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
+#define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_range(vma, start, end)	do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
+
+#define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vunmap(start, end)		do { } while (0)
+
+#define flush_dcache_page(page)		do { } while (0)
+
+#define flush_dcache_mmap_lock(mapping)         do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)       do { } while (0)
+
+#define l1_inval_dcache_all __builtin_kvx_dinval
+#define kvx_fence __builtin_kvx_fence
+#define l1_inval_icache_all __builtin_kvx_iinval
+
+int dcache_wb_inval_virt_range(unsigned long vaddr, unsigned long len, bool wb,
+			       bool inval);
+void dcache_wb_inval_phys_range(phys_addr_t addr, unsigned long len, bool wb,
+				bool inval);
+
+/*
+ * The L1 is indexed by virtual addresses and as such, invalidation takes
+ * virtual addresses as arguments.
+ */
+static inline
+void l1_inval_dcache_range(unsigned long vaddr, unsigned long size)
+{
+	unsigned long end = vaddr + size;
+
+	/* Then inval L1 */
+	if (size >= KVX_DCACHE_INVAL_SIZE) {
+		__builtin_kvx_dinval();
+		return;
+	}
+
+	vaddr = ALIGN_DOWN(vaddr, KVX_DCACHE_LINE_SIZE);
+	for (; vaddr < end; vaddr += KVX_DCACHE_LINE_SIZE)
+		__builtin_kvx_dinvall((void *) vaddr);
+}
+
+static inline
+void inval_dcache_range(phys_addr_t paddr, unsigned long size)
+{
+	l1_inval_dcache_range((unsigned long) phys_to_virt(paddr), size);
+}
+
+static inline
+void wb_dcache_range(phys_addr_t paddr, unsigned long size)
+{
+	/* Fence to ensure all write are committed */
+	kvx_fence();
+}
+
+static inline
+void wbinval_dcache_range(phys_addr_t paddr, unsigned long size)
+{
+	/* Fence to ensure all write are committed */
+	kvx_fence();
+
+	l1_inval_dcache_range((unsigned long) phys_to_virt(paddr), size);
+}
+
+static inline
+void l1_inval_icache_range(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+	unsigned long size = end - start;
+
+	if (size >= KVX_ICACHE_INVAL_SIZE) {
+		__builtin_kvx_iinval();
+		__builtin_kvx_barrier();
+		return;
+	}
+
+	start = ALIGN_DOWN(start, KVX_ICACHE_LINE_SIZE);
+	for (addr = start; addr < end; addr += KVX_ICACHE_LINE_SIZE)
+		__builtin_kvx_iinvals((void *) addr);
+
+	__builtin_kvx_barrier();
+}
+
+static inline
+void wbinval_icache_range(phys_addr_t paddr, unsigned long size)
+{
+	unsigned long vaddr = (unsigned long) phys_to_virt(paddr);
+
+	/* Fence to ensure all write are committed */
+	kvx_fence();
+
+	l1_inval_icache_range(vaddr, vaddr + size);
+}
+
+static inline
+void sync_dcache_icache(unsigned long start, unsigned long end)
+{
+	/* Fence to ensure all write are committed */
+	kvx_fence();
+	/* Then invalidate the L1 icache */
+	l1_inval_icache_range(start, end);
+}
+
+static inline
+void local_flush_icache_range(unsigned long start, unsigned long end)
+{
+	sync_dcache_icache(start, end);
+}
+
+#ifdef CONFIG_SMP
+void flush_icache_range(unsigned long start, unsigned long end);
+#else
+#define flush_icache_range local_flush_icache_range
+#endif
+
+static inline
+void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long start = (unsigned long) page_address(page);
+	unsigned long end = start + PAGE_SIZE;
+
+	sync_dcache_icache(start, end);
+}
+
+static inline
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			     unsigned long vaddr, int len)
+{
+	sync_dcache_icache(vaddr, vaddr + len);
+}
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+	do { \
+		memcpy(dst, src, len); \
+		if (vma->vm_flags & VM_EXEC) \
+			flush_icache_user_range(vma, page, vaddr, len); \
+	} while (0)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+	memcpy(dst, src, len)
+
+#endif	/* _ASM_KVX_CACHEFLUSH_H */
diff --git a/arch/kvx/include/asm/fixmap.h b/arch/kvx/include/asm/fixmap.h
new file mode 100644
index 0000000000000..3863e410d71de
--- /dev/null
+++ b/arch/kvx/include/asm/fixmap.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_FIXMAP_H
+#define _ASM_KVX_FIXMAP_H
+
+/**
+ * Use the latest available kernel address minus one page.
+ * This is needed since __fix_to_virt returns
+ * (FIXADDR_TOP - ((x) << PAGE_SHIFT))
+ * Due to that, first member will be shifted by 0 and will be equal to
+ * FIXADDR_TOP.
+ * Some other architectures simply add a FIX_HOLE at the beginning of
+ * the fixed_addresses enum (I think ?).
+ */
+#define FIXADDR_TOP	(-PAGE_SIZE)
+
+#define ASM_FIX_TO_VIRT(IDX) \
+	(FIXADDR_TOP - ((IDX) << PAGE_SHIFT))
+
+#ifndef __ASSEMBLY__
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+enum fixed_addresses {
+	FIX_EARLYCON_MEM_BASE,
+	FIX_GDB_BARE_DISPLACED_MEM_BASE,
+	/* Used to access text early in RW mode (jump label) */
+	FIX_TEXT_PATCH,
+	__end_of_fixed_addresses
+};
+
+#define FIXADDR_SIZE  (__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START (FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXMAP_PAGE_IO (PAGE_KERNEL_DEVICE)
+
+void __set_fixmap(enum fixed_addresses idx,
+				phys_addr_t phys, pgprot_t prot);
+
+#include <asm-generic/fixmap.h>
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/kvx/include/asm/hugetlb.h b/arch/kvx/include/asm/hugetlb.h
new file mode 100644
index 0000000000000..a5984e8ede7eb
--- /dev/null
+++ b/arch/kvx/include/asm/hugetlb.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_HUGETLB_H
+#define _ASM_KVX_HUGETLB_H
+
+#include <asm/pgtable.h>
+
+#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
+extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, pte_t pte);
+
+#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+				     unsigned long addr, pte_t *ptep);
+
+#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
+extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep,
+				      pte_t pte, int dirty);
+
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
+extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
+				    unsigned long addr, pte_t *ptep);
+
+#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
+extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+				   unsigned long addr, pte_t *ptep);
+
+#include <asm-generic/hugetlb.h>
+
+#endif /* _ASM_KVX_HUGETLB_H */
diff --git a/arch/kvx/include/asm/mem_map.h b/arch/kvx/include/asm/mem_map.h
new file mode 100644
index 0000000000000..ea90144209ce1
--- /dev/null
+++ b/arch/kvx/include/asm/mem_map.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef _ASM_KVX_MEM_MAP_H
+#define _ASM_KVX_MEM_MAP_H
+
+#include <linux/const.h>
+#include <linux/sizes.h>
+
+#include <asm/page.h>
+#include <asm/fixmap.h>
+
+/**
+ * kvx memory mapping defines
+ * For more information on memory mapping, please see
+ * Documentation/kvx/kvx-mmu.txt
+ *
+ * All _BASE defines are relative to PAGE_OFFSET
+ */
+
+/* Guard between various memory map zones */
+#define MAP_GUARD_SIZE	SZ_1G
+
+/**
+ * Kernel direct memory mapping
+ */
+#define KERNEL_DIRECT_MEMORY_MAP_BASE	PAGE_OFFSET
+#define KERNEL_DIRECT_MEMORY_MAP_SIZE	UL(0x1000000000)
+#define KERNEL_DIRECT_MEMORY_MAP_END \
+		(KERNEL_DIRECT_MEMORY_MAP_BASE + KERNEL_DIRECT_MEMORY_MAP_SIZE)
+
+/**
+ * Vmalloc mapping (goes from kernel direct memory map up to fixmap start -
+ * guard size)
+ */
+#define KERNEL_VMALLOC_MAP_BASE (KERNEL_DIRECT_MEMORY_MAP_END + MAP_GUARD_SIZE)
+#define KERNEL_VMALLOC_MAP_SIZE	\
+		(FIXADDR_START - KERNEL_VMALLOC_MAP_BASE - MAP_GUARD_SIZE)
+
+#endif
diff --git a/arch/kvx/include/asm/mmu.h b/arch/kvx/include/asm/mmu.h
new file mode 100644
index 0000000000000..a9fecb560fe5b
--- /dev/null
+++ b/arch/kvx/include/asm/mmu.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ *            Marc Poulhiès
+ */
+
+#ifndef _ASM_KVX_MMU_H
+#define _ASM_KVX_MMU_H
+
+#include <linux/bug.h>
+#include <linux/types.h>
+#include <linux/threads.h>
+
+#include <asm/page.h>
+#include <asm/sfr.h>
+#include <asm/page.h>
+#include <asm/pgtable-bits.h>
+#include <asm/tlb_defs.h>
+
+/* Virtual addresses can use at most 41 bits */
+#define MMU_VIRT_BITS		41
+
+/*
+ * See Documentation/kvx/kvx-mmu.rst for details about the division of the
+ * virtual memory space.
+ */
+#if defined(CONFIG_KVX_4K_PAGES)
+#define MMU_USR_ADDR_BITS	39
+#else
+#error "Only 4Ko page size is supported at this time"
+#endif
+
+typedef struct mm_context {
+	unsigned long end_brk;
+	unsigned long asn[NR_CPUS];
+	unsigned long sigpage;
+} mm_context_t;
+
+struct __packed tlb_entry_low {
+	unsigned int es:2;       /* Entry Status */
+	unsigned int cp:2;       /* Cache Policy */
+	unsigned int pa:4;       /* Protection Attributes */
+	unsigned int r:2;        /* Reserved */
+	unsigned int ps:2;       /* Page Size */
+	unsigned int fn:28;      /* Frame Number */
+};
+
+struct __packed tlb_entry_high {
+	unsigned int asn:9;  /* Address Space Number */
+	unsigned int g:1;    /* Global Indicator */
+	unsigned int vs:2;   /* Virtual Space */
+	unsigned int pn:29;  /* Page Number */
+};
+
+struct kvx_tlb_format {
+	union {
+		struct tlb_entry_low tel;
+		uint64_t tel_val;
+	};
+	union {
+		struct tlb_entry_high teh;
+		uint64_t teh_val;
+	};
+};
+
+#define KVX_EMPTY_TLB_ENTRY { .tel_val = 0x0, .teh_val = 0x0 }
+
+/* Bit [0:39] of the TLB format corresponds to TLB Entry low */
+/* Bit [40:80] of the TLB format corresponds to the TLB Entry high */
+#define kvx_mmu_set_tlb_entry(tlbf) do { \
+	kvx_sfr_set(TEL, (uint64_t) tlbf.tel_val); \
+	kvx_sfr_set(TEH, (uint64_t) tlbf.teh_val); \
+} while (0)
+
+#define kvx_mmu_get_tlb_entry(tlbf) do { \
+	tlbf.tel_val = kvx_sfr_get(TEL); \
+	tlbf.teh_val = kvx_sfr_get(TEH); \
+} while (0)
+
+/* Use kvx_mmc_ to read a field from MMC value passed as parameter */
+#define __kvx_mmc(mmc_reg, field) \
+	kvx_sfr_field_val(mmc_reg, MMC, field)
+
+#define kvx_mmc_error(mmc)  __kvx_mmc(mmc, E)
+#define kvx_mmc_parity(mmc) __kvx_mmc(mmc, PAR)
+#define kvx_mmc_sb(mmc)     __kvx_mmc(mmc, SB)
+#define kvx_mmc_ss(mmc)     __kvx_mmc(mmc, SS)
+#define kvx_mmc_sw(mmc)     __kvx_mmc(mmc, SW)
+#define kvx_mmc_asn(mmc)    __kvx_mmc(mmc, ASN)
+
+#define KVX_TLB_ACCESS_READ 0
+#define KVX_TLB_ACCESS_WRITE 1
+#define KVX_TLB_ACCESS_PROBE 2
+
+#ifdef CONFIG_KVX_DEBUG_TLB_ACCESS
+
+#define KVX_TLB_ACCESS_SIZE (1 << CONFIG_KVX_DEBUG_TLB_ACCESS_BITS)
+#define KVX_TLB_ACCESS_MASK GENMASK((CONFIG_KVX_DEBUG_TLB_ACCESS_BITS - 1), 0)
+#define KVX_TLB_ACCESS_GET_IDX(idx) (idx & KVX_TLB_ACCESS_MASK)
+
+/* This structure is used to make decoding of MMC easier in gdb */
+struct mmc_t {
+	unsigned int asn:9;
+	unsigned int s: 1;
+	unsigned int r1: 4;
+	unsigned int sne: 1;
+	unsigned int spe: 1;
+	unsigned int ptc: 2;
+	unsigned int sw: 4;
+	unsigned int ss: 6;
+	unsigned int sb: 1;
+	unsigned int r2: 1;
+	unsigned int par: 1;
+	unsigned int e: 1;
+};
+
+struct __packed kvx_tlb_access_t {
+	struct kvx_tlb_format entry;  /* 128 bits */
+	union {
+		struct mmc_t mmc;
+		uint32_t mmc_val;
+	};
+	uint32_t type;
+};
+
+extern void kvx_update_tlb_access(int type);
+
+#else
+#define kvx_update_tlb_access(type) do {} while (0)
+#endif
+
+static inline void kvx_mmu_readtlb(void)
+{
+	kvx_update_tlb_access(KVX_TLB_ACCESS_READ);
+	asm volatile ("tlbread\n;;");
+}
+
+static inline void kvx_mmu_writetlb(void)
+{
+	kvx_update_tlb_access(KVX_TLB_ACCESS_WRITE);
+	asm volatile ("tlbwrite\n;;");
+}
+
+static inline void kvx_mmu_probetlb(void)
+{
+	kvx_update_tlb_access(KVX_TLB_ACCESS_PROBE);
+	asm volatile ("tlbprobe\n;;");
+}
+
+#define kvx_mmu_add_entry(buffer, way, entry) do { \
+	kvx_sfr_set_field(MMC, SB, buffer); \
+	kvx_sfr_set_field(MMC, SW, way); \
+	kvx_mmu_set_tlb_entry(entry); \
+	kvx_mmu_writetlb();           \
+} while (0)
+
+#define kvx_mmu_remove_ltlb_entry(way) do { \
+	struct kvx_tlb_format __invalid_entry = KVX_EMPTY_TLB_ENTRY; \
+	kvx_mmu_add_entry(MMC_SB_LTLB, way, __invalid_entry); \
+} while (0)
+
+static inline int get_page_size_shift(int ps)
+{
+	/*
+	 * Use the same assembly trick using sbmm to directly get the page size
+	 * shift using a constant which encodes all page size shifts
+	 */
+	return __builtin_kvx_sbmm8(KVX_PS_SHIFT_MATRIX,
+				  KVX_SBMM_BYTE_SEL << ps);
+}
+
+/*
+ * 4 bits are used to index the kvx access permissions. Bits are used as
+ * follow:
+ *
+ *   +---------------+------------+-------------+------------+
+ *   |     Bit 3     |   Bit 2    |   Bit 1     |   Bit 0    |
+ *   |---------------+------------+-------------+------------|
+ *   |  _PAGE_GLOBAL | _PAGE_EXEC | _PAGE_WRITE | _PAGE_READ |
+ *   +---------------+------------+-------------+------------+
+ *
+ * If _PAGE_GLOBAL is set then the page belongs to the kernel. Otherwise it
+ * belongs to the user. When the page belongs to user-space then give the
+ * same rights to the kernel-space.
+ * In order to quickly compute policy from this value, we use sbmm instruction.
+ * The main interest is to avoid an additionnal load and specifically in the
+ * assembly refill handler.
+ */
+static inline u8 get_page_access_perms(u8 policy)
+{
+	/* If PAGE_READ is unset, there is no permission for this page */
+	if (!(policy & (_PAGE_READ >> _PAGE_PERMS_SHIFT)))
+		return TLB_PA_NA_NA;
+
+	/* Discard the _PAGE_READ bit to get a linear number in [0,7] */
+	policy >>= 1;
+
+	/* Use sbmm to directly get the page perms */
+	return __builtin_kvx_sbmm8(KVX_PAGE_PA_MATRIX,
+				  KVX_SBMM_BYTE_SEL << policy);
+}
+
+static inline struct kvx_tlb_format tlb_mk_entry(
+	void *paddr,
+	void *vaddr,
+	unsigned int ps,
+	unsigned int global,
+	unsigned int pa,
+	unsigned int cp,
+	unsigned int asn,
+	unsigned int es)
+{
+	struct kvx_tlb_format entry;
+	u64 mask = ULONG_MAX << get_page_size_shift(ps);
+
+	BUG_ON(ps >= (1 << KVX_SFR_TEL_PS_WIDTH));
+
+	/*
+	 * 0 matches the virtual space:
+	 * - either we are virtualized and the hypervisor will set it
+	 *   for us when using writetlb
+	 * - Or we are native and the virtual space is 0
+	 */
+	entry.teh_val = TLB_MK_TEH_ENTRY((uintptr_t)vaddr & mask, 0, global,
+					 asn);
+	entry.tel_val = TLB_MK_TEL_ENTRY((uintptr_t)paddr, ps, es, cp, pa);
+
+	return entry;
+}
+
+static inline unsigned long tlb_entry_phys(struct kvx_tlb_format tlbe)
+{
+	return ((unsigned long) tlbe.tel.fn << KVX_SFR_TEL_FN_SHIFT);
+}
+
+static inline unsigned long tlb_entry_virt(struct kvx_tlb_format tlbe)
+{
+	return ((unsigned long) tlbe.teh.pn << KVX_SFR_TEH_PN_SHIFT);
+}
+
+static inline unsigned long tlb_entry_size(struct kvx_tlb_format tlbe)
+{
+	return BIT(get_page_size_shift(tlbe.tel.ps));
+}
+
+static inline int tlb_entry_overlaps(struct kvx_tlb_format tlbe1,
+				     struct kvx_tlb_format tlbe2)
+{
+	unsigned long start1, end1;
+	unsigned long start2, end2;
+
+	start1 = tlb_entry_virt(tlbe1);
+	end1 = start1 + tlb_entry_size(tlbe1);
+
+	start2 = tlb_entry_virt(tlbe2);
+	end2 = start2 + tlb_entry_size(tlbe2);
+
+	return start1 <= end2 && end1 >= start2;
+}
+
+static inline int tlb_entry_match_addr(struct kvx_tlb_format tlbe,
+				       unsigned long vaddr)
+{
+	/*
+	 * TLB entries store up to 41 bits so the provided address must be
+	 * truncated to match teh.pn.
+	 */
+	vaddr &= GENMASK(MMU_VIRT_BITS - 1, KVX_SFR_TEH_PN_SHIFT);
+
+	return tlb_entry_virt(tlbe) == vaddr;
+}
+
+extern void kvx_mmu_early_setup(void);
+
+static inline void paging_init(void) {}
+
+void kvx_mmu_ltlb_remove_entry(unsigned long vaddr);
+void kvx_mmu_ltlb_add_entry(unsigned long vaddr, phys_addr_t paddr,
+			    pgprot_t flags, unsigned long page_shift);
+
+void kvx_mmu_jtlb_add_entry(unsigned long address, pte_t *ptep,
+			    unsigned int asn);
+extern void mmu_early_init(void);
+
+struct mm_struct;
+
+#endif	/* _ASM_KVX_MMU_H */
diff --git a/arch/kvx/include/asm/mmu_context.h b/arch/kvx/include/asm/mmu_context.h
new file mode 100644
index 0000000000000..39fa92f1506b2
--- /dev/null
+++ b/arch/kvx/include/asm/mmu_context.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef __ASM_KVX_MMU_CONTEXT_H
+#define __ASM_KVX_MMU_CONTEXT_H
+
+/*
+ * Management of the Address Space Number:
+ * Coolidge architecture provides a 9-bit ASN to tag TLB entries. This can be
+ * used to allow several entries with the same virtual address (so from
+ * different process) to be in the TLB at the same time. That means that won't
+ * necessarily flush the TLB when a context switch occurs and so it will
+ * improve performances.
+ */
+#include <linux/smp.h>
+
+#include <asm/mmu.h>
+#include <asm/sfr_defs.h>
+#include <asm/tlbflush.h>
+
+#include <asm-generic/mm_hooks.h>
+
+#define MM_CTXT_ASN_MASK	GENMASK(KVX_SFR_MMC_ASN_WIDTH - 1, 0)
+#define MM_CTXT_CYCLE_MASK	(~MM_CTXT_ASN_MASK)
+#define MM_CTXT_NO_ASN		UL(0x0)
+#define MM_CTXT_FIRST_CYCLE	(MM_CTXT_ASN_MASK + 1)
+
+#define mm_asn(mm, cpu)		((mm)->context.asn[cpu])
+
+DECLARE_PER_CPU(unsigned long, kvx_asn_cache);
+#define cpu_asn_cache(cpu) per_cpu(kvx_asn_cache, cpu)
+
+static inline void get_new_mmu_context(struct mm_struct *mm, unsigned int cpu)
+{
+	unsigned long asn = cpu_asn_cache(cpu);
+
+	asn++;
+	/* Check if we need to start a new cycle */
+	if ((asn & MM_CTXT_ASN_MASK) == 0) {
+		pr_debug("%s: start new cycle, flush all tlb\n", __func__);
+		local_flush_tlb_all();
+
+		/*
+		 * Above check for rollover of 9 bit ASN in 64 bit container.
+		 * If the container itself wrapped around, set it to a non zero
+		 * "generation" to distinguish from no context
+		 */
+		if (asn == 0)
+			asn = MM_CTXT_FIRST_CYCLE;
+	}
+
+	cpu_asn_cache(cpu) = asn;
+	mm_asn(mm, cpu) = asn;
+
+	pr_debug("%s: mm = 0x%llx: cpu[%d], cycle: %lu, asn: %lu\n",
+		 __func__, (unsigned long long)mm, cpu,
+		(asn & MM_CTXT_CYCLE_MASK) >> KVX_SFR_MMC_ASN_WIDTH,
+		asn & MM_CTXT_ASN_MASK);
+}
+
+static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
+{
+
+	unsigned long asn = mm_asn(mm, cpu);
+
+	/*
+	 * Move to new ASN if it was not from current alloc-cycle/generation.
+	 * This is done by ensuring that the generation bits in both
+	 * mm->context.asn and cpu_asn_cache counter are exactly same.
+	 *
+	 * NOTE: this also works for checking if mm has a context since the
+	 * first alloc-cycle/generation is always '1'. MM_CTXT_NO_ASN value
+	 * contains cycle '0', and thus it will match.
+	 */
+	if ((asn ^ cpu_asn_cache(cpu)) & MM_CTXT_CYCLE_MASK)
+		get_new_mmu_context(mm, cpu);
+}
+
+static inline void activate_context(struct mm_struct *mm, unsigned int cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	get_mmu_context(mm, cpu);
+
+	kvx_sfr_set_field(MMC, ASN, mm_asn(mm, cpu) & MM_CTXT_ASN_MASK);
+
+	local_irq_restore(flags);
+}
+
+/**
+ * Redefining the generic hooks that are:
+ *   - activate_mm
+ *   - deactivate_mm
+ *   - enter_lazy_tlb
+ *   - init_new_context
+ *   - destroy_context
+ *   - switch_mm
+ */
+
+#define activate_mm(prev, next) switch_mm((prev), (next), NULL)
+#define deactivate_mm(tsk, mm) do { } while (0)
+#define enter_lazy_tlb(mm, tsk) do { } while (0)
+
+static inline int init_new_context(struct task_struct *tsk,
+				   struct mm_struct *mm)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		mm_asn(mm, cpu) = MM_CTXT_NO_ASN;
+
+	return 0;
+}
+
+static inline void destroy_context(struct mm_struct *mm)
+{
+	int cpu = smp_processor_id();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	mm_asn(mm, cpu) = MM_CTXT_NO_ASN;
+	local_irq_restore(flags);
+}
+
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			     struct task_struct *tsk)
+{
+	unsigned int cpu = smp_processor_id();
+
+	/**
+	 * Comment taken from arc, but logic is the same for us:
+	 *
+	 * Note that the mm_cpumask is "aggregating" only, we don't clear it
+	 * for the switched-out task, unlike some other arches.
+	 * It is used to enlist cpus for sending TLB flush IPIs and not sending
+	 * it to CPUs where a task once ran-on, could cause stale TLB entry
+	 * re-use, specially for a multi-threaded task.
+	 * e.g. T1 runs on C1, migrates to C3. T2 running on C2 munmaps.
+	 *      For a non-aggregating mm_cpumask, IPI not sent C1, and if T1
+	 *      were to re-migrate to C1, it could access the unmapped region
+	 *      via any existing stale TLB entries.
+	 */
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	if (prev != next)
+		activate_context(next, cpu);
+}
+
+
+#endif /* __ASM_KVX_MMU_CONTEXT_H */
diff --git a/arch/kvx/include/asm/mmu_stats.h b/arch/kvx/include/asm/mmu_stats.h
new file mode 100644
index 0000000000000..999352dbc1ce1
--- /dev/null
+++ b/arch/kvx/include/asm/mmu_stats.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_MMU_STATS_H
+#define _ASM_KVX_MMU_STATS_H
+
+#ifdef CONFIG_KVX_MMU_STATS
+#include <linux/percpu.h>
+
+struct mmu_refill_stats {
+	unsigned long count;
+	unsigned long total;
+	unsigned long min;
+	unsigned long max;
+};
+
+enum mmu_refill_type {
+	MMU_REFILL_TYPE_USER,
+	MMU_REFILL_TYPE_KERNEL,
+	MMU_REFILL_TYPE_KERNEL_DIRECT,
+	MMU_REFILL_TYPE_COUNT,
+};
+
+struct mmu_stats {
+	struct mmu_refill_stats refill[MMU_REFILL_TYPE_COUNT];
+	/* keep these fields ordered this way for assembly */
+	unsigned long cycles_between_refill;
+	unsigned long last_refill;
+	unsigned long tlb_flush_all;
+};
+
+DECLARE_PER_CPU(struct mmu_stats, mmu_stats);
+#endif
+
+#endif /* _ASM_KVX_MMU_STATS_H */
diff --git a/arch/kvx/include/asm/page.h b/arch/kvx/include/asm/page.h
new file mode 100644
index 0000000000000..63a3bdd3bfdf6
--- /dev/null
+++ b/arch/kvx/include/asm/page.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_PAGE_H
+#define _ASM_KVX_PAGE_H
+
+#include <linux/const.h>
+
+#define PAGE_SHIFT		CONFIG_KVX_PAGE_SHIFT
+#define PAGE_SIZE		_BITUL(PAGE_SHIFT)
+#define PAGE_MASK		(~(PAGE_SIZE - 1))
+
+#define DDR_PHYS_OFFSET		(0x100000000)
+#define PHYS_OFFSET		CONFIG_KVX_PHYS_OFFSET
+#define PAGE_OFFSET		CONFIG_KVX_PAGE_OFFSET
+#define DDR_VIRT_OFFSET		(DDR_PHYS_OFFSET + PAGE_OFFSET)
+
+#define VA_TO_PA_OFFSET		(PHYS_OFFSET - PAGE_OFFSET)
+#define PA_TO_VA_OFFSET		(PAGE_OFFSET - PHYS_OFFSET)
+
+/*
+ * These macros are specifically written for assembly. They are useful for
+ * converting symbols above PAGE_OFFSET to their physical addresses.
+ */
+#define __PA(x)	((x) + VA_TO_PA_OFFSET)
+#define __VA(x)	((x) + PA_TO_VA_OFFSET)
+
+#if defined(CONFIG_KVX_4K_PAGES)
+/* Maximum usable bit using 4K pages and current page table layout */
+#define VA_MAX_BITS	40
+#define PGDIR_SHIFT     30
+#define PMD_SHIFT       21
+#else
+#error "64K page not supported"
+#endif
+
+/*
+ * Define _SHIFT, _SIZE and _MASK corresponding of the different page
+ * sizes supported by kvx.
+ */
+#define KVX_PAGE_4K_SHIFT 12
+#define KVX_PAGE_4K_SIZE  BIT(KVX_PAGE_4K_SHIFT)
+#define KVX_PAGE_4K_MASK  (~(KVX_PAGE_4K_SIZE - 1))
+
+#define KVX_PAGE_64K_SHIFT 16
+#define KVX_PAGE_64K_SIZE  BIT(KVX_PAGE_64K_SHIFT)
+#define KVX_PAGE_64K_MASK  (~(KVX_PAGE_64K_SIZE - 1))
+
+#define KVX_PAGE_2M_SHIFT 21
+#define KVX_PAGE_2M_SIZE  BIT(KVX_PAGE_2M_SHIFT)
+#define KVX_PAGE_2M_MASK  (~(KVX_PAGE_2M_SIZE - 1))
+
+#define KVX_PAGE_512M_SHIFT  29
+#define KVX_PAGE_512M_SIZE  BIT(KVX_PAGE_512M_SHIFT)
+#define KVX_PAGE_512M_MASK  (~(KVX_PAGE_512M_SIZE - 1))
+
+/* Encode all page shift into one 32bit constant for sbmm */
+#define KVX_PS_SHIFT_MATRIX	((KVX_PAGE_512M_SHIFT << 24) | \
+				 (KVX_PAGE_2M_SHIFT << 16) | \
+				 (KVX_PAGE_64K_SHIFT << 8) | \
+				 (KVX_PAGE_4K_SHIFT))
+
+/* Encode all page access policy into one 64bit constant for sbmm */
+#define KVX_PAGE_PA_MATRIX	((UL(TLB_PA_NA_RWX) << 56) | \
+				 (UL(TLB_PA_NA_RX) << 48) | \
+				 (UL(TLB_PA_NA_RW) << 40) | \
+				 (UL(TLB_PA_NA_R) << 32) | \
+				 (UL(TLB_PA_RWX_RWX) << 24) | \
+				 (UL(TLB_PA_RX_RX) << 16) | \
+				 (UL(TLB_PA_RW_RW) << 8) | \
+				 (UL(TLB_PA_R_R)))
+
+/*
+ * Select a byte using sbmm8. When shifted by one bit left, we get the next
+ * byte.
+ * For instance using this default constant with sbmm yields the value between
+ * first byte of the double word.
+ * If constant is shifted by 1, the value is now 0x0000000000000002ULL and this
+ * yield the second byte and so on, and so on !
+ */
+#define KVX_SBMM_BYTE_SEL	0x01
+
+#ifndef __ASSEMBLY__
+
+#include <linux/string.h>
+
+/* Page Global Directory entry */
+typedef struct {
+	unsigned long pgd;
+} pgd_t;
+
+/* Page Middle Directory entry */
+typedef struct {
+	unsigned long pmd;
+} pmd_t;
+
+/* Page Table entry */
+typedef struct {
+	unsigned long pte;
+} pte_t;
+
+/* Protection bits */
+typedef struct {
+	unsigned long pgprot;
+} pgprot_t;
+
+typedef struct page *pgtable_t;
+
+/**
+ * Macros to access entry values
+ */
+#define pgd_val(x)	((x).pgd)
+#define pmd_val(x)	((x).pmd)
+#define pte_val(x)	((x).pte)
+#define pgprot_val(x)	((x).pgprot)
+
+/**
+ * Macro to create entry from value
+ */
+#define __pgd(x)	((pgd_t) { (x) })
+#define __pmd(x)	((pmd_t) { (x) })
+#define __pte(x)	((pte_t) { (x) })
+#define __pgprot(x)	((pgprot_t) { (x) })
+
+#define pte_pgprot(x)	__pgprot(pte_val(x) & ~PFN_PTE_MASK)
+
+#define __pa(x)	((unsigned long)(x) + VA_TO_PA_OFFSET)
+#define __va(x)	((void *)((unsigned long) (x) + PA_TO_VA_OFFSET))
+
+#define phys_to_pfn(phys)	(PFN_DOWN(phys))
+#define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
+
+#define virt_to_pfn(vaddr)	(phys_to_pfn(__pa(vaddr)))
+#define pfn_to_virt(pfn)	(__va(pfn_to_phys(pfn)))
+
+#define virt_to_page(vaddr)	(pfn_to_page(virt_to_pfn(vaddr)))
+#define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
+
+#define page_to_phys(page)	virt_to_phys(page_to_virt(page))
+#define phys_to_page(phys)	(pfn_to_page(phys_to_pfn(phys)))
+
+#define virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
+
+extern void clear_page(void *to);
+extern void copy_page(void *to, void *from);
+
+static inline void clear_user_page(void *page, unsigned long vaddr,
+				struct page *pg)
+{
+	clear_page(page);
+}
+
+static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
+				struct page *topage)
+{
+	copy_page(to, from);
+}
+
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#include <asm-generic/memory_model.h>
+#include <asm-generic/getorder.h>
+
+#endif /* __ASSEMBLY__ */
+
+#endif	/* _ASM_KVX_PAGE_H */
diff --git a/arch/kvx/include/asm/page_size.h b/arch/kvx/include/asm/page_size.h
new file mode 100644
index 0000000000000..2c2850205b50e
--- /dev/null
+++ b/arch/kvx/include/asm/page_size.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_PAGE_SIZE_H
+#define _ASM_KVX_PAGE_SIZE_H
+
+#include <asm/tlb_defs.h>
+
+#if defined(CONFIG_HUGETLB_PAGE)
+#define HUGE_PAGE_SIZE (MMC_PMJ_64K | MMC_PMJ_2M | MMC_PMJ_512M)
+#else
+#define HUGE_PAGE_SIZE (0)
+#endif
+
+#if defined(CONFIG_KVX_4K_PAGES)
+#define TLB_DEFAULT_PS		TLB_PS_4K
+#define KVX_SUPPORTED_PSIZE	(MMC_PMJ_4K | HUGE_PAGE_SIZE)
+#elif defined(CONFIG_KVX_64K_PAGES)
+#define TLB_DEFAULT_PS		TLB_PS_64K
+#define KVX_SUPPORTED_PSIZE	(MMC_PMJ_64K | HUGE_PAGE_SIZE)
+#else
+#error "Unsupported page size"
+#endif
+
+#endif
diff --git a/arch/kvx/include/asm/pgalloc.h b/arch/kvx/include/asm/pgalloc.h
new file mode 100644
index 0000000000000..c199343600339
--- /dev/null
+++ b/arch/kvx/include/asm/pgalloc.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_PGALLOC_H
+#define _ASM_KVX_PGALLOC_H
+
+#include <linux/mm.h>
+#include <asm/tlb.h>
+
+#define __HAVE_ARCH_PGD_FREE
+#include <asm-generic/pgalloc.h>
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	free_pages((unsigned long) pgd, PAGES_PER_PGD);
+}
+
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd;
+
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PAGES_PER_PGD);
+	if (unlikely(pgd == NULL))
+		return NULL;
+
+	memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+
+	/* Copy kernel mappings */
+	memcpy(pgd + USER_PTRS_PER_PGD,
+	       init_mm.pgd + USER_PTRS_PER_PGD,
+	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+
+	return pgd;
+}
+
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	unsigned long pfn = virt_to_pfn(pmd);
+
+	set_pud(pud, __pud((unsigned long)pfn << PAGE_SHIFT));
+}
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
+{
+	unsigned long pfn = virt_to_pfn(pte);
+
+	set_pmd(pmd, __pmd((unsigned long)pfn << PAGE_SHIFT));
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
+{
+	unsigned long pfn = virt_to_pfn(page_address(pte));
+
+	set_pmd(pmd, __pmd((unsigned long)pfn << PAGE_SHIFT));
+}
+
+#if CONFIG_PGTABLE_LEVELS > 2
+#define __pmd_free_tlb(tlb, pmd, addr) pmd_free((tlb)->mm, pmd)
+#endif
+
+#define __pte_free_tlb(tlb, pte, buf) do {				\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	} while (0)
+
+#endif /* _ASM_KVX_PGALLOC_H */
diff --git a/arch/kvx/include/asm/pgtable-bits.h b/arch/kvx/include/asm/pgtable-bits.h
new file mode 100644
index 0000000000000..7e4f20cd1b39c
--- /dev/null
+++ b/arch/kvx/include/asm/pgtable-bits.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ *            Julian Vetter
+ */
+
+#ifndef _ASM_KVX_PGTABLE_BITS_H
+#define _ASM_KVX_PGTABLE_BITS_H
+
+/*
+ * Protection bit definition
+ * As we don't have any HW to handle page table walk, we can define
+ * our own PTE format. In order to make things easier, we are trying to match
+ * some parts of $tel and $teh.
+ *
+ * PageSZ must be on bit 10 and 11, because it matches the TEL.PS bits. By doing
+ * this it is easier in assembly to set the TEL.PS to PageSZ. In other words,
+ * KVX_PAGE_SZ_SHIFT == KVX_SFR_TEL_PS_SHIFT. It is checked by using a
+ * BUILD_BUG_ON() in arch/kvx/mm/tlb.c.
+ *
+ * The Huge bit must be somewhere in the first 12 bits to be able to detect it
+ * when reading the PMD entry.
+ *
+ * KV3-1:
+ *  +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+ *  | 63..23  | 22..13 | 12 | 11..10 | 9 | 8 | 7 | 6 | 5 | 4 | 3..2 | 1 | 0 |
+ *  +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+ *      PFN     Unused   S    PageSZ   H   G   X   W   R   D    CP    A   P
+ *
+ * Note: PFN is 40-bits wide. We use 41-bits to ensure that the upper bit is
+ *       always set to 0. This is required when shifting the PFN to the right.
+ */
+
+/* The following shifts are used in ASM to easily extract bits */
+#define _PAGE_PERMS_SHIFT      5
+#define _PAGE_GLOBAL_SHIFT     8
+#define _PAGE_HUGE_SHIFT       9
+
+#define _PAGE_PRESENT  (1 << 0)    /* Present */
+#define _PAGE_ACCESSED (1 << 1)    /* Set by tlb refill code on any access */
+/* Bits 2 - 3 are reserved for the cache policy */
+#define _PAGE_DIRTY    (1 << 4)    /* Set by tlb refill code on any write */
+#define _PAGE_READ     (1 << _PAGE_PERMS_SHIFT)    /* Readable */
+#define _PAGE_WRITE    (1 << 6)    /* Writable */
+#define _PAGE_EXEC     (1 << 7)    /* Executable */
+#define _PAGE_GLOBAL   (1 << _PAGE_GLOBAL_SHIFT)   /* Global */
+#define _PAGE_HUGE     (1 << _PAGE_HUGE_SHIFT)     /* Huge page */
+/* Bits 10 - 11 are reserved for the page size */
+#define _PAGE_SOFT     (1 << 12)   /* Reserved for software */
+
+#define _PAGE_SZ_64K           (TLB_PS_64K << KVX_PAGE_SZ_SHIFT)
+#define _PAGE_SZ_2M            (TLB_PS_2M << KVX_PAGE_SZ_SHIFT)
+#define _PAGE_SZ_512M          (TLB_PS_512M << KVX_PAGE_SZ_SHIFT)
+
+#define _PAGE_SPECIAL          _PAGE_SOFT
+
+/*
+ * If _PAGE_PRESENT is clear because the user mapped it with PROT_NONE
+ * pte_present still gives true. Bit[15] of the PTE is used since its unused
+ * for a PTE entry for kv3-1 (see above)
+ */
+#define _PAGE_NONE             (1 << 15)
+
+/* Used for swap PTEs only. */
+#define _PAGE_SWP_EXCLUSIVE    (1 << 2)
+
+/* Note: mask used in assembly cannot be generated with GENMASK */
+#define PFN_PTE_SHIFT		23
+#define PFN_PTE_MASK           (~(((1 << PFN_PTE_SHIFT) - 1)))
+
+#define KVX_PAGE_SZ_SHIFT      10
+#define KVX_PAGE_SZ_MASK       KVX_SFR_TEL_PS_MASK
+
+/* Huge page of 64K are hold in PTE table */
+#define KVX_PAGE_64K_NR_CONT   (1UL << (KVX_PAGE_64K_SHIFT - PAGE_SHIFT))
+/* Huge page of 512M are hold in PMD table */
+#define KVX_PAGE_512M_NR_CONT  (1UL << (KVX_PAGE_512M_SHIFT - PMD_SHIFT))
+
+#define KVX_PAGE_CP_SHIFT      2
+#define KVX_PAGE_CP_MASK       KVX_SFR_TEL_CP_MASK
+
+
+#define _PAGE_CACHED   (TLB_CP_W_C << KVX_PAGE_CP_SHIFT)
+#define _PAGE_UNCACHED (TLB_CP_U_U << KVX_PAGE_CP_SHIFT)
+#define _PAGE_DEVICE   (TLB_CP_D_U << KVX_PAGE_CP_SHIFT)
+
+#define KVX_ACCESS_PERMS_BITS     4
+#define KVX_ACCESS_PERMS_OFFSET   _PAGE_PERMS_SHIFT
+#define KVX_ACCESS_PERMS_SIZE     (1 << KVX_ACCESS_PERMS_BITS)
+
+#define KVX_ACCESS_PERM_START_BIT KVX_ACCESS_PERMS_OFFSET
+#define KVX_ACCESS_PERM_STOP_BIT \
+	(KVX_ACCESS_PERMS_OFFSET + KVX_ACCESS_PERMS_BITS - 1)
+#define KVX_ACCESS_PERMS_MASK \
+	GENMASK(KVX_ACCESS_PERM_STOP_BIT, KVX_ACCESS_PERM_START_BIT)
+#define KVX_ACCESS_PERMS_INDEX(x) \
+	((unsigned int)(x & KVX_ACCESS_PERMS_MASK) >> KVX_ACCESS_PERMS_OFFSET)
+
+/* Bits read, write, exec and global are not preserved across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_READ | _PAGE_WRITE | \
+					  _PAGE_EXEC | _PAGE_GLOBAL))
+
+#endif
diff --git a/arch/kvx/include/asm/pgtable.h b/arch/kvx/include/asm/pgtable.h
new file mode 100644
index 0000000000000..f33e81d7c5b1f
--- /dev/null
+++ b/arch/kvx/include/asm/pgtable.h
@@ -0,0 +1,468 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ *            Marius Gligor
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_PGTABLE_H
+#define _ASM_KVX_PGTABLE_H
+
+#include <linux/mmzone.h>
+#include <linux/mm_types.h>
+
+#include <asm/page.h>
+#include <asm/pgtable-bits.h>
+
+#include <asm-generic/pgtable-nopud.h>
+
+#include <asm/mem_map.h>
+
+struct mm_struct;
+struct vm_area_struct;
+
+/*
+ * Hugetlb definitions. All sizes are supported (64 KB, 2 MB and 512 MB).
+ */
+#if defined(CONFIG_KVX_4K_PAGES)
+#define HUGE_MAX_HSTATE		3
+#elif defined(CONFIG_KVX_64K_PAGES)
+#define HUGE_MAX_HSTATE		2
+#else
+#error "Unsupported page size"
+#endif
+
+#define HPAGE_SHIFT		PMD_SHIFT
+#define HPAGE_SIZE		BIT(HPAGE_SHIFT)
+#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+
+extern pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
+				vm_flags_t flags);
+#define arch_make_huge_pte arch_make_huge_pte
+
+/* Vmalloc definitions */
+#define VMALLOC_START	KERNEL_VMALLOC_MAP_BASE
+#define VMALLOC_END	(VMALLOC_START + KERNEL_VMALLOC_MAP_SIZE - 1)
+
+/* Also used by GDB script to go through the page table */
+#define PGDIR_BITS	(VA_MAX_BITS - PGDIR_SHIFT)
+#define PMD_BITS	(PGDIR_SHIFT - PMD_SHIFT)
+#define PTE_BITS	(PMD_SHIFT - PAGE_SHIFT)
+
+/* Size of region mapped by a page global directory */
+#define PGDIR_SIZE      BIT(PGDIR_SHIFT)
+#define PGDIR_MASK      (~(PGDIR_SIZE - 1))
+
+/* Size of region mapped by a page middle directory */
+#define PMD_SIZE        BIT(PMD_SHIFT)
+#define PMD_MASK        (~(PMD_SIZE - 1))
+
+/* Number of entries in the page global directory */
+#define PAGES_PER_PGD	2
+#define PTRS_PER_PGD	(PAGES_PER_PGD * PAGE_SIZE / sizeof(pgd_t))
+
+/* Number of entries in the page middle directory */
+#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
+
+/* Number of entries in the page table */
+#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
+
+#define USER_PTRS_PER_PGD    (TASK_SIZE/PGDIR_SIZE)
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+
+/* Page protection bits */
+#define _PAGE_BASE		(_PAGE_PRESENT | _PAGE_CACHED)
+#define _PAGE_KERNEL		(_PAGE_PRESENT | _PAGE_GLOBAL | \
+				 _PAGE_READ | _PAGE_WRITE)
+#define _PAGE_KERNEL_EXEC	(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC | \
+				 _PAGE_GLOBAL | _PAGE_WRITE)
+#define _PAGE_KERNEL_DEVICE	(_PAGE_KERNEL | _PAGE_DEVICE)
+#define _PAGE_KERNEL_NOCACHE	(_PAGE_KERNEL | _PAGE_UNCACHED)
+
+#define PAGE_NONE		__pgprot(_PAGE_NONE)
+#define PAGE_READ		__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_READ_WRITE		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE)
+#define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+#define PAGE_READ_WRITE_EXEC	__pgprot(_PAGE_BASE | _PAGE_READ |	\
+					 _PAGE_EXEC | _PAGE_WRITE)
+
+#define PAGE_KERNEL		__pgprot(_PAGE_KERNEL | _PAGE_CACHED)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL_EXEC)
+#define PAGE_KERNEL_NOCACHE	__pgprot(_PAGE_KERNEL | _PAGE_UNCACHED)
+#define PAGE_KERNEL_DEVICE	__pgprot(_PAGE_KERNEL_DEVICE)
+#define PAGE_KERNEL_RO		__pgprot((_PAGE_KERNEL | _PAGE_CACHED) & ~(_PAGE_WRITE))
+#define PAGE_KERNEL_ROX		__pgprot(_PAGE_KERNEL_EXEC  & ~(_PAGE_WRITE))
+
+#define pgprot_noncached(prot)	(__pgprot((pgprot_val(prot) & ~KVX_PAGE_CP_MASK) | _PAGE_UNCACHED))
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern struct page *empty_zero_page;
+#define ZERO_PAGE(vaddr)       (empty_zero_page)
+
+
+/*
+ * Encode and decode a swap entry. Swap PTEs are all PTEs that are !pte_none()
+ * && !pte_present(). Swap entries are encoded in an arch dependent format:
+ *
+ *  +--------+----+-------+------+---+---+---+
+ *  | 63..16 | 15 | 14..8 | 7..3 | 2 | 1 | 0 |
+ *  +--------+----+-------+------+---+---+---+
+ *    offset   0      0     type   E   0   0
+ *
+ * This allows for up to 31 swap files and 1PB per swap file.
+ */
+#define __SWP_TYPE_SHIFT        3
+#define __SWP_TYPE_BITS         5
+#define __SWP_TYPE_MASK         ((1UL << __SWP_TYPE_BITS) - 1)
+#define __SWP_OFFSET_SHIFT      16
+
+#define MAX_SWAPFILES_CHECK()   \
+	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
+
+#define __swp_type(x)   (((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
+#define __swp_offset(x) ((x).val >> __SWP_OFFSET_SHIFT)
+#define __swp_entry(type, offset) ((swp_entry_t) \
+	{ ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+
+#define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)   ((pte_t) { (x).val })
+
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	pte_val(pte) &= ~_PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
+/*
+ * PGD definitions:
+ *   - pgd_ERROR
+ */
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
+
+/*
+ * PUD
+ *
+ * As we manage a three level page table the call to set_pud is used to fill
+ * PGD.
+ */
+static inline void set_pud(pud_t *pudp, pud_t pmd)
+{
+	*pudp = pmd;
+}
+
+static inline int pud_none(pud_t pud)
+{
+	return pud_val(pud) == 0;
+}
+
+static inline int pud_bad(pud_t pud)
+{
+	return pud_none(pud);
+}
+static inline int pud_present(pud_t pud)
+{
+	return pud_val(pud) != 0;
+}
+
+static inline void pud_clear(pud_t *pud)
+{
+	set_pud(pud, __pud(0));
+}
+
+/*
+ * PMD definitions:
+ *   - set_pmd
+ *   - pmd_present
+ *   - pmd_none
+ *   - pmd_bad
+ *   - pmd_clear
+ *   - pmd_page
+ */
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	*pmdp = pmd;
+}
+
+/* Returns 1 if entry is present */
+static inline int pmd_present(pmd_t pmd)
+{
+	return pmd_val(pmd) != 0;
+}
+
+/* Returns 1 if the corresponding entry has the value 0 */
+static inline int pmd_none(pmd_t pmd)
+{
+	return pmd_val(pmd) == 0;
+}
+
+/* Used to check that a page middle directory entry is valid */
+static inline int pmd_bad(pmd_t pmd)
+{
+	return pmd_none(pmd);
+}
+
+/* Clears the entry to prevent process to use the linear address that
+ * mapped it.
+ */
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	set_pmd(pmdp, __pmd(0));
+}
+
+/*
+ * Returns the address of the descriptor of the page table referred by the
+ * PMD entry.
+ */
+static inline struct page *pmd_page(pmd_t pmd)
+{
+	if (pmd_val(pmd) & _PAGE_HUGE)
+		return pfn_to_page(
+				(pmd_val(pmd) & PFN_PTE_MASK) >> PFN_PTE_SHIFT);
+
+	return pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT);
+}
+
+#define pmd_ERROR(e) \
+	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
+
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)pfn_to_virt(pud_val(pud) >> PAGE_SHIFT);
+}
+
+static inline struct page *pud_page(pud_t pud)
+{
+	return pfn_to_page(pud_val(pud) >> PAGE_SHIFT);
+}
+
+/*
+ * PTE definitions:
+ *   - set_pte
+ *   - set_pte_at
+ *   - pte_clear
+ *   - pte_page
+ *   - pte_pfn
+ *   - pte_present
+ *   - pte_none
+ *   - pte_write
+ *   - pte_dirty
+ *   - pte_young
+ *   - pte_special
+ *   - pte_mkdirty
+ *   - pte_mkwrite_novma
+ *   - pte_mkclean
+ *   - pte_mkyoung
+ *   - pte_mkold
+ *   - pte_mkspecial
+ *   - pte_wrprotect
+ */
+
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep = pteval;
+}
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	set_pte(ptep, pteval);
+}
+
+#define pte_clear(mm, addr, ptep) set_pte(ptep, __pte(0))
+
+/* Constructs a page table entry */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
+{
+	return __pte(((pfn << PFN_PTE_SHIFT) & PFN_PTE_MASK) |
+		     pgprot_val(prot));
+}
+
+/* Builds a page table entry by combining a page descriptor and a group of
+ * access rights.
+ */
+#define mk_pte(page, prot)	(pfn_pte(page_to_pfn(page), prot))
+
+/* Modifies page access rights */
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+#define pte_page(x)     pfn_to_page(pte_pfn(x))
+
+static inline unsigned long pmd_page_vaddr(pmd_t pmd)
+{
+	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT);
+}
+
+/* Yields the page frame number (PFN) of a page table entry */
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return ((pte_val(pte) & PFN_PTE_MASK) >> PFN_PTE_SHIFT);
+}
+
+static inline int pte_present(pte_t pte)
+{
+	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_NONE));
+}
+
+static inline int pte_none(pte_t pte)
+{
+	return (pte_val(pte) == 0);
+}
+
+static inline int pte_write(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_WRITE;
+}
+
+static inline int pte_dirty(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DIRTY;
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_ACCESSED;
+}
+
+static inline int pte_special(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SPECIAL;
+}
+
+static inline int pte_huge(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_HUGE;
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkwrite_novma(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_WRITE);
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_DIRTY));
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_ACCESSED));
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+}
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_HUGE);
+}
+
+static inline pte_t pte_of_pmd(pmd_t pmd)
+{
+	return __pte(pmd_val(pmd));
+}
+
+#define pmd_pfn(pmd)       pte_pfn(pte_of_pmd(pmd))
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+#define pmdp_establish pmdp_establish
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	return __pmd(xchg(&pmd_val(*pmdp), pmd_val(pmd)));
+}
+
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_HUGE);
+}
+
+static inline pmd_t pmd_of_pte(pte_t pte)
+{
+	return __pmd(pte_val(pte));
+}
+
+
+#define pmd_mkclean(pmd)      pmd_of_pte(pte_mkclean(pte_of_pmd(pmd)))
+#define pmd_mkdirty(pmd)      pmd_of_pte(pte_mkdirty(pte_of_pmd(pmd)))
+#define pmd_mkold(pmd)	      pmd_of_pte(pte_mkold(pte_of_pmd(pmd)))
+#define pmd_mkwrite_novma(pmd)      pmd_of_pte(pte_mkwrite_novma(pte_of_pmd(pmd)))
+#define pmd_mkyoung(pmd)      pmd_of_pte(pte_mkyoung(pte_of_pmd(pmd)))
+#define pmd_modify(pmd, prot) pmd_of_pte(pte_modify(pte_of_pmd(pmd), prot))
+#define pmd_wrprotect(pmd)    pmd_of_pte(pte_wrprotect(pte_of_pmd(pmd)))
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	/* Create a huge page in PMD implies a size of 2 MB */
+	return __pmd(pmd_val(pmd) |
+			_PAGE_HUGE | (TLB_PS_2M << KVX_PAGE_SZ_SHIFT));
+}
+
+static inline pmd_t pmd_mkinvalid(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~(_PAGE_PRESENT);
+
+	return pmd;
+}
+
+#define pmd_dirty(pmd)     pte_dirty(pte_of_pmd(pmd))
+#define pmd_write(pmd)     pte_write(pte_of_pmd(pmd))
+#define pmd_young(pmd)     pte_young(pte_of_pmd(pmd))
+
+#define mk_pmd(page, prot)  pmd_of_pte(mk_pte(page, prot))
+
+static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+{
+	return __pmd(((pfn << PFN_PTE_SHIFT) & PFN_PTE_MASK) |
+			pgprot_val(prot));
+}
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+			      pmd_t *pmdp, pmd_t pmd)
+{
+	*pmdp = pmd;
+}
+
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#endif	/* _ASM_KVX_PGTABLE_H */
diff --git a/arch/kvx/include/asm/sparsemem.h b/arch/kvx/include/asm/sparsemem.h
new file mode 100644
index 0000000000000..2f35743f20fb2
--- /dev/null
+++ b/arch/kvx/include/asm/sparsemem.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPARSEMEM_H
+#define _ASM_KVX_SPARSEMEM_H
+
+#ifdef CONFIG_SPARSEMEM
+#define MAX_PHYSMEM_BITS	40
+#define SECTION_SIZE_BITS	30
+#endif /* CONFIG_SPARSEMEM */
+
+#endif /* _ASM_KVX_SPARSEMEM_H */
diff --git a/arch/kvx/include/asm/symbols.h b/arch/kvx/include/asm/symbols.h
new file mode 100644
index 0000000000000..a53c1607979fe
--- /dev/null
+++ b/arch/kvx/include/asm/symbols.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SYMBOLS_H
+#define _ASM_KVX_SYMBOLS_H
+
+/* Symbols to patch TLB refill handler */
+extern char kvx_perf_tlb_refill[], kvx_std_tlb_refill[];
+
+/* Entry point of the ELF, used to start other PEs in SMP */
+extern int kvx_start[];
+
+#endif
diff --git a/arch/kvx/include/asm/tlb.h b/arch/kvx/include/asm/tlb.h
new file mode 100644
index 0000000000000..190b682e18191
--- /dev/null
+++ b/arch/kvx/include/asm/tlb.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_TLB_H
+#define _ASM_KVX_TLB_H
+
+struct mmu_gather;
+
+static void tlb_flush(struct mmu_gather *tlb);
+
+int clear_ltlb_entry(unsigned long vaddr);
+
+#include <asm-generic/tlb.h>
+
+static inline unsigned int pgprot_cache_policy(unsigned long flags)
+{
+	return (flags & KVX_PAGE_CP_MASK) >> KVX_PAGE_CP_SHIFT;
+}
+
+#endif /* _ASM_KVX_TLB_H */
diff --git a/arch/kvx/include/asm/tlb_defs.h b/arch/kvx/include/asm/tlb_defs.h
new file mode 100644
index 0000000000000..1c77f7387ecea
--- /dev/null
+++ b/arch/kvx/include/asm/tlb_defs.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_TLB_DEFS_H
+#define _ASM_KVX_TLB_DEFS_H
+
+#include <linux/sizes.h>
+
+#include <asm/sfr.h>
+
+/* Architecture specification */
+#define MMC_SB_JTLB 0
+#define MMC_SB_LTLB 1
+
+#define MMU_LTLB_SETS 1
+#define MMU_LTLB_WAYS 16
+
+#define MMU_JTLB_SETS 64
+#define MMU_JTLB_WAYS_SHIFT 2
+#define MMU_JTLB_WAYS (1 << MMU_JTLB_WAYS_SHIFT)
+
+#define MMU_JTLB_ENTRIES	(MMU_JTLB_SETS << MMU_JTLB_WAYS_SHIFT)
+
+/* Set is determined using the 6 lsb of virtual page */
+#define MMU_JTLB_SET_MASK (MMU_JTLB_SETS - 1)
+#define MMU_JTLB_WAY_MASK (MMU_JTLB_WAYS - 1)
+
+/* TLB: Entry Status */
+#define TLB_ES_INVALID    0
+#define TLB_ES_PRESENT    1
+#define TLB_ES_MODIFIED   2
+#define TLB_ES_A_MODIFIED 3
+
+/* TLB: Cache Policy - First value is for data, the second is for instruction
+ * Symbols are
+ *   D: device
+ *   U: uncached
+ *   W: write through
+ *   C: cache enabled
+ */
+#define TLB_CP_D_U 0
+#define TLB_CP_U_U 1
+#define TLB_CP_W_C 2
+#define TLB_CP_U_C 3
+
+/* TLB: Protection Attributes: First value is when PM=0, second is when PM=1
+ * Symbols are:
+ *   NA: no access
+ *   R : read
+ *   W : write
+ *   X : execute
+ */
+#define TLB_PA_NA_NA   0
+#define TLB_PA_NA_R    1
+#define TLB_PA_NA_RW   2
+#define TLB_PA_NA_RX   3
+#define TLB_PA_NA_RWX  4
+#define TLB_PA_R_R     5
+#define TLB_PA_R_RW    6
+#define TLB_PA_R_RX    7
+#define TLB_PA_R_RWX   8
+#define TLB_PA_RW_RW   9
+#define TLB_PA_RW_RWX  10
+#define TLB_PA_RX_RX   11
+#define TLB_PA_RX_RWX  12
+#define TLB_PA_RWX_RWX 13
+
+/* TLB: Page Size */
+#define TLB_PS_4K   0
+#define TLB_PS_64K  1
+#define TLB_PS_2M   2
+#define TLB_PS_512M 3
+
+#define TLB_G_GLOBAL	1
+#define TLB_G_USE_ASN	0
+
+#define TLB_MK_TEH_ENTRY(_vaddr, _vs, _global, _asn) \
+	(((_vs) << KVX_SFR_TEH_VS_SHIFT) | \
+	((_global) << KVX_SFR_TEH_G_SHIFT) | \
+	((_asn) << KVX_SFR_TEH_ASN_SHIFT) | \
+	(((_vaddr) >> KVX_SFR_TEH_PN_SHIFT) << KVX_SFR_TEH_PN_SHIFT))
+
+#define TLB_MK_TEL_ENTRY(_paddr, _ps, _es, _cp, _pa) \
+	(((_es) << KVX_SFR_TEL_ES_SHIFT) | \
+	((_ps) << KVX_SFR_TEL_PS_SHIFT) | \
+	((_cp) << KVX_SFR_TEL_CP_SHIFT) | \
+	((_pa) << KVX_SFR_TEL_PA_SHIFT) | \
+	(((_paddr) >> KVX_SFR_TEL_FN_SHIFT) << KVX_SFR_TEL_FN_SHIFT))
+
+
+/* Refill routine related defines */
+#define REFILL_PERF_ENTRIES	4
+#define REFILL_PERF_PAGE_SIZE	SZ_512M
+
+/* paddr will be inserted in assembly code */
+#define REFILL_PERF_TEL_VAL \
+	TLB_MK_TEL_ENTRY(0, TLB_PS_512M, TLB_ES_A_MODIFIED, TLB_CP_W_C, \
+			 TLB_PA_NA_RWX)
+/* vaddr will be inserted in assembly code */
+#define REFILL_PERF_TEH_VAL	TLB_MK_TEH_ENTRY(0, 0, TLB_G_GLOBAL, 0)
+
+/*
+ * LTLB fixed entry index
+ */
+#define LTLB_ENTRY_KERNEL_TEXT	0
+#define LTLB_ENTRY_GDB_PAGE	1
+#define LTLB_ENTRY_VIRTUAL_SMEM	2
+/* Reserve entries for kernel pagination */
+#define LTLB_KERNEL_RESERVED	3
+/* This define should reflect the maximum number of fixed LTLB entries */
+#define LTLB_ENTRY_FIXED_COUNT	(LTLB_KERNEL_RESERVED + REFILL_PERF_ENTRIES)
+#define LTLB_ENTRY_EARLY_SMEM	LTLB_ENTRY_FIXED_COUNT
+
+/* MMC: Protection Trap Cause */
+#define MMC_PTC_RESERVED 0
+#define MMC_PTC_READ     1
+#define MMC_PTC_WRITE    2
+#define MMC_PTC_EXECUTE  3
+
+/* MMC: Page size Mask in JTLB */
+#define MMC_PMJ_4K   1
+#define MMC_PMJ_64K  2
+#define MMC_PMJ_2M   4
+#define MMC_PMJ_512M 8
+
+#endif
diff --git a/arch/kvx/include/asm/tlbflush.h b/arch/kvx/include/asm/tlbflush.h
new file mode 100644
index 0000000000000..6c11fe7108078
--- /dev/null
+++ b/arch/kvx/include/asm/tlbflush.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_TLBFLUSH_H
+#define _ASM_KVX_TLBFLUSH_H
+
+#include <linux/sched.h>
+#include <linux/printk.h>
+#include <linux/mm_types.h>
+
+extern void local_flush_tlb_page(struct vm_area_struct *vma,
+				 unsigned long addr);
+extern void local_flush_tlb_all(void);
+extern void local_flush_tlb_mm(struct mm_struct *mm);
+extern void local_flush_tlb_range(struct vm_area_struct *vma,
+				  unsigned long start,
+				  unsigned long end);
+extern void local_flush_tlb_kernel_range(unsigned long start,
+					 unsigned long end);
+
+#ifdef CONFIG_SMP
+extern void smp_flush_tlb_all(void);
+extern void smp_flush_tlb_mm(struct mm_struct *mm);
+extern void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
+extern void smp_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
+extern void smp_flush_tlb_kernel_range(unsigned long start, unsigned long end);
+
+static inline void flush_tlb(void)
+{
+	smp_flush_tlb_mm(current->mm);
+}
+
+#define flush_tlb_page         smp_flush_tlb_page
+#define flush_tlb_all          smp_flush_tlb_all
+#define flush_tlb_mm           smp_flush_tlb_mm
+#define flush_tlb_range        smp_flush_tlb_range
+#define flush_tlb_kernel_range smp_flush_tlb_kernel_range
+
+#else
+#define flush_tlb_page         local_flush_tlb_page
+#define flush_tlb_all          local_flush_tlb_all
+#define flush_tlb_mm           local_flush_tlb_mm
+#define flush_tlb_range        local_flush_tlb_range
+#define flush_tlb_kernel_range local_flush_tlb_kernel_range
+#endif
+
+void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+		pmd_t *pmd);
+
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+	unsigned long address, pte_t *ptep, unsigned int nr);
+void update_mmu_cache(struct vm_area_struct *vma,
+	unsigned long address, pte_t *ptep);
+
+#endif /* _ASM_KVX_TLBFLUSH_H */
diff --git a/arch/kvx/include/asm/vmalloc.h b/arch/kvx/include/asm/vmalloc.h
new file mode 100644
index 0000000000000..a07692431108e
--- /dev/null
+++ b/arch/kvx/include/asm/vmalloc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_VMALLOC_H
+#define _ASM_KVX_VMALLOC_H
+
+#endif /* _ASM_KVX_VMALLOC_H */
diff --git a/arch/kvx/mm/cacheflush.c b/arch/kvx/mm/cacheflush.c
new file mode 100644
index 0000000000000..62ec07266708e
--- /dev/null
+++ b/arch/kvx/mm/cacheflush.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/smp.h>
+#include <linux/hugetlb.h>
+#include <linux/mm_types.h>
+
+#include <asm/cacheflush.h>
+
+#ifdef CONFIG_SMP
+
+struct flush_data {
+	unsigned long start;
+	unsigned long end;
+};
+
+static inline void ipi_flush_icache_range(void *arg)
+{
+	struct flush_data *ta = arg;
+
+	local_flush_icache_range(ta->start, ta->end);
+}
+
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	struct flush_data data = {
+		.start = start,
+		.end = end
+	};
+
+	/* Then invalidate L1 icache on all cpus */
+	on_each_cpu(ipi_flush_icache_range, &data, 1);
+}
+EXPORT_SYMBOL(flush_icache_range);
+
+#endif /* CONFIG_SMP */
+
+void dcache_wb_inval_phys_range(phys_addr_t addr, unsigned long len, bool wb,
+				bool inval)
+{
+	if (wb && inval) {
+		wbinval_dcache_range(addr, len);
+	} else {
+		if (inval)
+			inval_dcache_range(addr, len);
+		if (wb)
+			wb_dcache_range(addr, len);
+	}
+}
+
+static inline pte_t *get_ptep(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return NULL;
+
+	/* checks for huge page at pmd level */
+	if (pmd_leaf(*pmd)) {
+		pte = (pte_t *) pmd;
+		if (!pte_present(*pte))
+			return NULL;
+
+		return pte;
+	}
+
+	pte = pte_offset_map(pmd, addr);
+	if (!pte_present(*pte))
+		return NULL;
+
+	return pte;
+}
+
+static unsigned long dcache_wb_inval_virt_to_phys(struct vm_area_struct *vma,
+						  unsigned long vaddr,
+						  unsigned long len,
+						  bool wb, bool inval)
+{
+	unsigned long pfn, offset, pgsize;
+	pte_t *ptep;
+
+	ptep = get_ptep(vma->vm_mm, vaddr);
+	if (!ptep) {
+		/*
+		 * Since we did not found a matching pte, return needed
+		 * length to be aligned on next page boundary
+		 */
+		offset = (vaddr & (PAGE_SIZE - 1));
+		return PAGE_SIZE - offset;
+	}
+
+	/* Handle page sizes correctly */
+	pgsize = (pte_val(*ptep) & KVX_PAGE_SZ_MASK) >> KVX_PAGE_SZ_SHIFT;
+	pgsize = (1 << get_page_size_shift(pgsize));
+
+	offset = vaddr & (pgsize - 1);
+	len = min(pgsize - offset, len);
+	pfn = pte_pfn(*ptep);
+
+	dcache_wb_inval_phys_range(PFN_PHYS(pfn) + offset, len, wb, inval);
+
+	return len;
+}
+
+int dcache_wb_inval_virt_range(unsigned long vaddr, unsigned long len, bool wb,
+			       bool inval)
+{
+	unsigned long end = vaddr + len;
+	unsigned long vma_end;
+	struct vm_area_struct *vma;
+	unsigned long rlen;
+	struct mm_struct *mm = current->mm;
+
+	/* necessary for find_vma */
+	mmap_read_lock(mm);
+
+	/*
+	 * Verify that the specified address region actually belongs to this
+	 * process.
+	 */
+	while (vaddr < end) {
+		vma = find_vma(current->mm, vaddr);
+		if (vma == NULL || vaddr < vma->vm_start) {
+			mmap_read_unlock(mm);
+			return -EFAULT;
+		}
+		vma_end = min(end, vma->vm_end);
+		while (vaddr < vma_end) {
+			rlen = dcache_wb_inval_virt_to_phys(vma, vaddr, len, wb, inval);
+			len -= rlen;
+			vaddr += rlen;
+		}
+	}
+
+	mmap_read_unlock(mm);
+
+	return 0;
+}
diff --git a/arch/kvx/mm/dma-mapping.c b/arch/kvx/mm/dma-mapping.c
new file mode 100644
index 0000000000000..d73fbb1c35896
--- /dev/null
+++ b/arch/kvx/mm/dma-mapping.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Jules Maselbas
+ *            Julian Vetter
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include "../../../drivers/iommu/dma-iommu.h"
+
+#include <asm/cacheflush.h>
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	unsigned long addr = (unsigned long) page_to_phys(page);
+
+	/* Flush pending data and invalidate pages */
+	wbinval_dcache_range(addr, size);
+}
+
+/**
+ * The implementation of arch should follow the following rules:
+ *		map		for_cpu		for_device	unmap
+ * TO_DEV	writeback	none		writeback	none
+ * FROM_DEV	invalidate	invalidate(*)	invalidate	invalidate(*)
+ * BIDIR	writeback	invalidate	writeback	invalidate
+ *
+ * (*) - only necessary if the CPU speculatively prefetches.
+ *
+ * (see https://lkml.org/lkml/2018/5/18/979)
+ */
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		inval_dcache_range(paddr, size);
+		break;
+
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		wb_dcache_range(paddr, size);
+		break;
+
+	default:
+		WARN_ON_ONCE(true);
+	}
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+			   enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		inval_dcache_range(paddr, size);
+		break;
+
+	default:
+		WARN_ON_ONCE(true);
+	}
+}
+
+#ifdef CONFIG_IOMMU_DMA
+void arch_teardown_dma_ops(struct device *dev)
+{
+	dev->dma_ops = NULL;
+}
+#endif /* CONFIG_IOMMU_DMA*/
+
+void arch_setup_dma_ops(struct device *dev, bool coherent)
+{
+	dev->dma_coherent = coherent;
+	if (device_iommu_mapped(dev))
+		iommu_setup_dma_ops(dev);
+}
diff --git a/arch/kvx/mm/extable.c b/arch/kvx/mm/extable.c
new file mode 100644
index 0000000000000..8889a1a90a775
--- /dev/null
+++ b/arch/kvx/mm/extable.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/riscv/mm/extable.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+
+#include <linux/extable.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+
+int fixup_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(regs->spc);
+	if (fixup) {
+		regs->spc = fixup->fixup;
+		return 1;
+	}
+	return 0;
+}
diff --git a/arch/kvx/mm/fault.c b/arch/kvx/mm/fault.c
new file mode 100644
index 0000000000000..9d8513db57a8d
--- /dev/null
+++ b/arch/kvx/mm/fault.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ *            Yann Sionneau
+ */
+
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/perf_event.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/signal.h>
+#include <linux/mm.h>
+
+#include <asm/mmu.h>
+#include <asm/traps.h>
+#include <asm/ptrace.h>
+#include <asm/pgtable.h>
+#include <asm/sfr_defs.h>
+#include <asm/current.h>
+#include <asm/tlbflush.h>
+
+static int handle_vmalloc_fault(uint64_t ea)
+{
+	/*
+	 * Synchronize this task's top level page-table with
+	 * the 'reference' page table.
+	 * As we only have 2 or 3 level page table we don't need to
+	 * deal with other levels.
+	 */
+	unsigned long addr = ea & PAGE_MASK;
+	pgd_t *pgd_k, *pgd;
+	p4d_t *p4d_k, *p4d;
+	pud_t *pud_k, *pud;
+	pmd_t *pmd_k, *pmd;
+	pte_t *pte_k;
+
+	pgd = pgd_offset(current->active_mm, ea);
+	pgd_k = pgd_offset_k(ea);
+	if (!pgd_present(*pgd_k))
+		return 1;
+	set_pgd(pgd, *pgd_k);
+
+	p4d = p4d_offset(pgd, ea);
+	p4d_k = p4d_offset(pgd_k, ea);
+	if (!p4d_present(*p4d_k))
+		return 1;
+
+	pud = pud_offset(p4d, ea);
+	pud_k = pud_offset(p4d_k, ea);
+	if (!pud_present(*pud_k))
+		return 1;
+
+	pmd = pmd_offset(pud, ea);
+	pmd_k = pmd_offset(pud_k, ea);
+	if (!pmd_present(*pmd_k))
+		return 1;
+
+	/* Some other architectures set pmd to synchronize them but
+	 * as we just synchronized the pgd we don't see how they can
+	 * be different. Maybe we miss something so in case we
+	 * put a guard here.
+	 */
+	if (pmd_val(*pmd) != pmd_val(*pmd_k))
+		pr_err("%s: pmd not synchronized (0x%lx != 0x%lx)\n",
+		       __func__, pmd_val(*pmd), pmd_val(*pmd_k));
+
+	pte_k = pte_offset_kernel(pmd_k, ea);
+	if (!pte_present(*pte_k)) {
+		pr_err("%s: PTE not present for 0x%llx\n",
+		       __func__, ea);
+		return 1;
+	}
+
+	/* We refill the TLB now to avoid to take another nomapping
+	 * trap.
+	 */
+	kvx_mmu_jtlb_add_entry(addr, pte_k, 0);
+
+	return 0;
+}
+
+void do_page_fault(struct pt_regs *regs, uint64_t es, uint64_t ea)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned long flags, cause, vma_mask;
+	int code = SEGV_MAPERR;
+	vm_fault_t fault;
+
+	cause = kvx_sfr_field_val(es, ES, RWX);
+
+	/* We fault-in kernel-space virtual memory on-demand. The
+	 * 'reference' page table is init_mm.pgd.
+	 */
+	if (is_vmalloc_addr((void *) ea) && !user_mode(regs)) {
+		if (handle_vmalloc_fault(ea))
+			goto no_context;
+		return;
+	}
+
+	mm = current->mm;
+
+	/*
+	 * If we're in an interrupt or have no user
+	 * context, we must not take the fault..
+	 */
+	if (unlikely(faulthandler_disabled() || !mm))
+		goto no_context;
+
+	/* By default we retry and fault task can be killed */
+	flags = FAULT_FLAG_DEFAULT;
+
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, ea);
+
+retry:
+	mmap_read_lock(mm);
+
+	vma = find_vma(mm, ea);
+	if (!vma)
+		goto bad_area;
+	if (likely(vma->vm_start <= ea))
+		goto good_area;
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		goto bad_area;
+	vma = expand_stack(mm, ea);
+	if (unlikely(!vma))
+		goto bad_area_nosemaphore;
+
+good_area:
+	/* Handle access type */
+	switch (cause) {
+	case KVX_TRAP_RWX_FETCH:
+		vma_mask = VM_EXEC;
+		break;
+	case KVX_TRAP_RWX_READ:
+		vma_mask = VM_READ;
+		break;
+	case KVX_TRAP_RWX_WRITE:
+		vma_mask = VM_WRITE;
+		flags |= FAULT_FLAG_WRITE;
+		break;
+	/* Atomic are both read/write */
+	case KVX_TRAP_RWX_ATOMIC:
+		vma_mask = VM_WRITE | VM_READ;
+		flags |= FAULT_FLAG_WRITE;
+		break;
+	default:
+		panic("%s: unhandled cause %lu", __func__, cause);
+	}
+
+	if ((vma->vm_flags & vma_mask) != vma_mask) {
+		code = SEGV_ACCERR;
+		goto bad_area;
+	}
+
+	/*
+	 * If for any reason we can not handle the fault we make sure that
+	 * we exit gracefully rather then retry endlessly with the same
+	 * result.
+	 */
+	fault = handle_mm_fault(vma, ea, flags, regs);
+
+	/*
+	 * If we need to retry but a fatal signal is pending, handle the
+	 * signal first. We do not need to release the mmap_sem because it
+	 * would already be released in __lock_page_or_retry in mm/filemap.c.
+	 */
+	if (fault_signal_pending(fault, regs))
+		return;
+
+	/* The fault is fully completed (including releasing mmap lock) */
+	if (fault & VM_FAULT_COMPLETED)
+		return;
+
+	if (unlikely(fault & VM_FAULT_ERROR)) {
+		if (fault & VM_FAULT_OOM)
+			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
+		else if (fault & VM_FAULT_SIGBUS)
+			goto do_sigbus;
+		BUG();
+	}
+
+	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
+		flags |= FAULT_FLAG_TRIED;
+		/* No need to up_read(&mm->mmap_sem) as we would
+		 * have already released it in __lock_page_or_retry().
+		 * Look in mm/filemap.c for explanations.
+		 */
+		goto retry;
+	}
+
+	/* Fault errors and retry case have been handled nicely */
+	mmap_read_unlock(mm);
+	return;
+
+bad_area:
+	mmap_read_unlock(mm);
+bad_area_nosemaphore:
+
+	if (user_mode(regs)) {
+		user_do_sig(regs, SIGSEGV, code, ea);
+		return;
+	}
+
+no_context:
+	/* Are we prepared to handle this kernel fault?
+	 *
+	 * (The kernel has valid exception-points in the source
+	 *  when it accesses user-memory. When it fails in one
+	 *  of those points, we find it in a table and do a jump
+	 *  to some fixup code that loads an appropriate error
+	 *  code)
+	 */
+	if (fixup_exception(regs))
+		return;
+
+	/*
+	 * Oops. The kernel tried to access some bad page. We'll have to
+	 * terminate things with extreme prejudice.
+	 */
+	bust_spinlocks(1);
+	if (kvx_sfr_field_val(es, ES, HTC) == KVX_TRAP_PROTECTION)
+		pr_alert(CUT_HERE "Kernel protection trap at virtual address %016llx\n",
+			 ea);
+	else {
+		pr_alert(CUT_HERE "Unable to handle kernel %s at virtual address %016llx\n",
+			 (ea < PAGE_SIZE) ? "NULL pointer dereference" :
+			 "paging request", ea);
+	}
+	die(regs, ea, "Oops");
+	bust_spinlocks(0);
+	make_task_dead(SIGKILL);
+
+out_of_memory:
+	/*
+	 * We ran out of memory, call the OOM killer, and return the userspace
+	 * (which will retry the fault, or kill us if we got oom-killed).
+	 */
+	mmap_read_unlock(mm);
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
+
+do_sigbus:
+	mmap_read_unlock(mm);
+	/* Kernel mode? Handle exceptions or die */
+	if (!user_mode(regs))
+		goto no_context;
+
+	user_do_sig(regs, SIGBUS, BUS_ADRERR, ea);
+
+	return;
+
+}
+
+void do_writetoclean(struct pt_regs *regs, uint64_t es, uint64_t ea)
+{
+	panic("%s not implemented", __func__);
+}
diff --git a/arch/kvx/mm/init.c b/arch/kvx/mm/init.c
new file mode 100644
index 0000000000000..c68468b8957ea
--- /dev/null
+++ b/arch/kvx/mm/init.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+/* Memblock header depends on types.h but does not include it ! */
+#include <linux/types.h>
+#include <linux/memblock.h>
+#include <linux/mmzone.h>
+#include <linux/of_fdt.h>
+#include <linux/sched.h>
+#include <linux/sizes.h>
+#include <linux/init.h>
+#include <linux/initrd.h>
+#include <linux/pfn.h>
+#include <linux/mm.h>
+
+#include <asm/sections.h>
+#include <asm/tlb_defs.h>
+#include <asm/tlbflush.h>
+#include <asm/fixmap.h>
+#include <asm/page.h>
+#include <asm/setup.h>
+
+/*
+ * On kvx, memory map contains the first 2G of DDR being aliased.
+ * Full contiguous DDR is located at @[4G - 68G].
+ * However, to access this DDR in 32bit mode, the first 2G of DDR are
+ * mirrored from 4G to 2G.
+ * These first 2G are accessible from all DMAs (included 32 bits one).
+ *
+ * Hence, the memory map is the following:
+ *
+ * (68G) 0x1100000000-> +-------------+
+ *                      |             |
+ *              66G     |(ZONE_NORMAL)|
+ *                      |             |
+ *   (6G) 0x180000000-> +-------------+
+ *                      |             |
+ *              2G      |(ZONE_DMA32) |
+ *                      |             |
+ *   (4G) 0x100000000-> +-------------+ +--+
+ *                      |             |    |
+ *              2G      |   (Alias)   |    | 2G Alias
+ *                      |             |    |
+ *    (2G) 0x80000000-> +-------------+ <--+
+ *
+ * The translation of 64 bits -> 32 bits can then be done using dma-ranges property
+ * in device-trees.
+ */
+
+#define DDR_64BIT_START		(4ULL * SZ_1G)
+#define DDR_32BIT_ALIAS_SIZE	(2ULL * SZ_1G)
+
+#define MAX_DMA32_PFN	PHYS_PFN(DDR_64BIT_START + DDR_32BIT_ALIAS_SIZE)
+
+#define SMEM_GLOBAL_START	(16 * 1024 * 1024)
+#define SMEM_GLOBAL_END		(20 * 1024 * 1024)
+#define MAX_SMEM_MEMBLOCKS	(32)
+
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+
+/*
+ * empty_zero_page is a special page that is used for zero-initialized data and
+ * COW.
+ */
+struct page *empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
+
+extern char _start[];
+extern char __kernel_smem_code_start[];
+extern char __kernel_smem_code_end[];
+
+static void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES];
+
+	memset(zones_size, 0, sizeof(zones_size));
+
+	zones_size[ZONE_DMA32] = min(MAX_DMA32_PFN, max_low_pfn);
+	zones_size[ZONE_NORMAL] = max_low_pfn;
+
+	free_area_init(zones_size);
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_initrd(void)
+{
+	u64 base = phys_initrd_start;
+	u64 end = phys_initrd_start + phys_initrd_size;
+
+	if (phys_initrd_size == 0) {
+		pr_info("initrd not found or empty");
+		return;
+	}
+
+	if (base < memblock_start_of_DRAM() || end > memblock_end_of_DRAM()) {
+		pr_err("initrd not in accessible memory, disabling it");
+		phys_initrd_size = 0;
+		return;
+	}
+
+	pr_info("initrd: 0x%llx - 0x%llx\n", base, end);
+
+	memblock_reserve(phys_initrd_start, phys_initrd_size);
+
+	/* the generic initrd code expects virtual addresses */
+	initrd_start = (unsigned long) __va(base);
+	initrd_end = initrd_start + phys_initrd_size;
+}
+#endif
+
+static phys_addr_t memory_limit = PHYS_ADDR_MAX;
+
+static int __init early_mem(char *p)
+{
+	if (!p)
+		return 1;
+
+	memory_limit = memparse(p, &p) & PAGE_MASK;
+	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
+
+	return 0;
+}
+early_param("mem", early_mem);
+
+static void __init setup_bootmem(void)
+{
+	phys_addr_t start, end = 0;
+	u64 i;
+	struct memblock_region *region = NULL;
+	struct memblock_region to_be_reserved[MAX_SMEM_MEMBLOCKS] = {};
+	struct memblock_region *reserve = to_be_reserved;
+
+	init_mm.start_code = (unsigned long)_stext;
+	init_mm.end_code = (unsigned long)_etext;
+	init_mm.end_data = (unsigned long)_edata;
+	init_mm.brk = (unsigned long)_end;
+
+	memblock_reserve(__pa(_start),  __pa(_end) -  __pa(_start));
+
+
+	for_each_mem_range(i, &start, &end) {
+		pr_info("%15s: memory  : 0x%lx - 0x%lx\n", __func__,
+			(unsigned long)start,
+			(unsigned long)end);
+	}
+
+	/* min_low_pfn is the lowest PFN available in the system */
+	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
+
+	/* max_low_pfn indicates the end if NORMAL zone */
+	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
+
+	/* Set the maximum number of pages in the system */
+	set_max_mapnr(max_low_pfn - min_low_pfn);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif
+
+	if (memory_limit != PHYS_ADDR_MAX)
+		memblock_mem_limit_remove_map(memory_limit);
+
+	/* Don't reserve the device tree if its builtin */
+	if (!is_kernel_rodata((unsigned long) initial_boot_params))
+		early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+
+	start = SMEM_GLOBAL_START;
+	/*
+	 * make sure all smem is reserved
+	 * It seems that it's not OK to call memblock_reserve() from
+	 * for_each_reserved_mem_region() {} loop, so let's store
+	 * the "to be reserved" regions in the to_be_reserved array.
+	 */
+	for_each_reserved_mem_region(region) {
+		if (region->base >= SMEM_GLOBAL_END)
+			break; /* we finished to scan the smem area */
+
+		if (region->base > SMEM_GLOBAL_START && region->base != start) {
+			if (reserve > &to_be_reserved[MAX_SMEM_MEMBLOCKS - 1]) {
+				pr_crit("Impossible to mark the whole smem as reserved memory.\n");
+				pr_crit("It would take more than the maximum of %d memblocks.\n",
+					MAX_SMEM_MEMBLOCKS);
+				break;
+			}
+			reserve->base = start;
+			reserve->size = region->base - start;
+			reserve++;
+		}
+
+		start = region->base + region->size;
+	}
+
+	if (start < SMEM_GLOBAL_END)
+		memblock_reserve(start, SMEM_GLOBAL_END - start);
+
+	/* Now let's reserve the smem memblocks for real */
+	for (region = to_be_reserved; region->size != 0; region++)
+		memblock_reserve(region->base, region->size);
+
+	memblock_allow_resize();
+	memblock_dump_all();
+}
+
+static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
+static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss __maybe_unused;
+
+void __init early_fixmap_init(void)
+{
+	unsigned long vaddr;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * Fixed mappings:
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
+	pgd = pgd_offset_pgd(swapper_pg_dir, vaddr);
+	set_pgd(pgd, __pgd(__pa_symbol(fixmap_pmd)));
+
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
+	pmd = pmd_offset(pud, vaddr);
+	set_pmd(pmd, __pmd(__pa_symbol(fixmap_pte)));
+}
+
+void __init setup_arch_memory(void)
+{
+	setup_bootmem();
+	sparse_init();
+	zone_sizes_init();
+}
+
+void __init mem_init(void)
+{
+	memblock_free_all();
+
+	/* allocate the zero page */
+	empty_zero_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!empty_zero_page)
+		panic("Failed to allocate the empty_zero_page");
+}
+
+void free_initmem(void)
+{
+#ifdef CONFIG_POISON_INITMEM
+	free_initmem_default(0x0);
+#else
+	free_initmem_default(-1);
+#endif
+}
+
+void __set_fixmap(enum fixed_addresses idx,
+				phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *pte;
+
+
+	BUG_ON(idx >= __end_of_fixed_addresses);
+
+	pte = &fixmap_pte[pte_index(addr)];
+
+	if (pgprot_val(flags)) {
+		set_pte(pte, pfn_pte(phys_to_pfn(phys), flags));
+	} else {
+		/* Remove the fixmap */
+		pte_clear(&init_mm, addr, pte);
+	}
+	local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
+
+static const pgprot_t protection_map[16] = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READ,
+	[VM_WRITE]					= PAGE_READ,
+	[VM_WRITE | VM_READ]				= PAGE_READ,
+	[VM_EXEC]					= PAGE_READ_EXEC,
+	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
+	[VM_EXEC | VM_WRITE]				= PAGE_READ_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_READ_EXEC,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READ,
+	[VM_SHARED | VM_WRITE]				= PAGE_READ_WRITE,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_READ_WRITE,
+	[VM_SHARED | VM_EXEC]				= PAGE_READ_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READ_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_READ_WRITE_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_READ_WRITE_EXEC
+};
+DECLARE_VM_GET_PAGE_PROT
diff --git a/arch/kvx/mm/mmap.c b/arch/kvx/mm/mmap.c
new file mode 100644
index 0000000000000..a2225db644384
--- /dev/null
+++ b/arch/kvx/mm/mmap.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm64/mm/mmap.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifdef CONFIG_STRICT_DEVMEM
+
+#include <linux/mm.h>
+#include <linux/ioport.h>
+
+#include <asm/page.h>
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain address
+ * is valid. The argument is a physical page number.  We mimic x86 here by
+ * disallowing access to system RAM as well as device-exclusive MMIO regions.
+ * This effectively disable read()/write() on /dev/mem.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+		return 0;
+	if (!page_is_ram(pfn))
+		return 1;
+	return 0;
+}
+
+#endif
diff --git a/arch/kvx/mm/mmu.c b/arch/kvx/mm/mmu.c
new file mode 100644
index 0000000000000..9cb11bd2dfdf7
--- /dev/null
+++ b/arch/kvx/mm/mmu.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Vincent Chardon
+ *            Jules Maselbas
+ */
+
+#include <linux/cache.h>
+#include <linux/types.h>
+#include <linux/irqflags.h>
+#include <linux/printk.h>
+#include <linux/percpu.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
+
+#include <asm/mmu.h>
+#include <asm/tlb.h>
+#include <asm/page_size.h>
+#include <asm/mmu_context.h>
+
+#define DUMP_LTLB 0
+#define DUMP_JTLB 1
+
+DEFINE_PER_CPU_ALIGNED(uint8_t[MMU_JTLB_SETS], jtlb_current_set_way);
+static struct kvx_tlb_format ltlb_entries[MMU_LTLB_WAYS];
+static unsigned long ltlb_entries_bmp;
+
+static int kvx_mmu_ltlb_overlaps(struct kvx_tlb_format tlbe)
+{
+	int bit = LTLB_ENTRY_FIXED_COUNT;
+
+	for_each_set_bit_from(bit, &ltlb_entries_bmp, MMU_LTLB_WAYS) {
+		if (tlb_entry_overlaps(tlbe, ltlb_entries[bit]))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * kvx_mmu_ltlb_add_entry - Add a kernel entry in the LTLB
+ *
+ * In order to lock some entries in the LTLB and be always mapped, this
+ * function can be called with a physical address, a virtual address and
+ * protection attribute to add an entry into the LTLB. This is mainly for
+ * performances since there won't be any NOMAPPING traps for these pages.
+ *
+ * @vaddr: Virtual address for the entry (must be aligned according to tlb_ps)
+ * @paddr: Physical address for the entry (must be aligned according to tlb_ps)
+ * @flags: Protection attributes
+ * @tlb_ps: Page size attribute for TLB (TLB_PS_*)
+ */
+void kvx_mmu_ltlb_add_entry(unsigned long vaddr, phys_addr_t paddr,
+			    pgprot_t flags, unsigned long tlb_ps)
+{
+	unsigned int cp;
+	unsigned int idx;
+	unsigned long irqflags;
+	struct kvx_tlb_format tlbe;
+	u64 page_size = BIT(get_page_size_shift(tlb_ps));
+
+	BUG_ON(!IS_ALIGNED(vaddr, page_size) || !IS_ALIGNED(paddr, page_size));
+
+	cp = pgprot_cache_policy(pgprot_val(flags));
+
+	tlbe = tlb_mk_entry(
+		(void *) paddr,
+		(void *) vaddr,
+		tlb_ps,
+		TLB_G_GLOBAL,
+		TLB_PA_NA_RW,
+		cp,
+		0,
+		TLB_ES_A_MODIFIED);
+
+	local_irq_save(irqflags);
+
+	if (IS_ENABLED(CONFIG_KVX_DEBUG_TLB_WRITE) &&
+	    kvx_mmu_ltlb_overlaps(tlbe))
+		panic("VA %lx overlaps with an existing LTLB mapping", vaddr);
+
+	idx = find_next_zero_bit(&ltlb_entries_bmp, MMU_LTLB_WAYS,
+				 LTLB_ENTRY_FIXED_COUNT);
+	/* This should never happen */
+	BUG_ON(idx >= MMU_LTLB_WAYS);
+	__set_bit(idx, &ltlb_entries_bmp);
+	ltlb_entries[idx] = tlbe;
+	kvx_mmu_add_entry(MMC_SB_LTLB, idx, tlbe);
+
+	if (kvx_mmc_error(kvx_sfr_get(MMC)))
+		panic("Failed to write entry to the LTLB");
+
+	local_irq_restore(irqflags);
+}
+
+void kvx_mmu_ltlb_remove_entry(unsigned long vaddr)
+{
+	int ret, bit = LTLB_ENTRY_FIXED_COUNT;
+	struct kvx_tlb_format tlbe;
+
+	for_each_set_bit_from(bit, &ltlb_entries_bmp, MMU_LTLB_WAYS) {
+		tlbe = ltlb_entries[bit];
+		if (tlb_entry_match_addr(tlbe, vaddr)) {
+			__clear_bit(bit, &ltlb_entries_bmp);
+			break;
+		}
+	}
+
+	if (bit == MMU_LTLB_WAYS)
+		panic("Trying to remove non-existent LTLB entry for addr %lx\n",
+		      vaddr);
+
+	ret = clear_ltlb_entry(vaddr);
+	if (ret)
+		panic("Failed to remove LTLB entry for addr %lx\n", vaddr);
+}
+
+/**
+ * kvx_mmu_jtlb_add_entry - Add an entry into JTLB
+ *
+ * JTLB is used both for kernel and user entries.
+ *
+ * @address: Virtual address for the entry (must be aligned according to tlb_ps)
+ * @ptep: pte entry pointer
+ * @asn: ASN (if pte entry is not global)
+ */
+void kvx_mmu_jtlb_add_entry(unsigned long address, pte_t *ptep,
+			    unsigned int asn)
+{
+	unsigned int shifted_addr, set, way;
+	unsigned long flags, pte_val;
+	struct kvx_tlb_format tlbe;
+	unsigned int pa, cp, ps;
+	phys_addr_t pfn;
+
+	pte_val = pte_val(*ptep);
+
+	pfn = (phys_addr_t)pte_pfn(*ptep);
+
+	asn &= MM_CTXT_ASN_MASK;
+
+	/* Set page as accessed */
+	pte_val(*ptep) |= _PAGE_ACCESSED;
+
+	BUILD_BUG_ON(KVX_PAGE_SZ_SHIFT != KVX_SFR_TEL_PS_SHIFT);
+
+	ps = (pte_val & KVX_PAGE_SZ_MASK) >> KVX_PAGE_SZ_SHIFT;
+	pa = get_page_access_perms(KVX_ACCESS_PERMS_INDEX(pte_val));
+	cp = pgprot_cache_policy(pte_val);
+
+	tlbe = tlb_mk_entry(
+		(void *)pfn_to_phys(pfn),
+		(void *)address,
+		ps,
+		(pte_val & _PAGE_GLOBAL) ? TLB_G_GLOBAL : TLB_G_USE_ASN,
+		pa,
+		cp,
+		asn,
+		TLB_ES_A_MODIFIED);
+
+	shifted_addr = address >> get_page_size_shift(ps);
+	set = shifted_addr & MMU_JTLB_SET_MASK;
+
+	local_irq_save(flags);
+
+	if (IS_ENABLED(CONFIG_KVX_DEBUG_TLB_WRITE) &&
+	    kvx_mmu_ltlb_overlaps(tlbe))
+		panic("VA %lx overlaps with an existing LTLB mapping", address);
+
+	way = get_cpu_var(jtlb_current_set_way)[set]++;
+	put_cpu_var(jtlb_current_set_way);
+
+	way &= MMU_JTLB_WAY_MASK;
+
+	kvx_mmu_add_entry(MMC_SB_JTLB, way, tlbe);
+
+	if (IS_ENABLED(CONFIG_KVX_DEBUG_TLB_WRITE) &&
+	    kvx_mmc_error(kvx_sfr_get(MMC)))
+		panic("Failed to write entry to the JTLB (in update_mmu_cache)");
+
+	local_irq_restore(flags);
+}
+
+void __init kvx_mmu_early_setup(void)
+{
+	int bit;
+	struct kvx_tlb_format tlbe;
+
+	kvx_mmu_remove_ltlb_entry(LTLB_ENTRY_EARLY_SMEM);
+
+	if (raw_smp_processor_id() != 0) {
+		/* Apply existing ltlb entries starting from first one free */
+		bit = LTLB_ENTRY_FIXED_COUNT;
+		for_each_set_bit_from(bit, &ltlb_entries_bmp, MMU_LTLB_WAYS) {
+			tlbe = ltlb_entries[bit];
+			kvx_mmu_add_entry(MMC_SB_LTLB, bit, tlbe);
+		}
+	}
+}
diff --git a/arch/kvx/mm/mmu_stats.c b/arch/kvx/mm/mmu_stats.c
new file mode 100644
index 0000000000000..e70b7e2dcab1a
--- /dev/null
+++ b/arch/kvx/mm/mmu_stats.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+
+#include <asm/mmu_stats.h>
+
+static struct dentry *mmu_stats_debufs;
+
+static const char *mmu_refill_types_name[MMU_REFILL_TYPE_COUNT] = {
+	[MMU_REFILL_TYPE_USER] = "User",
+	[MMU_REFILL_TYPE_KERNEL] = "Kernel",
+	[MMU_REFILL_TYPE_KERNEL_DIRECT] = "Kernel Direct"
+};
+
+DEFINE_PER_CPU(struct mmu_stats, mmu_stats);
+
+static int mmu_stats_show(struct seq_file *m, void *v)
+{
+	int cpu, type;
+	unsigned long avg = 0, total_refill, efficiency, total_cycles;
+	struct mmu_stats *stats;
+	struct mmu_refill_stats *ref_stat;
+
+	total_cycles = get_cycles();
+	for_each_present_cpu(cpu) {
+		stats = &per_cpu(mmu_stats, cpu);
+		total_refill = 0;
+
+		seq_printf(m, " - CPU %d\n", cpu);
+		for (type = 0; type < MMU_REFILL_TYPE_COUNT; type++) {
+			ref_stat = &stats->refill[type];
+			total_refill += ref_stat->count;
+			if (ref_stat->count)
+				avg = ref_stat->total / ref_stat->count;
+			else
+				avg = 0;
+
+			seq_printf(m,
+				   "  - %s refill stats:\n"
+				   "   - count: %lu\n"
+				   "   - min: %lu\n"
+				   "   - avg: %lu\n"
+				   "   - max: %lu\n",
+				   mmu_refill_types_name[type],
+				   ref_stat->count,
+				   ref_stat->min,
+				   avg,
+				   ref_stat->max
+				   );
+		}
+
+		if (total_refill)
+			avg = stats->cycles_between_refill / total_refill;
+		else
+			avg = 0;
+
+		seq_printf(m, "  - Average cycles between refill: %lu\n", avg);
+		seq_printf(m, "  - tlb_flush_all calls: %lu\n",
+			   stats->tlb_flush_all);
+		efficiency = stats->cycles_between_refill * 100 /
+			     stats->last_refill;
+		seq_printf(m, "  - Efficiency: %lu%%\n", efficiency);
+	}
+
+	return 0;
+}
+
+static int mmu_stats_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, mmu_stats_show, NULL);
+}
+
+static const struct file_operations mmu_stats_fops = {
+	.open		= mmu_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init mmu_stats_debufs_init(void)
+{
+	mmu_stats_debufs = debugfs_create_dir("kvx_mmu_debug", NULL);
+
+	debugfs_create_file("mmu_stats", 0444, mmu_stats_debufs, NULL,
+			    &mmu_stats_fops);
+
+	return 0;
+}
+subsys_initcall(mmu_stats_debufs_init);
diff --git a/arch/kvx/mm/tlb.c b/arch/kvx/mm/tlb.c
new file mode 100644
index 0000000000000..a606dc89bba4e
--- /dev/null
+++ b/arch/kvx/mm/tlb.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/mmu_context.h>
+#include <linux/sched.h>
+
+#include <asm/tlbflush.h>
+#include <asm/tlb_defs.h>
+#include <asm/page_size.h>
+#include <asm/mmu_stats.h>
+#include <asm/pgtable.h>
+#include <asm/tlb.h>
+
+/*
+ * When in kernel, use dummy ASN 42 to be able to catch any problem easily if
+ * ASN is not restored properly.
+ */
+#define KERNEL_DUMMY_ASN	42
+
+/* Threshold of page count above which we will regenerate a new ASN */
+#define ASN_FLUSH_PAGE_THRESHOLD	(MMU_JTLB_ENTRIES)
+
+/* Threshold of page count above which we will flush the whole JTLB */
+#define FLUSH_ALL_PAGE_THRESHOLD	(MMU_JTLB_ENTRIES)
+
+DEFINE_PER_CPU(unsigned long, kvx_asn_cache) = MM_CTXT_FIRST_CYCLE;
+
+#ifdef CONFIG_KVX_DEBUG_TLB_ACCESS
+
+static DEFINE_PER_CPU_ALIGNED(struct kvx_tlb_access_t[KVX_TLB_ACCESS_SIZE],
+		       kvx_tlb_access_rb);
+/* Lower bits hold the index and upper ones hold the number of wrapped */
+static DEFINE_PER_CPU(unsigned int, kvx_tlb_access_idx);
+
+void kvx_update_tlb_access(int type)
+{
+	unsigned int *idx_ptr = &get_cpu_var(kvx_tlb_access_idx);
+	unsigned int idx;
+	struct kvx_tlb_access_t *tab = get_cpu_var(kvx_tlb_access_rb);
+
+	idx = KVX_TLB_ACCESS_GET_IDX(*idx_ptr);
+
+	kvx_mmu_get_tlb_entry(tab[idx].entry);
+	tab[idx].mmc_val = kvx_sfr_get(MMC);
+	tab[idx].type = type;
+
+	(*idx_ptr)++;
+	put_cpu_var(kvx_tlb_access_rb);
+	put_cpu_var(kvx_tlb_access_idx);
+};
+
+#endif
+
+/**
+ * clear_tlb_entry() - clear an entry in TLB if it exists
+ * @addr: the address used to set TEH.PN
+ * @global: is page global or not
+ * @asn: ASN used if page is not global
+ * @tlb_type: tlb type (MMC_SB_LTLB or MMC_SB_JTLB)
+ *
+ * Preemption must be disabled when calling this function. There is no need to
+ * invalidate micro TLB because it is invalidated when we write TLB.
+ *
+ * Return: 0 if TLB entry was found and deleted properly, -ENOENT if not found
+ * -EINVAL if found but in incorrect TLB.
+ *
+ */
+static int clear_tlb_entry(unsigned long addr,
+			   unsigned int global,
+			   unsigned int asn,
+			   unsigned int tlb_type)
+{
+	struct kvx_tlb_format entry;
+	unsigned long mmc_val;
+	int saved_asn, ret = 0;
+
+	/* Sanitize ASN */
+	asn &= MM_CTXT_ASN_MASK;
+
+	/* Before probing we need to save the current ASN */
+	mmc_val = kvx_sfr_get(MMC);
+	saved_asn = kvx_sfr_field_val(mmc_val, MMC, ASN);
+	kvx_sfr_set_field(MMC, ASN, asn);
+
+	/* Probe is based on PN and ASN. So ES can be anything */
+	entry = tlb_mk_entry(0, (void *)addr, 0, global, 0, 0, 0,
+			     TLB_ES_INVALID);
+	kvx_mmu_set_tlb_entry(entry);
+
+	kvx_mmu_probetlb();
+
+	mmc_val = kvx_sfr_get(MMC);
+
+	if (kvx_mmc_error(mmc_val)) {
+		if (kvx_mmc_parity(mmc_val)) {
+			/*
+			 * This should never happens unless you are bombared by
+			 * streams of charged particules. If it happens just
+			 * flush the JTLB and let's continue (but check your
+			 * environment you are probably not in a safe place).
+			 */
+			WARN(1, "%s: parity error during lookup (addr 0x%lx, asn %u). JTLB will be flushed\n",
+			     __func__, addr, asn);
+			kvx_sfr_set_field(MMC, PAR, 0);
+			local_flush_tlb_all();
+		}
+
+		/*
+		 * else there is no matching entry so just clean the error and
+		 * restore the ASN before returning.
+		 */
+		kvx_sfr_set_field(MMC, E, 0);
+		ret = -ENOENT;
+		goto restore_asn;
+	}
+
+	/* We surely don't want to flush another TLB type or we are fried */
+	if (kvx_mmc_sb(mmc_val) != tlb_type) {
+		ret = -EINVAL;
+		goto restore_asn;
+	}
+
+	/*
+	 * At this point the probe found an entry. TEL and TEH have correct
+	 * values so we just need to set the entry status to invalid to clear
+	 * the entry.
+	 */
+	kvx_sfr_set_field(TEL, ES, TLB_ES_INVALID);
+
+	kvx_mmu_writetlb();
+
+	/* Need to read MMC SFR again */
+	mmc_val = kvx_sfr_get(MMC);
+	if (kvx_mmc_error(mmc_val))
+		panic("%s: Failed to clear entry (addr 0x%lx, asn %u)",
+		      __func__, addr, asn);
+	else
+		pr_debug("%s: Entry (addr 0x%lx, asn %u) cleared\n",
+			__func__, addr, asn);
+
+restore_asn:
+	kvx_sfr_set_field(MMC, ASN, saved_asn);
+
+	return ret;
+}
+
+static void clear_jtlb_entry(unsigned long addr,
+			     unsigned int global,
+			     unsigned int asn)
+{
+	clear_tlb_entry(addr, global, asn, MMC_SB_JTLB);
+}
+
+/**
+ * clear_ltlb_entry() - Remove a LTLB entry
+ * @vaddr: Virtual address to be matched against LTLB entries
+ *
+ * Return: Same value as clear_tlb_entry
+ */
+int clear_ltlb_entry(unsigned long vaddr)
+{
+	return clear_tlb_entry(vaddr, TLB_G_GLOBAL, KERNEL_DUMMY_ASN,
+			       MMC_SB_LTLB);
+}
+
+/* If mm is current we just need to assign the current task a new ASN. By
+ * doing this all previous TLB entries with the former ASN will be invalidated.
+ * if mm is not the current one we invalidate the context and when this other
+ * mm will be swapped in then a new context will be generated.
+ */
+void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	int cpu = smp_processor_id();
+
+	destroy_context(mm);
+	if (current->active_mm == mm)
+		activate_context(mm, cpu);
+}
+
+void local_flush_tlb_page(struct vm_area_struct *vma,
+			  unsigned long addr)
+{
+	int cpu = smp_processor_id();
+	unsigned int current_asn;
+	struct mm_struct *mm;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	mm = vma->vm_mm;
+	current_asn = mm_asn(mm, cpu);
+
+	/* If mm has no context there is nothing to do */
+	if (current_asn != MM_CTXT_NO_ASN)
+		clear_jtlb_entry(addr, TLB_G_USE_ASN, current_asn);
+
+	local_irq_restore(flags);
+}
+
+void local_flush_tlb_all(void)
+{
+	struct kvx_tlb_format tlbe = KVX_EMPTY_TLB_ENTRY;
+	int set, way;
+	unsigned long flags;
+#ifdef CONFIG_KVX_MMU_STATS
+	struct mmu_stats *stats = &per_cpu(mmu_stats, smp_processor_id());
+
+	stats->tlb_flush_all++;
+#endif
+
+	local_irq_save(flags);
+
+	/* Select JTLB and prepare TEL (constant) */
+	kvx_sfr_set(TEL, (uint64_t) tlbe.tel_val);
+	kvx_sfr_set_field(MMC, SB, MMC_SB_JTLB);
+
+	for (set = 0; set < MMU_JTLB_SETS; set++) {
+		tlbe.teh.pn = set;
+		for (way = 0; way < MMU_JTLB_WAYS; way++) {
+			/* Set is selected automatically according to the
+			 * virtual address.
+			 * With 4K pages the set is the value of the 6 lower
+			 * significant bits of the page number.
+			 */
+			kvx_sfr_set(TEH, (uint64_t) tlbe.teh_val);
+			kvx_sfr_set_field(MMC, SW, way);
+			kvx_mmu_writetlb();
+
+			if (kvx_mmc_error(kvx_sfr_get(MMC)))
+				panic("Failed to initialize JTLB[s:%02d w:%d]",
+				      set, way);
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
+void local_flush_tlb_range(struct vm_area_struct *vma,
+			   unsigned long start,
+			   unsigned long end)
+{
+	const unsigned int cpu = smp_processor_id();
+	unsigned long flags;
+	unsigned int current_asn;
+	unsigned long pages = (end - start) >> PAGE_SHIFT;
+
+	if (pages > ASN_FLUSH_PAGE_THRESHOLD) {
+		local_flush_tlb_mm(vma->vm_mm);
+		return;
+	}
+
+	start &= PAGE_MASK;
+
+	local_irq_save(flags);
+
+	current_asn = mm_asn(vma->vm_mm, cpu);
+	if (current_asn != MM_CTXT_NO_ASN) {
+		while (start < end) {
+			clear_jtlb_entry(start, TLB_G_USE_ASN, current_asn);
+			start += PAGE_SIZE;
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
+/**
+ * local_flush_tlb_kernel_range() - flush kernel TLB entries
+ * @start: start kernel virtual address
+ * @end: end kernel virtual address
+ *
+ * Return: nothing
+ */
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	unsigned long flags;
+	unsigned long pages = (end - start) >> PAGE_SHIFT;
+
+	if (pages > FLUSH_ALL_PAGE_THRESHOLD) {
+		local_flush_tlb_all();
+		return;
+	}
+
+	start &= PAGE_MASK;
+
+	local_irq_save(flags);
+
+	while (start < end) {
+		clear_jtlb_entry(start, TLB_G_GLOBAL, KERNEL_DUMMY_ASN);
+		start += PAGE_SIZE;
+	}
+
+	local_irq_restore(flags);
+}
+
+void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+		pmd_t *pmd)
+{
+	pte_t pte = __pte(pmd_val(*pmd));
+
+	/* THP PMD accessors are implemented in terms of PTE */
+	update_mmu_cache(vma, addr, &pte);
+}
+
+void update_mmu_cache(struct vm_area_struct *vma,
+	unsigned long address, pte_t *ptep)
+{
+	struct mm_struct *mm;
+	unsigned long asn;
+	int cpu = smp_processor_id();
+
+	if (unlikely(ptep == NULL))
+		panic("pte should not be NULL\n");
+
+	/* Flush any previous TLB entries */
+	flush_tlb_page(vma, address);
+
+	/* No need to add the TLB entry until the process that owns the memory
+	 * is running.
+	 */
+	mm = current->active_mm;
+	if (vma && (mm != vma->vm_mm))
+		return;
+
+	/*
+	 * Get the ASN:
+	 * ASN can have no context if address belongs to kernel space. In
+	 * fact as pages are global for kernel space the ASN is ignored
+	 * and can be equal to any value.
+	 */
+	asn = mm_asn(mm, cpu);
+
+#ifdef CONFIG_KVX_DEBUG_ASN
+	/*
+	 * For addresses that belong to user space, the value of the ASN
+	 * must match the mmc.asn and be non zero
+	 */
+	if (address < PAGE_OFFSET) {
+		unsigned int mmc_asn = kvx_mmc_asn(kvx_sfr_get(MMC));
+
+		if (asn == MM_CTXT_NO_ASN)
+			panic("%s: ASN [%lu] is not properly set for address 0x%lx on CPU %d\n",
+			      __func__, asn, address, cpu);
+
+		if ((asn & MM_CTXT_ASN_MASK) != mmc_asn)
+			panic("%s: ASN not synchronized with MMC: asn:%lu != mmc.asn:%u\n",
+			      __func__, (asn & MM_CTXT_ASN_MASK), mmc_asn);
+	}
+#endif
+
+	kvx_mmu_jtlb_add_entry(address, ptep, asn);
+}
+
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
+{
+	for (;;) {
+		update_mmu_cache(vma, addr, ptep);
+		if (--nr == 0)
+			break;
+		addr += PAGE_SIZE;
+		ptep++;
+	}
+}
+
+#ifdef CONFIG_SMP
+
+struct tlb_args {
+	struct vm_area_struct *ta_vma;
+	unsigned long ta_start;
+	unsigned long ta_end;
+};
+
+static inline void ipi_flush_tlb_page(void *arg)
+{
+	struct tlb_args *ta = arg;
+
+	local_flush_tlb_page(ta->ta_vma, ta->ta_start);
+}
+
+void
+smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct tlb_args ta = {
+		.ta_vma = vma,
+		.ta_start = addr
+	};
+
+	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page, &ta, 1);
+}
+EXPORT_SYMBOL(smp_flush_tlb_page);
+
+void
+smp_flush_tlb_mm(struct mm_struct *mm)
+{
+	on_each_cpu_mask(mm_cpumask(mm), (smp_call_func_t)local_flush_tlb_mm,
+			 mm, 1);
+}
+EXPORT_SYMBOL(smp_flush_tlb_mm);
+
+static inline void ipi_flush_tlb_range(void *arg)
+{
+	struct tlb_args *ta = arg;
+
+	local_flush_tlb_range(ta->ta_vma, ta->ta_start, ta->ta_end);
+}
+
+void
+smp_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end)
+{
+	struct tlb_args ta = {
+		.ta_vma = vma,
+		.ta_start = start,
+		.ta_end = end
+	};
+
+	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range, &ta, 1);
+}
+EXPORT_SYMBOL(smp_flush_tlb_range);
+
+static inline void ipi_flush_tlb_kernel_range(void *arg)
+{
+	struct tlb_args *ta = arg;
+
+	local_flush_tlb_kernel_range(ta->ta_start, ta->ta_end);
+}
+
+void
+smp_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	struct tlb_args ta = {
+		.ta_start = start,
+		.ta_end = end
+	};
+
+	on_each_cpu(ipi_flush_tlb_kernel_range, &ta, 1);
+}
+EXPORT_SYMBOL(smp_flush_tlb_kernel_range);
+
+#endif
-- 
2.45.2






