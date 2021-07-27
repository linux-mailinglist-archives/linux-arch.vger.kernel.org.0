Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F183D6ED5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhG0GKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhG0GKu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:10:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9653C061757;
        Mon, 26 Jul 2021 23:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t3OnbpMN0amphJR+ZqgOptW+ighdT38XSDrB1q6UGsY=; b=jxiZJUH1ZldCiRMidy9A0MN4FV
        okgzD1ux3SJB6nURWa1SMC0+SxoMfrsTCYSAkO/RMZj4ghpmPzEuy9qfzXK3BpzVja11hpREgQ2hB
        /xs650Kb1jqHLHG+yyDtL2K10/2IDdROHGxy3DsJDxhIuJsLNiPv08PvDZhR/wX8ZbA0KvfAeTr0U
        GLmNyWK50LLQrs5sQvt3sYtFc1Jm9Sp0BckshzulJzaqKLzR0tzaKziM8xRGC9IEOWHsj88pyusQh
        GEqauNJTMpP+sztKcdRkRat9r7hGjVwUNFPS8WEPtr3xCKsQNrYxFDMOGMl+kDSmZfS42eBHW4voZ
        CaITiwNw==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GEm-00Eit3-Oj; Tue, 27 Jul 2021 06:07:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 07/15] dm-writecache: use bvec_kmap_local instead of bvec_kmap_irq
Date:   Tue, 27 Jul 2021 07:56:38 +0200
Message-Id: <20210727055646.118787-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is no need to disable interrupts in bio_copy_block, and the local
only mappings helps to avoid any sort of problems with stray writes
into the bio data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/md/dm-writecache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index e21e29e81bbf..3d2cf811ec3e 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1214,14 +1214,13 @@ static void memcpy_flushcache_optimized(void *dest, void *source, size_t size)
 static void bio_copy_block(struct dm_writecache *wc, struct bio *bio, void *data)
 {
 	void *buf;
-	unsigned long flags;
 	unsigned size;
 	int rw = bio_data_dir(bio);
 	unsigned remaining_size = wc->block_size;
 
 	do {
 		struct bio_vec bv = bio_iter_iovec(bio, bio->bi_iter);
-		buf = bvec_kmap_irq(&bv, &flags);
+		buf = bvec_kmap_local(&bv);
 		size = bv.bv_len;
 		if (unlikely(size > remaining_size))
 			size = remaining_size;
@@ -1239,7 +1238,7 @@ static void bio_copy_block(struct dm_writecache *wc, struct bio *bio, void *data
 			memcpy_flushcache_optimized(data, buf, size);
 		}
 
-		bvec_kunmap_irq(buf, &flags);
+		kunmap_local(buf);
 
 		data = (char *)data + size;
 		remaining_size -= size;
-- 
2.30.2

