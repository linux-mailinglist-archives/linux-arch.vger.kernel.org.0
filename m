Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A51A7E63
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502736AbgDNNO5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502731AbgDNNOx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:14:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EECC061A10;
        Tue, 14 Apr 2020 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kDWxNR99BXM0mYvZJ8aft2fdXgy+jyVb2k5m2hDhDIg=; b=m99mv6+L6NEGc5NsA05meTZ7J4
        pET4ii0TRtjQCrdWlxaL+Z3i+1UptXtFxQGlSdBzQ21ohBGQEpsm2M9Vft9jJlWjOu19cVSMmyEje
        0W2E7OvYWUFCIVLO80Sg9o0BZPGaQA1gW/JQLBqCnSWgvbRsrUncgPC43+OGZ32lMwtrlOJABgpmP
        dr9dO3PUdumoeIRhWb8CKqgTbCH+YaovAGUKzCjWGK+2U4vCn6pUJZSRIvNXmAxIaRcb8mHUrLnCb
        kt1YUre6HJ0Ez+Ip2qdE7zqvvZHdZOwfghfirz0wiudpSSYO5JMcU+7yljHPY3nC7FtZMX6hoowY6
        r5y6QnkA==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLOb-0006lI-8l; Tue, 14 Apr 2020 13:14:33 +0000
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
Subject: [PATCH 12/29] mm: pass addr as unsigned long to vb_free
Date:   Tue, 14 Apr 2020 15:13:31 +0200
Message-Id: <20200414131348.444715-13-hch@lst.de>
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

Ever use of addr in vb_free casts to unsigned long first, and the caller
has an unsigned long version of the address available anyway.  Just pass
that and avoid all the casts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/vmalloc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9183fc0d365a..aada9e9144bd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1664,7 +1664,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	return vaddr;
 }
 
-static void vb_free(const void *addr, unsigned long size)
+static void vb_free(unsigned long addr, unsigned long size)
 {
 	unsigned long offset;
 	unsigned long vb_idx;
@@ -1674,24 +1674,22 @@ static void vb_free(const void *addr, unsigned long size)
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
 
-	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
+	flush_cache_vunmap(addr, addr + size);
 
 	order = get_order(size);
 
-	offset = (unsigned long)addr & (VMAP_BLOCK_SIZE - 1);
-	offset >>= PAGE_SHIFT;
+	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 
-	vb_idx = addr_to_vb_idx((unsigned long)addr);
+	vb_idx = addr_to_vb_idx(addr);
 	rcu_read_lock();
 	vb = radix_tree_lookup(&vmap_block_tree, vb_idx);
 	rcu_read_unlock();
 	BUG_ON(!vb);
 
-	vunmap_page_range((unsigned long)addr, (unsigned long)addr + size);
+	vunmap_page_range(addr, addr + size);
 
 	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range((unsigned long)addr,
-					(unsigned long)addr + size);
+		flush_tlb_kernel_range(addr, addr + size);
 
 	spin_lock(&vb->lock);
 
@@ -1791,7 +1789,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 
 	if (likely(count <= VMAP_MAX_ALLOC)) {
 		debug_check_no_locks_freed(mem, size);
-		vb_free(mem, size);
+		vb_free(addr, size);
 		return;
 	}
 
-- 
2.25.1

