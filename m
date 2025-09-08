Return-Path: <linux-arch+bounces-13412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B8B49B13
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 22:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E4716992B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDD2DA753;
	Mon,  8 Sep 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QV5qeeFb"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A445945
	for <linux-arch@vger.kernel.org>; Mon,  8 Sep 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363317; cv=none; b=INTbJ2lSkRRZApne8+iLWNDureP7K7d3gkYWwttT6KXUTeqV1BytuG2iEU7DP1/1SlPrvFVJ/SVWB4Uxdm0Z34vWEuUkAaApwxNP3bj0qmzPKgPRcg7NFllIXH+ucriegtX/MmjBD+i/1hn19oc5pc2/ct+mAcuuQjuBPQ6YWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363317; c=relaxed/simple;
	bh=r8LseYBMJGPeDTkEIlmQA8hA/xOfBFZAF3b8Q4xzECg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDCnxLkWDV9bsb8axpZS5xr04/vD7IJsNg7831Q57GARJpzWZW5ULl7gLUO080MfM6BcdjkNMpE7z7ElTlMTP1gEEFC3/eNsAr3hNlzRRvb0nuUlPmq/C/Te9bSu1CgQ5ksYcDdFyjNiaNCcv2U6AAFU/VpDi747Dr3PCeBHoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QV5qeeFb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757363315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bxb19G3442DgWyJiqqUjcRLQKcfJrjyTTRUmwA5uVFs=;
	b=QV5qeeFbItD0syAGwVMk08sffHwjdsE8/0Aa8qzoClkysUruHONUL3uvRRQwg9NcrggeAK
	r49PZPhzCjBDJzQZuGASRVGHCTsDzAJ8NeZ0jwBT2r8UR4+/Z/c+iy5ZjxyXbhd+QshwfU
	u7OrfQF2Y0w2vdrtUMA2HDV+10lBOxU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-W9USboG_N-GuAXaiMqE-uw-1; Mon, 08 Sep 2025 16:28:33 -0400
X-MC-Unique: W9USboG_N-GuAXaiMqE-uw-1
X-Mimecast-MFC-AGG-ID: W9USboG_N-GuAXaiMqE-uw_1757363313
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so26232075e9.2
        for <linux-arch@vger.kernel.org>; Mon, 08 Sep 2025 13:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363313; x=1757968113;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bxb19G3442DgWyJiqqUjcRLQKcfJrjyTTRUmwA5uVFs=;
        b=NA/5Aua3C01T9wmK5UCsWVAKT6DGYlbadgyzEgXOEKgzXbND7tSnQbjI8myBWVPoNu
         XhKXcgB9BYr/b+e+VFZKt7ZkhCEikeYu5iNLpox+oCmWMaVU9taR7yYD88b4r9QnI7C9
         shogajNuSuwqNMqAY9RibJ+BGKDar+UWhDEu9IKg/4XX+Gjw26/W00lpW5Z/FtxnnEJs
         b6+U3ME9hRr3XC2HGWnyo9dsMgQ/9RDpSyxDv5mn3h2JbaS7XGe2rCdCDaMco6pGnrBO
         ibcY8mhW6n6za5wh0fysaU70C93hIi/s4oB4XCZ6CyKOIurwj3uepZqQv2ahaZPxxKAZ
         VFPA==
X-Forwarded-Encrypted: i=1; AJvYcCX/nV1/CoasSb7jmjAys+vSNcLLtGGQcyuCk6Eq5saz2zRQGhH+WQQTIgtjJ24aZ4lbviO0lX/b2xlx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KdtTjHj6S36xozo4bKXG/2+2VY/+i7RicRuDhFyI2WLqdaHn
	7IhzVaFsyFvUgdpCiLaObFrfUcH4eLXZq3++8XfCPifL9yrdhUpLMF7wmsWHxoZDOBNTGWsZfp6
	QJV5pxaJhafQGb49WCZNm8zBl73jJBpjjerarKJG2DVKRQD8ArYO1+4Y3GU6CnOY=
X-Gm-Gg: ASbGncs+sCQs+XPHDlHRvawFgSRfTHJi2jZIE8K9m6NY878AFgxtKSzq3yWZnd1Go6/
	2kVQtmui3MtG864vyxf5i9XSDyIXPgs/Xmca+FEk/ReJFl+tAYYGLG34LyQWuWuXXdREshFZVTT
	A31S4As47Q89EqWMt1yuFhYslVOL5DTOUUUmkiBZq/4QzhfNIbNaFSwcLiC/4PyNSMKDidNerrX
	pnuyQ1l8ikB+jdmiuCnWxF8aqwPfTKcSN37eKqQrv5VgwwppE7d7Upp7eS5lk3K6YJs+aEIlBVF
	8kbSEDVCHtKRjT0xemT/W1/pGL6zR9lJbEI6h5gTmM6Tb1/IWr3bJ5rOPPJmrTr7Cso5elE=
X-Received: by 2002:a05:600c:c4ac:b0:45b:8a6f:c6de with SMTP id 5b1f17b1804b1-45ddded4e96mr73982125e9.29.1757363312554;
        Mon, 08 Sep 2025 13:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJXsjpdhZEn7w8fFB+LV9zG6ThVcnhw68syW4sBBZ2cyLQUhMVhLuFxV2Kr3/2gkuGtxeFNQ==
X-Received: by 2002:a05:600c:c4ac:b0:45b:8a6f:c6de with SMTP id 5b1f17b1804b1-45ddded4e96mr73981545e9.29.1757363312024;
        Mon, 08 Sep 2025 13:28:32 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ae98.dip0.t-ipconnect.de. [87.161.174.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm252991295e9.13.2025.09.08.13.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 13:28:31 -0700 (PDT)
Message-ID: <fbbd4b7d-1614-4d6f-9f7c-2821f35404ae@redhat.com>
Date: Mon, 8 Sep 2025 22:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/22] mm/mshare: charge fault handling allocations to
 the mshare owner
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
 bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
 jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
 liam.howlett@oracle.com, linyongting@bytedance.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
 maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
 pcc@google.com, peterz@infradead.org, pfalcato@suse.de, rostedt@goodmis.org,
 rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
 tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz,
 vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com,
 willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-23-anthony.yznaga@oracle.com>
 <a0238ff1-3ca2-4f0b-8452-26584b531724@redhat.com>
 <3752d094-e754-4453-b404-75d92de3e364@oracle.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <3752d094-e754-4453-b404-75d92de3e364@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 21:21, Anthony Yznaga wrote:
> 
> 
> On 9/8/25 11:50 AM, David Hildenbrand wrote:
>> On 20.08.25 03:04, Anthony Yznaga wrote:
>>> When handling a fault in an mshare range, redirect charges for page
>>> tables and other allocations to the mshare owner rather than the
>>> current task.
>>>
>>
>> That looks rather weird. I would have thought there would be an easy way
>> to query the mshare owner for a given mshare mapping, and if the current
>> MM corresponds to that owner you know that you are running in the owner
>> context.
>>
>> Of course, we could have a helper like is_mshare_owner(mapping, current)
>> or sth like that.
>>
> 
> I'm not quite following you. Charges for newly faulted pages will be
> automatically directed to the mshare owner because the mshare mm will
> have its mm_owner field pointing to the owner. On the other hand,
> allocations for page table pages are handled differently.
> GFP_PGTABLE_USER causes the accounting to go through
> __memcg_kmem_charge_page() which will charge them to the memcg for the
> current task unless unless current->active_memcg is set to point to
> another memcg.

As a note, I think at some point we discussed re-routing page faults to 
the owner, so the owner can take care of all of that naturally. Is that 
what's happening here?


So, are we running into that code that we have current be another MM 
than vma->vm_mm?

Reminds me of: FOLL_REMOTE->FAULT_FLAG_REMOTE. But I guess, we don't 
take care of different accounting in that case.

Anyhow, what I meant is that you could just check whether you have a 
mshare VMA, and if so check if current is different to the mshare MM 
owner. So I don't immediately see why MMF_MSHARE is required.

-- 
Cheers

David / dhildenb


