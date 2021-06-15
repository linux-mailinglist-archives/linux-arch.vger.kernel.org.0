Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBD3A7F2A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFON2I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFON2H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:28:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E11C061574;
        Tue, 15 Jun 2021 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1X21SF/7fmwg2FrGG5ahYeKQk8ivw4suEk6vCt/uQZM=; b=Yvjhr/bJmyJ/QCD+GCduqR8jqD
        RfTnBcPS7gxLwW7kxITRtCz0LU2jOF9jpt0JwCS1WO3/TpTYsfE0R4dPtZGTRx/ju2FqDrozih8Jk
        aiZGKwiuEcyhdyeL+PmvjvkV5PFLRvauaMoSuuu9uM+vJl3qs/9CTh7sD2QjB2KjfOb65mtU2myUn
        qkfsk6YjZlAK3U/zrVA/R5JbS2FbFJIRHZFLKMBJGzz6h8RCblaDBYsnT/foXESa+zQPlmJelf4oX
        Vi9UPEtaewyVKmdkil7ItuM/Sw7khkyPbd4o6gm/aAiy9bj/1GtYW24JZAJ9XsVUcVZw0mxAa3egy
        OVadjXDg==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt942-006nuT-C1; Tue, 15 Jun 2021 13:25:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 01/18] mm: add a kunmap_local_dirty helper
Date:   Tue, 15 Jun 2021 15:24:39 +0200
Message-Id: <20210615132456.753241-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a helper that calls flush_kernel_dcache_page before unmapping the
local mapping.  flush_kernel_dcache_page is required for all pages
potentially mapped into userspace that were written to using kmap*,
so having a helper that does the right thing can be very convenient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/highmem-internal.h | 7 +++++++
 include/linux/highmem.h          | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 7902c7d8b55f..bd37706db147 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -224,4 +224,11 @@ do {								\
 	__kunmap_local(__addr);					\
 } while (0)
 
+#define kunmap_local_dirty(__page, __addr)			\
+do {								\
+	if (!PageSlab(__page))					\
+		flush_kernel_dcache_page(__page);		\
+	kunmap_local(__addr);					\
+} while (0)
+
 #endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 832b49b50c7b..65f548db4f2d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -93,6 +93,10 @@ static inline void kmap_flush_unused(void);
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
  * disabling migration in order to keep the virtual address stable across
  * preemption. No caller of kmap_local_page() can rely on this side effect.
+ *
+ * If data is written to the returned kernel mapping, the callers needs to
+ * unmap the mapping using kunmap_local_dirty(), else kunmap_local() should
+ * be used.
  */
 static inline void *kmap_local_page(struct page *page);
 
-- 
2.30.2

