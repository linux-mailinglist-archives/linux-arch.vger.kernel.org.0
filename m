Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379FBE8111
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfJ2GuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:50:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfJ2Gtl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lil/5cEkB/ZCAm17l4nkkVLk0wR2AVyhy52WWrhy+jc=; b=Clics5wmuny/QEVuzK+aLMTOHC
        xTR47+4t2hf+1EL495L6YDe2b1bhdP2iL2gZ6So1eoyjBGv+fWKioKrNZ+joIE9YDNAhIoBqhIJoi
        XJ+GZQQkkW6/u9H/uxnRQLDas1LQVVmjfceQ61NizDuHN7qgdfoAila7LmFnD1GSeK8q7CDNVsaro
        qdmuqt8Ax+kf//nvUvplkBw2rchRE6tY6patRUBc1IqsOxnMpWma+vkuGWVkwZPtQum+bruxilmgv
        Zoobbdxr0L6prRHNcrvRjOVo8c0Mka/S4Qmt2JTjQqeGjXFNAZV6TXXwbGTxEsqIWqrv0MwCkiNky
        s6Q5C5uQ==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJj-00040a-QU; Tue, 29 Oct 2019 06:49:24 +0000
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
Subject: [PATCH 15/21] nios2: remove __iounmap
Date:   Tue, 29 Oct 2019 07:48:28 +0100
Message-Id: <20191029064834.23438-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029064834.23438-1-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No need to indirect iounmap for nios2.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nios2/include/asm/io.h | 7 +------
 arch/nios2/mm/ioremap.c     | 6 +++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
index d108937c321e..746853ac7d8d 100644
--- a/arch/nios2/include/asm/io.h
+++ b/arch/nios2/include/asm/io.h
@@ -26,12 +26,7 @@
 #define writel_relaxed(x, addr)	writel(x, addr)
 
 void __iomem *ioremap(unsigned long physaddr, unsigned long size);
-extern void __iounmap(void __iomem *addr);
-
-static inline void iounmap(void __iomem *addr)
-{
-	__iounmap(addr);
-}
+void iounmap(void __iomem *addr);
 
 /* Pages to physical address... */
 #define page_to_phys(page)	virt_to_phys(page_to_virt(page))
diff --git a/arch/nios2/mm/ioremap.c b/arch/nios2/mm/ioremap.c
index 7a1a27f3daa3..b56af759dcdf 100644
--- a/arch/nios2/mm/ioremap.c
+++ b/arch/nios2/mm/ioremap.c
@@ -157,11 +157,11 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 EXPORT_SYMBOL(ioremap);
 
 /*
- * __iounmap unmaps nearly everything, so be careful
+ * iounmap unmaps nearly everything, so be careful
  * it doesn't free currently pointer/page tables anymore but it
  * wasn't used anyway and might be added later.
  */
-void __iounmap(void __iomem *addr)
+void iounmap(void __iomem *addr)
 {
 	struct vm_struct *p;
 
@@ -173,4 +173,4 @@ void __iounmap(void __iomem *addr)
 		pr_err("iounmap: bad address %p\n", addr);
 	kfree(p);
 }
-EXPORT_SYMBOL(__iounmap);
+EXPORT_SYMBOL(iounmap);
-- 
2.20.1

