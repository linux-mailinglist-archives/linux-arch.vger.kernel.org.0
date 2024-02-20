Return-Path: <linux-arch+bounces-2497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4D85BB62
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 13:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCC61F21FAD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB267E75;
	Tue, 20 Feb 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1WxHD1m"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEED67C42
	for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430753; cv=none; b=EkOnn/uSiGrKE7c0lALNzKhC0w7gqFT9tTiKTOqyF4Adg5APVHmuBvUrSz+I/nnGltDxxNvwadKd5xsDHEth/CiINLwZavTRXWv2VXOQkWLdUuiyo/xkxjUgJnaQsBthsVgpPFzappEen3/IeQWaNcV+BJj2FQhLbNgZJfNZC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430753; c=relaxed/simple;
	bh=2AiCAlGFhbdgPcWkQSCiR7KZ0q8cVeEaMVaZUE8Jc0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HLQjU6Y1ULb1UJsgTl8NMLQRFOq1M8Yx3LQpnNI2hXumJ7TsEVwrdHAvinLBvrBr85WfK3hPvY8N2PVqjNyy/VEGj7y3h9zn7KqxDJFWTX0bQEMiXAk4nPsPRXDTtYuWzSXcjR2uHPoq9dEMCgyM17ApWimONm4y84VKsvtMLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1WxHD1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708430750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iu9GpedBJlsb/GLStbej3IybrXKMwD/RH9TYp6z4oqs=;
	b=I1WxHD1moK4xIPGPYQJtoikKeeLLZXNT7M41F2e8NqQEz5ItAB4vHlha7SQhvIwMEuJq9M
	GAVrQOLEK3cCNbDSydJ3taEzBv8fbQg7nvziJSrw6mCH1OF5z0iCoh1ifn9DCUs/aDVXOx
	cTNjaOgJ47X0EZhwQus5Ua4x5JrTEtQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-oE4FvUT5O3SBboNG5jjyBA-1; Tue, 20 Feb 2024 07:05:48 -0500
X-MC-Unique: oE4FvUT5O3SBboNG5jjyBA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512aacf66d1so1875137e87.3
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 04:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430745; x=1709035545;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu9GpedBJlsb/GLStbej3IybrXKMwD/RH9TYp6z4oqs=;
        b=mzTaxKBfk5OzXW5XNBsCYUhemf9LvgDwZthzxXfm5r7yx09mapjFnMKfyDi9u3eRF9
         dpDwLywLz7gFaJtSe5I9dm99yzyVvgy/PZ4fENB/KVnbKOMR4lRul75ItWklWph1XvA+
         IMSBbIYlo0yDCVbgowLuJxboEuLlX1A8jl9tmOVueglzTptIvwl04vXs9SBn8IQEpBye
         4UKpaPjt3OUxrSHVTWBgNoo8FEIG8IT4WCSTgzqjeHU6mKR5Cui1C2Uua7PnyLakVIVC
         3zDcZsOOG9rl/Uob9m1iB4jW+Ara4Rolvctl5JkhfMH87MQT6HJyd3pF2hNMssuJ5xf/
         jMXA==
X-Forwarded-Encrypted: i=1; AJvYcCUD81Ks4JisPbtg+itoiiIw6hKKKaxL3uIcxlKTAjOSIsoyhWSsDWjZDGvPs7AWUhI2u4jyf+/SGyqcbEZ4g8tim82zpZWeK0U7OQ==
X-Gm-Message-State: AOJu0YxR2fG5ehyp7I2/Qr7zGOZ9gKCxoC7D27NdD3Tl4lyE14bkSY7Q
	WZH9bR/UCyVZBNlbSuuzAFxVTfzVvCincEVfh1w7tK/XlIsJrhAXeqQnch1GzDN0yq5vUY7CZc1
	TMxLOVb6jqR7BPQ3fENstZFYhY1rVcDY8iqJTGTsxRP2iVq7sQkI/S1hdERo=
X-Received: by 2002:a05:6512:744:b0:512:9de5:baf1 with SMTP id c4-20020a056512074400b005129de5baf1mr3925571lfs.34.1708430745108;
        Tue, 20 Feb 2024 04:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxJ+2mNoy1Lcu2pJ9mqEHwgefWFhQSBfjslDVflJTtuc3zB3lO25drqJE1w8Ld+hXtVWUgyw==
X-Received: by 2002:a05:6512:744:b0:512:9de5:baf1 with SMTP id c4-20020a056512074400b005129de5baf1mr3925546lfs.34.1708430744659;
        Tue, 20 Feb 2024 04:05:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id ij26-20020a056402159a00b005621bdbfdb0sm3616883edb.75.2024.02.20.04.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 04:05:44 -0800 (PST)
Message-ID: <70d77490-9036-48ac-afc9-4b976433070d@redhat.com>
Date: Tue, 20 Feb 2024 13:05:42 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64 MTE tag storage reuse - alternatives to MIGRATE_CMA
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
 eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, rppt@kernel.org,
 akpm@linux-foundation.org, peterz@infradead.org, konrad.wilk@oracle.com,
 willy@infradead.org, jgross@suse.com, hch@lst.de, geert@linux-m68k.org,
 vitaly.wool@konsulko.com, ddstreet@ieee.org, sjenning@redhat.com,
 hughd@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <ZdSMbjGf2Fj98diT@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZdSMbjGf2Fj98diT@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.24 12:26, Alexandru Elisei wrote:
> Hello,
> 

Hi!

> This is a request to discuss alternatives to the current approach for
> reusing the MTE tag storage memory for data allocations [1]. Each iteration
> of the series uncovered new issues, the latest being that memory allocation
> is being performed in atomic contexts [2]; I would like to start a
> discussion regarding possible alternative, which would integrate better
> with the memory management code.
> 
> This is a high level overview of the current approach:
> 
>   * Tag storage pages are put on the MIGRATE_CMA lists, meaning they can be
>     used for data allocations like (almost) any other page in the system.
> 
>   * When a page is allocated as tagged, the corresponding tag storage is
>     also allocated.
> 
>   * There's a static relationship between a page and the location in memory
>     where its tags are stored. Because of this, if the corresponding tag
>     storage is used for data, the tag storage page is migrated.
> 
> Although this is the most generic approach because tag storage pages are
> treated like normal pages, it has some disadvantages:
> 
>   * HW KASAN (MTE in the kernel) cannot be used. The kernel allocates memory
>     in atomic context, where migration is not possible.
> 
>   * Tag storage pages cannot be themselves tagged, and this means that all
>     CMA pages, even those which aren't tag storage, cannot be used for
>     tagged allocations.
> 
>   * Page migration is costly, and a process that uses MTE can experience
>     measurable slowdowns if the tag storage it requires is in use for data.
>     There might be ways to reduce this cost (by reducing the likelihood that
>     tag storage pages are allocated), but it cannot be completely
>     eliminated.
> 
>   * Worse yet, a userspace process can use a tag storage page in such a way
>     that migration is effectively impossible [3],[4].  A malicious process
>     can make use of this to prevent the allocation of tag storage for other
>     processes in the system, leading to a degraded experience for the
>     affected processes. Worst case scenario, progress becomes impossible for
>     those processes.
> 
> One alternative approach I'm looking at right now is cleancache. Cleancache
> was removed in v5.17 (commit 0a4ee518185e) because the only backend, the
> tmem driver, had been removed earlier (in v5.3, commit 814bbf49dcd0).
> 
> With this approach, MTE tag storage would be implemented as a driver
> backend for cleancache. When a tag storage page is needed for storing tags,
> the page would simply be dropped from the cache (cleancache_get_page()
> returns -1).

With large folios in place, we'd likely want to investigate not working 
on individual pages, but on (possibly large) folios instead.

> 
> I believe this is a very good fit for tag storage reuse, because it allows
> tag storage to be allocated even in atomic contexts, which enables MTE in
> the kernel. As a bonus, all of the changes to MM from the current approach
> wouldn't be needed, as tag storage allocation can be handled entirely in
> set_ptes_at(), copy_*highpage() or arch_swap_restore().
> 
> Is this a viable approach that would be upstreamable? Are there other
> solutions that I haven't considered? I'm very much open to any alternatives
> that would make tag storage reuse viable.

As raised recently, I had similar ideas with something like virtio-mem 
in the past (wanted to call it virtio-tmem back then), but didn't have 
time to look into it yet.

I considered both, using special device memory as "cleancache" backend, 
and using it as backend storage for something similar to zswap. We would 
not need a memmap/"struct page" for that special device memory, which 
reduces memory overhead and makes "adding more memory" a more reliable 
operation.

Using it as "cleancache" backend does make some things a lot easier.

The idea would be to provide a variable amount of additional memory to a 
VM, that can be reclaimed easily and reliably on demand.

The details are a bit more involved, but in essence, imagine a special 
physical memory region that is provided by a the hypervisor via a device 
to the VM. A virtio device "owns" that region and the driver manages it, 
based on requests from the hypervisor.

Similar to virtio-mem, there are ways for the hypervisor to request 
changes to the memory consumption of a device (setting the requested 
size). So when requested to consume less, clean pagecache pages can be 
dropped and the memory can be handed back to the hypervisor.

Of course, likely we would want to consider using "slower" memory in the 
hypervisor to back such a device.

I also thought about better integrating memory reclaim in the 
hypervisor, similar to "MADV_FREE" semantic way. One idea I had was that 
the memory provided by the device might have "special" semantics (as if 
the memory is always marked MADV_FREE), whereby the hypervisor could 
reclaim+discard any memory in that region any time, and the driver would 
have ways to get notified about that, or detect that reclaim happened.

I learned that there are cases where data that is significantly larger 
than main memory might be read repeatedly. As long as there is free 
memory in the hypervisor, it could be used as a cache for clean 
pagecache pages. In contrast to memory ballonning + virtio-mem, that 
memory can be easily and reliably reclaimed. And reclaiming that memory 
cannot really hurt the VM, it would only affect performance.

Long story short: what I had in mind would require similar hooks (again).

In contrast to tmem, with arm64 MTE we could get an actual supported 
cleancache backend fairly easily. I recall that tmem was abandoned in 
XEN and never really reached production quality.

-- 
Cheers,

David / dhildenb


