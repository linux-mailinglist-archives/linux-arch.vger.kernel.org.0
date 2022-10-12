Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6385FC387
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJLKLa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJLKLG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 06:11:06 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F282B489E;
        Wed, 12 Oct 2022 03:10:32 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MnT0z0pDCz9sn4;
        Wed, 12 Oct 2022 12:10:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p8qtrgagl0Ep; Wed, 12 Oct 2022 12:10:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MnT0w5xDRz9sn6;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AEA4C8B776;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id d3B-9O74toCi; Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F08AE8B76C;
        Wed, 12 Oct 2022 12:10:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 29CA9xoa1165800
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:09:59 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 29CA9xe51165799;
        Wed, 12 Oct 2022 12:09:59 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        linux-ia64@vger.kernel.org
Subject: [RFC PATCH 6/8] ia64: mm: Convert to GENERIC_IOREMAP
Date:   Wed, 12 Oct 2022 12:09:42 +0200
Message-Id: <3e63827ddd7479d495532ce39f3c232328b77151.1665568707.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1665568707.git.christophe.leroy@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665569382; l=4621; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=BfEck34eDmxFT16UNm424CyNhewE4v53xTcpBtR0vzI=; b=FqyRvaCgnSIrYfBNZYA1Lx00oj9ZZooHKJYGWcIwmHAKirkaG4VZlJgmlsS/5L3vPEOUglXZDKCi UvpJlVEADRIY6TQuvHgezkbeg5dKBjeZ60j3FnaHNb7Ju5FoiIcv
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Baoquan He <bhe@redhat.com>

By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. Arch only needs to
provide implementation of arch_ioremap() or arch_iounmap() if there's
arch specific handling needed in its ioremap() or iounmap(). This
change will simplify implementation by removing duplicated codes with
generic ioremap() and iounmap(), and has the equivalent functioality
as before.

Here add hooks arch_ioremap() and arch_iounmap() for ia64's special
operation when ioremap() and iounmap(), then ioremap_cache() is
converted to use ioremap_prot() from GENERIC_IOREMAP.

The old ioremap_uc() is kept and add its macro definittion.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/ia64/Kconfig          |  1 +
 arch/ia64/include/asm/io.h | 11 ++++++----
 arch/ia64/mm/ioremap.c     | 45 ++++++--------------------------------
 3 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 26ac8ea15a9e..1ca18be5dc30 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -45,6 +45,7 @@ config IA64
 	select GENERIC_IRQ_LEGACY
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select ARCH_TASK_STRUCT_ON_STACK
 	select ARCH_TASK_STRUCT_ALLOCATOR
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index ce66dfc0e719..06e006d82d81 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -247,18 +247,21 @@ static inline void outsl(unsigned long port, const void *src,
 
 # ifdef __KERNEL__
 
-extern void __iomem * ioremap(unsigned long offset, unsigned long size);
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
+
+void __iomem *ioremap_prot(unsigned long phys_addr, unsigned long size,
+			   unsigned long flags);
 extern void __iomem * ioremap_uc(unsigned long offset, unsigned long size);
-extern void iounmap (volatile void __iomem *addr);
 static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
 {
 	return ioremap(phys_addr, size);
 }
-#define ioremap ioremap
+#define ioremap_prot ioremap_prot
 #define ioremap_cache ioremap_cache
 #define ioremap_uc ioremap_uc
-#define iounmap iounmap
 
+bool iounmap_allowed(void *addr);
+#define iounmap_allowed iounmap_allowed
 /*
  * String version of IO memory access ops:
  */
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 55fd3eb753ff..0d43efe528e4 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -29,13 +29,9 @@ early_ioremap (unsigned long phys_addr, unsigned long size)
 	return __ioremap_uc(phys_addr);
 }
 
-void __iomem *
-ioremap (unsigned long phys_addr, unsigned long size)
+void __iomem *ioremap_prot(unsigned long phys_addr, unsigned long size,
+			   unsigned long flags)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset;
-	pgprot_t prot;
 	u64 attr;
 	unsigned long gran_base, gran_size;
 	unsigned long page_base;
@@ -68,36 +64,12 @@ ioremap (unsigned long phys_addr, unsigned long size)
 	 */
 	page_base = phys_addr & PAGE_MASK;
 	size = PAGE_ALIGN(phys_addr + size) - page_base;
-	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB) {
-		prot = PAGE_KERNEL;
-
-		/*
-		 * Mappings have to be page-aligned
-		 */
-		offset = phys_addr & ~PAGE_MASK;
-		phys_addr &= PAGE_MASK;
-
-		/*
-		 * Ok, go for it..
-		 */
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-
-		area->phys_addr = phys_addr;
-		addr = (void __iomem *) area->addr;
-		if (ioremap_page_range((unsigned long) addr,
-				(unsigned long) addr + size, phys_addr, prot)) {
-			vunmap((void __force *) addr);
-			return NULL;
-		}
-
-		return (void __iomem *) (offset + (char __iomem *)addr);
-	}
+	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB)
+		return generic_ioremap_prot(phys_addr, size, __pgprot(flags));
 
 	return __ioremap_uc(phys_addr);
 }
-EXPORT_SYMBOL(ioremap);
+EXPORT_SYMBOL(ioremap_prot);
 
 void __iomem *
 ioremap_uc(unsigned long phys_addr, unsigned long size)
@@ -114,10 +86,7 @@ early_iounmap (volatile void __iomem *addr, unsigned long size)
 {
 }
 
-void
-iounmap (volatile void __iomem *addr)
+bool iounmap_allowed(void *addr)
 {
-	if (REGION_NUMBER(addr) == RGN_GATE)
-		vunmap((void *) ((unsigned long) addr & PAGE_MASK));
+	return REGION_NUMBER(addr) == RGN_GATE;
 }
-EXPORT_SYMBOL(iounmap);
-- 
2.37.1

