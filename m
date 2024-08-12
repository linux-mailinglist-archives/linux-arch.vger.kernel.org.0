Return-Path: <linux-arch+bounces-6165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703694F706
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4201F21E70
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1718CBEE;
	Mon, 12 Aug 2024 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGzAI2Xh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE118953F;
	Mon, 12 Aug 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489047; cv=none; b=hNS2STUYaHXFJSGz8WEadRCf1ia47th6Hf0H4CscnOGPMSOwOqwgytUvrknHzl3M+Tz3yl3ekl5iuxk15eawUQ86ijbMeTooRxIBsUYqi/jIFT9DKAR5Up8KHa+Xhq5bj+mmmgssFfnCWvk3mTrlfWNyTd5cJ/ne7MHpzNQ7nzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489047; c=relaxed/simple;
	bh=d+vCa423I26VhKoMec2FKCuPA7cvb8N4MAocJwx5ALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYMNQT2TMC6EAkk1Rj6zPCJS5xaq82LZo4PTPbolbecmxzY3BOtm0aDNtJTzfS1egn9dSGXayjuYFfNXLEuX34bvbthk3pPosAS4WoJ0vOa9uktQrRccr5aR96oYFwE9ZyQtRpL9JzF4/hvlNvyRNhAzqiafQSYn7E7BEfu71gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGzAI2Xh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so35995155e9.0;
        Mon, 12 Aug 2024 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489043; x=1724093843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2sjbryQMGv4AdoT/U/rNl9kIID6zfJVvTVXlbzwsh8=;
        b=SGzAI2XhVWv/80lWW/PoJSE1ugxN7xQ0TiCZKWItOo85Y0Bhu8mpx+HlbgEE4/KmJC
         W6JZ+7P/B0OP3UiGqijtP0PA3NIeJD45z2thL8sGEivozosecvZ6S7qZm13JNN5DQn/k
         QNBh2Ld0RKu5OB1f5VGgU3tmNL9wdXQh2Wzdhk50+T5/zulO3y4G5k7L7hC8fZAMCfTF
         j3v7gCBCqvYm1qscPbcE7cPUIt8aq7rjqsQTV+4K0ZQ3dZvmPqt6nwsaq48c0xMajM1N
         JUiHMKjrOpEvnDsETK72Aag8xJUJE8xGm12ubE1CRxH5FfmYOCehd8QyhPkTGUA5ZqIw
         vQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489043; x=1724093843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2sjbryQMGv4AdoT/U/rNl9kIID6zfJVvTVXlbzwsh8=;
        b=xCo8z8ugTQP4j+TP0beWVcYxdZpR4NDKJrTUJxlmoHkcQjQH6bMlbd5ImukOmzLYdQ
         e5NLrTlTN14KPFp1QHE8C6a1caqIa4PXiFj2qYllsU8oYn3SE4ZBK3IPMC2cRedJY5n4
         60z5VSPImeiqaT7MXAr5QQ6UjM3+e79TBXmhdsd/OM0hYsSsXa383GrBdmPOU+EeoOL6
         9Up58lO8m0VSLfGLpQ5DNqypPQFD0pwmz7wC7Q+QlwGbUmVwHmnRm/GWgPq+UFRH+zYs
         FGQPHgfC3kLMs/7FE/mpeh8H+IMR7GWqkoGfJq4gkgZzC9Nr/t+RVcAPqZli2oVW/t8W
         3Omg==
X-Forwarded-Encrypted: i=1; AJvYcCUBUl+zE7r6IgRb2r/pI6WMfb+zuCHJmx268cYdh2ziaCPRLgecyJDb4E4JZeYHXBO5pJx4EPcZ9AwVjA==@vger.kernel.org, AJvYcCVsgh5cLBFgF1tt1ZWNC577OeELgLoaHUcNavN49sAJ7h1hnDi8xkQU35IF23mQ3MQUUFonlkq71ImwbAkB@vger.kernel.org, AJvYcCWGgL9wsDCUgPRvucS2LSgPIALUHV9U5tGKleH6nyF7iulED8hs4JeZHvVrhcqDZStBm1E5osHgk/9UaQ==@vger.kernel.org, AJvYcCWJ7gX269yAKTVobHL07Q2GfU/jvfX6IMw2d6PN4p2a5rTPkHIWc+m1QjiEUMs1ffJ+ckxdlVovM5f6F4k=@vger.kernel.org, AJvYcCWJJfMFUhS06+fokNPXi5Qtx2Lfhd7cSW6/dIz71YHg6T6pMoujBPA1VzRpDkyBgMxqw+x2kI/AW+QH5A==@vger.kernel.org, AJvYcCWa1Iu5S7PJl+MJVkhBJKiPlXsGhGAuFF52RisJDxm+WH4zbQg3vyL7qVdflk1C2Rzb2lCATEW8qfcXSSg=@vger.kernel.org, AJvYcCWu56hDKZzEP9XoH4Q1lQAv+FSMr8Uc+yQbsacuV0zs6+O3Evqk/lfqvhuShTnqxftGbNDpO0WNf9aloKpH@vger.kernel.org, AJvYcCX9LkVASVW+UTt48ULUkYwe9jAEPNArRrpCDWE2Jy8z5ozzJfIUiuigWrfF8qKTxQJ5hSiB+bLH@vger.kernel.org, AJvYcCXX9KyCp2pnSVYRbpRx1ovS/5PGszxywY6+Af0/bSLrLpSmtIardNp16735S6bkmTIYKuaRJGenWCjj@vger.kernel.org, AJvYcCXrZN+vJGNJOEqafRDMgEFd
 Fj4YnJU/3OKGyOuqTd+XsRi8HNogx+ggjwA4B7XMEDkavbzoOoimrV6+qdDD5KYzxAHx@vger.kernel.org, AJvYcCXuLEuloxCjkSy83Ui+XXqnDu3SZb/4ouQestXBHnNCPctG6WETRsbmwDXkaJWVD4p3I63t2B7KUW46HrQxeMkc@vger.kernel.org, AJvYcCXudaalqrIgQht6HJyl99zf4VNJkiw2IbbpWRGr+SyDA9CNy5Xuz38WKHhFoQApMPCmxTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Q6Gihw1CJ1fEBwS4hS74QjhtYoAq+GGzycMzul9eWdZDRPTT
	qQ/B21WV0Grfu/yOJl/pi1PzqNW1EAJGxPjck1BSEKO+0fh5qAFQ
X-Google-Smtp-Source: AGHT+IEgvdD1yYp72suiR6P1ehhpzftJmIWivZSP7rA0NRI76nLUeqN5Kig9ZMEqKyVOM8ybyn7Wfg==
X-Received: by 2002:a05:600c:4713:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-429d486febdmr10015365e9.24.1723489043096;
        Mon, 12 Aug 2024 11:57:23 -0700 (PDT)
Received: from [192.168.42.116] ([85.255.232.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36ba72sm8280177f8f.16.2024.08.12.11.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 11:57:22 -0700 (PDT)
Message-ID: <7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com>
Date: Mon, 12 Aug 2024 19:57:51 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory
 provider
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240812105732.5d2845e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 18:57, Jakub Kicinski wrote:
> On Sun, 11 Aug 2024 22:51:13 +0100 Pavel Begunkov wrote:
>>> I think we're talking about 2 slightly different flags, AFAIU.>
>>> Pavel and I are suggesting the driver reports "I support memory
>>> providers" directly to core (via the queue-api or what not), and we
>>> check that flag directly in netdev_rx_queue_restart(), and fail
>>> immediately if the support is not there.
>>
>> I might've misread Jakub, but yes, I believe it's different. It'd
>> communicate about support for providers to upper layers, so we can
>> fail even before attempting to allocate a new queue and init a
>> page pool.
> 
> Got it. Since allocating memory happens before stopping traffic
> I think it's acceptable to stick to a single flag.

I agree, it's an failure case of init path, shouldn't be
a problem.


>>> Jakub is suggesting a page_pool_params flag which lets the driver
>>> report "I support memory providers". If the driver doesn't support it
>>> but core is trying to configure that, then the page_pool_create will
>>> fail, which will cause the queue API operation
>>> (ndo_queue_alloc_mem_alloc) to fail, which causes
>>> netdev_rx_queue_restart() to fail.
>>
>> And I'm not against this way either if we explicitly get an error
>> back instead of trying to figure it out post-factum like by
>> checking the references and possibly reverting the allocation.
>> Maybe that's where I was confused, and that refcount thing was
>> suggested as a WARN_ONCE?
> 
> Yup, the refcount (now: check of the page pool list) was meant
> as a WARN_ONCE() to catch bad drivers.
> 
>> FWIW, I think it warrants two flags. The first saying that the
>> driver supports providers at all:
>>
>> page_pool_init() {
>> 	if (rxq->mp_params)
>> 		if (!(flags & PP_PROVIDERS_SUPPORTED))
>> 			goto fail;
>> }
>>
>> And the second telling whether the driver wants to install
>> providers for this particular page pool, so if there is a
>> separate pool for headers we can set it with plain old kernel
>> pages.
> 
> The implementation of the queue API should be resilient against
> failures in alloc, and not being MP capable is just a form of
> alloc failure. I don't see the upside of double-flag.
> 
>> payload_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED);
>> header_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED |
>>                                       PP_IGNORE_PROVIDERS);
> 
> Also don't see the upside of the explicit "non-capable" flag,
> but I haven't thought of that. Is there any use?

Considering that we pass a mp to page pool indirectly via
a queue

rxq->mp_param = devmemtcp;
... // later
pp_params.queue = rxq;
page_pool_create(pp_params);

How can we create a separate header pool without mp and let
the other data pool be initialized with mp? We can make
sure pp_params.queue is NULL, but API isn't sound, I think
the plans are to reuse the queue argument for some other
purposes.

param_tmp = rxq->mp_param;
rxq->mp_param = NULL;
page_pool_create(pp_params);
rxq->mp_param = param_tmp;

Temporarily erasing mp_param is another option, but I think
by far the simplest is another flag.

> One important note. The flag should not be tied to memory providers
> but rather to netmem, IOW unreadable memory. MP is an internal detail,
> the important fact from the driver-facing API perspective is that the
> driver doesn't need struct pages.

Sure, didn't want to go into describing how these are not
the same thing. Naming should reflect it, and if we expect
providers that don't produce net_iov, we might want to have
a flag in mp_param or so.

-- 
Pavel Begunkov

