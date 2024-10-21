Return-Path: <linux-arch+bounces-8396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37589A9158
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B151C21B69
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490941FDFAD;
	Mon, 21 Oct 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+FA37YR"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D41CF7BF
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543068; cv=none; b=KxPzEpi1pw7HddX5ndtQKkYHOIkQmngq+I+QJiZ1AvbcsYWKCpJxRP1hgJRu3Q8KSW4BTOLHhyPc6W8oVyj2Q1lPK0nOQF4MZNXlhFIAsCTKUG4A68+a1/JAN/sDm6kNIkzjo0ZvYk3EaaJjqSuVbQ8sDUclmmmEqrdmZITYkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543068; c=relaxed/simple;
	bh=4T2FKoZ4mH+ucoOjwg7YHPEHwCt6rtp5Fs2QjggPzUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx2ehINNcSZOVE3NjbRlJulNwuCSTFwJQPT6Ig19lrAATKPwVCD8fTtqkkmn1dQkjUfpTU4U/4r2FKX+y99qSZGhg9o+A9QMmEZdWrvMoh7DsW6rck7cP5LHoFdPcDuJ8IwUaJa5EpNDr/V+kXofmlduOKM5Ifcw41UK0ebH118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+FA37YR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729543065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J0pdqvyCZGSuoD31ctx2SsdibfeZpHT/ebecW+GGQCc=;
	b=Y+FA37YRiplW47vswjcdWjRZcDkczzvL/i3YIc9Hm6Sws5ODYEWTA85/2rWsWV7Y1m6i8S
	3uOMhPBPShSHzPdtklnhJrqFlBNE+ddmDUSzYfcbA+KCWTfrjhD8yV2ZB7RJ2yndJHbmdw
	S/VHBqI4+0FfQO8kGCqz71TuTRV92Fg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-kEWlOhewOXCHWv_uPbL9Rg-1; Mon, 21 Oct 2024 16:37:44 -0400
X-MC-Unique: kEWlOhewOXCHWv_uPbL9Rg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so2566719f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543063; x=1730147863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0pdqvyCZGSuoD31ctx2SsdibfeZpHT/ebecW+GGQCc=;
        b=hEKCYv10CGkOgL6BNyeWVKxbibn+PbkQ/K5X78zCQyGwGBTDtHRubL5a+Y+2Ur3U1d
         b4cwPvgRlfffmCsD61TcQpov572S8usyJxJz7Pb1e64MARRZmCTGC/0wOve6UEdY876+
         Xa8ABRSWXW5p4+ABi5lz63HNqNPXqMNws2/ySDe1buu2trONbaZCxCuL0m6wsoNwoZyE
         6AcsHcWQRUkbVpL6DwrC157hws1eeH3/b1sjIuXAowUjzWKgprrZMPfhx/CDgK7LTn7Y
         hqNtF3uAkgNSgNysgt5JnyFpschVgxgSZHD5OB0byUkFF2X0qWWM/w0C01k/Ka94PimO
         tcNg==
X-Forwarded-Encrypted: i=1; AJvYcCU0HuAxry4I6TVOyJsxyW8uHValmA9oT/6JkrRmlPHpoFQM3mPlJtmAAQ3YjTkEVIqyThlGaKQOdzI2@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAH6Nwv6eqAqCuRE8eHPa4b1JFeZBw0+ArloY5X8fl2UEeyXE
	XPEuHDZA8crFueSi8kZW9E8cSjSc/UVBz7g5vmlonhDpb1e2cHK0zajfLZp0PB8y5jmiXcgkgS5
	s1Ipb5+CEolEpBxlJWBrw4Le5Fb1c4p2BpD5WjKAfPaZPFYivC6gjo4bdcjI=
X-Received: by 2002:adf:e643:0:b0:37d:4e20:9be0 with SMTP id ffacd0b85a97d-37eab6ebdadmr7980198f8f.51.1729543063289;
        Mon, 21 Oct 2024 13:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRpKAC5c6xVw1HVZUSluiOBC9oQK+3adL0UR00BpCUmVvqAx9WFzjCXc6djAwNuS668eKPQA==
X-Received: by 2002:adf:e643:0:b0:37d:4e20:9be0 with SMTP id ffacd0b85a97d-37eab6ebdadmr7980191f8f.51.1729543062921;
        Mon, 21 Oct 2024 13:37:42 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6747.dip0.t-ipconnect.de. [91.12.103.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a485dcsm5088945f8f.34.2024.10.21.13.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:37:41 -0700 (PDT)
Message-ID: <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
Date: Mon, 21 Oct 2024 22:37:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 22:25, Vlastimil Babka wrote:
> On 10/21/24 22:17, David Hildenbrand wrote:
>> On 21.10.24 22:11, Vlastimil Babka wrote:
>>> On 10/20/24 18:20, Lorenzo Stoakes wrote:
>>>
>>> <snip>
>>>
>>>> +static long madvise_guard_poison(struct vm_area_struct *vma,
>>>> +				 struct vm_area_struct **prev,
>>>> +				 unsigned long start, unsigned long end)
>>>> +{
>>>> +	long err;
>>>> +
>>>> +	*prev = vma;
>>>> +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>>>> +		return -EINVAL;
>>>> +
>>>> +	/*
>>>> +	 * If we install poison markers, then the range is no longer
>>>> +	 * empty from a page table perspective and therefore it's
>>>> +	 * appropriate to have an anon_vma.
>>>> +	 *
>>>> +	 * This ensures that on fork, we copy page tables correctly.
>>>> +	 */
>>>> +	err = anon_vma_prepare(vma);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	/*
>>>> +	 * Optimistically try to install the guard poison pages first. If any
>>>> +	 * non-guard pages are encountered, give up and zap the range before
>>>> +	 * trying again.
>>>> +	 */
>>>
>>> Should the page walker become powerful enough to handle this in one go? :)
>>> But sure, if it's too big a task to teach it to zap ptes with all the tlb
>>> flushing etc (I assume it's something page walkers don't do today), it makes
>>> sense to do it this way.
>>> Or we could require userspace to zap first (MADV_DONTNEED), but that would
>>> unnecessarily mean extra syscalls for the use case of an allocator debug
>>> mode that wants to turn freed memory to guards to catch use after free.
>>> So this seems like a good compromise...
>>
>> Yes please, KIS.
> 
> You mean "require userspace to zap first (MADV_DONTNEED)" ?

Yes, I see from Lorenzo's reply that there is apparently some history to 
this (maybe it's all nicely summarized in the cover letter / this patch, 
have to dig further).

Not sure yet what the problem is, I would have thought it's all 
protected by the PTL, and concurrent faults are user space doing 
something stupid and we'd detect it.

Have to do some more reading on this.

> 
> I'd normally agree with the KIS principle, but..
> 
>> We can always implement support for that later if
> 
> it would either mean later we change behavior (installing guards on
> non-zapped PTEs would have to be an error now but maybe start working later,
> which is user observable change thus can break somebody)
> 
>> really required (leave behavior open when documenting).
> 
> and leaving it open when documenting doesn't really mean anything for the
> "we don't break userspace" promise vs what the implementation actually does.

Not quite I think. You could start return -EEXIST or -EOPNOTSUPP and 
document that this can change in the future to succeed if there is 
something. User space can sense support.

Something failing that at one point starts working is not really 
breaking user space, unless someone really *wants* to fail if there is 
already something (e.g., concurrent fault -> bail out instead of hiding it).

Of course, a more elegant solution would be GUARD_INSTALL vs. 
GUARD_FORCE_INSTALL.

.. but again, there seems to be more history to this.

-- 
Cheers,

David / dhildenb


