Return-Path: <linux-arch+bounces-8426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB69AB687
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 21:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526F3B22DA1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFF91CB315;
	Tue, 22 Oct 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjDKrhjU"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACE1C9ED9
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624418; cv=none; b=hoA42dq78DXEB5MmrJOcmwHyDxR2KzcG2gByrcbywvyMHw+Z4BE7/XcGZNd0ABBXOh1gcj9E3LSe59uVs5LjiqGcHsvCckooO4LO2sb5ZIrjVRmlnp2f7wBJsrJeD5flX3vUeZAV4wF5OU4p7lqo+RDXP7EurhEzig3AwGHn5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624418; c=relaxed/simple;
	bh=juVarUPviZ3Y9dv25YqG6HrLREtLnb9dxD9qz28UjWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUoWtwLS5PhWO4803NbBldIZ0yibQvn3qRzZY1uuj98S5nlq6Vs+VXQSkGdEpI+gNvPdbAj93btsCyr2cuf4gsXTkyf/cnYrBE7UsAGH2f+BJiD1J8PNDzJBM0LHHRhNOxXuILuiXP9x37eeGwyoJ9h+wm8rVA0NTUoJldxIc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjDKrhjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729624415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JQB1D++mgBq6rqJS2wjNPRobEh+Vi2Q7sndX1MLqJFc=;
	b=JjDKrhjUVUl88TWLiW76PyQp75QH21IoocwoinJ1C1jGEkopRZCC+GziA16MJR0NEZpI8G
	IFNQf5mO9zydJU4J/8WsxUM9hydmByvZ6ftnZNGOlIeJiGkf1NYgCrrqACKNIbB7E3lelK
	zEr1HLDJG6QmnitW5o87NOZCtFbp/NA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Pmn7xXo9P5qIi3Lij9UbMw-1; Tue, 22 Oct 2024 15:13:33 -0400
X-MC-Unique: Pmn7xXo9P5qIi3Lij9UbMw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431673032e6so29611765e9.0
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 12:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624412; x=1730229212;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQB1D++mgBq6rqJS2wjNPRobEh+Vi2Q7sndX1MLqJFc=;
        b=OobYTFc8pWsWXiRYnfT8AGEtj07/NS83gm8ZxSSYj2Urc0jIBQvvdKheCevbqT8j8B
         N+e7r2reL0yF8jT8ynC6fof1qZ6QdpU1TYWLnkNX5wBMVQStnn5/NhmsQbG0H138bSXe
         7whjP54GsUWbDzSqNW2e/9ppdwhwsRzqTOszHKV3zOkMFyfQIHUKU3PKBdd9fAheANfA
         eesoyZFiiPPI2qhbtPtEX6DEITpu8tPqLEyfu9jzuPnorxRnwgk22BFx1JTD1MfsIYlf
         bH2o0zbc3vTS2U5Mj6KaUslhJYcNLejEMEQrAvl8eHEgbqxwI5yT+sK9VAeYxi8vYO8w
         1Jqw==
X-Forwarded-Encrypted: i=1; AJvYcCXqdy45+8Os5OgxXysaQknu0Zv+rVFxf6ekSqe//GX+lb4qekDiwXQV/sVQkar0REoabOVoUwK0l3+D@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvlajQdgQ1N/NBBGVAA9iJ/RNBi8ehaZk3sOBMfE1g0M6qpAY
	CJhOtoLQb2VSNMabdrnDh6ycglDcyfhk5erSoC6Gjo/ltmz5drMAjWbbr4uKihqmtEK+2UoaqJp
	DNlW7NrAkaJ8gYlltEU+FB65jTTEQGtcFNUiWTCbqYzzSOa695OxNZ0VjvOM=
X-Received: by 2002:a05:600c:3146:b0:431:52b7:a485 with SMTP id 5b1f17b1804b1-4318415c3f8mr1814345e9.19.1729624411960;
        Tue, 22 Oct 2024 12:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjMkppZQE3e+ZHbFlzdfNT2/fELgudA1DzF43wqQgxALikNjAl1XCDoSkp15Ycvqa/1uALew==
X-Received: by 2002:a05:600c:3146:b0:431:52b7:a485 with SMTP id 5b1f17b1804b1-4318415c3f8mr1814025e9.19.1729624411508;
        Tue, 22 Oct 2024 12:13:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072? (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de. [2003:cb:c705:f700:352b:d857:b95d:9072])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57102asm95608155e9.1.2024.10.22.12.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 12:13:31 -0700 (PDT)
Message-ID: <43dc4de2-1838-45dd-8d8f-3e5b95624c74@redhat.com>
Date: Tue, 22 Oct 2024 21:13:28 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
To: Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
 <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
 <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
 <49afa956-21e1-4b3d-9dde-82a6891f2902@redhat.com>
 <cbf17dc3-01eb-4416-8ec5-cac05e50d663@lucifer.local>
 <ef0e11c5-13cf-4d47-a277-41da317be165@redhat.com>
 <acf358a4-c503-4347-8156-9269c43bf796@lucifer.local>
 <8329667f-73b6-48fe-8f3c-07c741462fee@suse.cz>
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
In-Reply-To: <8329667f-73b6-48fe-8f3c-07c741462fee@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 19:26, Vlastimil Babka wrote:
> On 10/21/24 19:14, Lorenzo Stoakes wrote:
>> On Mon, Oct 21, 2024 at 07:00:53PM +0200, David Hildenbrand wrote:
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Also the existing logic is that existing markers (HW poison, uffd-simulated HW
>>>>>> poison, uffd wp marker) are retained and no error raised on MADV_DONTNEED, and
>>>>>> no error on MADV_FREE either, so it'd be consistent with existing behaviour.
>>>>>
>>>>>
>>>>> HW poison / uffd-simulated HW poison are expected to be zapped: it's just
>>>>> like a mapped page with HWPOISON. So that is correct.
>>>>
>>>> Well, poison is _not_ zapped on MADV_DONTNEED but _is_ on MADV_FREE :) anyway, I
>>>
>>> Huh?
>>>
>>> madvise_dontneed_single_vma()->zap_page_range_single(details=NULL)->unmap_single_vma(details=NULL)
>>> ... zap_pte_range()
>>>
>>> } else if (is_hwpoison_entry(entry) ||
>>> 	   is_poisoned_swp_entry(entry)) {
>>> 	if (!should_zap_cows(details))
>>> 		continue;
>>> 	...
>>>
>>> Should just zap them.
>>>
>>> What am I missing?
>>
>> Yeah ok it's me who's missing something here, I hadn't noticed details == NULL
>> so should_zap_cows() is true, my mistake!
> 
> Well, good to know it's consistent then. As I've explained I see why zapping
> actual hwpoison makes sense for MADV_DONTNEED/MADV_FREE. That it's done also
> for uffd poison is not completely clear, but maybe it was just easier to
> implement. 

Note that in VM context "uffd poison" really just is "this was hwpoison 
on the source VM, so we mimic that on the destination VM, because the 
data *is* lost" -- so you want the exact same behavior.

For example, when a VM reboots you might just want to ZAP these hwpoison 
entries, and get fresh pages on next access.

So to me it makes sense that they are treated equally.

-- 
Cheers,

David / dhildenb


