Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF51A7C4E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502846AbgDNNPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502831AbgDNNPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:15:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216EFC061A0C;
        Tue, 14 Apr 2020 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZI4U6BB9zlUyzXcQXfM3VhQxGL0k8FwW66WlTWcFnjw=; b=DuJhJNoi84j4y+ELSEk4TJJjyZ
        8E0g/lTAW0lXP4it4eZ25t7S3NAemXF7vCY6cSs+mAdTzydbKgGd7mpBCmkLnEQJJafJ/e0JSFQWA
        2sfV6l/SpE7aHPfshqIjorcf5C/UM2ChZjnjIzLCtv6oMiyTEpupPp0FO1YAlTJ0/6fCTX6yygOiB
        wsbflnnRcwmSE2DirRcX363HrqCLCWAr2oLn/deFV/kxMA43WQrMaT3aQyHGkgf8hHvL2/FREsjwt
        hHOEtE3xtVAjP6xBHsf3esbTCRkLw4FlmZO8SHDdGGF/R9Aat+5w/2QTWxUoTypO/JCUluyZkGGnq
        2iLfPbLA==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLPN-0001bW-Iw; Tue, 14 Apr 2020 13:15:23 +0000
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 26/29] mm: remove vmalloc_user_node_flags
Date:   Tue, 14 Apr 2020 15:13:45 +0200
Message-Id: <20200414131348.444715-27-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Open code it in __bpf_map_area_alloc, which is the only caller.  Also
clean up __bpf_map_area_alloc to have a single vmalloc call with
slightly different flags instead of the current two different calls.

For this to compile for the nommu case add a __vmalloc_node_range stub
to nommu.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/vmalloc.h |  1 -
 kernel/bpf/syscall.c    | 24 ++++++++++++++----------
 mm/nommu.c              | 14 ++++++++------
 mm/vmalloc.c            | 20 --------------------
 4 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 108f49b47756..f90f2946aac2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -106,7 +106,6 @@ extern void *vzalloc(unsigned long size);
 extern void *vmalloc_user(unsigned long size);
 extern void *vmalloc_node(unsigned long size, int node);
 extern void *vzalloc_node(unsigned long size, int node);
-extern void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags);
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *vmalloc_32_user(unsigned long size);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 48d98ea8fad6..dd30b334c554 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -25,6 +25,7 @@
 #include <linux/nospec.h>
 #include <linux/audit.h>
 #include <uapi/linux/btf.h>
+#include <asm/pgtable.h>
 #include <linux/bpf_lsm.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
@@ -281,26 +282,29 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 	 * __GFP_RETRY_MAYFAIL to avoid such situations.
 	 */
 
-	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
+	const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO;
+	unsigned int flags = 0;
+	unsigned long align = 1;
 	void *area;
 
 	if (size >= SIZE_MAX)
 		return NULL;
 
 	/* kmalloc()'ed memory can't be mmap()'ed */
-	if (!mmapable && size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
-		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
+	if (mmapable) {
+		BUG_ON(!PAGE_ALIGNED(size));
+		align = SHMLBA;
+		flags = VM_USERMAP;
+	} else if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
+		area = kmalloc_node(size, gfp | GFP_USER | __GFP_NORETRY,
 				    numa_node);
 		if (area != NULL)
 			return area;
 	}
-	if (mmapable) {
-		BUG_ON(!PAGE_ALIGNED(size));
-		return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
-					       __GFP_RETRY_MAYFAIL | flags);
-	}
-	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_RETRY_MAYFAIL | flags,
-			      numa_node, __builtin_return_address(0));
+
+	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
+			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
+			flags, numa_node, __builtin_return_address(0));
 }
 
 void *bpf_map_area_alloc(u64 size, int numa_node)
diff --git a/mm/nommu.c b/mm/nommu.c
index 81a86cd85893..b42cd6003d7d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -150,6 +150,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
+void *__vmalloc_node_range(unsigned long size, unsigned long align,
+		unsigned long start, unsigned long end, gfp_t gfp_mask,
+		pgprot_t prot, unsigned long vm_flags, int node,
+		const void *caller)
+{
+	return __vmalloc(size, flags);
+}
+
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller)
 {
@@ -180,12 +188,6 @@ void *vmalloc_user(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_user);
 
-void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags)
-{
-	return __vmalloc_user_flags(size, flags | __GFP_ZERO);
-}
-EXPORT_SYMBOL(vmalloc_user_node_flags);
-
 struct page *vmalloc_to_page(const void *addr)
 {
 	return virt_to_page(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 333fbe77255a..f6f2acdaf70c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2658,26 +2658,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-/**
- * vmalloc_user_node_flags - allocate memory for userspace on a specific node
- * @size: allocation size
- * @node: numa node
- * @flags: flags for the page level allocator
- *
- * The resulting memory area is zeroed so it can be mapped to userspace
- * without leaking data.
- *
- * Return: pointer to the allocated memory or %NULL on error
- */
-void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags)
-{
-	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
-				    flags | __GFP_ZERO, PAGE_KERNEL,
-				    VM_USERMAP, node,
-				    __builtin_return_address(0));
-}
-EXPORT_SYMBOL(vmalloc_user_node_flags);
-
 /**
  * vmalloc_exec - allocate virtually contiguous, executable memory
  * @size:	  allocation size
-- 
2.25.1

