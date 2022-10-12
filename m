Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66DE5FC390
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJLKN0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 06:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJLKMo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 06:12:44 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979BFC1D8C;
        Wed, 12 Oct 2022 03:11:17 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MnT121v5Bz9sn9;
        Wed, 12 Oct 2022 12:10:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X_q9l7VdCY8K; Wed, 12 Oct 2022 12:10:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MnT0w6fq3z9snD;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C76498B76C;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id w4hH0sd8_Gs9; Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F30EF8B770;
        Wed, 12 Oct 2022 12:10:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 29CA9wkA1165787
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:09:58 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 29CA9wXj1165786;
        Wed, 12 Oct 2022 12:09:58 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com
Subject: [RFC PATCH 3/8] mm/ioremap: Define generic_ioremap_prot() and generic_iounmap()
Date:   Wed, 12 Oct 2022 12:09:39 +0200
Message-Id: <32dedfbe00c1da0114f66d6a43c56f4a16a85b64.1665568707.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1665568707.git.christophe.leroy@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665569382; l=2900; s=20211009; h=from:subject:message-id; bh=tHKak9ewpxUny0w2VkBQKImX8SLPs5/iqHbvEIk/9vg=; b=hYMYcHwiD3nBwyr7FsnC5psNvXsF9LTBALezca5yNlGQ2xDqkhtnGul3QOPUPPBFWo1J13/7QYq9 yBXJn9/RAUX1a1sG4t8+rxe8M0+dyWHT0JV7m/xpbkC/ROLX9m4v
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define a generic version of ioremap_prot() and iounmap() that
architectures can call after they have performed the necessary
alteration to parameters and/or necessary verifications.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/io.h |  4 ++++
 mm/ioremap.c             | 26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a68f8fbf423b..43eb4f62e954 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1073,9 +1073,13 @@ static inline bool iounmap_allowed(void *addr)
 }
 #endif
 
+void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
+                                  pgprot_t prot);
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
+void generic_iounmap(volatile void __iomem *addr);
 
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 8652426282cc..9f34a8f90b58 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,8 +11,8 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
+				   pgprot_t prot)
 {
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
@@ -28,7 +28,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, prot))
+	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
 		return NULL;
 
 	area = get_vm_area_caller(size, VM_IOREMAP,
@@ -38,17 +38,24 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	vaddr = (unsigned long)area->addr;
 	area->phys_addr = phys_addr;
 
-	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
-			       __pgprot(prot))) {
+	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot)) {
 		free_vm_area(area);
 		return NULL;
 	}
 
 	return (void __iomem *)(vaddr + offset);
 }
+
+#ifndef ioremap_prot
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
+{
+	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+}
 EXPORT_SYMBOL(ioremap_prot);
+#endif
 
-void iounmap(volatile void __iomem *addr)
+void generic_iounmap(volatile void __iomem *addr)
 {
 	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
 
@@ -58,4 +65,11 @@ void iounmap(volatile void __iomem *addr)
 	if (is_vmalloc_addr(vaddr))
 		vunmap(vaddr);
 }
+
+#ifndef iounmap
+void iounmap(volatile void __iomem *addr)
+{
+	generic_iounmap(addr);
+}
 EXPORT_SYMBOL(iounmap);
+#endif
-- 
2.37.1

