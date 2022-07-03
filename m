Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BCE5647C8
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiGCOOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiGCON1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46965389D;
        Sun,  3 Jul 2022 07:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D897060EBA;
        Sun,  3 Jul 2022 14:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC649C341CF;
        Sun,  3 Jul 2022 14:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857599;
        bh=SjvzdzE2ttb5T4CvAtofk3e4OOOHvWuIERA5ikgNjmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siH4M69sheNMyxc/JpYu8lPCDXTyunyYIiDWEyB5IkRDloa5bkujqL2b9/nYTNRBZ
         K23e89eTVvZu5aZ7UwzYLMaX1bQCsHsHKwNuuFO9mvOIJkB0IspdA3tmlQ1ogNN+4E
         oeAmY8ydY6PCwzOi0Qz5vh/feaf4wy9cEJKEDSBND30Oweo7w535DkkXw0koY/mAlo
         dn9A/M8nMHzj00eQZ5b7j77+VEWaa03Ij4eszc3zp/13wEsIrVKCWlONmfu1wJshiB
         h7T3Cxi6gX2/78U0EV5pdogYFQVGQbrv3wD5MO29jpCb75ze+qpPWgpoO1C3s9WGp+
         bIYYz5FFpcs8A==
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH 10/14] loongarch: drop definition of PMD_ORDER
Date:   Sun,  3 Jul 2022 17:11:59 +0300
Message-Id: <20220703141203.147893-11-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220703141203.147893-1-rppt@kernel.org>
References: <20220703141203.147893-1-rppt@kernel.org>
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

This is the order of the page table allocation, not the order of a PMD.
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/loongarch/include/asm/pgalloc.h | 4 ++--
 arch/loongarch/include/asm/pgtable.h | 7 +++----
 arch/loongarch/kernel/asm-offsets.c  | 3 ---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index b0a57b25c131..93e785f46639 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -66,12 +66,12 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	pmd_t *pmd;
 	struct page *pg;
 
-	pg = alloc_pages(GFP_KERNEL_ACCOUNT, PMD_ORDER);
+	pg = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!pg)
 		return NULL;
 
 	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_pages(pg, PMD_ORDER);
+		__free_page(pg);
 		return NULL;
 	}
 
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index e0bbfc31fe72..f926537d2233 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -23,7 +23,6 @@
 
 #define PGD_ORDER		0
 #define PUD_ORDER		0
-#define PMD_ORDER		0
 
 #if CONFIG_PGTABLE_LEVELS == 2
 #define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
@@ -31,12 +30,12 @@
 #define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT - 3))
 #elif CONFIG_PGTABLE_LEVELS == 4
 #define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT - 3))
 #define PUD_SIZE	(1UL << PUD_SHIFT)
 #define PUD_MASK	(~(PUD_SIZE-1))
 #define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT + PUD_ORDER - 3))
@@ -52,7 +51,7 @@
 #define PTRS_PER_PUD	((PAGE_SIZE << PUD_ORDER) >> 3)
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-#define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) >> 3)
+#define PTRS_PER_PMD	(PAGE_SIZE >> 3)
 #endif
 #define PTRS_PER_PTE	(PAGE_SIZE >> 3)
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 1a1166a7e61c..aa4ef42d759f 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -191,9 +191,6 @@ void output_mm_defines(void)
 	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
 	BLANK();
 	DEFINE(_PGD_ORDER, PGD_ORDER);
-#ifndef __PAGETABLE_PMD_FOLDED
-	DEFINE(_PMD_ORDER, PMD_ORDER);
-#endif
 	BLANK();
 	DEFINE(_PMD_SHIFT, PMD_SHIFT);
 	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
-- 
2.34.1

