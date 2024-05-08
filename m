Return-Path: <linux-arch+bounces-4270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8048C013C
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08C61C22E48
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBF12883C;
	Wed,  8 May 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4ZTjST2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB712839E;
	Wed,  8 May 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183069; cv=none; b=pgUf66C8Lf1D7unmWJRCnNDRs2/JOayOWCM8KMXdYKn+Ta85NxYlDfNoKUR0cJMwxN4R5ALEQlwB2ZLKmYWHN3Bj16t5OSaWUlU4YeHBAni3js5UgIk2YLRFSihzkW/KChbjqN+eaXb9CaxbbmN1DHc5CyOij5CGsMRuPtuwslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183069; c=relaxed/simple;
	bh=kYkH3GQ8ASJnV40LkgFncEJhg6ZPhWJ+ixUSgcyTt5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOQ93AJoQw6Cs1FmKxHbg9fb7VnwFMaZ9SkbR0MfOEMXNB26OuTgzyIKC3MGa9xejYvn9b7hdbZFb4euMZEsO/hfsJSvU5TBLiV9pPzFzcq5Rw87htCOGcoCaNqM0LlYCpgonsGmTHHAJhJ0lena93W/pFIgTSa73BiVSAQHP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4ZTjST2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572adaa172cso1944341a12.1;
        Wed, 08 May 2024 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715183066; x=1715787866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQJE9gf7KB48yGwLoojwH5ddpfi3k3r9Ytiu480CbPs=;
        b=D4ZTjST2J0LHRW5zE/BvfGtWzm+6QcrPh2Q+5c8ON1LKBDNlFBzLEk7p8VbOSnIWwR
         j4Qv4V22IL6WKC+o1s5cfrTDm6B+qYkCupM8OHnyWPlAzqFeE0BHTBXI4obems13Tl0+
         JFnWOoC+wPywj6jd4t8RJl2WHtJdLFPkxHY7KtSVi3PwvuuTbU/WWZ2sEnIsIO7o8g0Z
         w2GfZ2ObTAtHrKLLdrwGE+lvFdM59kLuGjC2Y6l8tvxQA1sGu8Nup/Ww3QNVdKuwGKnR
         qem+kxllPsvuMWrWHIR0K9OiS6vK85lcOKDWFEXR9wYHSqIKDOjdoQaBrIKJ57edXOvu
         Ah0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183066; x=1715787866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQJE9gf7KB48yGwLoojwH5ddpfi3k3r9Ytiu480CbPs=;
        b=xKn9fEzlR7mg8j7NL5k0DvAlPdGSLfDILF4/wBSQ4aacEt/3L0Vy+1iUSnz0mKdJ4l
         lXhT32coNKjtfdYpTc3r51QFrq+TdNMb8NQQGTZH62mqT6yiL8uUm/Fu0B/M6emSCv8o
         pW8tG8qZIl/Ihj1PARrgHDHkAjJ8Ck5O/Yv0Kh6qxQTojgdvfVcouuSupSJ0UCA92/cm
         JV2un8AhGyH+i4QtEOIB61CZm/NW62tiiVKupJUgYNmcmRyAli/G55xhjozogCiMzDEJ
         NAY5h7+jBBq7ZHdndipQNXOsX04Hx8eBLLePfAqWtog7CuvQ16M16mc4c0+ogPtGoJJl
         QiQg==
X-Forwarded-Encrypted: i=1; AJvYcCXvPfwewo6F8HQGVbxutB28KEooVEHRftnyGoKXD3PO/2xg12tE97L22k5cu+ksL7qPzixRlYBrNpliBWNpZtnSQrlI8rmopL/9ie1FlWNcqwZavg2sgqatuJb5L9rwzrzku05+J8yxeR6EkiIo+d03XdRkj+kYZlXPkPoua9i+MN1LKwMrYT9vJ1tsdlxiDQFV5Y9kjJa1PgOtFgAXwbIVBblCE0/o8W1VQu43jZl/lHXvXszxfrQ+QeeOiGO5lQsrPc90MSzkzpwbKVG1YqgjOBCi4BHN6i2Z6AzukjBTOj4VWY+I6ER9ZmjGnIn2Bmz4SjHn6hpv9Civ6XJ4rp8fXING7NSTVFoAi3MfJWzeGM6X/soIm1qzDYkn8/oWZq4dFimzqPRgxdUlc5RwIaWUlDzd3u0b723Gg/TYBPEVmTbnpbgJ/GY9+WDjM+D7emXJ/72NuxrWL5thCXqQEjzWHHfWLNMCWEfP5M91RFI9pL5w0MKLOVcekuX3fjYyHqZsoKx7+g==
X-Gm-Message-State: AOJu0YytoznEv2AR4a6CWvCBsLQ+WYiZmRLhvwAT6ORu9uiEb0ZbGsPY
	qSJdBfFwDX6fdspT676VHdpBuwZR59diRmkDdmK46XG8Sz4lYJuCEZK2FX6E
X-Google-Smtp-Source: AGHT+IE5Nm674D55fDuDNAiohan1HsOJY3ZoiOdnVUCBNyXk04j1w8UnHxZIePZoq8yZeGceb/9ETQ==
X-Received: by 2002:a05:6402:1bc6:b0:572:e81d:6e70 with SMTP id 4fb4d7f45d1cf-573328e4e6dmr20330a12.15.1715183065606;
        Wed, 08 May 2024 08:44:25 -0700 (PDT)
Received: from [192.168.42.40] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id er21-20020a056402449500b005726e5e8765sm7691323edb.3.2024.05.08.08.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 08:44:25 -0700 (PDT)
Message-ID: <6f69694b-4281-45a6-92aa-d9d72b918df2@gmail.com>
Date: Wed, 8 May 2024 16:44:32 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>,
 Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
References: <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca>
 <54830914-1ec9-4312-96ad-423ac0aeb233@gmail.com>
 <20240508142530.GR4718@ziepe.ca>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240508142530.GR4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 15:25, Jason Gunthorpe wrote:
> On Wed, May 08, 2024 at 12:30:07PM +0100, Pavel Begunkov wrote:
> 
>>> I'm not going to pretend to know about page pool details, but dmabuf
>>> is the way to get the bulk of pages into a pool within the net stack's
>>> allocator and keep that bulk properly refcounted while.> An object like
>>> dmabuf is needed for the general case because there are
>>> not going to be per-page references or otherwise available.
>>
>> They are already pinned, memory is owned by the provider, io_uring
>> in this case, and it should not be freed circumventing io_uring,
>> and at this stage calling release_pages() is not such a hassle,
>> especially comparing to introducing an additional object.
> 
> Something needs to co-ordinate when the net stack's allocator is done
> with the bulk of pages and when io_uring and do the final
> put_user_page() to free it. DMABUF is not an unreasonable choice for
> this.

When a page pool dies notifies io_uring via the ->destroy callback.
Vise versa, when io_uring wants to terminate zerocopy, it releases
the interface queue, which kills the page pool, ending in
->destroy again.
  
>>> topic to me, and honestly hacking into the allocator free function
>>> seems a bit weird..
>>
>> Do you also think that DMA_BUF_IOCTL_SYNC is a weird hack, because
>> it "delays free" by pinning the dmabuf object and letting the user
>> read memory instead of copying it? I can find many examples
> 
> It seems to me the flow you want is for the driver to allocate a page,
> put it on a rx ring, process it through the netstack, and deliver it
> to io_uring. io_uring would then sit on the allocation until userspace
> it done and return it back to the netstack allocator.

That's right, with a note that "driver allocating a page" is
not a alloc_page() but grabbing a user page/frag  the user
registered beforehand.

> Hooking the free of the netstack allocator and then defering it seems

FWIW, it's not about page pool's ->release_page, it's a slow
path and in an ideal world wouldn't be called outside of tear
down.

> like a weird and indirect way to get there. Why can't io_uring just be
> the entity that does the final free and not mess with the logic
> allocator?

Then the user has to do a syscall (e.g. via io_uring) to return pages,
and there we'd need to care how to put the pages efficiently, i.e.
hitting the page pool's fast path, e.g. by hoping napi is scheduled and
scheduled for the CPU we're running on, or maybe transferring the pages
to the right CPU first.

Compare it with userspace putting pages into a ring, and the allocator
taking from there when needed without any extra synchronisation and
hassle just because it's a sole consumer.

-- 
Pavel Begunkov

