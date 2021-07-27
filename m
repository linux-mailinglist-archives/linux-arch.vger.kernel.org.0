Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9A3D6F64
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhG0GZO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0GZN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:25:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF5C061757;
        Mon, 26 Jul 2021 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jFuNMKcRbcVnR+JgRWAcFH4S0wPCM0LhDW7OHMhdenM=; b=ZlPtXIOVwXE0aeEVhqPQ0pLddO
        rr5EooQEZ6+S9JLHdS21sBPJ1zXlGbUobbMssMsOIoajU/cNBcLZJUaVK4Cq1Vob1y9rvjIvfaLP2
        jLpBaotC3LPfh4M8MsZaVgWQopzUxvAs4oPgX7/CsaH6Tg3bzUa+ZnsFVTsnGZ8SKQM2ObR5Ktt06
        WsUeEtBSIekhebyDfQ2PaCHHjj4MGhZDYWrXqhTPqVBQoOEXwnJPZUVITViJeIx9mu07++3CnzVuD
        /ZSLyXN29uMKgcHN4h+6S9tjvi3olbm75aJXSRMnpdhi9hwLYuajBpxC0wX2qwNMJvHPzgYD+vaqb
        7LUmYtkA==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GRw-00Ejpq-EQ; Tue, 27 Jul 2021 06:20:46 +0000
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
Subject: [PATCH 15/15] block: use bvec_kmap_local in bio_integrity_process
Date:   Tue, 27 Jul 2021 07:56:46 +0200
Message-Id: <20210727055646.118787-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Using local kmaps slightly reduces the chances to stray writes, and
the bvec interface cleans up the code a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

