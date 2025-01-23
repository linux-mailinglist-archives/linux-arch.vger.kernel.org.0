Return-Path: <linux-arch+bounces-9874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31813A1ACA7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986B07A3267
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201BF1D45FE;
	Thu, 23 Jan 2025 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaNBbxxY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714D1D3576
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671216; cv=none; b=tuu4vN0vOE3A1pZxLTB8qhU5HsmlIQyVUlB6zz+AzgGuV4gaMA7NLwZP82dC411mhZGD/Szz5BgWwG3De4P14+M9wvVh4Np2u1vXQTbbs5e3WKbNq3X7qpy3kAjgKFOPBio+P4IBILn2JG8vQS42iNJ34cYsLn2aUvWF12N7Qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671216; c=relaxed/simple;
	bh=YxkDzrDcoFpsXuNxNlivsvDgnLQCtMSMvJ79SrwZ/Uc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C12kI//eav0WaVrRI6uR6shCkIeKQpskeaizza0LvuFQosIJd9tVZPqwAi2D43W9mos2mNLFcuiXtLdELDG4azT9Hmif8i6GMvfVAulc3FGBjw+S8bI6P9/kL15ZhLUdbvr1gdlg/F/kg2n2xGGbRzZu1w1hel8mNdeDT5v+9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XaNBbxxY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c8aca5f1so33487385ad.0
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 14:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737671213; x=1738276013; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tft7nm1JR9P/DYe+6ctmV/lRjjdKS3eqeij/WSGrhTY=;
        b=XaNBbxxYC1Q3YhD80DROYj9L/VZTOzHrHXRRC51d5vrA6T4EZpNLk5YiedShkqajoQ
         BwLZ3GE8GMJL/AjDeie3tbwL7JuFblEhS7lAN4qmi4lqe5lvPlgKDKeUPp+FGLGuCaJz
         Hp+4huXkaMJ7nlmOTnYAU+1YlnbMTAfCASNBKGw54BDleEOni/waYi7Zs78kns0cgjlj
         Qt+XDvd25zlH8rE3dcnIR03wXvHvXZPVqt8digAkD1yBbiX1VYdi5PjPsxQ3fNUliLc+
         Iw0w3J2r+ZJJLVrtIxh67ZiQnJ7UCpu9Fs7yBOD2FudwS6gkeMjyU5yVmF3U81ytZzZd
         Viww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737671213; x=1738276013;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tft7nm1JR9P/DYe+6ctmV/lRjjdKS3eqeij/WSGrhTY=;
        b=Jmwq3HNMaUv/QJTlbJAYyqesao2PktxEWvJaRl7pQsI52OomsYtWWxhbIUeOLFWOP5
         rTohiUbQ7hcNheAAtZl12Ps6ZxCTCD1+p0IaO/pbsuf7qca4Rj8sAZy0i9lEz8n/62YA
         biy+U0uc4rf7y4DQeygdyA+xXC1kdtNEtpvB0Jfw/dtf2hSXs48vDamS/vMRIfNFEMpd
         h7NgTZ8X3HV2GFh1a2PgIyFQlfA+ZGmRmb5/TF0ba92GbYOP1X6PW5LHh6x1Slmfw31j
         8pcKR4VXAt0Nj11VKPK7BY2t3Ih66yqQIPjVTc8PnCtn6llMQ9tYZOWj8DpX3NmJs5Mj
         Bjkw==
X-Forwarded-Encrypted: i=1; AJvYcCVS84oAX/heEJJypBdd+e+IvX/qWN+busAzm6dn7boRwqrmK7DVZYZXMnFpndX4UGLgkNsMS01yis0b@vger.kernel.org
X-Gm-Message-State: AOJu0YwWs1ORwG01h5GSR+opaUqSBKBWG/JR6rLMX42S4xctoCb9Z9pT
	j2lZ+w5CihqZte1S/Nmw2TAD8B7Kms7gL0fwXvCPG126c4yri0C01j/FG1rOoA==
X-Gm-Gg: ASbGncth2ANGPP1lWZhHT0hnl5/IzmgrrWvQfF8ioYDAviQvkmYj9tNwzEBSRgRnMxc
	97iU+oUkV8AUvRGPsPDfONUgw6pVtIj1akJhFnx3M2qSuIe332V7Ihu0E/PPZaticl11RBYoQ3a
	cR+ePnlxujxF0D1toazt2uzEjTtqa/I70svw5dGXHn/jg3TkQyu60EQOGiI4207Zmd8J/7oM9Rk
	WcRzcfXWg22WoZqhmHzQd+O/9zNxntIKlgtgX/fvORKTrvshMDhJ9BcO/cdStulmaoyYV4bSITS
	8hf6wsEDVeC3xsDUJad2liK5jBhiIKAbxbJpHi2JmlhpzOhD/zq4iujstgPPo3UR1HR2kpRV4aI
	=
X-Google-Smtp-Source: AGHT+IFdr/JY0zYSzFQXqKrxePDHm7GTPzdct2mHp7qiWEvNNUEv0l0Rhkvb8+8S4Eb6YB26iHiPTg==
X-Received: by 2002:a05:6a20:7f96:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1eb2147d3f9mr41098399637.11.1737671213391;
        Thu, 23 Jan 2025 14:26:53 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6d22e4sm471624b3a.83.2025.01.23.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 14:26:52 -0800 (PST)
Date: Thu, 23 Jan 2025 14:26:42 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <20250123164358.2384447-1-roman.gushchin@linux.dev>
Message-ID: <32128611-60d5-147c-7e82-7b1dfbe8236b@google.com>
References: <20250123164358.2384447-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Jan 2025, Roman Gushchin wrote:

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
> ---

As Liam said, thanks.

> 
> v3:
>   - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)
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
>  include/asm-generic/tlb.h | 49 ++++++++++++++++++++++++++++-----------
>  mm/memory.c               |  7 ++++++
>  2 files changed, 42 insertions(+), 14 deletions(-)

The code looks right to me now, but not the comments (I usually
prefer no comment to a wrong or difficult to get right comment).

Except when I try to write a simple enough correct comment,
I find the code has to be changed, and that then suggests
further changes... Sigh.

(We could also go down a path of saying that all of the vma_pfn stuff
would be better under #fidef CONFIG_MMU_GATHER_MERGE_VMAS; but I
think we shall only confuse ourselves that way - it shouldn't be
enough to matter, so long as it does not add any extra TLB flushes.)

> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 709830274b75..cdc95b69b91d 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -380,8 +380,16 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  	tlb->cleared_pmds = 0;
>  	tlb->cleared_puds = 0;
>  	tlb->cleared_p4ds = 0;
> +
> +	/*
> +	 * vma_pfn can only be set in tlb_start_vma(), so let's
> +	 * initialize it here. Also a tlb flush issued by
> +	 * tlb_flush_mmu_pfnmap() will cancel the vma_pfn state,
> +	 * so that unnecessary subsequent flushes are avoided.

No, that misses the point (or misses half of the point): the
tlb_flush_mmu_pfnmap() itself won't need to flush if for other reasons
we've done a TLB flush since the last VM_PFNMAP|VM_MIXEDMAP vma.

What I want to write is:
	 * vma_pfn can only be set in tlb_start_vma(), so initialize it here.
	 * And then any call to tlb_flush_mmu_tlbonly() will reset it again,
	 * so that unnecessary subsequent flushes are avoided.

But once I look at tlb_flush_mmu_tlbonly(), I'm reminded that actually
it does nothing, if none of cleared_ptes etc. is set: so would not reset
vma_pfn in that case; which is okay-ish, but makes writing the comment hard.

So maybe tlb_flush_mmu_tlbonly() should do an explicit "tlb->vma_pfn = 0"
before returning early; but that then raises the question of whether it
would not be better just to initialize vma_pfn to 0 in __tlb_gather_mmu(),
not touch it in __tlb_reset_range(), but reset it to 0 at the start of
tlb_flush_mmu_tlbonly().

But it also makes me realize that tlb_flush_mmu_tlbonly() avoiding
__tlb_reset_range() when nothing was cleared, is not all that good:
because if flushing a small range is better than flushing a large range,
then it would be good to reset the range even when nothing was cleared
(though it looks stupid to reset all the fields just found 0 already).

Arrgh.  This is not what you wnat to hear, to get your slowdown fix in.
Simplest just to ignore the existing range deficiency, I suppose.  But
where to reset vma_pfn?  I'm torn, have to let you and others decide.

Hugh

> +	 */
> +	tlb->vma_pfn = 0;
>  	/*
> -	 * Do not reset mmu_gather::vma_* fields here, we do not
> +	 * Do not reset other mmu_gather::vma_* fields here, we do not
>  	 * call into tlb_start_vma() again to set them if there is an
>  	 * intermediate flush.
>  	 */
> @@ -449,7 +457,14 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
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
>  }
>  
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> @@ -466,6 +481,20 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
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
> +	if (unlikely(!tlb->fullmm && tlb->vma_pfn))
> +		tlb_flush_mmu_tlbonly(tlb);
> +}
> +
>  static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>  					struct page *page, int page_size)
>  {
> @@ -549,22 +578,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
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

