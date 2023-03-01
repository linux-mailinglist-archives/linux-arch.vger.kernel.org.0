Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327F6A66C3
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 04:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCADqv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 22:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCADq3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 22:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CD38E9C
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2023 19:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677642289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZjhNHfCq0k8rI1ELCJTN8u4w8f61XUm94YTHptLe20=;
        b=XXha/xgJn7rNDJveHy3iMk0u/MIKCYaj1UQfGgsgoPuz8zsJDq4j6Cxd71HYfi1IZqcI/9
        A4DHOOuPMbkbasB5Ev3G12i3CGP5Sn1Ii08oXU8saYUzFM4SY1wtF0l9XHQB401xgF5wwD
        Mra/Rff0hLxI0YWcne5IzmT4bXoRLUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-L7cYu-UcO7uMwCSPp8Rblg-1; Tue, 28 Feb 2023 22:44:43 -0500
X-MC-Unique: L7cYu-UcO7uMwCSPp8Rblg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 451DC87B2A2;
        Wed,  1 Mar 2023 03:44:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2A5DC15BAD;
        Wed,  1 Mar 2023 03:44:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        willy@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 17/17] mm: ioremap: remove unneeded ioremap_allowed and iounmap_allowed
Date:   Wed,  1 Mar 2023 11:42:47 +0800
Message-Id: <20230301034247.136007-18-bhe@redhat.com>
In-Reply-To: <20230301034247.136007-1-bhe@redhat.com>
References: <20230301034247.136007-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now there are no users of ioremap_allowed and iounmap_allowed, clean
them up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/asm-generic/io.h | 26 --------------------------
 mm/ioremap.c             |  6 ------
 2 files changed, 32 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 29ee791164ac..c13109d17dcb 100644
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
index 4a7749d85044..8cb337446bba 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -32,9 +32,6 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
-		return NULL;
-
 #ifdef IOREMAP_START
 	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
 				    IOREMAP_END, __builtin_return_address(0));
@@ -68,9 +65,6 @@ void generic_iounmap(volatile void __iomem *addr)
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

