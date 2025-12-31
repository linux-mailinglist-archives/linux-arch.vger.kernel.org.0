Return-Path: <linux-arch+bounces-15624-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE26CEBFA3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 13:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4567301057F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768D322A30;
	Wed, 31 Dec 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE4r/UCf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B1320A01;
	Wed, 31 Dec 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767184420; cv=none; b=W/odhbBiNDBpbHms3QKmH5VRgqo+4Bl/x81z5v7umcQlXdi9cV8qUsqZ7W/0WowGDihmxKBiBaiW28OzukBvkdyOyZ34bJWI/k2xES102OlgpAKq05TXb/6hXysXfpi2RaMF49zybsaZ8HSsRwdHdh9GlBOaj0aJykpO+TxbdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767184420; c=relaxed/simple;
	bh=88co770AdIIceGvPwMVRk+/DHD76pSN9yIlkzwg/7uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkJtApnKudXQJBUBfscndO3shhBF3jXVgpbGK58auVkYoWe4ZnSWKjnuiWm8a9jIqBdTkSUBOsXQeNPMLW424A7wrdhymlxMhiTsPiGceKoOoIhaj4si6q7wMh5yWW9knleXeAP9VtAxOAT7IvX6mz3PMoh8xXyp3sMKJYcLpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE4r/UCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105F8C113D0;
	Wed, 31 Dec 2025 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767184419;
	bh=88co770AdIIceGvPwMVRk+/DHD76pSN9yIlkzwg/7uM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oE4r/UCfpuC1PaAb9MdsdBU8sXRc2ePgeEuIj2rQ9eP5m1TU5zx587hBGLFLuo9xJ
	 V7g5LTrqyXvIRLQfqgbp2rXq3sEKWQ1HzoGh9Ey43xw0G5Pl9sACb+IRdk+GKEl32D
	 KEdMisFv9H9UmI0Bhbhmm07yLfYehoNYdLQy+tkyYHwGwF2r3lPx8/2Xp++Ws1aSmK
	 bOCTDRyrwF0Rg+NieWnXQCDeZK5Nrix7UnVkrveR+OUyU+3JVbFYMpu9OIxv3GQoDF
	 /llElF2C7gkZ0d07keo6NKLapRuK/yrG1QrFbSmZ2x87lJ+6oDPlbtH7eyIEAgcmC2
	 To5UZafOHYpqg==
Message-ID: <1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org>
Date: Wed, 31 Dec 2025 13:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] skip redundant TLB sync IPIs
To: Dave Hansen <dave.hansen@intel.com>, Lance Yang <lance.yang@linux.dev>,
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
 <f81b98e5-87c0-4c21-9a75-ad5f9b6af6aa@intel.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <f81b98e5-87c0-4c21-9a75-ad5f9b6af6aa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/31/25 05:26, Dave Hansen wrote:
> On 12/29/25 06:52, Lance Yang wrote:
> ...
>> This series introduces a way for architectures to indicate their TLB flush
>> already provides full synchronization, allowing the redundant IPI to be
>> skipped. For now, the optimization is implemented for x86 first and applied
>> to all page table operations that free or unshare tables.
> 
> I really don't like all the complexity here. Even on x86, there are
> three or more ways of deriving this. Having the pv_ops check the value
> of another pv op is also a bit unsettling.

Right. What I actually meant is that we simply have a property "bool 
flush_tlb_multi_implies_ipi_broadcast" that we set only to true from the 
initialization code.

Without comparing the pv_ops.

That should reduce the complexity quite a bit IMHO.

But maybe you have an even better way on how to indicate support, in a 
very simple way.

> 
> That said, complexity can be worth it with sufficient demonstrated
> gains. But:
> 
>> When unsharing hugetlb PMD page tables or collapsing pages in khugepaged,
>> we send two IPIs: one for TLB invalidation, and another to synchronize
>> with concurrent GUP-fast walkers.
> 
> Those aren't exactly hot paths. khugepaged is fundamentally rate
> limited. I don't think unsharing hugetlb PMD page tables just is all
> that common either.

Given that the added IPIs during unsharing broke Oracle DBs rather badly 
[1], I think this is actually a case worth optimizing.

I'd assume that the impact can be measured on a many-core/many-socket 
system with an adjusted reproducer of [1]. The impact will not be as big 
as what [1] fixed (we reduced the tlb_remove_table_sync_one() 
invocations quite drastically).

After all, tlb_remove_table_sync_one() sends an IPI to *all* CPUs in the 
system, not just the ones in the MM CPU mask, which is rather bad on 
systems with a lot of CPUs. Of course, this way we can only optimize on 
systems that actually send IPIs during TLB flushes.

For other systems, it will be more tricky to avoid these broadcast IPIs.

(I have the faint recollection that the IPI broadcast through 
tlb_remove_table_sync_one() is a problem when called from 
__tlb_remove_table_one() on RT systems ...)

[1] https://lkml.kernel.org/r/20251223214037.580860-1-david@kernel.org

-- 
Cheers

David

