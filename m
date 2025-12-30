Return-Path: <linux-arch+bounces-15609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213EBCEA9CF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 21:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BCEF30060CD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC9265CD9;
	Tue, 30 Dec 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrAmyVvE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957F246782;
	Tue, 30 Dec 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126842; cv=none; b=EJoXNB2mon+jVLkGGUyb1VqpznDzm6wRkLP84SYfoaU8FW5EMAnYpuM0+14I+nVq9QJzlsoWzaV/mFPxBU7iMixi4rIe3j0wdo5/ng71Rcmr5DPded+aOEWOQhC118sYvW9V2xWOHm3ECiOQ9Mt/qhPiewYipkXSnhfOr50XE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126842; c=relaxed/simple;
	bh=4IHtShbZ7SkTOAYLBZj9TSKXtSMlwo4nI5tswNsLZWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKMLaIOGl6OqW81OMzsuc6wV+mhF+iDZ8M0NyzMj6QuUd34aeqTVr1ML2fdLpFWPE2xh+TwNbPEOiOK8KtAH6pwcuTxgMlhAy/aFr2Q2skV9weKxrZxTQ+p4mscX1H3MMeq/VvkrMraWPRqaWe6Wfj605QIa1wcAjnmIjYsYMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrAmyVvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E9BC4CEFB;
	Tue, 30 Dec 2025 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767126842;
	bh=4IHtShbZ7SkTOAYLBZj9TSKXtSMlwo4nI5tswNsLZWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PrAmyVvEnpZ4yRI0wUa+185Y7q0FM/Tw3glVvKO5aACCa44jDc+P3QXzXw4+OfTfo
	 gOr9uPnI9cTfK7MH1w1F81H84Ygc0l7FXK2cLSASh6Q2r8VSoz07W59zj3BUPoCN2D
	 BPalls68LBODQR68nQJuK+fPOz9D9ZAuJKLlPwctvqVEefMmhTueXozTyHCpOMRbQz
	 NqXfiidlc2SnQsUfOKDlVwSYUVdhxWXlrSkUjpKnT/GMUcIPbYL/lbgpXZ6188Gs8G
	 nMoCTTrrsk7d+STX9wdSJ7qliax3KSJGjlULX2X/L8zszSXrBY+P4cg+HUh1eMVQzC
	 k4LOD1usLY82A==
Message-ID: <f4d5548d-6045-47a3-b233-0a67702bb477@kernel.org>
Date: Tue, 30 Dec 2025 21:33:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: embed TLB flush IPI check in
 tlb_remove_table_sync_one()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251229145245.85452-1-lance.yang@linux.dev>
 <20251229145245.85452-4-lance.yang@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251229145245.85452-4-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/25 15:52, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> Embed the tlb_table_flush_implies_ipi_broadcast() check directly inside
> tlb_remove_table_sync_one() instead of requiring every caller to check
> it explicitly. This relies on callers to do the right thing: flush with
> freed_tables=true or unshared_tables=true beforehand.
> 
> All existing callers satisfy this requirement:
> 
> 1. mm/khugepaged.c:1188 (collapse_huge_page):
> 
>     pmdp_collapse_flush(vma, address, pmd)
>     -> flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE)
>        -> flush_tlb_mm_range(mm, ..., freed_tables = true)
>           -> flush_tlb_multi(mm_cpumask(mm), info)
> 
>     So freed_tables=true before calling tlb_remove_table_sync_one().
> 
> 2. include/asm-generic/tlb.h:861 (tlb_flush_unshared_tables):
> 
>     tlb_flush_mmu_tlbonly(tlb)
>     -> tlb_flush(tlb)
>        -> flush_tlb_mm_range(mm, ..., unshared_tables = true)
>           -> flush_tlb_multi(mm_cpumask(mm), info)
> 
>     unshared_tables=true (equivalent to freed_tables for sending IPIs).
> 
> 3. mm/mmu_gather.c:341 (__tlb_remove_table_one):
> 
>     When we can't allocate a batch page in tlb_remove_table(), we do:
> 
>     tlb_table_invalidate(tlb)
>     -> tlb_flush_mmu_tlbonly(tlb)
>        -> flush_tlb_mm_range(mm, ..., freed_tables = true)
>           -> flush_tlb_multi(mm_cpumask(mm), info)
> 
>     Then:
>     tlb_remove_table_one(table)
>     -> __tlb_remove_table_one(table) // if !CONFIG_PT_RECLAIM
>        -> tlb_remove_table_sync_one()
> 
>     freed_tables=true, and this should work too.
> 
>     Why is tlb->freed_tables guaranteed? Because callers like
>     pte_free_tlb() (via free_pte_range) set freed_tables=true before
>     calling __pte_free_tlb(), which then calls tlb_remove_table().
>     We cannot free page tables without freed_tables=true.
> 
>     Note that tlb_remove_table_sync_one() was a NOP on bare metal x86
>     (CONFIG_MMU_GATHER_RCU_TABLE_FREE=n) before commit a37259732a7d
>     ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional").
> 
> 4-5. mm/khugepaged.c:1683,1819 (pmdp_get_lockless_sync macro):
> 
>     Same as #1. These also use pmdp_collapse_flush() beforehand.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

LGTM. I think we should document that somewhere. Can we add some 
kerneldoc for tlb_remove_table_sync_one() where we document that it 
doesn't to any sync if a previous TLB flush when removing/unsharing page 
tables would have already performed an IPI?

> ---
>   mm/mmu_gather.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 7468ec388455..7b588643cbae 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -276,6 +276,10 @@ static void tlb_remove_table_smp_sync(void *arg)
>   
>   void tlb_remove_table_sync_one(void)
>   {
> +	/* Skip the IPI if the TLB flush already synchronized with other CPUs. */
> +	if (tlb_table_flush_implies_ipi_broadcast())
> +		return;
> +
>   	/*
>   	 * This isn't an RCU grace period and hence the page-tables cannot be
>   	 * assumed to be actually RCU-freed.


-- 
Cheers

David

