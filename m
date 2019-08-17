Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7483090F04
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfHQHs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:48:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHQHs6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5SkdqR1UsVqx+dJJilot2kBEqYF7QYLDxZka/Ck8fu0=; b=ZatyEcLA3WYyfZypu4HXO+dFNm
        ZecZgO5apqFzibglPmJ7Aq6EeaVqso2e4kB478BcOb4tAKVw17M/oTEjSjMVL7dwQD3YgWT+58ImX
        4pZZq14VE09Zqznm8ukqcGVlGsS5JoE/mj+dlCUOryDHBDXlOOzI2VrdlAg+bG3PKOkclWWm+lVH+
        UXouLZW6td8PI4EF4q9XGfBeGL8qDPs4C0GQL9aqrz19tYIkbDaKjcw9d9KlPGB0MxDV637M4mNzI
        c7oA+aq6uvk5skywOZ1+7PO/SEf6x+3Sp2a79FmUBB8USBI+dG24y2kR65y+bP+kbL1L7z5dzQi+A
        4b0jVOhA==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytSD-00055m-Im; Sat, 17 Aug 2019 07:48:50 +0000
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
Subject: [PATCH 13/26] xtensa: clean up ioremap
Date:   Sat, 17 Aug 2019 09:32:40 +0200
Message-Id: <20190817073253.27819-14-hch@lst.de>
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

Use ioremap as the main implemented function, and defined
ioremap_nocache to it as a deprecated alias.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/io.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index da3e783f896b..ffadc99c8601 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -31,8 +31,7 @@ void xtensa_iounmap(volatile void __iomem *addr);
 /*
  * Return the virtual address for the specified bus memory.
  */
-static inline void __iomem *ioremap_nocache(unsigned long offset,
-		unsigned long size)
+static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 {
 	if (offset >= XCHAL_KIO_PADDR
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
@@ -51,15 +50,10 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
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

