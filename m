Return-Path: <linux-arch+bounces-9877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D769AA1B193
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 09:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC1886FED
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DAF218ACA;
	Fri, 24 Jan 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubxncmQq"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864EF14A0A3;
	Fri, 24 Jan 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706978; cv=none; b=BnTMRYEwcMJ2sO8vV7lINWJdDq7Weq5dQ0XQpDtCpsZ5O9cLv8RMw6nvFSCRl9mbwknnaSxJQWrGKc9POc8wZrxr93zzOxSQu/kv2ZPIOeboudW6otWgQ2yDmvqtuPKbwSwlI8kLHwqGTuTrSphbIfdVSrr9lMWoiixmJLl76nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706978; c=relaxed/simple;
	bh=Tm30ruTyODoHBJJHwUPCVood6Ip1dK6lX9GjNPBmusI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEFgZwISnxRhW1ox5/6bGXJ8sMaz9uFLR1Sd13YDH0Ml+hqsUuTjQjE3vyQr8DqE3isAsjZGE1HdpENDDhjoaqSIVPKq6007Y2wpBX+v3aiconRxU92jVLggyDirG/hjTHAN42UJyBdXs72viMSP45AVVQ7fzk7GZ+5pBqrotrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ubxncmQq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=binYfpzYbTrV0P3XYTLlLA8s1eJr7PdgVILx4bbckQQ=; b=ubxncmQqIdSg3CjTbED6mL6Okn
	hgWnal1SYpkPYvNFJTwXzdQvD/LvqLR+jEH1VdrMQfOts+dXROUI8Z2KBaqN0nI5+agHuBI+oTIAl
	SBw/kbPhzV2Yb45wIFktxtIQP01s87m2tDbjTI3rIwmIc2lEciiTtVQHboxinOYQm3jIyhDJ2niIR
	f7ZEGJGSvsU5rlu1E1oLNYdhAGyRTebYuNVRyQ/COINoEfeVw+kjtCbbq6UplNprUQsxn1hdDWclp
	FZSokTx69MEp1GGb/To3ohpty5ovbX2ixE0PH25WEuXmhoCpbhadzZB5iYfn6+0XicPSwB2rqaD/1
	ptpRk/0g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbExn-0000000ERhO-3kmZ;
	Fri, 24 Jan 2025 08:22:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D590300619; Fri, 24 Jan 2025 09:22:51 +0100 (CET)
Date: Fri, 24 Jan 2025 09:22:50 +0100
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
Message-ID: <20250124082250.GA13226@noisy.programming.kicks-ass.net>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
 <Z5LM4b2sC1fHgB3p@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5LM4b2sC1fHgB3p@google.com>

On Thu, Jan 23, 2025 at 11:12:33PM +0000, Roman Gushchin wrote:

> > +static inline void tlb_free_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> >  {
> >  	if (tlb->fullmm)
> >  		return;
> >  
> >  	/*
> >  	 * VM_PFNMAP is more fragile because the core mm will not track the
> > +	 * page mapcount -- there might not be page-frames for these PFNs
> > +	 * after all.
> > +	 *
> > +	 * Specifically() there is a race between munmap() and
> > +	 * unmap_mapping_range(), where munmap() will unlink the VMA, such
> > +	 * that unmap_mapping_range() will no longer observe the VMA and
> > +	 * no-op, without observing the TLBI, returning prematurely.
> > +	 *
> > +	 * So if we're about to unlink such a VMA, and we have pending
> > +	 * TLBI for such a vma, flush things now.
> >  	 */
> > +	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) && tlb->vma_pfn)
> >  		tlb_flush_mmu_tlbonly(tlb);
> 
> Why do we need to re-check vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP) here?

No need, but an opportunity.

> In free_pgtables() we're iterating over multiple vma's. What if the first has
> no VM_PFNMAP set, but some other do? Idk if it's even possible, but it's not
> obvious that it's not possible either.

If we only need to flush PFN entries before unlinking PFN VMAs, then:

 - if there are no PFNs pending (vma_pfn), we don't need to flush;
 - if no PFN vma is being freed (vm_flags), we don't need to flush.

Notably, if an earlier flush has already issued the TLBI, there is no
need to issue one again, but also, if we end up not actually freeing the
PFN vma, we also don't care.


