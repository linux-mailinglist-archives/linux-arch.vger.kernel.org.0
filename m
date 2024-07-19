Return-Path: <linux-arch+bounces-5525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69F937A22
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1D91C215AD
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E3145B21;
	Fri, 19 Jul 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB9Ab4yp"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A013F435
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404027; cv=none; b=mMiqVoVy3I+hLazBu+8N2iUMkxaUKS2tmb9LZfuvrdZ4L79sRNLno56z7xPH73zqPP4Nxyl/FbkmUybsnTyz7mOU+6N26yyNv6W0xJaSERYmHViTIC8nN3/s85XeR19eZAOgLdu9kTmisobVugSYbTmvS5uyRjLQAbqp9RBzQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404027; c=relaxed/simple;
	bh=G/83OOXGDR4aYZm1pviJyH+6+6grR3Xuvmel6UjhP6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfabpDrvyhMokgNtHdaZNxHtzxm/bW+cjjpH5p3N1e31V86bBgGM5gIGIrJd1AFMqSy419KXp3/AVsj5aXZooadystlbHE51EBtDpgKgGkKsIs//o4dzm2rDegCBqwtgNVWXeSo6Ji4X52f0OtfzWK7+AwVsLFrTZDAKGMy5cEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HB9Ab4yp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721404024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qdg+XFgn2gowb/OLr2+FtH9LRvXkqxb4OmH6/xkelt8=;
	b=HB9Ab4ypQpqeRaAjAXWa+pPLApvGgn81TGx/J2PPJhhFsOrO4FaiuLvMgo4vqt9+lbAaB7
	2t5IpscPPBRSxWXwfvFHl2YtP1ArPBSKWho6rBIoBbYJEHI+tLKmP5Fyk9IKYTAmvr0N1C
	ztKaMXdJpg1eyIVSXSr5wd6FywAbeBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-NOCK9ISUPFmjBZugJ4MU1Q-1; Fri, 19 Jul 2024 11:47:03 -0400
X-MC-Unique: NOCK9ISUPFmjBZugJ4MU1Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4279418eb2bso12517705e9.1
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 08:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721404022; x=1722008822;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdg+XFgn2gowb/OLr2+FtH9LRvXkqxb4OmH6/xkelt8=;
        b=TVyNrhdIUYD/gsr7WWKXA2dfmHnwKQp6Ugafi2CDZ8B2Q6LOAH/X3qN7R8OKEjL992
         rzLl1ZMoP9zadWKdl3+93ZA5h10NyQltkJ+cgHhnpGyKNIY/nytXqQmPXLKDv5NJiyKy
         K83KKPg/SdfSEp2z09FwFagkHLvsbHgglbfa0ah/7sIyKODhEzoZ2yX+x51y4GpPHA7Q
         6twurtmQGy/3Ey7Fvylw08PoiaW9o5ALD2LR+06tQV2BdCyFgiFOkL0SVOPG3IV/cwzk
         uqvdDCe0c9vFO77vLMHqKiWcTbjbSXWiU/ipLNUKTHyIRBXCRJbSYlbWqmKrQdfFKXq5
         19wg==
X-Forwarded-Encrypted: i=1; AJvYcCXIMwwkA6nQzVg+Fwdedylu4tDKs41UKdm4uqf0JQUkJRB+cRfzvmqW0lrTzRKND3xTyozEgM8QEhdSvoNyKKKBMtpI8OrgBKH4uw==
X-Gm-Message-State: AOJu0YwYh8AmVhOHH9Z9lsU0Bq/hvRPQzKVakM2oxQmfZ2OuRTlEqFFe
	VTUB/iUwnuHkJcC9jGayowHBbebV9hAG1RbEIMbl8L/zYBW0Y78++smhDBj4+VDyjy5t0krcNyd
	8903b4xJMLAd1oFR3WzycmaA19mbl6yxZPP4tjp+/rjEUvgNq0EL/Xdbv4YE=
X-Received: by 2002:a05:600c:4f42:b0:425:649b:60e8 with SMTP id 5b1f17b1804b1-427c2ce4ec2mr59181075e9.18.1721404021843;
        Fri, 19 Jul 2024 08:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkk+7fVut5qcTcGBeestcx2OOs9WsAxgbfDNI+xjLXD9oXIYfigE2OZ+7D6CPvbkI1WcMoBQ==
X-Received: by 2002:a05:600c:4f42:b0:425:649b:60e8 with SMTP id 5b1f17b1804b1-427c2ce4ec2mr59180725e9.18.1721404021321;
        Fri, 19 Jul 2024 08:47:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1000:c4af:a24f:b8ba:8bbc? (p200300cbc7051000c4afa24fb8ba8bbc.dip0.t-ipconnect.de. [2003:cb:c705:1000:c4af:a24f:b8ba:8bbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d692998csm28786805e9.32.2024.07.19.08.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 08:47:00 -0700 (PDT)
Message-ID: <c4180f8b-a41f-4dd7-9a2b-f4ec0efa0dcf@redhat.com>
Date: Fri, 19 Jul 2024 17:46:58 +0200
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
 <96850252-a49f-4d78-a94b-a9a25e3f2bd5@redhat.com>
 <ZpqHniqaMxj-iDfw@kernel.org>
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
In-Reply-To: <ZpqHniqaMxj-iDfw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.07.24 17:34, Mike Rapoport wrote:
> On Fri, Jul 19, 2024 at 05:07:35PM +0200, David Hildenbrand wrote:
>>>>> -	 * Allocate node data.  Try node-local memory and then any node.
>>>>> -	 * Never allocate in DMA zone.
>>>>> -	 */
>>>>> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
>>>>> -	if (!nd_pa) {
>>>>> -		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
>>>>> -		       nd_size, nid);
>>>>> -		return;
>>>>> -	}
>>>>> -	nd = __va(nd_pa);
>>>>> -
>>>>> -	/* report and initialize */
>>>>> -	printk(KERN_INFO "NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
>>>>> -	       nd_pa, nd_pa + nd_size - 1);
>>>>> -	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
>>>>> -	if (tnid != nid)
>>>>> -		printk(KERN_INFO "    NODE_DATA(%d) on node %d\n", nid, tnid);
>>>>> -
>>>>> -	node_data[nid] = nd;
>>>>> -	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
>>>>> -
>>>>> -	node_set_online(nid);
>>>>> -}
>>>>> -
>>>>>     /**
>>>>>      * numa_cleanup_meminfo - Cleanup a numa_meminfo
>>>>>      * @mi: numa_meminfo to clean up
>>>>> @@ -571,6 +538,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>>>>>     			continue;
>>>>>     		alloc_node_data(nid);
>>>>> +		node_set_online(nid);
>>>>>     	}
>>>>
>>>> I can spot that we only remove a single node_set_online() call from x86.
>>>>
>>>> What about all the other architectures? Will there be any change in behavior
>>>> for them? Or do we simply set the nodes online later once more?
>>>
>>> On x86 node_set_online() was a part of alloc_node_data() and I moved it
>>> outside so it's called right after alloc_node_data(). On other
>>> architectures the allocation didn't include that call, so there should be
>>> no difference there.
>>
>> But won't their arch code try setting the nodes online at a later stage?
>>
>> And I think, some architectures only set nodes online conditionally
>> (see most other node_set_online() calls).
>>
>> Sorry if I'm confused here, but with now unconditional node_set_online(), won't
>> we change the behavior of other architectures?
> 
> The generic alloc_node_data() does not set the node online:
> 
> +/* Allocate NODE_DATA for a node on the local memory */
> +void __init alloc_node_data(int nid)
> +{
> +	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
> +	u64 nd_pa;
> +	void *nd;
> +	int tnid;
> +
> +	/* Allocate node data.  Try node-local memory and then any node. */
> +	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	if (!nd_pa)
> +		panic("Cannot allocate %zu bytes for node %d data\n",
> +		      nd_size, nid);
> +	nd = __va(nd_pa);
> +
> +	/* report and initialize */
> +	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> +		nd_pa, nd_pa + nd_size - 1);
> +	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> +	if (tnid != nid)
> +		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
> +
> +	node_data[nid] = nd;
> +	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> +}
> 
> I might have missed some architecture except x86 that calls
> node_set_online() in its alloc_node_data(), but the intention was to leave
> that call outside the alloc and explicitly add it after the call to
> alloc_node_data() if needed like in x86.

I'm stupid, I didn't realize it is still only called from x86 :(

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


