Return-Path: <linux-arch+bounces-15612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C613CEB130
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96D53300C340
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60A2E62B5;
	Wed, 31 Dec 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWjmBNlf"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C862E62A2
	for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767148196; cv=none; b=Xy1m2btp83YYFbzV4OmsKR5jIuiaK14aldWNE+btfhdgnP2SCElK61Qk3boPb1tGf80GraXZ7ILn3NjDQXJSMuQ5pVb6S45hpecUWAw0FRcInmIA+heJt308dBUzUI7vkkAsqQhEiyMhZmUIIOmbfifSTm2CXbX039j+cTpHjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767148196; c=relaxed/simple;
	bh=7rXjqJR/SeOtUouPwaConEb1plJhkxgMWyk7kIs0yws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7nJmuOur9ue2jt724yRoObMOmDhbyyYmepB+tUm0rG6w9SWUFHPTHYFOdJliEnf6/v8bdP6lwhQJc/fBjHN5OCm0GrJ/JU3e1ZdvsWczILrY7Vnqqf3f+kA6tSOBDCZy1PjtVGTJ82nOo5eQBkarYQOIko49ctFX/Yi40QCa/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWjmBNlf; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af13561e-c512-4ab3-af5f-3b2057ac6667@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767148180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37nD/3cQoIBI0/8IexFOw2YpceIM7p2wvl3IFIN7jQc=;
	b=XWjmBNlfSH4f7yYWlEW51gqh/6yRLbDw2YvyaNBHRcNpxz64Ud8N5126J65U7ERVSnQQfr
	59jIGP68fKaJXi4HB2xgjLejyEflrzDJT8yqvo2Xzz5i73aE1om/wwQUGbnV2tYXPzjyTx
	xbZc/lV026OlxMR2SGFTkWLyaXCHkQo=
Date: Wed, 31 Dec 2025 10:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] mm/tlb: allow architectures to skip redundant TLB
 sync IPIs
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 akpm@linux-foundation.org
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
 <725b85bf-ff5e-45d6-991e-d92598779f98@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <725b85bf-ff5e-45d6-991e-d92598779f98@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/31 04:31, David Hildenbrand (Red Hat) wrote:
> On 12/29/25 15:52, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When unsharing hugetlb PMD page tables, we currently send two IPIs: one
>> for TLB invalidation, and another to synchronize with concurrent GUP-fast
>> walkers.
>>
>> However, if the TLB flush already reaches all CPUs, the second IPI is
>> redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
>> completes, any concurrent GUP-fast must have finished.
>>
>> Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
>> their TLB flush provides full synchronization, enabling the redundant IPI
>> to be skipped.
>>
>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   include/asm-generic/tlb.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 4d679d2a206b..e8d99b5e831f 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -261,6 +261,20 @@ static inline void 
>> tlb_remove_table_sync_one(void) { }
>>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>> +/*
>> + * Architectures can override if their TLB flush already broadcasts 
>> IPIs to all
>> + * CPUs when freeing or unsharing page tables.
>> + *
>> + * Return true only when the flush guarantees:
>> + * - IPIs reach all CPUs with potentially stale paging-structure 
>> cache entries
>> + * - Synchronization with IRQ-disabled code like GUP-fast
>> + */
>> +#ifndef tlb_table_flush_implies_ipi_broadcast
>> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
>> +{
>> +    return false;
>> +}
>> +#endif
>>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>   /*
> 
> 
> This should likely get squashed into patch #3. Patch #1 itself does not 
> add a lot of value to be had separately.
> 
> So best to squash both and have them as #1, to then implement it in #2 
> for x86.

Sounds good, will do! Squashing #1 and #3 together, keeping the x86
implementation as #2 ;)

Cheers,
Lance

