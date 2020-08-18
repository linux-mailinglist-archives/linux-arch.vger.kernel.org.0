Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5491724892F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgHRPSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgHRPSk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 11:18:40 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9854F207DA;
        Tue, 18 Aug 2020 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763918;
        bh=Oo0BK/Dxb760cgwYm8yezajjoylgcCoXRmjwfHYQ/yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBBX7IZOL7O5OjP+FGSn/b9diGahataJkBRDR4kRNNGJiRVcj1EH3UYbRih/1skPj
         6hLZ04b+OkpdATLfj4Fc4PJvfnjhszctok7M0slj0gGH94ox2y9JhEMpYDrGi/jVPs
         sfJ3N1o3CdTN0K5G022ggrof09u30Lc2kWBlWwcI=
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
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v3 10/17] memblock: reduce number of parameters in for_each_mem_range()
Date:   Tue, 18 Aug 2020 18:16:27 +0300
Message-Id: <20200818151634.14343-11-rppt@kernel.org>
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

Currently for_each_mem_range() and for_each_mem_range_rev() iterators are
the most generic way to traverse memblock regions. As such, they have 8
parameters and they are hardly convenient to users. Most users choose to
utilize one of their wrappers and the only user that actually needs most of
the parameters is memblock itself.

To avoid yet another naming for memblock iterators, rename the existing
for_each_mem_range[_rev]() to __for_each_mem_range[_rev]() and add a new
for_each_mem_range[_rev]() wrappers with only index, start and end
parameters.

The new wrapper nicely fits into init_unavailable_mem() and will be used in
upcoming changes to simplify memblock traversals.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>  # MIPS
---
 .clang-format                          |  2 ++
 arch/arm64/kernel/machine_kexec_file.c |  6 ++--
 arch/powerpc/kexec/file_load_64.c      |  6 ++--
 include/linux/memblock.h               | 41 +++++++++++++++++++-------
 mm/page_alloc.c                        |  3 +-
 5 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/.clang-format b/.clang-format
index a0a96088c74f..3e42a8e4df73 100644
--- a/.clang-format
+++ b/.clang-format
@@ -205,7 +205,9 @@ ForEachMacros:
   - 'for_each_memblock_type'
   - 'for_each_memcg_cache_index'
   - 'for_each_mem_pfn_range'
+  - '__for_each_mem_range'
   - 'for_each_mem_range'
+  - '__for_each_mem_range_rev'
   - 'for_each_mem_range_rev'
   - 'for_each_migratetype_order'
   - 'for_each_msi_entry'
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 361a1143e09e..5b0e67b93cdc 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -215,8 +215,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	phys_addr_t start, end;
 
 	nr_ranges = 1; /* for exclusion of crashkernel region */
-	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-					MEMBLOCK_NONE, &start, &end, NULL)
+	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
 
 	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
@@ -225,8 +224,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	cmem->max_nr_ranges = nr_ranges;
 	cmem->nr_ranges = 0;
-	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-					MEMBLOCK_NONE, &start, &end, NULL) {
+	for_each_mem_range(i, &start, &end) {
 		cmem->ranges[cmem->nr_ranges].start = start;
 		cmem->ranges[cmem->nr_ranges].end = end - 1;
 		cmem->nr_ranges++;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 53bb71e3a2e1..2c9d908eab96 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -250,8 +250,7 @@ static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
 	phys_addr_t start, end;
 	u64 i;
 
-	for_each_mem_range_rev(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			       MEMBLOCK_NONE, &start, &end, NULL) {
+	for_each_mem_range_rev(i, &start, &end) {
 		/*
 		 * memblock uses [start, end) convention while it is
 		 * [start, end] here. Fix the off-by-one to have the
@@ -350,8 +349,7 @@ static int __locate_mem_hole_bottom_up(struct kexec_buf *kbuf,
 	phys_addr_t start, end;
 	u64 i;
 
-	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			   MEMBLOCK_NONE, &start, &end, NULL) {
+	for_each_mem_range(i, &start, &end) {
 		/*
 		 * memblock uses [start, end) convention while it is
 		 * [start, end] here. Fix the off-by-one to have the
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 47a76e237fca..27c3b84d1615 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -162,7 +162,7 @@ static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
 #endif /* CONFIG_HAVE_MEMBLOCK_PHYS_MAP */
 
 /**
- * for_each_mem_range - iterate through memblock areas from type_a and not
+ * __for_each_mem_range - iterate through memblock areas from type_a and not
  * included in type_b. Or just type_a if type_b is NULL.
  * @i: u64 used as loop variable
  * @type_a: ptr to memblock_type to iterate
@@ -173,7 +173,7 @@ static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
  * @p_nid: ptr to int for nid of the range, can be %NULL
  */
-#define for_each_mem_range(i, type_a, type_b, nid, flags,		\
+#define __for_each_mem_range(i, type_a, type_b, nid, flags,		\
 			   p_start, p_end, p_nid)			\
 	for (i = 0, __next_mem_range(&i, nid, flags, type_a, type_b,	\
 				     p_start, p_end, p_nid);		\
@@ -182,7 +182,7 @@ static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
 			      p_start, p_end, p_nid))
 
 /**
- * for_each_mem_range_rev - reverse iterate through memblock areas from
+ * __for_each_mem_range_rev - reverse iterate through memblock areas from
  * type_a and not included in type_b. Or just type_a if type_b is NULL.
  * @i: u64 used as loop variable
  * @type_a: ptr to memblock_type to iterate
@@ -193,15 +193,36 @@ static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
  * @p_nid: ptr to int for nid of the range, can be %NULL
  */
-#define for_each_mem_range_rev(i, type_a, type_b, nid, flags,		\
-			       p_start, p_end, p_nid)			\
+#define __for_each_mem_range_rev(i, type_a, type_b, nid, flags,		\
+				 p_start, p_end, p_nid)			\
 	for (i = (u64)ULLONG_MAX,					\
-		     __next_mem_range_rev(&i, nid, flags, type_a, type_b,\
+		     __next_mem_range_rev(&i, nid, flags, type_a, type_b, \
 					  p_start, p_end, p_nid);	\
 	     i != (u64)ULLONG_MAX;					\
 	     __next_mem_range_rev(&i, nid, flags, type_a, type_b,	\
 				  p_start, p_end, p_nid))
 
+/**
+ * for_each_mem_range - iterate through memory areas.
+ * @i: u64 used as loop variable
+ * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ */
+#define for_each_mem_range(i, p_start, p_end) \
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,	\
+			     MEMBLOCK_NONE, p_start, p_end, NULL)
+
+/**
+ * for_each_mem_range_rev - reverse iterate through memblock areas from
+ * type_a and not included in type_b. Or just type_a if type_b is NULL.
+ * @i: u64 used as loop variable
+ * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ */
+#define for_each_mem_range_rev(i, p_start, p_end)			\
+	__for_each_mem_range_rev(i, &memblock.memory, NULL, NUMA_NO_NODE, \
+				 MEMBLOCK_NONE, p_start, p_end, NULL)
+
 /**
  * for_each_reserved_mem_region - iterate over all reserved memblock areas
  * @i: u64 used as loop variable
@@ -307,8 +328,8 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
  * soon as memblock is initialized.
  */
 #define for_each_free_mem_range(i, nid, flags, p_start, p_end, p_nid)	\
-	for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
-			   nid, flags, p_start, p_end, p_nid)
+	__for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
+			     nid, flags, p_start, p_end, p_nid)
 
 /**
  * for_each_free_mem_range_reverse - rev-iterate through free memblock areas
@@ -324,8 +345,8 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
  */
 #define for_each_free_mem_range_reverse(i, nid, flags, p_start, p_end,	\
 					p_nid)				\
-	for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,	\
-			       nid, flags, p_start, p_end, p_nid)
+	__for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved, \
+				 nid, flags, p_start, p_end, p_nid)
 
 int memblock_set_node(phys_addr_t base, phys_addr_t size,
 		      struct memblock_type *type, int nid);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e2bab486fea..12da56b1cf39 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6979,8 +6979,7 @@ static void __init init_unavailable_mem(void)
 	 * Loop through unavailable ranges not covered by memblock.memory.
 	 */
 	pgcnt = 0;
-	for_each_mem_range(i, &memblock.memory, NULL,
-			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
+	for_each_mem_range(i, &start, &end) {
 		if (next < start)
 			pgcnt += init_unavailable_range(PFN_DOWN(next),
 							PFN_UP(start));
-- 
2.26.2

