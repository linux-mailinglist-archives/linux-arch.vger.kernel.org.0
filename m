Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4711AAD8
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfLKMbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfLKMbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6kZNNxSi21G4pXOCtXTpl9gJxQNMiVTuEix3Ulh9cmE=; b=U+50FffwCXOOmCFvs0ul2LtaFV
        hZXEbR8JwFIHgJxOtnzEuLJhbTgu/iLzJyBkFwz+/L9ig1+9iG+tN/50OiRVoeGNimDy0Cbj4xuY7
        bO2Vs8F0SOAtThWosCnNtDOez0aUiE4CX6pieCiH/ItSRf9VEM1GdopsL384J5Q2+a8ZpAjzZ/fQd
        5of6hD4fwuTT1mD9s0EvEfKwaFrLhS8jHCzJSRmSjHqz3WIFHPescBDqQ0xwffllkhZgBb71wGqaC
        YDcVwIo2S+eiZH/q4Md3azal/pDEv9YXSI6Gg9Gnj5Hp8/s7qQxFFodqMxsGDL45vFOVDS8xqRJT8
        ipsqcG0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0001Pb-LA; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC9E8306BF0;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4770520137CB9; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.342306385@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 12/17] m68k/tlb: Fix __p*_free_tlb()
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

The Motorola MMU has funny PMD stuff, so use a custom table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/Kconfig                        |    1 +
 arch/m68k/include/asm/mcf_pgalloc.h      |   11 +++++------
 arch/m68k/include/asm/motorola_pgalloc.h |   22 ++++++++++------------
 3 files changed, 16 insertions(+), 18 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -31,6 +31,7 @@ config M68K
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select MMU_GATHER_NO_RANGE if MMU
+	select MMU_GATHER_TABLE_FREE if MMU_MOTOROLA
 
 config CPU_BIG_ENDIAN
 	def_bool y
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -38,12 +38,11 @@ extern inline pmd_t *pmd_alloc_kernel(pg
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
-				  unsigned long address)
-{
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
-}
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_page((tlb), (pte));		\
+} while (0)
 
 #define __pmd_free_tlb(tlb, pmd, address) do { } while (0)
 
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -57,15 +57,13 @@ static inline void pte_free(struct mm_st
 	__free_page(page);
 }
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
-				  unsigned long address)
-{
-	pgtable_pte_page_dtor(page);
-	cache_page(kmap(page));
-	kunmap(page);
-	__free_page(page);
-}
-
+#define __pte_free_tlb(tlb, pte, address)		\
+do {							\
+	pgtable_pte_page_dtor(pte);			\
+	cache_page(kmap(pte));				\
+	kunmap(pte);					\
+	tlb_remove_page((tlb), (pte));			\
+} while (0)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
@@ -77,12 +75,12 @@ static inline int pmd_free(struct mm_str
 	return free_pointer_table(pmd);
 }
 
-static inline int __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-				 unsigned long address)
+static inline void __tlb_remove_table(void *table)
 {
-	return free_pointer_table(pmd);
+	free_pointer_table(table);
 }
 
+#define __pmd_free_tlb(tlb, pmd, address) tlb_remove_table((tlb), (pmd))
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {


