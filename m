Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007973F1ED
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjF0DSf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjF0DRI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:17:08 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C62723;
        Mon, 26 Jun 2023 20:15:47 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5768a7e3adbso46470387b3.0;
        Mon, 26 Jun 2023 20:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835746; x=1690427746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBkB4loM/Mt006iaxsYk7j8UnaAx8a9/NTd5FkPootg=;
        b=H1qFd5ryATtw8t405nCe3wIlgG+rX1BXYLLKuv1YpYWhPdhPiNJLVH72Jw72yhkr/h
         3iJdbhNcvDeJj1R/7QZzbVvdYp8+Ef/D3y8M93HMkREuKVm52xA1EryWULik3f4dSL7k
         14E+NJ36RkQ5e6TdqjWSx7Fc6bbQU9Nra+93+Jt2nhawSIssAg+z8tZmqu6fpDttBNOM
         ca/S4ptlU/TspyqfylxkdmdBeNsH9f2Hrm83Obo7DrdaBuxczqOW9lHL1iMbAqq171gX
         B7pt5M7+TmTNcw4OD4CiyQ2ipIhxzKH/nEdZ2UyNN8D+QQdMlcx6LBXeqPnQpiIanV21
         tW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835746; x=1690427746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBkB4loM/Mt006iaxsYk7j8UnaAx8a9/NTd5FkPootg=;
        b=KD8jwcubm0hh73DWu7ZDye1QXELvMlqnRwhApUyD5LoAOnsDE4aOg8TLcY5jMdjrtx
         VCueirSG2sz/UAsLGG4TISh9AKYB62nbCaUJuCofVRL2ahqo1e2ImBwICjaO5GrmrP+d
         Q24r7LtfF25ilmRZybGiEVjaeckN/Q46I18EEL6b5pZrla3ksgsXc9MikNBMqk0yqlwE
         iel9Mg1oAIqHDc4RmHzEjf9VvCFDIV9ngmFTHkNdo/LVrnzWmHeGZvzKwJ3kfi5T4NHL
         tgy1gLkDvLfvuI1GA2jUq408zop27bIr2McShsweuLwrthBQ0chMQlS18O0q8vvDiWEW
         LmPA==
X-Gm-Message-State: AC+VfDyUSpza+zVcTJ4a7eeWLgCC8qM5Tw55pj4bv+3OXKbx1bFnLB/w
        +P50LiAIGpO/JF0naYwNzUk=
X-Google-Smtp-Source: ACHHUZ6u2uv6uT2cSLb5CcuORgExO8yy2prZOQQwKiPsRPUBkVmf/UzBxwtB6MEmnnGsXK2WOg9dTA==
X-Received: by 2002:a0d:ea81:0:b0:565:b76d:82c8 with SMTP id t123-20020a0dea81000000b00565b76d82c8mr32046751ywe.5.1687835745750;
        Mon, 26 Jun 2023 20:15:45 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:45 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v6 18/33] pgalloc: Convert various functions to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:16 -0700
Message-Id: <20230627031431.29653-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/asm-generic/pgalloc.h | 88 +++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index a7cf825befae..c75d4a753849 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -8,7 +8,7 @@
 #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
 
 /**
- * __pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
+ * __pte_alloc_one_kernel - allocate memory for a PTE-level kernel page table
  * @mm: the mm_struct of the current context
  *
  * This function is intended for architectures that need
@@ -18,12 +18,17 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL &
+			~__GFP_HIGHMEM, 0);
+
+	if (!ptdesc)
+		return NULL;
+	return ptdesc_address(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
 /**
- * pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
+ * pte_alloc_one_kernel - allocate memory for a PTE-level kernel page table
  * @mm: the mm_struct of the current context
  *
  * Return: pointer to the allocated memory or %NULL on error
@@ -35,40 +40,40 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 #endif
 
 /**
- * pte_free_kernel - free PTE-level kernel page table page
+ * pte_free_kernel - free PTE-level kernel page table memory
  * @mm: the mm_struct of the current context
  * @pte: pointer to the memory containing the page table
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	pagetable_free(virt_to_ptdesc(pte));
 }
 
 /**
- * __pte_alloc_one - allocate a page for PTE-level user page table
+ * __pte_alloc_one - allocate memory for a PTE-level user page table
  * @mm: the mm_struct of the current context
  * @gfp: GFP flags to use for the allocation
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocate memory for a page table and ptdesc and runs pagetable_pte_ctor().
  *
  * This function is intended for architectures that need
  * anything beyond simple page allocation or must have custom GFP flags.
  *
- * Return: `struct page` initialized as page table or %NULL on error
+ * Return: `struct page` referencing the ptdesc or %NULL on error
  */
 static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
 {
-	struct page *pte;
+	struct ptdesc *ptdesc;
 
-	pte = alloc_page(gfp);
-	if (!pte)
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(pte)) {
-		__free_page(pte);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	return pte;
+	return ptdesc_page(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE
@@ -76,9 +81,9 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
  * pte_alloc_one - allocate a page for PTE-level user page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocate memory for a page table and ptdesc and runs pagetable_pte_ctor().
  *
- * Return: `struct page` initialized as page table or %NULL on error
+ * Return: `struct page` referencing the ptdesc or %NULL on error
  */
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
@@ -92,14 +97,16 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
  */
 
 /**
- * pte_free - free PTE-level user page table page
+ * pte_free - free PTE-level user page table memory
  * @mm: the mm_struct of the current context
- * @pte_page: the `struct page` representing the page table
+ * @pte_page: the `struct page` referencing the ptdesc
  */
 static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
-	pgtable_pte_page_dtor(pte_page);
-	__free_page(pte_page);
+	struct ptdesc *ptdesc = page_ptdesc(pte_page);
+
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 
@@ -107,10 +114,11 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 
 #ifndef __HAVE_ARCH_PMD_ALLOC_ONE
 /**
- * pmd_alloc_one - allocate a page for PMD-level page table
+ * pmd_alloc_one - allocate memory for a PMD-level page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pmd_page_ctor().
+ * Allocate memory for a page table and ptdesc and runs pagetable_pmd_ctor().
+ *
  * Allocations use %GFP_PGTABLE_USER in user context and
  * %GFP_PGTABLE_KERNEL in kernel context.
  *
@@ -118,28 +126,30 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  */
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	page = alloc_page(gfp);
-	if (!page)
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pmd_t *)page_address(page);
+	return ptdesc_address(ptdesc);
 }
 #endif
 
 #ifndef __HAVE_ARCH_PMD_FREE
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
+
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
-	free_page((unsigned long)pmd);
+	pagetable_pmd_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 #endif
 
@@ -150,19 +160,25 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	gfp_t gfp = GFP_PGTABLE_USER;
+	struct ptdesc *ptdesc;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	gfp &= ~__GFP_HIGHMEM;
+
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
+		return NULL;
+	return ptdesc_address(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
 /**
- * pud_alloc_one - allocate a page for PUD-level page table
+ * pud_alloc_one - allocate memory for a PUD-level page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page using %GFP_PGTABLE_USER for user context and
- * %GFP_PGTABLE_KERNEL for kernel context.
+ * Allocate memory for a page table using %GFP_PGTABLE_USER for user context
+ * and %GFP_PGTABLE_KERNEL for kernel context.
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
@@ -175,7 +191,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	free_page((unsigned long)pud);
+	pagetable_free(virt_to_ptdesc(pud));
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -190,7 +206,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_page((unsigned long)pgd);
+	pagetable_free(virt_to_ptdesc(pgd));
 }
 #endif
 
-- 
2.40.1

