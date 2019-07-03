Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD835E3C6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGCMYO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 08:24:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGCMYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2019 08:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZFBwbC42pF4/ydEOSJ4y75ZnrJb+ZBbMm/qFm7Ht5k0=; b=WEx9srRwWmoqUX7+8/383RgnoA
        JkY9g5iVy2AsFb7crvNngMC9nYxMWlUtCqrN52g21njC+8+Tbwyzj1th2SQC/9Vb68MRJaCdOkIt+
        58E/1wkcRfXTf12JbOQH5edlHDRzkPzOdWiPDu6LqX4AkXipzufsMFiDBgbuc5/+yT39EqLsPEiz/
        uLZmWd5DLgCSDafOJKP7V+kfgpBt8Bf/EZp7hk5snHLffR15fGDXOoYe9ucOHehAAACNgS/uVWofT
        BZdjTpWBb0Lf/XIoTSKMXWgP8D7/gzf6fwicrUI8rZ+tRDhawJFWNO649IsRvKQ7DbhoZ8xN0Qk8V
        HnoKguMg==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hieIp-0002Fv-TN; Wed, 03 Jul 2019 12:23:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 2/3] mm: provide a print_vma_addr stub for !CONFIG_MMU
Date:   Wed,  3 Jul 2019 05:23:58 -0700
Message-Id: <20190703122359.18200-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703122359.18200-1-hch@lst.de>
References: <20190703122359.18200-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd0b5f4e1e45..69843ee0c5f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2756,7 +2756,13 @@ extern int randomize_va_space;
 #endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
+#ifdef CONFIG_MMU
 void print_vma_addr(char *prefix, unsigned long rip);
+#else
+static inline void print_vma_addr(char *prefix, unsigned long rip)
+{
+}
+#endif
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
-- 
2.20.1

