Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E10131FA
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfECQSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 12:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECQSa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 May 2019 12:18:30 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE0020651;
        Fri,  3 May 2019 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900308;
        bh=1gc+88gGR8xs/HHG6j+3eKyXyw0MdhLPFZmbxDlan0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORHT3+AoYShsuuQO5PFoH4MN9lIuD27v03opdUhE7D6MhJ3ZFlrne2bcwdb1S/99e
         JNCnsuMLUbfOQundyleyVhRpdJdwc193k7lyiJTj+1sl9zI38iCZlnHNebbBFtS/8d
         UBobcwP26APlYC3LB4Vq9ec4UDgXUUcThKhfVnBY=
Date:   Sat, 4 May 2019 00:18:08 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>,
        Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
        Greentime Hu <green.hu@gmail.com>,
        nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/15] csky: switch to generic version of pte allocation
Message-ID: <20190503161808.GA11596@guoren-Inspiron-7460>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-6-git-send-email-rppt@linux.ibm.com>
 <20190503160348.GA9526@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503160348.GA9526@guoren-Inspiron-7460>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 04, 2019 at 12:03:48AM +0800, Guo Ren wrote:
> Hi Mike,
> 
> Acked-by: Guo Ren <ren_guo@c-sky.com>
> 
> On Thu, May 02, 2019 at 06:28:32PM +0300, Mike Rapoport wrote:
> > The csky implementation pte_alloc_one(), pte_free_kernel() and pte_free()
> > is identical to the generic except of lack of __GFP_ACCOUNT for the user
> > PTEs allocation.
> > 
> > Switch csky to use generic version of these functions.
> Ok.
> 
> > 
> > The csky implementation of pte_alloc_one_kernel() is not replaced because
> > it does not clear the allocated page but rather sets each PTE in it to a
> > non-zero value.
> Yes, we must set each PTE to _PAGE_GLOBAL because hardware refill the
> MMU TLB entry with two PTEs and it use the result of pte0.global | pte1.global.
                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^
                                              correct: pte0.global & pte1.global
> If pte0 is valid and pte1 is invalid, we must set _PAGE_GLOBAL in
> invalid pte entry. Fortunately, there is no performance issue.
> 
> > 
> > The pte_free_kernel() and pte_free() versions on csky are identical to the
> > generic ones and can be simply dropped.
> Ok.
> 
> Best Regards
>  Guo Ren
> 
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/csky/include/asm/pgalloc.h | 30 +++---------------------------
> >  1 file changed, 3 insertions(+), 27 deletions(-)
> > 
> > diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
> > index d213bb4..98c571670 100644
> > --- a/arch/csky/include/asm/pgalloc.h
> > +++ b/arch/csky/include/asm/pgalloc.h
> > @@ -8,6 +8,9 @@
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> >  
> > +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> > +#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
> > +
> >  static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
> >  					pte_t *pte)
> >  {
> > @@ -39,33 +42,6 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >  	return pte;
> >  }
> >  
> > -static inline struct page *pte_alloc_one(struct mm_struct *mm)
> > -{
> > -	struct page *pte;
> > -
> > -	pte = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
> > -	if (!pte)
> > -		return NULL;
> > -
> > -	if (!pgtable_page_ctor(pte)) {
> > -		__free_page(pte);
> > -		return NULL;
> > -	}
> > -
> > -	return pte;
> > -}
> > -
> > -static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> > -{
> > -	free_pages((unsigned long)pte, PTE_ORDER);
> > -}
> > -
> > -static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
> > -{
> > -	pgtable_page_dtor(pte);
> > -	__free_pages(pte, PTE_ORDER);
> > -}
> > -
> >  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> >  {
> >  	free_pages((unsigned long)pgd, PGD_ORDER);
> > -- 
> > 2.7.4
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
