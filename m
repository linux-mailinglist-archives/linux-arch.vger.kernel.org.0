Return-Path: <linux-arch+bounces-7776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32095993331
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A919B21222
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345F1D2711;
	Mon,  7 Oct 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBPuc2y+"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4711DB349
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318467; cv=none; b=WRxdyVE/HfR0tq/nGZiF+5SHbutgGnK7hOO24kBpdWeMG+1xBY4lks7k7LCZ38YTQ/ZAtcWZ3OUMi8gZLoRSPjBKxUV5/pm+3Sc/++JIoS/u5eJwNVbxTXPOTjKD37vuGu7qhFPfTO9rRz7mftHn6oUOGd/o/8oikj5b8pHudt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318467; c=relaxed/simple;
	bh=Q4ehC+4iij/GsMPSv4QGbIMVTb12xqpcDPPUy51JTG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYU4/1lFr+HbrT04Qrk7BsvJJRMFVfJ4u0LCrrvB1upN5GT0pBZ/G/Z9Fp4PWLADtYowmo09D3NSAgmCpjYIyDXx8RuTQrM0gl76MYXK3D9J9J393SvI4OmH1IPOO3D7I14KgCUXkAhiPS7QXsZF5lChFpPI1c+0u111VQHBK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBPuc2y+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728318464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zmZU0Mmpd44U3BbyLr7kM8wjfeGXqm1ApUSjGn76gWw=;
	b=BBPuc2y+fCt24zGdsFkkc8WlWyd1g2kHi9IhbokmU/MN3xAUqQZiNCD6v3/s8W/nYgFEo9
	FslL+aUJ4CT3GNQ04COOkIncIWpfjaXzwPe9UUD3lNxQ4j8z2SrNR/85PDXUwwFmyTne0S
	KbFU60hyArfpTCQOLskeRaXkV7y/UK4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ZMlPESqIP42Gvcjlm8yV7A-1; Mon, 07 Oct 2024 12:27:43 -0400
X-MC-Unique: ZMlPESqIP42Gvcjlm8yV7A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42e8bf0f5e8so30780875e9.2
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 09:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318462; x=1728923262;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmZU0Mmpd44U3BbyLr7kM8wjfeGXqm1ApUSjGn76gWw=;
        b=eVc5uxmad4JaBnPTZShtfDWSZ1EQDwRNrT1UjRgtmYsYfJ6qmQnQvDnluBodVkndyr
         3I/VKtccwpu1XxYU/5yWgroYOv4L20tcGQJ9LDzYFYnpf+QdA3O/L03v6d9kqdg2AW0j
         nEvzKYQTM63nxSnSHSApbQg/ZP8FoEWceV9tIF0jc47VU5F6JpSD8w98wTA75DivXUeg
         83yJqQml/WWtW8PQ+DUDY66BOy03hRgnWn5dsLug+cCXpkygVC7xvcp8bJ9vzTtaN3Hj
         T973vK5QUI6FlCJMxgJ112TTWd4v20vIXPaXOhJWyYNOwUz3Pxc8OoMnBIkz0pNzCjIK
         qQLg==
X-Forwarded-Encrypted: i=1; AJvYcCXGq1sKa8D9eGRuzUHwXUYwvOZz00AjvIDpq1Mcrd4WnMWNlRKRh5AHlLTJNEAelIsZx6QnybbRlVtp@vger.kernel.org
X-Gm-Message-State: AOJu0YzDffupDlI8agNkiijUno0XRkmhIEuPj1Rvb2YJcCJZK0MY445A
	/63iy0oOBckZB7DwsGLnrB8tQh407D3l1hlHx9kPSpgFd5BoXZIvRlGX/iVN089sNQWaucEB3e3
	197YLZfSGlfCRNf5Z+fyByT9EXVK1PE80GOaIe6fLucm7DkpfdU+XxmjusjE=
X-Received: by 2002:a05:600c:4f54:b0:42c:bde5:9082 with SMTP id 5b1f17b1804b1-42f85abed48mr93642605e9.17.1728318461877;
        Mon, 07 Oct 2024 09:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxJ2VVuoUjT5FlgW6gtTfuxQ72gAyeU0+fApv0ddKAUAIu2HVn1sSxTYG4yneDogsJj5mHag==
X-Received: by 2002:a05:600c:4f54:b0:42c:bde5:9082 with SMTP id 5b1f17b1804b1-42f85abed48mr93642395e9.17.1728318461548;
        Mon, 07 Oct 2024 09:27:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34? (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de. [2003:cb:c725:8700:77c7:bde:9446:8d34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4430esm97891055e9.37.2024.10.07.09.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 09:27:41 -0700 (PDT)
Message-ID: <7c13be04-1d18-45bd-8cfc-f5d37bd39a8e@redhat.com>
Date: Mon, 7 Oct 2024 18:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Dave Hansen <dave.hansen@intel.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, akpm@linux-foundation.org,
 willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 khalid@kernel.org
Cc: andreyknvl@gmail.com, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
 ebiederm@xmission.com, catalin.marinas@arm.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org,
 David Rientjes <rientjes@google.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
 <8c7fbaf1-61a0-4f55-8466-1ab40464d9db@redhat.com>
 <0a1678d8-0974-4783-a6f6-da85adfa1a34@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
In-Reply-To: <0a1678d8-0974-4783-a6f6-da85adfa1a34@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.10.24 17:58, Dave Hansen wrote:
> On 10/7/24 01:44, David Hildenbrand wrote:
>> On 02.10.24 19:35, Dave Hansen wrote:
>>> We were just chatting about this on David Rientjes's MM alignment call.
>>
>> Unfortunately I was not able to attend this time, my body decided it's a
>> good idea to stay in bed for a couple of days.
>>
>>> I thought I'd try to give a little brain
>>>
>>> Let's start by thinking about KVM and secondary MMUs.  KVM has a primary
>>> mm: the QEMU (or whatever) process mm.  The virtualization (EPT/NPT)
>>> tables get entries that effectively mirror the primary mm page tables
>>> and constitute a secondary MMU.  If the primary page tables change,
>>> mmu_notifiers ensure that the changes get reflected into the
>>> virtualization tables and also that the virtualization paging structure
>>> caches are flushed.
>>>
>>> msharefs is doing something very similar.  But, in the msharefs case,
>>> the secondary MMUs are actually normal CPU MMUs.  The page tables are
>>> normal old page tables and the caches are the normal old TLB.  That's
>>> what makes it so confusing: we have lots of infrastructure for dealing
>>> with that "stuff" (CPU page tables and TLB), but msharefs has
>>> short-circuited the infrastructure and it doesn't work any more.
>>
>> It's quite different IMHO, to a degree that I believe they are different
>> beasts:
>>
>> Secondary MMUs:
>> * "Belongs" to same MM context and the primary MMU (process page tables)
> 
> I think you're speaking to the ratio here.  For each secondary MMU, I
> think you're saying that there's one and only one mm_struct.  Is that right?

Yes, that is my understanding (at least with KVM). It's a secondary MMU 
derived from exactly one primary MMU (MM context -> page table hierarchy).

The sophisticated ( :) ) notifier mechanism when updating the primary 
MMU will result in keeping the secondary MMU in sync (of course, what to 
sync, and how to, depends in KVM on the memory slot that define how the 
guest physical memory layout is derived from the process virtual address 
space).

> 
>> * Maintains separate tables/PTEs, in completely separate page table
>>    hierarchy
> 
> This is the case for KVM and the VMX/SVM MMUs, but it's not generally
> true about hardware.  IOMMUs can walk x86 page tables and populate the
> IOTLB from the _same_ page table hierarchy as the CPU.

Yes, of course.

-- 
Cheers,

David / dhildenb


