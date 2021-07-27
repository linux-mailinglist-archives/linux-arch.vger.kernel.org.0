Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490483D6F17
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhG0GSl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhG0GSl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2CC061757;
        Mon, 26 Jul 2021 23:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=44bMn9sQsnAqHSq0Ad2Laa9gOVD3MbwUdF/8MEGZRgI=; b=SqQd/rUbSnUsVAVYT9i6GdUHG9
        uEK6Te8F76Lna1DRgGRno2YLB2xw2x2FKU+CIgohHdvSUus40dCSkU2gPCnWeG2G34MjyEEWDTaov
        L5fsNT6ysOQox/P+bMhiOqERnNhHX149FVjoAbBf6KjtkcgciLVE7K2U20iali5dcl/Ee4BUPrEf0
        J4bjn8D8ix24lDshE2VGPJSq9/ERJIDNyqLyFZesB/ArDaLK7JdPoJTT344b2fkVv8f63LJq4Zg3P
        Y5NUV+OAHnVQgnKmGWKu4INbz2Whp2wffZK+IaXfqAmfKPbP0hbtcCSx+NNZqquurqWfD864OHqBs
        bphQAYFA==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GKX-00EjGF-Gl; Tue, 27 Jul 2021 06:13:30 +0000
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
Subject: [PATCH 11/15] block: use memcpy_to_bvec in copy_to_high_bio_irq
Date:   Tue, 27 Jul 2021 07:56:42 +0200
Message-Id: <20210727055646.118787-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use memcpy_to_bvec instead of opencoding the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bounce.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 94081e013c58..7e9e666c04dc 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -67,18 +67,6 @@ static __init int init_emergency_pool(void)
 
 __initcall(init_emergency_pool);
 
-/*
- * highmem version, map in to vec
- */
-static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
-{
-	unsigned char *vto;
-
-	vto = kmap_atomic(to->bv_page);
-	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
-	kunmap_atomic(vto);
-}
-
 /*
  * Simple bounce buffer support for highmem pages. Depending on the
  * queue gfp mask set, *to may or may not be a highmem page. kmap it
@@ -86,7 +74,6 @@ static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
  */
 static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 {
-	unsigned char *vfrom;
 	struct bio_vec tovec, fromvec;
 	struct bvec_iter iter;
 	/*
@@ -104,11 +91,8 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 			 * been modified by the block layer, so use the original
 			 * copy, bounce_copy_vec already uses tovec->bv_len
 			 */
-			vfrom = page_address(fromvec.bv_page) +
-				tovec.bv_offset;
-
-			bounce_copy_vec(&tovec, vfrom);
-			flush_dcache_page(tovec.bv_page);
+			memcpy_to_bvec(&tovec, page_address(fromvec.bv_page) +
+				       tovec.bv_offset);
 		}
 		bio_advance_iter(from, &from_iter, tovec.bv_len);
 	}
-- 
2.30.2

