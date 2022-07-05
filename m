Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0960E567320
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiGEPsI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiGEPsF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:48:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F892DED;
        Tue,  5 Jul 2022 08:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A683CB81807;
        Tue,  5 Jul 2022 15:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC33FC341CE;
        Tue,  5 Jul 2022 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036081;
        bh=23WC1sQugdkdZL087WhgGrBTkb1KDCfCNGBK/jIciVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzfKK2r+ZuagPaB0lU0+NpBG5JSi/1A/P3jIk1yWTJYWgNNhfNtig9k087EhiIfjZ
         wPfBD0odF9eZjgS8SyBeFOUeRlRBnkXTBGyyfTXeJnvc+y1ByWxQw/qzwZXQhA6fWb
         e8HdBwrCHvY6akPyPnByuRihfJf9N1zVfWGqDOROcaaDuUPbWIhW2yDwiSe2FRHc1c
         A4Ww0jcDmQTKkwKKPIJxwUqK6HorU34yHkBt2nJCHx9qv5aMwOalBmaxRsuYjlW8w8
         W2yMz7HL6LMCvnQH2lBvn7604BCPuaTEyo299PG2KfxbQW6Sd1UX/eAy86N9LJYbCu
         mwUIcyo1aUkig==
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
Subject: [PATCH v2 06/15] mips: Rename PGD_ORDER to PGD_TABLE_ORDER
Date:   Tue,  5 Jul 2022 18:46:59 +0300
Message-Id: <20220705154708.181258-7-rppt@kernel.org>
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

While at it remove unused defintion of _PGD_ORDER in asm-offsets.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/mips/include/asm/pgalloc.h    |  2 +-
 arch/mips/include/asm/pgtable-32.h |  6 +++---
 arch/mips/include/asm/pgtable-64.h | 16 ++++++++--------
 arch/mips/kernel/asm-offsets.c     |  1 -
 arch/mips/kvm/mmu.c                |  2 +-
 arch/mips/mm/pgtable.c             |  2 +-
 arch/mips/mm/tlbex.c               | 12 ++++++------
 7 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 1ef8e86ae565..796035784c73 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -51,7 +51,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_ORDER);
+	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
 }
 
 #define __pte_free_tlb(tlb,pte,address)			\
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 35bd519a1078..495c603c1a30 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -75,12 +75,12 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
  * we don't really have any PUD/PMD directory physically.
  */
 #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT) && !defined(CONFIG_PHYS_ADDR_T_64BIT)
-# define __PGD_ORDER	(32 - 3 * PAGE_SHIFT + PGD_T_LOG2 + PTE_T_LOG2 + 1)
+# define __PGD_TABLE_ORDER (32 - 3 * PAGE_SHIFT + PGD_T_LOG2 + PTE_T_LOG2 + 1)
 #else
-# define __PGD_ORDER	(32 - 3 * PAGE_SHIFT + PGD_T_LOG2 + PTE_T_LOG2)
+# define __PGD_TABLE_ORDER (32 - 3 * PAGE_SHIFT + PGD_T_LOG2 + PTE_T_LOG2)
 #endif
 
-#define PGD_ORDER	(__PGD_ORDER >= 0 ? __PGD_ORDER : 0)
+#define PGD_TABLE_ORDER	(__PGD_TABLE_ORDER >= 0 ? __PGD_TABLE_ORDER : 0)
 #define PUD_TABLE_ORDER	aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER	aieeee_attempt_to_allocate_pmd
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index dbf7e461d360..a259ca4d1272 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -85,35 +85,35 @@
  */
 #ifdef CONFIG_PAGE_SIZE_4KB
 # ifdef CONFIG_MIPS_VA_BITS_48
-#  define PGD_ORDER		0
+#  define PGD_TABLE_ORDER	0
 #  define PUD_TABLE_ORDER	0
 # else
-#  define PGD_ORDER		1
+#  define PGD_TABLE_ORDER	1
 #  define PUD_TABLE_ORDER	aieeee_attempt_to_allocate_pud
 # endif
 #define PMD_TABLE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_8KB
-#define PGD_ORDER		0
+#define PGD_TABLE_ORDER		0
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
 #ifdef CONFIG_MIPS_VA_BITS_48
-#define PGD_ORDER               1
+#define PGD_TABLE_ORDER		1
 #else
-#define PGD_ORDER               0
+#define PGD_TABLE_ORDER		0
 #endif
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_32KB
-#define PGD_ORDER		0
+#define PGD_TABLE_ORDER		0
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_64KB
-#define PGD_ORDER		0
+#define PGD_TABLE_ORDER		0
 #define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #ifdef CONFIG_MIPS_VA_BITS_48
 #define PMD_TABLE_ORDER		0
@@ -122,7 +122,7 @@
 #endif
 #endif
 
-#define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#define PTRS_PER_PGD	((PAGE_SIZE << PGD_TABLE_ORDER) / sizeof(pgd_t))
 #ifndef __PAGETABLE_PUD_FOLDED
 #define PTRS_PER_PUD	((PAGE_SIZE << PUD_TABLE_ORDER) / sizeof(pud_t))
 #endif
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0c97f755e256..c4501897b870 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -196,7 +196,6 @@ void output_mm_defines(void)
 #endif
 	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
 	BLANK();
-	DEFINE(_PGD_ORDER, PGD_ORDER);
 	BLANK();
 	DEFINE(_PMD_SHIFT, PMD_SHIFT);
 	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 1bfd1b501d82..db17e870bdff 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -80,7 +80,7 @@ pgd_t *kvm_pgd_alloc(void)
 {
 	pgd_t *ret;
 
-	ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
+	ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
 	if (ret)
 		kvm_pgd_init(ret);
 
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index 05560b042d82..3b7590660a04 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -12,7 +12,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret, *init;
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
+	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init((unsigned long)ret);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6e8e71f12fab..a57519ae96b1 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -818,7 +818,7 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 * everything but the lower xuseg addresses goes down
 		 * the module_alloc/vmalloc path.
 		 */
-		uasm_i_dsrl_safe(p, ptr, tmp, PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+		uasm_i_dsrl_safe(p, ptr, tmp, PGDIR_SHIFT + PGD_TABLE_ORDER + PAGE_SHIFT - 3);
 		uasm_il_bnez(p, r, ptr, label_vmalloc);
 	} else {
 		uasm_il_bltz(p, r, tmp, label_vmalloc);
@@ -1127,7 +1127,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 			UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
 
 		uasm_i_dsrl_safe(p, scratch, tmp,
-				 PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+				 PGDIR_SHIFT + PGD_TABLE_ORDER + PAGE_SHIFT - 3);
 		uasm_il_bnez(p, r, scratch, label_vmalloc);
 
 		if (pgd_reg == -1) {
@@ -1493,12 +1493,12 @@ static void setup_pw(void)
 #endif
 	pgd_i = PGDIR_SHIFT;  /* 1st level PGD */
 #ifndef __PAGETABLE_PMD_FOLDED
-	pgd_w = PGDIR_SHIFT - PMD_SHIFT + PGD_ORDER;
+	pgd_w = PGDIR_SHIFT - PMD_SHIFT + PGD_TABLE_ORDER;
 
 	pmd_i = PMD_SHIFT;    /* 2nd level PMD */
 	pmd_w = PMD_SHIFT - PAGE_SHIFT;
 #else
-	pgd_w = PGDIR_SHIFT - PAGE_SHIFT + PGD_ORDER;
+	pgd_w = PGDIR_SHIFT - PAGE_SHIFT + PGD_TABLE_ORDER;
 #endif
 
 	pt_i  = PAGE_SHIFT;    /* 3rd level PTE */
@@ -1536,7 +1536,7 @@ static void build_loongson3_tlb_refill_handler(void)
 
 	if (check_for_high_segbits) {
 		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
-		uasm_i_dsrl_safe(&p, K1, K0, PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+		uasm_i_dsrl_safe(&p, K1, K0, PGDIR_SHIFT + PGD_TABLE_ORDER + PAGE_SHIFT - 3);
 		uasm_il_beqz(&p, &r, K1, label_vmalloc);
 		uasm_i_nop(&p);
 
@@ -2611,7 +2611,7 @@ void build_tlb_refill_handler(void)
 	check_pabits();
 
 #ifdef CONFIG_64BIT
-	check_for_high_segbits = current_cpu_data.vmbits > (PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+	check_for_high_segbits = current_cpu_data.vmbits > (PGDIR_SHIFT + PGD_TABLE_ORDER + PAGE_SHIFT - 3);
 #endif
 
 	if (cpu_has_3kex) {
-- 
2.34.1

