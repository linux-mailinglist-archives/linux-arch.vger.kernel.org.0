Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72E736D13
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjFTNTf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjFTNSt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 09:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A61A1BDA
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687267049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8YWy6B/dkgubJEAfONkbnYrM9N6ISZoYICTMz8lkkw=;
        b=COsoQdm7tV1CiGho5RM9tXMmgo3MhVBGn6+1pW8OsoMtKu98VxGiDjcBqqC5a2Qt5cHGl/
        rbaNsVrw3j8QArS0lrWeyVQslSZbo6WAETs2daSVPDsTHD2WkmprZlHoU2dVKAivtvWUVZ
        b51qJDZvn3GFbHyYPyOzL8zO7Q+NFDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-ez00HCYEMsyDPHbeiCsRCQ-1; Tue, 20 Jun 2023 09:17:24 -0400
X-MC-Unique: ez00HCYEMsyDPHbeiCsRCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 729AE1039D34;
        Tue, 20 Jun 2023 13:16:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 906A4C1ED96;
        Tue, 20 Jun 2023 13:16:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 16/19] mm: move is_ioremap_addr() into new header file
Date:   Tue, 20 Jun 2023 21:13:53 +0800
Message-Id: <20230620131356.25440-17-bhe@redhat.com>
In-Reply-To: <20230620131356.25440-1-bhe@redhat.com>
References: <20230620131356.25440-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now is_ioremap_addr() is only used in kernel/iomem.c and gonna be used
in mm/ioremap.c. Move it into its own new header file linux/ioremap.h.

Signed-off-by: Baoquan He <bhe@redhat.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/pgtable.h |  8 --------
 include/linux/ioremap.h            | 30 ++++++++++++++++++++++++++++++
 include/linux/mm.h                 |  5 -----
 kernel/iomem.c                     |  1 +
 mm/ioremap.c                       | 10 +---------
 5 files changed, 32 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/ioremap.h

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9972626ddaf6..d252323a753f 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -158,14 +158,6 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 }
 
 #ifdef CONFIG_PPC64
-#define is_ioremap_addr is_ioremap_addr
-static inline bool is_ioremap_addr(const void *x)
-{
-	unsigned long addr = (unsigned long)x;
-
-	return addr >= IOREMAP_BASE && addr < IOREMAP_END;
-}
-
 struct seq_file;
 void arch_report_meminfo(struct seq_file *m);
 #endif /* CONFIG_PPC64 */
diff --git a/include/linux/ioremap.h b/include/linux/ioremap.h
new file mode 100644
index 000000000000..f0e99fc7dd8b
--- /dev/null
+++ b/include/linux/ioremap.h
@@ -0,0 +1,30 @@
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
+
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
index 68d9895144ad..a21a6c9fa5ab 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -10,15 +10,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/export.h>
-
-/*
- * Ioremap often, but not always uses the generic vmalloc area. E.g on
- * Power ARCH, it could have different ioremap space.
- */
-#ifndef IOREMAP_START
-#define IOREMAP_START   VMALLOC_START
-#define IOREMAP_END     VMALLOC_END
-#endif
+#include <linux/ioremap.h>
 
 void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 				   pgprot_t prot)
-- 
2.34.1

