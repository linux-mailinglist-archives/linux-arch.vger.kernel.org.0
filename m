Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE242235907
	for <lists+linux-arch@lfdr.de>; Sun,  2 Aug 2020 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHBQjM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Aug 2020 12:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHBQjM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 2 Aug 2020 12:39:12 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6F7207BB;
        Sun,  2 Aug 2020 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596386350;
        bh=gqBMOJufupVT6nwjCYDhdQzDn7YpaiO3JM6cP/9C3wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeAsAzWKRP59PigJoeA+XtS0FJGWFVUdDhjkFEKClGxmxsaW6+DxphUxN6CoYMYaT
         tl2WX65cznSnalnk9ZwonQBu35jxUPNSqyzIs2PyJpU9XishZghg1BraDKduHM2ouD
         WedM8Ivn0Ro/l/b30nFV0/UkeZIodRQvAC8k7/4U=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v2 16/17] memblock: implement for_each_reserved_mem_region() using __next_mem_region()
Date:   Sun,  2 Aug 2020 19:36:00 +0300
Message-Id: <20200802163601.8189-17-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200802163601.8189-1-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Iteration over memblock.reserved with for_each_reserved_mem_region() used
__next_reserved_mem_region() that implemented a subset of
__next_mem_region().

Use __for_each_mem_range() and, essentially, __next_mem_region() with
appropriate parameters to reduce code duplication.

While on it, rename for_each_reserved_mem_region() to
for_each_reserved_mem_range() for consistency.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 .clang-format                    |  2 +-
 arch/arm64/kernel/setup.c        |  2 +-
 drivers/irqchip/irq-gic-v3-its.c |  2 +-
 include/linux/memblock.h         | 12 +++------
 mm/memblock.c                    | 46 +++++++-------------------------
 5 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/.clang-format b/.clang-format
index 52ededab25ce..e28a849a1c58 100644
--- a/.clang-format
+++ b/.clang-format
@@ -266,7 +266,7 @@ ForEachMacros:
   - 'for_each_process_thread'
   - 'for_each_property_of_node'
   - 'for_each_registered_fb'
-  - 'for_each_reserved_mem_region'
+  - 'for_each_reserved_mem_range'
   - 'for_each_rtd_codec_dais'
   - 'for_each_rtd_codec_dais_rollback'
   - 'for_each_rtd_components'
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 93b3844cf442..f3aec7244aab 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -257,7 +257,7 @@ static int __init reserve_memblock_reserved_regions(void)
 		if (!memblock_is_region_reserved(mem->start, mem_size))
 			continue;
 
-		for_each_reserved_mem_region(j, &r_start, &r_end) {
+		for_each_reserved_mem_range(j, &r_start, &r_end) {
 			resource_size_t start, end;
 
 			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index beac4caefad9..9971fd8cf6b6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2192,7 +2192,7 @@ static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
 
 	addr_end = addr + size - 1;
 
-	for_each_reserved_mem_region(i, &start, &end) {
+	for_each_reserved_mem_range(i, &start, &end) {
 		if (addr >= start && addr_end <= end)
 			return true;
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ec2fd8f32a19..9e51b3fd4134 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -136,9 +136,6 @@ void __next_mem_range_rev(u64 *idx, int nid, enum memblock_flags flags,
 			  struct memblock_type *type_b, phys_addr_t *out_start,
 			  phys_addr_t *out_end, int *out_nid);
 
-void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
-				phys_addr_t *out_end);
-
 void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 
 /**
@@ -193,7 +190,7 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 			     MEMBLOCK_NONE, p_start, p_end, NULL)
 
 /**
- * for_each_reserved_mem_region - iterate over all reserved memblock areas
+ * for_each_reserved_mem_range - iterate over all reserved memblock areas
  * @i: u64 used as loop variable
  * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
@@ -201,10 +198,9 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
  * Walks over reserved areas of memblock. Available as soon as memblock
  * is initialized.
  */
-#define for_each_reserved_mem_region(i, p_start, p_end)			\
-	for (i = 0UL, __next_reserved_mem_region(&i, p_start, p_end);	\
-	     i != (u64)ULLONG_MAX;					\
-	     __next_reserved_mem_region(&i, p_start, p_end))
+#define for_each_reserved_mem_range(i, p_start, p_end)			\
+	__for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,	\
+			     MEMBLOCK_NONE, p_start, p_end, NULL)
 
 static inline bool memblock_is_hotpluggable(struct memblock_region *m)
 {
diff --git a/mm/memblock.c b/mm/memblock.c
index 48d614352b25..dadf579f7c53 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -946,42 +946,16 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
 }
 
-/**
- * __next_reserved_mem_region - next function for for_each_reserved_region()
- * @idx: pointer to u64 loop variable
- * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
- * @out_end: ptr to phys_addr_t for end address of the region, can be %NULL
- *
- * Iterate over all reserved memory regions.
- */
-void __init_memblock __next_reserved_mem_region(u64 *idx,
-					   phys_addr_t *out_start,
-					   phys_addr_t *out_end)
-{
-	struct memblock_type *type = &memblock.reserved;
-
-	if (*idx < type->cnt) {
-		struct memblock_region *r = &type->regions[*idx];
-		phys_addr_t base = r->base;
-		phys_addr_t size = r->size;
-
-		if (out_start)
-			*out_start = base;
-		if (out_end)
-			*out_end = base + size - 1;
-
-		*idx += 1;
-		return;
-	}
-
-	/* signal end of iteration */
-	*idx = ULLONG_MAX;
-}
-
-static bool should_skip_region(struct memblock_region *m, int nid, int flags)
+static bool __init_memblock should_skip_region(struct memblock_type *type,
+					       struct memblock_region *m,
+					       int nid, int flags)
 {
 	int m_nid = memblock_get_region_node(m);
 
+	/* we never skip regions when iterating memblock.reserved */
+	if (type == &memblock.reserved)
+		return false;
+
 	/* only memory regions are associated with nodes, check it */
 	if (nid != NUMA_NO_NODE && nid != m_nid)
 		return true;
@@ -1048,7 +1022,7 @@ void __init_memblock __next_mem_range(u64 *idx, int nid,
 		phys_addr_t m_end = m->base + m->size;
 		int	    m_nid = memblock_get_region_node(m);
 
-		if (should_skip_region(m, nid, flags))
+		if (should_skip_region(type_a, m, nid, flags))
 			continue;
 
 		if (!type_b) {
@@ -1152,7 +1126,7 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 		phys_addr_t m_end = m->base + m->size;
 		int m_nid = memblock_get_region_node(m);
 
-		if (should_skip_region(m, nid, flags))
+		if (should_skip_region(type_a, m, nid, flags))
 			continue;
 
 		if (!type_b) {
@@ -1977,7 +1951,7 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_region(i, &start, &end)
+	for_each_reserved_mem_range(i, &start, &end)
 		reserve_bootmem_region(start, end);
 
 	/*
-- 
2.26.2

