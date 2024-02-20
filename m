Return-Path: <linux-arch+bounces-2503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6285C0EF
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 17:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E581F22D03
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38587604E;
	Tue, 20 Feb 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNCbN+kt"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453167E93
	for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445794; cv=none; b=n3DBdbBz1OGf7yWjMTvXzSWcXVvlcTnHhsFeV5zBSkUhPzzDK3zsLvzHhokm2S0bTNoMFjI6dpuPAjc+ATsKpXCexTRZa2NN1vxn0hIV+JYCdCok+sP5iBcieFJK0cjoJQmUrt71gkr3LstoSPoc3DXlgq0kPSVX61hT1nRUBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445794; c=relaxed/simple;
	bh=fNl6lyUOgKohGJ/1RBxQXDRKPck/JiqdyAkP4q6KSXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIKoxbA2fJsmH0Ev7BgiPCVvNyHBlCMXJHKus4i2xkT4cZvpq209Q2pqfgL2zm/3NFqSEpHFRnLfY+AiLdbBjW32G03FERBzepFKemgtutN6gt8kgogjfuYAzIsIxSeqPH+zinGeMi0VG4UKkSKBNL/9RsykenTR9BP4v9jublo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNCbN+kt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708445791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IOkv4G8oqZhiLY6yORFNZFfraVFQ5rLm5lw21cNN9CU=;
	b=KNCbN+kt2mHZ1AhXHeTk8OxJKn0Y070Hx1KWWpNg0pYiDkMcJvZIuJ8QrOAAX+8P2qRcwB
	YN/Be6KdkYAIem3/bcfr+RnquPn25kYKqvmoefq2Xkp3HNZtvMmqGnrcD3N77tFHxnuLum
	mvGqxNzmjev8drJUT9OSmkWGMzw1vLg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-KfJaq65yOYSX8o7BLzm_zA-1; Tue, 20 Feb 2024 11:16:30 -0500
X-MC-Unique: KfJaq65yOYSX8o7BLzm_zA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-410e6b59df4so32338465e9.3
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 08:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708445788; x=1709050588;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOkv4G8oqZhiLY6yORFNZFfraVFQ5rLm5lw21cNN9CU=;
        b=CGoINTVV1zto+10RFPCFiKupzgbBdzAVs1Th9+eyZnTJW61kk2RvMnzzDfoY/9Xlcp
         NkJYW1njmcvL+1rxqgTYRnPQCYr50W/qEQNIs7Buh1mNBmhd8DdhQcf7CojYEQlG6+Uj
         mNrrYQnT6dLkTM+N0CE/LnI2CFptJ9SRNJpgXOiVmeI89zbbjhZZttEQBNPIQvV8hjKA
         Wo9M1ouo5HruoAk0VNZ9MWVnzLXT/EiumLx16Yi69UtqoTs+lrpx01IKL/aa0Ql178Lp
         Pq6xH0zjwdvD6VhWNFX8us6Et0zu2iAS6N64MaERdEQSWtHoPsbNlzvyQRKgC0HigMlW
         UDDA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Esx9NjZ+rCFxVqnk66nI7Uc67a1aXjYa4QJWlMKtWdnEXiv1+O1zhSEZpnihh1NuZzTHPxS1sWGpNAkr/DhIvfjjHVDBmkMiLg==
X-Gm-Message-State: AOJu0YzfG36p4EXS5pcsqLfPdQnC0wC1YhMZgOhM3QdVad8s2BBRDcTy
	3ePqULFx5c5FdpHEV0QOxU2+rbJTKmX/4qxC2DNkuaqXNjTT0/dMPIbM6lKLDS045qXbo55FZVr
	7Ah+IsgTiND4pYrNNhZDHAJUjuugRKTde9z7MIbVdFJyl7/abK5s0SMftgPU=
X-Received: by 2002:a05:6000:1f04:b0:33d:546e:7882 with SMTP id bv4-20020a0560001f0400b0033d546e7882mr5566192wrb.17.1708445788594;
        Tue, 20 Feb 2024 08:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Y0Ardhjv47GyzTLmmnojFiLZn6wDAH1Folf0gVJQvKZR5tcZV+zJu/yF7l1A4ow5gGYRLg==
X-Received: by 2002:a05:6000:1f04:b0:33d:546e:7882 with SMTP id bv4-20020a0560001f0400b0033d546e7882mr5566152wrb.17.1708445788167;
        Tue, 20 Feb 2024 08:16:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d4a11000000b0033cf4e47496sm13852574wrq.51.2024.02.20.08.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 08:16:27 -0800 (PST)
Message-ID: <b10d52ba-4a8d-43bd-96c1-cde848bec143@redhat.com>
Date: Tue, 20 Feb 2024 17:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64 MTE tag storage reuse - alternatives to MIGRATE_CMA
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, pcc@google.com, steven.price@arm.com,
 anshuman.khandual@arm.com, eugenis@google.com, kcc@google.com,
 hyesoo.yu@samsung.com, rppt@kernel.org, akpm@linux-foundation.org,
 peterz@infradead.org, konrad.wilk@oracle.com, willy@infradead.org,
 jgross@suse.com, hch@lst.de, geert@linux-m68k.org, vitaly.wool@konsulko.com,
 ddstreet@ieee.org, sjenning@redhat.com, hughd@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <ZdSMbjGf2Fj98diT@raptor>
 <70d77490-9036-48ac-afc9-4b976433070d@redhat.com> <ZdSojvNyaqli2rWE@raptor>
 <e0b7c884-4345-44b1-b8c0-2711a28a980e@redhat.com> <ZdTNOq9BoOoKo8bZ@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZdTNOq9BoOoKo8bZ@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>> I believe this is a very good fit for tag storage reuse, because it allows
>>>>> tag storage to be allocated even in atomic contexts, which enables MTE in
>>>>> the kernel. As a bonus, all of the changes to MM from the current approach
>>>>> wouldn't be needed, as tag storage allocation can be handled entirely in
>>>>> set_ptes_at(), copy_*highpage() or arch_swap_restore().
>>>>>
>>>>> Is this a viable approach that would be upstreamable? Are there other
>>>>> solutions that I haven't considered? I'm very much open to any alternatives
>>>>> that would make tag storage reuse viable.
>>>>
>>>> As raised recently, I had similar ideas with something like virtio-mem in
>>>> the past (wanted to call it virtio-tmem back then), but didn't have time to
>>>> look into it yet.
>>>>
>>>> I considered both, using special device memory as "cleancache" backend, and
>>>> using it as backend storage for something similar to zswap. We would not
>>>> need a memmap/"struct page" for that special device memory, which reduces
>>>> memory overhead and makes "adding more memory" a more reliable operation.
>>>
>>> Hm... this might not work with tag storage memory, the kernel needs to
>>> perform cache maintenance on the memory when it transitions to and from
>>> storing tags and storing data, so the memory must be mapped by the kernel.
>>
>> The direct map will definitely be required I think (copy in/out data). But
>> memmap for tag memory will likely not be required. Of course, it depends how
>> to manage tag storage. Likely we have to store some metadata, hopefully we
>> can avoid the full memmap and just use something else.
> 
> So I guess instead of ZONE_DEVICE I should try to use arch_add_memory()
> directly? That has the limitation that it cannot be used by a driver
> (symbol not exported to modules).
You can certainly start with something simple, and we can work on 
removing that memmap allocation later.

Maybe we have to expose new primitives in the context of such drivers. 
arch_add_memory() likely also doesn't do what you need.

I recall that we had a way of only messing with the direct map.

Last time I worked with that was in the context of memtrace
(arch/powerpc/platforms/powernv/memtrace.c)

There, we call arch_create_linear_mapping()/arch_remove_linear_mapping().

... and now my memory comes back: we never finished factoring out 
arch_create_linear_mapping/arch_remove_linear_mapping so they would be 
available on all architectures.


Your driver will be very arm64 specific, so doing it in an arm64-special 
way might be good enough initially. For example, the arm64-core could 
detect that special memory region and just statically prepare the direct 
map and not expose the memory to the buddy/allocate a memmap. Similar to 
how we handle the crashkernel/kexec IIRC (we likely do not have a direct 
map for that, though; ).

[I was also wondering if we could simply dynamically map/unmap when 
required so you can just avoid creating the entire direct map; might bot 
be the best approach performance-wise, though]

There are a bunch of details to be sorted out, but I don't consider the 
directmap/memmap side of things a big problem.

-- 
Cheers,

David / dhildenb


