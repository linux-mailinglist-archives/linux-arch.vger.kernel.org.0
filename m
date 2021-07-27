Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9E13D6EE4
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhG0GMa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhG0GM1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:12:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EDC061757;
        Mon, 26 Jul 2021 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=k7hxGRm8Jl8QZ0E+0tTGTFXB/cUrDbqKzMcpkCKTcVM=; b=qOzgVuer/l+JjRHTjrfejC5H0c
        kIMxSXO0tc6EKwb6Paj46WFFsvihRo46zwbCF6u/ox0BMTbvyvAkW82c7/W6c01w8Vli8sHT1oHEA
        igqhLTnaHPhM/mX+2TDHlkNVqOGfz5/ewuc/R6Aj36elBnj1YRRk7IC3dfDBzWEs1YYU5mwd8n8pg
        SGi3KEDr8pOsJLQTAki2hI5qmv66GCxlb2/O5Mt/QwfUX6374VGGcTB9Dw/CvsJjJ3bsXqEtOp+lb
        5orgIQsSdB41M8ETuicBH7S9MNgZTy8gGIDsli7Of9vn298FB8wCc1suaQz913KTRSPKEnwwyYG/K
        UE3vUmqw==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GG9-00Ej14-Eo; Tue, 27 Jul 2021 06:08:41 +0000
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
Subject: [PATCH 08/15] ps3disk: use memcpy_{from,to}_bvec
Date:   Tue, 27 Jul 2021 07:56:39 +0200
Message-Id: <20210727055646.118787-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the bvec helpers instead of open coding the copy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: Geoff Levand <geoff@infradead.org>
---
 drivers/block/ps3disk.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index f374ea2c67ce..8d51efbe045d 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -83,26 +83,12 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 	unsigned int offset = 0;
 	struct req_iterator iter;
 	struct bio_vec bvec;
-	unsigned int i = 0;
-	size_t size;
-	void *buf;
 
 	rq_for_each_segment(bvec, req, iter) {
-		unsigned long flags;
-		dev_dbg(&dev->sbd.core, "%s:%u: bio %u: %u sectors from %llu\n",
-			__func__, __LINE__, i, bio_sectors(iter.bio),
-			iter.bio->bi_iter.bi_sector);
-
-		size = bvec.bv_len;
-		buf = bvec_kmap_irq(&bvec, &flags);
 		if (gather)
-			memcpy(dev->bounce_buf+offset, buf, size);
+			memcpy_from_bvec(dev->bounce_buf + offset, &bvec);
 		else
-			memcpy(buf, dev->bounce_buf+offset, size);
-		offset += size;
-		flush_kernel_dcache_page(bvec.bv_page);
-		bvec_kunmap_irq(buf, &flags);
-		i++;
+			memcpy_to_bvec(&bvec, dev->bounce_buf + offset);
 	}
 }
 
-- 
2.30.2

