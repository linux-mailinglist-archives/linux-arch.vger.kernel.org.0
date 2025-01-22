Return-Path: <linux-arch+bounces-9851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F36A18FD4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 11:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC33A619D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57167210F76;
	Wed, 22 Jan 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ak5IHfNw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB81F8ADE
	for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542100; cv=none; b=ss7M4pXSIACNE3uOhpFN9k8WtecN6Fjs9GJ2Hu36odn+yx9M/ZeoZQPe3A1lDmXlbvvWxevKYCMqqAkhvYZkEIBjivsh/EF8/oTNlRj9jLIlGaE9UyoFUsoHhKlEIS65hZDlwIOSPNyzDsvYHWPaN8TXXHjzyVD22SSwBfl7VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542100; c=relaxed/simple;
	bh=ccJd2MyaJcrtIWCpembBa49egq7fiecO/LfSNbaFH/g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nqRujTtzKvgB5U6MrFbx570sy0zXTeWRENdltzvghTzVoDJqnY6b2MhLC/AwWf10uOb5TRFULwFShyReqUhjqbjGZaWb09x0X+BrnfNH9zqVQdhrvTOQc6e+qiEAR6t3pUIwrmMK7qW7FeSJ9xq0wvliATLgabEaT3pB3vTRQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ak5IHfNw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso112920755ad.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737542098; x=1738146898; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8U/payZ20c9Ax3t2jNC8bRsYJo5GmzmF42je0IW1q6s=;
        b=Ak5IHfNwtgfzutUxLesTdfAY0lOXs/3lRRGZpeSlI7gwqP5/JhPaJbErOrxJfDEbrY
         D63oKO13eHh2EqG/7d5xAgcBIOtY9gjRGHuvO8/xejIdi5B2sHTJfoKnPqy4xwEv5jvo
         IYQ2NICajTgz5+gn3xiOicGm2t8+YXlJhcxs3nwcGgpc0Nw6rQpJptWmHEru8UjMYDvc
         J88lYTYWjpr2zt1EOYmHcafya4V5zrzjqBa502desY3O5vbE4myukbc7Ns+oQoScSf/i
         ACi9cX6kpOEP7cNUYWDuM3aaeBcOXfWj/SVEDkVmnnQ3NaqM0k8ySbqFMmTQM7OBnorW
         1p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737542098; x=1738146898;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U/payZ20c9Ax3t2jNC8bRsYJo5GmzmF42je0IW1q6s=;
        b=BfZUkTkANJVEY3w+wgDNy4lkHR1zioREB3WHVzLebubrvjozf+4JpE1nHVFMPDyesx
         cZ0zCTyZ6xIkcOUqV6sjQxrdFotLgKiuZpacqiQF2aV/ZwHHHsRdmRlseBd2A52Sy+23
         IaTn0YXkxPqDhzWlaoKdBl/wV/ZyLmeNYx3FgStDh+DUpolh1YnrBqbs6wo238GLJgfD
         ToAI92ZGnnyqSe+CsIq2KCHeJEuVdVwkHbv1bHNAo4zvlSyHxcnrX78G8WjiMRR63ee7
         6K7BglmfzJ/2iFNMYlusmHgh717FEe81sUAdoymkgnC3o+H/cP3EHMpd1ExwARR6O33+
         FIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ImjueABzZMpvA7GC56fUCKC0Er9QnjS/reiO4RBzbaHusIhxQPbDXOZlcIhcprHSCZOy0axwVrsa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bAthL8r/IxW9uJHCZgheYBP5wsJXnTC2eNxwaKw0fNWB0gZR
	jNKEFGC8GgPhYOI6KGwVPN1x5NJHViIX8kVguRb3gVytWjOtzWOhUslye0iR7Q==
X-Gm-Gg: ASbGnctbWHZVHuNGfxxBjQytAu/nZl20WVfzvKlPzeQw8HbSm7lhrCgPg7H5hLXFojy
	pmKZFYJI/0jWfPmzdim8ZOj6khcbvWkIRr1FaBVVXDORx7E3rPY7RE8l5Eczet0RX9Jh/6DIMdR
	uyBaYE++GEq9hQattb4Ui9dAHmQjyR9JLzfeb/hePRjDoUKOzKhkh18t/Z+Y4Fh/GJn56zA+8W3
	VRFid3AUi5isZHsPWW3iwM06qy7KE+2e1ei4La8ZSVLiSwNxcL8ToNx8pfDWXp6qR5k6Nr1+1uU
	xO0+WSiNKjhLjzXx/6opIr0xQ+1F+Nbdp5xzS2DZupVj/+yL2S+V1w==
X-Google-Smtp-Source: AGHT+IEA7uPz8eU9TDBP3U4S5r/5kxWYft7JncmGKt91LbEvuF4KcW1eWWFG5Z0CDvmZRNuxUgbBtg==
X-Received: by 2002:a05:6a00:428d:b0:725:ae5f:7f06 with SMTP id d2e1a72fcca58-72dafadbc37mr29647191b3a.23.1737542097673;
        Wed, 22 Jan 2025 02:34:57 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa751asm10651865b3a.162.2025.01.22.02.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 02:34:56 -0800 (PST)
Date: Wed, 22 Jan 2025 02:34:45 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <20250121200929.188542-1-roman.gushchin@linux.dev>
Message-ID: <f698fccc-f94a-e7d9-29de-56a90b57c4a4@google.com>
References: <20250121200929.188542-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Jan 2025, Roman Gushchin wrote:

> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(),

Yes, I think that was a poor way of fixing the bug in question.

> which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).

Right.

> 
> Fix this by moving the tlb flush out of tlb_end_vma() into
> free_pgtables(), somewhat similar to the stable version of the
> original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> for PFNMAP mappings before unlink_file_vma()").

Something like this patch will be a good improvement:
but not this version of the patch.

Because the mmu_gather may be gathering across many vmas,
but tlb_start_vma(), well, its "tlb_update_vma_flags()", says
	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
so a following vma may reset vma_pfn too soon: more care is needed.

But probably vma_pfn should be reset to 0 somewhere, to avoid an
extra TLB flush in free_pgtables() when it has already been done.

Perhaps vma_pfn should follow the same pattern of initialization,
setting and clearing as cleared_ptes etc, instead of following
vma_huge and vma_exec.  Perhaps, but it is something different,
and I've not yet checked enough to be sure: tlb.h is still a maze
too twisty for me.

Hugh (after power outage interrupted reply)

> 
> Note, that if tlb->fullmm is set, no flush is required, as the whole
> mm is about to be destroyed.
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
>  include/asm-generic/tlb.h | 16 ++++------------
>  mm/memory.c               |  7 +++++++
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 709830274b75..411daa96f57a 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -549,22 +549,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
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
> +	 */
> +	if (tlb->vma_pfn && !tlb->fullmm)
> +		tlb_flush_mmu(tlb);
> +
>  	do {
>  		unsigned long addr = vma->vm_start;
>  		struct vm_area_struct *next;
> -- 
> 2.48.0.rc2.279.g1de40edade-goog

