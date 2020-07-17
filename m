Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF68223A12
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgGQLOl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGQLOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1796C08C5C0;
        Fri, 17 Jul 2020 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=G2PV3JD1hofFY1qgnR3BY+EQPfEM9HsXume4Dr7DRnk=; b=Ka83rRYoEtlhZlelqXZ2reoVNG
        c3psqE8LlKgY5/dxe8pHVAsn5xsC/K10d0dms9/MK3//sK20Xjwt/qTRwMPKptZyaoM81YRhrOOyP
        aPK2g/aIBYbfai8KbUpc7keOXMTTHznTBmSyA3RzslV20ge7d4zbgDncUMgNPU1/0KeXMsTiUzwFP
        GM4AAkK6f4JzqywkFCYyQ3YtScmPM34DM2DMpmTJPuElir8eUzZt6X5kKc2kReIUxv5+Rx+nDvvuU
        DhZTZbgf87SagTOmVsHLiZ5AGaCSE9R5k6ITPOprV8aaSl4WiMdbTHimgTsh/lAoEISmsPFyKW9Cz
        4ck418bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJb-0001da-1P; Fri, 17 Jul 2020 11:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A3E2306E07;
        Fri, 17 Jul 2020 13:14:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C4D5B203D4096; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.766472738@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 07/11] ia64/tlb: Fix __p*_free_tlb()
References: <20200717111005.024867618@infradead.org>
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


