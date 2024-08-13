Return-Path: <linux-arch+bounces-6170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BB694FB7A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 03:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278E7B2187A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFEA7494;
	Tue, 13 Aug 2024 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdO6MD7k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384E12E48;
	Tue, 13 Aug 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514187; cv=none; b=a/L54NEqzJOyoj3bBd3Wvg6v2y8H4UhZsC0zs2ga4m/WnFCpRcGCpHbvSRf+ItzAzvhi2V7bM1ScYCMeYbXriBJJ82PfKCzQu9YOsXhqqt/0qmguN/BhtRluXU7hMDnpZJ+skNpoQm7qkl/3tHw8/vot2rgHExif2bEjY/11IP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514187; c=relaxed/simple;
	bh=A1BZFBBLYKZGwF1UkEhTm3eGr7foQgEE57xJWjji4FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tuc0vOn7iGME8n/Ov6kZIiUC5r0fKRRAO8vUGsImGlfsY3pG+OIe1wmxJibT8cAIhPRJ0exf5K+k8EMwhWsqYj6z3u8jYvXgEZMEgPZBo/oD5s93vNaWEJzWGdjderjkTfFBoP7M9fW4LYE0lUyau5rPOiNFKLbIMCGlZ/MWS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdO6MD7k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so34347105e9.2;
        Mon, 12 Aug 2024 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723514183; x=1724118983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSibsKkWXPTZsPGOBJp3Fcm/0om9Gy4boGmfKowM9D4=;
        b=GdO6MD7kd8vNcfAiiXNd6PbbK0pzlzNycsQl7AFtLPBwUAo+kDgDTEz7+OcBI8+wvl
         BHUO8wnDv5Czk2c+Ccm5xjS+vJiNCbvTxrlyinG+j69sSLhEF7eyYczcKMxty1AbpNtQ
         vETrRT6vRd+lcvGFZvqlPM7xUfe4Z7BQLEXrKDGibdLWi9NBEyu6qDTSmO8qV9snh/2P
         WHDWqQRhJUu1flx61KYIjTRKCtG1uNrkNWYj0pQrGg/rFv/O05JlVhHIytP/7qtw+Kpr
         NNLOZkja+eU7nPvqPHszR7BbVWsLqPfqY/+faS77e/zRjMleEypl5rAlBf/86Vg36i4Q
         LHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723514183; x=1724118983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSibsKkWXPTZsPGOBJp3Fcm/0om9Gy4boGmfKowM9D4=;
        b=pAQ/IH96KlljCXX1jiv1unIoaLETuiGgURpzgBOjFcDZ6kgeDH+HVXChDyslrjbfcU
         9gaCE6ACil+5voBPsQiYzdoHL/e6KGVoqTU6yidrQPCNv4A2ahdJZmHaznqRiiZ32l9o
         ECX/8lQ+3XuzhVsylwjjnZfiR2oVb4ZxzqmAJkyWRzGfEn0KWMgqdTyM+FdaGhxk1Izt
         LLPVv/patMwqjYN/oAP1/i3m/P++dI4HEsaVAsC87RHT22fACkXSqOEZFgXN3nTnlYqz
         6vQONvLLxWzkA1uD+BK2cdQ8LLbLjQmiircb/m6jzlIiqAX+06RIkawmeLZexSWVO938
         LNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsrK7Z45ongMkYy84YAWTKOqkpqHiP8kHnoRJdaCU0rm3W1m6rIskCPbE3aD036nVYCqqd1LWtaPIVSJqeydLf7QyVGrdcchCcojHdgBERwxmvEgxcuiYoikRuZW4G8T3uCdtSVSD3HXzekviMXcV1pLPXLgJJVoCBOapkQ1Pj+q5vVDytiBuQdHhZ5s8TNyk2Rv+YSyV83Z476aLLc1XEwlFGIfLQ1ErFMYKb9e3MaPoXrw0rckAVGyi/iJ4/4E/Xy39beLGqxZYHsuKnKkuAXoJT+SDwhkVHN/PoxcvQLw4Kkwk6LlvyDJC+D0MyVSpQX6Fm7c78t3aqmOKMDOSFUj1QPioEoedjgdHKgmk6nujLD41V5dp96BrCA/RzQNpYCacB2CiU+pLPnX8pmvNIJGoaY9GIvDJmkc7+4DDzuUyGGR7wWp+VTtbirSWhDV9Lfd/Wv16MIGWX3fgvCcodYz3OMulikpuQKdew7li8Eg69ppSCjCtqQblDkuukGCAwlWQHeQ==
X-Gm-Message-State: AOJu0YxU9zwCsA6ASu3EM+MiOrQb1b4y0t4kiGUlPRzGs5R9vUfON3D1
	7UwzrFVydIydVKOpWrItBq3026aPU9OVqBMYdHCEfFN2ElC+z2Rd
X-Google-Smtp-Source: AGHT+IG2cxhEUGEjchcaIrhqVTsKQUiFNfY0aoBbKWG/+9xydhrcFsfo82Q+iGvABQKDqUAFqalXDg==
X-Received: by 2002:a05:600c:4fc5:b0:426:5dca:50a with SMTP id 5b1f17b1804b1-429d481da7bmr14330075e9.21.1723514182757;
        Mon, 12 Aug 2024 18:56:22 -0700 (PDT)
Received: from [192.168.42.116] ([85.255.232.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7618b9sm209629205e9.30.2024.08.12.18.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 18:56:22 -0700 (PDT)
Message-ID: <23be8495-53d1-469a-bd9d-4dc2295be71f@gmail.com>
Date: Tue, 13 Aug 2024 02:56:50 +0100
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
 <7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com>
 <71260e3c-dee4-4bf0-b257-cdabd8cff3f1@gmail.com>
 <20240812171548.509ca539@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240812171548.509ca539@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 01:15, Jakub Kicinski wrote:
> On Mon, 12 Aug 2024 20:04:41 +0100 Pavel Begunkov wrote:
>>>> Also don't see the upside of the explicit "non-capable" flag,
>>>> but I haven't thought of that. Is there any use?
>>
>> Or maybe I don't get what you're asking, I explained
>> why to have that "PP_IGNORE_PROVIDERS" on top of the flag
>> saying that it's supported.
>>
>> Which "non-capable" flag you have in mind? A page pool create
>> flag or one facing upper layers like devmem tcp?
> 
> Let me rephrase - what's the point of having both PP_PROVIDERS_SUPPORTED
> and PP_IGNORE_PROVIDERS at the page pool level? PP_CAP_NET(MEM|IOV),
> and it's either there or it's not.

The second flag solves a problem with initializing page pools
with headers, but let's forget about it for now, it's rather a
small nuance, would probably reappear when someone would try to
use pp_params->queue for purposes different from memory providers.

> If you're thinking about advertising the support all the way to the
> user, I'm not sure if page pool is the right place to do so. It's more
> of a queue property.

Nope. Only the first "SUPPORTED" flag serves that purpose in a way
by failing setup like netlink devmem dmabuf binding and returning
the error back to user.

> BTW, Mina, the core should probably also check that XDP isn't installed
> before / while the netmem is bound to a queue.

-- 
Pavel Begunkov

