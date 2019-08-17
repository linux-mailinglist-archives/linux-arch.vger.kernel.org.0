Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6586390E0F
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHQHoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:44:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQHoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HVa1dlO13VGUAr1yg3sOZ4M4arLVOwQoi05nRfUMCMI=; b=UAFSW5+tlkDmNpbrqdSS4sPWLy
        /2BupHlqIZ500JsJdSVDcvzy7Sh/K5vJygbZlTzELSTKGEp3yT4+XJ3iOfbxplbmvdWRQcjrlsQAn
        7hIqWCaLM5pmdpqwtIshLmPD/nl9vfmrUCCky9UABOsdtl3s+NgW1R8yD7Afqyi6q5jgk+rvFx9fE
        Auk7jPGG5wy5dg6qkbZlRIKw9VqZG7f+V59MKY1OLtNF7OBEqqC+JkggYIUvpgR9DScsMLU3E7wKR
        NjBeVJdN8OZzUkfj5vK6aQY+cRsuY0ivzNOJ2l8iKvA7YPXtphclPGZwRLoZ9OzDwXuu6nTb7yix6
        HKYMj5Yg==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytNX-0001rF-8R; Sat, 17 Aug 2019 07:43:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/26] mips: remove ioremap_cachable
Date:   Sat, 17 Aug 2019 09:32:31 +0200
Message-Id: <20190817073253.27819-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just define ioremap_cache directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/io.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 97a280640daf..c02db986ddf5 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -262,11 +262,11 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
 #define ioremap_uc ioremap_nocache
 
 /*
- * ioremap_cachable -	map bus memory into CPU space
+ * ioremap_cache -	map bus memory into CPU space
  * @offset:	    bus address of the memory
  * @size:	    size of the resource to map
  *
- * ioremap_nocache performs a platform specific sequence of operations to
+ * ioremap_cache performs a platform specific sequence of operations to
  * make bus memory CPU accessible via the readb/readw/readl/writeb/
  * writew/writel functions and the other mmio helpers. The returned
  * address is not guaranteed to be usable directly as a virtual
@@ -276,9 +276,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  * the CPU.  Also enables full write-combining.	 Useful for some
  * memory-like regions on I/O busses.
  */
-#define ioremap_cachable(offset, size)					\
+#define ioremap_cache(offset, size)					\
 	__ioremap_mode((offset), (size), _page_cachable_default)
-#define ioremap_cache ioremap_cachable
 
 /*
  * ioremap_wc     -   map bus memory into CPU space
-- 
2.20.1

