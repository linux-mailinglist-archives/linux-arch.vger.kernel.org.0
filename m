Return-Path: <linux-arch+bounces-15553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 124BACDD9E2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Dec 2025 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA68301F8EE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Dec 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC63164C2;
	Thu, 25 Dec 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy3CW1cl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6E248F64;
	Thu, 25 Dec 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766656061; cv=none; b=orFE3p+Z24uQxIc1WY2ZVrHwMdpc7uI3BwAUr+QliNPTTe5WFexFea875DF3VDcsD8fhpRNHVu7KDNKC5HBXcxnDkWtUhaRyDSLIusUK2gDPHtBYDdY7BCvbxQChwIWRjOn3bdLNZnXTGU6qf4bnK9rC0VA2dBaxxj+qcveia18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766656061; c=relaxed/simple;
	bh=4iBf9Ig+t1xZ4dvyb20eBO6tby258MpacRjtRiuO0x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG7SfwWakHA+cLLnkqjstzbekqwoomUT3ejXzFV6CxW0Qt7WGmTyuXErg73QwGfNG5xEBHsPpc9eR6GWGpiJgAaw5LP92KFLc3D1kedBQ4+md74A5bKce6qYd5rL/rPjp5/6mDajjPMIhH0hw7wObLA2kRFp2saWemX6Ya1tDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy3CW1cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31718C4CEFB;
	Thu, 25 Dec 2025 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766656061;
	bh=4iBf9Ig+t1xZ4dvyb20eBO6tby258MpacRjtRiuO0x0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sy3CW1cl1V3JPg70g8bQsB4iA48x8OjbpxmQgLkgWCBxjDa/fzZujnEiktu0asc8W
	 EgJNXpxsQNA3GmAva2xgyf7XtosKOHAm5KVaHeZLxbhBCra2qoZBHXy8+zRehzGgVJ
	 ybiG8m1WcwgntsV43LgQmro+YiovZx4zqyM7TFiDdNScPYSRLKmcqe1QROJ/NTDn0T
	 5UAZS4Z6cv6d4irIbm5f5d2u2UAzRef6Y3nLoFGCTDFsLEXvhzVk87CuErhbuokTe9
	 WxtgpfE1EZT8EnaSKuVUwcBIsm2et6EEIWuvoqYu+zdLJL23l33c9NGF4yKnfkF7b4
	 EHU5dKggAUUhg==
Message-ID: <f223dd74-331c-412d-93fc-69e360a5006c@kernel.org>
Date: Thu, 25 Dec 2025 10:47:32 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 4/4] mm/hugetlb: fix excessive IPI broadcasts
 when unsharing PMD tables using mmu_gather
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
References: <20251223214037.580860-1-david@kernel.org>
 <20251223214037.580860-5-david@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251223214037.580860-5-david@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 22:40, David Hildenbrand (Red Hat) wrote:
> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
> tables that it severely regresses some workloads.
> 
> In particular, when we fork()+exit(), or when we munmap() a large
> area backed by many shared PMD tables, we perform one IPI broadcast per
> unshared PMD table.
> 
> There are two optimizations to be had:
> 
> (1) When we process (unshare) multiple such PMD tables, such as during
>      exit(), it is sufficient to send a single IPI broadcast (as long as
>      we respect locking rules) instead of one per PMD table.
> 
>      Locking prevents that any of these PMD tables could get reused before
>      we drop the lock.
> 
> (2) When we are not the last sharer (> 2 users including us), there is
>      no need to send the IPI broadcast. The shared PMD tables cannot
>      become exclusive (fully unshared) before an IPI will be broadcasted
>      by the last sharer.
> 
>      Concurrent GUP-fast could walk into a PMD table just before we
>      unshared it. It could then succeed in grabbing a page from the
>      shared page table even after munmap() etc succeeded (and supressed
>      an IPI). But there is not difference compared to GUP-fast just
>      sleeping for a while after grabbing the page and re-enabling IRQs.
> 
>      Most importantly, GUP-fast will never walk into page tables that are
>      no-longer shared, because the last sharer will issue an IPI
>      broadcast.
> 
>      (if ever required, checking whether the PUD changed in GUP-fast
>       after grabbing the page like we do in the PTE case could handle
>       this)
> 
> So let's rework PMD sharing TLB flushing + IPI sync to use the mmu_gather
> infrastructure so we can implement these optimizations and demystify the
> code at least a bit. Extend the mmu_gather infrastructure to be able to
> deal with our special hugetlb PMD table sharing implementation.
> 
> To make initialization of the mmu_gather easier when working on a single
> VMA (in particular, when dealing with hugetlb), provide
> tlb_gather_mmu_vma().
> 
> We'll consolidate the handling for (full) unsharing of PMD tables in
> tlb_unshare_pmd_ptdesc() and tlb_flush_unshared_tables(), and track
> in "struct mmu_gather" whether we had (full) unsharing of PMD tables.
> 
> Because locking is very special (concurrent unsharing+reuse must be
> prevented), we disallow deferring flushing to tlb_finish_mmu() and instead
> require an explicit earlier call to tlb_flush_unshared_tables().
> 
>  From hugetlb code, we call huge_pmd_unshare_flush() where we make sure
> that the expected lock protecting us from concurrent unsharing+reuse is
> still held.
> 
> Check with a VM_WARN_ON_ONCE() in tlb_finish_mmu() that
> tlb_flush_unshared_tables() was properly called earlier.
> 
> Document it all properly.
> 
> Notes about tlb_remove_table_sync_one() interaction with unsharing:
> 
> There are two fairly tricky things:
> 
> (1) tlb_remove_table_sync_one() is a NOP on architectures without
>      CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> 
>      Here, the assumption is that the previous TLB flush would send an
>      IPI to all relevant CPUs. Careful: some architectures like x86 only
>      send IPIs to all relevant CPUs when tlb->freed_tables is set.
> 
>      The relevant architectures should be selecting
>      MMU_GATHER_RCU_TABLE_FREE, but x86 might not do that in stable
>      kernels and it might have been problematic before this patch.
> 
>      Also, the arch flushing behavior (independent of IPIs) is different
>      when tlb->freed_tables is set. Do we have to enlighten them to also
>      take care of tlb->unshared_tables? So far we didn't care, so
>      hopefully we are fine. Of course, we could be setting
>      tlb->freed_tables as well, but that might then unnecessarily flush
>      too much, because the semantics of tlb->freed_tables are a bit
>      fuzzy.
> 
>      This patch changes nothing in this regard.
> 
> (2) tlb_remove_table_sync_one() is not a NOP on architectures with
>      CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.
> 
>      Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
>      we still issue IPIs during TLB flushes and don't actually need the
>      second tlb_remove_table_sync_one().
> 
>      This optimized can be implemented on top of this, by checking e.g., in
>      tlb_remove_table_sync_one() whether we really need IPIs. But as
>      described in (1), it really must honor tlb->freed_tables then to
>      send IPIs to all relevant CPUs.
> 
> Notes on TLB flushing changes:
> 
> (1) Flushing for non-shared PMD tables
> 
>      We're converting from flush_hugetlb_tlb_range() to
>      tlb_remove_huge_tlb_entry(). Given that we properly initialize the
>      MMU gather in tlb_gather_mmu_vma() to be hugetlb aware, similar to
>      __unmap_hugepage_range(), that should be fine.
> 
> (2) Flushing for shared PMD tables
> 
>      We're converting from various things (flush_hugetlb_tlb_range(),
>      tlb_flush_pmd_range(), flush_tlb_range()) to tlb_flush_pmd_range().
> 
>      tlb_flush_pmd_range() achieves the same that
>      tlb_remove_huge_tlb_entry() would achieve in these scenarios.
>      Note that tlb_remove_huge_tlb_entry() also calls
>      __tlb_remove_tlb_entry(), however that is only implemented on
>      powerpc, which does not support PMD table sharing.
> 
>      Similar to (1), tlb_gather_mmu_vma() should make sure that TLB
>      flushing keeps on working as expected.
> 
> Further, note that the ptdesc_pmd_pts_dec() in huge_pmd_share() is not a
> concern, as we are holding the i_mmap_lock the whole time, preventing
> concurrent unsharing. That ptdesc_pmd_pts_dec() usage will be removed
> separately as a cleanup later.
> 
> There are plenty more cleanups to be had, but they have to wait until
> this is fixed.
> 
> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---

The following doc fixup on top, reported by buildbots on my private branch:


 From 3556c4ce6b645f680be8040c8512beadb5f84d38 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Date: Thu, 25 Dec 2025 10:41:55 +0100
Subject: [PATCH] fixup

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
  mm/mmu_gather.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index cd32c2dbf501b..7468ec3884555 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -462,8 +462,8 @@ void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
  }
  
  /**
- * tlb_gather_mmu - initialize an mmu_gather structure for operating on a single
- *		    VMA
+ * tlb_gather_mmu_vma - initialize an mmu_gather structure for operating on a
+ *			single VMA
   * @tlb: the mmu_gather structure to initialize
   * @vma: the vm_area_struct
   *
-- 
2.52.0


-- 
Cheers

David

