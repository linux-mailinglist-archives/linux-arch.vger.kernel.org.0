Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563C872D2AD
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbjFLVJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbjFLVID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587563AA3;
        Mon, 12 Jun 2023 14:05:15 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56d304ef801so13957477b3.0;
        Mon, 12 Jun 2023 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603914; x=1689195914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FIbG7hZZYadBjxNE3W8iUcLLESpTErkJHs37ORZhp8=;
        b=BMMTeVLiiLARHio/XE+I+jCCeZoZ/97PeMj84XvLWmMUbB9BdVCUvYIh2Us5nXhEm+
         GaSZgpWEka3eZpV6QF9Ku5suybhjbTiNh30wb18mf5p0dFW0PZnCu02ldx/3kc8oSeaP
         hgkMZXUdVJaPYGHQpXtn3m8hqql89twVyrxmE12C9NmDu/gHq6ZxnWDz8at6uc4XM4uq
         jVgNP7Ttfo26QgXC06Wfp89Jm/XIZvIR1V8k58aaM2NCapiWRWOfK01T68EA7hRajFaH
         oJy6HK1lOn1lYlC9chHC+ep/FXR5v1W1mqYIJQPpykFbYWE7681/f5WmSIHHhv6wsGKo
         YetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603914; x=1689195914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FIbG7hZZYadBjxNE3W8iUcLLESpTErkJHs37ORZhp8=;
        b=Lmcs3LyBYqIpYJyEjja0xq4XYVQBnatFmDxQ3qms0vmk6TLa6IthxbiBjKuuoP7ZGB
         /xFFNoqibTzlqFo5oAOFbSwW8jkVVnyj0C2Tnzm2GlpYV1phjQLkecmM4QuNV6to5g3a
         Jsl6AFFSYL/o1F0mBlUYZ6GHzjh7PJbM76RuLalrLrWt58X6f6a2FlQeHJcP1o2yMmsB
         mCN/fYH7WpVYXaqswe/t9RRoRFrhU6hHPTjhK9AfbKCSafp+YmoK8gLq3AQo97pZui/L
         ktpZmwjVw0X98I7UsbWKaxrpFDBssIwYSQ7/zS/su1+/OtGvqqysxrkBxCAnx05I4nI7
         aLTQ==
X-Gm-Message-State: AC+VfDzNohKTihTbwoxHmB/YJYCA/+8e/VcR5dkm5HmG3almaL7s9E5q
        hzozPovT/mTd2aww0vh+fYI=
X-Google-Smtp-Source: ACHHUZ4XoQ/hY/ZwMXh2mexBZV3rZaOJ0y9b6ri+pUfVP98Mdhfd/kVsDzGgS7EyjMgcF/onsjMNTw==
X-Received: by 2002:a0d:ca8c:0:b0:56d:28b:8042 with SMTP id m134-20020a0dca8c000000b0056d028b8042mr7057809ywd.40.1686603914513;
        Mon, 12 Jun 2023 14:05:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:14 -0700 (PDT)
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
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 14/34] powerpc: Convert various functions to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:03 -0700
Message-Id: <20230612210423.18611-15-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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

