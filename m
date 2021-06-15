Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4B3A7FAB
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFONbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhFONbC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:31:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF3C0613A4;
        Tue, 15 Jun 2021 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gCdUfdryXX9J3CwMxmwyJL5seb86z6Ov9FawmIkvAKE=; b=Kaaj+w5sQBoBqkokmlMCbw4thd
        Y7RDcQBgSPtWiunihfvmP4ESXOvhqtDJoTqJoE/9zJZprhgvpjDifd84KWd+McMZbcjtKZXFVlJUN
        jQg6z+ZJ54Tz4G17iB1ZeKnFbcbf9O+F+c28OwF/47Tcch64az3DF3QiXEebGtjAucaT1r0tIgSvE
        CY3C3GkjI8ZtiKGXJSYcKIMth7IL2aHU47vDbyksvE6tWslM8x9Dh1MmU4C3uNhLT/izjphPsnF20
        CiWAlkUponb1AsZWsfz5+tjnNExbaWSCT5bk2MDSTan/yAXXEiELwPjfQkKmiuYUy/NJjXyM7lrBM
        oj39iSdw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt96I-006o5s-Gs; Tue, 15 Jun 2021 13:27:36 +0000
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
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 08/18] block: use memzero_page in zero_fill_bio
Date:   Tue, 15 Jun 2021 15:24:46 +0200
Message-Id: <20210615132456.753241-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use memzero_bvec to zero each segment in the bio instead of manually
mapping and zeroing the data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 block/bio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..1d7abdb83a39 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -495,16 +495,11 @@ EXPORT_SYMBOL(bio_kmalloc);
 
 void zero_fill_bio(struct bio *bio)
 {
-	unsigned long flags;
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
-	bio_for_each_segment(bv, bio, iter) {
-		char *data = bvec_kmap_irq(&bv, &flags);
-		memset(data, 0, bv.bv_len);
-		flush_dcache_page(bv.bv_page);
-		bvec_kunmap_irq(data, &flags);
-	}
+	bio_for_each_segment(bv, bio, iter)
+		memzero_bvec(&bv);
 }
 EXPORT_SYMBOL(zero_fill_bio);
 
-- 
2.30.2

