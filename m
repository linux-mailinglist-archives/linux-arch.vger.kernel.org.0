Return-Path: <linux-arch+bounces-9914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE7A1D406
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 11:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4F31887734
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5411FCFF7;
	Mon, 27 Jan 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDdOK1Dt"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84F135A63;
	Mon, 27 Jan 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972207; cv=none; b=R6G90hNpxyqauqBBvvoWrtLFA3Jnl4kNuDwhHSfGQUBmW5pB9rjtUeI2C8uzCeWeo/saF4uHwXntMJElVFsIvFimApft0QA4p+pFpdkWLQvm+rcY4mG5rCeG0UWiN7P1PwoNtWY+k3PTG53cZxEFdDKGCgmhoK+PiPkiANPNGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972207; c=relaxed/simple;
	bh=D2MONTkeAt7Vl1eyY9Fw12W1EYQWmh/nJtWN6fgj2zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgWoaqv73Yt2evU3ZIlVna8wnSaeTvk5Q4uUW0ltk8xwhjmAjdZOHoUnNaj7Iu/xhbfZmuICmHq910Ab0zQrNfrunWXpru6hfDPE8DMRuZxA+lzxtJKRrSl22czr7Am6LBjoC3UZQiaSPEHXW0nTRlcPo4rw7Zmt/M+j4NinLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDdOK1Dt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cqqWTLTGcefHQFj93a6JzifbYNKjM6buoj1GhNpFJgU=; b=SDdOK1Dt/Gj/VFCUcunnKUPAdZ
	JlDDS9o7ZGOw/5ZKkQwL+USGtZ4Q+h8HL7CvHopZsdMiweCfUoFeVzL0emBvXm+iUIWbi/d+j/miJ
	Bd6Rv5Aro4K69bnQv9F7FpshBJheDPnNCd+VLCS3O4G9joct0DErNCgMf5Ng/tm9lAVm2WMCMyTVg
	7fLDnW1LmT2BbhWWNJxfy0gUT+/81Ao6Ji2gDflEDsmoRA0ghS7fhoTBAsg7oqOB931N/6BKH41EL
	k2VJdg9D7XbjUKFPYwVBv1/yvy5KFMRJhWkgHlEf04H28xsKDw19BOgJ5hE/KmGy5Ax7LiGhyeFQE
	b26ZEz8A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcLxg-00000009FFV-3Csm;
	Mon, 27 Jan 2025 10:03:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5889B3004DE; Mon, 27 Jan 2025 11:03:20 +0100 (CET)
Date: Mon, 27 Jan 2025 11:03:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <20250127100320.GC16742@noisy.programming.kicks-ass.net>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
 <Z5LM4b2sC1fHgB3p@google.com>
 <20250124082250.GA13226@noisy.programming.kicks-ass.net>
 <Z5Q9KvugnVQv8QIO@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Q9KvugnVQv8QIO@google.com>

On Sat, Jan 25, 2025 at 01:23:54AM +0000, Roman Gushchin wrote:
> On Fri, Jan 24, 2025 at 09:22:50AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 23, 2025 at 11:12:33PM +0000, Roman Gushchin wrote:
> > 
> > > > +static inline void tlb_free_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > > >  {
> > > >  	if (tlb->fullmm)
> > > >  		return;
> > > >  
> > > >  	/*
> > > >  	 * VM_PFNMAP is more fragile because the core mm will not track the
> > > > +	 * page mapcount -- there might not be page-frames for these PFNs
> > > > +	 * after all.
> > > > +	 *
> > > > +	 * Specifically() there is a race between munmap() and
> > > > +	 * unmap_mapping_range(), where munmap() will unlink the VMA, such
> > > > +	 * that unmap_mapping_range() will no longer observe the VMA and
> > > > +	 * no-op, without observing the TLBI, returning prematurely.
> > > > +	 *
> > > > +	 * So if we're about to unlink such a VMA, and we have pending
> > > > +	 * TLBI for such a vma, flush things now.
> > > >  	 */
> > > > +	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) && tlb->vma_pfn)
> > > >  		tlb_flush_mmu_tlbonly(tlb);
> > > 
> > > Why do we need to re-check vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP) here?
> > 
> > No need, but an opportunity.
> > 
> > > In free_pgtables() we're iterating over multiple vma's. What if the first has
> > > no VM_PFNMAP set, but some other do? Idk if it's even possible, but it's not
> > > obvious that it's not possible either.
> > 
> > If we only need to flush PFN entries before unlinking PFN VMAs, then:
> > 
> >  - if there are no PFNs pending (vma_pfn), we don't need to flush;
> >  - if no PFN vma is being freed (vm_flags), we don't need to flush.
> 
> Right, but if I understand the code correctly, more than one vma can be
> freed by a single free_pgtables() invocation. Should we then check
> each vma's flags in the while loop in free_pgtables()? But then
> we're back to where we're now with multiple flushes.

Right, I misplaced it -- it should be in the vma loop.

> Do I misunderstand this?

I'm not sure how this would cause more flushes; notably it will not
cause flushes where no page-tables are dropped, eg. MADV, which was why
you started all this IIUC.


