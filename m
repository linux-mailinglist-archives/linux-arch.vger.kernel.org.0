Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C221A7E38
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgDNNdb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502814AbgDNNPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:15:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E93C0610D5;
        Tue, 14 Apr 2020 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=u3nIu92+yzd2DkZyrdIwKviaxx6KjPltBpD1EwU5vf4=; b=EmYWhnqLHvhUkXM+PJWi6bo1Ia
        etHuuwEOyZ2ARE55ofJOGLAB1N8BvyKT8vIGa2G4/jTU0js9MGTzT1kGsl6VQE2hDtOz4b+YKwPpf
        QREUVBWSt3gqmsjYdkAJ3XJxjT2G/4hnhFyaY/XmVFEjz3+CD1yDoxHysRiSwklc3Jgsd9DppXJiE
        af8RLvbaw2aaJGLqEtnajEMjTD3n8ZpUzNKrdyFJN39yhWMzSfhQB5F0wXvWkTsBEryX4m1J5aZF9
        wCf9fIGTCNnPEgYQbZP4R5Y9JSu6ffdMnd3b62bVSq02UmAN+uJ+7Y53ZjR1XeyQp4vxbc1bQJtbk
        /QsUK7iA==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLPD-0008Me-8R; Tue, 14 Apr 2020 13:15:11 +0000
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
Subject: [PATCH 23/29] mm: remove both instances of __vmalloc_node_flags
Date:   Tue, 14 Apr 2020 15:13:42 +0200
Message-Id: <20200414131348.444715-24-hch@lst.de>
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

The real version just had a few callers that can open code it and
remove one layer of indirection.  The nommu stub was public but only
had a single caller, so remove it and avoid a CONFIG_MMU ifdef in
vmalloc.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/vmalloc.h |  9 ---------
 mm/nommu.c              |  3 ++-
 mm/vmalloc.c            | 20 ++++++--------------
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c1b9d6eca05f..4a46d296e70d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -115,17 +115,8 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller);
-#ifndef CONFIG_MMU
-extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
-static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
-						gfp_t flags, void *caller)
-{
-	return __vmalloc_node_flags(size, node, flags);
-}
-#else
 extern void *__vmalloc_node_flags_caller(unsigned long size,
 					 int node, gfp_t flags, void *caller);
-#endif
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
diff --git a/mm/nommu.c b/mm/nommu.c
index 2df549adb22b..9553efa59787 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -150,7 +150,8 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
-void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags)
+void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
+		void *caller)
 {
 	return __vmalloc(size, flags);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index de7952959e82..3d59d848ad48 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2566,14 +2566,6 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
-static inline void *__vmalloc_node_flags(unsigned long size,
-					int node, gfp_t flags)
-{
-	return __vmalloc_node(size, 1, flags, node,
-				__builtin_return_address(0));
-}
-
-
 void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
 				  void *caller)
 {
@@ -2594,8 +2586,8 @@ void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
  */
 void *vmalloc(unsigned long size)
 {
-	return __vmalloc_node_flags(size, NUMA_NO_NODE,
-				    GFP_KERNEL);
+	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
+				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc);
 
@@ -2614,8 +2606,8 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vzalloc(unsigned long size)
 {
-	return __vmalloc_node_flags(size, NUMA_NO_NODE,
-				GFP_KERNEL | __GFP_ZERO);
+	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
+				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vzalloc);
 
@@ -2670,8 +2662,8 @@ EXPORT_SYMBOL(vmalloc_node);
  */
 void *vzalloc_node(unsigned long size, int node)
 {
-	return __vmalloc_node_flags(size, node,
-			 GFP_KERNEL | __GFP_ZERO);
+	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, node,
+				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-- 
2.25.1

