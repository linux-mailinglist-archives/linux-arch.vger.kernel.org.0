Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18893D6EB9
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhG0GHo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhG0GHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:07:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F6DC061757;
        Mon, 26 Jul 2021 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M2KGG6I0U2EZ5R+rEPh6yOtJDtRGWl8X6UKQ2IJBGZQ=; b=CRL1laGIBQmQ1ZR+XgfjfpB2n6
        CI9D4xjMJHRNUpbpT5zdNb3ttNHIEZ062MFo8E26hr6xTyrjPMw8xu8qQ8bUvCSrghNbadb55mrWv
        8fl5GN5mDWWAxkYRTHKunAmC1GPf/LzcJPgRZd1xURbB7YjQtGLz8xFwZD81kO9ApElpUe9KY2l38
        s03fMuiKRxcZ+4mHQPgGbcwGO7Pwilw3rCGjYwva0cfs2myPpFX3YdyvVEaM5HazuvKr3hTp/Qk+m
        9sV+2nK6xT8z63QQ956jcnxfk4PP9DXaGh6dEj7KaV4hO4J/FA/hrc9ELvPvPH6jfpGo/7VJGBobk
        NfxX31Fw==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GC8-00EijX-Cw; Tue, 27 Jul 2021 06:04:16 +0000
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
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 05/15] block: use memzero_page in zero_fill_bio
Date:   Tue, 27 Jul 2021 07:56:36 +0200
Message-Id: <20210727055646.118787-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 block/bio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..2e436bccb1e2 100644
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

