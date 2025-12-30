Return-Path: <linux-arch+bounces-15608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E029ACEA9C0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 21:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7A683005F3D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864526F46E;
	Tue, 30 Dec 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFImDH+K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A032641CA;
	Tue, 30 Dec 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126721; cv=none; b=RmdzfZutQz66tunuAFxViueoB7FYjT89vpbj3JSxDGgOSHqcXaSs9TPvBLM/FZfrAsP9Cdyw7SZegvepW75bE25BvomFqdU/pA63tlkWEm9FwWARI62qIPt1kNVwUXcOUKMPVW5WPwdoy9XbScSdTxGQtt3S2imNE1xPH2ZYC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126721; c=relaxed/simple;
	bh=cndBsIdqWaO0mAWgypNK8SdnZmIn09dB7jgukNbm22w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvVlSgt/vqCbrBDxeUwvPRyS7VT7UB3/VpmoNrwksABNNzwRpNk3+cm3p+mibzUUXeIqo8QjMfj/x8ocjBt5II6SBW+1GbVfA8Bm8+jtO/Io7RKtB9kaIk60p0oF04ZdgXAD0XvTNCJi9bUg8ezZ7aLxxx7dRO38A8i4pEuWTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFImDH+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB22C4CEFB;
	Tue, 30 Dec 2025 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767126721;
	bh=cndBsIdqWaO0mAWgypNK8SdnZmIn09dB7jgukNbm22w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RFImDH+KE8o0n4QR10H4g03pXnoFVlnXi95t2jkVwzBvm3iUyPAFFUDsKjAGKDS6O
	 1384jK4bXsTUKQREFbHc8T14YsyjZ+5+N8hJOzl4uztvoAtlBb3DmFTDK6k9t9bzqf
	 ZJEBD9PvLpA5IArOlpb5q2+k+IMGVc11Rw89kMQbSOPhEt7RAZUMFXt8wVmNpDEzR+
	 1c2TTUYBxQn4PU1f477EIXkUnOabLBlYBPHtygvfN3TT098hZXv+M8VvSEg+q82w0L
	 Lyje7kaCTXZXIiAkmhIbGXmDPlFCtiuzom3Hy4MBH5P6HZtutqAiPtkJM6DqHmd2LZ
	 zJ4zf1lkPnAhw==
Message-ID: <725b85bf-ff5e-45d6-991e-d92598779f98@kernel.org>
Date: Tue, 30 Dec 2025 21:31:49 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/tlb: allow architectures to skip redundant TLB
 sync IPIs
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
 <20251229145245.85452-2-lance.yang@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251229145245.85452-2-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/25 15:52, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When unsharing hugetlb PMD page tables, we currently send two IPIs: one
> for TLB invalidation, and another to synchronize with concurrent GUP-fast
> walkers.
> 
> However, if the TLB flush already reaches all CPUs, the second IPI is
> redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
> completes, any concurrent GUP-fast must have finished.
> 
> Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
> their TLB flush provides full synchronization, enabling the redundant IPI
> to be skipped.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   include/asm-generic/tlb.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 4d679d2a206b..e8d99b5e831f 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -261,6 +261,20 @@ static inline void tlb_remove_table_sync_one(void) { }
>   
>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>   
> +/*
> + * Architectures can override if their TLB flush already broadcasts IPIs to all
> + * CPUs when freeing or unsharing page tables.
> + *
> + * Return true only when the flush guarantees:
> + * - IPIs reach all CPUs with potentially stale paging-structure cache entries
> + * - Synchronization with IRQ-disabled code like GUP-fast
> + */
> +#ifndef tlb_table_flush_implies_ipi_broadcast
> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
> +{
> +	return false;
> +}
> +#endif
>   
>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>   /*


This should likely get squashed into patch #3. Patch #1 itself does not 
add a lot of value to be had separately.

So best to squash both and have them as #1, to then implement it in #2 
for x86.

-- 
Cheers

David

