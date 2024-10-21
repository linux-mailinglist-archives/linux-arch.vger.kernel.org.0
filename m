Return-Path: <linux-arch+bounces-8392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3AA9A90E3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E384C283185
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491D1FBF56;
	Mon, 21 Oct 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFjKFpfb"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FC19EEC4
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541933; cv=none; b=glrxbMtYsM2mJwDxisbhsin27NSjp+8oEOWFd1/jPF4V8JtrDe5dsqOhQDd3kN/rgIWEAmZXR6jRxGVdnm7Zmstmtq0XLHE0GSf77xC5eI2kqZrvM5uiHGRAg++bnWebZOC8bhumVWC8GJ2NQ8O9HIpwUK1Nmj0I0zaAIy3Azn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541933; c=relaxed/simple;
	bh=ow8qB7zSMBU87cxA7P3F/0WxMvgzc9ilG3X0oKA0n0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsOra+jFQhcWy0M11yebvfzR44WKzjklEp7E3+rS/jouF0qr16ybEFR6BMnLkATdfi70ahOhNVgIOqg/xiYE6dXl59C4XOB75w1cg0jm48kFA/LIw3xg0Eh2zUo1MpcuJkIAW+SUQT6n+GWPihO4SHsnhaWeh8lO4+HOssOgXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFjKFpfb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729541930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M88OeI5oZFPk5wfhywkCpTo9I5LQOf7gyBYD+TmpbMs=;
	b=WFjKFpfbZcsPp8n27oXqBTswFlkkQDY8S+ngCvfSljTWQk6e2xV0hi5NsmQsmyoucTgSRp
	HK5rw2gs38MSv+c3IHePgmxXQIvqiJEKhBSP2q7SDbepLfOTLYHl3P+I+7+44sZOYmrClT
	vpGcT8sZEV7SmQHOP3+DKkJBwR099dI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-p0Vur85BObu9q5tx-Jj1bA-1; Mon, 21 Oct 2024 16:18:49 -0400
X-MC-Unique: p0Vur85BObu9q5tx-Jj1bA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d458087c0so3301619f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541928; x=1730146728;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M88OeI5oZFPk5wfhywkCpTo9I5LQOf7gyBYD+TmpbMs=;
        b=swv52JMW9V+/dclIBoKKOF8d+tgiACsBfvMMZ749rc2rsh9IKs99PGQWkegNwpVcLy
         p8jjUmMDUu6B7oC50746LIp8kqaERA5Yh9H/9iRAoBVHO/6LdNjKN8idst4eIV4e0PFH
         G32I1n2fXJA25qvBHsQgums1yOVJlMSRaaJkgW2lfKhxnO5FPWu8bxB+KOgpYCXQFQMp
         D1PqZv9kM/Jfz1Rzmh4xcPmTVo9AHArF67l0clOCAttLvJIEOihAcFq/3ebqH441V0vB
         Ztv419btmvEbLIA/uY+/CFB+hau6RHaXFqPGJXj90uvFI2KpDH7TMwz/HLVOu17KEv6T
         6pKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGxHMUqVhhffj9hfP53uUhpYLEfZ6VromPSgNm3Qi/MyNRb47jCZH3bYxBHMJwb7lzN5/KyQ3nHUV2@vger.kernel.org
X-Gm-Message-State: AOJu0YyiW7wETVsL+IpCJDj/s1RqXE+1S2XDNZybIxI2oJnirwYSLg6W
	R0bfX829D756XUbB1yV2qAc0CCplM1fe+b5oWgyx2VI18fhOwEYVnYkK8Iu7evt7Ry38k5WIvBw
	sWCHihyY3lNtOzv2F7ks0YO4QZRl/KmhlUw4fANYQBZMgwyJKGeFjIlhsQrY=
X-Received: by 2002:a5d:4845:0:b0:37d:4610:dca with SMTP id ffacd0b85a97d-37ef14c36a2mr473518f8f.31.1729541928260;
        Mon, 21 Oct 2024 13:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5o8+RlEPSJh6ZYLVD8PlLR+Qht5L0r2ZYZxN0Zixf3cPupS76Kl1KQKSr870jX7VNYn6Shw==
X-Received: by 2002:a5d:4845:0:b0:37d:4610:dca with SMTP id ffacd0b85a97d-37ef14c36a2mr473461f8f.31.1729541926389;
        Mon, 21 Oct 2024 13:18:46 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6747.dip0.t-ipconnect.de. [91.12.103.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4864csm5086369f8f.35.2024.10.21.13.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:18:45 -0700 (PDT)
Message-ID: <5e72a89f-4094-4831-8670-7fda2f64efa5@redhat.com>
Date: Mon, 21 Oct 2024 22:18:43 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>,
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
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <b13a83f4-c31c-441d-b18e-d63d78c4b2fb@redhat.com>
 <b2bca752-77f3-4b63-abe9-348a5fc2a5cc@lucifer.local>
 <c8272b9d-5c33-4b44-9d6d-1d25c7ac23dd@redhat.com>
 <3baf8814-0a9a-4de0-b568-62d241dbba0e@nvidia.com>
 <a4b7ed07-3b14-4443-aa76-77d720912cd0@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a4b7ed07-3b14-4443-aa76-77d720912cd0@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 21:39, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 12:25:08PM -0700, John Hubbard wrote:
>> On 10/21/24 10:23 AM, David Hildenbrand wrote:
> [snip]
>>>>> Just to raise it here: MADV_GUARD_INSTALL / MADV_GUARD_REMOVE or sth. like
>>>>> that would have been even clearer, at least to me.
>>
>> Yes, I think so.
>>
>>>>
>>>> :)
>>>>
>>>> It still feels like poisoning to me because we're explicitly putting
>>>> something in the page tables to make a range have different fault behaviour
>>>> like a HW poisoning, and 'installing' suggests backing or something like
>>>> this, I think that's more confusing.
>>>
>>> I connect "poison" to "SIGBUS" and "corrupt memory state", not to "there is nothing and there must not be anything". Thus my thinking. But again, not the end of the world, just wanted to raise it ...
>>
>> "Poison" is used so far for fairly distinct things, and I'd very much like
>> to avoid extending its meaning to guard pages. It makes the other things
>> less unique, and it misses a naming and classification opportunity.
>>
>> "Guard" and "guard page" are fairly unique names. That's valuable.
>>
>>
>> thanks,
>> --
>> John Hubbard
>>
> 
> Guys you're breaking my heart... Will you not leave me with even a remnant
> of a cultural reference?? [0]

I'm sure you will recover from that loss :)

-- 
Cheers,

David / dhildenb


