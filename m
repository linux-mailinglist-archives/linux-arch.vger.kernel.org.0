Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC0E8143
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfJ2Gt2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbfJ2Gt1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3F9DtF8s0F7FvQcx64692HZn7ZcjGFqeZajVee0KQs4=; b=PPvjFAO3QLUi9dpVleIiAU3Vv4
        /Pu3BDJxheu7StSqoIj8LzyNSKaOxNF4Ma7zI2KAFCD+WLRYxvRi56SItDw11aM3TxVNn3ezAUnOo
        C0chd4qWBYO+xlwExg+24mjnRghpEDzPF9AYBmZZhga7btg57O+DsZA0o1R84X1fIXQXDYR6D9lNl
        D90QKJNymHcdH2Xzzp+bcJ0ZxE/E9F+jli54bK8rjpgsQALvv3AI1UTpkxwPGIzrlHJw4WnsggfKl
        F0eQCDfF/NW9YMB8KxgjFC0q8PpYrNbdF7NPlwAP/0B/RtwyAiLQERzQYZzCYuUoEsPmS7CwP4RJh
        BAl3AJYg==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJN-0003ax-2F; Tue, 29 Oct 2019 06:49:01 +0000
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
Subject: [PATCH 08/21] x86: Clean up ioremap()
Date:   Tue, 29 Oct 2019 07:48:21 +0100
Message-Id: <20191029064834.23438-9-hch@lst.de>
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

Use ioremap() as the main implemented function, and defines
ioremap_nocache() as a deprecated alias of ioremap() in
preparation of removing ioremap_nocache() entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/io.h | 8 ++------
 arch/x86/mm/ioremap.c     | 8 ++++----
 arch/x86/mm/pageattr.c    | 4 ++--
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 6bed97ff6db2..6b5cc41319a7 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -180,8 +180,6 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
  * The default ioremap() behavior is non-cached; if you need something
  * else, you probably want one of the following.
  */
-extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size);
-#define ioremap_nocache ioremap_nocache
 extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
 #define ioremap_uc ioremap_uc
 extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
@@ -205,11 +203,9 @@ extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long
  * If the area you are trying to map is a PCI BAR you should have a
  * look at pci_iomap().
  */
-static inline void __iomem *ioremap(resource_size_t offset, unsigned long size)
-{
-	return ioremap_nocache(offset, size);
-}
+void __iomem *ioremap(resource_size_t offset, unsigned long size);
 #define ioremap ioremap
+#define ioremap_nocache ioremap
 
 extern void iounmap(volatile void __iomem *addr);
 #define iounmap iounmap
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a39dcdb5ae34..7985233dfb8d 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -280,11 +280,11 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 }
 
 /**
- * ioremap_nocache     -   map bus memory into CPU space
+ * ioremap     -   map bus memory into CPU space
  * @phys_addr:    bus address of the memory
  * @size:      size of the resource to map
  *
- * ioremap_nocache performs a platform specific sequence of operations to
+ * ioremap performs a platform specific sequence of operations to
  * make bus memory CPU accessible via the readb/readw/readl/writeb/
  * writew/writel functions and the other mmio helpers. The returned
  * address is not guaranteed to be usable directly as a virtual
@@ -300,7 +300,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
  *
  * Must be freed with iounmap.
  */
-void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
+void __iomem *ioremap(resource_size_t phys_addr, unsigned long size)
 {
 	/*
 	 * Ideally, this should be:
@@ -315,7 +315,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
 	return __ioremap_caller(phys_addr, size, pcm,
 				__builtin_return_address(0), false);
 }
-EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(ioremap);
 
 /**
  * ioremap_uc     -   map bus memory into CPU space as strongly uncachable
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 0d09cc5aad61..1b99ad05b117 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1784,7 +1784,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*
-	 * for now UC MINUS. see comments in ioremap_nocache()
+	 * for now UC MINUS. see comments in ioremap()
 	 * If you really need strong UC use ioremap_uc(), but note
 	 * that you cannot override IO areas with set_memory_*() as
 	 * these helpers cannot work with IO memory.
@@ -1799,7 +1799,7 @@ int set_memory_uc(unsigned long addr, int numpages)
 	int ret;
 
 	/*
-	 * for now UC MINUS. see comments in ioremap_nocache()
+	 * for now UC MINUS. see comments in ioremap()
 	 */
 	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
 			      _PAGE_CACHE_MODE_UC_MINUS, NULL);
-- 
2.20.1

