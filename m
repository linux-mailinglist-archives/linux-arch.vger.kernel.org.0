Return-Path: <linux-arch+bounces-1829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BC841E47
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2478328A6FD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18A56B98;
	Tue, 30 Jan 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIGNfnYQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5155E68
	for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604461; cv=none; b=FlN0ZohToKU8v2eNGGqe7L4Lzcc0cUNwIPArtGBoEY2DBqBHY30+9B6/EVVRjfZS75HJdfn9M9AQ+wX+j/XeezprGDr5Kn4fkg1fR6UJeY9zI6tRJd6d1hQD4Fi5fFzzXumWnBJ8yDufK3eBKmm4aJv+CAqsdURbpMgBpeHlEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604461; c=relaxed/simple;
	bh=RQabRgKEIuNHJ6KiwLx1/vha+0obtcE1bHXLxdPBoyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnkeDUyWb8cB4c+vVodQun0U4nOZ+vs0D9ylBQR+Rpp+o71gM403/kJVC/dzx7L5lWsq5UR1gGf/eiEyxgHkxDyBDAHuwKwT9lOzLwrttYDPUoGMNCcEDJDbWeoqvHHDvzbnk51mGl8bs55DElobTF1Ipwddh2XIlttkV9QHGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIGNfnYQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706604458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TMYRcY7fcWS3U+8/mQjUjxVSWjw4nRNYWgsj2DLQnvk=;
	b=dIGNfnYQdZ5B9Nadw0JWQXdUa5T/jEapllcrfZWWlq0XJkMsJ1MDOx6hxKuG+JL2o/Eqyu
	f5yd6OFb8PfQIH++kz0SL5PL9zXT6naqX3GF2l7zfwLI4V34u/B5uIRT2jM6YbBSG+G/Az
	f4D9FD8bjb3WXYoijoWMoM7CbS9Z5Ss=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-K7PklOYfOQSxftIJTXNFiA-1; Tue, 30 Jan 2024 03:47:36 -0500
X-MC-Unique: K7PklOYfOQSxftIJTXNFiA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e530b7596so28822655e9.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 00:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604455; x=1707209255;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMYRcY7fcWS3U+8/mQjUjxVSWjw4nRNYWgsj2DLQnvk=;
        b=ryrDppQxhOqT1f40e687RSvh5pSm/NlvgUl8bZJqVLNy2ySsLwSqf6op0tI63fTcFs
         yVTSA1dAtMppl1hYiGj+KY+aRswds7hbpf3LW+V8RzfqRidMw7EENEFybe0F6VNjmuqa
         f1i1btczjjh58z4WGOpmMckt9o2AElVF+CKlzNLDuegrgHymbwaqVC53rddDv4F1kalW
         kUPpI7Vx+uYt7R5YvlgqLmv/cfnERYEnd1VThfPXqq0rEL/2xC1T+uPph/86iYUz0v16
         hQ3UqnDF0E3ET9L8pE80/XaHjkI1VdjLtvwirsaggp0AqJ8BG4rDUdb3romABIq2by36
         2T1A==
X-Gm-Message-State: AOJu0YxqnUrFZxBejzLxF//tpr/fSboFcouk3DRdx+YjuWmuk4Luh7hs
	5F57+sjT50qNaJHsbSxhp+82IPrF9bAA02vE1e8gdhJL5eqjne4UW56OvTomTRu1Eq5gL9xWFlz
	Yty6oMTZbvblfuQwNApdTuVTMLTbiDqZzuBpnfo/6MJt8wR+29Cck0jSv20E=
X-Received: by 2002:a05:600c:4711:b0:40e:f693:94dc with SMTP id v17-20020a05600c471100b0040ef69394dcmr4390238wmo.11.1706604455228;
        Tue, 30 Jan 2024 00:47:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo9os8l577gMrVODJaBcGpunOnxYAo8fevwAecPoxkMopjBuH/JdoXYu7FgIPVD/pjTKpmmg==
X-Received: by 2002:a05:600c:4711:b0:40e:f693:94dc with SMTP id v17-20020a05600c471100b0040ef69394dcmr4390221wmo.11.1706604454816;
        Tue, 30 Jan 2024 00:47:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:2700:bdf6:739b:9f9d:862f? (p200300cbc7082700bdf6739b9f9d862f.dip0.t-ipconnect.de. [2003:cb:c708:2700:bdf6:739b:9f9d:862f])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b0033af51eafc6sm2538195wrm.104.2024.01.30.00.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:47:34 -0800 (PST)
Message-ID: <fa47972e-302d-4cc7-9cdf-8251634d326a@redhat.com>
Date: Tue, 30 Jan 2024 09:47:30 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] mm/memory: further separate anon and pagecache
 folio handling in zap_present_pte()
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
 <20240129143221.263763-4-david@redhat.com>
 <40cfb242-ceb0-44c6-afe7-c1744825dc62@arm.com>
 <c783e71c-2fc0-4752-be6b-7ea316758243@redhat.com>
 <a50f2ee0-680d-4506-93f0-af22adda1b3b@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a50f2ee0-680d-4506-93f0-af22adda1b3b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.01.24 09:45, Ryan Roberts wrote:
> On 30/01/2024 08:37, David Hildenbrand wrote:
>> On 30.01.24 09:31, Ryan Roberts wrote:
>>> On 29/01/2024 14:32, David Hildenbrand wrote:
>>>> We don't need up-to-date accessed-dirty information for anon folios and can
>>>> simply work with the ptent we already have. Also, we know the RSS counter
>>>> we want to update.
>>>>
>>>> We can safely move arch_check_zapped_pte() + tlb_remove_tlb_entry() +
>>>> zap_install_uffd_wp_if_needed() after updating the folio and RSS.
>>>>
>>>> While at it, only call zap_install_uffd_wp_if_needed() if there is even
>>>> any chance that pte_install_uffd_wp_if_needed() would do *something*.
>>>> That is, just don't bother if uffd-wp does not apply.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    mm/memory.c | 16 +++++++++++-----
>>>>    1 file changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 69502cdc0a7d..20bc13ab8db2 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1552,12 +1552,9 @@ static inline void zap_present_pte(struct mmu_gather
>>>> *tlb,
>>>>        folio = page_folio(page);
>>>>        if (unlikely(!should_zap_folio(details, folio)))
>>>>            return;
>>>> -    ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>>> -    arch_check_zapped_pte(vma, ptent);
>>>> -    tlb_remove_tlb_entry(tlb, pte, addr);
>>>> -    zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
>>>>          if (!folio_test_anon(folio)) {
>>>> +        ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>>>            if (pte_dirty(ptent)) {
>>>>                folio_mark_dirty(folio);
>>>>                if (tlb_delay_rmap(tlb)) {
>>>> @@ -1567,8 +1564,17 @@ static inline void zap_present_pte(struct mmu_gather
>>>> *tlb,
>>>>            }
>>>>            if (pte_young(ptent) && likely(vma_has_recency(vma)))
>>>>                folio_mark_accessed(folio);
>>>> +        rss[mm_counter(folio)]--;
>>>> +    } else {
>>>> +        /* We don't need up-to-date accessed/dirty bits. */
>>>> +        ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>>> +        rss[MM_ANONPAGES]--;
>>>>        }
>>>> -    rss[mm_counter(folio)]--;
>>>> +    arch_check_zapped_pte(vma, ptent);
>>>
>>> Isn't the x86 (only) implementation of this relying on the dirty bit? So doesn't
>>> that imply you still need get_and_clear for anon? (And in hindsight I think that
>>> logic would apply to the previous patch too?)
>>
>> x86 uses the encoding !writable && dirty to indicate special shadow stacks. That
>> is, the hw dirty bit is set by software (to create that combination), not by
>> hardware.
>>
>> So you don't have to sync against any hw changes of the hw dirty bit. What you
>> had in the original PTE you read is sufficient.
>>
> 
> Right, got it. In that case:

Thanks a lot for paying that much attention during your reviews! Highly 
appreciated!

> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> 

-- 
Cheers,

David / dhildenb


