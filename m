Return-Path: <linux-arch+bounces-1825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E8841E27
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9DAB2B340
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4C57866;
	Tue, 30 Jan 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0zfKq4o"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA95647A
	for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604077; cv=none; b=imM6uCAkDFK/nQwLpe66HDclD+HH/Q2tBsiGThrqSbxi4DyDKioYv+9XqWiFLfbOGXi4KBBL09FVZ9FRnqhA3H/fDu8hkEeUIbRXNpBKN4FeTNNr1x/+pijSlb0xv8ALpXaQhTXtXs7tuvnH7xCioetJzyITW9LSzO4zlvNek88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604077; c=relaxed/simple;
	bh=4rh0Q2Hx4gVs1GnupnIzsQ6wwoJNXFCaVER32ep7Twg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9Su0bnBX6HIKuBBkT3vTrxfrALUDfUV1ney5kvBLMNSljbJ5DHw7bM4ZT8dqSljC+oMizYlFLysYXWY8IGJ78YxLQmEsbCsmAmPSycJTx8BlL115rFdsAqT9O30QWdE2C1TYdHaz2YbHSUhgyv3wymwtMxDFvfyb3wZx1TfnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0zfKq4o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706604073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WTLnFRdfrnxQwRE7F4TUEf4XESOHlEYGkt2XMSp/gnM=;
	b=Z0zfKq4oBalWOLPmUNNft8DS8cK3ioork54OPHtmg2zrfs8QwttfknxaLdBc4iuwssShTa
	noCZ7ut/HTkMucwtE9rceUFkgF5GcZqiBCgVfFEthwVfFpwLOzIXhQB6mTHszpNxwkadHx
	mCq6HRdtTeOMPNsjjDzFgskcxySL31U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-bX2j7dv5NCWtgOzCTZKPsQ-1; Tue, 30 Jan 2024 03:41:11 -0500
X-MC-Unique: bX2j7dv5NCWtgOzCTZKPsQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e9e5c8f49so3783599e87.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 00:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604070; x=1707208870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTLnFRdfrnxQwRE7F4TUEf4XESOHlEYGkt2XMSp/gnM=;
        b=OZpQazd88Kv2w9/imGPN0DLiQuseuVWCAEqVpr+vkYsx/OpnVml4S1f81hRMEzoyU3
         oHcEkem/wmHwE5x9O4YGXqnU1W/jfovKoDNSg70Yv49WNPiib82iXjlvcZB0KMPy2V6t
         WOoF8op226QhRSzczVJg1FPmrAnhwAe605TNLo7AewWVqgCIp0PKH0IWoPpghvOw1+HJ
         Yvf1YPTM9XB9anaG+78TjR5VjxhpPE3ntUuYk0cugQiVGjNbRbsuxUJAMhCkQwmcDPXH
         8SmhsD3ErgME3c5ydDzhtwYnEp3n814McewX7bdJ62hqs4tTNhNrJqtM6fCOk6M8JFL2
         DywA==
X-Gm-Message-State: AOJu0YxJU8EfAc3OjPvLXGSf3zJmr4DhIIU9tx0it47rsSkmu23vh+SX
	WHvtcKU+EmnwE5TtiVFTJ2Aw2p0MauSJvtU49J49chHvNNBnA9Y8jeIAtqcfqZ4miNCY5tSK+t1
	v2n5P9BuysLLJdRDzkjCGYBeefkIowHJzgCRt+EDUN9CN9JbsaaXztsoh6ik=
X-Received: by 2002:a05:6512:e9b:b0:510:ee2d:c185 with SMTP id bi27-20020a0565120e9b00b00510ee2dc185mr5566824lfb.13.1706604070370;
        Tue, 30 Jan 2024 00:41:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcI8ngN1g9WgPokS7RyiEf1XgLiCDm+dXR+CkC1Oa7Yg/aFBEbTGjE1f71utFB2RtdPFKXlQ==
X-Received: by 2002:a05:6512:e9b:b0:510:ee2d:c185 with SMTP id bi27-20020a0565120e9b00b00510ee2dc185mr5566802lfb.13.1706604069964;
        Tue, 30 Jan 2024 00:41:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:2700:bdf6:739b:9f9d:862f? (p200300cbc7082700bdf6739b9f9d862f.dip0.t-ipconnect.de. [2003:cb:c708:2700:bdf6:739b:9f9d:862f])
        by smtp.gmail.com with ESMTPSA id p34-20020a05600c1da200b0040f22171921sm838440wms.3.2024.01.30.00.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:41:09 -0800 (PST)
Message-ID: <8d19d635-2f55-4c0d-958b-0640f99ff0ce@redhat.com>
Date: Tue, 30 Jan 2024 09:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] mm/memory: factor out zapping of present pte into
 zap_present_pte()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240129143221.263763-1-david@redhat.com>
 <20240129143221.263763-2-david@redhat.com>
 <40e87333-4da9-4497-a117-9885986e376a@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <40e87333-4da9-4497-a117-9885986e376a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.01.24 09:13, Ryan Roberts wrote:
> On 29/01/2024 14:32, David Hildenbrand wrote:
>> Let's prepare for further changes by factoring out processing of present
>> PTEs.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 92 ++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 52 insertions(+), 40 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b05fd28dbce1..50a6c79c78fc 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1532,13 +1532,61 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>>   	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>   }
>>   
>> +static inline void zap_present_pte(struct mmu_gather *tlb,
>> +		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
>> +		unsigned long addr, struct zap_details *details,
>> +		int *rss, bool *force_flush, bool *force_break)
>> +{
>> +	struct mm_struct *mm = tlb->mm;
>> +	bool delay_rmap = false;
>> +	struct folio *folio;
> 
> You need to init this to NULL otherwise its a random value when calling
> should_zap_folio() if vm_normal_page() returns NULL.

Right, and we can stop setting it to NULL in the original function. 
Patch #2 changes these checks, which is why it's only a problem in this 
patch.

Will fix, thanks!

-- 
Cheers,

David / dhildenb


