Return-Path: <linux-arch+bounces-6128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFA94D3DC
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4029128173A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AE1991A0;
	Fri,  9 Aug 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4XRIGju"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCA1990C3;
	Fri,  9 Aug 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218323; cv=none; b=o77Qps3mt2JAQoidVyVSxRUAu7eRZgeVpFxy/IttbUJgbPQwrRg6rHqzYpU1OaVhxau9fY5oZMBtHUUK1u0bghz6UaK92ChQ4wcw3oPQ7jx1vEih8EvQfZZe3BEC0XCX3I4KFNrRz1V6kstggbuZ8kLFLNHbeU1v8gerpqdZuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218323; c=relaxed/simple;
	bh=Bd6gp8vS1KnlhuO7wKJxo1DLFOwvyo1WP/CqGQTLnXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXcOi6frJN0oXRrUnuo1RRu7xLeXIFz/3dqz6btKCPsYmSuDF+/qQaBocCkzZMmddp0xHS4HfEpZpyJhYMFGUqYh7yMivcArpPTH4muRpfXCz17b1tsvP0bWiB7E9iCEjXtvrpZLUDdU/rPdoXovkQHIKIiPcFYXq8hEroEc9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4XRIGju; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so366688866b.0;
        Fri, 09 Aug 2024 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723218320; x=1723823120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wa1W3WV7VpGrEaPcisbcd/cWnkBoUbT/sIRi8LearZg=;
        b=W4XRIGjulb1hhqjAyCp1O8TsdHK84PqMuKKM93hSEjVdTnLzQkSRL90qAOFYqhdc2x
         GHHRQ6iOT4UtmN3GVhlzQjLa0vDteJEAyLn714ra0LYy3BuponwmsNGMW/Vslir6VdCC
         v+hTJYFqi3DEF+FXs2c6a4WeWQ8IerANOeYarjUGhAP4fxi/3U992SwlEA2kuBFZopgb
         XkxENzw3feEJkIzmv5il4b/5DJAJb8mLi8fNOZrvMQpxWz/SBRJXJ4GHzhwDqmGAQ1ou
         BtpoCepeF9L/xlED6ZgqbH1/56yaTKh4461zxjnMxi8WFonr1C7T14acXOjq/DSDHhGH
         SzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723218320; x=1723823120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa1W3WV7VpGrEaPcisbcd/cWnkBoUbT/sIRi8LearZg=;
        b=xIIjkLwrXoma+d/hYXaVKjoUW1yxiBMWJvWC92d95xm7YMETni6VkPKuvGxvPQ1Hj5
         ihjFrxc5mOzKA5ip9CedgUaTV0a+n+cEilyOXuU0SxVOLMZrm8/6INcJ2g3P55QAqsUw
         6JBqubANfazW+hgyh5Ldt2s/rrIgMNgFZQsgMI4+wRjyRJ33DMqPyQwqSOO3608YBAkb
         d1HdD5voBvpsBxDPplLg7nqcOfJJRCmbzT27Uq/bVnc/MoqtFMkjZkIm8PJwPXehDDaS
         gVpr33Atdn4Yueq+8URtwyooMjld6L5GQwyJx12/RIBYMd15rOgd5gWcrI2tyG5KGyuA
         Er8w==
X-Forwarded-Encrypted: i=1; AJvYcCWh11OvVxxylBmePJXMeNLWZ+psob5agcVwUIU/0NtWNfocc+5cedl+ogFaUWOceQKCLbtZqMz50Rbo4yz22maNRgxDE7zigUXbA+o3vxjqJxDDXeoiqIrUv41LrExF8L2yHawBAK5b4frFexEt6CIfv425yjuTYD6DbAh7zWS3PGHRZupYAw3f79UqzF5Xl/GCi3A9MlPqHAxbVoA3uuxNNSJSq66UQoUEqKVKuwT8INUFXHp8r8goCKUniByQzBpYm2SI9Gth6QBPYw6e0qQFbDn6sDRIzpPVfgmIWLyHSFpt7105PFi+ynhB1CPkkAyrGUzE0zJZAzPANOx/L9aIDbEaJQsYxEYGehaQ+QV9LX3lj33R/LwICNcjIlfhgKz4AoKH9ARGIroMLK1BkPFlrrBXl2zc3stNyqxNLUFrifK3Nmkz8zx/+Wm69cDg6h2A5unnHqqFBSBY4dkPdPGO+k/v2p0mixd5dWMTQQ==
X-Gm-Message-State: AOJu0YztZaIFx2AatPbhRTbcpSwEYFLaToikQzct0+VFDUdUET4TcY1T
	p415RZPlkcrbJfWwFG9Akvf+TP3khg7Me8ee0W4qFUopFUfLkGn7
X-Google-Smtp-Source: AGHT+IGaWJiDPaSc3UHkzWGM2j8RhpJMnAUdZZgUzu3ws85xIf7phwHYyeL4ZJReXHb3Sd+69ayIRw==
X-Received: by 2002:a17:907:6d14:b0:a7a:8a38:9d99 with SMTP id a640c23a62f3a-a80aba196d6mr130567366b.35.1723218319823;
        Fri, 09 Aug 2024 08:45:19 -0700 (PDT)
Received: from [192.168.42.29] (82-132-212-15.dab.02.net. [82.132.212.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e77sm847390266b.169.2024.08.09.08.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:45:19 -0700 (PDT)
Message-ID: <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
Date: Fri, 9 Aug 2024 16:45:50 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/24 15:10, Mina Almasry wrote:
> On Thu, Aug 8, 2024 at 10:24 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 8 Aug 2024 16:36:24 -0400 Mina Almasry wrote:
>>>> How do you know that the driver:
>>>>   - supports net_iov at all (let's not make implicit assumptions based
>>>>     on presence of queue API);
>>>>   - supports net_iov in current configuration (eg header-data split is
>>>>     enabled)
>>>>   - supports net_iov for _this_ pool (all drivers must have separate
>>>>     buffer pools for headers and data for this to work, some will use
>>>>     page pool for both)
>>>>
>>>> What comes to mind is adding an "I can gobble up net_iovs from this
>>>> pool" flag in page pool params (the struct that comes from the driver),
>>>
>>> This already sorta exists in the current iteration, although maybe in
>>> an implicit way. As written, drivers need to set params.queue,
>>> otherwise core will not attempt to grab the mp information from
>>> params.queue. A driver can set params.queue for its data pages pool
>>> and not set it for the headers pool. AFAICT that deals with all 3
>>> issues you present above.
>>>
>>> The awkward part is if params.queue starts getting used for other
>>> reasons rather than passing mp configuration, but as of today that's
>>> not the case so I didn't add the secondary flag. If you want a second
>>> flag to be added preemptively, I can do that, no problem. Can you
>>> confirm params.queue is not good enough?
>>
>> I'd prefer a flag. The setting queue in a param struct is not a good
>> API for conveying that the page pool is for netmem payloads only.
>>
>>>> and then on the installation path we can check if after queue reset
>>>> the refcount of the binding has increased. If it did - driver has
>>>> created a pool as we expected, otherwise - fail, something must be off.
>>>> Maybe that's a bit hacky?
>>>
>>> What's missing is for core to check at binding time that the driver
>>> supports net_iov. I had relied on the implicit presence of the
>>> queue-API.
>>>
>>> What you're proposing works, but AFAICT it's quite hacky, yes. I
>>> basically need to ASSERT_RTNL in net_devmem_binding_get() to ensure
>>> nothing can increment the refcount while the binding is happening so
>>> that the refcount check is valid.
>>
>> True. Shooting from the hip, but we could walk the page pools of the
>> netdev and find the one that has the right mp installed, and matches
>> queue? The page pools are on a list hooked up to the netdev, trivial
>> to walk.
>>
> 
> I think this is good, and it doesn't seem hacky to me, because we can
> check the page_pools of the netdev while we hold rtnl, so we can be
> sure nothing is messing with the pp configuration in the meantime.
> Like you say below it does validate the driver rather than rely on the
> driver saying it's doing the right thing. I'll look into putting this
> in the next version.

Why not have a flag set by the driver and advertising whether it
supports providers or not, which should be checked for instance in
netdev_rx_queue_restart()? If set, the driver should do the right
thing. That's in addition to a new pp_params flag explicitly telling
if pp should use providers. It's more explicit and feels a little
less hacky.

-- 
Pavel Begunkov

