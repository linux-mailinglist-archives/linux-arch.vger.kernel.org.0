Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE531A2121
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgDHMAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:00:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgDHMAt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WTia+Kd8nLd79kGizEELYmSwhhdp0SP7Ry4KHt9ID+U=; b=GyHNoqndZkpQJn55E5OLkEOGoU
        irtZeGy5qWin01/AJaYhblfYS1g6ItN0UlMnbbOvKVQarA+eYO3v49gGTr4ZjqCCUTcOgcyMH8XCC
        FqcTSzdza8XnpOqaWH9tsRV7+ZlwC3YEun2+4/nwP1qTiqE50qQt2Dn5VWO05aPK5gqbC6vdZ9ZeP
        Lx9oX4FKwloVnBSXIHqBcoHe3ON/RgEcNoSUpXOTbaPELyDAA1s2qfraMBj1YRdAMtwTmX9ZyRci3
        2Q3I+EJGRKpU+mOjiWU55Iqw7+AMIxu+mCXNDStF8MOl5GdJbi7jEHL9hY3O+pAaQDMI9Ur5AEbk2
        T7uJxzuA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9NY-00051s-NB; Wed, 08 Apr 2020 12:00:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/28] mm: remove map_vm_range
Date:   Wed,  8 Apr 2020 13:59:13 +0200
Message-Id: <20200408115926.1467567-16-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Switch all callers to map_kernel_range, which symmetric to the unmap
side (as well as the _noflush versions).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/cachetlb.rst |  2 +-
 include/linux/vmalloc.h             | 10 ++++------
 mm/vmalloc.c                        | 21 +++++++--------------
 mm/zsmalloc.c                       |  4 +++-
 net/ceph/ceph_common.c              |  3 +--
 5 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 93cb65d52720..a1582cc79f0f 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -213,7 +213,7 @@ Here are the routines, one by one:
 	there will be no entries in the cache for the kernel address
 	space for virtual addresses in the range 'start' to 'end-1'.
 
-	The first of these two routines is invoked after map_vm_area()
+	The first of these two routines is invoked after map_kernel_range()
 	has installed the page table entries.  The second is invoked
 	before unmap_kernel_range() deletes the page table entries.
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 3070b4dbc2d9..15ffbd8e8e65 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -168,11 +168,11 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
 
-extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
-			struct page **pages);
 #ifdef CONFIG_MMU
 extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
+int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
+		struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
 extern void unmap_kernel_range(unsigned long addr, unsigned long size);
 static inline void set_vm_flush_reset_perms(void *addr)
@@ -189,14 +189,12 @@ map_kernel_range_noflush(unsigned long start, unsigned long size,
 {
 	return size >> PAGE_SHIFT;
 }
+#define map_kernel_range map_kernel_range_noflush
 static inline void
 unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
 }
-static inline void
-unmap_kernel_range(unsigned long addr, unsigned long size)
-{
-}
+#define unmap_kernel_range unmap_kernel_range_noflush
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca8dc5d42580..b0c7cdc8701a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -272,8 +272,8 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 	return 0;
 }
 
-static int map_kernel_range(unsigned long start, unsigned long size,
-			   pgprot_t prot, struct page **pages)
+int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
+		struct page **pages)
 {
 	int ret;
 
@@ -2027,16 +2027,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	flush_tlb_kernel_range(addr, end);
 }
 
-int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
-{
-	unsigned long addr = (unsigned long)area->addr;
-	int err;
-
-	err = map_kernel_range(addr, get_vm_area_size(area), prot, pages);
-
-	return err > 0 ? 0 : err;
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
@@ -2408,7 +2398,8 @@ void *vmap(struct page **pages, unsigned int count,
 	if (!area)
 		return NULL;
 
-	if (map_vm_area(area, prot, pages)) {
+	if (map_kernel_range((unsigned long)area->addr, size, prot,
+			pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
@@ -2471,8 +2462,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
-	if (map_vm_area(area, prot, pages))
+	if (map_kernel_range((unsigned long)area->addr, get_vm_area_size(area),
+			prot, pages) < 0)
 		goto fail;
+
 	return area->addr;
 
 fail:
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ac0524330b9b..f6dc0673e62c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1138,7 +1138,9 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 static inline void *__zs_map_object(struct mapping_area *area,
 				struct page *pages[2], int off, int size)
 {
-	BUG_ON(map_vm_area(area->vm, PAGE_KERNEL, pages));
+	unsigned long addr = (unsigned long)area->vm->addr;
+
+	BUG_ON(map_kernel_range(addr, PAGE_SIZE * 2, PAGE_KERNEL, pages) < 0);
 	area->vm_addr = area->vm->addr;
 	return area->vm_addr + off;
 }
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a0e97f6c1072..66f22e8aa529 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -190,8 +190,7 @@ EXPORT_SYMBOL(ceph_compare_options);
  * kvmalloc() doesn't fall back to the vmalloc allocator unless flags are
  * compatible with (a superset of) GFP_KERNEL.  This is because while the
  * actual pages are allocated with the specified flags, the page table pages
- * are always allocated with GFP_KERNEL.  map_vm_area() doesn't even take
- * flags because GFP_KERNEL is hard-coded in {p4d,pud,pmd,pte}_alloc().
+ * are always allocated with GFP_KERNEL.
  *
  * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
  */
-- 
2.25.1

