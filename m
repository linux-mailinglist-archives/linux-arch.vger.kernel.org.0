Return-Path: <linux-arch+bounces-1901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90219843C65
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E21F303B9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC369E16;
	Wed, 31 Jan 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qd9wuoH1"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCD6996E
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696513; cv=none; b=VsCzlFgElkwjdetvYcnef2IhwLraajMQ+2uBrcf7OpFLGmHbmbIb546N04+qUcikPfWqq0rm9W8TG2CZiwo6Xs44cvLlN3+UJuZGJ2lrnNhNqM0VLyo6nKl99rj5LF2jM7AuC6dAwJaBl8/QCO24/nuQFhtfGH0v4tzvPCPbsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696513; c=relaxed/simple;
	bh=0zqss8RvmMMUa+8cez5lYzsk4Ra0zHoNq5EeNaViwIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A29r0p2rea095CyFAiIJpIsviI00wLquYiYYLdURPrMwJaWGysvn7ZT6+UswGRq0r8QJKgP8TKkP9c7R6v4oQ55QafjRaGTStdEl/M8b0kCZCGZ60/c0rZHeU/QEPBL0zF7oXrhZiUg6GGNywDzcHwMngIsc8FRoI+skEc/aJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qd9wuoH1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706696510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=73RrgumU4dTEdpu7qb4tr6nfAzM+QJQ7avPpro2/7XU=;
	b=Qd9wuoH1QbGg/9Ad1QAdYwfCY7XlEqMrDOY4p9DHtpn0M77lEdLuPpI5DmC/QsKteknj1h
	mLjRcr6yH9BYNU2YTxo357Thx6/6oNIxPpeXxvkAeGiWdgZxr1eV7u3E2TNjMQSuSZ1b0B
	wU2KSKEuePbOzSOn0JWbRVn6zj4Ebds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-sbgcWaLTPzqpVfCYXuG1Jg-1; Wed, 31 Jan 2024 05:21:48 -0500
X-MC-Unique: sbgcWaLTPzqpVfCYXuG1Jg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40f00a86728so9720045e9.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 02:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696507; x=1707301307;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73RrgumU4dTEdpu7qb4tr6nfAzM+QJQ7avPpro2/7XU=;
        b=kP9YRomV5FqrAm3Huf+ZEpBqq64z9QN1vuo4ON08gSwNBQ/8aEnwJ8Y60d9ra2ny7t
         M0t50vEiKoYHLdcBc242tcFMkk8B3FDsef4nsxOTsYpQjmW29UE/d7Bfw0TlTANGZYvf
         SzUHrm4yrIAv8zrV6VUmsquJM2Nyy4voou+XgOGk77p5iVGL3SC9F/G5YVoHLYZZtYdw
         +TAsDH1TjgZ5YzCvTkitgLYHnzj3xw6Z4fWCusoycSLJJNzm8+t0tLPDImBboOj8p3qY
         p1x+/XgMtz3j7SnKUXGET1uToKxWaRjq5edvbft1dMnqfgO6XqRYyR0nox2aFj7P4t2I
         OZyQ==
X-Gm-Message-State: AOJu0YxB8L/QBsPdnPKnjV7G1zUqAROHYrqWZhLsHA2GkN9t1M1LsFAx
	wsvB50c4m/2sjcFnD4rcycaFP/tOjSklP/VJ7Y3ieAPWyWlp2ppyLwx8dOaWMYGqNBCyEI6voHa
	p480+gqWnbqY8w44eACRYUMCvjY7MGj/HX3vej4q8aAtnkbi0z0Pa2y2idi4=
X-Received: by 2002:a05:600c:a52:b0:40e:fb93:96a8 with SMTP id c18-20020a05600c0a5200b0040efb9396a8mr1025152wmq.34.1706696507307;
        Wed, 31 Jan 2024 02:21:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm8H+S0GPo4hPZwIvn/3ceJOMxesbZa0lUxz7PX3mJ9EcmFB1akenvSvaaMhwHJInvhGC5ww==
X-Received: by 2002:a05:600c:a52:b0:40e:fb93:96a8 with SMTP id c18-20020a05600c0a5200b0040efb9396a8mr1025123wmq.34.1706696506931;
        Wed, 31 Jan 2024 02:21:46 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b0040e4733aecbsm1134749wmp.15.2024.01.31.02.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:21:46 -0800 (PST)
Message-ID: <cf9adefc-8508-49a4-a7f0-784e345c5d80@redhat.com>
Date: Wed, 31 Jan 2024 11:21:45 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
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
 <20240129143221.263763-10-david@redhat.com>
 <bec84017-b1c9-48e7-a206-c4c8a651ee83@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bec84017-b1c9-48e7-a206-c4c8a651ee83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +
>> +#ifndef clear_full_ptes
>> +/**
>> + * clear_full_ptes - Clear PTEs that map consecutive pages of the same folio.
> 
> I know its implied from "pages of the same folio" (and even more so for the
> above variant due to mention of access/dirty), but I wonder if its useful to
> explicitly state that "all ptes being cleared are present at the time of the call"?

"Clear PTEs" -> "Clear present PTEs" ?

That should make it clearer.

[...]

>>   	if (!delay_rmap) {
>> -		folio_remove_rmap_pte(folio, page, vma);
>> +		folio_remove_rmap_ptes(folio, page, nr, vma);
>> +
>> +		/* Only sanity-check the first page in a batch. */
>>   		if (unlikely(page_mapcount(page) < 0))
>>   			print_bad_pte(vma, addr, ptent, page);
> 
> Is there a case for either removing this all together or moving it into
> folio_remove_rmap_ptes()? It seems odd to only check some pages.
> 

I really wanted to avoid another nasty loop here.

In my thinking, for 4k folios, or when zapping subpages of large folios, 
we still perform the exact same checks. Only when batching we don't. So 
if there is some problem, there are ways to get it triggered. And these 
problems are barely ever seen.

folio_remove_rmap_ptes() feels like the better place -- especially 
because the delayed-rmap handling is effectively unchecked. But in 
there, we cannot "print_bad_pte()".

[background: if we had a total mapcount -- iow cheap folio_mapcount(), 
I'd check here that the total mapcount does not underflow, instead of 
checking per-subpage]

> 
>>   	}
>> -	if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
>> +	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
>>   		*force_flush = true;
>>   		*force_break = true;
>>   	}
>>   }
>>   
>> -static inline void zap_present_pte(struct mmu_gather *tlb,
>> +/*
>> + * Zap or skip one present PTE, trying to batch-process subsequent PTEs that map
> 
> Zap or skip *at least* one... ?

Ack

-- 
Cheers,

David / dhildenb


