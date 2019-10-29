Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB75FE8102
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfJ2GuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:50:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbfJ2GuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0G9VjTCDn1azePVEARZDWm3/hUf6+uTfkQZKCgB5wVo=; b=rJgXsU3DXKzNjWM4Yt1bNVKDIH
        Qfw9GjtZlieBmDiI4yRbbtb6Tt2IVIbE1nOgMvX08qE9q87ppZN2VEI5JHc6SCp3qiVTCAI6u4kg5
        eHAN7AglzO7nQU50FgdoGIsBwXgxkEW90qHyexs0dpg1m6vgkX/0EkhCW1/4qnydnCE0B091rlttG
        189APJUZlHIdLeOADqftAb2pmoh/3Ex28d5LjzrgpeQFzNzGP1tl3JNBLE3oewUHA/tgYu4B3nF+n
        JVtv+zFKm9r4bryMpjQN7HOA2FgzssZ/VHSzX5SyY95CvwCFQMkZp961u1EVlpKDFrpekuQzEn/C+
        wC89h25A==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLK3-0004Ik-1s; Tue, 29 Oct 2019 06:49:43 +0000
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
Subject: [PATCH 21/21] csky: use generic ioremap
Date:   Tue, 29 Oct 2019 07:48:34 +0100
Message-Id: <20191029064834.23438-22-hch@lst.de>
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

Use the generic ioremap_prot and iounmap helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/Kconfig               |  1 +
 arch/csky/include/asm/io.h      |  8 +++---
 arch/csky/include/asm/pgtable.h |  4 +++
 arch/csky/mm/ioremap.c          | 45 ---------------------------------
 4 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847b5f42..da09c884cc30 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -17,6 +17,7 @@ config CSKY
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
 	select DW_APB_TIMER_OF
+	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index f572605d5ad5..332f51bc68fb 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -36,11 +36,9 @@
 /*
  * I/O memory mapping functions.
  */
-extern void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot);
-extern void iounmap(void *addr);
-
-#define ioremap(addr, size)		__ioremap((addr), (size), pgprot_noncached(PAGE_KERNEL))
-#define ioremap_wc(addr, size)		__ioremap((addr), (size), pgprot_writecombine(PAGE_KERNEL))
+#define ioremap_wc(addr, size) \
+	ioremap_prot((addr), (size), \
+		(_PAGE_IOREMAP & ~_CACHE_MASK) | _CACHE_UNCACHED)
 
 #include <asm-generic/io.h>
 
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 7c21985c60dc..4b2a41e15f2e 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -86,6 +86,10 @@
 #define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 				_CACHE_CACHED)
 
+#define _PAGE_IOREMAP \
+	(_PAGE_PRESENT | __READABLE | __WRITEABLE | _PAGE_GLOBAL | \
+	 _CACHE_UNCACHED | _PAGE_SO)
+
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
 #define __P010	PAGE_COPY
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index ae78256a56fd..70c8268d3b2b 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -3,53 +3,8 @@
 
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/vmalloc.h>
 #include <linux/io.h>
 
-#include <asm/pgtable.h>
-
-static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
-				      pgprot_t prot, void *caller)
-{
-	phys_addr_t last_addr;
-	unsigned long offset, vaddr;
-	struct vm_struct *area;
-
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
-	offset = addr & (~PAGE_MASK);
-	addr &= PAGE_MASK;
-	size = PAGE_ALIGN(size + offset);
-
-	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-	if (!area)
-		return NULL;
-
-	vaddr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
-		free_vm_area(area);
-		return NULL;
-	}
-
-	return (void __iomem *)(vaddr + offset);
-}
-
-void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
-{
-	return __ioremap_caller(phys_addr, size, prot,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(__ioremap);
-
-void iounmap(void __iomem *addr)
-{
-	vunmap((void *)((unsigned long)addr & PAGE_MASK));
-}
-EXPORT_SYMBOL(iounmap);
-
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-- 
2.20.1

