Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFF70280D
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjEOJOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjEOJN1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 05:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5457010DD
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2023 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684141855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uaseq8uUQQ6QMQSRfFux0A76lTwwiGZ3GmLj5/5Y0lk=;
        b=flycym+Ynt7xbcB0oQPyi6aV376DqhbhQanJs1xwwDnpjtumtd9YKozakmbt/Zc75MZDpd
        q0D73Jt+qcLeKVomLEN6SzRZTyNAHKdRhZS2hfL3rXhOKU7qqfhPkMX3KtsST0pCeM9PHG
        0/GZAfVeBqjzYwm6SHVXWZJlcflWFDs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-ER6juC3BMNSvQDD-_oKHbw-1; Mon, 15 May 2023 05:10:50 -0400
X-MC-Unique: ER6juC3BMNSvQDD-_oKHbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A324585A588;
        Mon, 15 May 2023 09:10:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3611340C2070;
        Mon, 15 May 2023 09:10:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in generic ioremap
Date:   Mon, 15 May 2023 17:08:45 +0800
Message-Id: <20230515090848.833045-15-bhe@redhat.com>
In-Reply-To: <20230515090848.833045-1-bhe@redhat.com>
References: <20230515090848.833045-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

