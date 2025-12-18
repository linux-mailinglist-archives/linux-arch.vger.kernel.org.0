Return-Path: <linux-arch+bounces-15495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F5CCC038
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EE043018E4E
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03966341066;
	Thu, 18 Dec 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVLARpdJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0092340DA6;
	Thu, 18 Dec 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063599; cv=none; b=nZ/RuAO5R5Ow06cY68nv42Y1aX3INb/uAVxHPsqbzkbO3qS9DVz2MCQ+II2xPnia7fANUHY6nee8BPIVrLrkjpdh6jyzInp4WIS6klIl2y0qmlJjDTSaAg+OUcmeod48EuXhe2+9ALb1qM/KIVfI1rbfAgW7/aEzyEg8QRcBQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063599; c=relaxed/simple;
	bh=noBOehaCn0eQHCOL9jK85iPGFgqWhhnZhi8sq4KK4ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LydScE+BbLlk+CIQM2CBI+VPPlGObXH+D1+cRE8F7XcvULwFQIuAEA5DZW3lvxQfENRfiKBJMSsjX+02qrIBoKj37io+rsUOXSDuSXOxPxqE8Ug6TTienWfFMvTVvNZJx2HCCe+0Hbsd56VWi1N8art8ZETKrFPYyuBvNiy7aiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVLARpdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8235DC4CEFB;
	Thu, 18 Dec 2025 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063599;
	bh=noBOehaCn0eQHCOL9jK85iPGFgqWhhnZhi8sq4KK4ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SVLARpdJNApORh52uUZZ+oZ2JyLYhhz/WBH+2tA6rmYtnnIiFrQjatV7VC1q2EFci
	 DLtX5VHygbekmzw7MRbwk4qwON5Z/DHQt2yOFU0VXySkdOZgIF2V3xCx9QhBqqBXog
	 E4aQ8c3mqujNi+13wpTULk5t4b9vYwgsMEX5JFo1SLECtdzkXnxw22cGdIMGs7yFUl
	 ++iIalpZiuEX7o05n5TAxa6x25cDbmzLhrPlljziBlORCAe0W7oTKYJPcMZlOTsSy2
	 5ObM33ZOIqIET4C++6F0wqqZDHEaDnFEDMUPNwUDg/gmj3/hBXcPM4fI9fgiinKafD
	 S+RMp1+180Y0g==
Message-ID: <948d425a-2d6e-4439-a280-0ca9e7521b13@kernel.org>
Date: Thu, 18 Dec 2025 14:13:09 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] mm/khugepaged: skip redundant IPI in
 collapse_huge_page()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251213080038.10917-1-lance.yang@linux.dev>
 <20251213080038.10917-4-lance.yang@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251213080038.10917-4-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/25 09:00, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> Similar to the hugetlb PMD unsharing optimization, skip the second IPI
> in collapse_huge_page() when the TLB flush already provides necessary
> synchronization.
> 
> Before commit a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
> unconditional"), bare metal x86 didn't enable MMU_GATHER_RCU_TABLE_FREE.
> In that configuration, tlb_remove_table_sync_one() was a NOP. GUP-fast
> synchronization relied on IRQ disabling, which blocks TLB flush IPIs.
> 
> When Rik made MMU_GATHER_RCU_TABLE_FREE unconditional to support AMD's
> INVLPGB, all x86 systems started sending the second IPI. However, on
> native x86 this is redundant:
> 
>    - pmdp_collapse_flush() calls flush_tlb_range(), sending IPIs to all
>      CPUs to invalidate TLB entries
> 
>    - GUP-fast runs with IRQs disabled, so when the flush IPI completes,
>      any concurrent GUP-fast must have finished
> 
>    - tlb_remove_table_sync_one() provides no additional synchronization
> 
> On x86, skip the second IPI when running native (without paravirt) and
> without INVLPGB. For paravirt with non-native flush_tlb_multi and for
> INVLPGB, conservatively keep both IPIs.
> 
> Use tlb_table_flush_implies_ipi_broadcast(), consistent with the hugetlb
> optimization.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/khugepaged.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 97d1b2824386..06ea793a8190 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1178,7 +1178,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	_pmd = pmdp_collapse_flush(vma, address, pmd);
>   	spin_unlock(pmd_ptl);
>   	mmu_notifier_invalidate_range_end(&range);
> -	tlb_remove_table_sync_one();
> +	/*
> +	 * Skip the second IPI if the TLB flush above already synchronized
> +	 * with concurrent GUP-fast via broadcast IPIs.
> +	 */
> +	if (!tlb_table_flush_implies_ipi_broadcast())
> +		tlb_remove_table_sync_one();

We end up calling

	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);

	-> flush_tlb_mm_range(freed_tables = true)

	-> flush_tlb_multi(mm_cpumask(mm), info);

So freed_tables=true and we should be doing the right thing.

BTW, I was wondering whether we should embed that 
tlb_table_flush_implies_ipi_broadcast() check in 
tlb_remove_table_sync_one() instead.

It then relies on the caller to do the right thing (flush with 
freed_tables=true or unshared_tables = true).

Thoughts?

-- 
Cheers

David

