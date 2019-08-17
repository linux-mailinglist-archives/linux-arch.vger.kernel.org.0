Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD390E9A
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfHQHt3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:49:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfHQHt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X2XMh6NcEuuuxwCkoEHlCwDzxoVV2mYjVm5K/SgqkkM=; b=F0ejWSVheb2kFTv+WD6tekFFkn
        fAfq1FLSCP0QCsZ7GZ/mPRIWun3gXAUpPi1JDBzcJ2/GPF/x9OomZV8yZC5fZNJ/PxoYI4/SCmrm2
        Uo68POe5uJnJXg3eJppHvz1m9W5IJ7ljvvfRzmtVS93xkTEg5AAQ5SyBML0afLA+joKwS+kKvPqtz
        VB2aPZ2cvZNJFN/IwZoV1dNOm4yoZpk8QfWaca8bPj4V6BnEJb1MyzvjwTij8QJlN+6+acn5oDxqm
        tZbzUyWCAjC5keohWD7lcys/x8fzYSMqT8vqU9pTbTui0vWgApzZ3YY0oPwUmBF+ejHZDM0IX9pEV
        5V0L/6Vg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytSl-0005cL-3P; Sat, 17 Aug 2019 07:49:23 +0000
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
Subject: [PATCH 23/26] lib: provide a simple generic ioremap implementation
Date:   Sat, 17 Aug 2019 09:32:50 +0200
Message-Id: <20190817073253.27819-24-hch@lst.de>
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

A lot of architectures reuse the same simple ioremap implementation, so
start lifting the most simple variant to lib/ioremap.c.  It provides
ioremap_prot and iounmap, plus a default ioremap that uses prot_noncached,
although that can be overridden by asm/io.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/io.h | 20 ++++++++++++++++----
 lib/Kconfig              |  3 +++
 lib/ioremap.c            | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 4e45e1cb6560..4a661fdd1937 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -923,9 +923,10 @@ static inline void *phys_to_virt(unsigned long address)
  * DOC: ioremap() and ioremap_*() variants
  *
  * Architectures with an MMU are expected to provide ioremap() and iounmap()
- * themselves.  For NOMMU architectures we provide a default nop-op
- * implementation that expect that the physical address used for MMIO are
- * already marked as uncached, and can be used as kernel virtual addresses.
+ * themselves or rely on GENERIC_IOREMAP.  For NOMMU architectures we provide
+ * a default nop-op implementation that expect that the physical address used
+ * for MMIO are already marked as uncached, and can be used as kernel virtual
+ * addresses.
  *
  * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
  * for specific drivers if the architecture choses to implement them.  If they
@@ -946,7 +947,18 @@ static inline void iounmap(void __iomem *addr)
 {
 }
 #endif
-#endif /* CONFIG_MMU */
+#elif defined(CONFIG_GENERIC_IOREMAP)
+#include <asm/pgtable.h>
+
+void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
+void iounmap(volatile void __iomem *addr);
+
+static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
+{
+	/* _PAGE_IOREMAP needs to be supplied by the architecture */
+	return ioremap_prot(addr, size, _PAGE_IOREMAP);
+}
+#endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
 
 #ifndef ioremap_nocache
 #define ioremap_nocache ioremap
diff --git a/lib/Kconfig b/lib/Kconfig
index f33d66fc0e86..5d452e1072ab 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -636,6 +636,9 @@ config STRING_SELFTEST
 
 endmenu
 
+config GENERIC_IOREMAP
+	bool
+
 config GENERIC_LIB_ASHLDI3
 	bool
 
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 0a2ffadc6d71..3f0e18543de8 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -231,3 +231,42 @@ int ioremap_page_range(unsigned long addr,
 
 	return err;
 }
+
+#ifdef CONFIG_GENERIC_IOREMAP
+void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
+{
+	unsigned long offset, vaddr;
+	phys_addr_t last_addr;
+	struct vm_struct *area;
+
+	/* Disallow wrap-around or zero size */
+	last_addr = addr + size - 1;
+	if (!size || last_addr < addr)
+		return NULL;
+
+	/* Page-align mappings */
+	offset = addr & (~PAGE_MASK);
+	addr -= offset;
+	size = PAGE_ALIGN(size + offset);
+
+	area = get_vm_area_caller(size, VM_IOREMAP,
+			__builtin_return_address(0));
+	if (!area)
+		return NULL;
+	vaddr = (unsigned long)area->addr;
+
+	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
+		free_vm_area(area);
+		return NULL;
+	}
+
+	return (void __iomem *)(vaddr + offset);
+}
+EXPORT_SYMBOL(ioremap_prot);
+
+void iounmap(volatile void __iomem *addr)
+{
+	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+}
+EXPORT_SYMBOL(iounmap);
+#endif /* CONFIG_GENERIC_IOREMAP */
-- 
2.20.1

