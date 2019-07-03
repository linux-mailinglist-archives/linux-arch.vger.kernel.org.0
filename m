Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE35E3BA
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCMYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 08:24:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCMYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2019 08:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tV5Q9vU+tNXeMlXcZgsSk1/vWrS+XQOTNkGpzgJ8SaM=; b=GRizeqOIeAVt/poyWWniKCrW9O
        HQDXXZypve6C0K/gMwtK2UXRbImtD+Q5eL9fUTqoplsTqLQZiT6ZsuJ2eLIVAet2qqxjswXYIGEgU
        bUvEEeuTnOACbzDbhuCvRQuHl6g5DrwoYXkLgBOS3JpSvaayVxZ7ZrXbLAg7WAG3YAZihaHKGxnrk
        xYoDO3xz5xIkkvkyznXrdBMrcu520YDwpBYHu/V7PXekqLAUx+e6fLDLAT83R+ULpNO3EQa+/ukes
        AmAraVq9Wtf1Qunn8OCKA6AO/t3oiMA93AQDiFv7xC/3t9fwx4Jm1lgNDbqA9TCJTXfkDdmeoE8mn
        qLv1k1jQ==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hieIq-0002G1-4b; Wed, 03 Jul 2019 12:24:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: stub out all of swapops.h for !CONFIG_MMU
Date:   Wed,  3 Jul 2019 05:23:59 -0700
Message-Id: <20190703122359.18200-4-hch@lst.de>
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

The whole header file deals with swap entries and PTEs, none of which
can exist for nommu builds.  The current nommu ports have lots of
stubs to allow the inline functions in swapops.h to compile, but
as none of this functionality is actually used there is no point
in even providing it.  This way we don't have to provide the stubs
for the upcoming RISC-V nommu port, and can eventually remove it
from the existing ports.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swapops.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 4d961668e5fc..b02922556846 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -6,6 +6,8 @@
 #include <linux/bug.h>
 #include <linux/mm_types.h>
 
+#ifdef CONFIG_MMU
+
 /*
  * swapcache pages are stored in the swapper_space radix tree.  We want to
  * get good packing density in that tree, so the index should be dense in
@@ -50,13 +52,11 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-#ifdef CONFIG_MMU
 /* check whether a pte points to a swap entry */
 static inline int is_swap_pte(pte_t pte)
 {
 	return !pte_none(pte) && !pte_present(pte);
 }
-#endif
 
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
@@ -375,4 +375,5 @@ static inline int non_swap_entry(swp_entry_t entry)
 }
 #endif
 
+#endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
-- 
2.20.1

