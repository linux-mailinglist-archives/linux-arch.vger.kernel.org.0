Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E24DB3E7
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436875AbfJQRqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 13:46:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfJQRqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 13:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZcYpG77DrI4zIeJSB2UM1Pr1UMrxQ6cFx59Cqt/5V3Q=; b=b9du5QRgW+WmDcQUheOwDZ7nov
        NQgC3ouXuEYzjC5Ahka0oGzf6OBZXNP/TIGQpgQJOmTH8DPD9apYROqFk209osC824xYnsBAZU5H2
        YI+mTl3djs9VFFa7ysvUctY4mn7EN/CAU5gMJviy52CRIX+80a2CnmS56H/5F8TDicrXBTl963fCJ
        ZUBW9YC7oJ3U7j2XVQh47GMwddnkjIfAE+xz/ydj1gQtWcBq+jxWbg3a5NmnwmlkbZXKgJcUVa1Hi
        clmCx4rzZaIa6eccsJBdO6G/hwBI7ZvD3J9sn6K6Z/YGz7gB3RxXJoMiRj6vSm+88Va4dk+ZSDmtT
        pMyHX9VQ==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9qg-0005ZM-EJ; Thu, 17 Oct 2019 17:46:06 +0000
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
Subject: [PATCH 04/21] hexagon: clean up ioremap
Date:   Thu, 17 Oct 2019 19:45:37 +0200
Message-Id: <20191017174554.29840-5-hch@lst.de>
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

Use ioremap as the main implemented function, and defined
ioremap_nocache to it as a deprecated alias.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/io.h       | 11 ++---------
 arch/hexagon/kernel/hexagon_ksyms.c |  2 +-
 arch/hexagon/mm/ioremap.c           |  2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index ba1a444d55b3..89537dc1cf97 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -171,16 +171,9 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-/*
- * Need an mtype somewhere in here, for cache type deals?
- * This is probably too long for an inline.
- */
-void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size);
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
+#define ioremap_nocache ioremap
 
-static inline void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
-{
-	return ioremap_nocache(phys_addr, size);
-}
 
 static inline void iounmap(volatile void __iomem *addr)
 {
diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index cf8974beb500..b3dbb472572e 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(__vmgetie);
 EXPORT_SYMBOL(__vmsetie);
 EXPORT_SYMBOL(__vmyield);
 EXPORT_SYMBOL(empty_zero_page);
-EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 
diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
index 77d8e1e69e9b..b103d83b5fbb 100644
--- a/arch/hexagon/mm/ioremap.c
+++ b/arch/hexagon/mm/ioremap.c
@@ -9,7 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 
-void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	unsigned long last_addr, addr;
 	unsigned long offset = phys_addr & ~PAGE_MASK;
-- 
2.20.1

