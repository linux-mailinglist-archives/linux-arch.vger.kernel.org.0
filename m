Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E0736CD5
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFTNP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjFTNP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 09:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED2120
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687266884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4y8XwGcIF2jz2W1CKgMhspALuMHaJJCUGdTHN9uXAgA=;
        b=iKCyGdpj/usauQJv7iD8rn1JfZrBEiqqIIeRf6uaBagQvjHFXB0jieYwZIyzBIVb1ALYQN
        0kc9VZUuvASHS2p1E0TK6fB3bSEdkk74R+DUgVEa3tbmoBzhf78ONhYiIVfNFfkJnc9bgK
        bnQr7RH0eEmLESIp4Kfgi5AmQRJHdTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-RSNRVfhJNTGDfKn-1uoIcw-1; Tue, 20 Jun 2023 09:14:40 -0400
X-MC-Unique: RSNRVfhJNTGDfKn-1uoIcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8603488D0FD;
        Tue, 20 Jun 2023 13:14:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21554C1ED96;
        Tue, 20 Jun 2023 13:14:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Date:   Tue, 20 Jun 2023 21:13:39 +0800
Message-Id: <20230620131356.25440-3-bhe@redhat.com>
In-Reply-To: <20230620131356.25440-1-bhe@redhat.com>
References: <20230620131356.25440-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. This change will
simplify implementation by removing duplicated codes with generic
ioremap_prot() and iounmap(), and has the equivalent functioality.

For hexagon, the current ioremap() and iounmap() are the same as
generic version. After taking GENERIC_IOREMAP way, the old ioremap()
and iounmap() can be completely removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
---
v6->v7:
- Fix building error reported by lkp test robot. Here I only fixed the
  redefinition of iounmap(), ignored the PCI_IOBASE warnings since
  Nathan kindly reminded me the warning is a generic issue, and Niklas
  is working on that within below patchset.
  https://lore.kernel.org/all/20230612160237.GA199007@dev-arch.thelio-3990X/T/#u

 arch/hexagon/Kconfig          |  1 +
 arch/hexagon/include/asm/io.h | 11 +++++----
 arch/hexagon/mm/ioremap.c     | 44 -----------------------------------
 3 files changed, 8 insertions(+), 48 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 54eadf265178..17afffde1a7f 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -25,6 +25,7 @@ config HEXAGON
 	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
 	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 46a099de85b7..e2b308e32a37 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -27,8 +27,6 @@
 extern int remap_area_pages(unsigned long start, unsigned long phys_addr,
 				unsigned long end, unsigned long flags);
 
-extern void iounmap(const volatile void __iomem *addr);
-
 /* Defined in lib/io.c, needed for smc91x driver. */
 extern void __raw_readsw(const void __iomem *addr, void *data, int wordlen);
 extern void __raw_writesw(void __iomem *addr, const void *data, int wordlen);
@@ -170,8 +168,13 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
-#define ioremap_uc(X, Y) ioremap((X), (Y))
+/*
+ * I/O memory mapping functions.
+ */
+#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+		       (__HEXAGON_C_DEV << 6))
+
+#define ioremap_uc(addr, size) ioremap((addr), (size))
 
 
 #define __raw_writel writel
diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
deleted file mode 100644
index 255c5b1ee1a7..000000000000
--- a/arch/hexagon/mm/ioremap.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * I/O remap functions for Hexagon
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#include <linux/io.h>
-#include <linux/vmalloc.h>
-#include <linux/mm.h>
-
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
-{
-	unsigned long last_addr, addr;
-	unsigned long offset = phys_addr & ~PAGE_MASK;
-	struct vm_struct *area;
-
-	pgprot_t prot = __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
-					|(__HEXAGON_C_DEV << 6));
-
-	last_addr = phys_addr + size - 1;
-
-	/*  Wrapping not allowed  */
-	if (!size || (last_addr < phys_addr))
-		return NULL;
-
-	/*  Rounds up to next page size, including whole-page offset */
-	size = PAGE_ALIGN(offset + size);
-
-	area = get_vm_area(size, VM_IOREMAP);
-	addr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
-		vunmap((void *)addr);
-		return NULL;
-	}
-
-	return (void __iomem *) (offset + addr);
-}
-
-void iounmap(const volatile void __iomem *addr)
-{
-	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
-}
-- 
2.34.1

