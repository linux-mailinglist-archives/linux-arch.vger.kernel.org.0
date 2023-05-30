Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0D715A50
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjE3Ji0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 05:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjE3JiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B799C
        for <linux-arch@vger.kernel.org>; Tue, 30 May 2023 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685439454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3KL3EHQXIEMhG+qF6ouz6Zrek1DaRJ8+MJLe7WdMsQ=;
        b=ao+ujpc913UY6tHVZZdX5I6LWaSJpyDTqscHwqZxa/gJqiS2MG2cMakW+9SYC29jAtCg3e
        rrzSoivEwZHPoedIdLdCVS4OGVRG3lOcGlny6I+66ZK8g12MpjJXzJFfTBBvHj7eMfOuFE
        3cyYt9PxBFSLfV3ZXS2uP7sikV1EF0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-1_ez37_sOBKnhBkfjuZVmg-1; Tue, 30 May 2023 05:37:29 -0400
X-MC-Unique: 1_ez37_sOBKnhBkfjuZVmg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68A0C85A5BB;
        Tue, 30 May 2023 09:37:28 +0000 (UTC)
Received: from localhost (ovpn-12-192.pek2.redhat.com [10.72.12.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3550F43E907;
        Tue, 30 May 2023 09:37:26 +0000 (UTC)
Date:   Tue, 30 May 2023 17:37:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZHXD082+VntWgbNo@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
 <ZGR3yWIdjfJTupgY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR3yWIdjfJTupgY@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:44pm, Christoph Hellwig wrote:
> On Tue, May 16, 2023 at 11:41:26PM -0700, Christoph Hellwig wrote:
> > I think this would be cleaner if we'd just always use
> > __get_vm_area_caller and at the top of the file add a:
> > 
> > #ifndef IOREMAP_START
> > #define IOREMAP_START	VMALLOC_START
> > #define IOREMAP_END	VMALLOC_END
> > #endif
> > 
> > Together with a little comment that ioremap often, but not always
> > uses the generic vmalloc area.
> 
> .. and with that we can also simply is_ioremap_addr by moving it
> to ioremap.c and making it always operate on the IOREMAP constants.

In the current code, is_ioremap_addr() is being used in kernel/iomem.c.
However, mm/ioremap.c is only built in when CONFIG_GENERIC_IOREMAP is
enabled. This will impact those architectures which haven't taken
GENERIC_IOREMAP way.

[~]$ git grep is_ioremap_addr
arch/powerpc/include/asm/pgtable.h:#define is_ioremap_addr is_ioremap_addr
arch/powerpc/include/asm/pgtable.h:static inline bool is_ioremap_addr(const void *x)
include/linux/mm.h:static inline bool is_ioremap_addr(const void *x)
include/linux/mm.h:static inline bool is_ioremap_addr(const void *x)
kernel/iomem.c: if (is_ioremap_addr(addr))
mm/ioremap.c:   if (is_ioremap_addr(vaddr))

[bhe@MiWiFi-R3L-srv linux-arm64]$ git grep ioremap mm/Makefile
mm/Makefile:obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
mm/Makefile:obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o

If we want to consolidate code, we can move is_ioremap_addr() to
include/linux/mm.h libe below. Not sure if it's fine. With it,
both kernel/iomem.c and mm/ioremap.c can use is_ioremap_addr().

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..0fbb94f0f025 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1041,9 +1041,25 @@ unsigned long vmalloc_to_pfn(const void *addr);
  * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
  * is no special casing required.
  */
-
-#ifndef is_ioremap_addr
-#define is_ioremap_addr(x) is_vmalloc_addr(x)
+#if defined(CONFIG_HAS_IOMEM) || defined(CONFIG_GENERIC_IOREMAP)
+/*
+ * Ioremap often, but not always uses the generic vmalloc area. E.g on
+ * Power ARCH, it could have different ioremap space. 
+ */
+#ifndef IOREMAP_START
+#define IOREMAP_START   VMALLOC_START
+#define IOREMAP_END     VMALLOC_END
+#endif
+static inline bool is_ioremap_addr(const void *x)
+{
+	unsigned long addr = (unsigned long)kasan_reset_tag(x);
+	return addr >= IOREMAP_START && addr < IOREMAP_END;
+}
+#else
+static inline bool is_ioremap_addr(const void *x)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_MMU

