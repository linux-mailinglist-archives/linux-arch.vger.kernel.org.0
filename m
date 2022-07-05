Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1576356731C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiGEPsG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGEPr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260C18E19;
        Tue,  5 Jul 2022 08:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23B461B22;
        Tue,  5 Jul 2022 15:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E1FC341CA;
        Tue,  5 Jul 2022 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036075;
        bh=amROm/bZnnwpQhmpELzw7HPpFTBI4Ll1Xhds1dqZfkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jae5nqi+LDie3B68ucwPBnW9WpEvT/CUY0YK0Y/fYbCkg+I9wjll6D2rncfqMuVkX
         /f/kAhPhtIYDCh4tQndGrHfijQslMiNnoKfSuzX31TJLDhmS3meohQoACq6NWBOWS+
         IFpGfUg7WH2a1Jptzfzz3nVdoK+df04YoyDdxuu9Okzg/ylqR/BudJv5m7KyXGS3TC
         apkXVfV6V2qCCqrdp4FjgaOhuYEEEVMtJ5sufMCrABmc8T/G5aje7BafV+dNlwGJaQ
         PlPrj7uftHIsDFwzAJXzdGf50kxL0dy4S8gJHL4imsqOLdfl0DFXx16vd1vUW8Ew9o
         X7Y2yec4VWzpg==
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
Subject: [PATCH v2 05/15] mips: drop definitions of PTE_ORDER
Date:   Tue,  5 Jul 2022 18:46:58 +0300
Message-Id: <20220705154708.181258-6-rppt@kernel.org>
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
---
 arch/mips/include/asm/pgtable-32.h |  9 ++++-----
 arch/mips/include/asm/pgtable-64.h | 15 +++++----------
 arch/mips/kernel/asm-offsets.c     |  1 -
 arch/mips/mm/tlbex.c               |  2 +-
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index d9ae244a4fce..35bd519a1078 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -62,9 +62,9 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT) && !defined(CONFIG_PHYS_ADDR_T_64BIT)
-# define PGDIR_SHIFT	(2 * PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2 - 1)
+# define PGDIR_SHIFT	(2 * PAGE_SHIFT - PTE_T_LOG2 - 1)
 #else
-# define PGDIR_SHIFT	(2 * PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2)
+# define PGDIR_SHIFT	(2 * PAGE_SHIFT - PTE_T_LOG2)
 #endif
 
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
@@ -83,13 +83,12 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 #define PGD_ORDER	(__PGD_ORDER >= 0 ? __PGD_ORDER : 0)
 #define PUD_TABLE_ORDER	aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER	aieeee_attempt_to_allocate_pmd
-#define PTE_ORDER	0
 
 #define PTRS_PER_PGD	(USER_PTRS_PER_PGD * 2)
 #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT) && !defined(CONFIG_PHYS_ADDR_T_64BIT)
-# define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t) / 2)
+# define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t) / 2)
 #else
-# define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
+# define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
 #endif
 
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 7daf9a6509d8..dbf7e461d360 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -42,11 +42,11 @@
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 #ifdef __PAGETABLE_PMD_FOLDED
-#define PGDIR_SHIFT	(PAGE_SHIFT + PAGE_SHIFT + PTE_ORDER - 3)
+#define PGDIR_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #else
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
@@ -86,19 +86,17 @@
 #ifdef CONFIG_PAGE_SIZE_4KB
 # ifdef CONFIG_MIPS_VA_BITS_48
 #  define PGD_ORDER		0
-#  define PUD_TABLE_ORDER		0
+#  define PUD_TABLE_ORDER	0
 # else
 #  define PGD_ORDER		1
-#  define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
+#  define PUD_TABLE_ORDER	aieeee_attempt_to_allocate_pud
 # endif
 #define PMD_TABLE_ORDER		0
-#define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_8KB
 #define PGD_ORDER		0
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
-#define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
 #ifdef CONFIG_MIPS_VA_BITS_48
@@ -108,13 +106,11 @@
 #endif
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
-#define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_32KB
 #define PGD_ORDER		0
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
-#define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
@@ -124,7 +120,6 @@
 #else
 #define PMD_TABLE_ORDER		aieeee_attempt_to_allocate_pmd
 #endif
-#define PTE_ORDER		0
 #endif
 
 #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
@@ -134,7 +129,7 @@
 #ifndef __PAGETABLE_PMD_FOLDED
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_TABLE_ORDER) / sizeof(pmd_t))
 #endif
-#define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
+#define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ca7c5af7697d..0c97f755e256 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -197,7 +197,6 @@ void output_mm_defines(void)
 	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
 	BLANK();
 	DEFINE(_PGD_ORDER, PGD_ORDER);
-	DEFINE(_PTE_ORDER, PTE_ORDER);
 	BLANK();
 	DEFINE(_PMD_SHIFT, PMD_SHIFT);
 	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 8dbbd99fc7e8..6e8e71f12fab 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2065,7 +2065,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 
 	UASM_i_MFC0(p, wr.r1, C0_BADVADDR);
 	UASM_i_LW(p, wr.r2, 0, wr.r2);
-	UASM_i_SRL(p, wr.r1, wr.r1, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
+	UASM_i_SRL(p, wr.r1, wr.r1, PAGE_SHIFT - PTE_T_LOG2);
 	uasm_i_andi(p, wr.r1, wr.r1, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
 	UASM_i_ADDU(p, wr.r2, wr.r2, wr.r1);
 
-- 
2.34.1

