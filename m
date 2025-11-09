Return-Path: <linux-arch+bounces-14593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E079C439EA
	for <lists+linux-arch@lfdr.de>; Sun, 09 Nov 2025 08:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F5347ADB
	for <lists+linux-arch@lfdr.de>; Sun,  9 Nov 2025 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E3236A70;
	Sun,  9 Nov 2025 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEaGkOX+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738B193077;
	Sun,  9 Nov 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762674288; cv=none; b=aJjBEXLqzWhk/rLAGtS3YvXvgvRwx4rdzF3w3Hb1XBoJhvxXEHkHzjOkSedsRW8Hs6JOuDwbyMaS+KjMVhEovn1bSUmi9qkFTMRc4cF476z6oJbolR/qq9FzkJW5FF6dJVGyolSRSoUH84uYNg1s024iDQGme7f2TvLBAP7xN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762674288; c=relaxed/simple;
	bh=SXM1RJK4Y1aQhRPlTIZtM6v4fO/FHLamLP4CHn5W4Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSJqfnMJzzF3G/rSAuAniLvYLmeqA/BnhBsT9W11SN278tsHN4otQNSwzRBgmg0Pb/mgmshQG/0bt0wWig1OcrbQfqlUJ/OtTrf5to+LT+qPNwphsZFcHolqJ4znRfOt+DFaCuXOuCW6M60mfSUEjt8DWk6S3WULV5neodwVRI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEaGkOX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AA7C4CEF7;
	Sun,  9 Nov 2025 07:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762674287;
	bh=SXM1RJK4Y1aQhRPlTIZtM6v4fO/FHLamLP4CHn5W4Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEaGkOX+750ge1zsRExJBdxcZCWiyCN2X9rbocTZpOwQ/utvZ7cEBIhPmySBA22IK
	 jq+1DNA9z7vEPGCw6sQV+usYTJ7BaRuYpGVcKtz6D6b/ivwhSPSUuHrNDxLkrv0E6w
	 u7Uh8KG+K568UPZVpF5pwihAMcy3558XoDn9BWZuWQclBN9BJlo0w/TT/4xZPC4jbA
	 NXwBrsta1LFyzniQty1sMyWCVuKCprOolZhqNpOUR1YagOFumcwq4hq67NJYzkzAcs
	 QSt5xqbAnZgjImnfftJvLkdpNeJizJCtNVCmTpQlEevZf2WjQIbVZd/BDn2yyU01w1
	 Fy4UefJ9vd0Og==
Date: Sun, 9 Nov 2025 09:44:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vishal Moola <vishal.moola@gmail.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aRBGaAd_AvSvtzU6@kernel.org>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107095922.3106390-1-chenhuacai@loongson.cn>

On Fri, Nov 07, 2025 at 05:59:22PM +0800, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Resend because the lines begin with # was eaten by git.
> 
>  include/asm-generic/pgalloc.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..706e87b43b19 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -18,8 +18,7 @@
>   */
>  static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  {
> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
> -			~__GFP_HIGHMEM, 0);
> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
>  
>  	if (!ptdesc)
>  		return NULL;
> @@ -172,7 +171,6 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
> @@ -226,7 +224,6 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
> @@ -270,7 +267,6 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, order);
>  	if (!ptdesc)
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

