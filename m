Return-Path: <linux-arch+bounces-12022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAFABDE5D
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D2418865C1
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D322D7A8;
	Tue, 20 May 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hitf9Jk8"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C519E968
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753740; cv=none; b=iiHNoeLYopQH1LaLlgFIM9oeYat6DAFiCkSTx8TE9Ko1rpI9OrUa/fuWDrE1iBWphBY+hud02WHi0w4gKeaKR2KjoynJNWCS1YIiJ/ALBVryzMwdKzvuqgtErbk11ZnuUvHYYvL6gENE1L8n0M1yNtoYuSjnJP7ipjkCdjwnr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753740; c=relaxed/simple;
	bh=xpvDoUvXtvvoVcinPcn6XkpZY9URU3K1MNKi0C+0AJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdf0hD6AHz7effK4EFEYBgzHx7SKQr0JoKBRWXY37kOSiSSvHu2a67BOrMwM7yMo2gPIxwvxhu61T3uostXj1eKBjVZrPfhs3P1Xcfzlo6pE2wuUT5KNI0DXH76GlTCnEIQv6mrXYbk5NwuWkZOI/jqH4zuzwlKUInGr58cCICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hitf9Jk8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747753737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=epaO6bNKyNsoX0IWpCM87KgUPBgTouaLxd4ArWgJdpw=;
	b=Hitf9Jk8DOE64DpR6Vx+abk2dEgggOHwt+rpYcaJUlLUmjImheZXMj5wOr0TFlnBoCnvNI
	Dgpabm+6KfW1uTaIfnhJhPg4FEhZFDmDioEMs2WoeLEgYPGgh2qpSxMMV02cwroLpD1UUy
	afGCSaensStpX9uqoKhFPOeVqYEZfiI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-cqNEsCkFMK2NFdF2vNp_fw-1; Tue, 20 May 2025 11:08:56 -0400
X-MC-Unique: cqNEsCkFMK2NFdF2vNp_fw-1
X-Mimecast-MFC-AGG-ID: cqNEsCkFMK2NFdF2vNp_fw_1747753735
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-441c96c1977so39432085e9.0
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 08:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753735; x=1748358535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=epaO6bNKyNsoX0IWpCM87KgUPBgTouaLxd4ArWgJdpw=;
        b=EQ6/b0qDObbuaycQuaptxEhH0AeBm7KcgPtzXsnE5JOXzNz1+twESQ3X68HLm9pZyl
         WBH7ELsiNQy8/UCvevAFXCIbdnkZGqP2+DEieGSpJ0mJKrmX+2q0zsuTo/bRvz31J0fy
         WuCedCTOzzWbLL4F0ATO4SlDVR9UDWJcbAigWwfxsyH4nUtpailfLxqkfP6ACZHNt5DH
         d1eR2TGQzOdgasvavSidsVUj7z7j+mhMU5SaJ0/VPlj5UTCucwRWE9nTe9memlml63Rg
         M7LC0Dg6/EC/2YZqeXqPqP4VtdAngtDHEtXEx2Xd+lq31zcbB6i0ZMDzSsAB1QjWrRL6
         pDxw==
X-Forwarded-Encrypted: i=1; AJvYcCVv2bOsL+/Zmmxf89YUaMswdsu7bKgyxi/b0XKlqSZUcIFL0GwTX7NwZkxHxDVcJVOXR78hUHgWNP7Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmpyBiPQ6P5hA9a6eFYdvvBslYh8Bicgsxf/qe5OQWLRK5Rko
	+tf3a22pvA0AQgnYCyyJ4ORtmbF0Dut8EU0cXjKXMuQOiBPPmocWURBAf8fkj3OEyGOCuoPCc4T
	01r0Ef5rOGdBlAzbAEJ0PbCsY9Rv9gOG9hnWroGfw1rD/qUtNE/fn2mvNvOty8omqRXauPgLpQg
	==
X-Gm-Gg: ASbGnct6RIfB6YsgSGIYjkPMYfsj7ttjH6/5g5xSA1KVj2UszGOV9u9ojpIO73oVtaf
	YewA4nGRFRUukDpL2yiai2X6Z1bdACdn/04TOQa/pCTtbgI0ALu/nrPSGIfaxCpp11VfO7dcbIq
	7pbkKPxS1kqKe9HCeH3IYDkYYIxW7Zu54NWcwchuvtZ8pJBA3M9ZXeJUdX7KdNfLKcQZ81B7+m8
	ea9u8zwXI26tvNQPR/LOvv+/BBU5UcHPhAY/rf6/gc7bl/24FK/THiz2V+OvBS6AWpKOMFC1A+1
	EyLrJ2FVaqqlkyQAczpknucGPq4Jjbrvn3wgjcz1RbF80Pc9MP9uQGbnyQyGHondvUqbglKMWCk
	QE3TWOhvg9LkNtSsd8oC7MzURxDr3tdZZJydGuXw=
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr103545005e9.20.1747753734783;
        Tue, 20 May 2025 08:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoGrGo5grh6eX5e2f6SQpDqZFQSnOqc4BjwHoXSs42N+BkoVHjIFFwv9PMXS3/isdmwsmA6w==
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr103544605e9.20.1747753734270;
        Tue, 20 May 2025 08:08:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4a3csm35883445e9.22.2025.05.20.08.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:08:53 -0700 (PDT)
Message-ID: <ff6c9ac0-dce2-4d3f-b5f7-15f8fff3379b@redhat.com>
Date: Tue, 20 May 2025 17:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: make detection of highmem_start more robust
To: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Pratyush Yadav
 <ptyadav@amazon.de>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250519171805.1288393-1-rppt@kernel.org>
 <aCw9mpmhx9SrL8Oy@localhost.localdomain>
 <d2751191-fc32-418a-8b62-dedab41d0615@redhat.com>
 <aCyaiXO7nmjC3wWj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCyaiXO7nmjC3wWj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.05.25 17:06, Mike Rapoport wrote:
> On Tue, May 20, 2025 at 11:14:28AM +0200, David Hildenbrand wrote:
>> On 20.05.25 10:30, Oscar Salvador wrote:
>>> On Mon, May 19, 2025 at 08:18:05PM +0300, Mike Rapoport wrote:
>>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>>
>>>> Pratyush Yadav reports the following crash:
>>>>
>>>>       ------------[ cut here ]------------
>>>>       kernel BUG at arch/x86/mm/physaddr.c:23!
>>>>       ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
>>>>       CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
>>>>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>>>>       RIP: 0010:__phys_addr+0x58/0x60
>>>>       Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>>>>       RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
>>>>       RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
>>>>       RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
>>>>       RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
>>>>       R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
>>>>       R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
>>>>       FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>>>>       CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>       CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
>>>>       Call Trace:
>>>>        <TASK>
>>>>        ? __cma_declare_contiguous_nid+0x6e/0x340
>>>>        ? cma_declare_contiguous_nid+0x33/0x70
>>>>        ? dma_contiguous_reserve_area+0x2f/0x70
>>>>        ? setup_arch+0x6f1/0x870
>>>>        ? start_kernel+0x52/0x4b0
>>>>        ? x86_64_start_reservations+0x29/0x30
>>>>        ? x86_64_start_kernel+0x7c/0x80
>>>>        ? common_startup_64+0x13e/0x141
>>>>
>>>>     The reason is that __cma_declare_contiguous_nid() does:
>>>>
>>>>             highmem_start = __pa(high_memory - 1) + 1;
>>>>
>>>>     If dma_contiguous_reserve_area() (or any other CMA declaration) is
>>>>     called before free_area_init(), high_memory is uninitialized. Without
>>>>     CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
>>>>     highmem_start.
>>>>
>>>> The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
>>>> free_area_init()") moved initialization of high_memory after the call to
>>>> dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
>>>> architectures.
>>>>
>>>> In the case CONFIG_HIGHMEM is enabled, some architectures that actually
>>>> support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
>>>> before a possible call to __cma_declare_contiguous_nid() and some
>>>> initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
>>>> xtensa) even before the commit e120d1bc12da so they are fine with using
>>>> uninitialized value of high_memory.
>>>>
>>>> And in the case CONFIG_HIGHMEM is disabled high_memory essentially becomes
>>>> the first address after memory end, so instead of relying on high_memory to
>>>> calculate highmem_start use memblock_end_of_DRAM() and eliminate the
>>>> dependency of CMA area creation on high_memory in majority of
>>>> configurations.
>>>>
>>>> Reported-by: Pratyush Yadav <ptyadav@amazon.de>
>>>> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>
>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>>
>>> I will note though that it is a bit akward to have highmem involved here
>>> when we might not have CONFIG_HIGHMEM enabled.
>>> I get that for !CONFIG_HIGHMEM it is a no-op situation, but still I
>>> wonder whether we could abstract that from this function.
> 
> Highmem is there for some time now (see f7426b983a6a ("mm: cma: adjust
> address limit to avoid hitting low/high memory boundary"))
> We might try abstracting it from that function but I'd prefer not doing it
> that late in the release cycle.

Agreed, assuming this will still make it into this release.

>   
>> Same thought here.
>>
>> Can't we do some IS_ENABLED(CONFIG_HIGHMEM) magic or similar to not even use
>> that variable without CONFIG_HIGHMEM?
> 
> You mean highmem_start or high_memory?

highmem_start in this function.

> 
> high_memory is one of the ways to say "end of directly/linearly addressable
> memory" and some other places in the kernel (outside arch) still use it
> regardless of CONFIG_HIGHMEM.
> 
> And I don't think we have another way to say where directly addressable
> memory ends, and this IMHO is something that should replace high_memory.

Agreed.


-- 
Cheers,

David / dhildenb


