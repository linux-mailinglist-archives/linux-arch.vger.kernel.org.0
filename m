Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE65F8AA0
	for <lists+linux-arch@lfdr.de>; Sun,  9 Oct 2022 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJIKcq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Oct 2022 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiJIKc0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 06:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390502E6A8
        for <linux-arch@vger.kernel.org>; Sun,  9 Oct 2022 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0wz1H1leA7CuWV687C4HqKWq96HEonICKC1esEFR0M=;
        b=U0TE9ILg9Q3gAWolGbTawyzTVwGLbHIp+FiPYsCfgYigKvzWwoIybC3i6vIshBPHMI6zuC
        dVWB1IYgEI86oxYGzxZsL/8U8waM/ltzHDXnBdMlS+72/TJdCrrtTIJ5vFpDiYDnZrOqWN
        oudX87bKhiFgwNQyb18hXzg/X7Ei/N4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-HV8un_y7MuqyqxHBgOZLEg-1; Sun, 09 Oct 2022 06:32:12 -0400
X-MC-Unique: HV8un_y7MuqyqxHBgOZLEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5265729AB3FD;
        Sun,  9 Oct 2022 10:32:11 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8D640D298B;
        Sun,  9 Oct 2022 10:31:48 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH v3 04/11] mm: ioremap: allow ARCH to have its own ioremap definition
Date:   Sun,  9 Oct 2022 18:31:07 +0800
Message-Id: <20221009103114.149036-5-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-1-bhe@redhat.com>
References: <20221009103114.149036-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architectures like xtensa, arc, can be converted to GENERIC_IOREMAP,
to take standard ioremap_prot() and ioremap_xxx() way. But they have
ARCH specific handling for ioremap() method, than standard ioremap()
method.

In oder to convert them to take GENERIC_IOREMAP method, allow these
architecutres to have their own ioremap definition.

This is a preparation patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 2ae16906f3be..8878914579d8 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1078,11 +1078,14 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
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
-- 
2.34.1

