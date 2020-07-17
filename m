Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87E2223A2A
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGQLO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGQLOn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A46C08C5CE;
        Fri, 17 Jul 2020 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3R2DK7HvOJXWBjGxheTnCh1+oyh0A3xwV1bV88LUreM=; b=FAUumSd9I3/VNHUgNXx4k0r+oK
        XPsBvhXBs2S9D8KdP1DdzCn+DjvPQ/N53rubfaZdx/Zq28lfMnE4FWFrXxchpt7Fbf1H73vWibr4j
        kfeW2q7hWNzjn/xQ6xAH8dq5lajcLheqYNu/je7J2zCrVzuEsYRRAFG8On6JhRJVcrbLv0gwFgUug
        bT0FH7mxmojgXV6jLLYfJmaqGbBGG8nQCUBThUvi3fkTD9RIO3Clg7X9ZI3AaI+BL+SV+CRdZCc+o
        BsKMmuBNmewZ0MHaEgdFKq/FNkMMPDtazHdq2QEWx7CFn5z/oZZa+NB8HoSkX62V2Q62o6751m0i0
        7KMjrc4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJa-00051T-8Y; Fri, 17 Jul 2020 11:14:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81233306E3A;
        Fri, 17 Jul 2020 13:14:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D05A1203D4099; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.942447764@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:15 +0200
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
Subject: [PATCH v2 10/11] riscv/tlb: Fix __p*_free_tlb()
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

Since RISC-V has page based PMDs, no software walkers and IPI based
TLB invalidation, it can use the simple tlb_remove_page() based
freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/riscv/include/asm/pgalloc.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -73,14 +73,15 @@ static inline void pmd_free(struct mm_st
 	free_page((unsigned long)pmd);
 }
 
-#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, addr)	\
+	tlb_remove_table((tlb), virt_to_page(pmd))
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)   \
-do {                                    \
-	pgtable_pte_page_dtor(pte);     \
-	tlb_remove_page((tlb), pte);    \
+#define __pte_free_tlb(tlb, pte, buf)	\
+do {					\
+	pgtable_pte_page_dtor(pte);	\
+	tlb_remove_table((tlb), (pte));	\
 } while (0)
 #endif /* CONFIG_MMU */
 


