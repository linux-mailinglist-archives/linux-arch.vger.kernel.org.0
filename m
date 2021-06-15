Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C0A3A801E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFONf4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhFONfg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC565C0613A4;
        Tue, 15 Jun 2021 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1vl+lJtrWoiUzzKH0COLUmHTJyPccdOEl/SXPdFbHq8=; b=orcVM4ZS+23ndu19ILV+oG8Kdb
        EYq30bY5COpSe8j73G1ZSpdxCnZvGUug6zi+n3PtNKTIYr2gdrB6nrERB3vHdIIR4hPOT/UpTCyWs
        AYodO6/zr9y0OT7KoRpqlRoey1MBbGiUTgoxOd/kcm4TRjkQ8E3XYxEkGCrC8InktD++/3VespVyQ
        FAP7MeVYaSA+NqHbe0Hkisx+6r4BLNLdkNjC0eQtKEFztNzuWuVCAheweEjtcFUDpKAbuCLRmg4/G
        EVnQKf6DqMMaY9iFPuJi82thdu+6gkEtdThFuqtrkl3pXuuSly/nPtwkQFcg10SnbFD7sIkGMm4qc
        1ysBDTTA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt9Ae-006obD-98; Tue, 15 Jun 2021 13:32:08 +0000
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
Subject: [PATCH 18/18] block: use bvec_kmap_local in bio_integrity_process
Date:   Tue, 15 Jun 2021 15:24:56 +0200
Message-Id: <20210615132456.753241-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Using local kmaps slightly reduces the chances to stray writes, and
the bvec interface cleans up the code a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4b4eb8964a6f..8f54d49dc500 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -172,18 +172,16 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 	iter.prot_buf = prot_buf;
 
 	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
-		void *kaddr = kmap_atomic(bv.bv_page);
+		void *kaddr = bvec_kmap_local(&bv);
 
-		iter.data_buf = kaddr + bv.bv_offset;
+		iter.data_buf = kaddr;
 		iter.data_size = bv.bv_len;
-
 		ret = proc_fn(&iter);
-		if (ret) {
-			kunmap_atomic(kaddr);
-			return ret;
-		}
+		kunmap_local(kaddr);
+
+		if (ret)
+			break;
 
-		kunmap_atomic(kaddr);
 	}
 	return ret;
 }
-- 
2.30.2

