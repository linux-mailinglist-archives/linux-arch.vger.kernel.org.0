Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0DD2400E3
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHJC2c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Aug 2020 22:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHJC2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2020 22:28:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2EC061756;
        Sun,  9 Aug 2020 19:28:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so4047162pls.2;
        Sun, 09 Aug 2020 19:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0so4fQowQIABHlZeHOs4si+EurGVBhpstQxSdjCTKk=;
        b=tPXjNJyxl/wafOmjktA4v0Ff+6NiFDhm4uZJcRy4HkzLWih0dPUV2CRwh3DGpMwIHF
         aItzNDc9IbTLdzEljsN6mYtxCizmXQgXcjBf74sg5ANtkyq97tfSnq/Mp3zNE3px8GCM
         3OMirQTYfqlY0iL/dLFiUOZank9oTo3Cg5tkddIODGDb6Nnjw3juULR5rfKwd+vAv/ep
         G+69QNC/hMz2nPxMhGOqwj+FydQc9PrVOGvCVAxahSdjvzzoma50VHV2BuXkN1rJqV4v
         SALbUpMz6Dfgs7owjWTFbxm6f8wGV6BKVrpRMvnH3Oq4Ay84cmpHJr45w7ow2VTEsST6
         Ds4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0so4fQowQIABHlZeHOs4si+EurGVBhpstQxSdjCTKk=;
        b=Zq5x6wKmRGDaRl4xrsTIpdbtQShzrf/FDv075Ptdpu2chctmjTQ9FcnPgPQV0UnF2m
         4MnHtTHFcmhVyI+86u4QDjnTSF52o6yuly6FBJCFArvFZ4oYfnX/BENo++pdFS8MBrh/
         px/0YngIYww0ZGtnqCedHcqf89nlmx2C3eYUFk6GjxgjaJ9Ayok58S2hblVkdWW3QQDi
         2rDgPZxdACith9bPiqf2DbS6Gewrq+lffub6+p39rOyRDQNPL5we1NLUdarc6wGRkCkD
         7jfJ7JrMicefV94mvfwMtijaDlwFgM78Xr1kZ5up2dY07yXY28fYnAyngrFKMMiR/ydk
         zbkg==
X-Gm-Message-State: AOAM532GFvMzCnZAJYeZcCQ2j/RdWSCxazOO43RUl+qkAfUNH7R7UUov
        Oo7m6JtTU1BvkSVRVlD71o0=
X-Google-Smtp-Source: ABdhPJy2cbTkCgVj+7r3lbrOmme2kgKLyxtJ3KbxYuQ7Nh6zJNk1/S9jERNxlg1hhtGQ8/P+Younzg==
X-Received: by 2002:a17:90a:884:: with SMTP id v4mr22909813pjc.27.1597026511406;
        Sun, 09 Aug 2020 19:28:31 -0700 (PDT)
Received: from bobo.ibm.com (193-116-100-32.tpgi.com.au. [193.116.100.32])
        by smtp.gmail.com with ESMTPSA id l17sm21863475pff.126.2020.08.09.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 19:28:31 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3 8/8] mm/vmalloc: Hugepage vmalloc mappings
Date:   Mon, 10 Aug 2020 12:27:32 +1000
Message-Id: <20200810022732.1150009-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200810022732.1150009-1-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmaps,
vmalloc will attempt to allocate PMD-sized pages first, before falling
back to small pages.

Allocations which use something other than PAGE_KERNEL protections are
not permitted to use huge pages yet, not all callers expect this (e.g.,
module allocations vs strict module rwx).

This reduces TLB misses by nearly 30x on a `git diff` workload on a
2-node POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.

This can result in more internal fragmentation and memory overhead for a
given allocation, an option nohugevmap is added to disable at boot.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |   2 +
 include/linux/vmalloc.h                       |   1 +
 mm/vmalloc.c                                  | 174 +++++++++++++-----
 3 files changed, 135 insertions(+), 42 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 98ea67f27809..eaef176c597f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3190,6 +3190,8 @@
 
 	nohugeiomap	[KNL,x86,PPC] Disable kernel huge I/O mappings.
 
+	nohugevmap	[KNL,x86,PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index e3590e93bfff..8f25dbaca0a1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -58,6 +58,7 @@ struct vm_struct {
 	unsigned long		size;
 	unsigned long		flags;
 	struct page		**pages;
+	unsigned int		page_order;
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
 	const void		*caller;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4e5cb7c7f780..a7728c7086bc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -45,6 +45,19 @@
 #include "internal.h"
 #include "pgalloc-track.h"
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+static bool __ro_after_init vmap_allow_huge = true;
+
+static int __init set_nohugevmap(char *str)
+{
+	vmap_allow_huge = false;
+	return 0;
+}
+early_param("nohugevmap", set_nohugevmap);
+#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
+static const bool vmap_allow_huge = false;
+#endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)x;
@@ -468,31 +481,12 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long en
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
@@ -514,6 +508,65 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 	return 0;
 }
 
+static int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
+{
+	WARN_ON(page_shift < PAGE_SHIFT);
+
+	if (page_shift == PAGE_SHIFT) {
+		return vmap_small_pages_range_noflush(addr, end, prot, pages);
+	} else {
+		unsigned int i, nr = (end - addr) >> page_shift;
+
+		for (i = 0; i < nr; i++) {
+			int err;
+
+			err = vmap_range_noflush(addr, addr + (1UL << page_shift),
+						__pa(page_address(pages[i])), prot, page_shift);
+			if (err)
+				return err;
+
+			addr += 1UL << page_shift;
+		}
+
+		return 0;
+	}
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
@@ -2274,9 +2327,11 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (unlikely(!size))
 		return NULL;
 
-	if (flags & VM_IOREMAP)
-		align = 1ul << clamp_t(int, get_count_order_long(size),
-				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
+	if (flags & VM_IOREMAP) {
+		align = max(align,
+			    1ul << clamp_t(int, get_count_order_long(size),
+					   PAGE_SHIFT, IOREMAP_MAX_ORDER));
+	}
 
 	area = kzalloc_node(sizeof(*area), gfp_mask & GFP_RECLAIM_MASK, node);
 	if (unlikely(!area))
@@ -2475,7 +2530,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			__free_pages(page, 0);
+			__free_pages(page, area->page_order);
+			i += 1 << area->page_order;
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2614,9 +2670,12 @@ void *vmap(struct page **pages, unsigned int count,
 EXPORT_SYMBOL(vmap);
 
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				 pgprot_t prot, int node)
+				 pgprot_t prot, unsigned int page_shift, int node)
 {
 	struct page **pages;
+	unsigned long addr = (unsigned long)area->addr;
+	unsigned long size = get_vm_area_size(area);
+	unsigned int page_order = page_shift - PAGE_SHIFT;
 	unsigned int nr_pages, array_size, i;
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
 	const gfp_t alloc_mask = gfp_mask | __GFP_NOWARN;
@@ -2624,7 +2683,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 					0 :
 					__GFP_HIGHMEM;
 
-	nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
 	/* Please note that the recursion is strictly bounded. */
@@ -2643,29 +2702,29 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	area->pages = pages;
 	area->nr_pages = nr_pages;
+	area->page_order = page_order;
 
-	for (i = 0; i < area->nr_pages; i++) {
+	for (i = 0; i < area->nr_pages; i += 1 << page_order) {
 		struct page *page;
+		int p;
 
-		if (node == NUMA_NO_NODE)
-			page = alloc_page(alloc_mask|highmem_mask);
-		else
-			page = alloc_pages_node(node, alloc_mask|highmem_mask, 0);
-
+		page = alloc_pages_node(node, alloc_mask|highmem_mask, page_order);
 		if (unlikely(!page)) {
 			/* Successfully allocated i pages, free them in __vunmap() */
 			area->nr_pages = i;
 			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 			goto fail;
 		}
-		area->pages[i] = page;
+
+		for (p = 0; p < (1 << page_order); p++)
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
@@ -2701,22 +2760,45 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller)
 {
-	struct vm_struct *area;
+	struct vm_struct *area = NULL;
 	void *addr;
 	unsigned long real_size = size;
+	unsigned long real_align = align;
+	unsigned int shift = PAGE_SHIFT;
 
 	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
 		goto fail;
 
-	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
+	if (vmap_allow_huge && (pgprot_val(prot) == pgprot_val(PAGE_KERNEL))) {
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
+		if (size_per_node >= PMD_SIZE)
+			shift = PMD_SHIFT;
+	}
+
+again:
+	align = max(real_align, 1UL << shift);
+	size = ALIGN(real_size, align);
+
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
@@ -2730,8 +2812,16 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return addr;
 
 fail:
-	warn_alloc(gfp_mask, NULL,
+	if (shift > PAGE_SHIFT) {
+		shift = PAGE_SHIFT;
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

