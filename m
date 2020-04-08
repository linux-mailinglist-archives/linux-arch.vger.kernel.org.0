Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253CA1A20CE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgDHMAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:00:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgDHMAl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KEFtYuqpBrCVgZp8M6bEdJZafIEARW6kIJmg3biR4K0=; b=LRZUycqFMV229C2W8BGfXZ4U40
        c9uECl7UL+Q6WlTw2K2vpM6qbyXzXWKSEYHuGB9euL1doXvNACBXGwCe263BitSOP4m2FERpGA9gN
        TRzLryKZj3ipBzNzWf0PXyDi5Kld8X9dVhvWgI8ekPvXDXSzfpVR0fb0fPZ1YdalSvqohkCsUL3vN
        VI5JDnsndNAUg3JHPJcZeDv+TZT4Bppz0sXAEwaJrsSsGwe03LMwV08FDQSJiCUaJCwj5b1iw+qeR
        jPTA3RC7G61mI7HFz3NI2vi6CsCteSNh4cY2jdpfECo8JkHV3DyS8Nb9htyHHLOBRPfRaU3BqsP77
        06Ii0T3g==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9NV-0004ke-IF; Wed, 08 Apr 2020 12:00:22 +0000
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
Subject: [PATCH 14/28] mm: don't return the number of pages from map_kernel_range{,_noflush}
Date:   Wed,  8 Apr 2020 13:59:12 +0200
Message-Id: <20200408115926.1467567-15-hch@lst.de>
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

None of the callers needs the number of pages, and a 0 / -errno return
value is a lot more intuitive.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a3d810def567..ca8dc5d42580 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -249,7 +249,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
  * function.
  *
  * RETURNS:
- * The number of pages mapped on success, -errno on failure.
+ * 0 on success, -errno on failure.
  */
 int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 			     pgprot_t prot, struct page **pages)
@@ -269,7 +269,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 			return err;
 	} while (pgd++, addr = next, addr != end);
 
-	return nr;
+	return 0;
 }
 
 static int map_kernel_range(unsigned long start, unsigned long size,
-- 
2.25.1

