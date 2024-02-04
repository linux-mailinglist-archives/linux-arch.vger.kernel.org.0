Return-Path: <linux-arch+bounces-2075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9461848D00
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 11:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F73283841
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAA0219E0;
	Sun,  4 Feb 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIqwg0mm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50A21373;
	Sun,  4 Feb 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044344; cv=none; b=iNDG96PaQjq9yzb/7x95ao/SZfMVzVp3vpK/qPvlRI/UxpjAod+uQTJvS2rUDycdKX/+9qTvUEujjhjMw92qqUWyc98nicSCiK6TmpLAzRXENcr5x+gzMlFBRV9g6blrVTbBFwaWWXWnb7RF0mulSyX4eQrwwlQb9RgexnfKtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044344; c=relaxed/simple;
	bh=gPTH20pU/DzXXCAXEMnct3tWfsC+YYsXBZazocgU+S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9zMwc3q7e8s2/kQoAbBjDGHUTLxxJLpsuA/pO0GFB0w5JXHA85A5OuUXzOuRi+zPRRVuVndFO1Bji6KItwepC82YDBM6n3ugqFrTWDX0AOI2Ss6bVZPSfjCpH/hDdKoL66LwBmLiWTegekCKBrkNOGNUtUfPU1zU7wAOKxMJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIqwg0mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4ADC433C7;
	Sun,  4 Feb 2024 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707044344;
	bh=gPTH20pU/DzXXCAXEMnct3tWfsC+YYsXBZazocgU+S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIqwg0mmHnhbdBmB15Jd2Ku+Ap5LAoIwr6QSz7o7M4ZQTYQZNHoVqNxKgnyy6J0sk
	 cQGgupOTlS0eE6ZI6WmrYNYOQY5HtjxzHsyzlmZJO80HZYVWSgNtsrLI2djvpGMY6Q
	 RT6TNTAGHp6/ZPG8+jiB8rdBQYR2m6MgkHb7XGemcewjva4EtldPcruD8mUCs6S0p+
	 p3tG4JX7atakUDdJDDmkgNCulbCBf9R5YfT2AAtcPUA/aHquPJ2cAKhfvOKpdR7mTv
	 88hYwbIzhmqf2S9LAoF3AAc4OC5vAJjoAnSnKDvVv1WwveCQf8Z2NKAkzAxvOFRitI
	 h5glOgXAF/1uw==
Date: Sun, 4 Feb 2024 11:58:53 +0100
From: Mike Rapoport <rppt@kernel.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
	david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
Message-ID: <Zb9t7WtFbZofN5WZ@kernel.org>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>

On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
> For kernel PTE page, we do not need to allocate and initialize its split
> ptlock, but as a page table page, it's still necessary to add PG_table
> flag and NR_PAGETABLE statistics for it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/asm-generic/pgalloc.h |  7 ++++++-
>  include/linux/mm.h            | 21 ++++++++++++++++-----
>  2 files changed, 22 insertions(+), 6 deletions(-)

This should also update the architectures that define
__HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, otherwise NR_PAGETABLE counts will get
wrong.

Another related thing is that many architectures have custom allocations
for early page tables and these would also benefit form NR_PAGETABLE
accounting.
 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 879e5f8aa5e9..908bd9140ac2 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -23,6 +23,8 @@ static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
>  
>  	if (!ptdesc)
>  		return NULL;
> +
> +	__pagetable_pte_ctor(ptdesc);
>  	return ptdesc_address(ptdesc);
>  }
>  
> @@ -46,7 +48,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   */
>  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  {
> -	pagetable_free(virt_to_ptdesc(pte));
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
> +
> +	__pagetable_pte_dtor(ptdesc);
> +	pagetable_free(ptdesc);
>  }
>  
>  /**
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e442fd0efdd9..e37db032764e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2922,26 +2922,37 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
> -static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
> +static inline void __pagetable_pte_ctor(struct ptdesc *ptdesc)
>  {
>  	struct folio *folio = ptdesc_folio(ptdesc);
>  
> -	if (!ptlock_init(ptdesc))
> -		return false;
>  	__folio_set_pgtable(folio);
>  	lruvec_stat_add_folio(folio, NR_PAGETABLE);
> +}
> +
> +static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
> +{
> +	if (!ptlock_init(ptdesc))
> +		return false;
> +
> +	__pagetable_pte_ctor(ptdesc);
>  	return true;
>  }
>  
> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
> +static inline void __pagetable_pte_dtor(struct ptdesc *ptdesc)
>  {
>  	struct folio *folio = ptdesc_folio(ptdesc);
>  
> -	ptlock_free(ptdesc);
>  	__folio_clear_pgtable(folio);
>  	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
>  
> +static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
> +{
> +	ptlock_free(ptdesc);
> +	__pagetable_pte_dtor(ptdesc);
> +}
> +
>  pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
>  static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
>  {
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.

