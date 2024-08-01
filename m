Return-Path: <linux-arch+bounces-5845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47F944BBC
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5596283A48
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FC1A01DE;
	Thu,  1 Aug 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOosIZBZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAB19AD87
	for <linux-arch@vger.kernel.org>; Thu,  1 Aug 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516805; cv=none; b=oxTXlIJ6DzcZaZExFYBi4VGdHE1XTYyyenVQqsQPKj9KWPLiZQm77TWCDT9v2ma1T0WL/wDn+8WaU9WaucAUUVPl8FSfRvzWoeuU7ZTNGtbiBnObhfBKSSLrJalgoXWcH+Xg2CztL37CaAVaaqcI4Ff19Kv93EnREWFbTyTtYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516805; c=relaxed/simple;
	bh=RSXa3QrdosMXek03Kn5TJUgAyt9Pgt8CEW3Dz2q5d6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6CF3r4uyMq+Ayn+TADyxcdyvvKOGuA3FKribc3SLCYc/nC/ZBIJDLEJcSPMgTNhBAlZ4rtvzXptvseb8c+O+tdfSap4Sa6SHUwqF2AssKqKMMF8QVdKBoaIY8Vazg5weeEcjliGhGLPEKV56O+Fkl6rzmGlRcJl0fEs8DIF+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOosIZBZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722516802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tY3FTh7vOTxS/LhqhyyExp9r4gGoOfraF1glml6en7Q=;
	b=jOosIZBZGQTA8l+OiWKwMzhLzigshAK/nV9vhCJNY/NLT+TUtL17ZBj/F3NF9l/AwjmWEf
	GUH75fVn67N9cKzCJr1tlEBt1K3OsgR3HRXIaxs+6kcv3fNr2TPBNL83AsyU+YefTh/4dk
	wE5TFOLGG11KwpjnLCCQOfzUIxcdkEw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-I594v3-pP7aEM2Nr1ufIPA-1; Thu, 01 Aug 2024 08:53:20 -0400
X-MC-Unique: I594v3-pP7aEM2Nr1ufIPA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-368374dc565so3191009f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2024 05:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722516799; x=1723121599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tY3FTh7vOTxS/LhqhyyExp9r4gGoOfraF1glml6en7Q=;
        b=HgH2SCXfZ46zNKNMuZMKxkWfBHW962r100ZGJyrAqWBM0jICXYQfZvyl16o6DBvNo4
         iW1JevGVuSBey2IBo/GR2jKd2dgLDHM18Emc5ASB8v+3RhcNC71hSb8xj50CdAztqQhj
         kWJ5vPUcIMsGoToZ0aZ0tgqCKDs6wusutC5sQczB2gEsi6g2yQWrdkL6NnzpNkYJ56E5
         OFX+bKnQObj8u/J/jBtJwn+mK89QqONYdG61qmifLmx1Heln2s+D4g+bkoF3BIOHYkWW
         hmpROnDKTrQquywWlVDTYa3tusTxVv3lODvczr3KbTilH/HPY1nU/Yf4QnT3JAFL2tEq
         XuHA==
X-Forwarded-Encrypted: i=1; AJvYcCVG8SSkNm/KjMD65/pbspBarIZ0UgnX+TVNoRS67TJK/HuX3OXw7rrB5ugV6+j6JQpBZAzmTaU2OettxqNKMHOQPVpv0qx80WRvag==
X-Gm-Message-State: AOJu0YyItxSZg2nWVL35B3F/r/TY82Qtfn/2dzV9snx07XTccul7Awl+
	yl9zKZjsEnXdoAon2j1Rcw+h4pWYppVDGJmxeYkxnE1s1suCWa942/AftLE+foWLW6LAsPVqar0
	9HwHMAeV2oFImgE4o5FsGbodGksW5wTozjl4/aT+bsh/GzS5YADFjpvUMQ5o=
X-Received: by 2002:adf:ed11:0:b0:364:8568:f843 with SMTP id ffacd0b85a97d-36baaf46ff3mr1747190f8f.59.1722516799375;
        Thu, 01 Aug 2024 05:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXkQzuiBajNhJVSP5UhLjv2gX0jPjX0Kpt2L7st5acq9l3/tBwA4i709DCI0A4Sa8f6WF5tw==
X-Received: by 2002:adf:ed11:0:b0:364:8568:f843 with SMTP id ffacd0b85a97d-36baaf46ff3mr1747154f8f.59.1722516798788;
        Thu, 01 Aug 2024 05:53:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858197sm19818391f8f.68.2024.08.01.05.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 05:53:18 -0700 (PDT)
Message-ID: <bffe178c-bd97-4945-898e-97ba203f503e@redhat.com>
Date: Thu, 1 Aug 2024 14:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm: introduce MADV_DEMOTE/MADV_PROMOTE
To: Zhangrenze <zhang.renze@h3c.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "chris@zankel.net" <chris@zankel.net>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "deller@gmx.de" <deller@gmx.de>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Jiaoxupo <jiaoxupo@h3c.com>, Zhouhaofan <zhou.haofan@h3c.com>
References: <3a5785661e1b4f3381046aa5e808854c@h3c.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3a5785661e1b4f3381046aa5e808854c@h3c.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.08.24 11:57, Zhangrenze wrote:
>>> Sure, here's the Scalable Tiered Memory Control (STMC)
>>>
>>> **Background**
>>>
>>> In the era when artificial intelligence, big data analytics, and
>>> machine learning have become mainstream research topics and
>>> application scenarios, the demand for high-capacity and high-
>>> bandwidth memory in computers has become increasingly important.
>>> The emergence of CXL (Compute Express Link) provides the
>>> possibility of high-capacity memory. Although CXL TYPE3 devices
>>> can provide large memory capacities, their access speed is lower
>>> than traditional DRAM due to hardware architecture limitations.
>>>
>>> To enjoy the large capacity brought by CXL memory while minimizing
>>> the impact of high latency, Linux has introduced the Tiered Memory
>>> architecture. In the Tiered Memory architecture, CXL memory is
>>> treated as an independent, slower NUMA NODE, while DRAM is
>>> considered as a relatively faster NUMA NODE. Applications allocate
>>> memory from the local node, and Tiered Memory, leveraging memory
>>> reclamation and NUMA Balancing mechanisms, can transparently demote
>>> physical pages not recently accessed by user processes to the slower
>>> CXL NUMA NODE. However, when user processes re-access the demoted
>>> memory, the Tiered Memory mechanism will, based on certain logic,
>>> decide whether to promote the demoted physical pages back to the
>>> fast NUMA NODE. If the promotion is successful, the memory accessed
>>> by the user process will reside in DRAM; otherwise, it will reside in
>>> the CXL NODE. Through the Tiered Memory mechanism, Linux balances
>>> betweenlarge memory capacity and latency, striving to maintain an
>>> equilibrium for applications.
>>>
>>> **Problem**
>>> Although Tiered Memory strives to balance between large capacity and
>>> latency, specific scenarios can lead to the following issues:
>>>
>>>     1. In scenarios requiring massive computations, if data is heavily
>>>        stored in CXL slow memory and Tiered Memory cannot promptly
>>>        promote this memory to fast DRAM, it will significantly impact
>>>        program performance.
>>>     2. Similar to the scenario described in point 1, if Tiered Memory
>>>        decides to promote these physical pages to fast DRAM NODE, but
>>>        due to limitations in the DRAM NODE promote ratio, these physical
>>>        pages cannot be promoted. Consequently, the program will keep
>>>        running in slow memory.
>>>     3. After an application finishes computing on a large block of fast
>>>        memory, it may not immediately re-access it. Hence, this memory
>>>        can only wait for the memory reclamation mechanism to demote it.
>>>     4. Similar to the scenario described in point 3, if the demotion
>>>        speed is slow, these cold pages will occupy the promotion
>>>        resources, preventing some eligible slow pages from being
>>>        immediately promoted, severely affecting application efficiency.
>>>
>>> **Solution**
>>> We propose the **Scalable Tiered Memory Control (STMC)** mechanism,
>>> which delegates the authority of promoting and demoting memory to the
>>> application. The principle is simple, as follows:
>>>
>>>     1. When an application is preparing for computation, it can promote
>>>        the memory it needs to use or ensure the memory resides on a fast
>>>        NODE.
>>>     2. When an application will not use the memory shortly, it can
>>>        immediately demote the memory to slow memory, freeing up valuable
>>>        promotion resources.
>>>
>>> STMC mechanism is implemented through the madvise system call, providing
>>> two new advice options: MADV_DEMOTE and MADV_PROMOTE. MADV_DEMOTE
>>> advises demote the physical memory to the node where slow memory
>>> resides; this advice only fails if there is no free physical memory on
>>> the slow memory node. MADV_PROMOTE advises retaining the physical memory
>>> in the fast memory; this advice only fails if there are no promotion
>>> slots available on the fast memory node. Benefits brought by STMC
>>> include:
>>>
>>>     1. The STMC mechanism is a variant of on-demand memory management
>>>        designed to let applications enjoy fast memory as much as possible,
>>>        while actively demoting to slow memory when not in use, thus
>>>        freeing up promotion slots for the NODE and allowing it to run in
>>>        an optimized Tiered Memory environment.
>>>     2. The STMC mechanism better balances large capacity and latency.
>>>
>>> **Shortcomings of STMC**
>>> The STMC mechanism requires the caller to manage memory demotion and
>>> promotion. If the memory is not promptly demoting after an promotion,
>>> it may cause issues similar to memory leaks
>> Ehm, that sounds scary. Can you elaborate what's happening here and why
>> it is "similar to memory leaks"?
>>
>>
>> Can you also point out why migrate_pages() is not suitable? I would
>> assume demote/promote is in essence simply migrating memory between nodes.
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Thank you for the response. Below are my points of view. If there are any
> mistakes, I appreciate your understanding:
> 
> 1. In a tiered memory system, fast nodes and slow nodes act as two common
>     memory pools. The system has a certain ratio limit for promotion. For
>     example, a NODE may stipulate that when the available memory is less
>     than 1GB or 1/4 of the node's memory, promotion are prohibited. If we
>     use migrate_pages at this point, it will unrestrictedly promote slow
>     pages to fast memory, which may prevent other processes’ pages that
>     should have been promoted from being promoted. This is what I mean by
>     occupying promotion resources.
> 2. As described in point 1, if we use MADV_PROMOTE to temporarily promote
>     a batch of pages and do not demote them immediately after usage, it
>     will occupy many promotion resources. Other hot pages that need promote
>     will not be able to get promote, which will impact the performance of
>     certain processes.

So, you mean, applications can actively consume "fast memory" and 
"steal" it from other applications? I assume that's what you meant with 
"memory leak".

I would really suggest to *not* call this "similar to memory leaks", in 
your own favor ;)

> 3. MADV_DEMOTE and MADV_PROMOTE only rely on madvise, while migrate_pages
>     depends on libnuma.

Well, you can trivially call that systemcall also without libnuma ;) So 
that shouldn't really make a difference and is rather something that can 
be solved in user space.

> 4. MADV_DEMOTE and MADV_PROMOTE provide a better balance between capacity
>     and latency. They allow hot pages that need promoting to be promoted
>     smoothly and pages that need demoting to be demoted immediately. This
>     helps tiered memory systems to operate more rationally.

Can you summarize why something similar could not be provided by a 
library that builds up on existing functionality, such as migrate_pages? 
It could easily take a look at memory stats to reason whether a 
promotion/demotion makes sense (your example above with the memory 
distribution).

 From the patch itself I read

"MADV_DEMOTE can mark a range of memory pages as cold
pages and immediately demote them to slow memory. MADV_PROMOTE can mark
a range of memory pages as hot pages and immediately promote them to
fast memory"

which sounds to me like migrate_pages / MADV_COLD might be able to 
achieve something similar.

What's the biggest difference that MADV_DEMOTE|MADV_PROMOTE can do better?

-- 
Cheers,

David / dhildenb


