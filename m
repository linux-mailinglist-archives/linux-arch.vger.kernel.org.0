Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B590EB7
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHQHtl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:49:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfHQHtj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=36yragx/3TbEiZcx34O4KqBbL0NIwU1sXNolaAKeYnk=; b=HVAE0lQjT/hJkbpzzB2tZjROSK
        kiU7DYUqDEPZWtrV7bt1KLsAdvJGepTecyMV5qhyvtY6nsG3tXArCFRjSiD4/EAnGfygnvJ1oiWtq
        g/bd4FRz7MYl+Y89cyJAnIbKevt7s10LRbdlfGIYD3DRClSRnUOrs+qL8iCZZwVG3BPJerF++du9R
        I6dzzivPfOCtj97rSrX4Xf36xrk7WdjyOMerbCjU0Gff2qujhRRybGUBGiP1h9QCNgbO7MbROPSjy
        GADYa1qfgA9dnzqlPXfwpfOQXtzsHHsTsIvIiXtaWuydXu4ppeSMzRno9Q8sKua9m9vCoDHHUMTSl
        4XXanenw==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytSv-0005lu-BA; Sat, 17 Aug 2019 07:49:33 +0000
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
Subject: [PATCH 26/26] nds32: use generic ioremap
Date:   Sat, 17 Aug 2019 09:32:53 +0200
Message-Id: <20190817073253.27819-27-hch@lst.de>
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

Use the generic ioremap_prot and iounmap helpers.

Note that the io.h include in pgtable.h had to be removed to not create
an include loop.  As far as I can tell there was no need for it to
start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/Kconfig               |  1 +
 arch/nds32/include/asm/io.h      |  3 +-
 arch/nds32/include/asm/pgtable.h |  4 ++-
 arch/nds32/mm/Makefile           |  3 +-
 arch/nds32/mm/ioremap.c          | 62 --------------------------------
 5 files changed, 6 insertions(+), 67 deletions(-)
 delete mode 100644 arch/nds32/mm/ioremap.c

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index fbd68329737f..12c06a833b7c 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -20,6 +20,7 @@ config NDS32
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
+	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_CMPDI2
diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index fb0e8a24c7af..e57378d04006 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -6,8 +6,6 @@
 
 #include <linux/types.h>
 
-void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
-extern void iounmap(volatile void __iomem *addr);
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
@@ -80,6 +78,7 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 #define writeb(v,c)	({ __iowmb(); writeb_relaxed((v),(c)); })
 #define writew(v,c)	({ __iowmb(); writew_relaxed((v),(c)); })
 #define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
+
 #include <asm-generic/io.h>
 
 #endif /* __ASM_NDS32_IO_H */
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index c70cc56bec09..9c5efa4f1f96 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -12,7 +12,6 @@
 #include <asm/nds32.h>
 #ifndef __ASSEMBLY__
 #include <asm/fixmap.h>
-#include <asm/io.h>
 #include <nds32_intrinsic.h>
 #endif
 
@@ -130,6 +129,9 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define _PAGE_CACHE		_PAGE_C_MEM_WB
 #endif
 
+#define _PAGE_IOREMAP \
+	(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_G | _PAGE_C_DEV)
+
 /*
  * + Level 1 descriptor (PMD)
  */
diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index bd360e4583b5..897ecaf5cf54 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y				:= extable.o tlb.o \
-				   fault.o init.o ioremap.o mmap.o \
+obj-y				:= extable.o tlb.o fault.o init.o mmap.o \
                                    mm-nds32.o cacheflush.o proc.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
diff --git a/arch/nds32/mm/ioremap.c b/arch/nds32/mm/ioremap.c
deleted file mode 100644
index 690140bb23a2..000000000000
--- a/arch/nds32/mm/ioremap.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/vmalloc.h>
-#include <linux/io.h>
-#include <linux/mm.h>
-#include <asm/pgtable.h>
-
-void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
-
-static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
-				      void *caller)
-{
-	struct vm_struct *area;
-	unsigned long addr, offset, last_addr;
-	pgprot_t prot;
-
-	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
-		return NULL;
-
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-	if (!area)
-		return NULL;
-
-	area->phys_addr = phys_addr;
-	addr = (unsigned long)area->addr;
-	prot = __pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D |
-			_PAGE_G | _PAGE_C_DEV);
-	if (ioremap_page_range(addr, addr + size, phys_addr, prot)) {
-		vunmap((void *)addr);
-		return NULL;
-	}
-	return (__force void __iomem *)(offset + (char *)addr);
-
-}
-
-void __iomem *ioremap(phys_addr_t phys_addr, size_t size)
-{
-	return __ioremap_caller(phys_addr, size,
-				__builtin_return_address(0));
-}
-
-EXPORT_SYMBOL(ioremap);
-
-void iounmap(volatile void __iomem * addr)
-{
-	vunmap((void *)(PAGE_MASK & (unsigned long)addr));
-}
-
-EXPORT_SYMBOL(iounmap);
-- 
2.20.1

