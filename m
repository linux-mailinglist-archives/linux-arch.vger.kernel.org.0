Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6937291F7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFIH7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbjFIH6f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994914214
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2JqJ5DVfD1RBef7ys9lCToVJCiVC3QaC6lHIm4BgJc=;
        b=XIcCyN7Vt27a6MDWV17TgqsKDiaUP8o8WEJvsLKu0kAfHjIWlYu/RQvDDUte/az+1ryAUr
        eF1fcg7zu6XkwiiQuft5v05GNv2YPVJGpv6ZOyubYbQptjlCqJpwJkBc8J+Oy7DFUjFpku
        EEGQ+idQOt7vzmO/Z11ecLbYfdbARXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-63ItICqVMnCnNe_-eICvug-1; Fri, 09 Jun 2023 03:57:04 -0400
X-MC-Unique: 63ItICqVMnCnNe_-eICvug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A30D8185A78F;
        Fri,  9 Jun 2023 07:57:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D51720268C6;
        Fri,  9 Jun 2023 07:56:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v6 12/19] sh: mm: Convert to GENERIC_IOREMAP
Date:   Fri,  9 Jun 2023 15:55:21 +0800
Message-Id: <20230609075528.9390-13-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Here, add wrapper functions ioremap_prot() and iounmap() for SuperH's
special operation when ioremap() and iounmap().

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v5->v6:
  Based on the previous prep patch, this only focuses on converting to
  GENERIC_IOREMAP for SuperH - Christoph

 arch/sh/Kconfig          |  1 +
 arch/sh/include/asm/io.h | 40 +++++--------------------
 arch/sh/mm/ioremap.c     | 65 +++++++---------------------------------
 3 files changed, 20 insertions(+), 86 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9652d367fc37..f326985e46e0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -28,6 +28,7 @@ config SUPERH
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PXX_LOW_HIGH if X2TLB
 	select HAS_IOPORT if HAS_IOPORT_MAP
+	select GENERIC_IOREMAP if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 270e7952950c..b3a26b405c8d 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -266,40 +266,16 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #endif
 
 #ifdef CONFIG_MMU
-void iounmap(void __iomem *addr);
-void __iomem *__ioremap_caller(phys_addr_t offset, unsigned long size,
-			       pgprot_t prot, void *caller);
-
-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_caller(offset, size, PAGE_KERNEL_NOCACHE,
-			__builtin_return_address(0));
-}
-
-static inline void __iomem *
-ioremap_cache(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_caller(offset, size, PAGE_KERNEL,
-			__builtin_return_address(0));
-}
-#define ioremap_cache ioremap_cache
-
-#ifdef CONFIG_HAVE_IOREMAP_PROT
-static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-		unsigned long flags)
-{
-	return __ioremap_caller(offset, size, __pgprot(flags),
-			__builtin_return_address(0));
-}
-#endif /* CONFIG_HAVE_IOREMAP_PROT */
+/*
+ * I/O memory mapping functions.
+ */
+#define ioremap_prot ioremap_prot
+#define iounmap iounmap
 
-#else /* CONFIG_MMU */
-static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
-{
-	return (void __iomem *)(unsigned long)offset;
-}
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL_NOCACHE)
 
-static inline void iounmap(volatile void __iomem *addr) { }
+#define ioremap_cache(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 #endif /* CONFIG_MMU */
 
 #define ioremap_uc	ioremap
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 21342581144d..c33b3daa4ad1 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -72,22 +72,11 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #define __ioremap_29bit(offset, size, prot)		NULL
 #endif /* CONFIG_29BIT */
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem * __ref
-__ioremap_caller(phys_addr_t phys_addr, unsigned long size,
-		 pgprot_t pgprot, void *caller)
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
 {
-	struct vm_struct *area;
-	unsigned long offset, last_addr, addr, orig_addr;
 	void __iomem *mapped;
+	pgprot_t pgprot = __pgprot(prot);
 
 	mapped = __ioremap_trapped(phys_addr, size);
 	if (mapped)
@@ -97,11 +86,6 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	if (mapped)
 		return mapped;
 
-	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
-		return NULL;
-
 	/*
 	 * If we can't yet use the regular approach, go the fixmap route.
 	 */
@@ -112,34 +96,14 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	 * First try to remap through the PMB.
 	 * PMB entries are all pre-faulted.
 	 */
-	mapped = pmb_remap_caller(phys_addr, size, pgprot, caller);
+	mapped = pmb_remap_caller(phys_addr, size, pgprot,
+			__builtin_return_address(0));
 	if (mapped && !IS_ERR(mapped))
 		return mapped;
 
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr+1) - phys_addr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-	if (!area)
-		return NULL;
-	area->phys_addr = phys_addr;
-	orig_addr = addr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
-		vunmap((void *)orig_addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + (char *)orig_addr);
+	return generic_ioremap_prot(phys_addr, size, pgprot);
 }
-EXPORT_SYMBOL(__ioremap_caller);
+EXPORT_SYMBOL(ioremap_prot);
 
 /*
  * Simple checks for non-translatable mappings.
@@ -158,10 +122,9 @@ static inline int iomapping_nontranslatable(unsigned long offset)
 	return 0;
 }
 
-void iounmap(void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	unsigned long vaddr = (unsigned long __force)addr;
-	struct vm_struct *p;
 
 	/*
 	 * Nothing to do if there is no translatable mapping.
@@ -172,21 +135,15 @@ void iounmap(void __iomem *addr)
 	/*
 	 * There's no VMA if it's from an early fixed mapping.
 	 */
-	if (iounmap_fixed(addr) == 0)
+	if (iounmap_fixed((void __iomem *)addr) == 0)
 		return;
 
 	/*
 	 * If the PMB handled it, there's nothing else to do.
 	 */
-	if (pmb_unmap(addr) == 0)
+	if (pmb_unmap((void __iomem *)addr) == 0)
 		return;
 
-	p = remove_vm_area((void *)(vaddr & PAGE_MASK));
-	if (!p) {
-		printk(KERN_ERR "%s: bad address %p\n", __func__, addr);
-		return;
-	}
-
-	kfree(p);
+	generic_iounmap(addr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.34.1

