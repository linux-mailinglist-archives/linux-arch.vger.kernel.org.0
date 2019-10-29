Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1FE80C7
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbfJ2Gt2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfJ2Gt1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H/LEmNPB4LUKmzKwKTw7HppJqT8OudhcMVRJaPxcfXo=; b=FU1R09QDEjHZ/bQjP4k/Bj90jT
        TPIXA1ESvHrX5I5hOg10HKYCg+0cbeFXldoYnauwdz7lnXaiA1YJ34vvuSmtd3L7f2ChsAwNlIxgK
        5x/VqzEjbriG7iok1xOS8dp4IxhVy64TL5Nis6s/qQX3//5rU5ZnlLNJKdT3u56oTVnSHFs9e/nTk
        hjjBMq+5iskHDibXzDzVbNu1DuH2jRL2fqklIoyjYq9lzByiOC2pUAepdntJztYL3mIBn36WRv0K8
        CZeZPrQAggIEdlMX5uWOb+DZXMaDTeQVgcYS4J71MN4D5vRWnfnWmnw5AeXMqaoxCeao5ylHSgfE5
        Oiy6Vxww==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJT-0003p3-Ev; Tue, 29 Oct 2019 06:49:07 +0000
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
Subject: [PATCH 10/21] asm-generic: ioremap_uc should behave the same with and without MMU
Date:   Tue, 29 Oct 2019 07:48:23 +0100
Message-Id: <20191029064834.23438-11-hch@lst.de>
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

Whatever reason there is for the existence of ioremap_uc, and the fact
that it returns NULL by default on architectures with an MMU applies
equally to nommu architectures, so don't provide different defaults.

In practice the difference is meaningless as the only portable driver
that uses ioremap_uc is atyfb which probably doesn't show up on nommu
devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/io.h | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d02806513670..a98ed6325727 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -935,18 +935,7 @@ static inline void *phys_to_virt(unsigned long address)
  * defined your own ioremap_*() variant you must then declare your own
  * ioremap_*() variant as defined to itself to avoid the default NULL return.
  */
-
-#ifdef CONFIG_MMU
-
-#ifndef ioremap_uc
-#define ioremap_uc ioremap_uc
-static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
-{
-	return NULL;
-}
-#endif
-
-#else /* !CONFIG_MMU */
+#ifndef CONFIG_MMU
 
 /*
  * Change "struct page" to physical address.
@@ -980,14 +969,6 @@ static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
 }
 #endif
 
-#ifndef ioremap_uc
-#define ioremap_uc ioremap_uc
-static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
-{
-	return ioremap_nocache(offset, size);
-}
-#endif
-
 #ifndef ioremap_wc
 #define ioremap_wc ioremap_wc
 static inline void __iomem *ioremap_wc(phys_addr_t offset, size_t size)
@@ -1004,6 +985,21 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
 }
 #endif
 
+/*
+ * ioremap_uc is special in that we do require an explicit architecture
+ * implementation.  In general you do now want to use this function in a
+ * driver and use plain ioremap, which is uncached by default.  Similarly
+ * architectures should not implement it unless they have a very good
+ * reason.
+ */
+#ifndef ioremap_uc
+#define ioremap_uc ioremap_uc
+static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_HAS_IOPORT_MAP
 #ifndef CONFIG_GENERIC_IOMAP
 #ifndef ioport_map
-- 
2.20.1

