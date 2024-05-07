Return-Path: <linux-arch+bounces-4248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B98BEA99
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D9EB21A74
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7516C6AF;
	Tue,  7 May 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD/pUMEk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1BE570;
	Tue,  7 May 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103276; cv=none; b=VjC0QhH1dAc0ygZIessWZO1yFGYIBvlOJ56EQYd2dlHl/J0UzVlo+4VRn/em0Js5NeMxKsEso5yTiOC6b9G3BJhWuBm8O4l45MulyDkXCgYNEGNIB2id1uTEqiaX6VaHGRXYHkE/iIsHJwKlGAek+w58zp+E5uC9+5sGsOnYY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103276; c=relaxed/simple;
	bh=hkmSpCfY2pGETcTniSOSjKGIbKjU6zGXd/p45e1CGy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LB7QkhPYFT+RZNTNejzqlTkb+54C+/NjnEnvnR1ojxdpTMrTcyWZWy415XL6PuXsRDsV9VHDR7GCh473g7RCW/Q1+T+VJ6uezY7+pVSN2FcrV+iNAcYhAX4gIl7iQAQUAEDO3D2DgfjaOY9LtyB6JSfsBMzC8vfiTr0mXm3YigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD/pUMEk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51ef64d051bso2744763e87.1;
        Tue, 07 May 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715103273; x=1715708073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ix/QxWf0/ikFiOadZQO4gRsywekkLf0Td8sGVeNMKyo=;
        b=RD/pUMEkWyThGhfipc8589F/jMhkVh8PJ3N5UOIorpeLtHpGnZGV+zPvRn0eXeeC89
         5Tc8LB9WeNCWpjgUnZVvnboPdncgu7pC0z1usBtEI2vWzoEvKG6DMkay3OGWA/mReghI
         FEe9rYpYdHF0tuPpvzCeZJhK3GXU5jsB+ivcr99U5+Wix5DgiCcbnVFdy5eazSfsRnbf
         rHOxGb0zCwI7RkqPv0B8mFYD6Vx1xko6VrIj3DCL6ADLaBjiDvn+Uoi+/V9T5umSdsnp
         f3Lzeyla4D4CaeVVhmsl4X7WsOsd6vvewAs1vkesKaTDkwq7ihDprI5seVIBg4TRtn5G
         T23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715103273; x=1715708073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix/QxWf0/ikFiOadZQO4gRsywekkLf0Td8sGVeNMKyo=;
        b=e0RuIXjowtf2wAi78oEE6qA0Gwe7nHpy2cVr7iVNjhxVQtrxC2IJ6UgzzIR3eytsa8
         f6uprBC8Bst7FAa/QeivvgFDFQAElVk8zFAempPIvr5OToZgFe3VWDX2hG8Ax1InmaNV
         5DvgqCqHQ8ZQaPytrXqgQ0GWE+sCXRnMxJKXHmKGVq/+Kiaxl3z4lrPbHaT5sxEF0b5p
         ZhPI1IhoGgcjOWa8Uot+RGXJuaxbh+oXWxPawyAmH26XtM8hVij/LEMSa3B6QPdPphyl
         eFp1I5VU5LNs3jXM8q9pR3f35IiCCTqQLxcyDF5MYYuiviXcUGtB9E1onf0uXprN4kGU
         t9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWAiRp/gu7ilgr7U6BCFj6++dNT1zD1UAu7ardBPaJw1oouKt7z2MFMfAlT6idhRA+ZsdsAjVFpOZ9rf5T2KoCqNDlaujMig72Pjopg5FgSGTj2JlGenAS7qHqKD1iH9MdAfG6TjymSpmWjKk3yIJfCMT7k0cfv47UYcXCdyc7KqADlpVgjGxuaW/PVOvWF8gMZpM0lPyCzePnaP008N/wAzwGeeXDoPFx0TxZ2iycbWhZ4OVY2gALqgMzQ++G1dXyio9lMJX+E7dkc4Na4pflAcC1useZ68vyPLoSxNaqSP1v1Xa7JoM4jyh/agJEyuWlfk6XzDK2iVzLw69KForO4YT5dAaOQ2dtWrqDKVMa+e7z5dcb/A764IB/5bD6KN+fq95qAXXVdThEPfPgYfsItlw0XGEV5iHc4FPEm5h/4ObjQdcedBWQpNp+aC59L0PeNMK2NFwMcLT1kxUc/irQOx0mLSTvOxkaAGigrcqZ9C1s9ubTcwmDppT/UNee/dDI9ZbS8vA==
X-Gm-Message-State: AOJu0YyutIejzXqTxSGY99N+EeLBN7Lr8Nl4DfKVFO5Pg+v8GQwGyVsI
	MLvA6RVNoZHhPsxLp9dm1Bx3iAvLmyXgjw6sohuOZgndziMT6S9M
X-Google-Smtp-Source: AGHT+IFwBZaOv+SBhnHvVRoQ0ogfQ2GeK7ijkmELIpHxY/887/bhXSwiTzeGZmrx+/5btYaXXDo8Dw==
X-Received: by 2002:a05:6512:754:b0:51d:998e:e0c1 with SMTP id 2adb3069b0e04-5217c26e844mr150973e87.13.1715103272504;
        Tue, 07 May 2024 10:34:32 -0700 (PDT)
Received: from [192.168.42.69] ([85.255.235.91])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0041b434e5869sm23985466wmq.43.2024.05.07.10.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:34:32 -0700 (PDT)
Message-ID: <d0610fa1-562f-4d4e-ae84-2a0267316c32@gmail.com>
Date: Tue, 7 May 2024 18:34:39 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Christian Brauner <brauner@kernel.org>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Florian Westphal <fw@strlen.de>, Yunsheng Lin <linyunsheng@huawei.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>,
 Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>,
 Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <54b1bf11-0f9a-4e9e-9e5c-7d81e066fc7c@gmail.com>
 <CAHS8izNL-phg3y9xiQbx7A2wQE3ZZKXiQA0oFW9mgj4ONk7GSw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNL-phg3y9xiQbx7A2wQE3ZZKXiQA0oFW9mgj4ONk7GSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/24 18:15, Mina Almasry wrote:
> On Tue, May 7, 2024 at 9:55 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 5/7/24 17:23, Christoph Hellwig wrote:
>>> On Tue, May 07, 2024 at 01:18:57PM -0300, Jason Gunthorpe wrote:
>>>> On Tue, May 07, 2024 at 05:05:12PM +0100, Pavel Begunkov wrote:
>>>>>> even in tree if you give them enough rope, and they should not have
>>>>>> that rope when the only sensible options are page/folio based kernel
>>>>>> memory (incuding large/huge folios) and dmabuf.
>>>>>
>>>>> I believe there is at least one deep confusion here, considering you
>>>>> previously mentioned Keith's pre-mapping patches. The "hooks" are not
>>>>> that about in what format you pass memory, it's arguably the least
>>>>> interesting part for page pool, more or less it'd circulate whatever
>>>>> is given. It's more of how to have a better control over buffer lifetime
>>>>> and implement a buffer pool passing data to users and empty buffers
>>>>> back.
>>>>
>>>> Isn't that more or less exactly what dmabuf is? Why do you need
>>>> another almost dma-buf thing for another project?
>>>
>>> That's the exact point I've been making since the last round of
>>> the series.  We don't need to reinvent dmabuf poorly in every
>>> subsystem, but instead fix the odd parts in it and make it suitable
>>> for everyone.
>>
>> Someone would need to elaborate how dma-buf is like that addition
>> to page pool infra.
> 
> I think I understand what Jason is requesting here, and I'll take a
> shot at elaborating. AFAICT what he's saying is technically feasible
> and addresses the nack while giving you the uapi you want. It just
> requires a bit (a lot?) of work on your end unfortunately.
> 
> CONFIG_UDMABUF takes in a memfd, converts it to a dmabuf, and returns
> it to userspace. See udmabuf_create().
> 
> I think what Jason is saying here, is that you can write similar code
> to udmabuf_creat() that takes in a io_uring memory region, and
> converts it to a dmabuf inside the kernel.
> 
> I haven't looked at your series yet too closely (sorry!), but I assume
> you currently have a netlink API that binds an io_uring memory region
> to the NIC rx-queue page_pool, right? That netlink API would need to
> be changed to:

No, it's different, I'll skip details, but the main problem is
that those callbacks are used to implement the user api returning
buffers via a ring, where the callback grabs them (in napi context)
and feeds into page pool. That replaces SO_DEVMEM_DONTNEED and the
need for ioctl/setsockopt.

> 1. Take in the io_uring memory.
> 2. Convert it to a dmabuf like udmabuf_create() does.
> 3. Bind the resulting dmabuf to the rx-queue page_pool.
> 
> There would be more changes needed vis-a-vis the clean up path and
> lifetime management, but I think this is the general idea.
> 
> This would give you the uapi you want, while the page_pool never seen
> non-dmabuf memory (addresses the nack, I think).

-- 
Pavel Begunkov

