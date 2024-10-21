Return-Path: <linux-arch+bounces-8402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AED89A91F5
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADCB1C22BA3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BE1E231B;
	Mon, 21 Oct 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx4U/DA+"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB51E22FD
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545613; cv=none; b=IRbYK8y7hpx91XZWImKcD6YuGvBZj/lgBE9JDw92N4gMehXtYWgZcsNXA9tn5eYbxVQ/1KHi3qT5d4io3p9H2Y8Lf3DeIw8BqhZ2MJiO0xzPHuBID+qQlBmuvkfxO4Xn08eOjaXi2pUHm0EgJbvLOAoHLwkLm4e/BgLwRyejUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545613; c=relaxed/simple;
	bh=SZQvYJ/RSbLTDimoORxaj35b1qkanZzU3/SA1/dT/fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sidKTqnfVDBdnXT1xeH4sMYO+9FodXWsr78TTGqzxRR8G2KLF4krpc42wKqDm4GlCrWef0CtYcpXMXxtkOXcwTAOy1dM9iX7QZ1R8pIHCpKtH7MtNl7aa/Ty5OCminuJeStGLzfV9dbuY6Ms0u/jdFskddhQMKMjIRmwRQLZEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kx4U/DA+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729545610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QXnA9eK3dphiqyJhgikwav3yV2QEB8Twyyu0KVjMLeY=;
	b=Kx4U/DA+GSQKcaa5olGv+aZ29EA6kV5h709/WBGgQQBZX3PVxvxDm7369rxonTcMFJaR5O
	1jU9cDQc53zKgeJ8qQ6bpEJO48nN/iNglRK/dd/Y/y/MJsMKFxUVA9Piw2erPnO0a4cHmI
	F3JygYRNfYEotVp/d7CIDD2onshEW+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9rzfTcAaMwKEcQKCUDK5aw-1; Mon, 21 Oct 2024 17:20:09 -0400
X-MC-Unique: 9rzfTcAaMwKEcQKCUDK5aw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so39194285e9.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 14:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545607; x=1730150407;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXnA9eK3dphiqyJhgikwav3yV2QEB8Twyyu0KVjMLeY=;
        b=RPGJVpB3sgyT92ieSM5PUtmNWxjCKEzRQbVXdV0qvtKHN/tY5ccJF29/Ne87Ck8Jee
         leeySHW4SalgIDtEd36Hd+xVHEsl8O/vUeg29nniv18IOYyjS7i3BESRfEBjFNcIFQv3
         g+ua0k91RwXx5X6hA0X03eYPo5Ir0FgRX6mwl228ow14TTpDASY7bDAkkuPosf3HRI9k
         6AFmcq2zDDXRs5RI2JQkAfjXZr0sKRMX5W1zYreJP4Oya2L4+tZbwIhkSfBRZ8m3zDm4
         RSbzO9vudrCUBYExhO4rPGEJEv3ZFjwbvodjScfM3FVNbpSzZ3UE1PgAPkAskCDX/y0Q
         28YA==
X-Forwarded-Encrypted: i=1; AJvYcCXmrmNQK3S0O/Jb1zJLNNtnF4XqIyDOF0MONRK1Ddp3h3wILdZC3sOmMzrivFCeURvvciARedST+w1B@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0kghAT5UMG64NLniKQJs/XH767LyhOgkRyq3Lvm2AkgkiPYW
	8vIG0QRyREZT2B0U2rvNH5LDkxvPmZF5WZyP1ipBXFnlhwPbLt+pJairz5069+SVBWG5Sv82Evj
	r1xot0RN22+b99SZWUYjYiy5GOT5Hhv90c7TWaKqxmmcySnscJiMHNlaWZT8=
X-Received: by 2002:a05:600c:1c0b:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4317cb091cbmr2970595e9.30.1729545607095;
        Mon, 21 Oct 2024 14:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9sPDOXs+2klDzQodV352v7SWF/npmFB4NYlQWcr5osWwv+jWkTntE+SYVjHOr/OX+e4OTWQ==
X-Received: by 2002:a05:600c:1c0b:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4317cb091cbmr2970435e9.30.1729545606653;
        Mon, 21 Oct 2024 14:20:06 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6747.dip0.t-ipconnect.de. [91.12.103.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58c125sm67863795e9.26.2024.10.21.14.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 14:20:06 -0700 (PDT)
Message-ID: <0f7a6b69-5706-4010-ba7a-68a071922c80@redhat.com>
Date: Mon, 21 Oct 2024 23:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
 <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
 <73134e10-19eb-4e52-b87f-5fbfd322b575@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <73134e10-19eb-4e52-b87f-5fbfd322b575@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Yes, I see from Lorenzo's reply that there is apparently some history to
>> this (maybe it's all nicely summarized in the cover letter / this patch,
>> have to dig further).
>>
>> Not sure yet what the problem is, I would have thought it's all protected by
>> the PTL, and concurrent faults are user space doing something stupid and
>> we'd detect it.
> 
> The looping mechanism is fine for dealing with concurrent faults. There's
> no actual _race_ due to PTL, it's just that a user could repeatedly
> populate stuff stupidly in a range that is meant to have poison markers put
> in.
> 
> It's not likely and would be kind of an abusive of the interface, and it'd
> really be a process just hurting itself.
> 
> In nearly all cases you won't zap at all. The whole point is it's
> optimistic. In 99.99% of others you zap once...

Exactly! And that's why I am questioning whether the kernel should care 
about that. See below.

> 
>>
>> Have to do some more reading on this.
> 
> May I suggest a book on the history of the prodigy?

:D

> 
>>
>>>
>>> I'd normally agree with the KIS principle, but..
>>>
>>>> We can always implement support for that later if
>>>
>>> it would either mean later we change behavior (installing guards on
>>> non-zapped PTEs would have to be an error now but maybe start working later,
>>> which is user observable change thus can break somebody)
>>>
>>>> really required (leave behavior open when documenting).
>>>
>>> and leaving it open when documenting doesn't really mean anything for the
>>> "we don't break userspace" promise vs what the implementation actually does.
>>
>> Not quite I think. You could start return -EEXIST or -EOPNOTSUPP and
>> document that this can change in the future to succeed if there is
>> something. User space can sense support.
> 
> Yeah I mean originally I had a -EAGAIN which was sort of equivalent of this
> but Jann pointed out you're just shifting work to userland who would loop
> and repeat.
> 
> I just don't see why we'd do this.
> 
> In fact I was looking at the series and thinking 'wow it's actually a
> really small delta' and being proud but... still not KIS enough apparently
> ;)

You know, I read a lot of kernel code ... and mfill_atomic_install_pte() 
is what popped in my head: if there is already something, let user space 
handle it, because it is unexpected.

The uffd interface is slightly better, as it gives you the number of 
processed PTEs back, which madvise() is not designed for.

But maybe this (returning how many we already processed) is not required 
due to the nature of guard pages (below).

> 
>>
>> Something failing that at one point starts working is not really breaking
>> user space, unless someone really *wants* to fail if there is already
>> something (e.g., concurrent fault -> bail out instead of hiding it).
>>
>> Of course, a more elegant solution would be GUARD_INSTALL vs.
>> GUARD_FORCE_INSTALL.
>>
>> .. but again, there seems to be more history to this.
> 
> I don't think there's really any value in that. There's just no sensible
> situation in which a user would care about this I don't think.

Making sure nobody touches an area, and wile doing that somebody already 
touched that area? I guess it could be worked around by 
mprotect(PROT_NONE),madvise(GUARD),mprotect(PROT_READ|PROT_WRITE) ... 
which is not particularly nice :)

> 
> And if you're saying 'hey do MADV_DONTNEED if this fails and keep trying!'
> then why not just do that in the kernel?

Heh, no!

If user space doesn't expect there to be something, it should *fail*. 
That's likely going to be the majority of use cases for guard pages 
(happy to be told otherwise). No retry.

And if user space expects there to be something it should zap ahead of 
time (which some allocators maybe already do to free up memory after 
free()) to then install the guard. No retry.

There is this case where user space might be unsure. There, it might 
make sense to retry exactly once.

> 
> Trying to explain to a user 'hey this is for installing guard pages but if
> there's a facing fault it'll fail and that could keep happening and then
> you'll have to zap and maybe in a loop' just... seems like a bloody awful
> interface?

Hope my example above made it clearer. This "retry forever until it 
works" use case doesn't quite make sense to me, but I might just be 
missing something important.

But again, I have to do more reading on the history of the current 
approach ... and it's fairly late here.


-- 
Cheers,

David / dhildenb


