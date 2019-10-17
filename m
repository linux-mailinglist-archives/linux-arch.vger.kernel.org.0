Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B670DB3BE
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbfJQRqF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 13:46:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440688AbfJQRqF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 13:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LVEPu9/s1693dWfYlkD3Fqnhr0FkMtGhuRv/aJrvhOg=; b=RjRieJd82TpPK9jRpIQFlwUQn8
        rXPon9JuYUTZmAL1n9JR2nFjDASe7YxIYzEgRNyPtsyXMNApyap2c3pldQe89O0UfWLoJ4sAbFUYE
        yZFJqWKO35Vs7y7rWCsospb60FEjg9xxZyW/mCPccwxfH7qilMgMbY/A3IQRzjr/Ba13SUirLL73V
        JM+jcEr6RD+KtbH1A7hv86+6wW1A7zez/feRzYtKgaVDp8Hp8W+h2pUq62Cx0Q/DeJXyVj+ee6eQH
        2FtyfR8VKesOj1hdWsKfZ5DX/5o1uzAMjExm0qBhF/Fce5kYtW4LLLmh36+5rSFLWUWNavpjBNHCa
        sRP3HyLg==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9qb-0005Rn-DA; Thu, 17 Oct 2019 17:46:01 +0000
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
Subject: [PATCH 02/21] unicore32: remove ioremap_cached
Date:   Thu, 17 Oct 2019 19:45:35 +0200
Message-Id: <20191017174554.29840-3-hch@lst.de>
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

No users of ioremap_cached are left, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/unicore32/include/asm/io.h | 4 +---
 arch/unicore32/mm/ioremap.c     | 8 --------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/unicore32/include/asm/io.h b/arch/unicore32/include/asm/io.h
index c71aa4b95996..4b460e01acfa 100644
--- a/arch/unicore32/include/asm/io.h
+++ b/arch/unicore32/include/asm/io.h
@@ -18,10 +18,9 @@
 #include <asm-generic/io.h>
 
 /*
- * __uc32_ioremap and __uc32_ioremap_cached takes CPU physical address.
+ * __uc32_ioremap takes CPU physical address.
  */
 extern void __iomem *__uc32_ioremap(unsigned long, size_t);
-extern void __iomem *__uc32_ioremap_cached(unsigned long, size_t);
 extern void __uc32_iounmap(volatile void __iomem *addr);
 
 /*
@@ -32,7 +31,6 @@ extern void __uc32_iounmap(volatile void __iomem *addr);
  *
  */
 #define ioremap(cookie, size)		__uc32_ioremap(cookie, size)
-#define ioremap_cached(cookie, size)	__uc32_ioremap_cached(cookie, size)
 #define ioremap_nocache(cookie, size)	__uc32_ioremap(cookie, size)
 #define iounmap(cookie)			__uc32_iounmap(cookie)
 
diff --git a/arch/unicore32/mm/ioremap.c b/arch/unicore32/mm/ioremap.c
index cf6d656f240c..46a64bd6156a 100644
--- a/arch/unicore32/mm/ioremap.c
+++ b/arch/unicore32/mm/ioremap.c
@@ -220,14 +220,6 @@ __uc32_ioremap(unsigned long phys_addr, size_t size)
 }
 EXPORT_SYMBOL(__uc32_ioremap);
 
-void __iomem *
-__uc32_ioremap_cached(unsigned long phys_addr, size_t size)
-{
-	return __uc32_ioremap_caller(phys_addr, size, MT_DEVICE_CACHED,
-			__builtin_return_address(0));
-}
-EXPORT_SYMBOL(__uc32_ioremap_cached);
-
 void __uc32_iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
-- 
2.20.1

