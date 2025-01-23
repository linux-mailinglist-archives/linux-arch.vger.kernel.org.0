Return-Path: <linux-arch+bounces-9875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B206A1AD24
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 00:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A1D188AB29
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9971D516B;
	Thu, 23 Jan 2025 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KG1mnJDj"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642301D54FE
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673968; cv=none; b=r479k8QFhXiH8Dtqd7e+r1okPsTsNfcS1wqwUN+l4x6IjMze3neZxPvbS/GbN3mcS6KBG0hmLzmEsY2Vi+W1kAWIAoODU1WDUjVw7l1qckKorCUEQEBII1tlbSGek8oy0GB2MQSUtEMPiK5nBLYDfCQTh8aBdoCmVm9NfcPlVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673968; c=relaxed/simple;
	bh=ILINFvh4RxFZDSZe/PGXqp2SuVTGXJ4KZFQ2W0Af80k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWY9rhar8YR7YnYmcJ/kQmcAxOPyWG6vylkBcRzYt39wnHAGcW6RdlouMR+pTbousR9AFP+uhil42BxybXPqDlu8LnYZt2A+mGsa0UXhGSQvzn05pXK/P43V6GVLcXtgw4t1cAeLutA2j8WQTB7HKy4h7ryIFC13G2TDosGyf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KG1mnJDj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Jan 2025 23:12:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737673958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcVBjBQLStuVpEoSo/cN17Pb3wX3zerdbPx0nMvViy8=;
	b=KG1mnJDjNxkunhbhotPTEcv3TpNHVrnU9gnUqot/KYWpOB4JNRrI3ePKNt3Y1/dLcD+Mnt
	LTRUg0uCSX36AiuN/ntQWoTrAqEDrv+dRm5He91qlE6LN55e5DcNwGAvdMwdvTFI0Zk5mp
	DI1tIWpIykHZJrmfxGlMSnVH8Fjd+Tc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <Z5LM4b2sC1fHgB3p@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123214531.GA969@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 10:45:31PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 11:27:16PM +0000, Roman Gushchin wrote:
> > Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> > added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> > race between munmap() and unmap_mapping_range(). However it added some
> > overhead to other paths where tlb_vma_end() is used, but vmas are not
> > removed, e.g. madvise(MADV_DONTNEED).
> > 
> > Fix this by moving the tlb flush out of tlb_end_vma() into
> > free_pgtables(), somewhat similar to the stable version of the
> > original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> > for PFNMAP mappings before unlink_file_vma()").
> 
> 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 398c031be9ba..c2a9effb2e32 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> >  {
> >  	struct unlink_vma_file_batch vb;
> >  
> > +	/*
> > +	 * VM_PFNMAP and VM_MIXEDMAP maps require a special handling here:
> > +	 * force flush TLBs for such ranges to avoid munmap() vs
> > +	 * unmap_mapping_range() races.
> > +	 */
> > +	tlb_flush_mmu_pfnmap(tlb);
> > +
> >  	do {
> >  		unsigned long addr = vma->vm_start;
> >  		struct vm_area_struct *next;
> 
> So I'm not sure I muc like this name, it is fairly random and does very
> much not convey the reason we're calling this.
> 
> Anyway, going back to reading the original commit (because this
> changelog isn't helping me much), the problem appears to be that
> unlinking the vma will make unmap_mapping_range() skip things (no vma,
> nothing to do, etc) return early and bad things happen.
> 
> So am I right in thinking we need this tlb flush before all those
> unlink_{anon,file}_vma*() calls, and that the whole free_pgd_range()
> that goes and invalidates the page-tables is too late?
> 
> So how about we do something like so instead?

Overall looks good to me, except one question (below).

> 
> ---
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 709830274b75..481a24f2b839 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -58,6 +58,11 @@
>   *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
>   *    there's large holes between the VMAs.
>   *
> + *  - tlb_free_vma()
> + *
> + *    tlb_free_vma() marks the start of unlinking the vma and freeing
> + *    page-tables.
> + *
>   *  - tlb_remove_table()
>   *
>   *    tlb_remove_table() is the basic primitive to free page-table directories
> @@ -384,7 +389,10 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  	 * Do not reset mmu_gather::vma_* fields here, we do not
>  	 * call into tlb_start_vma() again to set them if there is an
>  	 * intermediate flush.
> +	 *
> +	 * Except for vma_pfn, that only cares if there's pending TLBI.
>  	 */
> +	tlb->vma_pfn = 0;
>  }
>  
>  #ifdef CONFIG_MMU_GATHER_NO_RANGE
> @@ -449,7 +457,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  	 */
>  	tlb->vma_huge = is_vm_hugetlb_page(vma);
>  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> -	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
> +
> +	/*
> +	 * Track if there's at least one VM_PFNMAP/VM_MIXEDMAP vma
> +	 * in the tracked range, see tlb_free_vma().
> +	 */
> +	tlb->vma_pfn  |= !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
>  }
>  
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> @@ -548,23 +561,39 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
>  }
>  
>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> +{
> +	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> +		return;
> +
> +	/*
> +	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> +	 * the ranges growing with the unused space between consecutive VMAs,
> +	 * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
> +	 * this.
> +	 */
> +	tlb_flush_mmu_tlbonly(tlb);
> +}
> +
> +static inline void tlb_free_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
>  	if (tlb->fullmm)
>  		return;
>  
>  	/*
>  	 * VM_PFNMAP is more fragile because the core mm will not track the
> -	 * page mapcount -- there might not be page-frames for these PFNs after
> -	 * all. Force flush TLBs for such ranges to avoid munmap() vs
> -	 * unmap_mapping_range() races.
> +	 * page mapcount -- there might not be page-frames for these PFNs
> +	 * after all.
> +	 *
> +	 * Specifically() there is a race between munmap() and
> +	 * unmap_mapping_range(), where munmap() will unlink the VMA, such
> +	 * that unmap_mapping_range() will no longer observe the VMA and
> +	 * no-op, without observing the TLBI, returning prematurely.
> +	 *
> +	 * So if we're about to unlink such a VMA, and we have pending
> +	 * TLBI for such a vma, flush things now.
>  	 */
> -	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> -		/*
> -		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> -		 * the ranges growing with the unused space between consecutive VMAs.
> -		 */
> +	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) && tlb->vma_pfn)
>  		tlb_flush_mmu_tlbonly(tlb);
> -	}

Why do we need to re-check vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP) here?

In free_pgtables() we're iterating over multiple vma's. What if the first has
no VM_PFNMAP set, but some other do? Idk if it's even possible, but it's not
obvious that it's not possible either.

Btw, are you going to handle it yourself or you want me to send a v4 based
on your version?

Thank you!

