Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB51A2105
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgDHMB0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:01:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDHMBZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=33m+8KzzYyHHFHNqMGAFFkSHEzBaZrs6s8Hwvu3qwIE=; b=QUg0+dwAHsHXfqz6Sp1fVPZeRO
        QVbOpL3630Yhcf97C5v1wf9NVYFrHADGV9PdCj2WnAUQ2xESHf4Rcx/+rt9wqLhaU9bDhDzO2woJn
        P9pAFglwrXl/ZutffchWU+EBw8HPh9gMTc0Y2rJBgieOawnQ0/Xm9AVyGWcyn+h7aLJtg5BwSkYX8
        Bk5gQ3CP6ycySTWc+BoLBOKaEiObBok3YZYiy0rKi2z+yaBkv4fKwQ5pPfJa4YmJnZVZfN/G1mBax
        WK3gy3KkQ3UMC0bqsOSHLcvmF/4c/8RwgvBElgKNFlSaem60bqthpdcveAYNeg7UeFbLJlS8jcqQv
        jh/9RS6A==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9OG-0005yR-5M; Wed, 08 Apr 2020 12:01:08 +0000
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
Subject: [PATCH 28/28] s390: use __vmalloc_node in stack_alloc
Date:   Wed,  8 Apr 2020 13:59:26 +0200
Message-Id: <20200408115926.1467567-29-hch@lst.de>
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

stack_alloc can use a slightly higher level vmalloc function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/kernel/setup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 36445dd40fdb..0f0b140b5558 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -305,12 +305,9 @@ void *restart_stack __section(.data);
 unsigned long stack_alloc(void)
 {
 #ifdef CONFIG_VMAP_STACK
-	return (unsigned long)
-		__vmalloc_node_range(THREAD_SIZE, THREAD_SIZE,
-				     VMALLOC_START, VMALLOC_END,
-				     THREADINFO_GFP,
-				     PAGE_KERNEL, 0, NUMA_NO_NODE,
-				     __builtin_return_address(0));
+	return (unsigned long)__vmalloc_node(THREAD_SIZE, THREAD_SIZE,
+			THREADINFO_GFP, NUMA_NO_NODE,
+			__builtin_return_address(0));
 #else
 	return __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
 #endif
-- 
2.25.1

