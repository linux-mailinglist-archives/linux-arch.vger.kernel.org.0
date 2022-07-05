Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689D5567373
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiGEPtn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiGEPtP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:49:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DABBDB;
        Tue,  5 Jul 2022 08:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2163CB81829;
        Tue,  5 Jul 2022 15:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38971C36AFD;
        Tue,  5 Jul 2022 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036099;
        bh=HB79TgDejynjwXx+ze+zwa0sbce+L9enN9kanFNzV5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaaPXiob0ep82//FrVUkugWoeOi0PJIcd+2Wbo9XNGm1SekBlXYWrxP28Hyy3Ct+F
         3j256FeKuXjKqDndi3j5r4uoPUZA9vuctkx5BAv5XadhJHOrQ3gGtfOhmv1aZIshms
         HbRNleco7/24QbDai+y+n/PMFj+C9hDB/++B+MUELlJvTd5JfzI2JaZ6Ebj4oYQ7Yr
         bO8XcshzPNDGxtCK2M+cQt/WnraJIwsYYk+KYR9iRZ5Oh4hlmdM9SAxI6UwY2Dwe5r
         SUcWXZDvT86R7ndr2QmwpbAWL4NaZuYEu5ppyv+8yH8fZpYouW044iP0y+4m/qTxyq
         oYEp+vLG55QgA==
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
Subject: [PATCH v2 09/15] loongarch: drop definition of PTE_ORDER
Date:   Tue,  5 Jul 2022 18:47:02 +0300
Message-Id: <20220705154708.181258-10-rppt@kernel.org>
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

This is the order of the page table allocation, not the order of a PTE.
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Huacai Chen <chenhuacai@kernel.org>
---
 arch/loongarch/include/asm/pgtable.h | 9 ++++-----
 arch/loongarch/kernel/asm-offsets.c  | 1 -
 arch/loongarch/mm/tlbex.S            | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index d9e86cfa53e2..e0bbfc31fe72 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -24,17 +24,16 @@
 #define PGD_ORDER		0
 #define PUD_ORDER		0
 #define PMD_ORDER		0
-#define PTE_ORDER		0
 
 #if CONFIG_PGTABLE_LEVELS == 2
-#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
+#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
 #elif CONFIG_PGTABLE_LEVELS == 3
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 #define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
 #elif CONFIG_PGTABLE_LEVELS == 4
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 #define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
@@ -55,7 +54,7 @@
 #if CONFIG_PGTABLE_LEVELS > 2
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) >> 3)
 #endif
-#define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) >> 3)
+#define PTRS_PER_PTE	(PAGE_SIZE >> 3)
 
 #define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index bfb65eb2844f..1a1166a7e61c 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -194,7 +194,6 @@ void output_mm_defines(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	DEFINE(_PMD_ORDER, PMD_ORDER);
 #endif
-	DEFINE(_PTE_ORDER, PTE_ORDER);
 	BLANK();
 	DEFINE(_PMD_SHIFT, PMD_SHIFT);
 	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 7eee40271577..e36c2c07dee3 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -83,7 +83,7 @@ vmalloc_done_load:
 	bne	t0, $r0, tlb_huge_update_load
 
 	csrrd	t0, LOONGARCH_CSR_BADV
-	srli.d	t0, t0, (PAGE_SHIFT + PTE_ORDER)
+	srli.d	t0, t0, PAGE_SHIFT
 	andi	t0, t0, (PTRS_PER_PTE - 1)
 	slli.d	t0, t0, _PTE_T_LOG2
 	add.d	t1, ra, t0
@@ -247,7 +247,7 @@ vmalloc_done_store:
 	bne	t0, $r0, tlb_huge_update_store
 
 	csrrd	t0, LOONGARCH_CSR_BADV
-	srli.d	t0, t0, (PAGE_SHIFT + PTE_ORDER)
+	srli.d	t0, t0, PAGE_SHIFT
 	andi	t0, t0, (PTRS_PER_PTE - 1)
 	slli.d	t0, t0, _PTE_T_LOG2
 	add.d	t1, ra, t0
@@ -414,7 +414,7 @@ vmalloc_done_modify:
 	bne	t0, $r0, tlb_huge_update_modify
 
 	csrrd	t0, LOONGARCH_CSR_BADV
-	srli.d	t0, t0, (PAGE_SHIFT + PTE_ORDER)
+	srli.d	t0, t0, PAGE_SHIFT
 	andi	t0, t0, (PTRS_PER_PTE - 1)
 	slli.d	t0, t0, _PTE_T_LOG2
 	add.d	t1, ra, t0
-- 
2.34.1

