Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D150390E2D
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHQHsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfHQHsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=juqTaRJLAUN8sACpA/ifAvJQqQFz7PwWUU79IVC7rTQ=; b=tE4HzSwuGmt2yt2L5TvlruIjuj
        t0P27yzYCepN/bZo5j5YE+jN4n4reTCWEHjt3fZIGDM/kcK2w4Z02+rNlH4gJQJCeoXVmnDIWcQcm
        NzYNgxNqTdiZAN/dc3AnRFo23b19A8TNkgYMp3ZeydNHcKieL1YYOVghVgZTFH4LUAKE+7Qy+vOMs
        TSieZ/dvv6XzmazukAeD0f34Pl3tZYVlzYuZDc4AHIDWxQBOwcO4rt3zGq9EnYmBrme0eo4WTS4iV
        Qp/C1+7eZwiDbZhaSHj/3CgSZUD3G5AEJWC1E7d2VdIfO4AloobrqCvQLAw0w8hQfYZylj+9cZNR5
        CCRg+ACA==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytRp-0004mg-GT; Sat, 17 Aug 2019 07:48:25 +0000
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
Subject: [PATCH 06/26] ia64: rename ioremap_nocache to ioremap_uc
Date:   Sat, 17 Aug 2019 09:32:33 +0200
Message-Id: <20190817073253.27819-7-hch@lst.de>
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

On ia64 ioremap_nocache fails if attributs don't match.  Not other
architectures does this, and we plan to get rid of ioremap_nocache.
So get rid of the special semantics and define ioremap_nocache in
terms of ioremap as no portable driver could rely on the behavior
anyway.

However x86 implements ioremap_uc with a in a similar way as the ia64
version of ioremap_nocache, so implement that instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/io.h | 6 +++---
 arch/ia64/mm/ioremap.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index a511d62d447a..febd2c6ea0b4 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -412,16 +412,16 @@ __writeq (unsigned long val, volatile void __iomem *addr)
 # ifdef __KERNEL__
 
 extern void __iomem * ioremap(unsigned long offset, unsigned long size);
-extern void __iomem * ioremap_nocache (unsigned long offset, unsigned long size);
+extern void __iomem * ioremap_uc(unsigned long offset, unsigned long size);
 extern void iounmap (volatile void __iomem *addr);
 static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
 {
 	return ioremap(phys_addr, size);
 }
 #define ioremap ioremap
-#define ioremap_nocache ioremap_nocache
+#define ioremap_nocache ioremap
 #define ioremap_cache ioremap_cache
-#define ioremap_uc ioremap_nocache
+#define ioremap_uc ioremap_uc
 #define iounmap iounmap
 
 /*
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 0c0de2c4ec69..a09cfa064536 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -99,14 +99,14 @@ ioremap (unsigned long phys_addr, unsigned long size)
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
-ioremap_nocache (unsigned long phys_addr, unsigned long size)
+ioremap_uc(unsigned long phys_addr, unsigned long size)
 {
 	if (kern_mem_attribute(phys_addr, size) & EFI_MEMORY_WB)
 		return NULL;
 
 	return __ioremap_uc(phys_addr);
 }
-EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(ioremap_uc);
 
 void
 early_iounmap (volatile void __iomem *addr, unsigned long size)
-- 
2.20.1

