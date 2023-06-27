Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064D873F1DB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjF0DSK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjF0DQd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:16:33 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D026AE;
        Mon, 26 Jun 2023 20:15:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-570002c9b38so42370607b3.1;
        Mon, 26 Jun 2023 20:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835741; x=1690427741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkWAvuRnBcdDxQyUnHPccd2fzUbRvSLtPtfAdfkK0D0=;
        b=Y29oLBo54IelkOx322p2iVXWfA4IaT3l9yF0tlkE7TIOLncY8qGbD0oBXUadhtPpBr
         ox9bcqf07tpeqzwcnY+iasgqeZXejAOVjtaJjAsb7WJ15Uy0POLJ3MxCZns1FcM5WPjP
         +JbOozXOilFCizwLt/mpoCnI1UBR9D6cbicNOi3gepwC7mGMoITq+lzxvsSHsVo1SDEj
         Mu7JBT23VNXCvVL/f5whQ8wp1S6+w1a74gEslVRxsbEnv+d7SoOA5E7Rsd4oM5np6JgZ
         2uL9Cbj4u7ByOSSRN6KflmiiGBGWbxgqL+M+RNd5GWw1ztOmw5rlB1y9QWz6YFnxA8My
         wgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835741; x=1690427741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkWAvuRnBcdDxQyUnHPccd2fzUbRvSLtPtfAdfkK0D0=;
        b=lfP/wDCin1a/9dqKxKCIV1Rwot6BRIuC6VfpgNdqISG2vwrwwufSWD/Kbjhvgb9x46
         7tItf5SqWvhIgGSTEk1MOfYvwONFdLlgpCU1EXlV88w7nZnW086MalaUDtoCrYFLRefA
         vac3PJx9V6rXef+O0jWp1DHSguHt69KDUpQlvkV8MFyweXBXJQ/4xwJdp3oO+H9Y2AfB
         O0FZNmqU+h8zNB9ohZB8yjycPoStIg+tWVzQKBAixQXUBTBuMtgeOBw1nQPhi/1emD2O
         1oF6RcovtO1UxkoVkxGsY03FKAWXy9R8PV7KTpD6k6aac6CpbaAOCfhL47KjtoWGx35I
         MXKg==
X-Gm-Message-State: AC+VfDy3kWLB2tN2ol6a5mhqxqnlhP8vKikyx+ekGDRjJDxKFO9IYiHI
        xAdKrCTisYYhOpj9BkVECC0=
X-Google-Smtp-Source: ACHHUZ6zo/heeKGErFKSgHt9WPTzp866BV9Vxkz2nD8Fm51KKhKDyA9uiul/2kgbaOeGxMWVqoUNKQ==
X-Received: by 2002:a0d:d742:0:b0:569:feee:3950 with SMTP id z63-20020a0dd742000000b00569feee3950mr33893914ywd.2.1687835741628;
        Mon, 26 Jun 2023 20:15:41 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:41 -0700 (PDT)
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
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 16/33] s390: Convert various pgalloc functions to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:14 -0700
Message-Id: <20230627031431.29653-17-vishal.moola@gmail.com>
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/s390/include/asm/pgalloc.h |   4 +-
 arch/s390/include/asm/tlb.h     |   4 +-
 arch/s390/mm/pgalloc.c          | 108 ++++++++++++++++----------------
 3 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 17eb618f1348..00ad9b88fda9 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -86,7 +86,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 	if (!table)
 		return NULL;
 	crst_table_init(table, _SEGMENT_ENTRY_EMPTY);
-	if (!pgtable_pmd_page_ctor(virt_to_page(table))) {
+	if (!pagetable_pmd_ctor(virt_to_ptdesc(table))) {
 		crst_table_free(mm, table);
 		return NULL;
 	}
@@ -97,7 +97,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (mm_pmd_folded(mm))
 		return;
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));
 	crst_table_free(mm, (unsigned long *) pmd);
 }
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index b91f4a9b044c..383b1f91442c 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -89,12 +89,12 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_puds = 1;
-	tlb_remove_table(tlb, pmd);
+	tlb_remove_ptdesc(tlb, pmd);
 }
 
 /*
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 66ab68db9842..79b1c2458d85 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -43,17 +43,17 @@ __initcall(page_table_register_sysctl);
 
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
-	struct page *page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, CRST_ALLOC_ORDER);
 
-	if (!page)
+	if (!ptdesc)
 		return NULL;
-	arch_set_page_dat(page, CRST_ALLOC_ORDER);
-	return (unsigned long *) page_to_virt(page);
+	arch_set_page_dat(ptdesc_page(ptdesc), CRST_ALLOC_ORDER);
+	return (unsigned long *) ptdesc_to_virt(ptdesc);
 }
 
 void crst_table_free(struct mm_struct *mm, unsigned long *table)
 {
-	free_pages((unsigned long)table, CRST_ALLOC_ORDER);
+	pagetable_free(virt_to_ptdesc(table));
 }
 
 static void __crst_table_upgrade(void *arg)
@@ -140,21 +140,21 @@ static inline unsigned int atomic_xor_bits(atomic_t *v, unsigned int bits)
 
 struct page *page_table_alloc_pgste(struct mm_struct *mm)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	u64 *table;
 
-	page = alloc_page(GFP_KERNEL);
-	if (page) {
-		table = (u64 *)page_to_virt(page);
+	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (ptdesc) {
+		table = (u64 *)ptdesc_to_virt(ptdesc);
 		memset64(table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64(table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	}
-	return page;
+	return ptdesc_page(ptdesc);
 }
 
 void page_table_free_pgste(struct page *page)
 {
-	__free_page(page);
+	pagetable_free(page_ptdesc(page));
 }
 
 #endif /* CONFIG_PGSTE */
@@ -233,7 +233,7 @@ void page_table_free_pgste(struct page *page)
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
 	unsigned long *table;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned int mask, bit;
 
 	/* Try to get a fragment of a 4K page as a 2K page table */
@@ -241,9 +241,9 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		table = NULL;
 		spin_lock_bh(&mm->context.lock);
 		if (!list_empty(&mm->context.pgtable_list)) {
-			page = list_first_entry(&mm->context.pgtable_list,
-						struct page, lru);
-			mask = atomic_read(&page->_refcount) >> 24;
+			ptdesc = list_first_entry(&mm->context.pgtable_list,
+						struct ptdesc, pt_list);
+			mask = atomic_read(&ptdesc->_refcount) >> 24;
 			/*
 			 * The pending removal bits must also be checked.
 			 * Failure to do so might lead to an impossible
@@ -255,13 +255,13 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			 */
 			mask = (mask | (mask >> 4)) & 0x03U;
 			if (mask != 0x03U) {
-				table = (unsigned long *) page_to_virt(page);
+				table = (unsigned long *) ptdesc_to_virt(ptdesc);
 				bit = mask & 1;		/* =1 -> second 2K */
 				if (bit)
 					table += PTRS_PER_PTE;
-				atomic_xor_bits(&page->_refcount,
+				atomic_xor_bits(&ptdesc->_refcount,
 							0x01U << (bit + 24));
-				list_del(&page->lru);
+				list_del(&ptdesc->pt_list);
 			}
 		}
 		spin_unlock_bh(&mm->context.lock);
@@ -269,27 +269,27 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			return table;
 	}
 	/* Allocate a fresh page */
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	arch_set_page_dat(page, 0);
+	arch_set_page_dat(ptdesc_page(ptdesc), 0);
 	/* Initialize page table */
-	table = (unsigned long *) page_to_virt(page);
+	table = (unsigned long *) ptdesc_to_virt(ptdesc);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
-		atomic_xor_bits(&page->_refcount, 0x03U << 24);
+		atomic_xor_bits(&ptdesc->_refcount, 0x03U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	} else {
 		/* Return the first 2K fragment of the page */
-		atomic_xor_bits(&page->_refcount, 0x01U << 24);
+		atomic_xor_bits(&ptdesc->_refcount, 0x01U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
 		spin_lock_bh(&mm->context.lock);
-		list_add(&page->lru, &mm->context.pgtable_list);
+		list_add(&ptdesc->pt_list, &mm->context.pgtable_list);
 		spin_unlock_bh(&mm->context.lock);
 	}
 	return table;
@@ -311,9 +311,8 @@ static void page_table_release_check(struct page *page, void *table,
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	unsigned int mask, bit, half;
-	struct page *page;
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	page = virt_to_page(table);
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
@@ -323,42 +322,41 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		 * will happen outside of the critical section from this
 		 * function or from __tlb_remove_table()
 		 */
-		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
+		mask = atomic_xor_bits(&ptdesc->_refcount, 0x11U << (bit + 24));
 		mask >>= 24;
 		if (mask & 0x03U)
-			list_add(&page->lru, &mm->context.pgtable_list);
+			list_add(&ptdesc->pt_list, &mm->context.pgtable_list);
 		else
-			list_del(&page->lru);
+			list_del(&ptdesc->pt_list);
 		spin_unlock_bh(&mm->context.lock);
-		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
+		mask = atomic_xor_bits(&ptdesc->_refcount, 0x10U << (bit + 24));
 		mask >>= 24;
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
 	} else {
 		half = 0x03U;
-		mask = atomic_xor_bits(&page->_refcount, 0x03U << 24);
+		mask = atomic_xor_bits(&ptdesc->_refcount, 0x03U << 24);
 		mask >>= 24;
 	}
 
-	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	page_table_release_check(ptdesc_page(ptdesc), table, half, mask);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 			 unsigned long vmaddr)
 {
 	struct mm_struct *mm;
-	struct page *page;
 	unsigned int bit, mask;
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
 	mm = tlb->mm;
-	page = virt_to_page(table);
 	if (mm_alloc_pgste(mm)) {
 		gmap_unlink(mm, table, vmaddr);
 		table = (unsigned long *) ((unsigned long)table | 0x03U);
-		tlb_remove_table(tlb, table);
+		tlb_remove_ptdesc(tlb, table);
 		return;
 	}
 	bit = ((unsigned long) table & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
@@ -368,12 +366,12 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	 * outside of the critical section from __tlb_remove_table() or from
 	 * page_table_free()
 	 */
-	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
+	mask = atomic_xor_bits(&ptdesc->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
 	if (mask & 0x03U)
-		list_add_tail(&page->lru, &mm->context.pgtable_list);
+		list_add_tail(&ptdesc->pt_list, &mm->context.pgtable_list);
 	else
-		list_del(&page->lru);
+		list_del(&ptdesc->pt_list);
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
@@ -383,7 +381,7 @@ void __tlb_remove_table(void *_table)
 {
 	unsigned int mask = (unsigned long) _table & 0x03U, half = mask;
 	void *table = (void *)((unsigned long) _table ^ mask);
-	struct page *page = virt_to_page(table);
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
 	switch (half) {
 	case 0x00U:	/* pmd, pud, or p4d */
@@ -391,20 +389,20 @@ void __tlb_remove_table(void *_table)
 		return;
 	case 0x01U:	/* lower 2K of a 4K page table */
 	case 0x02U:	/* higher 2K of a 4K page table */
-		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
+		mask = atomic_xor_bits(&ptdesc->_refcount, mask << (4 + 24));
 		mask >>= 24;
 		if (mask != 0x00U)
 			return;
 		break;
 	case 0x03U:	/* 4K page table with pgstes */
-		mask = atomic_xor_bits(&page->_refcount, 0x03U << 24);
+		mask = atomic_xor_bits(&ptdesc->_refcount, 0x03U << 24);
 		mask >>= 24;
 		break;
 	}
 
-	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	page_table_release_check(ptdesc_page(ptdesc), table, half, mask);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 /*
@@ -432,16 +430,20 @@ static void base_pgt_free(unsigned long *table)
 static unsigned long *base_crst_alloc(unsigned long val)
 {
 	unsigned long *table;
+	struct ptdesc *ptdesc;
 
-	table =	(unsigned long *)__get_free_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
-	if (table)
-		crst_table_init(table, val);
+	ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, CRST_ALLOC_ORDER);
+	if (!ptdesc)
+		return NULL;
+	table = ptdesc_address(ptdesc);
+
+	crst_table_init(table, val);
 	return table;
 }
 
 static void base_crst_free(unsigned long *table)
 {
-	free_pages((unsigned long)table, CRST_ALLOC_ORDER);
+	pagetable_free(virt_to_ptdesc(table));
 }
 
 #define BASE_ADDR_END_FUNC(NAME, SIZE)					\
-- 
2.40.1

