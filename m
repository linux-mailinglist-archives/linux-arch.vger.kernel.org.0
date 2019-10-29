Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEFE812A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfJ2Gtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:49:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbfJ2Gte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Ko5vX482tR0uQnQI1MnV6/Z/jjaFodCfNm4px/nvU8=; b=nYbODC0yYGVUM6bEVWymqF39zP
        GmadlvLrGZb3UuUdvA6VdrZCC/nfjZ8idoXgOd7kTi+OxrX40qF9g/e4NHrXahzmj6eGREnTdN1lw
        JsjXTRgazbmU1PJ2vLBU4XQoDQVQ8ZRNcetC+HQFmc3xRTXxvLU7UHeixei9jqeFFTbEAHq/e22v0
        Olzh9HYozyKQbx/lANp87sqc3TRPs6haNYIpl3wahuhrhHr78BUXb53LEzl08AuXyysJWjaI7U7Gg
        pvoyEQgsLG3Dcxt6znYvitWkzq5fu3iHSWKwxWf3RUVVQbRniefmZ7vpIzZGGcnBh7l5z7BcmF76f
        yKs/W5Vg==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJd-0003v8-1x; Tue, 29 Oct 2019 06:49:17 +0000
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
Subject: [PATCH 13/21] m68k: rename __iounmap and mark it static
Date:   Tue, 29 Oct 2019 07:48:26 +0100
Message-Id: <20191029064834.23438-14-hch@lst.de>
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

m68k uses __iounmap as the name for an internal helper that is only
used for some CPU types.  Mark it static, give it a better name
and move it around a bit to avoid a forward declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/include/asm/kmap.h |   1 -
 arch/m68k/mm/kmap.c          | 100 +++++++++++++++++------------------
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 421b6c9c769d..559cb91bede1 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -20,7 +20,6 @@ extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
 			       int cacheflag);
 #define iounmap iounmap
 extern void iounmap(void __iomem *addr);
-extern void __iounmap(void *addr, unsigned long size);
 
 #define ioremap ioremap
 static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 40a3b327da07..23f9466aabb5 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -54,6 +54,55 @@ static inline void free_io_area(void *addr)
 
 static struct vm_struct *iolist;
 
+/*
+ * __free_io_area unmaps nearly everything, so be careful
+ * Currently it doesn't free pointer/page tables anymore but this
+ * wasn't used anyway and might be added later.
+ */
+static void __free_io_area(void *addr, unsigned long size)
+{
+	unsigned long virtaddr = (unsigned long)addr;
+	pgd_t *pgd_dir;
+	pmd_t *pmd_dir;
+	pte_t *pte_dir;
+
+	while ((long)size > 0) {
+		pgd_dir = pgd_offset_k(virtaddr);
+		if (pgd_bad(*pgd_dir)) {
+			printk("iounmap: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
+			pgd_clear(pgd_dir);
+			return;
+		}
+		pmd_dir = pmd_offset(pgd_dir, virtaddr);
+
+		if (CPU_IS_020_OR_030) {
+			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
+			int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;
+
+			if (pmd_type == _PAGE_PRESENT) {
+				pmd_dir->pmd[pmd_off] = 0;
+				virtaddr += PTRTREESIZE;
+				size -= PTRTREESIZE;
+				continue;
+			} else if (pmd_type == 0)
+				continue;
+		}
+
+		if (pmd_bad(*pmd_dir)) {
+			printk("iounmap: bad pmd (%08lx)\n", pmd_val(*pmd_dir));
+			pmd_clear(pmd_dir);
+			return;
+		}
+		pte_dir = pte_offset_kernel(pmd_dir, virtaddr);
+
+		pte_val(*pte_dir) = 0;
+		virtaddr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+
+	flush_tlb_all();
+}
+
 static struct vm_struct *get_io_area(unsigned long size)
 {
 	unsigned long addr;
@@ -90,7 +139,7 @@ static inline void free_io_area(void *addr)
 		if (tmp->addr == addr) {
 			*p = tmp->next;
 			/* remove gap added in get_io_area() */
-			__iounmap(tmp->addr, tmp->size - IO_SIZE);
+			__free_io_area(tmp->addr, tmp->size - IO_SIZE);
 			kfree(tmp);
 			return;
 		}
@@ -249,55 +298,6 @@ void iounmap(void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-/*
- * __iounmap unmaps nearly everything, so be careful
- * Currently it doesn't free pointer/page tables anymore but this
- * wasn't used anyway and might be added later.
- */
-void __iounmap(void *addr, unsigned long size)
-{
-	unsigned long virtaddr = (unsigned long)addr;
-	pgd_t *pgd_dir;
-	pmd_t *pmd_dir;
-	pte_t *pte_dir;
-
-	while ((long)size > 0) {
-		pgd_dir = pgd_offset_k(virtaddr);
-		if (pgd_bad(*pgd_dir)) {
-			printk("iounmap: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
-			pgd_clear(pgd_dir);
-			return;
-		}
-		pmd_dir = pmd_offset(pgd_dir, virtaddr);
-
-		if (CPU_IS_020_OR_030) {
-			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
-			int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;
-
-			if (pmd_type == _PAGE_PRESENT) {
-				pmd_dir->pmd[pmd_off] = 0;
-				virtaddr += PTRTREESIZE;
-				size -= PTRTREESIZE;
-				continue;
-			} else if (pmd_type == 0)
-				continue;
-		}
-
-		if (pmd_bad(*pmd_dir)) {
-			printk("iounmap: bad pmd (%08lx)\n", pmd_val(*pmd_dir));
-			pmd_clear(pmd_dir);
-			return;
-		}
-		pte_dir = pte_offset_kernel(pmd_dir, virtaddr);
-
-		pte_val(*pte_dir) = 0;
-		virtaddr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	flush_tlb_all();
-}
-
 /*
  * Set new cache mode for some kernel address space.
  * The caller must push data for that range itself, if such data may already
-- 
2.20.1

