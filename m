Return-Path: <linux-arch+bounces-15677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE17CFBC64
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 03:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1E5930223DB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A01A285;
	Wed,  7 Jan 2026 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/QfcK3/"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14212253FC
	for <linux-arch@vger.kernel.org>; Wed,  7 Jan 2026 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754093; cv=none; b=tJQcPAp5gbJk6OurG3IcwylohhzhagELbqw9l3aGXCBRDMKsRfJZojrkq1HJWMXU9O+QVrIEBvPtiFOFx/qV4r0qe5MIJ5rKwsmhd+/Lr8nqWPoCFl7NniKb4Bp4oCJ0gGQbGVugzHIYb5hR8RfDK3S8S5RAX/uQl3zRp6VyJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754093; c=relaxed/simple;
	bh=4vg0zvMFIipcxhh2Kuyw4vvZins9BpuMTelqU1kZTtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vA7e/cQXJQqa4f9qxbJQLEI/vt7hNdknnaDhhJHrTbNwz1iiWZdJZj/TVESxafiMvF8RmueJsdb8ZR1pu03f2S2cl+5GqYuel8E8kyVMJ6ceKE6cododAEFqrxyU1uc4or3gJWrNwNKgEFzOr+4eH/hDsQ3E8zUxwGVpadJ4Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/QfcK3/; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2adc4355-f1e2-4355-b04e-efae4425a3d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767754086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFZrV5kmQftGED1K5FteX+JpgExPrbIhIEwJ9SC4Xfw=;
	b=Y/QfcK3/W+rQd+sxRh7PqPbB7Fy49kzT7B5aVJ2cZbpERAqVDPfd1qM1b/TlraC47629jf
	RM+lT+TuFXRJPR0nzpKAcNg9sVx5vSid6LIqjBtD288mC/4iDei3J2SKN/lTaoyxvO0Ejz
	CTPwD00Qi+CedL5Kcx28Z30m1Wz0L58=
Date: Wed, 7 Jan 2026 10:47:50 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v3 1/2] mm/tlb: skip redundant IPI when TLB flush
 already synchronized
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, david@kernel.org
Cc: dave.hansen@linux.intel.com, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com, akpm@linux-foundation.org
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-2-lance.yang@linux.dev>
 <a20ab449-e6b4-45c7-86df-bb194304503c@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a20ab449-e6b4-45c7-86df-bb194304503c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/7 00:24, Dave Hansen wrote:
> On 1/6/26 04:03, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When unsharing hugetlb PMD page tables, we currently send two IPIs: one
>> for TLB invalidation, and another to synchronize with concurrent GUP-fast
>> walkers via tlb_remove_table_sync_one().
>>
>> However, if the TLB flush already sent IPIs to all CPUs (when freed_tables
>> or unshared_tables is true), the second IPI is redundant. GUP-fast runs
>> with IRQs disabled, so when the TLB flush IPI completes, any concurrent
>> GUP-fast must have finished.
>>
>> To avoid the redundant IPI, we add a flag to mmu_gather to track whether
>> the TLB flush sent IPIs. We pass the mmu_gather pointer through the TLB
>> flush path via flush_tlb_info, so native_flush_tlb_multi() can set the
>> flag when it sends IPIs for freed_tables. We also set the flag for
>> local-only flushes, since disabling IRQs provides the same guarantee.
> 
> The lack of imperative voice is killing me. :)

Oops.

> 
>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>> index 866ea78ba156..c5950a92058c 100644
>> --- a/arch/x86/include/asm/tlb.h
>> +++ b/arch/x86/include/asm/tlb.h
>> @@ -20,7 +20,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>>   		end = tlb->end;
>>   	}
>>   
>> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
>> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
>> +			   tlb->freed_tables || tlb->unshared_tables, tlb);
>>   }
> 
> I think this hunk sums up v3 pretty well. Where there was a single boolean, now there are two. To add to that, the structure that contains the booleans is itself being passed in. The boolean is still named 'freed_tables', and is going from:
> 
> 	tlb->freed_tables
> 
> which is pretty obviously correct to:
> 
> 	tlb->freed_tables || tlb->unshared_tables
> 
> which is _far_ from obviously correct.
> 
> I'm at a loss for why the patch wouldn't just do this:
> 
> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb);
> 
> I suspect these were sent out in a bit of haste, which isn't the first time I've gotten that feeling with this series.
> 
> Could we slow down, please?

Sorry, I went too fast ...

> 
>>   static inline void invlpg(unsigned long addr)
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 00daedfefc1b..83c260c88b80 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -220,6 +220,7 @@ struct flush_tlb_info {
>>   	 *   will be zero.
>>   	 */
>>   	struct mm_struct	*mm;
>> +	struct mmu_gather	*tlb;
>>   	unsigned long		start;
>>   	unsigned long		end;
>>   	u64			new_tlb_gen;
> 
> This also gives me pause.
> 
> There is a *lot* of redundant information between 'struct mmu_gather' and 'struct tlb_flush_info'. There needs to at least be a description of what the relationship is and how these relate to each other. I would have naively thought that the right move here would be to pull the mmu_gather data out at one discrete time rather than store a pointer to it.
> 
> What I see here is, I suspect, the most expedient way to do it. I'd _certainly_ have done this myself if I was just hacking something together to play with as quickly as possible.
> 
> So, in the end, I don't hate the approach here (yet). But it is almost impossible to evaluate it because the series is taking some rather egregious shortcuts and is lacking any real semblance of a refactoring effort.

The flag lifetime issue David pointed out is real, and you're right
about the messy parameters :)

And, yeah, I need to think more those. Maybe v3 can be fixed, or maybe
v2 is actually sufficient - it's conservative but safe (no false positives).

Will take more time, thanks!

