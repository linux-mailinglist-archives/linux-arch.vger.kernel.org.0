Return-Path: <linux-arch+bounces-9867-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC6A19F40
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 08:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA32188A043
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178820B7FC;
	Thu, 23 Jan 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VnYbvFu7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55620B7EF
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618148; cv=none; b=W+nVwH6Eh13x9Q1bt7ltcH5z3C0nEK5zQMQ6Hm/tby8KpWPL4GCmnxtzKmV4fI9CRvQHR4qXa1MWeA3NbGFor6xbSPSb1bEhYk2/vBOA33Pc5xtj+RT50+6bnM/nWxK3dWo4rZz9Dr02/HH+BirhDMJg9Lqee9modSxVpITqJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618148; c=relaxed/simple;
	bh=wfajfUzt/gVR7KLjJXAQuJ+E1skD+YP/efwxQTViZVc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OiF9g56mSIghgKOBJAblsc/Tjr0eicBAldM+ft/kbLSuYeclX/R2vkLN0EsPbAsulThPVZ7qbLuK71Uy+SVpj4maaG0IGoAG2qCL8vvSzeynS3rhfLZ14oDR2GfFqmbAsZy1fMoyXaV1cDKBVhDHK2K4TyolW+s9dX4Ck7QCExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VnYbvFu7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so9771955ad.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737618146; x=1738222946; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo2Yjghf+PBm5FPd1YuKvq5zqJbtPenTYH/inXymsOg=;
        b=VnYbvFu7NXLwwOnyXGrrRwPzqjIAr6kvk9/Id8ztMsxooCJfKIcJqKD6UplV/P3DId
         jJq/M990yiwAN20lHRvod5h5C30V2ltDF8a/o758p6p03osuTf1M0KEW8IRJexBwscDH
         dQKwL/YUT9iZxrfaaY0Y2ylKoyKUhq2iDOXZwNS0ofo+Sva2CIih+Crtsh60c/uvkXKk
         LXDy1Yfy4BQ7SdJ9B5I2sEobd+Jg2xNCVRl6iB/5bODrVhUFKZNu4ejq4exVdFfThl6p
         TqYTVC0IY0Ws2TJgw0FKAY/co3bMA5LfJs6xXah8flGObllYpKY8a4HcNZAGbNON9Unl
         Mm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618146; x=1738222946;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo2Yjghf+PBm5FPd1YuKvq5zqJbtPenTYH/inXymsOg=;
        b=ODWXWg+ogH3E+NsvuDN0kgP/4lLWIHTjpckvYAI/PT9NhVK5Yb0yLd8ikYdd5OtDhE
         of/ezZpBhO6Sg4CojfPsxcpQZbacFB9nNvnwhsdXGkarRz1uFALL+PFMprBrf8ThcwlF
         IH6J4BvwmC9dxefZIqhAAsPpBDf0GS7silDr/5KJNZKYw7f5qB73sjlka37Z3jVk8MGR
         77cV59fBpsxxRgpEFvb6BR6UbmtRX/PSf5y1n+uN0rcx1X5YXAt92JNGceZMs8lK6zZ0
         bUdX+K9K9tBXya4/mHy3SuV3qFE9U1vcJJUDMcJ9XdhybDLN8r3udVIItORRK57h2MLn
         NDGg==
X-Forwarded-Encrypted: i=1; AJvYcCUFzJAQV4qKI+q40AGA82lV9DwHe9AtVIizSYi3+JZYihCmXPeZ2nC9fDN2AWiqgxD4+ArvsR2cVSeA@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTNv6asrc2QdiZMMyizlOXu7wsdMoBRhmgVVtpqY/fXzXDN96
	b2eRvrLXRMfy/1Iea11PY/MPY1uiJ/thLUZjT89cGfmphKtRbzT8y9gjTgxgRw==
X-Gm-Gg: ASbGncs7y1+rOxBsY9MP/jV4MVkj5XPgdzQL7atIFziRjOPS2Xfajx4p0KUgeuq/8rU
	LqweG24yEfZuTR6/ESdM2bY2k+sSRs/8Mj4KonPRHXNHar5I/4DbW3esXCEDr6E/wVzQK1eSEAy
	aN4UvMj6EFjq0fvJ3U2rwtrgTKvuDkeKYFy2evC8IQlj+5ZXMsr3Qd94JBveNN4CMByVKT5OMdD
	WmZwBZdwzcqWro9cxItOclA9jcdo7ZQSvlIbbEsz/kYPn9ew4MIifGvYUWDvIwcLcLnuR3N2whG
	/rcRiBDnHc36W3r0wv2zFPEEYIXtoBGUnXa+bO11AH60jnqYPdUV2dPnD0p40srl
X-Google-Smtp-Source: AGHT+IEPFrkjOSho6ZMrhwUrKQ+HhZzaOI9TlqZ8pK10JnKYj/aACTCK4JPXX4AQ/I7FKUG+1Xr1sQ==
X-Received: by 2002:a05:6a20:430e:b0:1e1:9f24:2e4c with SMTP id adf61e73a8af0-1eb2147fd19mr34162393637.16.1737618145551;
        Wed, 22 Jan 2025 23:42:25 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab817385sm12858014b3a.68.2025.01.22.23.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:42:24 -0800 (PST)
Date: Wed, 22 Jan 2025 23:42:13 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <20250122232716.1321171-1-roman.gushchin@linux.dev>
Message-ID: <c549a9af-cd5f-fd77-1af6-a10b30dd3256@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Jan 2025, Roman Gushchin wrote:

> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).
> 
> Fix this by moving the tlb flush out of tlb_end_vma() into
> free_pgtables(), somewhat similar to the stable version of the
> original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> for PFNMAP mappings before unlink_file_vma()").
> 
> Note, that if tlb->fullmm is set, no flush is required, as the whole
> mm is about to be destroyed.
> 
> v2:
>   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
>   - added comments (by Peter Z.)
>   - fixed the vma_pfn flag setting (by Hugh D.)
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/asm-generic/tlb.h | 41 ++++++++++++++++++++++++++-------------
>  mm/memory.c               |  7 +++++++
>  2 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 709830274b75..fbe31f49a5af 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -449,7 +449,14 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  	 */
>  	tlb->vma_huge = is_vm_hugetlb_page(vma);
>  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> -	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
> +
> +	/*
> +	 * vma_pfn is checked and cleared by tlb_flush_mmu_pfnmap()
> +	 * for a set of vma's, so it should be set if at least one vma
> +	 * has VM_PFNMAP or VM_MIXEDMAP flags set.
> +	 */
> +	if (vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))
> +		tlb->vma_pfn = 1;

Okay, but struct mmu_gather is usually on the caller's stack,
containing junk initially, and there's nothing in this patch
yet to initialize tlb->vma_pfn to 0.

__tlb_reset_range() needs to do that, doesn't it?  With some adjustment
to its comment about not resetting mmu_gather::vma_* fields.  Or would
it be better to get around that by renaming vma_pfn to, er, something
else - I'd have to understand the essence of Jann's race better to
come up with the right name - untracked_mappings? would that be right?
I still haven't grasped the essence of that race.

(Panic attack: where is, for example, tlb->need_flush_all initialized
to 0?  Ah, over in mm/mmu_gather.c, __tlb_gather_mmu().  Phew.)

And if __tlb_reset_range() resets tlb->vma_pfn to 0, then that has the
side-effect that any TLB flush cancels the vma_pfn state: which is a
desirable side-effect, isn't it? avoiding the possibility of doing an
unnecessary extra TLB flush in free_pgtables(), as I criticized before.

Hugh

>  }
>  
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> @@ -466,6 +473,22 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  	__tlb_reset_range(tlb);
>  }
>  
> +static inline void tlb_flush_mmu_pfnmap(struct mmu_gather *tlb)
> +{
> +	/*
> +	 * VM_PFNMAP and VM_MIXEDMAP maps are fragile because the core mm
> +	 * doesn't track the page mapcount -- there might not be page-frames
> +	 * for these PFNs after all. Force flush TLBs for such ranges to avoid
> +	 * munmap() vs unmap_mapping_range() races.
> +	 * Ensure we have no stale TLB entries by the time this mapping is
> +	 * removed from the rmap.
> +	 */
> +	if (unlikely(!tlb->fullmm && tlb->vma_pfn)) {
> +		tlb_flush_mmu_tlbonly(tlb);
> +		tlb->vma_pfn = 0;
> +	}
> +}
> +
>  static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>  					struct page *page, int page_size)
>  {
> @@ -549,22 +572,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
>  
>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
> -	if (tlb->fullmm)
> +	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
>  		return;
>  
>  	/*
> -	 * VM_PFNMAP is more fragile because the core mm will not track the
> -	 * page mapcount -- there might not be page-frames for these PFNs after
> -	 * all. Force flush TLBs for such ranges to avoid munmap() vs
> -	 * unmap_mapping_range() races.
> +	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> +	 * the ranges growing with the unused space between consecutive VMAs.
>  	 */
> -	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> -		/*
> -		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> -		 * the ranges growing with the unused space between consecutive VMAs.
> -		 */
> -		tlb_flush_mmu_tlbonly(tlb);
> -	}
> +	tlb_flush_mmu_tlbonly(tlb);
>  }
>  
>  /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 398c031be9ba..c2a9effb2e32 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  {
>  	struct unlink_vma_file_batch vb;
>  
> +	/*
> +	 * VM_PFNMAP and VM_MIXEDMAP maps require a special handling here:
> +	 * force flush TLBs for such ranges to avoid munmap() vs
> +	 * unmap_mapping_range() races.
> +	 */
> +	tlb_flush_mmu_pfnmap(tlb);
> +
>  	do {
>  		unsigned long addr = vma->vm_start;
>  		struct vm_area_struct *next;
> -- 
> 2.48.1.262.g85cc9f2d1e-goog

