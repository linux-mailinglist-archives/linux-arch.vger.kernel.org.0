Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086F46E528E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDQUxj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjDQUx0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E36EBB;
        Mon, 17 Apr 2023 13:53:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so9750107pjl.2;
        Mon, 17 Apr 2023 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764788; x=1684356788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDm5QDDKVVs67sujhxqGF1xdxDwJ7Cf+86boh2cHUEk=;
        b=Bg9zrwHmz+zWpBrO553L6xcdY/9UqoWF+7JCbvFGdP25XqpLPTgtgzoeSaxtZoExE9
         /hfw60KOOdzfPF4LPrgT1cUNcQCYvvrOjqBV5EeXW1oBY3+U5yLq/ZcoGhd2glQtHjSd
         E1SNfE4qG9orNxm4nPGVLtj0ZQ+EoD5+Of2kyr0VxZlAahOe3asPxpa5GldaOSiEcuod
         A/YatVmT6GM0jfgVRuBueRMwbH+1Zmb4szBdOpsRslV8e0A8Jy37baDQLXTR/uZAq8Io
         SplJDGW4RHssNwF9j3bgci8G5WEKKtAuNGcD0sy8PlvNVq51dUIvBHLo/SQen5NnMvRt
         jmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764788; x=1684356788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDm5QDDKVVs67sujhxqGF1xdxDwJ7Cf+86boh2cHUEk=;
        b=GG6ndrkzF0Q61dRR91QFxjhzxoiHpQItbqaQlN66FrMhFUkfs6J/23EhKd4oWzH21B
         LhCQRrP4YQutjJqMpB7S8wNv0gjzmy+QXUUCrOg9iJTni6EAg8tLMkIQ8nOGnKOVjABD
         YTcaofWjGPbS1L7Xl3xSWOyDEMPkrLmD6hQ+swz0fdpPFIXMGTkO1m9xyVfC7Vx8zZEZ
         7nLhJqmJb4fNpB1MePQGmExYqj3MRMSEkVymsdNFLTXYSvJKF2uvf/yTG42Hk1lmS5N0
         Msasq4hWvJ108JmfOFaeyxqSoeNfqSg59Ty4EA8y95oyXDB7t0tITtEa1F33INMgdry5
         ua9Q==
X-Gm-Message-State: AAQBX9dSkrADnr+hMDbKydiWl+FWleP194CrqXgya9HxtXiGajg/XTXE
        XxeUhqeXODwYGpG+/TJYxAw=
X-Google-Smtp-Source: AKy350Z9i6yPCDN1KgNRMsqi9oENFCLbYvx/eJwTeNJWe0OuxQ2o4hV6w1fDsy15hPJg9C6OAHihoA==
X-Received: by 2002:a17:90a:6aca:b0:246:82ac:b6b2 with SMTP id b10-20020a17090a6aca00b0024682acb6b2mr15576120pjm.9.1681764787792;
        Mon, 17 Apr 2023 13:53:07 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:07 -0700 (PDT)
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
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 16/33] s390: Convert various pgalloc functions to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:31 -0700
Message-Id: <20230417205048.15870-17-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/include/asm/pgalloc.h |   4 +-
 arch/s390/include/asm/tlb.h     |   4 +-
 arch/s390/mm/pgalloc.c          | 108 ++++++++++++++++----------------
 3 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 17eb618f1348..9841481560ae 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -86,7 +86,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 	if (!table)
 		return NULL;
 	crst_table_init(table, _SEGMENT_ENTRY_EMPTY);
-	if (!pgtable_pmd_page_ctor(virt_to_page(table))) {
+	if (!ptdesc_pmd_ctor(virt_to_ptdesc(table))) {
 		crst_table_free(mm, table);
 		return NULL;
 	}
@@ -97,7 +97,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (mm_pmd_folded(mm))
 		return;
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	ptdesc_pmd_dtor(virt_to_ptdesc(pmd));
 	crst_table_free(mm, (unsigned long *) pmd);
 }
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index b91f4a9b044c..1388c819b467 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -89,12 +89,12 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	ptdesc_pmd_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_puds = 1;
-	tlb_remove_table(tlb, pmd);
+	tlb_remove_ptdesc(tlb, pmd);
 }
 
 /*
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 6b99932abc66..16a29d2cfe85 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -43,17 +43,17 @@ __initcall(page_table_register_sysctl);
 
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
-	struct page *page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	struct ptdesc *ptdesc = ptdesc(GFP_KERNEL, CRST_ALLOC_ORDER);
 
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
+	ptdesc_free(virt_to_ptdesc(table);
 }
 
 static void __crst_table_upgrade(void *arg)
@@ -140,21 +140,21 @@ static inline unsigned int atomic_xor_bits(atomic_t *v, unsigned int bits)
 
 struct page *page_table_alloc_pgste(struct mm_struct *mm)
 {
-	struct page *page;
+	struct page *ptdesc;
 	u64 *table;
 
-	page = alloc_page(GFP_KERNEL);
-	if (page) {
-		table = (u64 *)page_to_virt(page);
+	ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
+	if (ptdesc) {
+		table = (u64 *)ptdesc_to_virt(page);
 		memset64(table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64(table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	}
-	return page;
+	return ptdesc_page(ptdesc);
 }
 
 void page_table_free_pgste(struct page *page)
 {
-	__free_page(page);
+	ptdesc_free(page_ptdesc(page));
 }
 
 #endif /* CONFIG_PGSTE */
@@ -230,7 +230,7 @@ void page_table_free_pgste(struct page *page)
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
 	unsigned long *table;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned int mask, bit;
 
 	/* Try to get a fragment of a 4K page as a 2K page table */
@@ -238,9 +238,9 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		table = NULL;
 		spin_lock_bh(&mm->context.lock);
 		if (!list_empty(&mm->context.pgtable_list)) {
-			page = list_first_entry(&mm->context.pgtable_list,
-						struct page, lru);
-			mask = atomic_read(&page->pt_frag_refcount);
+			ptdesc = list_first_entry(&mm->context.pgtable_list,
+						struct ptdesc, pt_list);
+			mask = atomic_read(&ptdesc->pt_frag_refcount);
 			/*
 			 * The pending removal bits must also be checked.
 			 * Failure to do so might lead to an impossible
@@ -253,13 +253,13 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			 */
 			mask = (mask | (mask >> 4)) & 0x03U;
 			if (mask != 0x03U) {
-				table = (unsigned long *) page_to_virt(page);
+				table = (unsigned long *) ptdesc_to_virt(ptdesc);
 				bit = mask & 1;		/* =1 -> second 2K */
 				if (bit)
 					table += PTRS_PER_PTE;
-				atomic_xor_bits(&page->pt_frag_refcount,
+				atomic_xor_bits(&ptdesc->pt_frag_refcount,
 							0x01U << bit);
-				list_del(&page->lru);
+				list_del(&ptdesc->pt_list);
 			}
 		}
 		spin_unlock_bh(&mm->context.lock);
@@ -267,27 +267,27 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			return table;
 	}
 	/* Allocate a fresh page */
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
-	arch_set_page_dat(page, 0);
+	arch_set_page_dat(ptdesc_page(ptdesc), 0);
 	/* Initialize page table */
-	table = (unsigned long *) page_to_virt(page);
+	table = (unsigned long *) ptdesc_to_virt(ptdesc);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
-		atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
+		atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x03U);
 		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	} else {
 		/* Return the first 2K fragment of the page */
-		atomic_xor_bits(&page->pt_frag_refcount, 0x01U);
+		atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x01U);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
 		spin_lock_bh(&mm->context.lock);
-		list_add(&page->lru, &mm->context.pgtable_list);
+		list_add(&ptdesc->pt_list, &mm->context.pgtable_list);
 		spin_unlock_bh(&mm->context.lock);
 	}
 	return table;
@@ -309,9 +309,8 @@ static void page_table_release_check(struct page *page, void *table,
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	unsigned int mask, bit, half;
-	struct page *page;
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	page = virt_to_page(table);
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
@@ -321,39 +320,38 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		 * will happen outside of the critical section from this
 		 * function or from __tlb_remove_table()
 		 */
-		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x11U << bit);
+		mask = atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x11U << bit);
 		if (mask & 0x03U)
-			list_add(&page->lru, &mm->context.pgtable_list);
+			list_add(&ptdesc->pt_list, &mm->context.pgtable_list);
 		else
-			list_del(&page->lru);
+			list_del(&ptdesc->pt_list);
 		spin_unlock_bh(&mm->context.lock);
-		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x10U << bit);
+		mask = atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x10U << bit);
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
 	} else {
 		half = 0x03U;
-		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
+		mask = atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x03U);
 	}
 
-	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	page_table_release_check(ptdesc_page(ptdesc), table, half, mask);
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
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
@@ -363,11 +361,11 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	 * outside of the critical section from __tlb_remove_table() or from
 	 * page_table_free()
 	 */
-	mask = atomic_xor_bits(&page->pt_frag_refcount, 0x11U << bit);
+	mask = atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x11U << bit);
 	if (mask & 0x03U)
-		list_add_tail(&page->lru, &mm->context.pgtable_list);
+		list_add_tail(&ptdesc->pt_list, &mm->context.pgtable_list);
 	else
-		list_del(&page->lru);
+		list_del(&ptdesc->pt_list);
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
@@ -377,7 +375,7 @@ void __tlb_remove_table(void *_table)
 {
 	unsigned int mask = (unsigned long) _table & 0x03U, half = mask;
 	void *table = (void *)((unsigned long) _table ^ mask);
-	struct page *page = virt_to_page(table);
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
 	switch (half) {
 	case 0x00U:	/* pmd, pud, or p4d */
@@ -385,18 +383,18 @@ void __tlb_remove_table(void *_table)
 		return;
 	case 0x01U:	/* lower 2K of a 4K page table */
 	case 0x02U:	/* higher 2K of a 4K page table */
-		mask = atomic_xor_bits(&page->pt_frag_refcount, mask << 4);
+		mask = atomic_xor_bits(&ptdesc->pt_frag_refcount, mask << 4);
 		if (mask != 0x00U)
 			return;
 		break;
 	case 0x03U:	/* 4K page table with pgstes */
-		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
+		mask = atomic_xor_bits(&ptdesc->pt_frag_refcount, 0x03U);
 		break;
 	}
 
-	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	page_table_release_check(ptdesc_page(ptdesc), table, half, mask);
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 /*
@@ -424,16 +422,20 @@ static void base_pgt_free(unsigned long *table)
 static unsigned long *base_crst_alloc(unsigned long val)
 {
 	unsigned long *table;
+	struct ptdesc *ptdesc;
 
-	table =	(unsigned long *)__get_free_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
-	if (table)
-		crst_table_init(table, val);
+	ptdesc = ptdesc_alloc(GFP_KERNEL, CRST_ALLOC_ORDER);
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
+	ptdesc_free(virt_to_ptdesc(table));
 }
 
 #define BASE_ADDR_END_FUNC(NAME, SIZE)					\
-- 
2.39.2

