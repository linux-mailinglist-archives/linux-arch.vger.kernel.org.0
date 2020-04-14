Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA61A7C22
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502698AbgDNNOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502691AbgDNNOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:14:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B77EC061A0C;
        Tue, 14 Apr 2020 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ShK5Me996gVFjNoA46gSO+1ycU7xfG9bvtmEJ4mSn6s=; b=Gr3oT3MbHE1JOk/VPGzX5p9T2C
        pTRrcuDzDM0N9/oba/OZkbq5svnWZVBlH/6k5PMc0AqFZzCkj/PMuazbQoCsdggoTOPpPMTN+Jdw2
        1vmgS5AmZsgc6NwRBlVqa4RUyo3fHcLRPDbEtgEsdcEkc3l2NwGMcLHeME4MekGImgf7hBX8yy4Ew
        Oe95oE5TymCplZ9T3ksxsI0AVAMkqZkZV0r2tIOfpkOySKtGKKkdx++daKuS2Vo9G7jTv6BgK5hJ5
        Mk4L0fksjwF4nsmuYh+vyOfrO+Rb8kVGGsUGg7IByh/BRa5VeZFFEMAjQ3y4O828yMhlGVVEbn/0g
        n++3f03w==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLOC-0006Q5-O2; Tue, 14 Apr 2020 13:14:09 +0000
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
Subject: [PATCH 05/29] dma-mapping: use vmap insted of reimplementing it
Date:   Tue, 14 Apr 2020 15:13:24 +0200
Message-Id: <20200414131348.444715-6-hch@lst.de>
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

Replace the open coded instance of vmap with the actual function.  In
the non-contiguous (IOMMU) case this requires an extra find_vm_area,
but given that this isn't a fast path function that is a small price
to pay.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/dma/remap.c | 48 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index d14cbc83986a..914ff5a58dd5 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -20,23 +20,6 @@ struct page **dma_common_find_pages(void *cpu_addr)
 	return area->pages;
 }
 
-static struct vm_struct *__dma_common_pages_remap(struct page **pages,
-			size_t size, pgprot_t prot, const void *caller)
-{
-	struct vm_struct *area;
-
-	area = get_vm_area_caller(size, VM_DMA_COHERENT, caller);
-	if (!area)
-		return NULL;
-
-	if (map_vm_area(area, prot, pages)) {
-		vunmap(area->addr);
-		return NULL;
-	}
-
-	return area;
-}
-
 /*
  * Remaps an array of PAGE_SIZE pages into another vm_area.
  * Cannot be used in non-sleeping contexts
@@ -44,15 +27,12 @@ static struct vm_struct *__dma_common_pages_remap(struct page **pages,
 void *dma_common_pages_remap(struct page **pages, size_t size,
 			 pgprot_t prot, const void *caller)
 {
-	struct vm_struct *area;
+	void *vaddr;
 
-	area = __dma_common_pages_remap(pages, size, prot, caller);
-	if (!area)
-		return NULL;
-
-	area->pages = pages;
-
-	return area->addr;
+	vaddr = vmap(pages, size >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
+	if (vaddr)
+		find_vm_area(vaddr)->pages = pages;
+	return vaddr;
 }
 
 /*
@@ -62,24 +42,20 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 void *dma_common_contiguous_remap(struct page *page, size_t size,
 			pgprot_t prot, const void *caller)
 {
-	int i;
+	int count = size >> PAGE_SHIFT;
 	struct page **pages;
-	struct vm_struct *area;
+	void *vaddr;
+	int i;
 
-	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
+	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;
-
-	for (i = 0; i < (size >> PAGE_SHIFT); i++)
+	for (i = 0; i < count; i++)
 		pages[i] = nth_page(page, i);
-
-	area = __dma_common_pages_remap(pages, size, prot, caller);
-
+	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
 	kfree(pages);
 
-	if (!area)
-		return NULL;
-	return area->addr;
+	return vaddr;
 }
 
 /*
-- 
2.25.1

