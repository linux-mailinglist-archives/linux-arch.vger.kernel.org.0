Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67F5DB43E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437173AbfJQRrV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 13:47:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503052AbfJQRrK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 13:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y+9+fF+2vSRO+kM640gbHAmaEAxFGX/M9O3TcjV73o0=; b=BXogae1PleCfPfmnuosA74leHs
        F4gcBAevVjtr18g98D6I5zH18pLoaXE0kHHKjkZIQkLXLQrfzOAiWzfJxLjILFWArCb8l0g49ZVDp
        EN4FenG2K8eamLeNKj2yT6sq7bqCckUtiNr6ov1Cn8zI5DCdErWlYWmy5sjTKQQ2hCpm3Td2rDfqH
        N0DoqW5ni1LuA3qVrJRdUHIWCueZviMRTqGcssA/MAiEaXOglSUSx1d/XwZlk3uIV3/SK4mcRHcR6
        m0TzotfU7qNROnfmcYDaqK7CQjTPBB6UE15bYh82RI7gVWaeG/ikLTmhym08QFs+2W4wqv1NN1SNZ
        vdMtshkA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9rR-0006Oi-4E; Thu, 17 Oct 2019 17:46:53 +0000
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
Subject: [PATCH 20/21] csky: remove ioremap_cache
Date:   Thu, 17 Oct 2019 19:45:53 +0200
Message-Id: <20191017174554.29840-21-hch@lst.de>
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

No driver that can be used on csky uses ioremap_cache, and this
interface has been deprecated in favor of memremap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/include/asm/io.h | 2 --
 arch/csky/mm/ioremap.c     | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index a4b9fb616faa..f572605d5ad5 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -36,13 +36,11 @@
 /*
  * I/O memory mapping functions.
  */
-extern void __iomem *ioremap_cache(phys_addr_t addr, size_t size);
 extern void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot);
 extern void iounmap(void *addr);
 
 #define ioremap(addr, size)		__ioremap((addr), (size), pgprot_noncached(PAGE_KERNEL))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), pgprot_writecombine(PAGE_KERNEL))
-#define ioremap_cache			ioremap_cache
 
 #include <asm-generic/io.h>
 
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index e13cd3497628..ae78256a56fd 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -44,13 +44,6 @@ void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
 }
 EXPORT_SYMBOL(__ioremap);
 
-void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
-{
-	return __ioremap_caller(phys_addr, size, PAGE_KERNEL,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_cache);
-
 void iounmap(void __iomem *addr)
 {
 	vunmap((void *)((unsigned long)addr & PAGE_MASK));
-- 
2.20.1

