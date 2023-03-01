Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E56A66BF
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 04:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCADqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 22:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCADqF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 22:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6A38EA5
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2023 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677642272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uaseq8uUQQ6QMQSRfFux0A76lTwwiGZ3GmLj5/5Y0lk=;
        b=QBkL+K9SFVGXtwh762lVJk7IntTpoVAt325+kwNDJpC5sUarSrIhdlY3rquxCznZrHUX97
        mllXjjGIVuu13hRddsQ6Psr/CdWyC6To0vrq8oYiQhVXNEEbW8SmQeh9ydqZ7nijj8kYTH
        3/DmY3zENi6sTBlm6Q9sLRjc5RZXMQU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-Nku5RR7JO3SsoRvpup12WQ-1; Tue, 28 Feb 2023 22:44:28 -0500
X-MC-Unique: Nku5RR7JO3SsoRvpup12WQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C97973C0DDB2;
        Wed,  1 Mar 2023 03:44:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6933CC15BAE;
        Wed,  1 Mar 2023 03:44:21 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        willy@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 14/17] mm/ioremap: Consider IOREMAP space in generic ioremap
Date:   Wed,  1 Mar 2023 11:42:44 +0800
Message-Id: <20230301034247.136007-15-bhe@redhat.com>
In-Reply-To: <20230301034247.136007-1-bhe@redhat.com>
References: <20230301034247.136007-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Architectures like powerpc have a dedicated space for IOREMAP mappings.

If so, use it in generic_ioremap_pro().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/ioremap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 2fbe6b9bc50e..4a7749d85044 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -35,8 +35,13 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
 		return NULL;
 
+#ifdef IOREMAP_START
+	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
+				    IOREMAP_END, __builtin_return_address(0));
+#else
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
+#endif
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
@@ -66,7 +71,7 @@ void generic_iounmap(volatile void __iomem *addr)
 	if (!iounmap_allowed(vaddr))
 		return;
 
-	if (is_vmalloc_addr(vaddr))
+	if (is_ioremap_addr(vaddr))
 		vunmap(vaddr);
 }
 
-- 
2.34.1

