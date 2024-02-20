Return-Path: <linux-arch+bounces-2500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6185BE32
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 15:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FF0B26050
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9F6D1C4;
	Tue, 20 Feb 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhfWVbJ0"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A366BFBD
	for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438053; cv=none; b=dzYC0KBMhL4z+RVhsahwTdy50XLJR/lp2V+MfgdPv+9aaiT39PgEJMPLdXc6Wgwh6gERi9Bcqj3mxNxQfv51fCBYNMkZfeRfFFncuH/WQkth6pYrvgwZn8sn+jXuTxQUJxsDUFDIU9p4ZOoaCqQyJy4aPYQJKlnNX+U3lAmJuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438053; c=relaxed/simple;
	bh=E/1SUYF3tv2F1OGwxNLmQh08FWlc1Ijdbb/2R+O4kIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY4VGFO3gyAcDpVcKSNdtOn+u18TTpenU7sFMCCh+sQwxKBZWoW71ew7DSdCtVFU8H2Xl3LTp2nN5n7eYLhFxPr7eevnglTjRLynYkFXyBbl7pZ1iUES5yyZlCobh8uuP/msyGDE5JO6V7ODdjqComaX4gCzfzWIPq3heDa2ivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhfWVbJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708438050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TfSiB4xU3Pf2ASAqrc35eYDgyfR8LdcSqcXXHY4DB94=;
	b=EhfWVbJ0J4fdaB2pi4s1GMvNjKhycibQ5lqOvV1/zus5B2Ed/WG7ZTEG2aC1CIJ1+BjUUi
	QFvmpYUMYQrPMVR2hqYIt+CO2SKYkL/+v8dbPulH60mrOfw4ZN1Nr9ShXtwJgxECP0jBP3
	+CDf8ndRpldibRWCYiYolXL3DG9U1uQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-wR0wQnzJN1SdOXaToOZloQ-1; Tue, 20 Feb 2024 09:07:26 -0500
X-MC-Unique: wR0wQnzJN1SdOXaToOZloQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4126c262040so5731275e9.0
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 06:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438045; x=1709042845;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfSiB4xU3Pf2ASAqrc35eYDgyfR8LdcSqcXXHY4DB94=;
        b=k385SJgrB/rgPtGufqUOvmnD+9CprV6cO/50MAJUmucDa7hhsSt/jYKWZylxL618GE
         JjFAYO/olGvoN/F2QMY72g12Lmmf2L6zHIxPGmISoy7o8eRPPOtOgAJxjyNLKzEiYxfL
         tFzeiB+cbcwaUhEGIx8GvqO63MTDWxKSvq0JNDnChoTnY64Wwxp9jAfhAPXA0YPAUNEC
         S1Av8LrMwYZnOdyonnUu6C9ZmXBQc1mWM3ybXh5WruabLkZOMsA9cc/yuL7uUFQ8bgvR
         E9juJegurKDs+PZy7MWXIwJ+M9WnbT8/DMOkRDHb3gzNA1GmC26R5pbYUPOf8tRp+gGF
         WuPA==
X-Forwarded-Encrypted: i=1; AJvYcCWHT9YOoXTmZficwgKNz0Ad4RxHjOOBHXFJDX3rvlvejBjLeQA9MUTNrrINMsk5Q133HFmOqzk4Ou/kyYCxZ/l1PpSyRW43z6KmCQ==
X-Gm-Message-State: AOJu0Yyxcm03h15AW7bVbT6Gs+Vuy7P4KYfXjuq+I7FfS1qiHHyShyu5
	DRt6tSHPBBkWG676OczpoLd6zgLKtx17JQolXdy+/7Yz9VYpZNA+9ZMaydcmRdtnS0GIdLtb6QA
	RJgnwiNGmbqG2zQhLTDRscv9xDS/kyfLug3bqEYeu4DtipHTWVzjATwkNyYk=
X-Received: by 2002:a05:600c:1d1a:b0:411:db41:687c with SMTP id l26-20020a05600c1d1a00b00411db41687cmr15038536wms.13.1708438044742;
        Tue, 20 Feb 2024 06:07:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlgR4p8fQNVJMnd6Ba7hnMrikj+Cav2h5yCFAosFZH5KGSXqMEspMFvnQvfnQxH3EKo9l5vg==
X-Received: by 2002:a05:600c:1d1a:b0:411:db41:687c with SMTP id l26-20020a05600c1d1a00b00411db41687cmr15038492wms.13.1708438044298;
        Tue, 20 Feb 2024 06:07:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id js21-20020a05600c565500b0040fdb244485sm14558144wmb.40.2024.02.20.06.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 06:07:23 -0800 (PST)
Message-ID: <e0b7c884-4345-44b1-b8c0-2711a28a980e@redhat.com>
Date: Tue, 20 Feb 2024 15:07:22 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZdSojvNyaqli2rWE@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> With large folios in place, we'd likely want to investigate not working on
>> individual pages, but on (possibly large) folios instead.
> 
> Yes, that would be interesting. Since the backend has no way of controlling
> what tag storage page will be needed for tags, and subsequently dropped
> from the cache, we would have to figure out what to do if one of the pages
> that is part of a large folio is dropped. The easiest solution that I can
> see is to remove the entire folio from the cleancache, but that would mean
> also dropping the rest of the pages from the folio unnecessarily.

Right, but likely that won't be an issue. Things get interesting when 
thinking about an efficient allocation approach.

> 
>>
>>>
>>> I believe this is a very good fit for tag storage reuse, because it allows
>>> tag storage to be allocated even in atomic contexts, which enables MTE in
>>> the kernel. As a bonus, all of the changes to MM from the current approach
>>> wouldn't be needed, as tag storage allocation can be handled entirely in
>>> set_ptes_at(), copy_*highpage() or arch_swap_restore().
>>>
>>> Is this a viable approach that would be upstreamable? Are there other
>>> solutions that I haven't considered? I'm very much open to any alternatives
>>> that would make tag storage reuse viable.
>>
>> As raised recently, I had similar ideas with something like virtio-mem in
>> the past (wanted to call it virtio-tmem back then), but didn't have time to
>> look into it yet.
>>
>> I considered both, using special device memory as "cleancache" backend, and
>> using it as backend storage for something similar to zswap. We would not
>> need a memmap/"struct page" for that special device memory, which reduces
>> memory overhead and makes "adding more memory" a more reliable operation.
> 
> Hm... this might not work with tag storage memory, the kernel needs to
> perform cache maintenance on the memory when it transitions to and from
> storing tags and storing data, so the memory must be mapped by the kernel.

The direct map will definitely be required I think (copy in/out data). 
But memmap for tag memory will likely not be required. Of course, it 
depends how to manage tag storage. Likely we have to store some 
metadata, hopefully we can avoid the full memmap and just use something 
else.

[...]

>> Similar to virtio-mem, there are ways for the hypervisor to request changes
>> to the memory consumption of a device (setting the requested size). So when
>> requested to consume less, clean pagecache pages can be dropped and the
>> memory can be handed back to the hypervisor.
>>
>> Of course, likely we would want to consider using "slower" memory in the
>> hypervisor to back such a device.
> 
> I'm not sure how useful that will be with tag storage reuse. KVM must
> assume that **all** the memory that the guest uses is tagged and it needs
> tag storage allocated (it's a known architectural limitation), so that will
> leave even less tag storage memory to distribute between the host and the
> guest(s).

Yes, I don't think this applies to tag storage.

> 
> Adding to that, at the moment Android is going to be the major (only?) user
> of tag storage reuse, and as far as I know pKVM is more restrictive with
> regards to the emulated devices and the memory that is shared between
> guests and the host.

Right, what I described here does not have overlap with tag storage 
besides requiring similar (cleancache) hooks.

-- 
Cheers,

David / dhildenb


