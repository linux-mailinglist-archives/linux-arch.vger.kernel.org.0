Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180C03A7F9F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFONax (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhFONat (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:30:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37457C061574;
        Tue, 15 Jun 2021 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fwYY4cSIlXZUYhtFYDVp8X4pn3Su5FY8BPl+PlDQj0g=; b=o9rlvoNlNXNdcekDmTn200bHY3
        du7q+hb5J/7l7Mmff9Frg7gGmQSc1zn1ny8mabmMdI1BR1VvKpaSCb2W3kFfgmB5Wn0ypoLANru6K
        0JyShqr627zVnXx3hdSjEHc5BRqaxcSXp6Lv41q3Vlpz9bnuGI+IDYeMnY+/4hXs2q0cqYlOfXVY0
        qWfc4SgsvwzQszydwfkZOw+gVh4V8ZlrQTPw5FSbbhfjFqbbTuUSS97XHewV2dusDFIBy8Y/ssZNq
        j5kIz+H15DstpmzoIdDZzwETQ220TxaVmb4fr0nBQwM2aPWzWB+SyYB9LT1e3W4NDUUJhbhy2WEM6
        DAhmxf9A==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt962-006o4C-KU; Tue, 15 Jun 2021 13:27:19 +0000
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
Subject: [PATCH 07/18] bvec: add memcpy_{from,to}_bvec and memzero_bvec helper
Date:   Tue, 15 Jun 2021 15:24:45 +0200
Message-Id: <20210615132456.753241-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add helpers to perform common memory operation on a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/bvec.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f8710af18eef..f9fa43b940ff 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -196,4 +196,37 @@ static inline void *bvec_kmap_local(struct bio_vec *bvec)
 	return kmap_local_page(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * memcpy_from_bvec - copy data from a bvec
+ * @bvec: bvec to copy from
+ *
+ * Must be called on single-page bvecs only.
+ */
+static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
+{
+	memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
+}
+
+/**
+ * memcpy_to_bvec - copy data to a bvec
+ * @bvec: bvec to copy to
+ *
+ * Must be called on single-page bvecs only.
+ */
+static inline void memcpy_to_bvec(struct bio_vec *bvec, const char *from)
+{
+	memcpy_to_page(bvec->bv_page, bvec->bv_offset, from, bvec->bv_len);
+}
+
+/**
+ * memzero_bvec - zero all data in a bvec
+ * @bvec: bvec to zero
+ *
+ * Must be called on single-page bvecs only.
+ */
+static inline void memzero_bvec(struct bio_vec *bvec)
+{
+	memzero_page(bvec->bv_page, bvec->bv_offset, bvec->bv_len);
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.30.2

