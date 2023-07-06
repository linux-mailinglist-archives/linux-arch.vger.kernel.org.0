Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307C74A158
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGFPrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGFPrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 11:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37A419B7
        for <linux-arch@vger.kernel.org>; Thu,  6 Jul 2023 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688658381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Tl0uNK3iTFKABiIz7zb0nAC1GuwS9Iddx7rewdSaxU=;
        b=BcZW9/s8qf/8IseG6MVfGuIvHVrYJPc+C8Cbp1DZ9ITSDBn2JDYu2sQtgHZO5zezjudZMB
        rJwHU81TRj/R22W73hQj9OFkHHsQAvzkIZERTf1YK+g1/x5qSvb710jbEE+ZTRTN39btNE
        i5pBviySDHNSo+U8+MsEdMrTd62u3W4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-ySB3notAN_2JJ180Qz1p8g-1; Thu, 06 Jul 2023 11:46:19 -0400
X-MC-Unique: ySB3notAN_2JJ180Qz1p8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F2CF858F1E;
        Thu,  6 Jul 2023 15:46:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE6B8F5CF0;
        Thu,  6 Jul 2023 15:46:09 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        shorne@gmail.com, David.Laight@ACULAB.COM, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>, linux-arch@vger.kernel.org
Subject: [PATCH v8 05/19] mm: ioremap: allow ARCH to have its own ioremap method definition
Date:   Thu,  6 Jul 2023 23:45:06 +0800
Message-Id: <20230706154520.11257-6-bhe@redhat.com>
In-Reply-To: <20230706154520.11257-1-bhe@redhat.com>
References: <20230706154520.11257-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architectures can be converted to GENERIC_IOREMAP, to take standard
ioremap_xxx() and iounmap() way. But some ARCH-es could have specific
handling for ioremap_prot(), ioremap() and iounmap(), than standard
methods.

In oder to convert these ARCH-es to take GENERIC_IOREMAP method, allow
these architecutres to have their own ioremap_prot(), ioremap() and
iounmap() definitions.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/io.h | 3 +++
 mm/ioremap.c             | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a7ca2099ba19..39244c3ee797 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1081,11 +1081,14 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 void iounmap(volatile void __iomem *addr);
 void generic_iounmap(volatile void __iomem *addr);
 
+#ifndef ioremap
+#define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
 	/* _PAGE_IOREMAP needs to be supplied by the architecture */
 	return ioremap_prot(addr, size, _PAGE_IOREMAP);
 }
+#endif
 #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
 
 #ifndef ioremap_wc
diff --git a/mm/ioremap.c b/mm/ioremap.c
index db6234b9db59..9f34a8f90b58 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -46,12 +46,14 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	return (void __iomem *)(vaddr + offset);
 }
 
+#ifndef ioremap_prot
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot)
 {
 	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
 }
 EXPORT_SYMBOL(ioremap_prot);
+#endif
 
 void generic_iounmap(volatile void __iomem *addr)
 {
@@ -64,8 +66,10 @@ void generic_iounmap(volatile void __iomem *addr)
 		vunmap(vaddr);
 }
 
+#ifndef iounmap
 void iounmap(volatile void __iomem *addr)
 {
 	generic_iounmap(addr);
 }
 EXPORT_SYMBOL(iounmap);
+#endif
-- 
2.34.1

