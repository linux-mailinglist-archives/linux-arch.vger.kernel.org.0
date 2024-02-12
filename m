Return-Path: <linux-arch+bounces-2186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75AE85126D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F95E1F2259F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132CD39857;
	Mon, 12 Feb 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMZTZq0w"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAE39846
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737967; cv=none; b=mihew8SJseUt/XFOPDmMbhphWeHsDIs8pY2QEaB8x1AuhK/GfEJyWLh26IZE4r4osk8q5P57RDPnr/e5vumiGFdc24htJTck5e3EliPYdqjkCYFjkb/Wepo88FrHfwLckHTwKtaPCABxxC/iC3ekVna8ZJ5gS2LDDbqMPOli7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737967; c=relaxed/simple;
	bh=e3Qi/zidgZHW8EQ1s/nn/L+6Qx2dPVv66kA1sLbsKvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAtGAU3etCecZ0m4s+oRRK0NFnHt2aUwsZNywNh3IZ7tO5vo8AjH14vGSf2FbRVW9XegA38d9+QEzS1h6oI2093hleqCbHjPURv0oQAGG9Y7aDucn4L2lom+jDKXs5JGZONIcYlX5xoUoP6h9n/arYaTRfPSU9G75cdy5GMa790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMZTZq0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707737963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tnxlD2zZuM/MfG8rr4PtMPWvp6ek2FU8otdfOIHULks=;
	b=aMZTZq0w8POjmETH80ovaH9kEjkMYYi5aV26ARyAHww8zmsbgbrNML7ZZsE72seOFTRZLD
	pJHav7VasoMsmyOMT1mNcf6lgi8T6jP/QvKBA1hSknNyV5R37lzTbL83f0oHYNRwCaujDn
	xXPvHxnDXXh5tN9f2TQ0IftA/zvPn6w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-F7YILMCQNZ60LpKTtFmx-g-1; Mon, 12 Feb 2024 06:39:21 -0500
X-MC-Unique: F7YILMCQNZ60LpKTtFmx-g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b1799e433so1515428f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 03:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737960; x=1708342760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnxlD2zZuM/MfG8rr4PtMPWvp6ek2FU8otdfOIHULks=;
        b=tfHN4pA+ClsAnZsydudRUMcD5lHmqsnuQm9j57bLh/L7nyHMBiCGD/w9j2u4vQR89h
         yo1KiVIdpZZhR6F7vqFRtLcYsAZVyFNs9mWs3mh5HhcRRbDWcfvS/mrCbQ0EY5gZq9xy
         8RhbSPeWzjNqIMTJdX8uttCGXu8ulvO0xnU8JB6GzYeT63fdtss9Q5jCbdMxeOBK+SDJ
         BSOoo+p0Bq4X/EYDqlnFPwMc9uQPmk3bTCdhmz+ft4GiMqbP2iIUkJAEUXaZiTGnIRCw
         U4QEEYVGLhuBqGS8jSdxqBiLwpdq4HP72h8EDYwRUCReIVsVzAWR9FR7yoIMzvpqtKH+
         M6aQ==
X-Gm-Message-State: AOJu0YzDhkXy5yZAydJfFx9yfauLS7t8yJXQF/trT65eP3LsRVlmTBJ+
	7wGp6B0zMdVNZhmEB5/iZGVuOI44RLMHhHw06sw0iBMb+XAIaG2srFocsG/EeZ0x06WX/WBEP18
	+c8Zgao4v+2z6oWR4i2EkdaPcH9mxtFa/mFb7mLygQJWDCvD2pZP8EB0pVeo=
X-Received: by 2002:adf:f245:0:b0:33b:4908:9bbc with SMTP id b5-20020adff245000000b0033b49089bbcmr5699723wrp.40.1707737960573;
        Mon, 12 Feb 2024 03:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUioO4snca74CokLIda6VZmW9gaQHSjIGT6dyz21HSz8JeGKkqynO+oRpxdf1ri8H8EQD4hg==
X-Received: by 2002:adf:f245:0:b0:33b:4908:9bbc with SMTP id b5-20020adff245000000b0033b49089bbcmr5699687wrp.40.1707737960095;
        Mon, 12 Feb 2024 03:39:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiyxq86CcNpJpJsAACFBe1j8fZYXvupRStxAm/+jVhV5iBauROwZmNuDfXqNOf9q0vZDAHyC6Vl/kbqUmM4O0rgI817GGBGqc9xizNxNug0I7OfCp3LWkYJ1qW4FJz4Zplx0+heCfgjGSZa5pBCNeyKLWM1wet/IeVGyxnOG+fcJWh6k1vSejfKDvER62BvyCFj+K3PSyfNYo5vumCVZ3RARp3DqFudrU5Sh7HVoqKW6eRzvyITwymDfPiAFnDA32MQJNOJSiUHVR8rgHtHwRJXZziP1wULzTJoj87FoS9bVaiBoeDVvpl/cL1Ehm+W7OAl/ks2WcYAcJwlxuTLdNMzAbsDdB7NKBQGXuF8MF+1NR+/GTAT4tDu3CI5ysjmyYLyUSgmO6lg2hVF9b72l/vxVcalPZ9/15mY8auwJrWxU+2ktQUVZOAPXhRNTEHp44git663SnYQK49M11CxuxaFKiiAxwt1CgtfxPIH4xyoh6U1C0Y+84SSkH/4fEVKqtmtES+meG6P//7YI2jz7TAha46pBQKF7PcloXyY4frF/YRuhTzdv2scmk0alZMhBvmckQDQKCklT+LobWDSsJEnYt2P2c9+wxZbvnD3Q/pX56/24mM0TPMDM36WkMyjAqG7ZZD9GWF9h4SIZY3HhdIEdXPOfQAHWtuRFwjsCS+ZxknpqBaox+DSnYhFFcjpbJAVGd/utcn/rEMBO+qwuK54y0Ke0lIc0CSY0sH6ZYxPtN+4iw=
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d404d000000b0033b4dae972asm6535562wrp.37.2024.02.12.03.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:39:19 -0800 (PST)
Message-ID: <dcf789a4-cff0-4140-b42a-d20b16efb5c5@redhat.com>
Date: Mon, 12 Feb 2024 12:39:16 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] mm/mmu_gather: improve cond_resched() handling
 with large folios and expensive page freeing
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Michal Hocko <mhocko@suse.com>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240209221509.585251-1-david@redhat.com>
 <20240209221509.585251-10-david@redhat.com>
 <f1578e92-4de0-4718-bf79-ec29e9a19fe0@arm.com>
 <6c66f7ca-4b14-4bbb-bf06-e81b3481b03f@redhat.com>
 <590946ad-a538-4c99-947f-93455c2d96c6@arm.com>
 <e6774e16-90c0-4fba-9b9c-98de803fc920@redhat.com>
 <66ca6c58-1983-494f-b920-140be736f1d8@redhat.com>
 <398991e6-d09d-4f47-a110-4ff1e8356b6e@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <398991e6-d09d-4f47-a110-4ff1e8356b6e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.24 12:21, Ryan Roberts wrote:
> On 12/02/2024 11:05, David Hildenbrand wrote:
>> On 12.02.24 11:56, David Hildenbrand wrote:
>>> On 12.02.24 11:32, Ryan Roberts wrote:
>>>> On 12/02/2024 10:11, David Hildenbrand wrote:
>>>>> Hi Ryan,
>>>>>
>>>>>>> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>>>>> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>>>>>>>      {
>>>>>>> -    struct mmu_gather_batch *batch;
>>>>>>> -
>>>>>>> -    for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>>>>>>> -        struct encoded_page **pages = batch->encoded_pages;
>>>>>>> +    struct encoded_page **pages = batch->encoded_pages;
>>>>>>> +    unsigned int nr, nr_pages;
>>>>>>>      +    /*
>>>>>>> +     * We might end up freeing a lot of pages. Reschedule on a regular
>>>>>>> +     * basis to avoid soft lockups in configurations without full
>>>>>>> +     * preemption enabled. The magic number of 512 folios seems to work.
>>>>>>> +     */
>>>>>>> +    if (!page_poisoning_enabled_static() && !want_init_on_free()) {
>>>>>>
>>>>>> Is the performance win really worth 2 separate implementations keyed off this?
>>>>>> It seems a bit fragile, in case any other operations get added to free
>>>>>> which are
>>>>>> proportional to size in future. Why not just always do the conservative
>>>>>> version?
>>>>>
>>>>> I really don't want to iterate over all entries on the "sane" common case. We
>>>>> already do that two times:
>>>>>
>>>>> a) free_pages_and_swap_cache()
>>>>>
>>>>> b) release_pages()
>>>>>
>>>>> Only the latter really is required, and I'm planning on removing the one in (a)
>>>>> to move it into (b) as well.
>>>>>
>>>>> So I keep it separate to keep any unnecessary overhead to the setups that are
>>>>> already terribly slow.
>>>>>
>>>>> No need to iterate a page full of entries if it can be easily avoided.
>>>>> Especially, no need to degrade the common order-0 case.
>>>>
>>>> Yeah, I understand all that. But given this is all coming from an array, (so
>>>> easy to prefetch?) and will presumably all fit in the cache for the common case,
>>>> at least, so its hot for (a) and (b), does separating this out really make a
>>>> measurable performance difference? If yes then absolutely this optimizaiton
>>>> makes sense. But if not, I think its a bit questionable.
>>>
>>> I primarily added it because
>>>
>>> (a) we learned that each cycle counts during mmap() just like it does
>>> during fork().
>>>
>>> (b) Linus was similarly concerned about optimizing out another batching
>>> walk in c47454823bd4 ("mm: mmu_gather: allow more than one batch of
>>> delayed rmaps"):
>>>
>>> "it needs to walk that array of pages while still holding the page table
>>> lock, and our mmu_gather infrastructure allows for batching quite a lot
>>> of pages.  We may have thousands on pages queued up for freeing, and we
>>> wanted to walk only the last batch if we then added a dirty page to the
>>> queue."
>>>
>>> So if it matters enough for reducing the time we hold the page table
>>> lock, it surely adds "some" overhead in general.
>>>
>>>
>>>>
>>>> You're the boss though, so if your experience tells you this is neccessary, then
>>>> I'm ok with that.
>>>
>>> I did not do any measurements myself, I just did that intuitively as
>>> above. After all, it's all pretty straight forward (keeping the existing
>>> logic, we need a new one either way) and not that much code.
>>>
>>> So unless there are strong opinions, I'd just leave the common case as
>>> it was, and the odd case be special.
>>
>> I think we can just reduce the code duplication easily:
>>
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index d175c0f1e2c8..99b3e9408aa0 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -91,18 +91,21 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct
>> vm_area_struct *vma)
>>   }
>>   #endif
>>   
>> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>> -{
>> -    struct mmu_gather_batch *batch;
>> +/*
>> + * We might end up freeing a lot of pages. Reschedule on a regular
>> + * basis to avoid soft lockups in configurations without full
>> + * preemption enabled. The magic number of 512 folios seems to work.
>> + */
>> +#define MAX_NR_FOLIOS_PER_FREE        512
>>   
>> -    for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>> -        struct encoded_page **pages = batch->encoded_pages;
>> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>> +{
>> +    struct encoded_page **pages = batch->encoded_pages;
>> +    unsigned int nr, nr_pages;
>>   
>> -        while (batch->nr) {
>> -            /*
>> -             * limit free batch count when PAGE_SIZE > 4K
>> -             */
>> -            unsigned int nr = min(512U, batch->nr);
>> +    while (batch->nr) {
>> +        if (!page_poisoning_enabled_static() && !want_init_on_free()) {
>> +            nr = min(MAX_NR_FOLIOS_PER_FREE, batch->nr);
>>   
>>               /*
>>                * Make sure we cover page + nr_pages, and don't leave
>> @@ -111,14 +114,39 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>               if (unlikely(encoded_page_flags(pages[nr - 1]) &
>>                        ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>>                   nr++;
>> +        } else {
>> +            /*
>> +             * With page poisoning and init_on_free, the time it
>> +             * takes to free memory grows proportionally with the
>> +             * actual memory size. Therefore, limit based on the
>> +             * actual memory size and not the number of involved
>> +             * folios.
>> +             */
>> +            for (nr = 0, nr_pages = 0;
>> +                 nr < batch->nr && nr_pages < MAX_NR_FOLIOS_PER_FREE;
>> +                 nr++) {
>> +                if (unlikely(encoded_page_flags(pages[nr]) &
>> +                         ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>> +                    nr_pages += encoded_nr_pages(pages[++nr]);
>> +                else
>> +                    nr_pages++;
>> +            }
>> +        }
>>   
>> -            free_pages_and_swap_cache(pages, nr);
>> -            pages += nr;
>> -            batch->nr -= nr;
>> +        free_pages_and_swap_cache(pages, nr);
>> +        pages += nr;
>> +        batch->nr -= nr;
>>   
>> -            cond_resched();
>> -        }
>> +        cond_resched();
>>       }
>> +}
>> +
>> +static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>> +{
>> +    struct mmu_gather_batch *batch;
>> +
>> +    for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
>> +        __tlb_batch_free_encoded_pages(batch);
>>       tlb->active = &tlb->local;
>>   }
>>   
> 
> Yes this is much cleaner IMHO! I don't think putting the poison and init_on_free
> checks inside the while loops should make a whole lot of difference - you're
> only going round that loop once in the common (4K pages) case.

Exactly.

> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks, this is the full patch, including the extended patch
description:


 From 5518fb32b950154794380d029eef8751af8c9804 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 9 Feb 2024 18:43:11 +0100
Subject: [PATCH] mm/mmu_gather: improve cond_resched() handling with large
  folios and expensive page freeing

In tlb_batch_pages_flush(), we can end up freeing up to 512 pages or
now up to 256 folio fragments that span more than one page, before we
conditionally reschedule.

It's a pain that we have to handle cond_resched() in
tlb_batch_pages_flush() manually and cannot simply handle it in
release_pages() -- release_pages() can be called from atomic context.
Well, in a perfect world we wouldn't have to make our code more
complicated at all.

With page poisoning and init_on_free, we might now run into soft lockups
when we free a lot of rather large folio fragments, because page freeing
time then depends on the actual memory size we are freeing instead of on
the number of folios that are involved.

In the absolute (unlikely) worst case, on arm64 with 64k we will be able
to free up to 256 folio fragments that each span 512 MiB: zeroing out 128
GiB does sound like it might take a while. But instead of ignoring this
unlikely case, let's just handle it.

So, let's teach tlb_batch_pages_flush() that there are some
configurations where page freeing is horribly slow, and let's reschedule
more frequently -- similarly like we did for now before we had large folio
fragments in there. Avoid yet another loop over all encoded pages in the
common case by handling that separately.

Note that with page poisoning/zeroing, we might now end up freeing only a
single folio fragment at a time that might exceed the old 512 pages limit:
but if we cannot even free a single MAX_ORDER page on a system without
running into soft lockups, something else is already completely bogus.
Freeing a PMD-mapped THP would similarly cause trouble.

In theory, we might even free 511 order-0 pages + a single MAX_ORDER page,
effectively having to zero out 8703 pages on arm64 with 64k, translating to
~544 MiB of memory: however, if 512 MiB doesn't result in soft lockups,
544 MiB is unlikely to result in soft lockups, so we won't care about
that for the time being.

In the future, we might want to detect if handling cond_resched() is
required at all, and just not do any of that with full preemption enabled.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/mmu_gather.c | 58 ++++++++++++++++++++++++++++++++++++-------------
  1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index d175c0f1e2c8..99b3e9408aa0 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,18 +91,21 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
  }
  #endif
  
-static void tlb_batch_pages_flush(struct mmu_gather *tlb)
-{
-	struct mmu_gather_batch *batch;
+/*
+ * We might end up freeing a lot of pages. Reschedule on a regular
+ * basis to avoid soft lockups in configurations without full
+ * preemption enabled. The magic number of 512 folios seems to work.
+ */
+#define MAX_NR_FOLIOS_PER_FREE		512
  
-	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct encoded_page **pages = batch->encoded_pages;
+static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
+{
+	struct encoded_page **pages = batch->encoded_pages;
+	unsigned int nr, nr_pages;
  
-		while (batch->nr) {
-			/*
-			 * limit free batch count when PAGE_SIZE > 4K
-			 */
-			unsigned int nr = min(512U, batch->nr);
+	while (batch->nr) {
+		if (!page_poisoning_enabled_static() && !want_init_on_free()) {
+			nr = min(MAX_NR_FOLIOS_PER_FREE, batch->nr);
  
  			/*
  			 * Make sure we cover page + nr_pages, and don't leave
@@ -111,14 +114,39 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
  			if (unlikely(encoded_page_flags(pages[nr - 1]) &
  				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
  				nr++;
+		} else {
+			/*
+			 * With page poisoning and init_on_free, the time it
+			 * takes to free memory grows proportionally with the
+			 * actual memory size. Therefore, limit based on the
+			 * actual memory size and not the number of involved
+			 * folios.
+			 */
+			for (nr = 0, nr_pages = 0;
+			     nr < batch->nr && nr_pages < MAX_NR_FOLIOS_PER_FREE;
+			     nr++) {
+				if (unlikely(encoded_page_flags(pages[nr]) &
+					     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
+					nr_pages += encoded_nr_pages(pages[++nr]);
+				else
+					nr_pages++;
+			}
+		}
  
-			free_pages_and_swap_cache(pages, nr);
-			pages += nr;
-			batch->nr -= nr;
+		free_pages_and_swap_cache(pages, nr);
+		pages += nr;
+		batch->nr -= nr;
  
-			cond_resched();
-		}
+		cond_resched();
  	}
+}
+
+static void tlb_batch_pages_flush(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch;
+
+	for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
+		__tlb_batch_free_encoded_pages(batch);
  	tlb->active = &tlb->local;
  }
  
-- 
2.43.0



-- 
Cheers,

David / dhildenb


