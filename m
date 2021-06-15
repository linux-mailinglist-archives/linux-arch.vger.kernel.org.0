Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085093A7F38
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhFON3I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhFON3G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:29:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5BFC061574;
        Tue, 15 Jun 2021 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1XxTqLx/vs09xzF7xNS0VaIj4xYUndutT8UPrg8vDg4=; b=aHNcz6QEz20YOXyOoU788juHt1
        IkccSwV0j1nB21d81HyU0cuTXMYo6yT2Tm6EmevigmjufOVssEY37tY4G3ouYxbe3QShzMra37xjf
        IUDN06H7tPPoDhOoGU5B42AD+xJvbPX20HIU1IKaBTENjsdGnCFhQ1Aqgcamea/L91UqkS9DlcJvX
        n+q7B93TQ5lJ/MHmzpA4Q7zastPvPPcLFZDMAT0Ayk/KokeZxDQkQl8EMFUtp2ZQJtcpiIQKb/Rwm
        dJlvK0U0C6HRrhC+J0afBlftZDWNDR4eQEMoiE4YAuzdnm8PTCIiD1boi6NQsvAsY68EJjlJr9zfr
        xFCT6UmQ==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt94Z-006nvL-Mz; Tue, 15 Jun 2021 13:25:50 +0000
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
Subject: [PATCH 03/18] mm: use kmap_local_page in memzero_page
Date:   Tue, 15 Jun 2021 15:24:41 +0200
Message-Id: <20210615132456.753241-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No need for kmap_atomic here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d0497c0daf80..d3df0e2db44f 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -338,9 +338,9 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 
 static inline void memzero_page(struct page *page, size_t offset, size_t len)
 {
-	char *addr = kmap_atomic(page);
+	char *addr = kmap_local_page(page);
 	memset(addr + offset, 0, len);
-	kunmap_atomic(addr);
+	kunmap_local_dirty(page, addr);
 }
 
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.30.2

