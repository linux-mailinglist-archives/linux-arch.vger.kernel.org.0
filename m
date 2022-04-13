Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5E4FF469
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiDMKJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiDMKJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 06:09:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10BA2574A6;
        Wed, 13 Apr 2022 03:06:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFF7E13D5;
        Wed, 13 Apr 2022 03:06:51 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD6003F73B;
        Wed, 13 Apr 2022 03:06:46 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     inux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tlb/hugetlb: Add framework to handle PGDIR_SIZE HugeTLB pages
Date:   Wed, 13 Apr 2022 15:37:14 +0530
Message-Id: <20220413100714.509888-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Change tlb_remove_huge_tlb_entry() to accommodate larger PGDIR_SIZE HugeTLB
pages via adding a new helper tlb_flush_pgd_range(). While here also update
struct mmu_gather as required, that is add a new member cleared_pgds.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.18-rc2, some earlier context could be found here

https://lore.kernel.org/all/20220406112124.GD2731@worktop.programming.kicks-ass.net/

 include/asm-generic/tlb.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index eee6f7763a39..6eaf0080ef2d 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -282,6 +282,7 @@ struct mmu_gather {
 	unsigned int		cleared_pmds : 1;
 	unsigned int		cleared_puds : 1;
 	unsigned int		cleared_p4ds : 1;
+	unsigned int		cleared_pgds : 1;
 
 	/*
 	 * tracks VM_EXEC | VM_HUGETLB in tlb_start_vma
@@ -325,6 +326,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	tlb->cleared_pmds = 0;
 	tlb->cleared_puds = 0;
 	tlb->cleared_p4ds = 0;
+	tlb->cleared_pgds = 0;
 	/*
 	 * Do not reset mmu_gather::vma_* fields here, we do not
 	 * call into tlb_start_vma() again to set them if there is an
@@ -420,7 +422,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 	 * these bits.
 	 */
 	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
-	      tlb->cleared_puds || tlb->cleared_p4ds))
+	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->cleared_pgds))
 		return;
 
 	tlb_flush(tlb);
@@ -472,6 +474,8 @@ static inline unsigned long tlb_get_unmap_shift(struct mmu_gather *tlb)
 		return PUD_SHIFT;
 	if (tlb->cleared_p4ds)
 		return P4D_SHIFT;
+	if (tlb->cleared_pgds)
+		return PGDIR_SHIFT;
 
 	return PAGE_SHIFT;
 }
@@ -545,6 +549,14 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 	tlb->cleared_p4ds = 1;
 }
 
+static inline void tlb_flush_pgd_range(struct mmu_gather *tlb,
+				     unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_pgds = 1;
+}
+
+
 #ifndef __tlb_remove_tlb_entry
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #endif
@@ -565,7 +577,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	do {							\
 		unsigned long _sz = huge_page_size(h);		\
-		if (_sz >= P4D_SIZE)				\
+		if (_sz >= PGDIR_SIZE)				\
+			tlb_flush_pgd_range(tlb, address, _sz);	\
+		else if (_sz >= P4D_SIZE)			\
 			tlb_flush_p4d_range(tlb, address, _sz);	\
 		else if (_sz >= PUD_SIZE)			\
 			tlb_flush_pud_range(tlb, address, _sz);	\
-- 
2.20.1

