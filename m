Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E818E3D6EA4
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhG0GDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0GDm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:03:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF457C061757;
        Mon, 26 Jul 2021 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v8qmxMjLxIzlD6RqvjykX0yBn4O2X8VoNuXIPKQ0DWs=; b=F1zxkw09un7Q7ywy8fFGyj0VQi
        i0Hwfanb4ZPab9UkwO3hM+KrlapC6OX+d4CgcwAwbOrB0qqpyy2JSGTWIdud2I5r39EazVdQYpiiI
        dvmgodgiOp1dL3vAAr7+VbwSAXdj9tZuD3rJF2M3L40WNCQwdPLFtRAR5CFj1uSGA7jE4V7yFC6w2
        0nUeZHjoY30POJBukQtnDQxgCaT/4+FSg6JzOrGU/p+m0fNf/UsW1wV8tSahJa1MxYHfaRZyv8uaO
        uHy5Uho9HBxe8lnFUSQraMHiA0VrrYPDuDZNXU/XmNXgnBQBVccIV4EImTr8hbAnLXGUpGJuKvjCf
        6mSmSB/A==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8G8U-00EiTR-JU; Tue, 27 Jul 2021 06:00:44 +0000
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
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 02/15] bvec: fix the include guards for bvec.h
Date:   Tue, 27 Jul 2021 07:56:33 +0200
Message-Id: <20210727055646.118787-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

