Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0263A7FFF
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFONeN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFONeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC6C061574;
        Tue, 15 Jun 2021 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HbWeEgqptxjWNK7W80q76MsDEy7Zz/e6+B7EWMBgV8Y=; b=jmkA5X9lidmbgX1TkMC9E1s/OX
        sXzfe8ue9sIAK6INJ5Dl3lX+QBBPPmI0jOn0zqdTG64+Ug3uCS4mu1fPzA3sPAnSVjt4phprDdR2I
        O5LVEQsfzFmz4kGtFNya2TL+RdF7n66kL7+2hQ7tjO4oqUau9XDLmWGNIL7nCrnq7BlWfvWVzJE1K
        y5I7lmBSbz/qiHqyOqYSRsxwiAOfwqde4+13GRFm5HJzV5zvZzLr+5GD91nlh1PhrEp8V5rECvLkz
        OUytNuiBoBQPwp3osxl16+pd+uBoR4YlAHZ3Iyrw3Y3kKHspKXkzXqERVWiK5rR6oycgRXPNi79At
        PystZgVA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt99h-006oSj-5Y; Tue, 15 Jun 2021 13:31:04 +0000
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
Subject: [PATCH 15/18] block: use memcpy_from_bvec in bio_copy_kern_endio_read
Date:   Tue, 15 Jun 2021 15:24:53 +0200
Message-Id: <20210615132456.753241-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use memcpy_from_bvec instead of open coding the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 3743158ddaeb..d1448aaad980 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -400,7 +400,7 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
+		memcpy_from_bvec(p, bvec);
 		p += bvec->bv_len;
 	}
 
-- 
2.30.2

