Return-Path: <linux-arch+bounces-4069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C48B772C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB2B23E4B
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D6178CFA;
	Tue, 30 Apr 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGDkLB6Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A12175570;
	Tue, 30 Apr 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483882; cv=none; b=LNbMPl+/NNTstr8Aqe2Wg5GmEn6xOe9b668l3tX2xADQmNbf72XPyB6ndkhT5j070lIW3o92pRV/l6mdtcxQ5xhm42gXvxYx7muZmQTFATacUw4W8KGWIxUQSAqlizqNk+0MucC3c5kEiTa6rv1kP5SXx/VdJH/DU1HIPxyPvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483882; c=relaxed/simple;
	bh=SuC9FZBFdHxF1mZgxsS3cEgWTqlhBFUTnYsCDjyTNtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC00rlowCeXRadA/6XkeLdmWhGYisXKP7liXe1wRROjAXuFUoRG0vSSaslhyTlMZXKkjEd1kG3e8EuhFTr/3NDQ1c2q0YAedM8Y3B3YnVMfAv/to9n111W+88DEaJ6OCpW6Po32B+B0uzAipNrKpDiu0P5FAQ4k0Ld4P/1R0gcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGDkLB6Z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a556d22fa93so620037066b.3;
        Tue, 30 Apr 2024 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714483879; x=1715088679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQkyBn4Lnt15qpQKjjn6/FTdXdojZaggT0oJDgNx33c=;
        b=ZGDkLB6ZeQHM7S3Is+kCTnTiARqKq4qV587fbHYAro6WfXbhqOJl4xElhj+paZsYmf
         zsAUaz2PKpwWr/nReu83KrPWzL6GJ3NUIxxkikoY8QndVlFBB2kiW68I82oyP7jC6rRy
         Kue90XOs9J1KUp/gg2ntdEqvPa2dNn7gTu+YQBJukKO9o97AEgFgOwO/3/oDzmTNYn7Z
         y11S4Gq7YyhptxbmCSG4fqN/oKfSdHaJfTjR+/gghddtiAmMsnce6A9NKgDCIc8BdxRr
         259AoX88DoDPU3UBi4BHE09WQIb1BCfB+Y6qiyc+rt/Pb6Hau/+OsPS5FrxyhRdjsoO+
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714483879; x=1715088679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQkyBn4Lnt15qpQKjjn6/FTdXdojZaggT0oJDgNx33c=;
        b=JAcftVU9819Df72KVKUuHnMPN5upC2nEnDHOXmwiHa/Mqd+nmSAv3AMwHfJtBagS+e
         cT4dtJMHpeiKwD8GOBBfy7z9s+FlYWcf8y8O5DNvEbZ3jmEGdrqyeDORwHPNtJheMH8u
         wbr8sgNO5kk1/HagI63jfYfPZwnByelcETO0aRYQuUgULnKKWyrBVDRskUDNMqTI48+k
         Scnd785HFs5P9LWN4GE3HWvYb1Vr7EbjCdPGIYTLiprCO5P9LexLTNzWT1FY3dzcvFGe
         8m82EnqztsJ+xRGTCSXLCXolzX7vhAll+CV5KiHaYTWPwu8g1HR9KqJcWBL0x3QmA995
         /xXA==
X-Forwarded-Encrypted: i=1; AJvYcCWO3Mh4iihGe+Ze3I9w69Mb8md/2Vgbcuk/pLV58IhsuuR2WJFdzyOfltYCYnTAzhyC3Q96pMnb/hapYki6ldbplKvipp/UGR14OMd7t+nyiHg9UAEhuQyqT390Cak0Dp389zqiVBmq8K56IZOWCR8LL7yrlDLr2eY7tghHxSHpoHbqi6gG11LFCEFiamASp3Vrj8sSNxwdF3/F5xLeXnqUhkRjJqFPXVMh4gGkdCMqR1e8LsIHJbmvUqAQjD+Plg/Xl64uBE2w1oL0lHwfzLclfEkOhylIGPpOYN0HOcP6L6hr4f568biULGqbqyAzHy+JxxkK/4RF2UQCccyO5l2TEBEKp0GpRMmu0l8RZU2Y/sDSbbOEDEI7+zWPY+EmYTeaBzOlsJQtRv9FwrepTHNgSLpUZDI/61aJJ5X7bi3PfaaLuxs5TehX6+ZnU5donnEdr74tYqEGIpcQNFOXqKitiOaOjKw1UyKmuRb9EQ==
X-Gm-Message-State: AOJu0Yw6lPjiuEN734nsx/qsNMGgMZPKsd83Z7mLWp1YTakIoYgSLDHK
	97DEipXt50d6B6REktqCeL5bFxAzsqNHolJf7BHCzaFFBuLw0vNj
X-Google-Smtp-Source: AGHT+IG4D9H/56/A4rQ0pU5al3G+zQuIMq1mBSgq9KUwXS9Rk/+kL4o0ZAf4JvbTFbHU0G4DNFxL/g==
X-Received: by 2002:a17:906:fb17:b0:a58:e74b:7e16 with SMTP id lz23-20020a170906fb1700b00a58e74b7e16mr2032608ejb.46.1714483879081;
        Tue, 30 Apr 2024 06:31:19 -0700 (PDT)
Received: from [192.168.42.188] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090615c900b00a555be38aaasm15011385ejd.164.2024.04.30.06.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 06:31:18 -0700 (PDT)
Message-ID: <35a79edf-e4ca-4501-99ad-231a3ab2b216@gmail.com>
Date: Tue, 30 Apr 2024 14:31:33 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 Breno Leitao <leitao@debian.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com>
 <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
 <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/27/24 03:11, Mina Almasry wrote:
> On Fri, Apr 26, 2024 at 5:18 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-04-02 5:20 pm, Mina Almasry wrote:
>>> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
>>>    */
>>>   typedef unsigned long __bitwise netmem_ref;
>>>
>>> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
>>> +{
>>> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
>>
>> I am guessing you added this to try and speed up the fast path? It's
>> overly restrictive for us since we do not need dmabuf necessarily. I
>> spent a bit too much time wondering why things aren't working only to
>> find this :(
> 
> My apologies, I'll try to put the changelog somewhere prominent, or
> notify you when I do something that I think breaks you.
> 
> Yes, this is a by-product of a discussion with regards to the
> page_pool benchmark regressions due to adding devmem. There is some
> background on why this was added and the impact on the
> bench_page_pool_simple tests in the cover letter.
> 
> For you, I imagine you want to change this to something like:
> 
> #if defined(CONFIG_PAGE_POOL)
> #if defined(CONFIG_DMA_SHARED_BUFFER) || defined(CONFIG_IOURING)
> 
> or something like that, right? Not sure if this is something I should

Feels a bit flimsy, if the argument is that you want to be able
to disable netmem overhead, then adding a netmem config option
sounds like a better way forward.

I have doubts this conditional handling is desirable in the first
place, but perhaps I missed the discussion.

> do here or if something more appropriate to be in the patches you
> apply on top.
> 
> I additionally think you may also need to run the
> page_pool_benchmark_simple tests like I do in the cover letter to see
> if you're affecting those.

-- 
Pavel Begunkov

