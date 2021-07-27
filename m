Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165BA3D6EF5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhG0GOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhG0GOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:14:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34891C061757;
        Mon, 26 Jul 2021 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KvHz1dLkYC5ZUL2hHb03Qg2DemCG1Z6Zzn1GTcFQUBY=; b=a+yu9sy6PghFftaPoTKkhmBu5/
        CfARq0842a7BTQyHfBU+z1RySnyknYjyRWxNB6+WZg0C2IdtY2Djud+04PneuVbafmTMjwkNd8BZw
        fxUp2VRNv8jX2RIrAkPFWMABFV66k/VJ6J4TcypvaiWHLnIrK7Zusi4qUINkQRTrlWKxW0AslG8sx
        7+Z5pLD8ZSMtmFxXIdj9GTvQYjcSzuWeZYzLsInOrs2xf+Nr6v0pXeQu7ABSLSKa8R1dCjDkyka93
        bxhkUhXOjLACoaqhfaQRJjp0fa4vK44AbnRzLyYZG6r7oN0J0AhKSWBfPgzWADCDIPSO2TCZKkDDW
        y9LKYvVQ==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GHj-00Ej6t-Dn; Tue, 27 Jul 2021 06:10:20 +0000
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
Subject: [PATCH 09/15] block: remove bvec_kmap_irq and bvec_kunmap_irq
Date:   Tue, 27 Jul 2021 07:56:40 +0200
Message-Id: <20210727055646.118787-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These two helpers are entirely unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/bio.h | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2203b686e1f0..7b5f65a81f2b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -5,7 +5,6 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
-#include <linux/highmem.h>
 #include <linux/mempool.h>
 #include <linux/ioprio.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
@@ -519,47 +518,6 @@ static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
-#ifdef CONFIG_HIGHMEM
-/*
- * remember never ever reenable interrupts between a bvec_kmap_irq and
- * bvec_kunmap_irq!
- */
-static inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
-{
-	unsigned long addr;
-
-	/*
-	 * might not be a highmem page, but the preempt/irq count
-	 * balancing is a lot nicer this way
-	 */
-	local_irq_save(*flags);
-	addr = (unsigned long) kmap_atomic(bvec->bv_page);
-
-	BUG_ON(addr & ~PAGE_MASK);
-
-	return (char *) addr + bvec->bv_offset;
-}
-
-static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
-{
-	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
-
-	kunmap_atomic((void *) ptr);
-	local_irq_restore(*flags);
-}
-
-#else
-static inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
-{
-	return page_address(bvec->bv_page) + bvec->bv_offset;
-}
-
-static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
-{
-	*flags = 0;
-}
-#endif
-
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
-- 
2.30.2

