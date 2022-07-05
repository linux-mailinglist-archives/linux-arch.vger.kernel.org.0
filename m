Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60BA56736F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiGEPtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiGEPsg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76271ADB9;
        Tue,  5 Jul 2022 08:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D4361B4A;
        Tue,  5 Jul 2022 15:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC7C36AF5;
        Tue,  5 Jul 2022 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036093;
        bh=Vue7H8LCr+M1pj6DZ3BvkAhUx8ulVRB7UqrqmOhXw0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUuAjX3ls21sld82+qncE1IqLvb+UaJbLEzg+zR4FHBiItcxPyQI9YPQPiPrexqHK
         rFngIr/HU/ZA0Ev4D41wN+HP076RxleRBt/L69xJ/B8r16G4gDNVgEG6/nl62cN3l5
         CVHVfgu25+HyKSo8bauTWNkf0JIw2IXiMDVlrUvOiCbBa2i+meVIloBk3mrraZlKaV
         iFg6LI+OPWIHIgnO3SdFXCOUW/cVI6HpVoGQuYww7GJC2D8zjTX4BASR34IGXkg/fG
         Wy4mtYDz1nqMgrCdSnu4I5NG++Nh9pYJ1t4EHgncfXjBqZLyxEIUQspta5O/gphKJ9
         hjOLZDMDfCkMw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH v2 08/15] nios2: drop definition of PGD_ORDER
Date:   Tue,  5 Jul 2022 18:47:01 +0300
Message-Id: <20220705154708.181258-9-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705154708.181258-1-rppt@kernel.org>
References: <20220705154708.181258-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

This is the order of the page table allocation, not the order of a PGD.
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nios2/include/asm/pgtable.h | 4 +---
 arch/nios2/mm/init.c             | 3 +--
 arch/nios2/mm/pgtable.c          | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index eaf8f28baa8b..74af16dafe86 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -68,9 +68,7 @@ struct mm_struct;
 
 #define PAGE_COPY MKP(0, 0, 1)
 
-#define PGD_ORDER	0
-
-#define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#define PTRS_PER_PGD	(PAGE_SIZE / sizeof(pgd_t))
 #define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD	\
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 2d6dbf7701f6..eab65e8ea69c 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -78,8 +78,7 @@ void __init mmu_init(void)
 	flush_tlb_all();
 }
 
-#define __page_aligned(order) __aligned(PAGE_SIZE << (order))
-pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __aligned(PAGE_SIZE);
 pte_t invalid_pte_table[PTRS_PER_PTE] __aligned(PAGE_SIZE);
 static struct page *kuser_page[1];
 
diff --git a/arch/nios2/mm/pgtable.c b/arch/nios2/mm/pgtable.c
index 9b587fd592dd..7c76e8a7447a 100644
--- a/arch/nios2/mm/pgtable.c
+++ b/arch/nios2/mm/pgtable.c
@@ -54,7 +54,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret, *init;
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
+	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
-- 
2.34.1

