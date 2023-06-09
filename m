Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E97291F0
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjFIH6x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbjFIH6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF030F0
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etYbctmjhFxwpuu9vO4kynRojZXXRgJ3ulf2IbYPQOU=;
        b=ffCfcM/kcRbg+pXFqornNmn7pT0y2mwLtB5lcfDR6M/CByhXI9jjg1hTOxpW4ED37HjebR
        PLDv+61tDVsW0Q75ZCBLhP8muFIruYiW6/EI3J+0AxpfeldcejP/KSuZtQ8GNcNr/Rw/3t
        OHG3E2wwjDRzd2f+dfNSR8e1/oU0vjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-jWs9skGqP8aLkn57za9NmQ-1; Fri, 09 Jun 2023 03:56:49 -0400
X-MC-Unique: jWs9skGqP8aLkn57za9NmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 487698039C9;
        Fri,  9 Jun 2023 07:56:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0BE820268C7;
        Fri,  9 Jun 2023 07:56:40 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
Date:   Fri,  9 Jun 2023 15:55:19 +0800
Message-Id: <20230609075528.9390-11-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Here, add wrapper functions ioremap_prot() and iounmap() for s390's
special operation when ioremap() and iounmap().

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/Kconfig          |  1 +
 arch/s390/include/asm/io.h | 21 ++++++++------
 arch/s390/pci/pci.c        | 57 +++++++-------------------------------
 3 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 6dab9c1be508..e625bb0cc6c7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -142,6 +142,7 @@ config S390
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
+	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index e3882b012bfa..4453ad7c11ac 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -22,11 +22,18 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
 
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
-void __iomem *ioremap(phys_addr_t addr, size_t size);
-void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
-void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
-void iounmap(volatile void __iomem *addr);
+/*
+ * I/O memory mapping functions.
+ */
+#define ioremap_prot ioremap_prot
+#define iounmap iounmap
+
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
+
+#define ioremap_wc(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
+#define ioremap_wt(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
@@ -51,10 +58,6 @@ static inline void ioport_unmap(void __iomem *p)
 #define pci_iomap_wc pci_iomap_wc
 #define pci_iomap_wc_range pci_iomap_wc_range
 
-#define ioremap ioremap
-#define ioremap_wt ioremap_wt
-#define ioremap_wc ioremap_wc
-
 #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
 #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
 #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index afc3f33788da..d34d5813d006 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -244,62 +244,25 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
        zpci_memcpy_toio(to, from, count);
 }
 
-static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
 {
-	unsigned long offset, vaddr;
-	struct vm_struct *area;
-	phys_addr_t last_addr;
-
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
+	/*
+	 * When PCI MIO instructions are unavailable the "physical" address
+	 * encodes a hint for accessing the PCI memory space it represents.
+	 * Just pass it unchanged such that ioread/iowrite can decode it.
+	 */
 	if (!static_branch_unlikely(&have_mio))
-		return (void __iomem *) addr;
+		return (void __iomem *)phys_addr;
 
-	offset = addr & ~PAGE_MASK;
-	addr &= PAGE_MASK;
-	size = PAGE_ALIGN(size + offset);
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	vaddr = (unsigned long) area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
-		free_vm_area(area);
-		return NULL;
-	}
-	return (void __iomem *) ((unsigned long) area->addr + offset);
-}
-
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
-{
-	return __ioremap(addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-void __iomem *ioremap(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, PAGE_KERNEL);
-}
-EXPORT_SYMBOL(ioremap);
-
-void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
-}
-EXPORT_SYMBOL(ioremap_wc);
-
-void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
-}
-EXPORT_SYMBOL(ioremap_wt);
-
 void iounmap(volatile void __iomem *addr)
 {
 	if (static_branch_likely(&have_mio))
-		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
+		generic_iounmap(addr);
 }
 EXPORT_SYMBOL(iounmap);
 
-- 
2.34.1

