Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429A3A0EF5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFIIw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 04:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237776AbhFIIw4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 04:52:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40D73613B6;
        Wed,  9 Jun 2021 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623228662;
        bh=8tEls2a/j7rfLxExLeORjJlhhRMMnkNIAM3JBjeBXvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQDflmZe8GCGk+yE+6t0jnBhybC3t6u+cv2dwtA8RYnfwgMeo8WJWR4Jrk7+oEHUG
         +LZhm54B/GRv/+AzBai/pepBRapGN3Yvum4g4htxptOm6Hin60MyrUPSdVoPl6Ima3
         63J43iUHA9zvuAOVzdCIYQlNhWzw3VSq+/Y3MZUi2GAooFLzxkS4DSacafOcOctPxH
         v3FZAF2gvX6Wl9H4lgAvp++2zsKZ0H3xMxhlEZXW8aztVORCBq+5xgkHPoE3/tL15r
         V7qg8oNM/cWsYEUomz3iFnSd9hjsy2q2Oouc/gWltLvLJigxqi1qzAGUlIn0ABKiLo
         RVXEJ7ZZn38MQ==
Date:   Wed, 9 Jun 2021 11:50:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Nick Hu <nickhu@andestech.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/thp: Define default pmd_pgtable()
Message-ID: <YMCA6Nsuu26k1746@kernel.org>
References: <1623214799-29817-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623214799-29817-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On Wed, Jun 09, 2021 at 10:29:59AM +0530, Anshuman Khandual wrote:
> Currently most platforms define pmd_pgtable() as pmd_page() duplicating the
> same code all over. Instead just define a default value i.e pmd_page() for
> pmd_pgtable() and let platforms override when required via <asm/pgtable.h>.
> All the existing platform that override pmd_pgtable() have been moved into
> their respective <asm/pgtable.h> header in order to precede before the new
> generic definition. This makes it much cleaner with reduced code.
> 
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

One nit below, otherwise

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> This patch applies on linux-next (20210608) as there is a merge conflict
> dependency on the following commit.
> 
> 40762590e8be ("mm: define default value for FIRST_USER_ADDRESS").
> 
> This patch has been built tested across multiple platforms.
> 
> Changes in V2:
> 
> - Changed m68k per Geert
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-arch/1623130327-13325-1-git-send-email-anshuman.khandual@arm.com/

...

> diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
> index 000f64869b91..198036aff519 100644
> --- a/arch/m68k/include/asm/sun3_pgalloc.h
> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
> @@ -32,7 +32,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
>  {
>  	pmd_val(*pmd) = __pa((unsigned long)page_address(page));
>  }
> -#define pmd_pgtable(pmd) pmd_page(pmd)
>  
>  /*
>   * allocating and freeing a pmd is trivial: the 1-entry pmd is
> diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
> index 5b24283a0a42..127282bd8b96 100644
> --- a/arch/m68k/include/asm/sun3_pgtable.h
> +++ b/arch/m68k/include/asm/sun3_pgtable.h
> @@ -96,6 +96,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#define pmd_pgtable(pmd) pmd_page(pmd)
> +

Is this one really needed? Won't the generic definition work instead?

>  /*
>   * Conversion functions: convert a page and protection to a page entry,
>   * and a page entry and page directory to the page they refer to.
> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> index d56b9f670ad1..6c33b05f730f 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -28,8 +28,6 @@ static inline pgd_t *get_pgd(void)
>  
>  #define pgd_alloc(mm)		get_pgd()
>  
> -#define pmd_pgtable(pmd)	pmd_page(pmd)
> -
>  extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  
>  #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))

-- 
Sincerely yours,
Mike.
