Return-Path: <linux-arch+bounces-6166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD494F719
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C841C2221E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1718E743;
	Mon, 12 Aug 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmdO2TXz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D418E022;
	Mon, 12 Aug 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489457; cv=none; b=mKO/fNk+17tH4rTTxdJ4ThlU+N6YJtiDcdf87K+8XOpADm5e6EXYyeUM6CxxWSQdDKjan2HVQuAAMfgEuE+sozGzRqNcPXKkPxAzC5WZNoNNxPnvfb62PLM9NWFKbku510hE3+TvZyPAVKWjLqpSjka2is0a5uRSymvBZxY3dsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489457; c=relaxed/simple;
	bh=ekVc0hNv9qR690ll/HYdObdq5mKMtN/AdT4pvFL27XQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kCC0ZsW4Jv2uk1VolRu+CWrJfjXJNVPEy+yLDdklJ5IokygYXe/JEwpwYzHlVgWU8lmiRnyBfwKV3udFe2QWXoDy3TBBiK+beL0/iCELXvzDoChJ0DigeaW96HlhoDewxEzrvdwHkCeIEJuAxWmChIH6sb7wqBd2EtJ4xiPUaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmdO2TXz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e3129851so34728275e9.3;
        Mon, 12 Aug 2024 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489454; x=1724094254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brVgXhkOlvihiylM1OGt4+AX9JCjvFnxaMYs3eS1Yzg=;
        b=ZmdO2TXz1jW+hW2Hwy2ZmoiWVXyuJBCYXi+a/DzDU6Ni7Q2an1dm+sjiepEUkDL4Ol
         1Mr/xNj2ePJvAO6Gin3jNlVZ75D6qsOzHS4IABM4+cihKwvwawHpHpCBfxqmD5tfn+Ab
         j9uhMU3w2H9SGH4hZVl6T156o8DrwxRxTgm3UszhL8wYQ7+WvpVByLvXfYHzEky/dOEd
         N71XcPNE580QZeGoNgF7lsjTIobxHtI2/+5eUgDPpnC2aKUj/AHwDt4cY1qY4boZKraX
         aW2282PWdPtWK2pQzIybgsP5Wvg6gFhPHcKV7wQ9ELQ6wpORaJb5NClyJf41R76gOHFF
         r1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489454; x=1724094254;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brVgXhkOlvihiylM1OGt4+AX9JCjvFnxaMYs3eS1Yzg=;
        b=m1Te3ToO2hLcCcrzjPHVKip7rqAKNU0CN5n7Z+YocgtCCC1l3i6TATsKN5DBSYPmtw
         Slsd4+g4wMmPDqtvlbRzGsUdeiW/g8tlDQbrvloPHHEyrK3DNwARP/Yy5ZcAVXf0YJRi
         4z2Be30n9vUJ0BjNPPaAlsR9MzBegfkA01lnoTvAOxT1/tP99c5FRzpNc3dRzG8LrNo4
         OMxcErbuCKSt9KrTOLiT0imRNROk/o6coEvk4V/kBQkesH7VqqZtLbsNj8wiPQinzHYS
         UodtgOyaFLH3170CCpuv5w0/GMtkQq3qsf5esuKH9FQqxF2j9vqEAjOGhk1pQGEwEdyV
         LE9w==
X-Forwarded-Encrypted: i=1; AJvYcCX236Vp62H2wlRw1qvpV4p/ifAEy9hjYn0R1OciBBlyunFISk8Y33CCR8nVWuUmyuECCVD3UEdlYWZMKE6JOR3Jv4ZkvPexWouulidziRBGpPa1z4WPl+GptcF8AKeVrEuo4sv9hoOncotRR9ezaMoJ6MEFYPz31w4RCGxYWRVkzWtLnEqCFi1ivFUt9+Euly2qhpcm/a3bK+G1LAh2oVDgV8HJbmpMZgS1tmkKyoCfjcG+mb/f+tOajK3Od8ILz/whi7O09+3/EHfCbYMYd2t8Em9kfSZ3m8VrJbk5uMmDs9x6FtXgFjv8EaGD8AVXg6LDAhcOBpnU2ObSE+6adMq5UlnLEOwjghT/HfotsGst2lKGOEmcSPVZNpfm7UZm8MSwS3rxXYjgVt4PCuOskYktOpmGErAvGGworUKD/2BuvCUfIRQbhj2GrvEfA1bqmQvEqelD1V0H59KIoXYFJiPyQ3cOj2tQjngEArPxo9HK+kGy9wZka395GII2bNdHQeDr/D2tig==
X-Gm-Message-State: AOJu0YywYvIbJRbJlgrX0Ps+suJCod5T9NT+G+sIAZgdhQsK+vZa+ChA
	+0z316SwM7XC9ctSuieq+cnMBtuX7Ai/ND8duVO9jFwT72MFvg5Q
X-Google-Smtp-Source: AGHT+IE8NitdTNHZwd36bF/y7l5NM1Z0CvlWv76a53+AHV7l7aFN8rRP6hTmGYaWZKbXiL82aNMP0g==
X-Received: by 2002:a05:600c:4ed2:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-429d481e867mr9523795e9.21.1723489453434;
        Mon, 12 Aug 2024 12:04:13 -0700 (PDT)
Received: from [192.168.42.116] ([85.255.232.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750ec0bsm111660895e9.15.2024.08.12.12.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 12:04:13 -0700 (PDT)
Message-ID: <71260e3c-dee4-4bf0-b257-cdabd8cff3f1@gmail.com>
Date: Mon, 12 Aug 2024 20:04:41 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory
 provider
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Donald Hunter <donald.hunter@gmail.com>,
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
 <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com>
 <20240812105732.5d2845e4@kernel.org>
 <7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com>
Content-Language: en-US
In-Reply-To: <7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 19:57, Pavel Begunkov wrote:
> On 8/12/24 18:57, Jakub Kicinski wrote:
>> On Sun, 11 Aug 2024 22:51:13 +0100 Pavel Begunkov wrote:
>>>> I think we're talking about 2 slightly different flags, AFAIU.>
>>>> Pavel and I are suggesting the driver reports "I support memory
>>>> providers" directly to core (via the queue-api or what not), and we
>>>> check that flag directly in netdev_rx_queue_restart(), and fail
>>>> immediately if the support is not there.
>>>
>>> I might've misread Jakub, but yes, I believe it's different. It'd
>>> communicate about support for providers to upper layers, so we can
>>> fail even before attempting to allocate a new queue and init a
>>> page pool.
>>
>> Got it. Since allocating memory happens before stopping traffic
>> I think it's acceptable to stick to a single flag.
> 
> I agree, it's an failure case of init path, shouldn't be
> a problem.
> 
> 
>>>> Jakub is suggesting a page_pool_params flag which lets the driver
>>>> report "I support memory providers". If the driver doesn't support it
>>>> but core is trying to configure that, then the page_pool_create will
>>>> fail, which will cause the queue API operation
>>>> (ndo_queue_alloc_mem_alloc) to fail, which causes
>>>> netdev_rx_queue_restart() to fail.
>>>
>>> And I'm not against this way either if we explicitly get an error
>>> back instead of trying to figure it out post-factum like by
>>> checking the references and possibly reverting the allocation.
>>> Maybe that's where I was confused, and that refcount thing was
>>> suggested as a WARN_ONCE?
>>
>> Yup, the refcount (now: check of the page pool list) was meant
>> as a WARN_ONCE() to catch bad drivers.
>>
>>> FWIW, I think it warrants two flags. The first saying that the
>>> driver supports providers at all:
>>>
>>> page_pool_init() {
>>>     if (rxq->mp_params)
>>>         if (!(flags & PP_PROVIDERS_SUPPORTED))
>>>             goto fail;
>>> }
>>>
>>> And the second telling whether the driver wants to install
>>> providers for this particular page pool, so if there is a
>>> separate pool for headers we can set it with plain old kernel
>>> pages.
>>
>> The implementation of the queue API should be resilient against
>> failures in alloc, and not being MP capable is just a form of
>> alloc failure. I don't see the upside of double-flag.
>>
>>> payload_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED);
>>> header_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED |
>>>                                       PP_IGNORE_PROVIDERS);
>>
>> Also don't see the upside of the explicit "non-capable" flag,
>> but I haven't thought of that. Is there any use?

Or maybe I don't get what you're asking, I explained
why to have that "PP_IGNORE_PROVIDERS" on top of the flag
saying that it's supported.

Which "non-capable" flag you have in mind? A page pool create
flag or one facing upper layers like devmem tcp?


> Considering that we pass a mp to page pool indirectly via
> a queue
> 
> rxq->mp_param = devmemtcp;
> ... // later
> pp_params.queue = rxq;
> page_pool_create(pp_params);
> 
> How can we create a separate header pool without mp and let
> the other data pool be initialized with mp? We can make
> sure pp_params.queue is NULL, but API isn't sound, I think
> the plans are to reuse the queue argument for some other
> purposes.
> 
> param_tmp = rxq->mp_param;
> rxq->mp_param = NULL;
> page_pool_create(pp_params);
> rxq->mp_param = param_tmp;
> 
> Temporarily erasing mp_param is another option, but I think
> by far the simplest is another flag.
> 
>> One important note. The flag should not be tied to memory providers
>> but rather to netmem, IOW unreadable memory. MP is an internal detail,
>> the important fact from the driver-facing API perspective is that the
>> driver doesn't need struct pages.
> 
> Sure, didn't want to go into describing how these are not
> the same thing. Naming should reflect it, and if we expect
> providers that don't produce net_iov, we might want to have
> a flag in mp_param or so.
> 

-- 
Pavel Begunkov

