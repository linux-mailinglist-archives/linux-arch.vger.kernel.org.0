Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E30736D1F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjFTNUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 09:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjFTNT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 09:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DDC1730
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687267108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72w03eJEhQqo4F/RBmYdJ2/NuxxsDP8AZF6XbBTG/zk=;
        b=DDUQqo1fFnhr0VufaWuE/18WeIlf8jJ8md0AWL7q0MN0aXvPLHBFqtGZWQobpNXiHVqvUw
        xYIhgzi0w71nMgVEkw9jLQw2HwkowC3f9qTB2xsi0XunVyLI+mKZGnwzWoF/+Lm6IQT4L/
        G3oNnLPHFIdVxQLvctizmXPzQA9hI2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-IvFW2tAHNyCwbGqZN7_6DA-1; Tue, 20 Jun 2023 09:18:22 -0400
X-MC-Unique: IvFW2tAHNyCwbGqZN7_6DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3289185A795;
        Tue, 20 Jun 2023 13:17:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9852C1ED96;
        Tue, 20 Jun 2023 13:16:52 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 18/19] arm64 : mm: add wrapper function ioremap_prot()
Date:   Tue, 20 Jun 2023 21:13:55 +0800
Message-Id: <20230620131356.25440-19-bhe@redhat.com>
In-Reply-To: <20230620131356.25440-1-bhe@redhat.com>
References: <20230620131356.25440-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since hook functions ioremap_allowed() and iounmap_allowed() will be
obsoleted, add wrapper function ioremap_prot() to contain the
the specific handling in addition to generic_ioremap_prot() invocation.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/io.h |  3 +--
 arch/arm64/mm/ioremap.c     | 10 ++++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 877495a0fd0c..97dd4ff1253b 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -139,8 +139,7 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
-#define ioremap_allowed ioremap_allowed
+#define ioremap_prot ioremap_prot
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index c5af103d4ad4..269f2f63ab7d 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,20 +3,22 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
 {
 	unsigned long last_addr = phys_addr + size - 1;
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
-		return false;
+		return NULL;
 
 	/* Don't allow RAM to be mapped. */
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
-		return false;
+		return NULL;
 
-	return true;
+	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
 }
+EXPORT_SYMBOL(ioremap_prot);
 
 /*
  * Must be called after early_fixmap_init
-- 
2.34.1

