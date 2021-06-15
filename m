Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003B3A7F68
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhFON37 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhFON36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:29:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A2C061574;
        Tue, 15 Jun 2021 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VDFAq4RAyfQcvq7NcXCc5PqaLI7MmLBvTcVGlewKg1A=; b=s7YJ177kDcPbGM2WG8E+hJ1eLZ
        A1GJ//E9BY/h/KFsN/+xFtAt0xf/30EdK+nx0yjsgtcrBDojX9AN5RpjcSCtdMxjtx1wom3sFgkz+
        jRxU56885taXJpb3fzrHtO95l7X/Ha/D/RNf+W3SuXaqFKdEquI5QY44BCPkNT/Mu4EqVp4Vp4wNj
        D65VpSGqfI2RQOFGedk/fn2HZRpohCK/tqwtdvnvfyEoGZ2iXjmVRQWRbTTsLmkQ0HBvbRBhdd9C6
        94Pzz8/3dAoDT0LTvf9w7WwF0gajKYl/xdC/TPIYGTqpn52ZYVVfuS+JrLhG4XqMBJ3JNGq65TZbi
        0ZI+8hOQ==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt95X-006nz9-7r; Tue, 15 Jun 2021 13:26:53 +0000
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
Subject: [PATCH 06/18] bvec: add a bvec_kmap_local helper
Date:   Tue, 15 Jun 2021 15:24:44 +0200
Message-Id: <20210615132456.753241-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a helper to call kmap_local_page on a bvec.  There is no need for
an unmap helper given that kunmap_local accept any address in the mapped
page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/bvec.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 883faf5f1523..f8710af18eef 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -7,6 +7,7 @@
 #ifndef __LINUX_BVEC_H
 #define __LINUX_BVEC_H
 
+#include <linux/highmem.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/limits.h>
@@ -183,4 +184,16 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
+/**
+ * bvec_kmap_local - map a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ *
+ * Must be called on single-page bvecs only.  Call kunmap_local on the returned
+ * address to unmap.
+ */
+static inline void *bvec_kmap_local(struct bio_vec *bvec)
+{
+	return kmap_local_page(bvec->bv_page) + bvec->bv_offset;
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.30.2

