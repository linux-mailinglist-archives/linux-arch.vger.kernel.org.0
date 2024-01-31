Return-Path: <linux-arch+bounces-1906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF4843D0A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BB71C2246D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F069DED;
	Wed, 31 Jan 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUwG5w5A"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6869D2E
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697797; cv=none; b=TEwY2sPnuIHnro1SLVHfQBvZoc0yUtOs2STpWVGkAudLY4XaTiJ/Xvq9Tfj9vGE9y/D5lGHqULWMxrhdb+DjeLv4Pxll/7wCYGQjV+XmQs3jBNsSAp8FVFl3UI3/Hd6TPTNESvHVtwCDvuS0mc4AgYWe+m58blqW1Q8zDtJ8Qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697797; c=relaxed/simple;
	bh=VKdh5ojB9n4H1igdsHNgzeWTEn+XBSJ7faZ2IWNWiks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f08kuJoktAmYCJuDcoRaSEQvuQLhAb2wlJ7yDewvEP9f0+UsnuQ7eqxbqre6qIs6gLEPvV7dzZv7NkhGvmEp969ZVGOkgpNvh1bUZMNkzkBVk0kG/1UwYelMCKWhHS+MAhIycoeCbWSamhht2smG6hfFVgQhuZFAHqBemIs4U9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUwG5w5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706697794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SHlw8k+TqYX0IO/Wrb506XALAVZ388XuzsT+3MrGA+U=;
	b=jUwG5w5AKRiIV8C4C5gg4vrMdzgWUOvCgGQ/KOqycM7Dcd7PO5b4ivW2im5mQLdBMN9W9D
	CRNzQCuSWB79+J0PZgtoqYEvz7X1SHmZjfmKVhJtEeks5NqpAOGTGBe5XkUUdTfBU0agyB
	tJaxQbFBDMPaILB5pZUnNkJiSX7loWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-5tvAc0FUNBW6kmx3iN2E8w-1; Wed, 31 Jan 2024 05:43:11 -0500
X-MC-Unique: 5tvAc0FUNBW6kmx3iN2E8w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso35893055e9.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 02:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706697789; x=1707302589;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHlw8k+TqYX0IO/Wrb506XALAVZ388XuzsT+3MrGA+U=;
        b=esVgYVUZj/KVg4+bV2ABD3mmzqzmiJVsIGKUvZNRV+52JVa+7rJjRgYo3/swNBtwK2
         1J/vtqyqGX+CDrRaIm5Uaqx27ziYOlBSkN7pzZQszxN/LsZlkrCC5JFdu4Ts94qBrokg
         Xl9XqxCyecuVkWG90hvfNLLlMN//fHLSjTmNJbCiWAXH7i69grINepRZ1hAymuWlpm0Q
         VQ6jSl2wI5VmU+VXRoeS8g05kde2GBVNHgleiWljx1HrlLGDbMRQIJo2clc84RDeXYPD
         np0wm0Ijz7orjKqsWCRTnCNjKQ4arETjVcubswCHvjyuKinhClA02Y2iFkYLyTO6rvBN
         kDuQ==
X-Gm-Message-State: AOJu0YzyO/EteMbAAI8YcWq/CouorGuLoazj6sMkhPFicEAGUPB7lt2U
	TQk6hBxAgDq3qnWufRXlZp845B9hjUsgoUGvxxSGU8SxmMkNAcBXpWJA20OUHgS+9okV7II5MB/
	O16g8p1RnrNBNaIteWYHQhctT5wfvmVJ6ptfCV1IjA1fT9mM0077FPIuDnQg=
X-Received: by 2002:a05:600c:3b09:b0:40e:f693:94dc with SMTP id m9-20020a05600c3b0900b0040ef69394dcmr952903wms.11.1706697789722;
        Wed, 31 Jan 2024 02:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgo7ZkvZKUZr4U69FQrkPfyz/lh2lKintb7qLUXFgEQCuMxTc504c6nJpvameaJYiG+lMkUA==
X-Received: by 2002:a05:600c:3b09:b0:40e:f693:94dc with SMTP id m9-20020a05600c3b0900b0040ef69394dcmr952894wms.11.1706697789373;
        Wed, 31 Jan 2024 02:43:09 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c021700b0040efb8f7158sm1192334wmi.15.2024.01.31.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:43:09 -0800 (PST)
Message-ID: <3739b705-b7c7-4d1b-b97d-7e55b99f64f6@redhat.com>
Date: Wed, 31 Jan 2024 11:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
To: Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
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
 linux-s390@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
References: <20240129143221.263763-1-david@redhat.com>
 <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 03:20, Yin Fengwei wrote:
> On 1/29/24 22:32, David Hildenbrand wrote:
>> This series is based on [1] and must be applied on top of it.
>> Similar to what we did with fork(), let's implement PTE batching
>> during unmap/zap when processing PTE-mapped THPs.
>>
>> We collect consecutive PTEs that map consecutive pages of the same large
>> folio, making sure that the other PTE bits are compatible, and (a) adjust
>> the refcount only once per batch, (b) call rmap handling functions only
>> once per batch, (c) perform batch PTE setting/updates and (d) perform TLB
>> entry removal once per batch.
>>
>> Ryan was previously working on this in the context of cont-pte for
>> arm64, int latest iteration [2] with a focus on arm6 with cont-pte only.
>> This series implements the optimization for all architectures, independent
>> of such PTE bits, teaches MMU gather/TLB code to be fully aware of such
>> large-folio-pages batches as well, and amkes use of our new rmap batching
>> function when removing the rmap.
>>
>> To achieve that, we have to enlighten MMU gather / page freeing code
>> (i.e., everything that consumes encoded_page) to process unmapping
>> of consecutive pages that all belong to the same large folio. I'm being
>> very careful to not degrade order-0 performance, and it looks like I
>> managed to achieve that.
> 
> One possible scenario:
> If all the folio is 2M size folio, then one full batch could hold 510M memory.
> Is it too much regarding one full batch before just can hold (2M - 4096 * 2)
> memory?

Good point, we do have CONFIG_INIT_ON_FREE_DEFAULT_ON. I don't remember 
if init_on_free or init_on_alloc was used in production systems. In 
tlb_batch_pages_flush(), there is a cond_resched() to limit the number 
of entries we process.

So if that is actually problematic, we'd run into a soft-lockup and need 
another cond_resched() [I have some faint recollection that people are 
working on removing cond_resched() completely].

One could do some counting in free_pages_and_swap_cache() (where we 
iterate all entries already) and insert cond_resched+release_pages() for 
every (e.g., 512) pages.

-- 
Cheers,

David / dhildenb


