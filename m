Return-Path: <linux-arch+bounces-8362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EA9A6EED
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9597C1F218E3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AC1CF5FE;
	Mon, 21 Oct 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaH9gEEc"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C551CEEAB
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526429; cv=none; b=R6ZbjHZNp31wm7YGc842ZlN2yGC6cfwke+0VzJ+QQZdk2fxafKOl91umqD5FUBGH8bm+1i+1Mq8oilrnmjrMrdcsBYppaG5OVC6AIm4UmW54UQrDDtUiWXLA3FB70XNNh9v7/6B1PumwCJEuiSuySWTmxi/kWj7TVmfFozx4NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526429; c=relaxed/simple;
	bh=U8P/OFCCPZoyYnSkjN2vuTZuaoFFmM2gAUQ3I1AfQYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWF8D+y8E/S0m244eD/cn/UmwqKnad0lCQ+sfSBB7mH+9xSqbp2xF7V7p9I5FKnLx/u7U30+m/Hj+jVN8w8eznSffQm/80FRnb6NLFp5AobLyTH4Ukf13qhjOac+p6cbsQJ41jAJ1K0ZVTobnmuzcLoiwM6FNI4ro4wDUDh+qnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaH9gEEc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729526426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5VsY7FPrNp4m1XJEjZKgoy8LpJYgb+68r1Vy+j6mDVY=;
	b=KaH9gEEcpRsZaTUv28CDpmilibl63T+okKfOJl/woebX5BMtuBUsgvlo1su4upCMEGLNRV
	p27feBC50FPX3g731Qg6C6NYWc1K3D7dBOQBjSBRM+yTzpXSxRCkzMiHxFo0c9i+CPQ6Zf
	XXTTrqN47cWtvqIVCd4G07Thf4fpMzw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-HsELinteMziVTLNwkY4Iiw-1; Mon, 21 Oct 2024 12:00:24 -0400
X-MC-Unique: HsELinteMziVTLNwkY4Iiw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5016d21eso1933092f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 09:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526423; x=1730131223;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VsY7FPrNp4m1XJEjZKgoy8LpJYgb+68r1Vy+j6mDVY=;
        b=Soo+4LXV39ShX3WQ82PVLFnNBeJ5uUqp7tJ35Q+WaoTWoYuOMErGGuzytJZ/5xY41D
         TQ4b4TcClubWh2u8YUGHQYlU9rTcQxGiJPa4RkQEC5iPpy/Fr5YiC6ll4wpW//AB4/ns
         Ng9/j0O3p7duAnYfCpuMrbW+gTpiaObfb8B5c7ePe54hMiNBP7T6/GhQ0pLP3eNUllZT
         YNAgi/bUnk0CysX04KXujkYTzuig3gzDKm/CkgroA6IAblhh/IlvQvyNwpDFm0MVmg70
         E4PtJluJsy0oESkI1jA+XmJ/9oYL6zPlmvZmnJ4NPl9q6piMOPneIUzndwoGXRta+bPf
         rHSw==
X-Forwarded-Encrypted: i=1; AJvYcCW/PN1G6bfBqY37lv7Sfhb13ujMThOdMPcHdxKEu0eEQEA6w0KnjK9tXDkHsvTWn5UMkPssqiuoONtX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/JwmE3tNdflPhNrJsERyWKlq9u8Sm6dOL5bPB9jso1A1qcEg
	fhzRPqGkAZbgNUCEERq+4OQEffTQDN1uOCgzzKDaQWwjWQsksS+ZOLg/7CVjoteata0wQIO3ogl
	VCVJP/pk+zHyuSXdsjNSKO6FTsSqp2VvebLMVg3NJ0qmRPD1kR6HRqWCRNyQ=
X-Received: by 2002:a5d:4d92:0:b0:37d:4527:ba1c with SMTP id ffacd0b85a97d-37eb48a0950mr8454115f8f.49.1729526423172;
        Mon, 21 Oct 2024 09:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqzeoFoaFHGhJoRGq8gloEj+8bzb49r8wGRuqyWhN1x9H9EeLTdyAQ/MXpihhxtbbMiv9R/Q==
X-Received: by 2002:a5d:4d92:0:b0:37d:4527:ba1c with SMTP id ffacd0b85a97d-37eb48a0950mr8454067f8f.49.1729526422732;
        Mon, 21 Oct 2024 09:00:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:1600:e899:f836:758b:6fef? (p200300cbc7281600e899f836758b6fef.dip0.t-ipconnect.de. [2003:cb:c728:1600:e899:f836:758b:6fef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b7dsm4645112f8f.24.2024.10.21.09.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:00:22 -0700 (PDT)
Message-ID: <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
Date: Mon, 21 Oct 2024 18:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
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
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 17:33, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 04:54:06PM +0200, Vlastimil Babka wrote:
>> On 10/21/24 16:33, Lorenzo Stoakes wrote:
>>> On Mon, Oct 21, 2024 at 04:13:34PM +0200, Vlastimil Babka wrote:
>>>> On 10/20/24 18:20, Lorenzo Stoakes wrote:
>>>>> Add a new PTE marker that results in any access causing the accessing
>>>>> process to segfault.
>>>>>
>>>>> This is preferable to PTE_MARKER_POISONED, which results in the same
>>>>> handling as hardware poisoned memory, and is thus undesirable for cases
>>>>> where we simply wish to 'soft' poison a range.
>>>>>
>>>>> This is in preparation for implementing the ability to specify guard pages
>>>>> at the page table level, i.e. ranges that, when accessed, should cause
>>>>> process termination.
>>>>>
>>>>> Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
>>>>> function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
>>>>> purpose was simply incorrect.
>>>>>
>>>>> We then reuse the same logic to determine whether a zap should clear a
>>>>> guard entry - this should only be performed on teardown and never on
>>>>> MADV_DONTNEED or the like.
>>>>
>>>> Since I would have personally put MADV_FREE among "or the like" here, it's
>>>> surprising to me that it in fact it's tearing down the guard entries now. Is
>>>> that intentional? It should be at least mentioned very explicitly. But I'd
>>>> really argue against it, as MADV_FREE is to me a weaker form of
>>>> MADV_DONTNEED - the existing pages are not zapped immediately but
>>>> prioritized for reclaim. If MADV_DONTNEED leaves guard PTEs in place, why
>>>> shouldn't MADV_FREE too?
>>>
>>> That is not, as I understand it, what MADV_FREE is, semantically. From the
>>> man pages:
>>>
>>>         MADV_FREE (since Linux 4.5)
>>>
>>>                The application no longer requires the pages in the range
>>>                specified by addr and len.  The kernel can thus free these
>>>                pages, but the freeing could be delayed until memory pressure
>>>                occurs.
>>>
>>>         MADV_DONTNEED
>>>
>>>                Do not expect access in the near future.  (For the time
>>>                being, the application is finished with the given range, so
>>>                the kernel can free resources associated with it.)
>>>
>>> MADV_FREE is 'we are completely done with this range'. MADV_DONTNEED is 'we
>>> don't expect to use it in the near future'.
>>
>> I think the description gives a wrong impression. What I think matters it
>> what happens (limited to anon private case as MADV_FREE doesn't support any
>> other)
>>
>> MADV_DONTNEED - pages discarded immediately, further access gives new
>> zero-filled pages
>>
>> MADV_FREE - pages prioritized for discarding, if that happens before next
>> write, it gets zero-filled page on next access, but a write done soon enough
>>   can cancel the upcoming discard.
>>
>> In that sense, MADV_FREE is a weaker form of DONTNEED, no?
>>
>>>>
>>>> Seems to me rather currently an artifact of MADV_FREE implementation - if it
>>>> encounters hwpoison entries it will tear them down because why not, we have
>>>> detected a hw memory error and are lucky the program wants to discard the
>>>> pages and not access them, so best use the opportunity and get rid of the
>>>> PTE entries immediately (if MADV_DONTNEED doesn't do that too, it certainly
>>>> could).
>>>
>>> Right, but we explicitly do not tear them down in the case of MADV_DONTNEED
>>> which matches the description in the manpages that the user _might_ come
>>> back to the range, whereas MADV_FREE means they are truly done but just
>>> don't want the overhead of actually unmapping at this point.
>>
>> But it's also defined what happens if user comes back to the range after a
>> MADV_FREE. I think the overhead saved happens in the case of actually coming
>> back soon enough to prevent the discard. With MADV_DONTNEED its immediate
>> and unconditional.
>>
>>> Seems to be this is moreso that MADV_FREE is a not-really-as-efficient
>>> version of what Rik wants to do with his MADV_LAZYFREE thing.
>>
>> I think that further optimizes MADV_FREE, which is already more optimized
>> than MADV_DONTNEED.
>>
>>>>
>>>> But to extend this to guard PTEs which are result of an explicit userspace
>>>> action feels wrong, unless the semantics is the same for MADV_DONTEED. The
>>>> semantics chosen for MADV_DONTNEED makes sense, so MADV_FREE should behave
>>>> the same?
>>>
>>> My understanding from the above is that MADV_FREE is a softer version of
>>> munmap(), i.e. 'totally done with this range', whereas MADV_DONTNEED is a
>>> 'revert state to when I first mapped this stuff because I'm done with it
>>> for now but might use it later'.
>>
>>  From the implementation I get the opposite understanding. Neither tears down
>> the vma like a proper unmap(). MADV_DONTNEED zaps page tables immediately,
>> MADV_FREE effectively too but with a delay depending on memory pressure.
>>
> 
> OK so based on IRC chat I think the conclusion here is TL;DR yes we have to
> change this, you're right :)
> 
> To summarise for on-list:
> 
> * MADV_FREE, while ostensibly being a 'lazy free' mechanism, has the
>    ability to be 'cancelled' if you write to the memory. Also, after the
>    freeing is complete, you can write to the memory to reuse it, the mapping
>    is still there.
> 
> * For hardware poison markers it makes sense to drop them as you're
>    effectively saying 'I am done with this range that is now unbacked and
>    expect to get an empty page should I use it now'. UFFD WP I am not sure
>    about but presumably also fine.
> 
> * However, guard pages are different - if you 'cancel' and you are left
>    with a block of memory allocated to you by a pthread or userland
>    allocator implementation, you don't want to then no longer be protected
>    from overrunning into other thread memory.

Agreed. What happens on MADV_DONTNEED/MADV_FREE on guard pages? Ignored 
or error? It sounds like a usage "error" to me (in contrast to munmap()).

-- 
Cheers,

David / dhildenb


