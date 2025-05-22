Return-Path: <linux-arch+bounces-12067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382DAC015C
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84371BC099E
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5DE80B;
	Thu, 22 May 2025 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsDeIZWy"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B31BC58
	for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747873458; cv=none; b=syiAcVK/YyaBg0HmbwQuvdzebfE9e8KgqsuoOHaYgmn0LzsEVKQbr1XRstaf65EXmeZ4IzWUnpUbjBmEyLF7Adl+WTVcTVMTH8yKILVAJ76CbxtCmrOEnPgz8eXEgGQ6ujDzF40mVVUtgX+exraoWRjKX3mnAo9RtVUKk+cHnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747873458; c=relaxed/simple;
	bh=T106uyTJtpqmU/8F1Pt7pFSZf7m5+fq2dbi8ntf+5KA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lwxxi0w40XCoeCK4WYvdeoVel85drrKO2u0lBN4qBeMM1JzmePgCivj+4Vf1MpCrcPszw00GSC+0TnSkU+AtnZ3YkrXotoClvVwreGiKZTKjks22jdW2vEr7wwRhdy7MSHKD9poefWhKQAZXmehDnENRKGRCnl8SwZjH45KyWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsDeIZWy; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747873444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrH9jBCKBEOrByQtkD+ofBzbo0nje3TFiKainJjRQrc=;
	b=nsDeIZWy0XQL+FstjkzXh/izAGEdF4IebwLXaH5pOGKGp2q24y3Q0lptRQ/59ZhA2jC6iF
	vUQqf64nQljBBhW0zsOXjhIF5haPqkB14hEUVM69YztfqBmNIrqvHq6r4geqcZ4lVQZtU2
	OMyWkZaqLeeL/68drUJeGbGFQavzRnU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jann Horn <jannh@google.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Peter Zijlstra <peterz@infradead.org>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Will Deacon
 <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,  Nick
 Piggin <npiggin@gmail.com>,  linux-arch@vger.kernel.org
Subject: Re: [PATCH v5] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <CAG48ez39SaJe=cwq3JZ6UM0BLMHEj76Kdmd9=Ho1nr17fAco6Q@mail.gmail.com>
	(Jann Horn's message of "Wed, 21 May 2025 02:38:20 +0200")
References: <20250520214813.3946964-1-roman.gushchin@linux.dev>
	<CAG48ez39SaJe=cwq3JZ6UM0BLMHEj76Kdmd9=Ho1nr17fAco6Q@mail.gmail.com>
Date: Wed, 21 May 2025 17:23:57 -0700
Message-ID: <878qmpwl0i.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Jann Horn <jannh@google.com> writes:

> On Tue, May 20, 2025 at 11:50=E2=80=AFPM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
>> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
>> race between munmap() and unmap_mapping_range(). However it added some
>> overhead to other paths where tlb_vma_end() is used, but vmas are not
>> removed, e.g. madvise(MADV_DONTNEED).
>>
>> Fix this by moving the tlb flush out of tlb_end_vma() into new
>> tlb_flush_vmas() called from free_pgtables(), somewhat similar to the
>> stable version of the original commit:
>> commit 895428ee124a ("mm: Force TLB flush for PFNMAP mappings before
>> unlink_file_vma()").
>>
>> Note, that if tlb->fullmm is set, no flush is required, as the whole
>> mm is about to be destroyed.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-mm@kvack.org
>>
>> ---
>> v5:
>>   - tlb_free_vma() -> tlb_free_vmas() to avoid extra checks
>>
>> v4:
>>   - naming/comments update (by Peter Z.)
>>   - check vma->vma->vm_flags in tlb_free_vma() (by Peter Z.)
>>
>> v3:
>>   - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)
>>
>> v2:
>>   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
>>   - added comments (by Peter Z.)
>>   - fixed the vma_pfn flag setting (by Hugh D.)
>> ---
>>  include/asm-generic/tlb.h | 49 +++++++++++++++++++++++++++++++--------
>>  mm/memory.c               |  2 ++
>>  2 files changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 88a42973fa47..8a8b9535a930 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -58,6 +58,11 @@
>>   *    Defaults to flushing at tlb_end_vma() to reset the range; helps w=
hen
>>   *    there's large holes between the VMAs.
>>   *
>> + *  - tlb_free_vmas()
>> + *
>> + *    tlb_free_vmas() marks the start of unlinking of one or more vmas
>> + *    and freeing page-tables.
>> + *
>>   *  - tlb_remove_table()
>>   *
>>   *    tlb_remove_table() is the basic primitive to free page-table dire=
ctories
>> @@ -399,7 +404,10 @@ static inline void __tlb_reset_range(struct mmu_gat=
her *tlb)
>>          * Do not reset mmu_gather::vma_* fields here, we do not
>>          * call into tlb_start_vma() again to set them if there is an
>>          * intermediate flush.
>> +        *
>> +        * Except for vma_pfn, that only cares if there's pending TLBI.
>>          */
>> +       tlb->vma_pfn =3D 0;
>
> This looks dodgy to me. Can you explain here in more detail why this
> is okay? Looking at current mainline, tlb->vma_pfn is only set to 1
> when tlb_start_vma() calls into tlb_update_vma_flags(); it is never
> set again after tlb_start_vma(), so I don't think it's legal to just
> clear it in the middle of a VMA.
>
> If we had something like this callgraph on a VM_MIXEDMAP mapping, with
> an intermediate TLB flush in the middle of the VM_MIXEDMAP mapping:
>
> tlb_start_vma()
>   [sets tlb->vma_pfn]
> zap_pte_range
>   tlb_flush_mmu_tlbonly
>     __tlb_reset_range
>       [clears tlb->vma_pfn]
> zap_pte_range
>   [zaps more PTEs and queues a pending TLB flush]
> tlb_end_vma()
> free_pgtables
>   tlb_free_vmas
>     [checks for tlb->vma_pfn]
>
> then tlb_free_vmas() will erroneously not do a flush when it should've
> done one, right?

Good catch!

>
> Why does it even matter to you whether tlb->vma_pfn ever gets reset? I
> think more or less at worst you do one extra TLB flush in some case
> involving a munmap() across multiple VMAs including a mix of
> VM_PFNMAP/VM_MIXEDMAP and non-VM_PFNMAP/VM_MIXEDMAP VMAs (which is
> already a fairly weird scenario on its own), with the region being
> operated on large enough or complicated enough that you already did at
> least one TLB flush, and the unmap sufficiently large or with
> sufficient address space around it that page tables are getting freed,
> or something like that? That seems like a scenario in which one more
> flush isn't going to be a big deal.

Agree.

>
> If you wanted to do this properly, I think you could do something like:
>
>  - add another flag tlb->current_vma_pfn that tracks whether the
> current vma is pfnmap/mixedmap
>  - reset tlb->vma_pfn on TLB flush
>  - set tlb->vma_pfn again if a TLB flush is enqueued while
> tlb->current_vma_pfn is true
>
> But that seems way too complicated, so I would just delete these three
> lines from the patch.

Agree, except tlb->vma_pfn needs to be initialized somewhere. This
is primarily why these lines were added based on the feedback to the
original version. However we missed the race you pointed at.

I guess instead tlb->vma_pfn can be initialized in __tlb_gather_mmu().

I'll send out the fixed version shortly.

Thank you!

