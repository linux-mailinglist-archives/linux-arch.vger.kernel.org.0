Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9871FF9F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjFBKof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjFBKoc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 06:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F11BD
        for <linux-arch@vger.kernel.org>; Fri,  2 Jun 2023 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685702597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phpZd5hK2i2mM+vAnJfGyLfRqwW0axG13fXI7MRFpGs=;
        b=Mcd3L4aUsnJE+6hkNKR3BVyGL/Zv9r0WtYgIoOmpeexpDAxXIch6wS4otPco/E1v3g0+L/
        37mOdAoNorYLVpwdYV0FEsd8FnEmDo6SeJ5BGAmMfVIPtndVUTt4g3++SXmp83/6QL8V8A
        K/SCvFQnlZrO7CZ+QTfY7QZaCpwEQ08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-I1xxHkoXNl6b6j-Eozu2nw-1; Fri, 02 Jun 2023 06:43:07 -0400
X-MC-Unique: I1xxHkoXNl6b6j-Eozu2nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F1F3185A793;
        Fri,  2 Jun 2023 10:43:06 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6936FC154D9;
        Fri,  2 Jun 2023 10:43:04 +0000 (UTC)
Date:   Fri, 2 Jun 2023 18:42:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZHnHs+ro44SBS+lV@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
 <ZGR3yWIdjfJTupgY@infradead.org>
 <ZHXD082+VntWgbNo@MiWiFi-R3L-srv>
 <ZHh9TcwFwzeWU9sx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHh9TcwFwzeWU9sx@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/01/23 at 04:13am, Christoph Hellwig wrote:
> On Tue, May 30, 2023 at 05:37:23PM +0800, Baoquan He wrote:
> > If we want to consolidate code, we can move is_ioremap_addr() to
> > include/linux/mm.h libe below. Not sure if it's fine. With it,
> > both kernel/iomem.c and mm/ioremap.c can use is_ioremap_addr().
> 
> Can we just add a ne header for this given that no one else really
> needs it?

Is it OK like below?

From fe5d4d25afa1e989fa82877c8466a97fc8bd8c93 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 2 Jun 2023 18:36:48 +0800
Subject: [PATCH] mm: move is_ioremap_addr() into new header file
Content-type: text/plain

Now is_ioremap_addr() is only used in kernel/iomem.c and gonna be used
in mm/ioremap.c. Move it into its own new header file linux/ioremap.h.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/ioremap.h | 29 +++++++++++++++++++++++++++++
 include/linux/mm.h      |  5 -----
 kernel/iomem.c          |  1 +
 mm/ioremap.c            |  1 +
 4 files changed, 31 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/ioremap.h

diff --git a/include/linux/ioremap.h b/include/linux/ioremap.h
new file mode 100644
index 000000000000..2fd51a77ebdc
--- /dev/null
+++ b/include/linux/ioremap.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IOREMAP_H
+#define _LINUX_IOREMAP_H
+
+#include <linux/kasan.h>
+#include <asm/pgtable.h>
+
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
+#endif
+
+#endif /* _LINUX_IOREMAP_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..7379f19768b4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1041,11 +1041,6 @@ unsigned long vmalloc_to_pfn(const void *addr);
  * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
  * is no special casing required.
  */
-
-#ifndef is_ioremap_addr
-#define is_ioremap_addr(x) is_vmalloc_addr(x)
-#endif
-
 #ifdef CONFIG_MMU
 extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
diff --git a/kernel/iomem.c b/kernel/iomem.c
index 62c92e43aa0d..9682471e6471 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/ioremap.h>
 
 #ifndef ioremap_cache
 /* temporary while we convert existing ioremap_cache users to memremap */
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 0248e630561b..3dede3302eba 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/export.h>
+#include <linux/ioremap.h>
 
 /*
  * Ioremap often, but not always uses the generic vmalloc area. E.g on
-- 
2.34.1

> 
> 

