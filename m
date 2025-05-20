Return-Path: <linux-arch+bounces-12013-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5995CABD582
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4825317A35B
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3EF278E41;
	Tue, 20 May 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e92VqDWu"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D5274FFB
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737762; cv=none; b=cKZqGNoYjVf/VgPJ5K2r3tW2ZcY8DNCRRWOC5lD4t8ogFjXC4Y6ujQSAFvQ0DdfW2Ba7ysNaf6kLALvua2mHMFJqgsiU1QJzhl/F/FraOtRtoSlx4KhHvQVTOqHFaGr6QAvQNmr71CrYASeb5RYfzhZ58bPPq5A2mSvSWNa4aEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737762; c=relaxed/simple;
	bh=9K6dcEafmDCnZ0UsHDmmLy4rV+hSaD1LF7PQrfU49XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rH2gb2qfF/MuP2R9HihjNORYEK6usUj+tunqDbhX65wP7CQNQoxPlgpToIiRWqeQXff9m1prkFFcEWpNU6rsUZ/N4INe5445uV144fDR5/swBb+1f9wMBR2NsHRDbjz74mRbXj6wAkMejGlVMktsmA41MMsxV/xFuN99Y408y7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e92VqDWu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747737758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nojfr5VsNFL8Qg1MDovYQSmnqTQxSYHWb0zCaB+p/w8=;
	b=e92VqDWu7Z/ne1HbS9z9hwuUrfNpzVT0YUABljV9fV0R+hazQe3beAm1XEJj6uWB2LA4Vi
	FwLS5O5jWTtFEhmMSIe9DtbtEN4ncNgXZU2K8n4ozUNlNa26BqOyjcgq28UALP8YhexQ7p
	VUaGFKceGiAUTu5pT1ikKi+8+HXNRP0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-Ma4US0RyP_Oy5wKmPwexPQ-1; Tue, 20 May 2025 06:42:36 -0400
X-MC-Unique: Ma4US0RyP_Oy5wKmPwexPQ-1
X-Mimecast-MFC-AGG-ID: Ma4US0RyP_Oy5wKmPwexPQ_1747737756
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-601ed3871a1so1723633a12.1
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 03:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737756; x=1748342556;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nojfr5VsNFL8Qg1MDovYQSmnqTQxSYHWb0zCaB+p/w8=;
        b=pRlLxxkKGNul0Eg5Q+h3IfnajMm7B7CYYXF5WYi3CZ7HaHYHBNyKRUJUFFZ0yJRQtB
         ZwrAWpwwEQB8ySnSQ5mK1wLMaxILco3Bu3vBx1CY5qkgR9yuPRBsrANAyx383IF9S+bU
         w0av/bgYUPhO04q9d6PlV8nPbh7cfBj6NRAuqR6/KDiP4F+LtCBYhuX+ikVzosbjm4FS
         +OUxDFBOtcKZ5X98OFZOgX+SJtSUqxY8+MrwWT0ZI7C5EIW0jLhAph/dNCJnvzwgDdWz
         BOj1dXyMlFuf80sdjCAfJHmUc2L9RbC2YYED46ethEvoYQWsKqayKyD3Qgn7+/JnIdCb
         wCKw==
X-Forwarded-Encrypted: i=1; AJvYcCURw3ys0R8Pe3iWYtM95hCiZPARbCRAdB0ahT6JNG38W7lvu3CbyGKJ55xJ+Wm0znyvu5WQHJjR6Zag@vger.kernel.org
X-Gm-Message-State: AOJu0YwL50sz9N0V4wPE99jAfre92CDjsVcZC0TdZ18hPeeBUpW1iOE1
	GZAH5CdG83RwXI0jL33p65gWlalD9tj/Nn0zCiixTKwLujxr/FIxp371IJN32h6Lii91peoMr1a
	76lTB5VTKWQjPgo4Rk0raLyoQA1VJVgakdlA2+nWizVq3/2zsBh8rcyKos64FlHk=
X-Gm-Gg: ASbGncvCgoWVcpPJDGuNps/+rqqVnNjVbwpvd8rcQlkgyeopg0E+z3fjSkeP1SBSRIc
	dMKeB0mDDgL1ZqPVQ81VDEcYFKzUuaAdfOjuBNWaCJALr3dC6dZ02nvcRf4Ccm6ZcfI5OqEsue7
	vthq3FolIcLevAFQcpzBU4fFQ0tl0b5gBhTWx2HbwuA9huIgEmsWUHO4+8WOf4x8oKVjUp220o5
	uisBW483zt8hfrQAA+X7m/vgiupR4LPMDK6ttjaFyxgTUyAu34TULLuoc2fGhXZlGQZYT+UVd2v
	3HWcqKu636NVbuMi/pzQr1yTe01TWL+jJefORdcua0130/gjpO4Ir6GafM3NnK+NECGgnGUOt4U
	NdLuKCRX53qKBV9bzRESuJ4S9wf2TfdY3ltAKm/4=
X-Received: by 2002:a05:6402:909:b0:5fc:8c24:814d with SMTP id 4fb4d7f45d1cf-6009010e4b0mr14682781a12.14.1747737755556;
        Tue, 20 May 2025 03:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF72JLG6asx3WKUC1ArlnTTnKbaD3lNc/q/VMNC0Ggr3/RIk+McvhKUYOM2NdDznrcZzod9KQ==
X-Received: by 2002:a05:6402:909:b0:5fc:8c24:814d with SMTP id 4fb4d7f45d1cf-6009010e4b0mr14682760a12.14.1747737755052;
        Tue, 20 May 2025 03:42:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3940fsm6950223a12.74.2025.05.20.03.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:42:34 -0700 (PDT)
Message-ID: <d9456551-a3ea-454c-8832-c0530f702ce0@redhat.com>
Date: Tue, 20 May 2025 12:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm: madvise: refactor madvise_populate()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <96503fba082709bc4894ba4134f9fac1d179ba93.1747686021.git.lorenzo.stoakes@oracle.com>
 <becb11bd-e10c-4f59-9ff1-1f7acd2e1ee0@redhat.com>
 <ea17a0a6-fe19-4f0b-9899-56d39b9fbac3@lucifer.local>
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
In-Reply-To: <ea17a0a6-fe19-4f0b-9899-56d39b9fbac3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.05.25 12:36, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 12:30:24PM +0200, David Hildenbrand wrote:
>> On 19.05.25 22:52, Lorenzo Stoakes wrote:
>>> Use a for-loop rather than a while with the update of the start argument at
>>> the end of the while-loop.
>>>
>>> This is in preparation for a subsequent commit which modifies this
>>> function, we therefore separate the refactoring from the actual change
>>> cleanly by separating the two.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    mm/madvise.c | 39 ++++++++++++++++++++-------------------
>>>    1 file changed, 20 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>> index 8433ac9b27e0..63cc69daa4c7 100644
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -967,32 +967,33 @@ static long madvise_populate(struct mm_struct *mm, unsigned long start,
>>>    	int locked = 1;
>>>    	long pages;
>>> -	while (start < end) {
>>> +	for (; start < end; start += pages * PAGE_SIZE) {
>>>    		/* Populate (prefault) page tables readable/writable. */
>>>    		pages = faultin_page_range(mm, start, end, write, &locked);
>>>    		if (!locked) {
>>>    			mmap_read_lock(mm);
>>>    			locked = 1;
>>>    		}
>>> -		if (pages < 0) {
>>> -			switch (pages) {
>>> -			case -EINTR:
>>> -				return -EINTR;
>>> -			case -EINVAL: /* Incompatible mappings / permissions. */
>>> -				return -EINVAL;
>>> -			case -EHWPOISON:
>>> -				return -EHWPOISON;
>>> -			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
>>> -				return -EFAULT;
>>> -			default:
>>> -				pr_warn_once("%s: unhandled return value: %ld\n",
>>> -					     __func__, pages);
>>> -				fallthrough;
>>> -			case -ENOMEM: /* No VMA or out of memory. */
>>> -				return -ENOMEM;
>>> -			}
>>> +
>>> +		if (pages >= 0)
>>> +			continue;
>>> +
>>> +		switch (pages) {
>>> +		case -EINTR:
>>> +			return -EINTR;
>>> +		case -EINVAL: /* Incompatible mappings / permissions. */
>>> +			return -EINVAL;
>>> +		case -EHWPOISON:
>>> +			return -EHWPOISON;
>>> +		case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
>>> +			return -EFAULT;
>>> +		default:
>>> +			pr_warn_once("%s: unhandled return value: %ld\n",
>>> +				     __func__, pages);
>>> +			fallthrough;
>>> +		case -ENOMEM: /* No VMA or out of memory. */
>>> +			return -ENOMEM;
>>
>> Can we limit it to what the patch description says? "Use a for-loop rather
>> than a while", or will that be a problem for the follow-up patch?
> 
> Well, kind of the point is that we can remove a level of indentation also, which
> then makes life easier in subsequent patch.
> 
> Happy to change description or break into two (but that seems a bit over the top
> maybe? :>)

Probably just mention it, otherwise it looks a bit like unrelated churn :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


