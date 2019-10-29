Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA14E8127
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfJ2Gto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:49:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbfJ2Gto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qlJzcnNPhbKTD4rzraxFG78WTWQrEPk5hzQGDgWCawQ=; b=Y+x2zOiatOg5SlYTX5fIO285L6
        e9gR7NlANxUOE2zBvNMRxfIDoWCbfMCRBk6vG9z1+FPPzw1ghvP04BsT8U5iafPimOMgcIxlYieqx
        XHbWRc05j3wQlus+5+bpKavpuuXmg4PQhOyVGgQ0wTToKzFv8HN5Pz3ppIosIDasWQGNqRvhE3907
        dko9p8G9zt32GQo472+E9lt4XkTGMc851892XuB60Fo3nVufVs8zsvnhVcR3a2RiJCr6sY8JWs9C7
        q/2jz+JRDFQO6VT3rY6frJkimmKKghWj1YFz3BjsvTf59RVf3NKYZgbciaZIZ0gSlsKC8omm+yXqm
        YpF86uMQ==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJm-00042z-KQ; Tue, 29 Oct 2019 06:49:27 +0000
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
Subject: [PATCH 16/21] sh: remove __iounmap
Date:   Tue, 29 Oct 2019 07:48:29 +0100
Message-Id: <20191029064834.23438-17-hch@lst.de>
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

No need to indirect iounmap for sh.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h | 9 ++-------
 arch/sh/mm/ioremap.c     | 4 ++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index ac0561960c52..1495489225ac 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -267,7 +267,7 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #ifdef CONFIG_MMU
 void __iomem *__ioremap_caller(phys_addr_t offset, unsigned long size,
 			       pgprot_t prot, void *caller);
-void __iounmap(void __iomem *addr);
+void iounmap(void __iomem *addr);
 
 static inline void __iomem *
 __ioremap(phys_addr_t offset, unsigned long size, pgprot_t prot)
@@ -328,7 +328,7 @@ __ioremap_mode(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #else
 #define __ioremap(offset, size, prot)		((void __iomem *)(offset))
 #define __ioremap_mode(offset, size, prot)	((void __iomem *)(offset))
-#define __iounmap(addr)				do { } while (0)
+#define iounmap(addr)				do { } while (0)
 #endif /* CONFIG_MMU */
 
 static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
@@ -370,11 +370,6 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 #define ioremap_nocache	ioremap
 #define ioremap_uc	ioremap
 
-static inline void iounmap(void __iomem *addr)
-{
-	__iounmap(addr);
-}
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index d09ddfe58fd8..f6d02246d665 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -103,7 +103,7 @@ static inline int iomapping_nontranslatable(unsigned long offset)
 	return 0;
 }
 
-void __iounmap(void __iomem *addr)
+void iounmap(void __iomem *addr)
 {
 	unsigned long vaddr = (unsigned long __force)addr;
 	struct vm_struct *p;
@@ -134,4 +134,4 @@ void __iounmap(void __iomem *addr)
 
 	kfree(p);
 }
-EXPORT_SYMBOL(__iounmap);
+EXPORT_SYMBOL(iounmap);
-- 
2.20.1

