Return-Path: <linux-arch+bounces-9850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168DA18F3D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6536316C4F1
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC01F8909;
	Wed, 22 Jan 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gb4+2Lp/"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734516BE3A;
	Wed, 22 Jan 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540412; cv=none; b=gbytqjcsvt6/KWg5J/QvWz4X9sPVT9A/yjuXjF7aM+iKEj+bpr9nwoCvn9Jh9pr2QArj5NjrQsTbHpSfrzyYyuWW1/Z1RzoUO8X+NPCLm/bCaT8nxZovtPP6XD3kBhCg6Lja+kPxFC+9UXvkpmOJLkBgd2yX7Ots3zqPq4H6fR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540412; c=relaxed/simple;
	bh=NlYmcOrpCyHN/XyatmOclJl8OASsTjAfA8WVg6Zcw7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBECrkqsL/6xmuTw0WBRoXVUcOg47mg7gMtOfaaf6tW+0IP5qObAU+seuBGW8wW4UeblF3iXn9HcYIAoGTqgMhMcBY2IYhTJTp3d88XJcQN6PmOhmy+DqIzUlN3kQe5SGXpL0gy4Atr3CncLUj2Sy97gpFTgXKCBtq/HhvqAaq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gb4+2Lp/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+4aqblxBo0mSTU8WQnlzPUPzt49g8vCbbD65eJ7VJE0=; b=Gb4+2Lp/lGo8WDR8KXtfHjbDfl
	4F15tHMq8LG+F0bd6ZE2kGbRbnqRwftqkkoURex3D0IPLM96mSJEia1fNnb+y7Vrn2fG/FJVgZ8r4
	TYPrmrFwRfRHjQVUHSan93o+fBZAmJEWU0/Z03lMSMns5cPCvF9m8RF+ost/+g/o2tW4YPbVbcKSw
	witQeG9dzQsZqLAqo5BGep+BxqL7MrW8CKAQ8BBTE3A+OgpqyPtoPP65Zo197G9s75EkJu6jR05Tc
	R/3F16MGLdac4KiaJBDu5j8Gv77kEe1wsEmEBS1cZu+++MpOK3JazRUo7c3l6jfJQZ5ztbT3z2MdT
	mJLd/wPw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taXdB-0000000DXET-1aaq;
	Wed, 22 Jan 2025 10:06:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28303300599; Wed, 22 Jan 2025 11:06:40 +0100 (CET)
Date: Wed, 22 Jan 2025 11:06:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <20250122100639.GF7145@noisy.programming.kicks-ass.net>
References: <20250121200929.188542-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121200929.188542-1-roman.gushchin@linux.dev>

On Tue, Jan 21, 2025 at 08:09:29PM +0000, Roman Gushchin wrote:
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
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

> diff --git a/mm/memory.c b/mm/memory.c
> index 398c031be9ba..2071415f68dd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  {
>  	struct unlink_vma_file_batch vb;
>  
> +	/*
> +	 * Ensure we have no stale TLB entries by the time this mapping is
> +	 * removed from the rmap.

This comment would be ever so much better if it would explain *why* this
is important.

> +	 */
> +	if (tlb->vma_pfn && !tlb->fullmm)
> +		tlb_flush_mmu(tlb);

I can't say I particularly like accessing vma_pfn outside of the
mmu_gather code, but I'm also not sure its worth it to add a special
helper.

I do worry this makes the whole thing a little more fragile though.

