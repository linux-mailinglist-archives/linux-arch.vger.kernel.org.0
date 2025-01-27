Return-Path: <linux-arch+bounces-9913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28341A1D3E3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5D47A2CF3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8A1FBEBC;
	Mon, 27 Jan 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dhY+XGFE"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFE25A63B;
	Mon, 27 Jan 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971620; cv=none; b=bEoLsQ/FPykBYTy8jOcnzU4G//oPO63arG1kzraVPZCIdzAYxRxUmCwI1AwKzMxB7NiG4LfZ2MGsgiyWSWYaLFXd919QyncqanfDk9vfuz0Kr8yn9k4uwzKZzuJNdB8VAycptytsISZRwcxYmg9oWMHOih36GhVWGJ6GrcRrptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971620; c=relaxed/simple;
	bh=MP1tghh+sFjWsQmfTpDYmczVqGWed510wFZkOZ+SZmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efytYfmLVtHMW6kbvWhuphymInD4WJZhbGE7ktKZrEdTfIa0giEtuc0Ilzhd0w0dyS3m1nlJjK+G7a0fjObeXVgK/0ljB2UC/b+KTEg3G+DHEnNVGfwJxlwYrmkBN1/FqMuVOutMrdzO3fuTcjm8+7KopTegzRMQdo0y7elsE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dhY+XGFE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kJGDu6W10NCF/1kHbq9MWN63eWI9W/iOmx8WRJAXCOg=; b=dhY+XGFEy3eopIVBJHf10Av56B
	6Xkmnx1VQvr6mQp7+jp3RcTV/RFe97oKO5DY+XOrgyGdWgFlJ6bwGastDUA4lSbZljoQWzF9GzDdd
	xm8pCO5G0bGL+L8FJRJhlkJBkMKlQWddJI21h8Eh0rIj28c0MmyG84AnELKnar+HC+GxjBj/m1z9o
	qX9x0Gy+cLh7WCU9U40xBMSFZCZCjOSR/TB56jz+6PnWOSF56uKUndBupWk3JvG8Oq0Z7Zwg13uBn
	Y0tkphhi4yjewRGnBmBLHdrhb1KQE7IbCwPOyCY9uiSti3xN32asvrV9OJw+hKG5vUqliT7Az9f51
	MI2ptaTw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcLoC-00000009EhB-2INM;
	Mon, 27 Jan 2025 09:53:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 945463004DE; Mon, 27 Jan 2025 10:53:31 +0100 (CET)
Date: Mon, 27 Jan 2025 10:53:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <20250127095331.GB16742@noisy.programming.kicks-ass.net>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
 <Z5LM4b2sC1fHgB3p@google.com>
 <26cd41c2-b8b6-0c1d-c36d-28f2f9f369be@google.com>
 <20250124083139.GB13226@noisy.programming.kicks-ass.net>
 <d01c2d60-3901-1f66-770f-e9d12bfd89b5@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01c2d60-3901-1f66-770f-e9d12bfd89b5@google.com>

On Sun, Jan 26, 2025 at 06:34:48PM -0800, Hugh Dickins wrote:

> > If we've flushed the relevant PFNs earlier, for whatever reason,
> > batching, or the arch has !MERGE_VMAS or whatever, then we do not need
> > to flush again. So clearing vma_pfn in __tlb_reset_range() is the right
> > place.
> 
> Yes, Roman moved to clearing vma_pfn in __tlb_reset_range() in his v3:
> we are all in agreement on that.

Ah, I had not seen v3 yet.

> > Similarly, if we don't ever actually free/unlink the PFN vma, we also
> > don't care.
> 
> I cannot think of a case in which we arrive at free_pgtables(), but do not
> unlink the vma(s) which caused vma_pfn to be set.  If there is such a case,
> it's not worth optimizing for;

Yeah, I suppose it doesn't happen. But I figured why assume stuff.

> and wrong to check just the first vma in the
> list (don't look only at the stable commit 895428ee124a which Roman cited -
> it had to be fixed by 891f03f688de afterwards).

Duh, yeah, so tlb_free_vma() wants to be inside the vma loop of
free_pgtables().

> Personally, I prefer code inline in free_pgtables() which shows what's
> going on, as Roman did in v1, rather than struggling to devise a
> self-explanatory function name for something over there in tlb.h.
> 
> But I may be in a minority on that, and his tlb_flush_mmu_pfnmap()
> is much more to the point than tlb_free_vma().

I prefer a function over the in-line thing such that mmu-gather is more
or less self contained.

So my concern is/was maintainability of all this; tlb_flush_mmu_pfnmap()
tells me nothing about when this function should be called. Otoh
tlb_free_vma() tell me this should be called when we're freeing VMAs --
much harder to misplace etc. If we have hooks placed at, and named
after, natural events in the lifetime of things, placement is 'obvious'.

Another possible name might be tlb_free_pgtables(), indicating we're
about to start freeing pagetables -- but it would need to assert
!tlb->freed_tables, and I'm not sure this is a constraint worth
imposing. It would bring pain if someone wanted to mix freeing pages and
page-tables.

And we already have vma based hooks, so I much prefer adding one more of
those. This is about funky VMAs after all.

