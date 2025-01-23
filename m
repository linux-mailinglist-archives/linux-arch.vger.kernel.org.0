Return-Path: <linux-arch+bounces-9870-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B66A1A80D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 17:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EED7166063
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF57E105;
	Thu, 23 Jan 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kJ8nr8AX"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2B70817
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650752; cv=none; b=M+51f0l31+CKQ1PTj8UsdyfCPJUCbuIf9yqFOIhrpKkx6yqshD83QkAaoqK+RfSE1Jc4YWplXnsX2Vrmyy8lPW4nr+IvHVoIDg2vK03+x9wH3E5Oy3AonBCAtsZX80gcftmdIQkUW93WE14++UjFqpt7IIecZdBuIlEXeLc0QzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650752; c=relaxed/simple;
	bh=8EmARwfhNk3XAVxqYCfxHgz9VK0eG8/wwrgQRisyIpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ligHrPivXeilY5Cz2+aS8lCMCKA0eTkSKHuQPKLKbMOVVlNJchmUOC/AI3gzOHkVArC6kTc3FXTGtgrb10c89ggnsL1kt3acr/Sqqm1XLcSqvQBJsv3IxNQVEozk3AN4+AU3+HkMs39MOtazhmTg9M4pikPPArkO8/IqULCvUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kJ8nr8AX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Jan 2025 16:45:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737650748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJ9ZmMqOR4SDwDKQYZ4A34XUruIirQBnXbcnNkA+BHQ=;
	b=kJ8nr8AXkvkQKmH/qZSX2NTzacDgublgbX56q14JVCxISLaRgcjD1rGphWFyTcdGYrGI0X
	b6IRJ9OxDGdbm2nAX4y2CpjgrizqJsUt8HRvf05MioMF4x85aJNFNsnhsIavSUY3qP+LBp
	qHuyk0HiiKLFZZFFfLxfjAljgtnfNrc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <Z5JyNvX3En7iIRLs@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <c549a9af-cd5f-fd77-1af6-a10b30dd3256@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c549a9af-cd5f-fd77-1af6-a10b30dd3256@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 22, 2025 at 11:42:13PM -0800, Hugh Dickins wrote:
> On Wed, 22 Jan 2025, Roman Gushchin wrote:
> 
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
> > 
> > Note, that if tlb->fullmm is set, no flush is required, as the whole
> > mm is about to be destroyed.
> > 
> > v2:
> >   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
> >   - added comments (by Peter Z.)
> >   - fixed the vma_pfn flag setting (by Hugh D.)
> > 
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nick Piggin <npiggin@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > ---
> >  include/asm-generic/tlb.h | 41 ++++++++++++++++++++++++++-------------
> >  mm/memory.c               |  7 +++++++
> >  2 files changed, 35 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index 709830274b75..fbe31f49a5af 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -449,7 +449,14 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
> >  	 */
> >  	tlb->vma_huge = is_vm_hugetlb_page(vma);
> >  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> > -	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
> > +
> > +	/*
> > +	 * vma_pfn is checked and cleared by tlb_flush_mmu_pfnmap()
> > +	 * for a set of vma's, so it should be set if at least one vma
> > +	 * has VM_PFNMAP or VM_MIXEDMAP flags set.
> > +	 */
> > +	if (vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))
> > +		tlb->vma_pfn = 1;
> 
> Okay, but struct mmu_gather is usually on the caller's stack,
> containing junk initially, and there's nothing in this patch
> yet to initialize tlb->vma_pfn to 0.
> 
> __tlb_reset_range() needs to do that, doesn't it?  With some adjustment
> to its comment about not resetting mmu_gather::vma_* fields.  Or would
> it be better to get around that by renaming vma_pfn to, er, something
> else - I'd have to understand the essence of Jann's race better to
> come up with the right name - untracked_mappings? would that be right?
> I still haven't grasped the essence of that race.

Yeah, this is a really good point.

> 
> (Panic attack: where is, for example, tlb->need_flush_all initialized
> to 0?  Ah, over in mm/mmu_gather.c, __tlb_gather_mmu().  Phew.)
> 
> And if __tlb_reset_range() resets tlb->vma_pfn to 0, then that has the
> side-effect that any TLB flush cancels the vma_pfn state: which is a
> desirable side-effect, isn't it? avoiding the possibility of doing an
> unnecessary extra TLB flush in free_pgtables(), as I criticized before.

Good point.

Just sent out v3 with your suggestions.

Thank you for your help here!

Roman

