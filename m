Return-Path: <linux-arch+bounces-9876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF72A1AF8F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 05:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863D01887A63
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 04:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B61D9337;
	Fri, 24 Jan 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evcKD9j2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777351D9598
	for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693855; cv=none; b=NQADuDaRVVl/D7UrUcoPu8GEpm+auGatcCR+T7eNJU70MpxbhTvt/IC5hX1bKJTWyewlqu4hj7uPXhIfrMERTEESrdoh78t6cGjaYPcGdwVd0xv7GXzxMgQbJPSGyI/yYM7PegiqPMmDnn3Ngb7fUdiA0sWaq1RVQxk7z9LfY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693855; c=relaxed/simple;
	bh=xkh73MzzFZ9RtobtX7zyjAdwySm5dr38XIhElkSpc0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hphujU5BxKGAYe5AL2p0hLRAudGwAqVKKtgapb9jZKf+08SctQQhS4oN45iE9VSSpwu/8SlaxOFqbcE3xtajRM1SHHR2ajirSluuFNw/zfcYNvtAMSW+T3rsyI4dBKdwvmQ07IV2hds4dHy3WsoAjUYlgUUGepg9yFu9f+5oSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evcKD9j2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215770613dbso21289585ad.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 20:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737693852; x=1738298652; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uv7cwOTpV0KzNA+qTFqu9tELK30ddmZjfRf/roGfDiI=;
        b=evcKD9j2FNpdqG8KDB4eKXefJ1c5AGfpbwiIHhSFVJiqesSaKxx01joxyU7meDVBXN
         Iu9Z6Tj+ybOec6r7MmKPxdwilI3JSXc2AGAJTlbtlJFg9pwj4T1grgbrOM7AssGV7T2N
         B3BC8oZKMuQhBu4+gOpBP23rawO4arikGKqAfOfP2j9RTr1vc9zamaQMNnb34xW8bd2d
         fOCEn54SxGap1PUZa1nU7+rUTGdrlVzaHW4np1RStulSWWyQEq5iZLIjDzFlR7jM/HJ0
         WlYO+UX7GRSfpeVG31QY0nfU/r/8tHkVmlQaOuVt4jux3Ds6FZYgfW8lqrBtvS+NNsOe
         DxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737693852; x=1738298652;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv7cwOTpV0KzNA+qTFqu9tELK30ddmZjfRf/roGfDiI=;
        b=bgSLxbs/TR8RQBGapRiuUoKofzMe8B2yj+MeR5UjFVOkGktTVOFHot/zpEFbq6LGfk
         p9eHnbdQPJP09+5dJuk6DgCTSgFWnUQkEVLAy4cqu9l+D0NHs74ZSkTkPyS8YarYSvFw
         fgpD2BmPAINv0VPcuw6qFWPSHQVZre1tU1WMLbFssfhfzDyCJp37xgkZD+A+kZNAvvIh
         ZaJhEfDVLivP/Wk4D3mBvJ5YNg7u/rLCxBcunZjLUESNOFs9rS8f3wzi6UZmquYBUADJ
         pYqHVBHZwuOKkQ0qFdSR2Hzs4fyKY2kWnWo+h9qbyUcigQv9WVbMcHyaS77z6MfNBjhq
         I5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVziUj4ORZdpRtdO/jg9iM9tDCQNJ4WBaNWzlR+WN+nenEjUEeGZSA0GzAE0iULk3k1U19eCxQTcVUS@vger.kernel.org
X-Gm-Message-State: AOJu0YywRJ9uHzVFBPFlQUU8ldukZNae2KPQ2E9J9A6buk7bW7WVCz6m
	G8TenjAXJTTNMIMrmHuFpi716CCSYbzzcLC6LQv1/R5dAjXkDqVoY+vTcnjQ9g==
X-Gm-Gg: ASbGncvEzcvCtUr3s6voO1jpXLJ/vCgp07j2Yux/9umUikVW5KS9pe+byw9Qf74T4bT
	lDK7ZHHKpDlNbKJjwOZ0SVIBGipBz3Itft21kqtbSiTKYV+ee6wGoAA31X9m63h53+pa68Yw/cu
	WXN1UOW0eZSnHt5WcgSkogOcmjry1sEHUTS6TwRcLQh/KMhQgzQbHDQgq981XYny2+xVF+NtiGh
	BVChS9BBaWgJ4/RDO+aGORlTWCJHTCRjv/zWYViWrLQN9hBDf3HR5LpIwE0uUVobCvip7GtInMu
	xjwtjL0y769xRsunrtrCbkYf1SF4Nf/TvZOXZ05aap58P0kAquXo2QPn5XdejWfApN36KtIaX3Q
	=
X-Google-Smtp-Source: AGHT+IGmuM5xbJ0dRlzaglpzHrCdlVIIELIc/CxP5w9jZ9cZ7t6VCUI3U4eu9nUuB+cgcOXhCnqk6g==
X-Received: by 2002:a05:6a20:734e:b0:1e8:bd15:6819 with SMTP id adf61e73a8af0-1eb214ea482mr45448432637.22.1737693852382;
        Thu, 23 Jan 2025 20:44:12 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78e41dsm855895b3a.173.2025.01.23.20.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 20:44:11 -0800 (PST)
Date: Thu, 23 Jan 2025 20:42:36 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Jann Horn <jannh@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <Z5LM4b2sC1fHgB3p@google.com>
Message-ID: <26cd41c2-b8b6-0c1d-c36d-28f2f9f369be@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev> <20250123214531.GA969@noisy.programming.kicks-ass.net> <Z5LM4b2sC1fHgB3p@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Jan 2025, Roman Gushchin wrote:
> On Thu, Jan 23, 2025 at 10:45:31PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 22, 2025 at 11:27:16PM +0000, Roman Gushchin wrote:
> > > Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> > > added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> > > race between munmap() and unmap_mapping_range(). However it added some
> > > overhead to other paths where tlb_vma_end() is used, but vmas are not
> > > removed, e.g. madvise(MADV_DONTNEED).
> > > 
> > > Fix this by moving the tlb flush out of tlb_end_vma() into
> > > free_pgtables(), somewhat similar to the stable version of the
> > > original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> > > for PFNMAP mappings before unlink_file_vma()").
> > 
> > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 398c031be9ba..c2a9effb2e32 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> > >  {
> > >  	struct unlink_vma_file_batch vb;
> > >  
> > > +	/*
> > > +	 * VM_PFNMAP and VM_MIXEDMAP maps require a special handling here:
> > > +	 * force flush TLBs for such ranges to avoid munmap() vs
> > > +	 * unmap_mapping_range() races.
> > > +	 */
> > > +	tlb_flush_mmu_pfnmap(tlb);
> > > +
> > >  	do {
> > >  		unsigned long addr = vma->vm_start;
> > >  		struct vm_area_struct *next;
> > 
> > So I'm not sure I muc like this name, it is fairly random and does very
> > much not convey the reason we're calling this.
> > 
> > Anyway, going back to reading the original commit (because this
> > changelog isn't helping me much), the problem appears to be that
> > unlinking the vma will make unmap_mapping_range() skip things (no vma,
> > nothing to do, etc) return early and bad things happen.

The changelog of commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush
VM_PFNMAP vmas") has not helped me either.  Nor could I locate any
discussion (Jann, Linus, Peter, Will?) that led up to it.

I can see that a racing unmap_mapping_range() may complete before
the munmap() has done its TLB flush, but (a) so what? and (b) how
does VM_PFNMAP or page_mapcount affect that? and (c) did Linus's
later delay_rmap changes make any difference to the story here.

Jann, please spell it out for us: I think I'm not the only one who
fails to understand the race in question.  At present I'm hovering
between thinking there was no bug to be fixed in the first place, or
that a tlb_flush_mmu_tlbonly() has to be done before unlinking vmas
in all cases (or in all file cases?).

I'm probably wrong in both directions, but cannot see it without help.

> > 
> > So am I right in thinking we need this tlb flush before all those
> > unlink_{anon,file}_vma*() calls, and that the whole free_pgd_range()
> > that goes and invalidates the page-tables is too late?
> > 
> > So how about we do something like so instead?
> 
> Overall looks good to me, except one question (below).

To me, Peter's patch looks much like yours, except wth different
names and comments, plus the "vma" error you point out below.

> > +static inline void tlb_free_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> >  {
> >  	if (tlb->fullmm)
> >  		return;
> >  
> >  	/*
> >  	 * VM_PFNMAP is more fragile because the core mm will not track the
> > -	 * page mapcount -- there might not be page-frames for these PFNs after
> > -	 * all. Force flush TLBs for such ranges to avoid munmap() vs
> > -	 * unmap_mapping_range() races.
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
> > -	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> > -		/*
> > -		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> > -		 * the ranges growing with the unused space between consecutive VMAs.
> > -		 */
> > +	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) && tlb->vma_pfn)
> >  		tlb_flush_mmu_tlbonly(tlb);
> > -	}
> 
> Why do we need to re-check vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP) here?
> 
> In free_pgtables() we're iterating over multiple vma's. What if the first has
> no VM_PFNMAP set, but some other do? Idk if it's even possible, but it's not
> obvious that it's not possible either.

Yes, of course that is possible: the "vma" to tlb_free_vma() is a mistake
(hmm, and there's no "free" in it either).

Hugh

