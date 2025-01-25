Return-Path: <linux-arch+bounces-9904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFF5A1C031
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 02:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA3C16D1E5
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78F150980;
	Sat, 25 Jan 2025 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="unLAAWB2"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334891487DD
	for <linux-arch@vger.kernel.org>; Sat, 25 Jan 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768253; cv=none; b=sZ41W3nZU+QshcocMR6To+ueGNOpd63x08o5VU4wbeP3ILM0mu+9zgx49CXWgOH9kBCB3OUzHG61s0OB+S9HNJU9LYGS2uTnu5iph1fAxHsWpF4cit8i6y9NAR5asfAUsERERx4xyIHo08iQ/tmUOLj8naKslqrvAUOapupzcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768253; c=relaxed/simple;
	bh=FYVfMxPYc+OFMvEkABiP1w05Cizf7xW4POCl2ZmnkxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2NEb+/f1KQmsJaKD+laN3jOU0i0tsj/yLlTR/4iiBEs4xtdZxAn1tDZhWFmfp/39j69yorv+/z5kfjbMOvBpMyo5iOAZGUxqBejNNbj0UAthwPLeYx5PKpduTHTgdfq7ZpuzMZ0Zzs0cs4VHZ+H4AR9dSXrjQbRWeidfZYfCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=unLAAWB2; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/pSbQD6T7cVkyHZaa4OI7IbTRYzdcQFCXIisyqs6sDM=;
	b=unLAAWB20cFTyKOtxmF44nr4maB8AeQkhvOjERFWEZKOP1qB1ZW9wA8TkoaVA1GZSUFjSF
	tbR2i3YhDxfsMGAdCkq4D5ukUiD8CNyvG8V9DBWKSOUezwkIZ0UDB3GJQpsp1rLAtVxwMd
	ZFHNa5MFYur4wlTDVCLjuzS0gqWCJTI=
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
Message-ID: <Z5Q9KvugnVQv8QIO@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
 <Z5LM4b2sC1fHgB3p@google.com>
 <20250124082250.GA13226@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124082250.GA13226@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 09:22:50AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 11:12:33PM +0000, Roman Gushchin wrote:
> 
> > > +static inline void tlb_free_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > >  {
> > >  	if (tlb->fullmm)
> > >  		return;
> > >  
> > >  	/*
> > >  	 * VM_PFNMAP is more fragile because the core mm will not track the
> > > +	 * page mapcount -- there might not be page-frames for these PFNs
> > > +	 * after all.
> > > +	 *
> > > +	 * Specifically() there is a race between munmap() and
> > > +	 * unmap_mapping_range(), where munmap() will unlink the VMA, such
> > > +	 * that unmap_mapping_range() will no longer observe the VMA and
> > > +	 * no-op, without observing the TLBI, returning prematurely.
> > > +	 *
> > > +	 * So if we're about to unlink such a VMA, and we have pending
> > > +	 * TLBI for such a vma, flush things now.
> > >  	 */
> > > +	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) && tlb->vma_pfn)
> > >  		tlb_flush_mmu_tlbonly(tlb);
> > 
> > Why do we need to re-check vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP) here?
> 
> No need, but an opportunity.
> 
> > In free_pgtables() we're iterating over multiple vma's. What if the first has
> > no VM_PFNMAP set, but some other do? Idk if it's even possible, but it's not
> > obvious that it's not possible either.
> 
> If we only need to flush PFN entries before unlinking PFN VMAs, then:
> 
>  - if there are no PFNs pending (vma_pfn), we don't need to flush;
>  - if no PFN vma is being freed (vm_flags), we don't need to flush.

Right, but if I understand the code correctly, more than one vma can be
freed by a single free_pgtables() invocation. Should we then check
each vma's flags in the while loop in free_pgtables()? But then
we're back to where we're now with multiple flushes.

Do I misunderstand this?

Thanks

