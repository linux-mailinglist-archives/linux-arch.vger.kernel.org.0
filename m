Return-Path: <linux-arch+bounces-2887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0258751D7
	for <lists+linux-arch@lfdr.de>; Thu,  7 Mar 2024 15:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4382875F4
	for <lists+linux-arch@lfdr.de>; Thu,  7 Mar 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8A812F36C;
	Thu,  7 Mar 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecSX+Wg2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838B12B144;
	Thu,  7 Mar 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821621; cv=none; b=DNq/+iTKLSTCHFdTN2fKFi7ObbYUn3QFoBgWrElmd370zRAc/UG0yb9JmJh8gVJmNOuyu0/j0x2JvFU1Kkmqm1d024pi1vdUMIN+0cZhJMxXvVUkQAJf9hyuBZmAah5Z+7RHNroZpiq937JaIuIs3WzBYZ3vvdOnNDLnnPFgMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821621; c=relaxed/simple;
	bh=7n43bQFtr5tMI6MqyXK1QrWmmVqkiyaya1b8yeJLdek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1Qz8LXnUiyJ31ooXK/LcgcJ5e2ydPq8lu2zZVMXFArSmokPxNsHAr44UEJx58YWrZAHBe56rMnqc3Uo3+lTAj1ADSjXQdvWw29vOQhLJK/pdpCARCfHM+zQR0NAIfyBDoTPUFUPOPK2dhWO8Sjf8Y9/KZM7jONDbS2yIcTiavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecSX+Wg2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44628725e3so132799466b.0;
        Thu, 07 Mar 2024 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709821617; x=1710426417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg01UjUEOFW1x71hZnPaPxS7brRMRXDWbNeoEMgN/eQ=;
        b=ecSX+Wg2v+Q1Nugo6J9Epv9Ac2wR9T6pLOjp1JsX7RqG2UeRpb/Mpwh4mVErQejFta
         L+qCQk8zEPpFXh+Zm852ZhcMmFrn02dEu3NXW/tfB29XsYfobhreotdLXFd/69JN1+kb
         zoVWI8POQkkKJNeo4nCbMsUqZkI0Qr71cOUv6kCQcBeqdbt6oSdPVMSRBRpWCQoUNzWs
         tMCMxi7oxXUJxeipVxXH+1x0v7ICSFK0UEIVRJFsOlUrtCGVaI3GS42dcBEtjjw7BLrp
         ZRM8qIJGDsHTuJh9PG8kbVvPY7ixpEbxPtmgC3lPHK3yg1lqBnlPdjPVhyDjPjdUvDAf
         vg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821617; x=1710426417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg01UjUEOFW1x71hZnPaPxS7brRMRXDWbNeoEMgN/eQ=;
        b=MnUYnVPEBSS0i49Uc0XIxupNWlce2vzinit5IYIEu17fWJ30sKzvDOweM3JWM3nnDo
         eym1vIjQaNnyGdEEZp885JO1WDEfYN/WAHYdAbHv23Q35dUYMTxMMwAQAzxd/ML9X/xi
         /46XOuDe9KMEeD3y/XdIZpyUFZ9L5wp9C5KDq5+5A/elGOEyZudW5QTfVsBDcClk71Q6
         2vLnEFw3hdAyIjGGtp/YmnCMJAA9zgRIftGwGa+QRBjlcqU12AM+gTaPItZJL/wQqBgV
         5caixUQTLXIF2JuzNpoHpiCFXr7f7PmuftFL2LgHxzYuhnF7aaMvgEvhhYY2lqT20zuO
         VmHA==
X-Forwarded-Encrypted: i=1; AJvYcCVMDdvGnj5S9H97vzJMsrloca92kh4gUO9P9kzIb2KTwRWlmBBcJSsN9h/shgZlDM3U2M5Vabe9La3ug9yOl7670LB42GiHRzutFQV3Re7uCjyOO6UAR/o+oq7rap4WWzCVBVt7GIvfcI4HERZ/a72cxxchZQIhOadOPdgjYiDZmKwEeGh9c+7iV2oOW5+QyAWVTniqNf1kQPowEKtliS6nMWCKP0zdAHg1hsWz/c6KEBagiiejvQtD64+f6lIjpOcdedbEr6TjSLIxJrx10geVPgUOZitNl3p3n4irxpK5LokZrCpp/hv1ccRFzwxHZrkbkBEK7goXsB20EvDPaiSAbkJ6J84BCA4cHCG6bhRrvh16Av/2i0FQszBXNu5xhLDdKpuP2QGJkYqcXtpPXg3QB0fF5kDvZPj031Eq9q75KduHmG0K8eWbFzPN/A4SHmXtrcrpC+G0wiZ6nryRm1dWn942c4iNeP0ag/asCw17DD0ixF1EYZ9gxZSLKd3hqEZNNtP5HQ==
X-Gm-Message-State: AOJu0YxkZBnyKLMwvGOZADQ+vbrrvPWuizEGlXfQKUlDS5PuzccDDHIg
	bbXWjJ/UvqtmKKAGJ8QVeMCiIYr6wHiRblZmYG7J7boIt5DvsZtU
X-Google-Smtp-Source: AGHT+IFT/ts927o6JGYwWZQXxyIlO6T96XDTdOGRrC1/6fXKlMhZn4RE5gk2GSWmMR28L6D4moz+Ug==
X-Received: by 2002:a17:906:39da:b0:a44:e2e0:bda8 with SMTP id i26-20020a17090639da00b00a44e2e0bda8mr10576240eje.0.1709821617228;
        Thu, 07 Mar 2024 06:26:57 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:310::2041? ([2620:10d:c092:600::1:86e8])
        by smtp.gmail.com with ESMTPSA id w16-20020a170906185000b00a4551cc291esm4475915eje.40.2024.03.07.06.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 06:26:56 -0800 (PST)
Message-ID: <de04486c-efb8-4c51-8d2e-a4a344f00f41@gmail.com>
Date: Thu, 7 Mar 2024 14:25:36 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, shakeel.butt@linux.dev
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
 <1b57dac2-4b04-4bec-b2d7-d0edb4fcabbc@davidwei.uk>
 <CAHS8izM5O39mnTQ8mhcQE75amDT4G-3vcgozzjcYsAdd_-he1g@mail.gmail.com>
 <417f293a-848e-4eb2-b690-c8696079b452@gmail.com>
 <CAHS8izNPtHb2GnEMviiJTFT_dPxsxgYsNw5V9s-gSC2YnJRPRg@mail.gmail.com>
 <772b9ab0-c6d7-4b13-8e05-44dd312b9879@gmail.com>
 <CAHS8izPzBqz4CzL7Axpfy7uXFDN1F5afyCfEeYnysH5KCjEgcQ@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPzBqz4CzL7Axpfy7uXFDN1F5afyCfEeYnysH5KCjEgcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/6/24 21:59, Mina Almasry wrote:
> On Wed, Mar 6, 2024 at 11:14 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> On 3/6/24 17:04, Mina Almasry wrote:
>>> On Wed, Mar 6, 2024 at 6:30 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>> On 3/5/24 22:36, Mina Almasry wrote:
...
>>>>> To be honest, I think it makes sense for the TCP stack to be
>>>>> responsible for putting the references that belong to it and the
>>>>> application. To me, it does not make much sense for the page pool to
>>>>> be responsible for putting the reference that belongs to the TCP stack
>>>>> or driver via a page_pool_scrub() function, as those references do not
>>>>> belong to the page pool really. I'm not sure why there is a diff
>>>>> between our use cases here because I'm not an io_uring expert. Why do
>>>>> you need to scrub all the references on page pool destruction? Don't
>>>>> these belong to non-page pool components like io_uring stack or TCP
>>>>> stack ol otherwise?
>>>>
>>>> That one is about cleaning buffers that are in b/w 4 and 5, i.e.
>>>> owned by the user, which devmem does at sock destruction. io_uring
>>>> could get by without scrub, dropping user refs while unregistering
>>>> ifq, but then it'd need to wait for all requests to finish so there
>>>> is no step 4 in the meantime. Might change, can be useful, but it
>>>> was much easier to hook into the pp release loop.
>>>>
>>>> Another concern is who and when can reset ifq / kill pp outside
>>>> of io_uring/devmem. I assume it can happen on a whim, which is
>>>> hard to handle gracefully.
>>>>
>>>
>>> If this is about dropping application refs in step 4 & step 5, then
>>> from devmem TCP perspective it must be done on socket close & skb
>>> freeing AFAIU, and not delayed until page_pool destruction.
>>
>> Right, something in the kernel should take care of it. You temporarily
>> attach it to the socket, which is fine. And you could've also stored
>> it in the netlink socket or some other object. In case of zcrx io_uring
>> impl, it's bound to io_uring, io_uring is responsible for cleaning them
>> up. And we do it before __page_pool_destroy, otherwise there would be
>> a ref dependency.
>>
> 
> AFAIU today the page_pool_release() waits until there are no more
> pages in flight before calling __page_pool_destroy(), and in existing
> use cases it's common for the page_pool to stay alive after
> page_pool_destroy() is called until all the skbs waiting in the
> receive queue to be recvmsg()'d are received and the page_pool is
> freed. I just didn't modify that behavior.
> 
>> A side note, attaching to netlink or some other global object sounds
>> conceptually better, as once you return a buffer to the user, the
>> socket should not have any further business with the buffer. FWIW,
>> that better resembles io_uring approach. For example allows to:
>>
>> recv(sock);
>> close(sock);
>> process_rx_buffers();
>>
>> or to return (i.e. DEVMEM_DONTNEED) buffers from different sockets
>> in one call. However, I don't think it's important for devmem and
>> perhaps more implementation dictated.
>>
> 
> Hmm I think this may be a sockets vs io_uring difference? For sockets
> there is no way to recvmsg() new buffers after the sock close and

That is true for io_uring as well, but io_uring can't wait for socket
tear down as it holds socket refs

> there is no way to release buffers to the kernel via the setsockopt()
> after the sock close.

If, for example, you store the xarray with userspace buffers in a
netlink socket and implement DONT_NEED setsockopt against it, you
would be able to return bufs after the TCP socket is closed. FWIW,
I'm not saying you should or even want to have it this way.

> But I don't think we need to align on everything here, right? If

Absolutely, mentioned just to entertain with a design consideration

> page_pool_scrub makes more sense in your use case because the lifetime
> of the io_uring buffers is different I don't see any issue with you
> extending the ops with page_pool_scrub(), and not define it for the
> dmabuf_devmem provider which doesn't need a scrub, right?

Yes, and it's a slow path, but I'll look at removing it anyway in
later rfcs.

>>> Think
>>> about a stupid or malicious user that does something like:
>>>
>>> 1. Set up dmabuf binding using netlink api.
>>> 2. While (100000):
>>> 3.   create devmem TCP socket.
>>> 4.   receive some devmem data on TCP socket.
>>> 5.   close TCP socket without calling DEVMEM_DONTNEED.
>>> 6. clean up dmabuf binding using netlink api.
>>>
>>> In this case, we need to drop the references in step 5 when the socket
>>> is destroyed, so the memory is freed to the page pool and available
>>> for the next socket in step 3. We cannot delay the freeing until step
>>> 6 when the rx queue is recreated and the page pool is destroyed,
>>> otherwise the net_iovs would leak in the loop and eventually the NIC
>>> would fail to find available memory. The same bug would be
>>
>> By "would leak" you probably mean until step 6, right? There are
> 
> Yes, sorry I wasn't clear!
> 
>> always many ways to shoot yourself in the leg. Even if you clean
>> up in 5, the user can just leak the socket and get the same result
>> with pp starvation. I see it not as a requirement but rather a
>> uapi choice, that's assuming netlink would be cleaned as a normal
>> socket when the task exits.
>>
> 
> Yes, thanks for pointing out. The above was a pathological example
> meant to describe the point, but I think this generates a realistic
> edge case I may run into production. I don't know if you care about
> the specifics, but FWIW we split our userspace into an orchestrator
> that allocates dma-bufs and binds them via netlink and the ML
> application that creates tcp connections. We do this because then the
> orchestrator needs CAP_NET_ADMIN for netlink but the ML applications
> do not. If we delay dropping references until page_pool_destroy then
> we delay dropping references until the orchestrator exists, i.e. we
> risk one ML application crashing, leaving references unfreed, and the
> next application (that reuses the buffers) seeing a smaller address
> space because the previous application did not get to release them
> before crash and so on.

Makes sense

> Now of course it's possible to work around this by making sure we
> don't reuse bound buffers (when they should be reusable for the same
> user), but in general I think in the socket use case it's a bit
> unnatural IMO for one socket to leave state behind like this and this
> would be a subtlety that the userspace needs to take care of, but like
> you said, maybe a uapi or buffer lifetime choice.
> 
>>> reproducible with io_uring unless you're creating a new page pool for
>>> each new io_uring socket equivalent.
>>
>> Surely we don't, but it's still the user's responsibility to
>> return buffers back. And in case of io_uring buffers returned
>> to the user are not attached to a socket, so even the
>> scope / lifetime is a bit different.
>>
> 
> Yes, sorry, without understanding the specifics it seems your lifetime
> management is different. IMO it's not an issue if we diverge in this
> aspect.

In terms of devmem that would be if you attach userspace buffers
to the netlink socket instead of a TCP socket as mentioned above,
not that much different

-- 
Pavel Begunkov

