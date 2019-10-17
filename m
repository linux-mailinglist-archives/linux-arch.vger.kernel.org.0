Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A40DB4A2
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfJQRsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 13:48:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437222AbfJQRqi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 13:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JoWYe6Vw3Po4m3FC1eS1aSF6GNt+BYWJoAwerG5jalc=; b=YOJSGNdHD2jVDmHKAZ5RVQSwZW
        I1+D9gXHmJYXOUcFNKj14k4yp812uQ1UfiHkLGmH5DQclsczuD17LZOXT/ejrv+Poj20UhvnzBo7D
        o43qFDc6T6LBz2k4Xk7M9LoI5DRgN17u1XapHnunkbJC3dNdaQNtFKt4OvOQtLWHb+hA8HjOM6GyQ
        Q9kQuspP8Kdi9QzusidafkjJCPbE3b1LdjEQY8/K0Faf807uNZwNt5L8ejhM6WndrO8ICRDvGxRDH
        MV5Ig+6MKj7bal5K7uxWLa4j33GEP4H+ZTVHakrbRWCxdNMbUAWbd3+B16stT3BEtwY1PG2Lhosaw
        b9lTecnQ==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9qo-0005hq-EV; Thu, 17 Oct 2019 17:46:14 +0000
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
Subject: [PATCH 07/21] parisc: remove __ioremap
Date:   Thu, 17 Oct 2019 19:45:40 +0200
Message-Id: <20191017174554.29840-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017174554.29840-1-hch@lst.de>
References: <20191017174554.29840-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

__ioremap is always called with the _PAGE_NO_CACHE, so fold the whole
thing and rename it to ioremap.  This allows allows to remove the
special EISA quirk to force _PAGE_NO_CACHE.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/io.h | 11 +----------
 arch/parisc/mm/ioremap.c     | 10 ++++------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 93d37010b375..46212b52c23e 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -127,16 +127,7 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 /*
  * The standard PCI ioremap interfaces
  */
-
-extern void __iomem * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
-
-/* Most machines react poorly to I/O-space being cacheable... Instead let's
- * define ioremap() in terms of ioremap_nocache().
- */
-static inline void __iomem * ioremap(unsigned long offset, unsigned long size)
-{
-	return __ioremap(offset, size, _PAGE_NO_CACHE);
-}
+void __iomem *ioremap(unsigned long offset, unsigned long size);
 #define ioremap_nocache(off, sz)	ioremap((off), (sz))
 #define ioremap_wc			ioremap_nocache
 #define ioremap_uc			ioremap_nocache
diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index f29f682352f0..6e7c005aa09b 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -25,7 +25,7 @@
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	void __iomem *addr;
 	struct vm_struct *area;
@@ -36,10 +36,8 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
 	unsigned long end = phys_addr + size - 1;
 	/* Support EISA addresses */
 	if ((phys_addr >= 0x00080000 && end < 0x000fffff) ||
-	    (phys_addr >= 0x00500000 && end < 0x03bfffff)) {
+	    (phys_addr >= 0x00500000 && end < 0x03bfffff))
 		phys_addr |= F_EXTEND(0xfc000000);
-		flags |= _PAGE_NO_CACHE;
-	}
 #endif
 
 	/* Don't allow wraparound or zero size */
@@ -65,7 +63,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
 	}
 
 	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
-			  _PAGE_ACCESSED | flags);
+			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
 
 	/*
 	 * Mappings have to be page-aligned
@@ -90,7 +88,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
 
 	return (void __iomem *) (offset + (char __iomem *)addr);
 }
-EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap);
 
 void iounmap(const volatile void __iomem *io_addr)
 {
-- 
2.20.1

