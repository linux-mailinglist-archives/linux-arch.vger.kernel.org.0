Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA49173F1B4
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjF0DQf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjF0DQD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:16:03 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B8E7B;
        Mon, 26 Jun 2023 20:15:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5704fce0f23so42034037b3.3;
        Mon, 26 Jun 2023 20:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835735; x=1690427735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO1uHT8He+Av5NkiVAKHRKBK8X3I83QFDr1CeWVeYZ4=;
        b=dat1wDV0hFLhWxYH0r8ddz1H8BGcTEWHVyi5Rs5rk43A9IksDrk+3mqoUiUkRQ1bdc
         PR81Ap1TsQpZ2VWOAqt25hxf/tbd3WLQzV54B0l4aeb76JcfUJ+wAECtozZ2I0UZuoRC
         uh/oOwQmqyqFuyDBqIX7eJx8OEjtqbDmrxv7FxX1ASzR4qd3FXDZ91LjXYV0TyzIprFw
         kPqkd4c0XzfvJ4/7zzjtkJRieqZM2Ms5EHtEVe+Q06Qv77iK8p1yxt5xwpUsINGiVcuX
         C3CUZrMaWADT5iPU+9qU+7PbI5xUFKj2+rJ+T40oMZKgcYMP/C+Ckh8hFjolQrjk+muF
         NBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835735; x=1690427735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO1uHT8He+Av5NkiVAKHRKBK8X3I83QFDr1CeWVeYZ4=;
        b=UiSVoODlrqWNG9PfBmrM6+nO7IHx5n7zgW1msDyt5PCg+5b8HoYW60WOENC7wl6uGI
         WCM25Xnd/gz/3Wq/4vNksGTydkd6xRVp3/ldXS6HQsF5RUy+jDrNaSxp/UfVxAJv1Qxc
         GN9zy3TeJ6IIvQhxm67CUuDkwDhkZhrkmT44ypn/N1RV1/B72tpq13ZGaDJlm9UHYZHY
         Tmrb4VbXjpHgHE/l3d8bYGYkZcaJwfp5HyHMwAnw08iptKN6OBr75rTXDP5r56aTbne7
         aSbXPQKltiluk7dYa5bKvBziy2ZWGedBgTp91DAsPopdb3yuCqw93RpDMfh5U5vgDsL/
         bNoQ==
X-Gm-Message-State: AC+VfDwN50RS/uX6M37Fl4MMBwzP/YM4TlbItLfsmlOSzILoIdCh8z1e
        SL0tuBmd1d5pSo6+H5jNY7A=
X-Google-Smtp-Source: ACHHUZ6zABvTWGv3CxHnfopD7sHdOjFX2mae0AdIm6lQEgrZTtH2zvRSehpouTlujo5zm4bK/E+peg==
X-Received: by 2002:a0d:f306:0:b0:56d:2b76:1d2 with SMTP id c6-20020a0df306000000b0056d2b7601d2mr29033748ywf.10.1687835735078;
        Mon, 26 Jun 2023 20:15:35 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:34 -0700 (PDT)
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
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 13/33] powerpc: Convert various functions to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:11 -0700
Message-Id: <20230627031431.29653-14-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to split struct ptdesc from struct page, convert various
functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/powerpc/mm/book3s64/mmu_context.c | 10 +++---
 arch/powerpc/mm/book3s64/pgtable.c     | 32 +++++++++---------
 arch/powerpc/mm/pgtable-frag.c         | 46 +++++++++++++-------------
 3 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index c766e4c26e42..1715b07c630c 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -246,15 +246,15 @@ static void destroy_contexts(mm_context_t *ctx)
 static void pmd_frag_destroy(void *pmd_frag)
 {
 	int count;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = virt_to_page(pmd_frag);
+	ptdesc = virt_to_ptdesc(pmd_frag);
 	/* drop all the pending references */
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_pmd_page_dtor(page);
-		__free_page(page);
+	if (atomic_sub_and_test(PMD_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
+		pagetable_pmd_dtor(ptdesc);
+		pagetable_free(ptdesc);
 	}
 }
 
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85c84e89e3ea..1212deeabe15 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -306,22 +306,22 @@ static pmd_t *get_pmd_from_cache(struct mm_struct *mm)
 static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 {
 	void *ret = NULL;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
-	page = alloc_page(gfp);
-	if (!page)
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_pages(page, 0);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	atomic_set(&page->pt_frag_refcount, 1);
+	atomic_set(&ptdesc->pt_frag_refcount, 1);
 
-	ret = page_address(page);
+	ret = ptdesc_address(ptdesc);
 	/*
 	 * if we support only one fragment just return the
 	 * allocated page.
@@ -331,12 +331,12 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 
 	spin_lock(&mm->page_table_lock);
 	/*
-	 * If we find pgtable_page set, we return
+	 * If we find ptdesc_page set, we return
 	 * the allocated page with single fragment
 	 * count.
 	 */
 	if (likely(!mm->context.pmd_frag)) {
-		atomic_set(&page->pt_frag_refcount, PMD_FRAG_NR);
+		atomic_set(&ptdesc->pt_frag_refcount, PMD_FRAG_NR);
 		mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -357,15 +357,15 @@ pmd_t *pmd_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr)
 
 void pmd_fragment_free(unsigned long *pmd)
 {
-	struct page *page = virt_to_page(pmd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
-	if (PageReserved(page))
-		return free_reserved_page(page);
+	if (pagetable_is_reserved(ptdesc))
+		return free_reserved_ptdesc(ptdesc);
 
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
-		pgtable_pmd_page_dtor(page);
-		__free_page(page);
+	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
+		pagetable_pmd_dtor(ptdesc);
+		pagetable_free(ptdesc);
 	}
 }
 
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 20652daa1d7e..8961f1540209 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -18,15 +18,15 @@
 void pte_frag_destroy(void *pte_frag)
 {
 	int count;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = virt_to_page(pte_frag);
+	ptdesc = virt_to_ptdesc(pte_frag);
 	/* drop all the pending references */
 	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_pte_page_dtor(page);
-		__free_page(page);
+	if (atomic_sub_and_test(PTE_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
+		pagetable_pte_dtor(ptdesc);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -55,25 +55,25 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
 	if (!kernel) {
-		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
-		if (!page)
+		ptdesc = pagetable_alloc(PGALLOC_GFP | __GFP_ACCOUNT, 0);
+		if (!ptdesc)
 			return NULL;
-		if (!pgtable_pte_page_ctor(page)) {
-			__free_page(page);
+		if (!pagetable_pte_ctor(ptdesc)) {
+			pagetable_free(ptdesc);
 			return NULL;
 		}
 	} else {
-		page = alloc_page(PGALLOC_GFP);
-		if (!page)
+		ptdesc = pagetable_alloc(PGALLOC_GFP, 0);
+		if (!ptdesc)
 			return NULL;
 	}
 
-	atomic_set(&page->pt_frag_refcount, 1);
+	atomic_set(&ptdesc->pt_frag_refcount, 1);
 
-	ret = page_address(page);
+	ret = ptdesc_address(ptdesc);
 	/*
 	 * if we support only one fragment just return the
 	 * allocated page.
@@ -82,12 +82,12 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 		return ret;
 	spin_lock(&mm->page_table_lock);
 	/*
-	 * If we find pgtable_page set, we return
+	 * If we find ptdesc_page set, we return
 	 * the allocated page with single fragment
 	 * count.
 	 */
 	if (likely(!pte_frag_get(&mm->context))) {
-		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
+		atomic_set(&ptdesc->pt_frag_refcount, PTE_FRAG_NR);
 		pte_frag_set(&mm->context, ret + PTE_FRAG_SIZE);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -108,15 +108,15 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
 
 void pte_fragment_free(unsigned long *table, int kernel)
 {
-	struct page *page = virt_to_page(table);
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	if (PageReserved(page))
-		return free_reserved_page(page);
+	if (pagetable_is_reserved(ptdesc))
+		return free_reserved_ptdesc(ptdesc);
 
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
 		if (!kernel)
-			pgtable_pte_page_dtor(page);
-		__free_page(page);
+			pagetable_pte_dtor(ptdesc);
+		pagetable_free(ptdesc);
 	}
 }
-- 
2.40.1

