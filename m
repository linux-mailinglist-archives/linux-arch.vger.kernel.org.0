Return-Path: <linux-arch+bounces-7179-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774BF97375F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1DE1F22DE3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E65D18EFD4;
	Tue, 10 Sep 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX5WLC4W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B661E493;
	Tue, 10 Sep 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971495; cv=none; b=mWYJUi3Erv4wfGiBnEg/H1Rrp4jMoh96akraQbzZV/tzRPzMkJ67FucJeyoX/WXHLBLEq42kHKWAgOQz61zofYYFhj9Py3zNDqpd2AzQo17wvuG8vHu5pgpPgWBTTP3r2eMT79c4KPydTbttvtA6x21e9R3Hp/GqxSih6NLiwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971495; c=relaxed/simple;
	bh=wQKkQQ0xITGBCqfPfPCikx77uwRKAH0jIp3FVk1QCDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1WL5pGICO41cGQJw+qNURtvAkD7k8ihWjl8GTronfXprVenGJ4KmgDdX+iQ8+TVnLClHA4S0Eb9DoZFCI+Pewlr2MYednlmlrwBQTF4mnO949ZPv22nV22JjZtdPfOJGYjM4L3kw1kxqwtXIqnD43JYzDOv2cpbFbQdefT5vcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX5WLC4W; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365aa568ceso5280894e87.0;
        Tue, 10 Sep 2024 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725971491; x=1726576291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtcRhukYoCtt3zbp0P2CQXM3Yj4Vl3Xs7XXdCTCWAv4=;
        b=gX5WLC4WtMNh+j0/DvLDK+6+zDbUesT1/QmPTiQRB5z9g43x+xsFf4+4qkhjHcEN7C
         a7epgs4g1P92PJVzkVFgWTMgjfCskGELw90lSasNA8DzcsF8WQb1NRZ8p04bfFR26YW0
         WhIKEL4gA/hIm6sGjQdrHtFHQyYimcl0BZyfh/qYcvDvTv0SY8BjIbQppqjB7lXtI8gR
         D8/DiNpaQXUY8EyJuu9426ZCeE63rbqeB7Ou3W9ANmx5DE0NPx1Rwgp1U4GGrdmhtpuH
         REu7dgHTXvejV9xvofcMDsYWhckelzxdfuDlwTbl9q0j5cw/B42TbQKsjUAEeUwntZFc
         1iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725971491; x=1726576291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtcRhukYoCtt3zbp0P2CQXM3Yj4Vl3Xs7XXdCTCWAv4=;
        b=K+cBsStNp1PoL2AWUFV1Ny2fFBmIbcgGyl7wtiNNxdAm7dX1vIcj+mVj0XHGJe9+oj
         wOHAGvzqFq/xH+ovJHizi9aTPUQeBIX/v9pyjgkegkhhtfxYeyKEKuEbT4qc6NYPk1rY
         N5CgWthpefY91A1AclQcg/rxgTyz9Dpzd7uPirXPHCnA2DRQeSLUd0q/RwTZ9f2qPI45
         OQQYXhrVlOjkq7kBtotdBI0YS6uXUdp/TMgYJiJtRBznwLDGrhhnkNR7ESUvYmZBQ1il
         GUeZ6XulvFSNs/9yHZptR8jfh4rLKykXrVin09DjsE6gMTZOJ6bQWO/mKjTQ/SOo2Jz5
         mqZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+FsFZeCi0zf46D3myVeLv81+DmVX4J0eY3dYMTFoYcXUm257uXdI6kQhqNucuH9/hz84=@vger.kernel.org, AJvYcCUH4WPfUvt8Uj/8mx5JLsx/yeYvZuNjeOAAqIVzMKmkqOqAOAwn+1Z/venyYkVGrPEALLNIo9ViR//J7Q==@vger.kernel.org, AJvYcCUZLxXyrrs/Zn9sMmu19KQOVmxVNVBfdatSCoumdC+EzJr32Hzv3qcjOfYRXJt6QKG7rhtCXG4Xaxxy9s8=@vger.kernel.org, AJvYcCVI6/CRVZTnHMCBEXVTzPcy1GuvUyWCAs8EQyjkRsvnURWeJ/xbYni6QmmQqdHXI3a3u8VfoHdAkJTn@vger.kernel.org, AJvYcCVh0epzvCu3b586T7Mcstrkfoca9F42dJcUUmyANHBfFZLpeyhJqzyNsC8xbGr5/uDLtB7VCsr914EKl0+b@vger.kernel.org, AJvYcCWfjtnDAs9iDl4ZEuqR2n4QznWbFdyKioIz2MY+4MELUbih3l/Gi1EFIr4/rXKjbhOxaKtTznWFgHE/Bw==@vger.kernel.org, AJvYcCWmLGnOuKJzwO8743PopL/+cDrv+jE8owNzTOVkY7y+OdL5G72ZTF9czmCH5WtSvycjdgj24ihTjcHvcYWkdFbv@vger.kernel.org, AJvYcCXGRTc1MIGDB+JptwptyDChiezcy+nwVOHk7IWC496s88OIiCVJo299eNKsgX6GdSAFsW20Inm46n2O/IAz@vger.kernel.org, AJvYcCXLlLvSc3E/87HHNlSwgOZu400mOwnxLWDbgYP3n7Xu4x04tdtCzy3HPWbdd5a8mui2tm81cLFoF0qU6Q==@vger.kernel.org, AJvYcCXchaykcV96AGUMh9TbDqvk
 dNCEpOY8zv1WbKRXRqkaesBdxRYB1Q45mcCj32+Ze3XotyFNmC2Yp1HKak07oqn9c4xk@vger.kernel.org, AJvYcCXz0H4hcDz7JyEqCCvQSvDqX1U942GTpNri8aL0Gvj5JmGoWqrIBcQTf9pttXkPsO/7/3U7aDdBq6QDun4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MYR2NjXdNXOpjBuvUo3DR+goPG2uQIFB1cVAgP4V0Sfja48t
	Fs3waM3VqfpXWUka4462os3NMB5Tgfh++CwtiOubidpeROald8q2
X-Google-Smtp-Source: AGHT+IGEVkB6nnSie3fLjpdXReDnDVW5WUCRhLkJsLhAZYuUFak44mbGNRXGfWfCij7/1bK1evFE2Q==
X-Received: by 2002:a05:6512:4021:b0:536:5810:e89 with SMTP id 2adb3069b0e04-5365880b041mr13327012e87.49.1725971490461;
        Tue, 10 Sep 2024 05:31:30 -0700 (PDT)
Received: from [192.168.42.252] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259511c0sm475844966b.62.2024.09.10.05.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:31:29 -0700 (PDT)
Message-ID: <9116f069-63a7-4cc9-b197-1f39ebfd0a57@gmail.com>
Date: Tue, 10 Sep 2024 13:31:56 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 00/13] Device Memory TCP
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
 Arnd Bergmann <arnd@arndb.de>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
References: <20240909054318.1809580-1-almasrymina@google.com>
 <42c202e6-8c4c-494f-8c28-17d66ed75880@huawei.com>
 <CAHS8izMX+9F1NngbPx6w7ikKR9TgPvm+jMwZ8168NJYhFC7sVQ@mail.gmail.com>
 <95e6c282-1e4f-458b-9e40-9b626d64b3bd@huawei.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <95e6c282-1e4f-458b-9e40-9b626d64b3bd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/24 11:44, Yunsheng Lin wrote:
> On 2024/9/10 0:54, Mina Almasry wrote:
>> On Mon, Sep 9, 2024 at 4:21 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>
>>> On 2024/9/9 13:43, Mina Almasry wrote:
>>>
>>>>
>>>> Perf - page-pool benchmark:
>>>> ---------------------------
>>>>
>>>> bench_page_pool_simple.ko tests with and without these changes:
>>>> https://pastebin.com/raw/ncHDwAbn
>>>>
>>>> AFAIK the number that really matters in the perf tests is the
>>>> 'tasklet_page_pool01_fast_path Per elem'. This one measures at about 8
>>>> cycles without the changes but there is some 1 cycle noise in some
>>>> results.
>>>>
>>>> With the patches this regresses to 9 cycles with the changes but there
>>>> is 1 cycle noise occasionally running this test repeatedly.
>>>>
>>>> Lastly I tried disable the static_branch_unlikely() in
>>>> netmem_is_net_iov() check. To my surprise disabling the
>>>> static_branch_unlikely() check reduces the fast path back to 8 cycles,
>>>> but the 1 cycle noise remains.
>>>
>>> Sorry for the late report, as I was adding a testing page_pool ko basing
>>> on [1] to avoid introducing performance regression when fixing the bug in
>>> [2].
>>> I used it to test the performance impact of devmem patchset for page_pool
>>> too, it seems there might be some noticable performance impact quite stably
>>> for the below testcases, about 5%~16% performance degradation as below in
>>> the arm64 system:
>>>
>>
>> Correct me if I'm wrong here, but on the surface here it seems that
>> you're re-reporting a known issue. Consensus seems to be that it's a
>> non-issue.
>>
>> In v6 I reported that the bench_page_pool_simple.ko test reports a 1
>> cycle regression with these patches, from 8->9 cycles. That is roughly
>> consistent with the 5-15% you're reporting.
> 
>  From the description above in the cover letter, I thought the performance
> data using the out of tree testing ko is not stable enough to justify the
> performance impact.
> 
>>
>> I root caused the reason for the regression to be the
>> netmem_is_net_iov() check in the fast path. I removed this regression
>> in v7 (see the change log) by conditionally compiling the check in
>> that function.
>>
>> In v8, Pavel/Jens/David pushed back on the ifdef check. See this
>> entire thread, but in particular this response from Jens:
> 
> It seemed the main objection is about how to enable this feature
> for the io_uring?

The pushback was that config checks as optimisation don't work in real
life, they inevitably get enabled everywhere but some niche cases.
io_uring could do another config for memory providers, but even if it's
not enabled by default (which is not a great option), distributions will
eventually turn it on.

So, if you have that "niche use case" that fully controls the kernel and
wants to shed this overhead, we can do a config structure, but if it's
about overhead for everyone in general, configs hardly help anything,
even without any io_uring in the picture.

> And it seemed that you had added the CONFIG_NET_DEVMEM for this
> devmem thing, why not use it for that?

-- 
Pavel Begunkov

