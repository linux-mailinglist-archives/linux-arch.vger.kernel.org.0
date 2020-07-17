Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B440A223A2E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgGQLPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGQLPC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:15:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFFC061755;
        Fri, 17 Jul 2020 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JpsKOsZ9DAnC7hF8A6UR44iGc8j6T+HCUrwgJT3qna0=; b=GsN9f7zd3xGQm9E7Rs/9GO6Onv
        tQFOciWVNRa0dSkuBi2M3LCrvRWcBpajEzmYqEbvlBaXEJj5TVu8rwQy1Q7CNM7FZR48rVSTeBEGI
        rxqAK1jJtMJgtXRWRByIMPriLYyhgef4TVlkdIWBk/HEuGJcrF5ZqBi4hDqMeVize23cLJ0dbQ2Rr
        ip6Sj9RwHTkJWgq4VEYAlzp2yq6rkCH7ht7KXWI/JDmBlDwMD1hfEqR0twYDRHj0D9qMYMWXXgvJy
        1co1QpT2PKFq+vwxgBdv2Cf4ZMf4aetp6NLBpyaXqUnapfRc5si+FOdHmr45RHoiibPH/LNSuP/jA
        R5Ykw5SA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJa-00051V-96; Fri, 17 Jul 2020 11:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D7ED300446;
        Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AC1F7203D4090; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.475459591@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:07 +0200
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
        Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 02/11] sh/tlb: Fix PGTABLE_LEVELS > 2
References: <20200717111005.024867618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Geert reported that his SH7722-based Migo-R board failed to boot after
commit:

  c5b27a889da9 ("sh/tlb: Convert SH to generic mmu_gather")

That commit fell victim to copying the wrong pattern --
__pmd_free_tlb() used to be implemented with pmd_free().

Fixes: c5b27a889da9 ("sh/tlb: Convert SH to generic mmu_gather")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -12,6 +12,7 @@ extern void pgd_free(struct mm_struct *m
 extern void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd);
 extern pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address);
 extern void pmd_free(struct mm_struct *mm, pmd_t *pmd);
+#define __pmd_free_tlb(tlb, pmdp, addr)		pmd_free((tlb)->mm, (pmdp))
 #endif
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -33,13 +34,4 @@ do {							\
 	tlb_remove_page((tlb), (pte));			\
 } while (0)
 
-#if CONFIG_PGTABLE_LEVELS > 2
-#define __pmd_free_tlb(tlb, pmdp, addr)			\
-do {							\
-	struct page *page = virt_to_page(pmdp);		\
-	pgtable_pmd_page_dtor(page);			\
-	tlb_remove_page((tlb), page);			\
-} while (0);
-#endif
-
 #endif /* __ASM_SH_PGALLOC_H */


