Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B454690F0A
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfHQHst (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:48:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHQHst (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ue4DxZ3Zcm953fmDi3d/yBssR+oeAqE0fhi/AFIRRjo=; b=DM7NuBiCER2SyLvxOha1uLSIil
        1PRBmLa9XJWK/YNKwZtoOw7l3UAtPrh0PbNr8nDg4aEWUOtiIE9W9F5j9VzQ9a0jai2SYKjORpORS
        7L+vWUwP9OnZ/VORXpCk0J7aCzu55jlqSh44R5ZKWxDE4jYe1uWRAFis6qOujjCoDURz3XPjFxaas
        NcPbqHlgXn56Y9LkzwNAkKZoCpsdA8sWwhfReey2wA/MI+BklRfCEeoucA/997Jj4dN0FKSD2vsQD
        fOjLhPgDK2SvhnykD1XqOCO1w1jvXAblSZzEnpQ2CK6jMogltxlTPf8T7Grk5NjquoO5ldoAwaY6a
        WkLSmmRg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytS6-00050P-Gn; Sat, 17 Aug 2019 07:48:43 +0000
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
Subject: [PATCH 11/26] parisc: remove __ioremap
Date:   Sat, 17 Aug 2019 09:32:38 +0200
Message-Id: <20190817073253.27819-12-hch@lst.de>
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

__ioremap is always called with the _PAGE_NO_CACHE, so fold the whole
thing and rename it to ioremap.  This allows allows to remove the
special EISA quirk to force _PAGE_NO_CACHE.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/io.h | 11 +----------
 arch/parisc/mm/ioremap.c     | 16 +++-------------
 2 files changed, 4 insertions(+), 23 deletions(-)

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
index 92a9b5f12f98..fe65e27f882b 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -25,23 +25,13 @@
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	void __iomem *addr;
 	struct vm_struct *area;
 	unsigned long offset, last_addr;
 	pgprot_t pgprot;
 
-#ifdef CONFIG_EISA
-	unsigned long end = phys_addr + size - 1;
-	/* Support EISA addresses */
-	if ((phys_addr >= 0x00080000 && end < 0x000fffff) ||
-	    (phys_addr >= 0x00500000 && end < 0x03bfffff)) {
-		phys_addr |= F_EXTEND(0xfc000000);
-		flags |= _PAGE_NO_CACHE;
-	}
-#endif
-
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
@@ -65,7 +55,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
 	}
 
 	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
-			  _PAGE_ACCESSED | flags);
+			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
 
 	/*
 	 * Mappings have to be page-aligned
@@ -90,7 +80,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
 
 	return (void __iomem *) (offset + (char __iomem *)addr);
 }
-EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap);
 
 void iounmap(const volatile void __iomem *addr)
 {
-- 
2.20.1

