Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201B52CFA27
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 08:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbgLEG7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLEG7Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:59:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD24CC061A52;
        Fri,  4 Dec 2020 22:58:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so5347205pfg.8;
        Fri, 04 Dec 2020 22:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRZepDZOFk10bQegSr670rdh7UW+D3+yhfDJQ0KUAZI=;
        b=o+Zc9b/1KrMxlVfGkFkl+BbssxM7bQc350ndlo/QIX05kStVvt5mo+8yObCo/dHBvQ
         Jv0EgCQd08L+XQUazZ83zn9VYQHgz1wz1o8cPfikxWN1dyHtqGoM7Z+LU1TAbtCV6qVy
         1bE8x+InISioqdO8fu85kwFrFpItaQjhT0rF435p3kq/iB9/y0CU6VrXy8DSUY4Euir6
         jTSkMpQHalnod8tOwjgiKtcmd1eMgg/LdeUNJAbKckDivjVmy2Vx2kZRzvCvfl5xpnCu
         o8OWH0y2zk1WQ7zlN/Hy5kNTuW0kFq7M7pTQ5WYxAoQlHSEMa2f0aWISX3pE9riF0Gj8
         oSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRZepDZOFk10bQegSr670rdh7UW+D3+yhfDJQ0KUAZI=;
        b=YZ2O7XFLpwGxK9bq98yJiATNB+i8+LEhg4c/KHAFEt9WsemRZNaPGrSPbKr7ixRKRo
         F7xSRzqD4QZw5uV4PTSEz3MMB/V++FSH5bEFzPU+8vckv91OHAQxBjDDdBfAt8/hjMPw
         l06eX7z8jugn+lTzilL5kwwdzBcvtLpBiccEq2AF41E0+2MSt1OLToigiD//sv08o7b4
         lLKsPOwes0OKvArHkdQ3UrVk85W0X04aAHefyDpKFC4GyoLuQ7ZQl7YCy0mM8z7J57sN
         kZP1cs6yZN+g4WLCxy3/44riUHsZmtI4vL9Kvzl7Bx5xsNJlpx+aBUNQvVAKntkU5xcM
         xY+w==
X-Gm-Message-State: AOAM533/aFGAUgdMxTR4G1nM4xVnyr8lKyVUb0J9jip4DTY8ApAxsWoz
        FsiNiG9mEpeH1PAuL3Q8XZ8=
X-Google-Smtp-Source: ABdhPJxrb67x3Gnv7/5cTUmtLQdbJLP6bJ+o2x3Seddk+PHjS9PwEyBkBrfa1SKhM5AYAvpqa12zMw==
X-Received: by 2002:a63:4c5d:: with SMTP id m29mr1006255pgl.368.1607151524320;
        Fri, 04 Dec 2020 22:58:44 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:58:43 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 11/12] mm/vmalloc: Hugepage vmalloc mappings
Date:   Sat,  5 Dec 2020 16:57:24 +1000
Message-Id: <20201205065725.1286370-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Support huge page vmalloc mappings. Config option HAVE_ARCH_HUGE_VMALLOC
enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
supports PMD sized vmap mappings.

vmalloc will attempt to allocate PMD-sized pages if allocating PMD size
or larger, and fall back to small pages if that was unsuccessful.

Architectures must ensure that any arch specific vmalloc allocations
that require PAGE_SIZE mappings (e.g., module allocations vs strict
module rwx) use the VM_NOHUGE flag to inhibit larger mappings.

When hugepage vmalloc mappings are enabled in the next patch, this
reduces TLB misses by nearly 30x on a `git diff` workload on a 2-node
POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.

This can result in more internal fragmentation and memory overhead for a
given allocation, an option nohugevmalloc is added to disable at boot.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig            |  10 +++
 include/linux/vmalloc.h |  18 ++++
 mm/page_alloc.c         |   5 +-
 mm/vmalloc.c            | 191 ++++++++++++++++++++++++++++++----------
 4 files changed, 178 insertions(+), 46 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..d8f056fc27b4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -662,6 +662,16 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 config HAVE_ARCH_HUGE_VMAP
 	bool
 
+config HAVE_ARCH_HUGE_VMALLOC
+	depends on HAVE_ARCH_HUGE_VMAP
+	bool
+	help
+	  Archs that select this would be capable of PMD-sized vmaps (i.e.,
+	  arch_vmap_pmd_supported() returns true), and they must make no
+	  assumptions that vmalloc memory is mapped with PAGE_SIZE ptes. The
+	  VM_NOHUGE flag can be used to prohibit arch-specific allocations from
+	  using hugepages to help with this (e.g., modules may require it).
+
 config ARCH_WANT_HUGE_PMD_SHARE
 	bool
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index a5ae791dc1e0..db018b531745 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -25,6 +25,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
 #define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
+#define VM_NOHUGE		0x00000200	/* force PAGE_SIZE pte mapping */
 
 /*
  * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
@@ -59,6 +60,7 @@ struct vm_struct {
 	unsigned long		size;
 	unsigned long		flags;
 	struct page		**pages;
+	unsigned int		page_order;
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
 	const void		*caller;
@@ -196,6 +198,18 @@ static inline void set_vm_flush_reset_perms(void *addr)
 	if (vm)
 		vm->flags |= VM_FLUSH_RESET_PERMS;
 }
+
+static inline bool is_vm_area_hugepages(const void *addr)
+{
+	/*
+	 * This may not 100% tell if the area is mapped with > PAGE_SIZE
+	 * page table entries, if for some reason the architecture indicates
+	 * larger sizes are available but decides not to use them, nothing
+	 * prevents that. This only indicates the size of the physical page
+	 * allocated in the vmalloc layer.
+	 */
+	return (find_vm_area(addr)->page_order > 0);
+}
 #else
 static inline int
 map_kernel_range_noflush(unsigned long start, unsigned long size,
@@ -212,6 +226,10 @@ unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
+static inline bool is_vm_area_hugepages(const void *addr)
+{
+	return false;
+}
 #endif
 
 /* for /dev/kmem */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..d907da0ad349 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -70,6 +70,7 @@
 #include <linux/psi.h>
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
+#include <linux/vmalloc.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -8171,6 +8172,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 	void *table = NULL;
 	gfp_t gfp_flags;
 	bool virt;
+	bool huge;
 
 	/* allow the kernel cmdline to have a say */
 	if (!numentries) {
@@ -8238,6 +8240,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		} else if (get_order(size) >= MAX_ORDER || hashdist) {
 			table = __vmalloc(size, gfp_flags);
 			virt = true;
+			huge = is_vm_area_hugepages(table);
 		} else {
 			/*
 			 * If bucketsize is not a power-of-two, we may free
@@ -8254,7 +8257,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
 		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
-		virt ? "vmalloc" : "linear");
+		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
 
 	if (_hash_shift)
 		*_hash_shift = log2qty;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ee9c3bee67f5..3800380b474f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -42,6 +42,19 @@
 #include "internal.h"
 #include "pgalloc-track.h"
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
+static bool __ro_after_init vmap_allow_huge = true;
+
+static int __init set_nohugevmalloc(char *str)
+{
+	vmap_allow_huge = false;
+	return 0;
+}
+early_param("nohugevmalloc", set_nohugevmalloc);
+#else /* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
+static const bool vmap_allow_huge = false;
+#endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)x;
@@ -477,31 +490,12 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 	return 0;
 }
 
-/**
- * map_kernel_range_noflush - map kernel VM area with the specified pages
- * @addr: start of the VM area to map
- * @size: size of the VM area to map
- * @prot: page protection flags to use
- * @pages: pages to map
- *
- * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify should
- * have been allocated using get_vm_area() and its friends.
- *
- * NOTE:
- * This function does NOT do any cache flushing.  The caller is responsible for
- * calling flush_cache_vmap() on to-be-mapped areas before calling this
- * function.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int map_kernel_range_noflush(unsigned long addr, unsigned long size,
-			     pgprot_t prot, struct page **pages)
+static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages)
 {
 	unsigned long start = addr;
-	unsigned long end = addr + size;
-	unsigned long next;
 	pgd_t *pgd;
+	unsigned long next;
 	int err = 0;
 	int nr = 0;
 	pgtbl_mod_mask mask = 0;
@@ -523,6 +517,65 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 	return 0;
 }
 
+static int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
+{
+	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
+
+	WARN_ON(page_shift < PAGE_SHIFT);
+
+	if (page_shift == PAGE_SHIFT)
+		return vmap_small_pages_range_noflush(addr, end, prot, pages);
+
+	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
+		int err;
+
+		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
+					__pa(page_address(pages[i])), prot,
+					page_shift);
+		if (err)
+			return err;
+
+		addr += 1UL << page_shift;
+	}
+
+	return 0;
+}
+
+static int vmap_pages_range(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
+{
+	int err;
+
+	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	flush_cache_vmap(addr, end);
+	return err;
+}
+
+/**
+ * map_kernel_range_noflush - map kernel VM area with the specified pages
+ * @addr: start of the VM area to map
+ * @size: size of the VM area to map
+ * @prot: page protection flags to use
+ * @pages: pages to map
+ *
+ * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify should
+ * have been allocated using get_vm_area() and its friends.
+ *
+ * NOTE:
+ * This function does NOT do any cache flushing.  The caller is responsible for
+ * calling flush_cache_vmap() on to-be-mapped areas before calling this
+ * function.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int map_kernel_range_noflush(unsigned long addr, unsigned long size,
+			     pgprot_t prot, struct page **pages)
+{
+	return vmap_pages_range_noflush(addr, addr + size, prot, pages, PAGE_SHIFT);
+}
+
 int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
 		struct page **pages)
 {
@@ -2400,6 +2453,7 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 {
 	int i;
 
+	/* HUGE_VMALLOC passes small pages to set_direct_map */
 	for (i = 0; i < area->nr_pages; i++)
 		if (page_address(area->pages[i]))
 			set_direct_map(area->pages[i]);
@@ -2433,11 +2487,12 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * map. Find the start and end range of the direct mappings to make sure
 	 * the vm_unmap_aliases() flush includes the direct map.
 	 */
-	for (i = 0; i < area->nr_pages; i++) {
+	for (i = 0; i < area->nr_pages; i += 1U << area->page_order) {
 		unsigned long addr = (unsigned long)page_address(area->pages[i]);
 		if (addr) {
+			unsigned long page_size = PAGE_SIZE << area->page_order;
 			start = min(addr, start);
-			end = max(addr + PAGE_SIZE, end);
+			end = max(addr + page_size, end);
 			flush_dmap = 1;
 		}
 	}
@@ -2480,11 +2535,11 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	if (deallocate_pages) {
 		int i;
 
-		for (i = 0; i < area->nr_pages; i++) {
+		for (i = 0; i < area->nr_pages; i += 1U << area->page_order) {
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			__free_pages(page, 0);
+			__free_pages(page, area->page_order);
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2674,12 +2729,17 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				 pgprot_t prot, int node)
+				 pgprot_t prot, unsigned int page_shift,
+				 int node)
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
-	unsigned int nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
-	unsigned int array_size = nr_pages * sizeof(struct page *), i;
+	unsigned int page_order = page_shift - PAGE_SHIFT;
+	unsigned long addr = (unsigned long)area->addr;
+	unsigned long size = get_vm_area_size(area);
+	unsigned int nr_small_pages = size >> PAGE_SHIFT;
+	unsigned int array_size = nr_small_pages * sizeof(struct page *);
 	struct page **pages;
+	unsigned int i;
 
 	gfp_mask |= __GFP_NOWARN;
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
@@ -2700,30 +2760,35 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	area->pages = pages;
-	area->nr_pages = nr_pages;
+	area->nr_pages = nr_small_pages;
+	area->page_order = page_order;
 
-	for (i = 0; i < area->nr_pages; i++) {
+	/*
+	 * Careful, we allocate and map page_order pages, but tracking is done
+	 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
+	 * the physical/mapped size.
+	 */
+	for (i = 0; i < area->nr_pages; i += 1U << page_order) {
 		struct page *page;
+		int p;
 
-		if (node == NUMA_NO_NODE)
-			page = alloc_page(gfp_mask);
-		else
-			page = alloc_pages_node(node, gfp_mask, 0);
-
+		page = alloc_pages_node(node, gfp_mask, page_order);
 		if (unlikely(!page)) {
 			/* Successfully allocated i pages, free them in __vfree() */
 			area->nr_pages = i;
 			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 			goto fail;
 		}
-		area->pages[i] = page;
+
+		for (p = 0; p < (1U << page_order); p++)
+			area->pages[i + p] = page + p;
+
 		if (gfpflags_allow_blocking(gfp_mask))
 			cond_resched();
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
-	if (map_kernel_range((unsigned long)area->addr, get_vm_area_size(area),
-			prot, pages) < 0)
+	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0)
 		goto fail;
 
 	return area->addr;
@@ -2731,7 +2796,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 fail:
 	warn_alloc(gfp_mask, NULL,
 			  "vmalloc: allocation failure, allocated %ld of %ld bytes",
-			  (area->nr_pages*PAGE_SIZE), area->size);
+			  (area->nr_pages*PAGE_SIZE), size);
 	__vfree(area->addr);
 	return NULL;
 }
@@ -2762,19 +2827,44 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	struct vm_struct *area;
 	void *addr;
 	unsigned long real_size = size;
+	unsigned long real_align = align;
+	unsigned int shift = PAGE_SHIFT;
 
-	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
 		goto fail;
 
-	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
+	if (vmap_allow_huge && !(vm_flags & VM_NOHUGE) &&
+			arch_vmap_pmd_supported(prot) &&
+			(pgprot_val(prot) == pgprot_val(PAGE_KERNEL))) {
+		unsigned long size_per_node;
+
+		/*
+		 * Try huge pages. Only try for PAGE_KERNEL allocations,
+		 * others like modules don't yet expect huge pages in
+		 * their allocations due to apply_to_page_range not
+		 * supporting them.
+		 */
+
+		size_per_node = size;
+		if (node == NUMA_NO_NODE)
+			size_per_node /= num_online_nodes();
+		if (size_per_node >= PMD_SIZE) {
+			shift = PMD_SHIFT;
+			align = max(real_align, 1UL << shift);
+			size = ALIGN(real_size, 1UL << shift);
+		}
+	}
+
+again:
+	size = PAGE_ALIGN(size);
+	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
 				vm_flags, start, end, node, gfp_mask, caller);
 	if (!area)
 		goto fail;
 
-	addr = __vmalloc_area_node(area, gfp_mask, prot, node);
+	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
 	if (!addr)
-		return NULL;
+		goto fail;
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -2788,8 +2878,19 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return addr;
 
 fail:
-	warn_alloc(gfp_mask, NULL,
+	if (shift > PAGE_SHIFT) {
+		free_vm_area(area);
+		shift = PAGE_SHIFT;
+		align = real_align;
+		size = real_size;
+		goto again;
+	}
+
+	if (!area) {
+		/* Warn for area allocation, page allocations already warn */
+		warn_alloc(gfp_mask, NULL,
 			  "vmalloc: allocation failure: %lu bytes", real_size);
+	}
 	return NULL;
 }
 
-- 
2.23.0

