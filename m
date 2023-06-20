Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60C736D18
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjFTNUH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjFTNTN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 09:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9F19AC
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687267079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrr2cNyhDy3XHVdkhg3dGxWKYfHUscXJOX9H9m6IS1s=;
        b=c7XR8s5cE8C4S327qkDkY3bpAAZcSiHot5zUBwZkTlFpB5qHpahOZeLhyxpnkKvkUv0rDP
        4o11ywoppeE6r6MhEqbCBtBk5gNk55MlmLa96GWt74fVg7rf8hbzY3e0Qgv3UaS8NK6wK9
        Y2R0i2Z8hI94nNqTAJhHO0uzRl2b83Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-cbsQdSbTO9iAyNHoribILg-1; Tue, 20 Jun 2023 09:17:52 -0400
X-MC-Unique: cbsQdSbTO9iAyNHoribILg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CDB33C28C17;
        Tue, 20 Jun 2023 13:16:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B052C1ED97;
        Tue, 20 Jun 2023 13:16:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 17/19] powerpc: mm: Convert to GENERIC_IOREMAP
Date:   Tue, 20 Jun 2023 21:13:54 +0800
Message-Id: <20230620131356.25440-18-bhe@redhat.com>
In-Reply-To: <20230620131356.25440-1-bhe@redhat.com>
References: <20230620131356.25440-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
and iounmap() are all visible and available to arch. Arch needs to
provide wrapper functions to override the generic versions if there's
arch specific handling in its ioremap_prot(), ioremap() or iounmap().
This change will simplify implementation by removing duplicated codes
with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
functioality as before.

Here, add wrapper functions ioremap_prot() and iounmap() for powerpc's
special operation when ioremap() and iounmap().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/include/asm/io.h |  8 +++-----
 arch/powerpc/mm/ioremap.c     | 26 +-------------------------
 arch/powerpc/mm/ioremap_32.c  | 19 +++++++++----------
 arch/powerpc/mm/ioremap_64.c  | 12 ++----------
 5 files changed, 16 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index bff5820b7cda..aadb280a539e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -194,6 +194,7 @@ config PPC
 	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IOREMAP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 67a3fb6de498..0732b743e099 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -889,8 +889,8 @@ static inline void iosync(void)
  *
  */
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
-extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
-				  unsigned long flags);
+#define ioremap ioremap
+#define ioremap_prot ioremap_prot
 extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
 #define ioremap_wc ioremap_wc
 
@@ -904,14 +904,12 @@ void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
 #define ioremap_cache(addr, size) \
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 
-extern void iounmap(volatile void __iomem *addr);
+#define iounmap iounmap
 
 void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size);
 
 int early_ioremap_range(unsigned long ea, phys_addr_t pa,
 			unsigned long size, pgprot_t prot);
-void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
-			 pgprot_t prot, void *caller);
 
 extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
 				      pgprot_t prot, void *caller);
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 4f12504fb405..705e8e8ffde4 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -41,7 +41,7 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 	return __ioremap_caller(addr, size, prot, caller);
 }
 
-void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
+void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long flags)
 {
 	pte_t pte = __pte(flags);
 	void *caller = __builtin_return_address(0);
@@ -74,27 +74,3 @@ int early_ioremap_range(unsigned long ea, phys_addr_t pa,
 
 	return 0;
 }
-
-void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
-			 pgprot_t prot, void *caller)
-{
-	struct vm_struct *area;
-	int ret;
-	unsigned long va;
-
-	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START, IOREMAP_END, caller);
-	if (area == NULL)
-		return NULL;
-
-	area->phys_addr = pa;
-	va = (unsigned long)area->addr;
-
-	ret = ioremap_page_range(va, va + size, pa, prot);
-	if (!ret)
-		return (void __iomem *)area->addr + offset;
-
-	vunmap_range(va, va + size);
-	free_vm_area(area);
-
-	return NULL;
-}
diff --git a/arch/powerpc/mm/ioremap_32.c b/arch/powerpc/mm/ioremap_32.c
index 9d13143b8be4..ca5bc6be3e6f 100644
--- a/arch/powerpc/mm/ioremap_32.c
+++ b/arch/powerpc/mm/ioremap_32.c
@@ -21,6 +21,13 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 	phys_addr_t p, offset;
 	int err;
 
+	/*
+	 * If the address lies within the first 16 MB, assume it's in ISA
+	 * memory space
+	 */
+	if (addr < SZ_16M)
+		addr += _ISA_MEM_BASE;
+
 	/*
 	 * Choose an address to map it to.
 	 * Once the vmalloc system is running, we use it.
@@ -31,13 +38,6 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 	offset = addr & ~PAGE_MASK;
 	size = PAGE_ALIGN(addr + size) - p;
 
-	/*
-	 * If the address lies within the first 16 MB, assume it's in ISA
-	 * memory space
-	 */
-	if (p < 16 * 1024 * 1024)
-		p += _ISA_MEM_BASE;
-
 #ifndef CONFIG_CRASH_DUMP
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
@@ -63,7 +63,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 		return (void __iomem *)v + offset;
 
 	if (slab_is_available())
-		return do_ioremap(p, offset, size, prot, caller);
+		return generic_ioremap_prot(addr, size, prot);
 
 	/*
 	 * Should check if it is a candidate for a BAT mapping
@@ -87,7 +87,6 @@ void iounmap(volatile void __iomem *addr)
 	if (v_block_mapped((unsigned long)addr))
 		return;
 
-	if (addr > high_memory && (unsigned long)addr < ioremap_bot)
-		vunmap((void *)(PAGE_MASK & (unsigned long)addr));
+	generic_iounmap(addr);
 }
 EXPORT_SYMBOL(iounmap);
diff --git a/arch/powerpc/mm/ioremap_64.c b/arch/powerpc/mm/ioremap_64.c
index 3acece00b33e..d24e5f166723 100644
--- a/arch/powerpc/mm/ioremap_64.c
+++ b/arch/powerpc/mm/ioremap_64.c
@@ -29,7 +29,7 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 		return NULL;
 
 	if (slab_is_available())
-		return do_ioremap(paligned, offset, size, prot, caller);
+		return generic_ioremap_prot(addr, size, prot);
 
 	pr_warn("ioremap() called early from %pS. Use early_ioremap() instead\n", caller);
 
@@ -49,17 +49,9 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
  */
 void iounmap(volatile void __iomem *token)
 {
-	void *addr;
-
 	if (!slab_is_available())
 		return;
 
-	addr = (void *)((unsigned long __force)PCI_FIX_ADDR(token) & PAGE_MASK);
-
-	if ((unsigned long)addr < ioremap_bot) {
-		pr_warn("Attempt to iounmap early bolted mapping at 0x%p\n", addr);
-		return;
-	}
-	vunmap(addr);
+	generic_iounmap(PCI_FIX_ADDR(token));
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.34.1

