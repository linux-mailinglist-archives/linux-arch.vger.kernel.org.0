Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2D729212
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjFIIBC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbjFIIA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0E46BB
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81nV18C3v1lk6vsTsYHvlL2VrwGGV2i7WxKaTwXwgOE=;
        b=IHbDQqQlSkyz2yVF9dqkkD4V0CBTIUr0hP1ldrGxLF+bcyZgo6SOiodLn+OiS/yWNuPCvc
        DCHmR0EVELwjiz4gjWnHW6sZqceOkf96Wrt18Qpg5TxKiJ2xnb/KxMBRtll/PaKl0D9nbl
        nfoQ3h/R3jgCW8rnBdleKkOKe2KYv7g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-ka62SOjHPdCC3QS6MTgItw-1; Fri, 09 Jun 2023 03:57:45 -0400
X-MC-Unique: ka62SOjHPdCC3QS6MTgItw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A34AD3C0CEF9;
        Fri,  9 Jun 2023 07:57:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B08E20268C7;
        Fri,  9 Jun 2023 07:57:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 18/19] arm64 : mm: add wrapper function ioremap_prot()
Date:   Fri,  9 Jun 2023 15:55:27 +0800
Message-Id: <20230609075528.9390-19-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since hook functions ioremap_allowed() and iounmap_allowed() will be
obsoleted, add wrapper function ioremap_prot() to contain the
specific handling in addition to generic_ioremap_prot() invocation.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
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

