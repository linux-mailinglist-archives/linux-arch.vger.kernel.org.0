Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17C6736D1A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjFTNUH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjFTNTS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 09:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0019B9
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687267083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keQ78Mv/VCFMjxLJbgEgr2h/sjN0UpPUn6QsvR3JRNU=;
        b=PuAhRBNVJuCwQhU2Hz70kgZ6/8jXDfK1O5K3qkeOCkYaDQjIVnpHtSEqX8/AoawLBCtqts
        yvQ44TUv/jXNrZbcelrOHLN5g5hiG+aF6qvowuhdbgA3ltSZjl5fi/WOLQgQv4udzCeuRq
        93eHyENlDtD80vv27Tmc6WY5CmGf5fo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-10jviPZINQmT4T6apGJu0w-1; Tue, 20 Jun 2023 09:17:55 -0400
X-MC-Unique: 10jviPZINQmT4T6apGJu0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 934BC3C0F691;
        Tue, 20 Jun 2023 13:17:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA753C478C7;
        Tue, 20 Jun 2023 13:17:02 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 19/19] mm: ioremap: remove unneeded ioremap_allowed and iounmap_allowed
Date:   Tue, 20 Jun 2023 21:13:56 +0800
Message-Id: <20230620131356.25440-20-bhe@redhat.com>
In-Reply-To: <20230620131356.25440-1-bhe@redhat.com>
References: <20230620131356.25440-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now there are no users of ioremap_allowed and iounmap_allowed, clean
them up.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/asm-generic/io.h | 26 --------------------------
 mm/ioremap.c             |  6 ------
 2 files changed, 32 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 39244c3ee797..bac63e874c7b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1047,32 +1047,6 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
-/*
- * Arch code can implement the following two hooks when using GENERIC_IOREMAP
- * ioremap_allowed() return a bool,
- *   - true means continue to remap
- *   - false means skip remap and return directly
- * iounmap_allowed() return a bool,
- *   - true means continue to vunmap
- *   - false means skip vunmap and return directly
- */
-#ifndef ioremap_allowed
-#define ioremap_allowed ioremap_allowed
-static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
-				   unsigned long prot)
-{
-	return true;
-}
-#endif
-
-#ifndef iounmap_allowed
-#define iounmap_allowed iounmap_allowed
-static inline bool iounmap_allowed(void *addr)
-{
-	return true;
-}
-#endif
-
 void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 				   pgprot_t prot);
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index a21a6c9fa5ab..3e049dfb28bd 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -33,9 +33,6 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
-		return NULL;
-
 	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
 				    IOREMAP_END, __builtin_return_address(0));
 	if (!area)
@@ -64,9 +61,6 @@ void generic_iounmap(volatile void __iomem *addr)
 {
 	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
 
-	if (!iounmap_allowed(vaddr))
-		return;
-
 	if (is_ioremap_addr(vaddr))
 		vunmap(vaddr);
 }
-- 
2.34.1

