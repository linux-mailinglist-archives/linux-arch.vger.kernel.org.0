Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D653D6EC7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhG0GJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhG0GJF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:09:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F6C061757;
        Mon, 26 Jul 2021 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cNxTcG8XdnUuoOVixjLVY8XjmYtYsiM+b+iVbGfjzMo=; b=YElztzLh9bPWVL4V+uU9bkDpMk
        NzLXuxXX8mqkPiEdB2lVQLf3TV5qJiqowOEHrhhlM06Y91t6eaziCzTqxX42qQ+8cb1d8ZXTRaikg
        YF5bKQT+bE2YjfM1cjolnhAs+dTL9vFk6NqmTNFE5uy2JYG8dRJQvDpF3Je4y8fhZ+4UaW9tikYHy
        WY55ceDWlHcUJgaRiSXsKjeyGORzyQs4tFpWjixBwSlsLjNevh7FbpN0Wxj9UdkAEILekZHJ2A5iP
        zcPxLvMPLFrlCZ5qfJamSbDvM83tqLmnBQ/axtL8y/k+21PGCIp8eSw58kmzmrTHns4GfaGKtsH6k
        qWoYyuyg==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GD4-00Einn-II; Tue, 27 Jul 2021 06:05:39 +0000
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
Subject: [PATCH 06/15] rbd: use memzero_bvec
Date:   Tue, 27 Jul 2021 07:56:37 +0200
Message-Id: <20210727055646.118787-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use memzero_bvec instead of reimplementing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/block/rbd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 90b947c96402..6d596c2c2cd6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1219,24 +1219,13 @@ static void rbd_dev_mapping_clear(struct rbd_device *rbd_dev)
 	rbd_dev->mapping.size = 0;
 }
 
-static void zero_bvec(struct bio_vec *bv)
-{
-	void *buf;
-	unsigned long flags;
-
-	buf = bvec_kmap_irq(bv, &flags);
-	memset(buf, 0, bv->bv_len);
-	flush_dcache_page(bv->bv_page);
-	bvec_kunmap_irq(buf, &flags);
-}
-
 static void zero_bios(struct ceph_bio_iter *bio_pos, u32 off, u32 bytes)
 {
 	struct ceph_bio_iter it = *bio_pos;
 
 	ceph_bio_iter_advance(&it, off);
 	ceph_bio_iter_advance_step(&it, bytes, ({
-		zero_bvec(&bv);
+		memzero_bvec(&bv);
 	}));
 }
 
@@ -1246,7 +1235,7 @@ static void zero_bvecs(struct ceph_bvec_iter *bvec_pos, u32 off, u32 bytes)
 
 	ceph_bvec_iter_advance(&it, off);
 	ceph_bvec_iter_advance_step(&it, bytes, ({
-		zero_bvec(&bv);
+		memzero_bvec(&bv);
 	}));
 }
 
-- 
2.30.2

