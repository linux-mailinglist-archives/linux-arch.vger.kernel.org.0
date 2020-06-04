Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDF1EE8D1
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgFDQs0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 12:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgFDQs0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jun 2020 12:48:26 -0400
Received: from kernel.org (unknown [87.71.78.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785802072E;
        Thu,  4 Jun 2020 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591289305;
        bh=Oz7w8Vy9BhqBNcFPLUtkFBwlNSjLFu/N//zwBWU6z1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpAs4zNrGftDH+mfIB6aH7FBHvii0eyFF4eGfjNke4KBrTczckrLCgkHoW5LOpXab
         zMovWEZ1cKUI1IRRf1GxOef/x+71d/03HlotOfi7JHLcWxCSSw/A7XESVjnbIVd0DK
         VihEcbNVmahz/dpMfM+c4PiM52AoOgpr7v341OcA=
Date:   Thu, 4 Jun 2020 19:48:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org,
        jroedel@suse.de, Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Fix pud_alloc_track()
Message-ID: <20200604164814.GA7600@kernel.org>
References: <20200604074446.23944-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604074446.23944-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 04, 2020 at 09:44:46AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The pud_alloc_track() needs to do different checks based on whether
> __ARCH_HAS_5LEVEL_HACK is defined, like it already does in
> pud_alloc(). Otherwise it causes boot failures on PowerPC.
> 
> Provide the correct implementations for both possible settings of
> __ARCH_HAS_5LEVEL_HACK to fix the boot problems.

There is a patch in mmotm [1] that completely removes
__ARCH_HAS_5LEVEL_HACK which is a part of the series [2] that updates
p4d folding accross architectures. This should fix boot on PowerPC and
the addition of pXd_alloc_track() for __ARCH_HAS_5LEVEL_HACK wouldn't be
necessary.


[1] https://github.com/hnaz/linux-mm/commit/cfae68792af3731ac902ea6ba5ed8df5a0f6bd2f
[2] https://lore.kernel.org/kvmarm/20200414153455.21744-1-rppt@kernel.org/

> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Fixes: d8626138009b ("mm: add functions to track page directory modifications")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/asm-generic/5level-fixup.h |  5 +++++
>  include/linux/mm.h                 | 26 +++++++++++++-------------
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
> index 58046ddc08d0..afbab31fbd7e 100644
> --- a/include/asm-generic/5level-fixup.h
> +++ b/include/asm-generic/5level-fixup.h
> @@ -17,6 +17,11 @@
>  	((unlikely(pgd_none(*(p4d))) && __pud_alloc(mm, p4d, address)) ? \
>  		NULL : pud_offset(p4d, address))
>  
> +#define pud_alloc_track(mm, p4d, address, mask)					\
> +	((unlikely(pgd_none(*(p4d))) &&						\
> +	  (__pud_alloc(mm, p4d, address) || ({*(mask)|=PGTBL_P4D_MODIFIED;0;})))?	\
> +	  NULL : pud_offset(p4d, address))
> +
>  #define p4d_alloc(mm, pgd, address)		(pgd)
>  #define p4d_alloc_track(mm, pgd, address, mask)	(pgd)
>  #define p4d_offset(pgd, start)			(pgd)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 66e0977f970a..ad3b31c5bcc3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2088,35 +2088,35 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  		NULL : pud_offset(p4d, address);
>  }
>  
> -static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> +static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
>  				     unsigned long address,
>  				     pgtbl_mod_mask *mod_mask)
> -
>  {
> -	if (unlikely(pgd_none(*pgd))) {
> -		if (__p4d_alloc(mm, pgd, address))
> +	if (unlikely(p4d_none(*p4d))) {
> +		if (__pud_alloc(mm, p4d, address))
>  			return NULL;
> -		*mod_mask |= PGTBL_PGD_MODIFIED;
> +		*mod_mask |= PGTBL_P4D_MODIFIED;
>  	}
>  
> -	return p4d_offset(pgd, address);
> +	return pud_offset(p4d, address);
>  }
>  
> -#endif /* !__ARCH_HAS_5LEVEL_HACK */
> -
> -static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> +static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
>  				     unsigned long address,
>  				     pgtbl_mod_mask *mod_mask)
> +
>  {
> -	if (unlikely(p4d_none(*p4d))) {
> -		if (__pud_alloc(mm, p4d, address))
> +	if (unlikely(pgd_none(*pgd))) {
> +		if (__p4d_alloc(mm, pgd, address))
>  			return NULL;
> -		*mod_mask |= PGTBL_P4D_MODIFIED;
> +		*mod_mask |= PGTBL_PGD_MODIFIED;
>  	}
>  
> -	return pud_offset(p4d, address);
> +	return p4d_offset(pgd, address);
>  }
>  
> +#endif /* !__ARCH_HAS_5LEVEL_HACK */
> +
>  static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
>  {
>  	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
