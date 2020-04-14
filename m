Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE81A7DFF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502863AbgDNNP5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502853AbgDNNPu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:15:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A51C061A0F;
        Tue, 14 Apr 2020 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xg3LanskcG5YxBBSEuWUOh1CRzHOTC2lvRuHUPOBmeo=; b=KhiN2gV6T32eNzUkhId1mXELeZ
        5PsdY9DuWijoEqV8hb2sX5GukDJyInt/jxOFGbCajA4t8GitLegtX+eJQjrYYS/EnKK8+i/D4f+Fn
        tuFY7+F0XaygZYJ5b1gWq/yCLhFuXWmmMjxhVh9UYbhg/6YPWDb54NRr5jsiB9JeTXQUj+Uy4dLSr
        ofbutqQlzahhykDWFxF/82ir6KFU2OmzWWDcFYlCWo/0EVGvQvt26fFQ+vtZ8pm1pttsS+Y8snal4
        j3dMZYsLj+N5ZdDPGWwXBRyexm9J5W7B+EYRiLN4iSj9Ock+F721O8Q3VljvKV/BYvUCnE8LmtGd2
        GtWRMJVg==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLPX-0001qd-UV; Tue, 14 Apr 2020 13:15:32 +0000
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
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 29/29] s390: use __vmalloc_node in stack_alloc
Date:   Tue, 14 Apr 2020 15:13:48 +0200
Message-Id: <20200414131348.444715-30-hch@lst.de>
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

stack_alloc can use a slightly higher level vmalloc function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

