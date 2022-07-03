Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80BD5647DC
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGCOMv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiGCOMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C5F5FF1;
        Sun,  3 Jul 2022 07:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF4660EAA;
        Sun,  3 Jul 2022 14:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0A9C341CB;
        Sun,  3 Jul 2022 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857564;
        bh=NMZvlt8So9JjYVYzdxqpcUA9ehtGED3xtzbuJg5wsK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pd/hwZjSP35hVJUliFWCBn7DOu0NIruNeFmeUNv08Uv0iRKnKCC6TMTllmH4ZmOS+
         Kzd5rh8p4faU8XThjLnuiP++YWoXwemBP23TzsffONqZ4dKduvyHUxXJOb5d5uyAZW
         CyvnSz99+nLJ46MVtLH+1E6ITfVSa47zB80m4Ic4XOzLnhThoXQ1PTXPcj7U0FVL1T
         kHJLbRwmXRDT5gUpUfYEsEcAPHa9x8fMgOB8WM5ZxVtAt93CQ7ouPVwjjcJ2W2V6IJ
         xg+m5ejeNNwMLoonAtar9+8bjZa/7HOcckf/9hcduaL8nkGakIYJXfGA0qadeEjwmw
         zzoOciBDEFiHQ==
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
Subject: [PATCH 04/14] mips: Rename PUD_ORDER to PUD_TABLE_ORDER
Date:   Sun,  3 Jul 2022 17:11:53 +0300
Message-Id: <20220703141203.147893-5-rppt@kernel.org>
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

This is the order of the page table allocation, not the order of a PUD.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/mips/include/asm/pgalloc.h    |  2 +-
 arch/mips/include/asm/pgtable-32.h |  2 +-
 arch/mips/include/asm/pgtable-64.h | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 0ef245cfcae9..1ef8e86ae565 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -91,7 +91,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
+	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_TABLE_ORDER);
 	if (pud)
 		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
 	return pud;
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 8d57bd5b0b94..d9ae244a4fce 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -81,7 +81,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 #endif
 
 #define PGD_ORDER	(__PGD_ORDER >= 0 ? __PGD_ORDER : 0)
-#define PUD_ORDER	aieeee_attempt_to_allocate_pud
+#define PUD_TABLE_ORDER	aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER	aieeee_attempt_to_allocate_pmd
 #define PTE_ORDER	0
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index ae0d5a09064d..7daf9a6509d8 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -59,7 +59,7 @@
 #define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_TABLE_ORDER - 3))
 #define PUD_SIZE	(1UL << PUD_SHIFT)
 #define PUD_MASK	(~(PUD_SIZE-1))
-#define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT + PUD_ORDER - 3))
+#define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT + PUD_TABLE_ORDER - 3))
 #endif
 
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
@@ -86,17 +86,17 @@
 #ifdef CONFIG_PAGE_SIZE_4KB
 # ifdef CONFIG_MIPS_VA_BITS_48
 #  define PGD_ORDER		0
-#  define PUD_ORDER		0
+#  define PUD_TABLE_ORDER		0
 # else
 #  define PGD_ORDER		1
-#  define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#  define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 # endif
 #define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_8KB
 #define PGD_ORDER		0
-#define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
@@ -106,19 +106,19 @@
 #else
 #define PGD_ORDER               0
 #endif
-#define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_32KB
 #define PGD_ORDER		0
-#define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
-#define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#define PUD_TABLE_ORDER		aieeee_attempt_to_allocate_pud
 #ifdef CONFIG_MIPS_VA_BITS_48
 #define PMD_TABLE_ORDER		0
 #else
@@ -129,7 +129,7 @@
 
 #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
 #ifndef __PAGETABLE_PUD_FOLDED
-#define PTRS_PER_PUD	((PAGE_SIZE << PUD_ORDER) / sizeof(pud_t))
+#define PTRS_PER_PUD	((PAGE_SIZE << PUD_TABLE_ORDER) / sizeof(pud_t))
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_TABLE_ORDER) / sizeof(pmd_t))
-- 
2.34.1

