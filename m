Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5743BDB3F1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440828AbfJQRqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 13:46:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfJQRqg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 13:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FX04uJGNdq/Yp5y2MJBzjZbPxUQfO+iCaj0twVF6zA4=; b=Hpof5+PgCEN69oEsWdFN1H2LS4
        exyt1cWF9c2ijgagC2J3+PBaBiaVIUbCA3O+3PoKcyUOXgA921+H2wQ2bdIi7W8FtYuTF5yY0FVrT
        4RZQ0CPQ3Je2a0MLuAYWjtzdnM+sx8W9l3gpha6FNhPatSkF2JDrLAljZfqyH8H+2idZU341lObe2
        7cSRfey1zSYpkrub7JjcpxpWWzxRoxSs0TWTdCrk+MUUkpsGnS70V6bneX1eodx2Mq9o1NxbphmAN
        m7NcvUJ3c7eHZT1uft9rs7OveIsuZodzWGjDPnV39m9gIXALdwW6wahActtOsDjdetmaP7grbP2fe
        0W/jqNuw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9ql-0005fL-Vc; Thu, 17 Oct 2019 17:46:12 +0000
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
Subject: [PATCH 06/21] nios2: remove __ioremap
Date:   Thu, 17 Oct 2019 19:45:39 +0200
Message-Id: <20191017174554.29840-7-hch@lst.de>
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

The cacheflag argument to __ioremap is always 0, so just implement
ioremap directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nios2/include/asm/io.h | 20 ++++----------------
 arch/nios2/mm/ioremap.c     | 17 +++--------------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
index 9010243077ab..74ab34aa6731 100644
--- a/arch/nios2/include/asm/io.h
+++ b/arch/nios2/include/asm/io.h
@@ -25,29 +25,17 @@
 #define writew_relaxed(x, addr)	writew(x, addr)
 #define writel_relaxed(x, addr)	writel(x, addr)
 
-extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
-			unsigned long cacheflag);
+void __iomem *ioremap(unsigned long physaddr, unsigned long size);
 extern void __iounmap(void __iomem *addr);
 
-static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
-{
-	return __ioremap(physaddr, size, 0);
-}
-
-static inline void __iomem *ioremap_nocache(unsigned long physaddr,
-						unsigned long size)
-{
-	return __ioremap(physaddr, size, 0);
-}
-
 static inline void iounmap(void __iomem *addr)
 {
 	__iounmap(addr);
 }
 
-#define ioremap_nocache ioremap_nocache
-#define ioremap_wc ioremap_nocache
-#define ioremap_wt ioremap_nocache
+#define ioremap_nocache ioremap
+#define ioremap_wc ioremap
+#define ioremap_wt ioremap
 
 /* Pages to physical address... */
 #define page_to_phys(page)	virt_to_phys(page_to_virt(page))
diff --git a/arch/nios2/mm/ioremap.c b/arch/nios2/mm/ioremap.c
index 3a28177a01eb..7a1a27f3daa3 100644
--- a/arch/nios2/mm/ioremap.c
+++ b/arch/nios2/mm/ioremap.c
@@ -112,8 +112,7 @@ static int remap_area_pages(unsigned long address, unsigned long phys_addr,
 /*
  * Map some physical address range into the kernel address space.
  */
-void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
-			unsigned long cacheflag)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	struct vm_struct *area;
 	unsigned long offset;
@@ -139,15 +138,6 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 				return NULL;
 	}
 
-	/*
-	 * Map uncached objects in the low part of address space to
-	 * CONFIG_NIOS2_IO_REGION_BASE
-	 */
-	if (IS_MAPPABLE_UNCACHEABLE(phys_addr) &&
-	    IS_MAPPABLE_UNCACHEABLE(last_addr) &&
-	    !(cacheflag & _PAGE_CACHED))
-		return (void __iomem *)(CONFIG_NIOS2_IO_REGION_BASE + phys_addr);
-
 	/* Mappings have to be page-aligned */
 	offset = phys_addr & ~PAGE_MASK;
 	phys_addr &= PAGE_MASK;
@@ -158,14 +148,13 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 	if (!area)
 		return NULL;
 	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size,
-		cacheflag)) {
+	if (remap_area_pages((unsigned long) addr, phys_addr, size, 0)) {
 		vunmap(addr);
 		return NULL;
 	}
 	return (void __iomem *) (offset + (char *)addr);
 }
-EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap);
 
 /*
  * __iounmap unmaps nearly everything, so be careful
-- 
2.20.1

