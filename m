Return-Path: <linux-arch+bounces-6151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B494E374
	for <lists+linux-arch@lfdr.de>; Sun, 11 Aug 2024 23:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F161C211ED
	for <lists+linux-arch@lfdr.de>; Sun, 11 Aug 2024 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88E15C150;
	Sun, 11 Aug 2024 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDhSiqyi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A082C1A5;
	Sun, 11 Aug 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723413047; cv=none; b=crVy5sXgKm1FYeTBemh8xBPQQVOSWSj/Hv4vP5OQXHCigcJRt2fwGTg21pGmBDitcSVeXyzax/OqRHhQpWyVPAuz5jmPgjR6xA+4zns0HObGqWBEd/m0dIypqTxlbhVy9uO3kYehWHgGA465KUnPVA+S9WMToXEbrQbcnMGE924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723413047; c=relaxed/simple;
	bh=Ideq94+P9om5h9G1gC4jNDnoTihqThz8+wk2lRChR4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4fwQO5uqkwqTP0n58zVWgaogE3Ln3DWbC1ZhZd17gjK603qf+CYYjH7Oo+/r9rylJjbLdu8aNkMfXd7pb9coPshqpip+d7tunm7LhK8+gjrLkVWSTrp+LrcFhrHIKF9WCZNG0Fh2/QKFBxktfsbN8p6vcpHNLLggcldsjDdj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDhSiqyi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so28252255e9.2;
        Sun, 11 Aug 2024 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723413044; x=1724017844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zmy5SX4/jWP7boerv8nNkQKhYLkyFlWX6WV0T42uhIk=;
        b=GDhSiqyiuHfQYjT8IakKlwh+Z2G4zzJRzlN6Gm8dOrhnznxUZwI1P1mdw8UB55poHQ
         U53J7kpisD59WrVsIAhCtoKGgzLvhibyT7lT1gINKLpgJYtAObg9BfwSxRbMDHKFrNzH
         ob6Wf6ZzCufzB+xUAv3PYXDbu3A3FzM7Kz9cFAoYfQfR+YZr3LszV5aTzD77XcboYfGz
         RqErGrMHEXEs7hRw7ANk5rxNfrcXfWoIwSOQPeAdXz9mlCoGLRjb1PS0UlhVMPkYxqie
         IrEeeFyKx6KyKjEqZif17jdJdbq4MKZ9g4w7b2qKulcEcss4PKn1wj+n9rhGlM09PO8g
         Kgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723413044; x=1724017844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zmy5SX4/jWP7boerv8nNkQKhYLkyFlWX6WV0T42uhIk=;
        b=CVUtaBRhJBKKqmeJDCemnkzfMtmqw53DmmdXjZ5u/GQTP75K54RTKzyy0MPHJW/L1f
         YLCgzy9powg7MTD3CPLHpHiHVhFpID4bpSUDfd+ojjXZ3s+CSN3ygczmjx0BGDwq2NUQ
         dIVnG9fiI2l5MDBZyeDtYlnzeMa5UswmaqjlrRnZQWBbpNsviW7Utr7RPyZEfIbcKVNi
         mRW6mLISiKq+XZPWy/tXzhJwZodSsJtM8KcGKNUbUGwFZbJ19QCMUeo5l6gDtKktjwzY
         ka6Iuhszh3lQYsFLoheZS7X2frBtOL/+fH8stbz9aCStFQGC6zYE69e8O+JiG6Bx5VS6
         2arg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8+XNRBZALhAeum6FOD7q9qwUVF5eWL8AKhMEBY2+83t53OqP2bxsXWpgguipptmRXMabjZoghlZO@vger.kernel.org, AJvYcCURIUGy5lcZroZlhzPoBgfvggICH5edH39BkEFvSHmdnbx2rUZXPGhdlkyt4qPB+hOusJazjYM8pR6Ib66E@vger.kernel.org, AJvYcCUShQgfGkPqSZhWgJ9LF7Lx9MFlyqJ/2eWjyK5DhBZro/+dDJQ/9z/E8+Jjw1qqR2v2y1U=@vger.kernel.org, AJvYcCUZveQrqa/QrtLr9ltr+4xt0Vk8u4gnz8C9Uwa1bmG2kIFSfEUpCfMGxj/V6sx1S2+X9znyyhKRb0VE73iYbQZf@vger.kernel.org, AJvYcCUmj88nEhODmSUJRxG3l+0dYQ7zOYSrZxyWPfVMXADu8dIb7lXHgePoA65bT3+cHIsyMbJdwC/363+rxbwa@vger.kernel.org, AJvYcCV9SGEY9Pljp7GJrw90TwUpSAmlnW/33WGKXOhkm3k4Dagzamdx/3sIJo/4VXKp+XqO+7aiO01OJ+uiEw==@vger.kernel.org, AJvYcCVKxqSIAJkGwzl6plFWSMFz/HYVgbhD7gba/ggy8fWiLT524vbhV/72WmCXzl9zv9ZjO/8ZeYoF1jYDhQY=@vger.kernel.org, AJvYcCVfxUOCT8sU2P87ACj5vC8JO7Hu9RC52fL5skZqZg8+GGjdPJ8m5rLEFYvzztwbIU9JVWenlZ2G+W+Dbnw=@vger.kernel.org, AJvYcCW1EEsLQa2Ho5soiWD3aJVXqKE+nFuNQ9vSmjT/oBTmsS1rbDOQaSI5as2mCDnPrWY+yNI7FSZ6LGnYxg==@vger.kernel.org, AJvYcCXKVLDtwJb2bV7ejrfxblrn
 baBqjt+zmI3/y3uBeXQJbPEKos0+l1tHa3a6VzYveoREOJtweu9SIqylIw==@vger.kernel.org, AJvYcCXST0g8JYhm+CJbGvQLD2/COFez8630ylhs8G2Tun40q46n5d5JyJ5T6dKT5o5mS+xb+DxkkiXP3XbKyc6cCea8MOcK@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8/lmDh/UcI1QJTiZMLgE4bppmnSXkNfkhTlZ1YcoN/GHkfk/
	gBLBYmn5sTKOeJ59Iw0U9HeluSrp7oMjt6paI0JNBWty5Pb1ZoN4
X-Google-Smtp-Source: AGHT+IFfo5+dE1Jz9ZaN7Mp86F0AFdfQ3J5qxDNb9cWZpuIKnM/ndN7vtT5TpeLfisL5UKGERSXV1w==
X-Received: by 2002:a05:600c:4eca:b0:426:6773:17 with SMTP id 5b1f17b1804b1-429c3a517e5mr43332115e9.30.1723413044174;
        Sun, 11 Aug 2024 14:50:44 -0700 (PDT)
Received: from [192.168.42.175] ([85.255.232.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750ef58sm79243045e9.16.2024.08.11.14.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:50:43 -0700 (PDT)
Message-ID: <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com>
Date: Sun, 11 Aug 2024 22:51:13 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory
 provider
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com>
 <20240806135924.5bb65ec7@kernel.org>
 <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
 <20240808192410.37a49724@kernel.org>
 <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
 <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
 <20240809205236.77c959b0@kernel.org>
 <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/11/24 03:21, Mina Almasry wrote:
> On Fri, Aug 9, 2024 at 11:52 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Fri, 9 Aug 2024 16:45:50 +0100 Pavel Begunkov wrote:
>>>> I think this is good, and it doesn't seem hacky to me, because we can
>>>> check the page_pools of the netdev while we hold rtnl, so we can be
>>>> sure nothing is messing with the pp configuration in the meantime.
>>>> Like you say below it does validate the driver rather than rely on the
>>>> driver saying it's doing the right thing. I'll look into putting this
>>>> in the next version.
>>>
>>> Why not have a flag set by the driver and advertising whether it
>>> supports providers or not, which should be checked for instance in
>>> netdev_rx_queue_restart()? If set, the driver should do the right
>>> thing. That's in addition to a new pp_params flag explicitly telling
>>> if pp should use providers. It's more explicit and feels a little
>>> less hacky.
>>
>> You mean like I suggested in the previous two emails? :)
>>
>> Given how easy the check is to implement, I think it's worth
>> adding as a sanity check. But the flag should be the main API,
>> if the sanity check starts to be annoying we'll ditch it.
> 
> I think we're talking about 2 slightly different flags, AFAIU.>
> Pavel and I are suggesting the driver reports "I support memory
> providers" directly to core (via the queue-api or what not), and we
> check that flag directly in netdev_rx_queue_restart(), and fail
> immediately if the support is not there.

I might've misread Jakub, but yes, I believe it's different. It'd
communicate about support for providers to upper layers, so we can
fail even before attempting to allocate a new queue and init a
page pool.

> Jakub is suggesting a page_pool_params flag which lets the driver
> report "I support memory providers". If the driver doesn't support it
> but core is trying to configure that, then the page_pool_create will
> fail, which will cause the queue API operation
> (ndo_queue_alloc_mem_alloc) to fail, which causes
> netdev_rx_queue_restart() to fail.

And I'm not against this way either if we explicitly get an error
back instead of trying to figure it out post-factum like by
checking the references and possibly reverting the allocation.
Maybe that's where I was confused, and that refcount thing was
suggested as a WARN_ONCE?

FWIW, I think it warrants two flags. The first saying that the
driver supports providers at all:

page_pool_init() {
	if (rxq->mp_params)
		if (!(flags & PP_PROVIDERS_SUPPORTED))
			goto fail;
}

And the second telling whether the driver wants to install
providers for this particular page pool, so if there is a
separate pool for headers we can set it with plain old kernel
pages.

payload_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED);
header_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED |
                                     PP_IGNORE_PROVIDERS);

(or invert the flag). That's assuming page_pool_params::queue is
a generic thing and we don't want to draw equivalence between
it and memory providers.

-- 
Pavel Begunkov

