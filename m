Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EF5F8A9C
	for <lists+linux-arch@lfdr.de>; Sun,  9 Oct 2022 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJIKcL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Oct 2022 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJIKb4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 06:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE682DA85
        for <linux-arch@vger.kernel.org>; Sun,  9 Oct 2022 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPWSMu71Jh93HhZeuwwaVa4hpm9QyiaP2xITx3CuaM8=;
        b=c3l1bG59h/j5aQN4/P8CxsW6Guw9tPTAbe+9exc1W3u4megPUhELQJsG6QDgExSaov4gAe
        82zOs/7WDngoEz7Uh2RHz+gE+DXgG/v/eX2Fqb63LMz3vsWpDcqGICaVSrJkANavlMbycE
        tiS74W2PtS8Xk+xBhwJQoviKipiY1hI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107--7vpRcU5OhOnjty4Oj6YjQ-1; Sun, 09 Oct 2022 06:31:49 -0400
X-MC-Unique: -7vpRcU5OhOnjty4Oj6YjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339C4185A794;
        Sun,  9 Oct 2022 10:31:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF2940D298B;
        Sun,  9 Oct 2022 10:31:40 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 03/11] mm/ioremap: change the return value of io[re|un]map_allowed and rename
Date:   Sun,  9 Oct 2022 18:31:06 +0800
Message-Id: <20221009103114.149036-4-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-1-bhe@redhat.com>
References: <20221009103114.149036-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, hooks ioremap_allowed() and iounmap_allowed() are used to
check if it's qualified to do ioremap, and now this is done on ARM64.
However, in oder to convert more architectures to take GENERIC_IOREMAP
method, several more things need be done in those two hooks:
 1) The io address mapping need be handled specifically on architectures,
    e.g arc, ia64, s390;
 2) The original physical address passed into ioremap_prot() need be
    fixed up, e.g arc;
 3) The 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
    and xtensa.

To handle these three issues,

 1) Rename ioremap_allowed() and iounmap_allowed() to arch_ioremap()
    and arch_iounmap() since the old name can't reflect their
    functionality after change;
 2) Change the return value of arch_ioremap() so that arch can add
    specifical io address mapping handling inside and return the maped
    address. Now their returned value means:
    ===
    arch_ioremap() return a bool,
      - IS_ERR means return an error
      - 0 means continue to remap
      - a non-zero, non-IS_ERR pointer is returned directly
    arch_iounmap() return a bool,
      - true means continue to vunmap
      - false means skip vunmap and return directly
 3) change the interface of arch_ioremap() so that the mapped address and
    adjusted 'prot' flag can be passed out. While at it, the invocation
    of arch_ioremap() need be moved to the beginning of ioremap_prot()
    because architectures like sh, openrisc, ia64, need do the ARCH
    specific io address mapping on the original physical address. And in
    the later patch, the address fix up code in arch_ioremap() also need
    be done on the original addre on some architectures.

This is preparation for later patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/io.h |  5 +++--
 arch/arm64/mm/ioremap.c     | 16 +++++++++++-----
 include/asm-generic/io.h    | 27 ++++++++++++++-------------
 mm/ioremap.c                | 13 +++++++++----
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 877495a0fd0c..6a5578ddbbf6 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -139,8 +139,9 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
-#define ioremap_allowed ioremap_allowed
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index c5af103d4ad4..ef75ffef4dbc 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,19 +3,25 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	unsigned long last_addr = phys_addr + size - 1;
+	unsigned long last_addr, offset, phys_addr = *paddr;
+
+	offset = phys_addr & (~PAGE_MASK);
+	phys_addr -= offset;
+	size = PAGE_ALIGN(size + offset);
+	last_addr = phys_addr + size - 1;
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
-		return false;
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	/* Don't allow RAM to be mapped. */
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
-		return false;
+		return IOMEM_ERR_PTR(-EINVAL);
 
-	return true;
+	return NULL;
 }
 
 /*
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a68f8fbf423b..2ae16906f3be 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1049,25 +1049,26 @@ static inline void iounmap(volatile void __iomem *addr)
 
 /*
  * Arch code can implement the following two hooks when using GENERIC_IOREMAP
- * ioremap_allowed() return a bool,
- *   - true means continue to remap
- *   - false means skip remap and return directly
- * iounmap_allowed() return a bool,
+ * arch_ioremap() return a bool,
+ *   - IS_ERR means return an error
+ *   - NULL means continue to remap
+ *   - a non-NULL, non-IS_ERR pointer is returned directly
+ * arch_iounmap() return a bool,
  *   - true means continue to vunmap
- *   - false means skip vunmap and return directly
+ *   - false code means skip vunmap and return directly
  */
-#ifndef ioremap_allowed
-#define ioremap_allowed ioremap_allowed
-static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
-				   unsigned long prot)
+#ifndef arch_ioremap
+#define arch_ioremap arch_ioremap
+static inline void __iomem *arch_ioremap(phys_addr_t *paddr, size_t size,
+				   unsigned long *prot_val)
 {
-	return true;
+	return NULL;
 }
 #endif
 
-#ifndef iounmap_allowed
-#define iounmap_allowed iounmap_allowed
-static inline bool iounmap_allowed(void *addr)
+#ifndef arch_iounmap
+#define arch_iounmap arch_iounmap
+static inline bool arch_iounmap(void __iomem *addr)
 {
 	return true;
 }
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 8652426282cc..fd1f0b33f4fd 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -17,6 +17,14 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
 	struct vm_struct *area;
+	void __iomem *ioaddr;
+
+	ioaddr = arch_ioremap(&phys_addr, size, &prot);
+	if (IS_ERR(ioaddr))
+		return NULL;
+
+	if (ioaddr)
+		return ioaddr;
 
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
@@ -28,9 +36,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, prot))
-		return NULL;
-
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
 	if (!area)
@@ -52,7 +57,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
 
-	if (!iounmap_allowed(vaddr))
+	if (!arch_iounmap((void __iomem *)addr))
 		return;
 
 	if (is_vmalloc_addr(vaddr))
-- 
2.34.1

