Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9545FC37F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJLKKi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 06:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLKKU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 06:10:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37953CBED;
        Wed, 12 Oct 2022 03:10:17 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MnT0w6ZHKz9sn8;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ydu5fOwW78u4; Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MnT0w5qSSz9sn3;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB7A98B77A;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sQNVSoiAGiNq; Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 012BB8B774;
        Wed, 12 Oct 2022 12:10:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 29CA9xNq1165804
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:09:59 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 29CA9xw41165803;
        Wed, 12 Oct 2022 12:09:59 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com
Subject: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic ioremap
Date:   Wed, 12 Oct 2022 12:09:43 +0200
Message-Id: <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1665568707.git.christophe.leroy@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665569382; l=1074; s=20211009; h=from:subject:message-id; bh=ELyr8PUsyD4mIfYsRSsdsfitAttTXEVDCquGDiFLN50=; b=MbLqqgcB49+PcaWOwavlBma2KxRl7NhNM0e3IhcyfyMIM6BgTnQF9m/+4m45QTF1wvkc4p+sMunj HT6K6uKVDVjjy4tF7tedmQcjX4nTnCt27/jozV0VB73DgHSpY0In
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some architecture have a dedicated space for IOREMAP mappings.

If so, use it in generic_ioremap_pro().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/ioremap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 9f34a8f90b58..a2be9cda975b 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -31,8 +31,13 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
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
@@ -62,7 +67,7 @@ void generic_iounmap(volatile void __iomem *addr)
 	if (!iounmap_allowed(vaddr))
 		return;
 
-	if (is_vmalloc_addr(vaddr))
+	if (is_ioremap_addr(vaddr))
 		vunmap(vaddr);
 }
 
-- 
2.37.1

