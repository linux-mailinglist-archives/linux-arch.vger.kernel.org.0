Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2375173AA5E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFVVA3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjFVU7Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 16:59:25 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6D2688;
        Thu, 22 Jun 2023 13:58:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so7344212276.2;
        Thu, 22 Jun 2023 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467505; x=1690059505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sltDOqqNfHEtvz8jLXUjW/r74sJCuRKUMVTEbSHBWCo=;
        b=kPeKxS6xjGfz9AlFKXBrS7k/oMitniLbJZydJSL7P9mRWo4eZ6+mhZ0RfQ/xgzRpRR
         shlp6IDjxc1Zi54v2Szw/IWPs7h13yhnqa4+SLs+JrO4xub++cDoiwuSfK32oAECXVqr
         +0aImmxu0MO1NlcDWPWE1t/GfM5gpYghSOx5OplyS42V7eE66ajuWsZpNSBe+PsYPrqi
         VcjBr8bDpFWaHKuuoQ+xJvxJpfPEC5IOcvI0xVrUQ3Ge8p6hulYzFPiT6b0ht75dwKoi
         lPIDcih2cDzp/fXel61I0gphUyR5giMIqEnrUx6FuLn8RjvsQYvRr7lV2J95H++gAjzy
         cNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467505; x=1690059505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sltDOqqNfHEtvz8jLXUjW/r74sJCuRKUMVTEbSHBWCo=;
        b=eL33KLMvjprK7KQyTYSyK21YofVwDQTuNStalbXJPEZgT8OH2qVroPYy6BxTwAeGmS
         upQRjjNk39T6AzhzG8Srzz9I2NMhlXiymrCKuYfSui/Nq4ZfmKEJ8Fme7YeCNioFjwUE
         l67IbBupIzMxEDQZUpKmLjnKwddM1vcUsJhkQwP1/HJoSO78rOD6xh4fqL+oI6XHC/5T
         fJ5Hs/QpZIQb7e+IT+MTYpEpWEMWGNByLH8nwopcgeWr6s9jnsqEEo5I0cllLYWZ4Lv2
         n/HjjdX9R83gW6voHDVI+WLvHsDYiT3ATZZpfnXE3HjBrO3sdZdGOWcTx0Ok3AeOW2YF
         kp6A==
X-Gm-Message-State: AC+VfDz00gahJntXIcZoyalLf9rNOWSA2/wW93Ba9dz0kNfiMU/oblqs
        sXH0ZO7aXPR7YgW3Xz6TAaE=
X-Google-Smtp-Source: ACHHUZ79c/uNHhonLkSvxldyR2pWp+AvCJ2e1p2TKGM3TkHKm3UmTC7VE9FYRHtJjJMm9DuNY9PrUg==
X-Received: by 2002:a25:c057:0:b0:ba7:db6c:c0ee with SMTP id c84-20020a25c057000000b00ba7db6cc0eemr14608074ybf.6.1687467504871;
        Thu, 22 Jun 2023 13:58:24 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:24 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v5 14/33] x86: Convert various functions to use ptdescs
Date:   Thu, 22 Jun 2023 13:57:26 -0700
Message-Id: <20230622205745.79707-15-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
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

In order to split struct ptdesc from struct page, convert various
functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/x86/mm/pgtable.c | 47 ++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 15a8009a4480..d3a93e8766ee 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -52,7 +52,7 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pgtable_pte_page_dtor(pte);
+	pagetable_pte_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, pte);
 }
@@ -60,7 +60,7 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 #if CONFIG_PGTABLE_LEVELS > 2
 void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct page *page = virt_to_page(pmd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
 	/*
 	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
@@ -69,8 +69,8 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	pgtable_pmd_page_dtor(page);
-	paravirt_tlb_remove_table(tlb, page);
+	pagetable_pmd_dtor(ptdesc);
+	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -92,16 +92,16 @@ void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 
 static inline void pgd_list_add(pgd_t *pgd)
 {
-	struct page *page = virt_to_page(pgd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
-	list_add(&page->lru, &pgd_list);
+	list_add(&ptdesc->pt_list, &pgd_list);
 }
 
 static inline void pgd_list_del(pgd_t *pgd)
 {
-	struct page *page = virt_to_page(pgd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
-	list_del(&page->lru);
+	list_del(&ptdesc->pt_list);
 }
 
 #define UNSHARED_PTRS_PER_PGD				\
@@ -112,12 +112,12 @@ static inline void pgd_list_del(pgd_t *pgd)
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
 {
-	virt_to_page(pgd)->pt_mm = mm;
+	virt_to_ptdesc(pgd)->pt_mm = mm;
 }
 
 struct mm_struct *pgd_page_get_mm(struct page *page)
 {
-	return page->pt_mm;
+	return page_ptdesc(page)->pt_mm;
 }
 
 static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
@@ -213,11 +213,14 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
+	struct ptdesc *ptdesc;
 
 	for (i = 0; i < count; i++)
 		if (pmds[i]) {
-			pgtable_pmd_page_dtor(virt_to_page(pmds[i]));
-			free_page((unsigned long)pmds[i]);
+			ptdesc = virt_to_ptdesc(pmds[i]);
+
+			pagetable_pmd_dtor(ptdesc);
+			pagetable_free(ptdesc);
 			mm_dec_nr_pmds(mm);
 		}
 }
@@ -230,18 +233,24 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
+	gfp &= ~__GFP_HIGHMEM;
 
 	for (i = 0; i < count; i++) {
-		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
-		if (!pmd)
+		pmd_t *pmd = NULL;
+		struct ptdesc *ptdesc = pagetable_alloc(gfp, 0);
+
+		if (!ptdesc)
 			failed = true;
-		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd))) {
-			free_page((unsigned long)pmd);
-			pmd = NULL;
+		if (ptdesc && !pagetable_pmd_ctor(ptdesc)) {
+			pagetable_free(ptdesc);
+			ptdesc = NULL;
 			failed = true;
 		}
-		if (pmd)
+		if (ptdesc) {
 			mm_inc_nr_pmds(mm);
+			pmd = ptdesc_address(ptdesc);
+		}
+
 		pmds[i] = pmd;
 	}
 
@@ -830,7 +839,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 
 	free_page((unsigned long)pmd_sv);
 
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));
 	free_page((unsigned long)pmd);
 
 	return 1;
-- 
2.40.1

