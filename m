Return-Path: <linux-arch+bounces-15673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F36CF9487
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25FF93062A28
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D50723BF83;
	Tue,  6 Jan 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMfitq5q"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A921238166
	for <linux-arch@vger.kernel.org>; Tue,  6 Jan 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715850; cv=none; b=mP/BgUIVIwFn84I65N6t3Hcz9BPs5qhMwHslpfwfeQ8F/k0MW8Jp87GfOxoXXV05tz/TiP7qqy3ch0vmLSH5EDHaXwwM9U6q6YBFmk4a/6xb2CNUI5x3W99VuhvXFewMp7EpUNwVI4aEW0lQpnTL4Ey8E6ev0cXAv7CDLMuFRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715850; c=relaxed/simple;
	bh=yBlOLmXvTJZXx7jjdD7//wgssdthb8b9LahudkWuwUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMimeeceJp6qiUTm2DIhHpVaMrVcoN/jfnZml19jM8XtJyz8Uboh6xU8+ZIwiK/qFCwT9m7hGXtf7xZBS+HPDY7VRYWFFaCHbaKtaaCps3KM7yKqnUe39fI6dlsFUWPeeYCgy4LG6DgxntwXbEhwTBNBAiqjsKlQ0H+zOnfp40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMfitq5q; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7472056a-3919-429a-845d-c2076496d537@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767715841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2Cxn3EwhDHfjbIl/gQOEzsQers63B4LPHPOwWIVtEQ=;
	b=KMfitq5qykqtSP82o+xKD9KMrBh5LLQ+BMtIueS1XaPfvKYYuLI/cEv8q892u//dY1od0g
	LO0YM3SIAu7Q9S0iBF/IKhT8smwFrozBqukDDTU7JjgH1HSDVGwkdIraim4N1etNoNULLe
	0HuFBMpjKHsPFeFGdcxksdb5Q6B3nZs=
Date: Wed, 7 Jan 2026 00:10:16 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v3 1/2] mm/tlb: skip redundant IPI when TLB flush
 already synchronized
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: dave.hansen@intel.com, dave.hansen@linux.intel.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-2-lance.yang@linux.dev>
 <da1e8a00-99fe-46d9-b425-c307ea933036@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <da1e8a00-99fe-46d9-b425-c307ea933036@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/6 23:19, David Hildenbrand (Red Hat) wrote:
>>   static void tlb_table_flush(struct mmu_gather *tlb)
>> @@ -367,7 +378,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void 
>> *table)
>>           *batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
>>           if (*batch == NULL) {
>>               tlb_table_invalidate(tlb);
>> -            tlb_remove_table_one(table);
>> +            tlb_remove_table_one(table, tlb);
>>               return;
>>           }
>>           (*batch)->nr = 0;
>> @@ -427,6 +438,7 @@ static void __tlb_gather_mmu(struct mmu_gather 
>> *tlb, struct mm_struct *mm,
>>       tlb->vma_pfn = 0;
>>       tlb->fully_unshared_tables = 0;
>> +    tlb->tlb_flush_sent_ipi = 0;
>>       __tlb_reset_range(tlb);
>>       inc_tlb_flush_pending(tlb->mm);
>>   }
> 
> But when would we have to reset tlb->tlb_flush_sent_ipi = 0 later? 
> That's where it gets tricky. Just imagine the MMU gather gets reused later.
> 
> Also,
> 
>      +    if (info->freed_tables && info->tlb)
>      +        info->tlb->tlb_flush_sent_ipi = true;
> 
> in native_flush_tlb_multi() misses the fact that we have different 
> flushing types for removed/unshared tables vs. other flush.
> 
> So this approach more here certainly gets more complicated and error prone.

Agreed. Tracking the flag through mmu_gather lifecycle does get
more complicated and error-prone ...

> 
> tlb_table_flush_implies_ipi_broadcast() was clearer in that regard: if 
> you flushed the TLB after removing /unsharing tables, the IPI for 
> handling page tables can be skipped. It's on the code flow to assure that.

v2 was definitely simpler.

> 
> What could work is tracking "tlb_table_flush_sent_ipi" really when we 
> are flushing the TLB for removed/unshared tables, and maybe resetting 
> it ... I don't know when from the top of my head.

Not sure what's the best way forward here :(

> 
> v2 was simpler IMHO.

The main concern Dave raised was that with PV hypercalls or when
INVLPGB is available, we can't tell from a static check whether IPIs
were actually sent.

Maybe that's acceptable, or we could find a simpler way to track that ...

Open to suggestions!

