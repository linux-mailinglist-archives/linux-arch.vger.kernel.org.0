Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA16A66B9
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 04:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCADpx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 22:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCADp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 22:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAC632524
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2023 19:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677642259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9whDoNwe8yovUO5v26C7zBzC5y2FxPUW+aeJ84UAlAo=;
        b=c5nOPvp0uz7y4yhs4J+vdsBrcb4WVnWG1KL4hWVBxsChDyzXzhBkB8vRMrtVXNktx8m3qM
        lhiLm0lYw1dpRv8ICUW9gFW0kcgydXYkBHcGFRDJ+6c7Xz34TlqOEZ/asv+Sfip0ljrQpE
        lhMMvsA0JkuSQY4n0h5DmrOziwJn/8Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-2dc4BHpnPxaMFbTsR4-azA-1; Tue, 28 Feb 2023 22:44:15 -0500
X-MC-Unique: 2dc4BHpnPxaMFbTsR4-azA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B38403814589;
        Wed,  1 Mar 2023 03:44:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5DEC15BAD;
        Wed,  1 Mar 2023 03:44:09 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        willy@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 12/17] xtensa: mm: Convert to GENERIC_IOREMAP
Date:   Wed,  1 Mar 2023 11:42:42 +0800
Message-Id: <20230301034247.136007-13-bhe@redhat.com>
In-Reply-To: <20230301034247.136007-1-bhe@redhat.com>
References: <20230301034247.136007-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Here, add wrapper functions ioremap_prot(), ioremap() and iounmap() for
xtensa's special operation when ioremap() and iounmap().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/xtensa/Kconfig          |  1 +
 arch/xtensa/include/asm/io.h | 32 ++++++++------------
 arch/xtensa/mm/ioremap.c     | 58 +++++++++---------------------------
 3 files changed, 27 insertions(+), 64 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index bcb0c5d2abc2..465d5981082a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -29,6 +29,7 @@ config XTENSA
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
+	select GENERIC_IOREMAP if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index a5b707e1c0f4..934e58399c8c 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -16,6 +16,7 @@
 #include <asm/vectors.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/pgtable.h>
 
 #include <linux/types.h>
 
@@ -24,22 +25,24 @@
 #define PCI_IOBASE		((void __iomem *)XCHAL_KIO_BYPASS_VADDR)
 
 #ifdef CONFIG_MMU
-
-void __iomem *xtensa_ioremap_nocache(unsigned long addr, unsigned long size);
-void __iomem *xtensa_ioremap_cache(unsigned long addr, unsigned long size);
-void xtensa_iounmap(volatile void __iomem *addr);
-
 /*
- * Return the virtual address for the specified bus memory.
+ * I/O memory mapping functions.
  */
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot);
+#define ioremap_prot ioremap_prot
+#define iounmap iounmap
+
 static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 {
 	if (offset >= XCHAL_KIO_PADDR
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
 		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_BYPASS_VADDR);
 	else
-		return xtensa_ioremap_nocache(offset, size);
+		return ioremap_prot(offset, size,
+			pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 }
+#define ioremap ioremap
 
 static inline void __iomem *ioremap_cache(unsigned long offset,
 		unsigned long size)
@@ -48,21 +51,10 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
 		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
 	else
-		return xtensa_ioremap_cache(offset, size);
-}
-#define ioremap_cache ioremap_cache
+		return ioremap_prot(offset, size, pgprot_val(PAGE_KERNEL));
 
-static inline void iounmap(volatile void __iomem *addr)
-{
-	unsigned long va = (unsigned long) addr;
-
-	if (!(va >= XCHAL_KIO_CACHED_VADDR &&
-	      va - XCHAL_KIO_CACHED_VADDR < XCHAL_KIO_SIZE) &&
-	    !(va >= XCHAL_KIO_BYPASS_VADDR &&
-	      va - XCHAL_KIO_BYPASS_VADDR < XCHAL_KIO_SIZE))
-		xtensa_iounmap(addr);
 }
-
+#define ioremap_cache ioremap_cache
 #endif /* CONFIG_MMU */
 
 #include <asm-generic/io.h>
diff --git a/arch/xtensa/mm/ioremap.c b/arch/xtensa/mm/ioremap.c
index a400188c16b9..8ca660b7ab49 100644
--- a/arch/xtensa/mm/ioremap.c
+++ b/arch/xtensa/mm/ioremap.c
@@ -6,60 +6,30 @@
  */
 
 #include <linux/io.h>
-#include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
-static void __iomem *xtensa_ioremap(unsigned long paddr, unsigned long size,
-				    pgprot_t prot)
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
 {
-	unsigned long offset = paddr & ~PAGE_MASK;
-	unsigned long pfn = __phys_to_pfn(paddr);
-	struct vm_struct *area;
-	unsigned long vaddr;
-	int err;
-
-	paddr &= PAGE_MASK;
-
+	unsigned long pfn = __phys_to_pfn((phys_addr));
 	WARN_ON(pfn_valid(pfn));
 
-	size = PAGE_ALIGN(offset + size);
-
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	vaddr = (unsigned long)area->addr;
-	area->phys_addr = paddr;
-
-	err = ioremap_page_range(vaddr, vaddr + size, paddr, prot);
-
-	if (err) {
-		vunmap((void *)vaddr);
-		return NULL;
-	}
-
-	flush_cache_vmap(vaddr, vaddr + size);
-	return (void __iomem *)(offset + vaddr);
-}
-
-void __iomem *xtensa_ioremap_nocache(unsigned long addr, unsigned long size)
-{
-	return xtensa_ioremap(addr, size, pgprot_noncached(PAGE_KERNEL));
+	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
 }
-EXPORT_SYMBOL(xtensa_ioremap_nocache);
+EXPORT_SYMBOL(ioremap_prot);
 
-void __iomem *xtensa_ioremap_cache(unsigned long addr, unsigned long size)
+void iounmap(volatile void __iomem *addr)
 {
-	return xtensa_ioremap(addr, size, PAGE_KERNEL);
-}
-EXPORT_SYMBOL(xtensa_ioremap_cache);
+	unsigned long va = (unsigned long) addr;
 
-void xtensa_iounmap(volatile void __iomem *io_addr)
-{
-	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
+	if ((va >= XCHAL_KIO_CACHED_VADDR &&
+	      va - XCHAL_KIO_CACHED_VADDR < XCHAL_KIO_SIZE) ||
+	    (va >= XCHAL_KIO_BYPASS_VADDR &&
+	      va - XCHAL_KIO_BYPASS_VADDR < XCHAL_KIO_SIZE))
+		return;
 
-	vunmap(addr);
+	generic_iounmap(addr);
 }
-EXPORT_SYMBOL(xtensa_iounmap);
+EXPORT_SYMBOL(iounmap);
-- 
2.34.1

