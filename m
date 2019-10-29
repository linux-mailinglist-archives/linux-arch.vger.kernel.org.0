Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079BFE8162
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJ2Gui (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:50:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbfJ2Gt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mUh9IJAtF893lJPSE9FNWl8JOGrC9DM2GbUNi0MOrgM=; b=Bcl34FqVmaBqqVI+du9/t1WBwh
        CnzH8QBgZg43YRJX6SYMEy0FbuLTrJ8+3/NWvTgMupUaIuJ7P3zNGWWQ4bSlbjIwYDvIWCqNMpGof
        uZZtftxof58J8BHmIqNYRqTaUBbNEVKZoAqXwqOjzDto9U1RdvbBJij24rkM/WXwtFX3QDXyo4Fgj
        ncAWjftWy4PevCZOGMl30oVTtmLj1G9OghB/uVP53D05WZNSyYbLeWmjUS4gYeoJ0XHCvfX2KtDEu
        BzYR5CBRz3VW76BOSgo/3DULK/PzlAzGELewEKvcNCXMckmOoUylJMTMwelypG2aE5icqyYG6Q/aG
        Rkiziyag==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJQ-0003jA-B4; Tue, 29 Oct 2019 06:49:04 +0000
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
Subject: [PATCH 09/21] xtensa: clean up ioremap
Date:   Tue, 29 Oct 2019 07:48:22 +0100
Message-Id: <20191029064834.23438-10-hch@lst.de>
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

Use ioremap as the main implemented function, and defined
ioremap_nocache to it as a deprecated alias.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/io.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 988e08530a5c..441fb56926a7 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -32,8 +32,7 @@ void xtensa_iounmap(volatile void __iomem *addr);
 /*
  * Return the virtual address for the specified bus memory.
  */
-static inline void __iomem *ioremap_nocache(unsigned long offset,
-		unsigned long size)
+static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 {
 	if (offset >= XCHAL_KIO_PADDR
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
@@ -52,15 +51,10 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
 		return xtensa_ioremap_cache(offset, size);
 }
 #define ioremap_cache ioremap_cache
-#define ioremap_nocache ioremap_nocache
-
-#define ioremap_wc ioremap_nocache
-#define ioremap_wt ioremap_nocache
 
-static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
-{
-	return ioremap_nocache(offset, size);
-}
+#define ioremap_nocache ioremap
+#define ioremap_wc ioremap
+#define ioremap_wt ioremap
 
 static inline void iounmap(volatile void __iomem *addr)
 {
-- 
2.20.1

