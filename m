Return-Path: <linux-arch+bounces-5521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BF937999
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A38B20BE0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220CD1459FC;
	Fri, 19 Jul 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR6+TVxN"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F38145334
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401665; cv=none; b=YMzJr3qSo2+GtdQG7ldsGtNuhRKCjmJ988yrfl10fpR8B4Lz5jVXez9m3nZedZmOVzrzRad17X9OpqIzXX6j3+fRj6dJ5wyC6ACeqwyttsjYEqTbtglbFnjJ2Uxd3U2ywa/hNCg9QAW+UznH+rTzWz2Aji3W7nHysxMoIBAaM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401665; c=relaxed/simple;
	bh=x74t0FO6EnAFkdZO0g+pbMZIBzD6UwTLnWZfNaslDZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5UwGcitWecLvpJQvPLxMzloIKVLaqO0tVbG2ajZahf1w6Zyp8XZnFmeNLEoQbzXnLmHSvfP3lIc/MWFknp7+sE4wDaiZplYvXuBHmuNY4kEWsuSBevU/yHkq4qekqNlEByuV1Z6LUTHAmmrz2heNQF+vqBNuNHrVjZxpRmT2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR6+TVxN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721401661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Hqez4+gddnelY4DOtO/pf2QUbb3lrjCJ7TtxZBjoRk=;
	b=DR6+TVxNhQ+pnJ5TMfW2OxUNhni2We9krK710joePUW0OBJBCodBOs9eBLA5TO/3MVyJ/J
	8EGYp1K7nbRmGwUX1iQQjLsRXsbnEzjdO25YdXAXrh17tKdGCtZNnpEdJDMfPFEV8BZKS0
	vsfVcz+5/X7Jl6hmooq/3cSBg/3Bdr8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-25SvsYeuNzqiI-TcrQwaiQ-1; Fri, 19 Jul 2024 11:07:40 -0400
X-MC-Unique: 25SvsYeuNzqiI-TcrQwaiQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3687f5a2480so458277f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 08:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401659; x=1722006459;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Hqez4+gddnelY4DOtO/pf2QUbb3lrjCJ7TtxZBjoRk=;
        b=ghc+ROyaKsa4lEjfhrH93rEHymCszN1yMLnuWjHtFlvgg0fQBFt7EcCPKXadZHwIp/
         NZ5AFNMKP7yNjJUJ98vwTF20Ee1vtNWiFwLuCIhzE5yXclPBfPfKy6ETleM2xlwZYCuc
         pXN4N9Ub9SWKant+jQYubcL7m0Kt6NIdJaVchOrs+7tlYeRNhgVszJN6pRzo/CAIJCbx
         Qvuqe+nxT9ryY0mIRrqMXO6Yhu8Hsl1CrYRQq3UIVdMJG/ztSBskeNpdBzi3yeK7twNT
         P85aWi24txKU6VDpdbOEP17S2VIvpGiQ5VJJgpH4rxht8nNyvzWfUFhfJD5ixs3JoPxk
         CdjA==
X-Forwarded-Encrypted: i=1; AJvYcCVi04HmhmNTVFHld673vqGO+Hks8cnvm6NKc9LoHLKdHouwz9YixknfdTBAw+wf9srnuOlrvPtZeSSKyCIHIEF7tkpi+z46SxbtFg==
X-Gm-Message-State: AOJu0Yyb60HKL0bq84+VVG0wSsBh1a9kKImNnT/9SAQknKr7JmoZl+5R
	7HkkPp3WtMwR4JyFdlt7y65Nhtf88l0boRQ54wYKuI7ONgqKIZtj2wiN1vidNqaCjjNZ7mFE+xg
	UTa+nyDJ/eYLxJCLYsBRON5pGaDdxWL69TkpuYTRGCDEukSN60MYvUxvtiRE=
X-Received: by 2002:adf:f6c8:0:b0:367:96b9:760a with SMTP id ffacd0b85a97d-3683171fa20mr5351635f8f.41.1721401658858;
        Fri, 19 Jul 2024 08:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3kf0+DVAX3s8AIoi07dbvv+TNfmFDQl0q2xJMZuXjXyMFfWvqwQOQgw4uRzUtRYfwr43y2A==
X-Received: by 2002:adf:f6c8:0:b0:367:96b9:760a with SMTP id ffacd0b85a97d-3683171fa20mr5351603f8f.41.1721401658315;
        Fri, 19 Jul 2024 08:07:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1000:c4af:a24f:b8ba:8bbc? (p200300cbc7051000c4afa24fb8ba8bbc.dip0.t-ipconnect.de. [2003:cb:c705:1000:c4af:a24f:b8ba:8bbc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368785c58e7sm1876063f8f.0.2024.07.19.08.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 08:07:37 -0700 (PDT)
Message-ID: <96850252-a49f-4d78-a94b-a9a25e3f2bd5@redhat.com>
Date: Fri, 19 Jul 2024 17:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] arch, mm: pull out allocation of NODE_DATA to
 generic code
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 x86@kernel.org
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-6-rppt@kernel.org>
 <220da8ed-337a-4b1e-badf-2bff1d36e6c3@redhat.com>
 <Zpi-HAb7EBxrZBtK@kernel.org>
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
In-Reply-To: <Zpi-HAb7EBxrZBtK@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> -	 * Allocate node data.  Try node-local memory and then any node.
>>> -	 * Never allocate in DMA zone.
>>> -	 */
>>> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
>>> -	if (!nd_pa) {
>>> -		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
>>> -		       nd_size, nid);
>>> -		return;
>>> -	}
>>> -	nd = __va(nd_pa);
>>> -
>>> -	/* report and initialize */
>>> -	printk(KERN_INFO "NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
>>> -	       nd_pa, nd_pa + nd_size - 1);
>>> -	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
>>> -	if (tnid != nid)
>>> -		printk(KERN_INFO "    NODE_DATA(%d) on node %d\n", nid, tnid);
>>> -
>>> -	node_data[nid] = nd;
>>> -	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
>>> -
>>> -	node_set_online(nid);
>>> -}
>>> -
>>>    /**
>>>     * numa_cleanup_meminfo - Cleanup a numa_meminfo
>>>     * @mi: numa_meminfo to clean up
>>> @@ -571,6 +538,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>>>    			continue;
>>>    		alloc_node_data(nid);
>>> +		node_set_online(nid);
>>>    	}
>>
>> I can spot that we only remove a single node_set_online() call from x86.
>>
>> What about all the other architectures? Will there be any change in behavior
>> for them? Or do we simply set the nodes online later once more?
> 
> On x86 node_set_online() was a part of alloc_node_data() and I moved it
> outside so it's called right after alloc_node_data(). On other
> architectures the allocation didn't include that call, so there should be
> no difference there.

But won't their arch code try setting the nodes online at a later stage?

And I think, some architectures only set nodes online conditionally
(see most other node_set_online() calls).

Sorry if I'm confused here, but with now unconditional node_set_online(), won't
we change the behavior of other architectures?

-- 
Cheers,

David / dhildenb


