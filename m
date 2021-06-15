Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0F3A7FCC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhFONct (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhFONce (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:32:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1DC0613A4;
        Tue, 15 Jun 2021 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2zRJ25N1ZQDjqoP5wRz0IPeM9t4AaO32k8GS/PID3co=; b=lg9kItVEWpEdsdpwblcoecYLrq
        nZ0fKKtL35zH7MUYw0F4AXQrqzi9e/V3lpY/GWSimSh1x46k6Weu3TDJVDlIDMvAzj+eGSQO03gzw
        5UaIHXhBx2u8NFFxHB89hxgXzBYbP5kwjzs5XwiLZynjO7ciIQgYWgOq3AO44AVNZ9r/hTjz4/2Of
        r0ku0UvSEU73lyxqx3QpcciGuNqCxEr0dOesI+wbPsUGXSGTdboY0wNj/Mq2Og0FA/RHuI5wT/pzk
        VOFK9eqWGz1osp64Ulb8foUPTSy6r31VRLoH0QXmFIcq9YYoP5OlIZROzAZCK7wLZjr993uYbTnPC
        awIppbww==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt97O-006oBC-0j; Tue, 15 Jun 2021 13:28:47 +0000
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
Subject: [PATCH 10/18] dm-writecache: use bvec_kmap_local instead of bvec_kmap_irq
Date:   Tue, 15 Jun 2021 15:24:48 +0200
Message-Id: <20210615132456.753241-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/md/dm-writecache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index aecc246ade26..93ca454eaca9 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1205,14 +1205,13 @@ static void memcpy_flushcache_optimized(void *dest, void *source, size_t size)
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
@@ -1230,7 +1229,7 @@ static void bio_copy_block(struct dm_writecache *wc, struct bio *bio, void *data
 			memcpy_flushcache_optimized(data, buf, size);
 		}
 
-		bvec_kunmap_irq(buf, &flags);
+		kunmap_local(buf);
 
 		data = (char *)data + size;
 		remaining_size -= size;
-- 
2.30.2

