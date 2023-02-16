Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC01699473
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBPMfr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Feb 2023 07:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjBPMfq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2023 07:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846D3A85C
        for <linux-arch@vger.kernel.org>; Thu, 16 Feb 2023 04:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676550903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gn5xqT9XfmH8tKovLjSHCJ1d21jDbu3NIptvTi8Sio=;
        b=ZxhAR0g128yuxW81NjzzRu99CvsepOx6p5IniM7Il6vyiOYkiN1rGjD2fN/kTNyjZK0Ayp
        AuOR9ViBny2q07OQaWE0ZTXPSRy3Il4+V0h70pZNmWSVXv+HTXLucWVVfI7LNN4Xgp8dZJ
        Y0foul7qeRdjxOxCuPhi8M85zHyt2Fg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-2MLUCqQ5OUieeNkqxfzfVw-1; Thu, 16 Feb 2023 07:35:00 -0500
X-MC-Unique: 2MLUCqQ5OUieeNkqxfzfVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7027B381494E;
        Thu, 16 Feb 2023 12:34:59 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C55D1492C3C;
        Thu, 16 Feb 2023 12:34:53 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        arnd@arndb.de, Baoquan He <bhe@redhat.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 04/16] mm: ioremap: allow ARCH to have its own ioremap method definition
Date:   Thu, 16 Feb 2023 20:34:07 +0800
Message-Id: <20230216123419.461016-5-bhe@redhat.com>
In-Reply-To: <20230216123419.461016-1-bhe@redhat.com>
References: <20230216123419.461016-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architectures can be converted to GENERIC_IOREMAP, to take standard
ioremap_xxx() and iounmap() way. But some ARCH-es could have specific
handling for ioremap_prot(), ioremap() and iounmap(), than standard
methods.

In oder to convert these ARCH-es to take GENERIC_IOREMAP, allow these
architecutres to have their own ioremap_prot(), ioremap() and iounmap()
definitions.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/io.h | 3 +++
 mm/ioremap.c             | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 5a9cf16ee0c2..29ee791164ac 100644
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

