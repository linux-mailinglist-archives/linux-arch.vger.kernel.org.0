Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19F77291ED
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjFIH6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbjFIH6D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638EE1BDF
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lDwY01DeRkcypkPwr3wPDENx+u681h4hIQx3NHXU5U=;
        b=X4yfC1xKNR9sqrzkv84RXbjrLL7HXZCjpYEmi6hVJA3vmz5BWWiOKSysO3pMNvRdd0RH6v
        VVViqWekw8zz8ddWnvUCMmbbzfEv4BIu3YOPJd+IbnoOgJt09TIu+PNEVQr/87VbtfLn+g
        9FlXlCCxsb6YPbAbGcUNMo/txbZxeFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-RicPtZkPNu6XXaXpAxIvew-1; Fri, 09 Jun 2023 03:56:41 -0400
X-MC-Unique: RicPtZkPNu6XXaXpAxIvew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 376CA185A78F;
        Fri,  9 Jun 2023 07:56:40 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD93420268C6;
        Fri,  9 Jun 2023 07:56:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v6 09/19] openrisc: mm: Convert to GENERIC_IOREMAP
Date:   Fri,  9 Jun 2023 15:55:18 +0800
Message-Id: <20230609075528.9390-10-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

For openrisc, the current ioremap() and iounmap() are the same as
generic version. After taking GENERIC_IOREMAP way, the old ioremap()
and iounmap() can be completely removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
---
v5->v6:
  Remove iounmap() because it's the same as the generic version since we
  have removed the code handling ealry mapping from fixmap pool in
  patch 3 - Mike

 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/include/asm/io.h | 11 ++++----
 arch/openrisc/mm/ioremap.c     | 49 ----------------------------------
 3 files changed, 7 insertions(+), 54 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index c7f282f60f64..fd9bb76a610b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,6 +21,7 @@ config OPENRISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
 	select HAVE_PCI
 	select HAVE_UID16
diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index ee6043a03173..5a6f0f16a5ce 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -15,6 +15,8 @@
 #define __ASM_OPENRISC_IO_H
 
 #include <linux/types.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 
 /*
  * PCI: We do not use IO ports in OpenRISC
@@ -27,11 +29,10 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap ioremap
-void __iomem *ioremap(phys_addr_t offset, unsigned long size);
-
-#define iounmap iounmap
-extern void iounmap(volatile void __iomem *addr);
+/*
+ * I/O memory mapping functions.
+ */
+#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index cdbcc7e73684..91c8259d4b7e 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -22,55 +22,6 @@
 
 extern int mem_init_done;
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
-{
-	phys_addr_t p;
-	unsigned long v;
-	unsigned long offset, last_addr;
-	struct vm_struct *area = NULL;
-
-	/* Don't allow wraparound or zero size */
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = addr & ~PAGE_MASK;
-	p = addr & PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - p;
-
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	v = (unsigned long)area->addr;
-
-	if (ioremap_page_range(v, v + size, p,
-			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
-		vfree(area->addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + (char *)v);
-}
-EXPORT_SYMBOL(ioremap);
-
-void iounmap(volatile void __iomem *addr)
-{
-	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
-}
-EXPORT_SYMBOL(iounmap);
-
 /**
  * OK, this one's a bit tricky... ioremap can get called before memory is
  * initialized (early serial console does this) and will want to alloc a page
-- 
2.34.1

