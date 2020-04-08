Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6DB1A2134
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgDHMBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:01:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgDHMAv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kdPXICt3ToIhxT0a97HmUqVQTUwvVQRxLdzdeoL86lM=; b=fZvvhthrevXdiqyl40zG/tdMD0
        d74Ir6bz9f/dsugmohA4kuydR4xiOtmsMKvGtcZ5yxa+3Qh06v/LfObaQofY0Aock1pIT7kiFjyHN
        QrVUchXeO3nvLSR9xwOZiMjM6kzP7dLHOZOMKwe3pWiJfedFC1r+GI8GxmyJ5Uhs1lA9wOXxk0j6n
        uMIrjyfAAFL6fQaKtg/qhYLK2PeQVSGJEWxgcstoCT64Ooe5MnLef4vvFOIN1UV/QAMQ2WQ1sJefg
        ihHf5FH1NZojwU5iKEaUi+NfuvFlNydjB9MBnsILibd+PkbNAUVQ/Xzwlod6KP4a00rrT1ExXNtA1
        SPK7ZQoQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9Ng-0005Da-9c; Wed, 08 Apr 2020 12:00:32 +0000
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
Subject: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Date:   Wed,  8 Apr 2020 13:59:15 +0200
Message-Id: <20200408115926.1467567-18-hch@lst.de>
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

This is always GFP_KERNEL - for long term mappings with other properties
vmap should be used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   | 2 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 3 +--
 drivers/media/common/videobuf2/videobuf2-vmalloc.c | 3 +--
 fs/erofs/decompressor.c                            | 2 +-
 fs/xfs/xfs_buf.c                                   | 2 +-
 include/linux/vmalloc.h                            | 3 +--
 mm/nommu.c                                         | 2 +-
 mm/vmalloc.c                                       | 4 ++--
 8 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
index 9272bef57092..debaf7b18ab5 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -66,7 +66,7 @@ static void *mock_dmabuf_vmap(struct dma_buf *dma_buf)
 {
 	struct mock_dmabuf *mock = to_mock(dma_buf);
 
-	return vm_map_ram(mock->pages, mock->npages, 0, PAGE_KERNEL);
+	return vm_map_ram(mock->pages, mock->npages, 0);
 }
 
 static void mock_dmabuf_vunmap(struct dma_buf *dma_buf, void *vaddr)
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 6db60e9d5183..92072a08af25 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -309,8 +309,7 @@ static void *vb2_dma_sg_vaddr(void *buf_priv)
 		if (buf->db_attach)
 			buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
 		else
-			buf->vaddr = vm_map_ram(buf->pages,
-					buf->num_pages, -1, PAGE_KERNEL);
+			buf->vaddr = vm_map_ram(buf->pages, buf->num_pages, -1);
 	}
 
 	/* add offset in case userptr is not page-aligned */
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 1a4f0ca87c7c..c66fda4a65e4 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -107,8 +107,7 @@ static void *vb2_vmalloc_get_userptr(struct device *dev, unsigned long vaddr,
 		buf->vaddr = (__force void *)
 			ioremap(__pfn_to_phys(nums[0]), size + offset);
 	} else {
-		buf->vaddr = vm_map_ram(frame_vector_pages(vec), n_pages, -1,
-					PAGE_KERNEL);
+		buf->vaddr = vm_map_ram(frame_vector_pages(vec), n_pages, -1);
 	}
 
 	if (!buf->vaddr)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5d2d81940679..7628816f2453 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -274,7 +274,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 
 	i = 0;
 	while (1) {
-		dst = vm_map_ram(rq->out, nrpages_out, -1, PAGE_KERNEL);
+		dst = vm_map_ram(rq->out, nrpages_out, -1);
 
 		/* retry two more times (totally 3 times) */
 		if (dst || ++i >= 3)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index f880141a2268..940af9da6db1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -474,7 +474,7 @@ _xfs_buf_map_pages(
 		nofs_flag = memalloc_nofs_save();
 		do {
 			bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
-						-1, PAGE_KERNEL);
+						-1);
 			if (bp->b_addr)
 				break;
 			vm_unmap_aliases();
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 15ffbd8e8e65..9273b1a91ca5 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -88,8 +88,7 @@ struct vmap_area {
  *	Highlevel APIs for driver use
  */
 extern void vm_unmap_ram(const void *mem, unsigned int count);
-extern void *vm_map_ram(struct page **pages, unsigned int count,
-				int node, pgprot_t prot);
+extern void *vm_map_ram(struct page **pages, unsigned int count, int node);
 extern void vm_unmap_aliases(void);
 
 #ifdef CONFIG_MMU
diff --git a/mm/nommu.c b/mm/nommu.c
index 318df4e236c9..4f07b7ef0297 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -351,7 +351,7 @@ void vunmap(const void *addr)
 }
 EXPORT_SYMBOL(vunmap);
 
-void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t prot)
+void *vm_map_ram(struct page **pages, unsigned int count, int node)
 {
 	BUG();
 	return NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 258220b203f1..7356b3f07bd8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1834,7 +1834,7 @@ EXPORT_SYMBOL(vm_unmap_ram);
  *
  * Returns: a pointer to the address that has been mapped, or %NULL on failure
  */
-void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t prot)
+void *vm_map_ram(struct page **pages, unsigned int count, int node)
 {
 	unsigned long size = (unsigned long)count << PAGE_SHIFT;
 	unsigned long addr;
@@ -1858,7 +1858,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 
 	kasan_unpoison_vmalloc(mem, size);
 
-	if (map_kernel_range(addr, size, prot, pages) < 0) {
+	if (map_kernel_range(addr, size, PAGE_KERNEL, pages) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
-- 
2.25.1

