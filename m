Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA62456FC
	for <lists+linux-arch@lfdr.de>; Sun, 16 Aug 2020 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHPJKO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Aug 2020 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgHPJKG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 05:10:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632EFC061786;
        Sun, 16 Aug 2020 02:10:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so61060plp.4;
        Sun, 16 Aug 2020 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NFhkMBJW82v5R2qq0DXUlpjk/Z0vbs/aoPPNmBeGGI=;
        b=R5qOCbE0HWQPPquvSxVOEDrtcnseyPIwuRJP6nFU9h/k9Vq94VIBHVamKYNEQcx84D
         /4ZM2lVZZ0NRbTaCQ13VFr0BUY1/pGFoP0twisLTrZ2Nar2VbfnZYZ+qKY/9IqMPB0R+
         7ilWcEX8R1uLjEs8tEEaFPJhkSbA+PA1yQ4X/ySQGgTDXfIIBx53ZuFXWEReFPcUHyZL
         7Oec3jZe/0YDgjgQTE6WXGrqbhcjrGQg5DD9QiG2dcwyFGvtJhS/PXY6Dts6+Ft6/DRA
         uOwFfYBo8T2LmcYi0HvSS0TvAd31qwPJm9lHasKK+V38tFTSS6ofy34MbUB6h/JRSbVo
         D4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NFhkMBJW82v5R2qq0DXUlpjk/Z0vbs/aoPPNmBeGGI=;
        b=LPwjPdjotEEX82EBEYohXcTh0JAv/PzzbkFS8JXnP8oAuZIMEqUKKLXxdECLZ5ac0j
         Yy3ZSoAchQEpNk42eRQcldAP0adckblR6GKVW3WMKa6n615HkT87G0KM1UlH/yvIdKdn
         Ioh0i2zeTeD8FC4HCeCN1qT6XlMi78Ky9Sh330V/aeKBr4IkuO17zm3eg1+BFNwnZMKv
         osUawI589p40JssAw/Sx6+WOFh3XyXtMxUpISzSgrVeL91dgpQ9lsFzMOYj/elGsEnCf
         ebSu6NEQdZh/D0FH1bBaiFI871CpsleObDedJMA4wsxm16BIiSjjnJdlXjc6Drmhijp7
         VEnA==
X-Gm-Message-State: AOAM530pc+3iFQZZ4Ba7W6DdhVgK9KcFjeVzms3g8KmFV/vMIoHTgKwr
        KHswTCMmylGBdt8KsVT9fgk=
X-Google-Smtp-Source: ABdhPJzYPmi5So9wweRK6VLaklObcWMLYwgxfwLsGfXoZAFZVfS3BesQaYpbzaDloikWs4g5q0sNhQ==
X-Received: by 2002:a17:90a:e381:: with SMTP id b1mr8260896pjz.218.1597569004509;
        Sun, 16 Aug 2020 02:10:04 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o19sm12768369pjs.8.2020.08.16.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:10:04 -0700 (PDT)
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
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v4 8/8] mm/vmalloc: Hugepage vmalloc mappings
Date:   Sun, 16 Aug 2020 19:09:04 +1000
Message-Id: <20200816090904.83947-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200816090904.83947-1-npiggin@gmail.com>
References: <20200816090904.83947-1-npiggin@gmail.com>
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
 mm/vmalloc.c                                  | 177 +++++++++++++-----
 3 files changed, 137 insertions(+), 43 deletions(-)

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
index 4e5cb7c7f780..c3595d87261c 100644
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
@@ -2471,11 +2526,11 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	if (deallocate_pages) {
 		int i;
 
-		for (i = 0; i < area->nr_pages; i++) {
+		for (i = 0; i < area->nr_pages; i += 1 << area->page_order) {
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			__free_pages(page, 0);
+			__free_pages(page, area->page_order);
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2614,9 +2669,12 @@ void *vmap(struct page **pages, unsigned int count,
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
@@ -2624,7 +2682,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 					0 :
 					__GFP_HIGHMEM;
 
-	nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
 	/* Please note that the recursion is strictly bounded. */
@@ -2643,29 +2701,29 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
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
@@ -2701,22 +2759,45 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
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
+		if (size_per_node >= PMD_SIZE) {
+			shift = PMD_SHIFT;
+			align = max(real_align, 1UL << shift);
+			size = ALIGN(real_size, 1UL << shift);
+		}
+	}
+
+again:
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
@@ -2730,8 +2811,18 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return addr;
 
 fail:
-	warn_alloc(gfp_mask, NULL,
+	if (shift > PAGE_SHIFT) {
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

