Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAE3A7F4F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhFON3g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFON3f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:29:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049CC0617AF;
        Tue, 15 Jun 2021 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wcPpMDy97xUK1RM10BNiXs7xBvfpVplA66+OJqXXBlc=; b=PoKYYdGYNgKcb1Dj9Q9IOSmwID
        7Kj7GzlvQq59r7+2/f5WMOpRRW+ZC41jxWkwj8ZNlkcTOLrn8O375s2Eg4Ly0E3VzmKwtzDtsFt+y
        m+6oCKbwu3G99/VH9eULMdeur3AsveUeLtF1JKn71UKFoYGv3swhN7URyvuh5jir7P2a/mPwV/7P2
        jJ8E/5RQNgCqn/uLR9uN8Q3/Mxq0SR2DWTahAW9RBPpiqdmWAN+cYx+VyZ2V1suqukiNuVOLrMIWZ
        gPbuXrEfQAiHdbNIFl2a120wbipxdYE+49g6khs8IPXOO0i6hHYMRHN8Gx/gllkvjupYKXKSzl3Sd
        fmhdvWyA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt95F-006nyF-RW; Tue, 15 Jun 2021 13:26:30 +0000
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
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 05/18] bvec: fix the include guards for bvec.h
Date:   Tue, 15 Jun 2021 15:24:43 +0200
Message-Id: <20210615132456.753241-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix the include guards to match the file naming.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/bvec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..883faf5f1523 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -4,8 +4,8 @@
  *
  * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>
  */
-#ifndef __LINUX_BVEC_ITER_H
-#define __LINUX_BVEC_ITER_H
+#ifndef __LINUX_BVEC_H
+#define __LINUX_BVEC_H
 
 #include <linux/bug.h>
 #include <linux/errno.h>
@@ -183,4 +183,4 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
-#endif /* __LINUX_BVEC_ITER_H */
+#endif /* __LINUX_BVEC_H */
-- 
2.30.2

