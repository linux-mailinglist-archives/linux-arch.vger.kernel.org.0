Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04EA1A20AB
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgDHMAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:00:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgDHMAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3abNsx+EShWxD+ucjKGAn+8BXbsWA3npQb6OT4j8l/k=; b=VTuUlyaHjuDzGAY0l0Q22uhlLf
        wD/tAlox5u5sxwFwINA4oO8TKm//8TPhXfbrlexPUg+aMWMvm2VJo3XJBh+Q/URlDJwK/WXYOIqeE
        itgjnyzqS9qM62X+s2FY6wgZPZwdcgVDuvcYWRMFVYFRkpvylxG5hinTXVu4DlbECjifF8IxKkSaj
        cIlPRqgcXUpLYjxtckGXmCEjkhgaGgmVSwpDkUczmnaU14CBOdlC4pJ/E1tYZYqk8DY+hdPi28d5/
        v/JuastRyfpIpckKinEsZDF94IKsPBkGGesJScTNgNFFeu8ITiRK19RpZ0CP7qP7hJoo3OYuGXLCo
        vBlTJxNQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9N6-000255-5d; Wed, 08 Apr 2020 11:59:56 +0000
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
Subject: [PATCH 08/28] mm: unexport unmap_kernel_range_noflush
Date:   Wed,  8 Apr 2020 13:59:06 +0200
Message-Id: <20200408115926.1467567-9-hch@lst.de>
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

There are no modular users of this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d1534d610b48..3375f9508ef6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2029,7 +2029,6 @@ void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
 	vunmap_page_range(addr, addr + size);
 }
-EXPORT_SYMBOL_GPL(unmap_kernel_range_noflush);
 
 /**
  * unmap_kernel_range - unmap kernel VM area and flush cache and TLB
-- 
2.25.1

