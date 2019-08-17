Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC790E1E
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQHqR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:46:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQHqR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PWKWAT+XF1ezmZcHb9DEi10XQA0jRcT+1Qeu2CvZDyI=; b=LxII4lrRlL1J1E6Hl6GfDHU+ci
        VcJnwcQ5TO6+YXCzQYGVXfleFfTjr8kvstgt7Nd/klSB0ZR2UsSDCLManVZBOIsC7JP5yhP1hQwLj
        xbt6UdZYRND916SxFh/gix8OY7mjJ38Yuw+66mRiygqaEWsAVbb6trg0yGE6Ge3yCTex1SYbx11+I
        Rb1Clk+WoY/DxzTxX6tiXNUumTtVhIT2FgWUo430BbPXkLlr6cRLBvZOyrGt9D0+xfnJZGUk04HE3
        0xTi4PYO05qKScEcFflzmgdk4/+cDqKU9wYzhZNHCQtvoQFFfDWAaoWTF90iR7aoDPSjhGJZzJCLq
        LfReqbPQ==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytPg-0003dW-GT; Sat, 17 Aug 2019 07:46:12 +0000
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
Subject: [PATCH 05/26] openrisc: map as uncached in ioremap
Date:   Sat, 17 Aug 2019 09:32:32 +0200
Message-Id: <20190817073253.27819-6-hch@lst.de>
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

Openrisc is the only architecture not mapping ioremap as uncached,
which has been the default since the Linux 2.6.x days.  Switch it
over to implement uncached semantics by default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/io.h      | 20 +++-----------------
 arch/openrisc/include/asm/pgtable.h |  2 +-
 arch/openrisc/mm/ioremap.c          |  8 ++++----
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 06a710757789..5b81a96ab85e 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -25,25 +25,11 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap_nocache ioremap_nocache
+#define ioremap_nocache ioremap
 #include <asm-generic/io.h>
 #include <asm/pgtable.h>
 
-extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
-				pgprot_t prot);
-
-static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
-{
-	return __ioremap(offset, size, PAGE_KERNEL);
-}
-
-/* #define _PAGE_CI       0x002 */
-static inline void __iomem *ioremap_nocache(phys_addr_t offset,
-					     unsigned long size)
-{
-	return __ioremap(offset, size,
-			 __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI));
-}
-
+void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 extern void iounmap(void *addr);
+
 #endif
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 497fd908a4c4..2fe9ff5b5d6f 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -97,7 +97,7 @@ extern void paging_init(void);
 /* Define some higher level generic page attributes.
  *
  * If you change _PAGE_CI definition be sure to change it in
- * io.h for ioremap_nocache() too.
+ * io.h for ioremap() too.
  */
 
 /*
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index e0c551ca0891..8f8e97f7eac9 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -34,8 +34,7 @@ static unsigned int fixmaps_used __initdata;
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-void __iomem *__ref
-__ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
+void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 {
 	phys_addr_t p;
 	unsigned long v;
@@ -66,7 +65,8 @@ __ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
 		fixmaps_used += (size >> PAGE_SHIFT);
 	}
 
-	if (ioremap_page_range(v, v + size, p, prot)) {
+	if (ioremap_page_range(v, v + size, p,
+			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
 		if (likely(mem_init_done))
 			vfree(area->addr);
 		else
@@ -76,7 +76,7 @@ __ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
 
 	return (void __iomem *)(offset + (char *)v);
 }
-EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap);
 
 void iounmap(void *addr)
 {
-- 
2.20.1

