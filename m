Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABEF7291EA
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbjFIH6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbjFIH56 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A803C0B
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgITI2yqguKz3xZ3AEWeb8MIawpkLomY+LhKu59PhRc=;
        b=EAZ+l9n/Psk2ZYZn+1e97ox0CTWT5nzy3mmwlJv0dSkWh4EOZJxiTs0mPJKW0qoo2B7qdi
        GEk5+GzxI6OBUBXPKkVs/I3/PwZvv+vXEbznjtlzgGZKvfBM6mT3BipIQTQrDBlW9RtQEl
        9/xekQK+GA8DuRJmuadvxWtiPtJRxN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-GsgpTOSBOV27xs_zRW3t0Q-1; Fri, 09 Jun 2023 03:56:27 -0400
X-MC-Unique: GsgpTOSBOV27xs_zRW3t0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B11538007D9;
        Fri,  9 Jun 2023 07:56:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2AE20268C6;
        Fri,  9 Jun 2023 07:56:20 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v6 07/19] arc: mm: Convert to GENERIC_IOREMAP
Date:   Fri,  9 Jun 2023 15:55:16 +0800
Message-Id: <20230609075528.9390-8-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
and iounmap() are all visible and available to arch. Arch needs to
provide wrapper functions to override the generic versions if there's
arch specific handling in its ioremap_prot(), ioremap() or iounmap().
This change will simplify implementation by removing duplicated codes
with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
functioality as before.

Here, add wrapper functions ioremap_prot() and iounmap() for arc's
special operation when ioremap_prot() and iounmap().

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/Kconfig          |  1 +
 arch/arc/include/asm/io.h |  7 +++---
 arch/arc/mm/ioremap.c     | 49 ++++-----------------------------------
 3 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ab6d701365bb..3a666ee0c0bc 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,7 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IOREMAP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 80347382a380..4fdb7350636c 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -21,8 +21,9 @@
 #endif
 
 extern void __iomem *ioremap(phys_addr_t paddr, unsigned long size);
-extern void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
-				  unsigned long flags);
+#define ioremap ioremap
+#define ioremap_prot ioremap_prot
+#define iounmap iounmap
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
 	return (void __iomem *)port;
@@ -32,8 +33,6 @@ static inline void ioport_unmap(void __iomem *addr)
 {
 }
 
-extern void iounmap(const volatile void __iomem *addr);
-
 /*
  * io{read,write}{16,32}be() macros
  */
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 712c2311daef..b07004d53267 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/cache.h>
 
 static inline bool arc_uncached_addr_space(phys_addr_t paddr)
@@ -25,13 +24,6 @@ static inline bool arc_uncached_addr_space(phys_addr_t paddr)
 
 void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
 {
-	phys_addr_t end;
-
-	/* Don't allow wraparound or zero size */
-	end = paddr + size - 1;
-	if (!size || (end < paddr))
-		return NULL;
-
 	/*
 	 * If the region is h/w uncached, MMU mapping can be elided as optim
 	 * The cast to u32 is fine as this region can only be inside 4GB
@@ -51,55 +43,22 @@ EXPORT_SYMBOL(ioremap);
  * ARC hardware uncached region, this one still goes thru the MMU as caller
  * might need finer access control (R/W/X)
  */
-void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
+void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
 			   unsigned long flags)
 {
-	unsigned int off;
-	unsigned long vaddr;
-	struct vm_struct *area;
-	phys_addr_t end;
 	pgprot_t prot = __pgprot(flags);
 
-	/* Don't allow wraparound, zero size */
-	end = paddr + size - 1;
-	if ((!size) || (end < paddr))
-		return NULL;
-
-	/* An early platform driver might end up here */
-	if (!slab_is_available())
-		return NULL;
-
 	/* force uncached */
-	prot = pgprot_noncached(prot);
-
-	/* Mappings have to be page-aligned */
-	off = paddr & ~PAGE_MASK;
-	paddr &= PAGE_MASK_PHYS;
-	size = PAGE_ALIGN(end + 1) - paddr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	area->phys_addr = paddr;
-	vaddr = (unsigned long)area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, paddr, prot)) {
-		vunmap((void __force *)vaddr);
-		return NULL;
-	}
-	return (void __iomem *)(off + (char __iomem *)vaddr);
+	return generic_ioremap_prot(paddr, size, pgprot_noncached(prot));
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-
-void iounmap(const volatile void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	/* weird double cast to handle phys_addr_t > 32 bits */
 	if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
 		return;
 
-	vfree((void *)(PAGE_MASK & (unsigned long __force)addr));
+	generic_iounmap(addr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.34.1

