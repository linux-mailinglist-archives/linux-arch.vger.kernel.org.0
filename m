Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A636D7291E0
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 09:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbjFIH55 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbjFIH5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F7359C
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1cwgKpxB+oYTQq0br6utRWEYNI4guxqhcfHp/vK96c=;
        b=hmD3SnBUvWOR9U03gxZ0MZpRH3T0wH+srnXs1WA3FiPXYBeZKmWoFtmAdCBAmWiLXrfIGW
        WD4+0nY4CYM0B00VJVZY4z5ZsO0HLVoBHIGo4s175QFNsqAktql8N8y3ccJWRAHS2SJW/G
        RjwoHkMoPF+G4/pkOQr4Hr8omwP79p8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-KXU_qVZcOVSgr_rQs7LwAQ-1; Fri, 09 Jun 2023 03:56:01 -0400
X-MC-Unique: KXU_qVZcOVSgr_rQs7LwAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4B8085A5BA;
        Fri,  9 Jun 2023 07:56:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 012CE20268C6;
        Fri,  9 Jun 2023 07:55:53 +0000 (UTC)
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
Subject: [PATCH v6 03/19] openrisc: mm: remove unneeded early ioremap code
Date:   Fri,  9 Jun 2023 15:55:12 +0800
Message-Id: <20230609075528.9390-4-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Under arch/openrisc, there isn't any place where ioremap() is called.
It means that there isn't early ioremap handling needed in openrisc,
So the early ioremap handling code in ioremap() of
arch/openrisc/mm/ioremap.c is unnecessary and can be removed.

And also remove the special handling in iounmap() since no page
is got from fixmap pool along with early ioremap code removing
in ioremap().

Link: https://lore.kernel.org/linux-mm/YwxfxKrTUtAuejKQ@oscomms1/
Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
v5->v6:
  Remove the special handling in iounmap() because no page is got from
  fixmap pool along with early ioremap code removing in ioremap() - Mike.

 arch/openrisc/mm/ioremap.c | 43 +++++---------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index 8ec0dafecf25..cdbcc7e73684 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -22,8 +22,6 @@
 
 extern int mem_init_done;
 
-static unsigned int fixmaps_used __initdata;
-
 /*
  * Remap an arbitrary physical address space into the kernel virtual
  * address space. Needed when the kernel wants to access high addresses
@@ -52,24 +50,14 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 	p = addr & PAGE_MASK;
 	size = PAGE_ALIGN(last_addr + 1) - p;
 
-	if (likely(mem_init_done)) {
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-		v = (unsigned long)area->addr;
-	} else {
-		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
-			return NULL;
-		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
-		fixmaps_used += (size >> PAGE_SHIFT);
-	}
+	area = get_vm_area(size, VM_IOREMAP);
+	if (!area)
+		return NULL;
+	v = (unsigned long)area->addr;
 
 	if (ioremap_page_range(v, v + size, p,
 			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
-		if (likely(mem_init_done))
-			vfree(area->addr);
-		else
-			fixmaps_used -= (size >> PAGE_SHIFT);
+		vfree(area->addr);
 		return NULL;
 	}
 
@@ -79,27 +67,6 @@ EXPORT_SYMBOL(ioremap);
 
 void iounmap(volatile void __iomem *addr)
 {
-	/* If the page is from the fixmap pool then we just clear out
-	 * the fixmap mapping.
-	 */
-	if (unlikely((unsigned long)addr > FIXADDR_START)) {
-		/* This is a bit broken... we don't really know
-		 * how big the area is so it's difficult to know
-		 * how many fixed pages to invalidate...
-		 * just flush tlb and hope for the best...
-		 * consider this a FIXME
-		 *
-		 * Really we should be clearing out one or more page
-		 * table entries for these virtual addresses so that
-		 * future references cause a page fault... for now, we
-		 * rely on two things:
-		 *   i)  this code never gets called on known boards
-		 *   ii) invalid accesses to the freed areas aren't made
-		 */
-		flush_tlb_all();
-		return;
-	}
-
 	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.34.1

