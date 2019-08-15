Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337968EA3D
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfHOL3K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 07:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfHOL3K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 07:29:10 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041FA2064A;
        Thu, 15 Aug 2019 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565868549;
        bh=iiPFjQ6IpGaSo+ZfHDmX+dVXiSF+Y0k80QYxQEedsKc=;
        h=From:To:Cc:Subject:Date:From;
        b=djZMVfT7jDb6PTyLETIQfabTlehNjYjkeLD+QO2DV69Gk9CsnFKc+KsCD+xFoPgcD
         Yzte242KQRZnpQi03iO4rK8p9lNxk1Gb1gGqMEYRhzPFEZAtN1OxLEDIik2eLeZlrM
         rbmc1VTP8VapiKx9nn8kxGLHavBm1BuJ5k5iQMco=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com,
        Guo Ren <ren_guo@c-sky.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] csky: Fixup ioremap function losing
Date:   Thu, 15 Aug 2019 19:28:57 +0800
Message-Id: <1565868537-17753-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Implement the following apis to meet usage in different scenarios.

 - ioremap          (NonCache + StrongOrder)
 - ioremap_nocache  (NonCache + StrongOrder)
 - ioremap_wc       (NonCache + WeakOrder  )
 - ioremap_cache    (   Cache + WeakOrder  )

Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/csky/include/asm/io.h | 23 ++++++++++++-----------
 arch/csky/mm/ioremap.c     | 23 +++++++++++++++++------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index c1dfa9c..80d071e 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -4,17 +4,10 @@
 #ifndef __ASM_CSKY_IO_H
 #define __ASM_CSKY_IO_H
 
-#include <abi/pgtable-bits.h>
+#include <asm/pgtable.h>
 #include <linux/types.h>
 #include <linux/version.h>
 
-extern void __iomem *ioremap(phys_addr_t offset, size_t size);
-
-extern void iounmap(void *addr);
-
-extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
-		size_t size, unsigned long flags);
-
 /*
  * I/O memory access primitives. Reads are ordered relative to any
  * following Normal memory access. Writes are ordered relative to any prior
@@ -40,9 +33,17 @@ extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
 #define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); mb(); })
 #endif
 
-#define ioremap_nocache(phy, sz)	ioremap(phy, sz)
-#define ioremap_wc ioremap_nocache
-#define ioremap_wt ioremap_nocache
+/*
+ * I/O memory mapping functions.
+ */
+extern void __iomem *ioremap_cache(phys_addr_t addr, size_t size);
+extern void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot);
+extern void iounmap(void *addr);
+
+#define ioremap(addr, size)		__ioremap((addr), (size), pgprot_noncached(PAGE_KERNEL))
+#define ioremap_wc(addr, size)		__ioremap((addr), (size), pgprot_writecombine(PAGE_KERNEL))
+#define ioremap_nocache(addr, size)	ioremap((addr), (size))
+#define ioremap_cache			ioremap_cache
 
 #include <asm-generic/io.h>
 
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index 4853111..e13cd34 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -8,12 +8,12 @@
 
 #include <asm/pgtable.h>
 
-void __iomem *ioremap(phys_addr_t addr, size_t size)
+static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
+				      pgprot_t prot, void *caller)
 {
 	phys_addr_t last_addr;
 	unsigned long offset, vaddr;
 	struct vm_struct *area;
-	pgprot_t prot;
 
 	last_addr = addr + size - 1;
 	if (!size || last_addr < addr)
@@ -23,14 +23,12 @@ void __iomem *ioremap(phys_addr_t addr, size_t size)
 	addr &= PAGE_MASK;
 	size = PAGE_ALIGN(size + offset);
 
-	area = get_vm_area_caller(size, VM_ALLOC, __builtin_return_address(0));
+	area = get_vm_area_caller(size, VM_IOREMAP, caller);
 	if (!area)
 		return NULL;
 
 	vaddr = (unsigned long)area->addr;
 
-	prot = pgprot_noncached(PAGE_KERNEL);
-
 	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
 		free_vm_area(area);
 		return NULL;
@@ -38,7 +36,20 @@ void __iomem *ioremap(phys_addr_t addr, size_t size)
 
 	return (void __iomem *)(vaddr + offset);
 }
-EXPORT_SYMBOL(ioremap);
+
+void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
+{
+	return __ioremap_caller(phys_addr, size, prot,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(__ioremap);
+
+void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
+{
+	return __ioremap_caller(phys_addr, size, PAGE_KERNEL,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_cache);
 
 void iounmap(void __iomem *addr)
 {
-- 
2.7.4

