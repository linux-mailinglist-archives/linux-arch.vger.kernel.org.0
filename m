Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB411302A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfLDQmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 11:42:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDQmS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 11:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yrRU3PisMm2st1jba/Bb8HxzI37AaG7nr9igFrhou+0=; b=YzSukzBJzdqU/YRJch4sntx/E
        sCZkgAXqyU8Ej6+v4ETINlSOyOuAcafjK2W4U6Fs//ZIYBczlusZ/pgQ44bR+n0nAlFM5eO8MirWJ
        qIjAFz6sXyFenhc9WNLc4StTDHvzQCcnIDggAMNIzuK8vkIlf24fOfOOlgl1Iz+UA11rQ08SXyC+w
        G1c3Dr+c8/Q/M6YpvfUOh3xnFX89tF5/200Y85jgFFVYZK0RQqPmSFlx+U6ud+y1xRZMmXFkg9eJb
        mG5q2RuAIdcWaLcilm+sE8on/C9JnC3syLBE4KkjSLE60YV8AStvK2Pb7JqHReYLAWBPh9Yjy6TQe
        BG0N42Dhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icXil-0007xP-5G; Wed, 04 Dec 2019 16:41:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ABC93006E3;
        Wed,  4 Dec 2019 17:40:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D67A20B83957; Wed,  4 Dec 2019 17:41:43 +0100 (CET)
Date:   Wed, 4 Dec 2019 17:41:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191204164143.GB2810@hirez.programming.kicks-ass.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
 <20191204133454.GW2844@hirez.programming.kicks-ass.net>
 <CAMuHMdVnhNFBqPQXKYCQbCnoQjZPSXRkuxbsbaguZ7_TcXXmVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVnhNFBqPQXKYCQbCnoQjZPSXRkuxbsbaguZ7_TcXXmVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 04, 2019 at 04:07:53PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 4, 2019 at 2:35 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Does this fare better?
> 
> Yes. Migo-R is happy again.
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/sh/include/asm/pgalloc.h
> > +++ b/arch/sh/include/asm/pgalloc.h
> > @@ -36,9 +36,7 @@ do {                                                  \
> >  #if CONFIG_PGTABLE_LEVELS > 2
> >  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
> >  do {                                                   \
> > -       struct page *page = virt_to_page(pmdp);         \
> > -       pgtable_pmd_page_dtor(page);                    \
> > -       tlb_remove_page((tlb), page);                   \
> > +       pmd_free((tlb)->mm, (pmdp));                    \
> >  } while (0);
> >  #endif

OK, so I was going to write a Changelog to go with that, but then I
realized that while this works and is similar to before the patch, I'm
not sure this is in fact correct.

With this on (and also before) we're freeing the PMD before we've done
the TLB invalidate, that seems wrong!

Looking at the size of that pmd_cache, that looks to be 30-(12+12-3)+3
== 12, which is exactly 1 page, for PAGE_SIZE_4K, less for the larger
pages.

I'm thinking perhaps we should do something like the below instead?


---
 arch/sh/mm/pgtable.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 5c8f9247c3c2..fac7e822fd0c 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -5,9 +5,6 @@
 #define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
 
 static struct kmem_cache *pgd_cachep;
-#if PAGETABLE_LEVELS > 2
-static struct kmem_cache *pmd_cachep;
-#endif
 
 void pgd_ctor(void *x)
 {
@@ -23,11 +20,6 @@ void pgtable_cache_init(void)
 	pgd_cachep = kmem_cache_create("pgd_cache",
 				       PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
 				       PAGE_SIZE, SLAB_PANIC, pgd_ctor);
-#if PAGETABLE_LEVELS > 2
-	pmd_cachep = kmem_cache_create("pmd_cache",
-				       PTRS_PER_PMD * (1<<PTE_MAGNITUDE),
-				       PAGE_SIZE, SLAB_PANIC, NULL);
-#endif
 }
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
@@ -48,11 +40,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
-}
-
-void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	kmem_cache_free(pmd_cachep, pmd);
+	BUILD_BUG_ON(PTRS_PER_PMD * (1<<PTE_MAGNITUDE) <= PAGE_SIZE);
+	return (pmd_t *)__get_free_page(PGALLOC_GFP);
 }
 #endif /* PAGETABLE_LEVELS > 2 */
