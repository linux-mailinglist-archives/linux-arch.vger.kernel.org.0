Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E6576D154
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjHBPOe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjHBPOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970530C6;
        Wed,  2 Aug 2023 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nv6mG4/l7H3PNgCsHrZF/ygxFjAa7ZRftAbjaaMLtfU=; b=qzVcnmGnCsgZ+JOYQS6BahTO8Y
        4fDBiRQz18mhL7VWDmt+dEhAq3Sa5V5SKNqJlpEUHzHABS6JtgC5YuZl2PoExrpyD8AaocAYrVL0F
        kZOD8nQ41FvXgl/QA/ZuvG8dBS9zKlb18eK+B21iVqCHpxywaoE23ictHd/iNF3rIOD2HGkDTJIvx
        kfl4cXXMk7Ue0xHMPdyStav5FoVJ0PeXiJjv0ATED/kYh0KKVQOz6g64xjsWqMVN5kNRgcOMcklQ1
        D/q8Qnz61oyymYEfIzTuQ6/SOMDCbqbF4Eo9VoW5m98bWEzT4szSXsV1wTLL2S1QdgPKFh0BO1pgB
        5MH2+1ZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYC-00FfmP-GT; Wed, 02 Aug 2023 15:14:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 38/38] mm: Call update_mmu_cache_range() in more page fault handling paths
Date:   Wed,  2 Aug 2023 16:14:06 +0100
Message-Id: <20230802151406.3735276-39-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pass the vm_fault to the architecture to help it make smarter decisions
about which PTEs to insert into the TLB.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 621716109627..236c46e85dc2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2997,7 +2997,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 
 		entry = pte_mkyoung(vmf->orig_pte);
 		if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
-			update_mmu_cache(vma, addr, vmf->pte);
+			update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
 	}
 
 	/*
@@ -3174,7 +3174,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	entry = pte_mkyoung(vmf->orig_pte);
 	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	count_vm_event(PGREUSE);
 }
@@ -3298,7 +3298,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		BUG_ON(unshare && pte_write(entry));
 		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 		if (old_folio) {
 			/*
 			 * Only after switching the pte to the new page may
@@ -4181,7 +4181,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4305,7 +4305,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4994,7 +4994,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (writable)
 		pte = pte_mkwrite(pte);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	goto out;
 }
@@ -5165,7 +5165,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	entry = pte_mkyoung(entry);
 	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
 				vmf->flags & FAULT_FLAG_WRITE)) {
-		update_mmu_cache(vmf->vma, vmf->address, vmf->pte);
+		update_mmu_cache_range(vmf, vmf->vma, vmf->address,
+				vmf->pte, 1);
 	} else {
 		/* Skip spurious TLB flush for retried page fault */
 		if (vmf->flags & FAULT_FLAG_TRIED)
-- 
2.40.1

