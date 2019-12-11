Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6747F11AAF1
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfLKMcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:32:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbfLKMcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G2PV3JD1hofFY1qgnR3BY+EQPfEM9HsXume4Dr7DRnk=; b=hcORLxXGPCck7A1YsNcz4BOVw5
        VZ9YQWv9XZlSpLEEn9qepixFuPimXOy60XXWt3ripw7Xqv+I/N1ByNWua4F4JQBfkkD4d/7Ap3R9m
        P82/XSGQ0NUmbO/TKmrB78+YK/T7O7RA5T225bbnXot+ENok2WLlz6Go1QOoCNtLcaabPE8hJMV54
        S7C0x9k6/oOcaS+2zOvwfFG7Fz5cVhHbJ99wS4IOFPouTCtCbM4X2QB3Cr5E9IZllo5upKTgx4hNE
        3dBwNpWWD3IA+40d1UFETBBQUZ36Wf+/cHGQjHx5yn4Ljg/1SaM6ZTv0+OWVVX4N6yy2unAeTbjNe
        X94eo1fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0003sn-Fw; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3675307019;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4F17E20137CB7; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.456987895@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:27 +0100
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
Subject: [PATCH 14/17] ia64/tlb: Fix __p*_free_tlb()
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

Since IA64 has page based P[UM]Ds, no software walkers and IPI based
TLB invalidation, it can use the simple tlb_remove_page() based
freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/ia64/include/asm/pgalloc.h |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -50,7 +50,9 @@ static inline void pud_free(struct mm_st
 {
 	free_page((unsigned long)pud);
 }
-#define __pud_free_tlb(tlb, pud, address)	pud_free((tlb)->mm, pud)
+
+#define __pud_free_tlb(tlb, pud, address)	\
+	tlb_remove_table((tlb), virt_to_page(pud))
 #endif /* CONFIG_PGTABLE_LEVELS == 4 */
 
 static inline void
@@ -69,7 +71,8 @@ static inline void pmd_free(struct mm_st
 	free_page((unsigned long)pmd);
 }
 
-#define __pmd_free_tlb(tlb, pmd, address)	pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, address)	\
+	tlb_remove_table((tlb), virt_to_page(pmd)
 
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t * pmd_entry, pgtable_t pte)
@@ -84,6 +87,10 @@ pmd_populate_kernel(struct mm_struct *mm
 	pmd_val(*pmd_entry) = __pa(pte);
 }
 
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
 
 #endif				/* _ASM_IA64_PGALLOC_H */


