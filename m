Return-Path: <linux-arch+bounces-4805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2E90291B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5C81F20C95
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509474404;
	Mon, 10 Jun 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el4krPbO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42B14A85;
	Mon, 10 Jun 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047215; cv=none; b=WKcj9cJrciRrIjg+mlI6OrzgcOxcDVj1o5q+vWozcDEB3/PDipYaZMxjX2eoniH+xsPANZpFrEtpcYmN7xYGJpQ6dIqfEE2gtog5MqO3YE2O7B2pg5dAmlyldPokM31rE5wr9vnEAGGC4tCyg3IRkVuIcejouZLq0MUZ3TcR+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047215; c=relaxed/simple;
	bh=Cy140D/wRN6P1O46vTjuDRmJh0MS1NceCS6uXkJqXLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJT7UAGD/rqbEbEP0IS5bq980Yc4GprU8esfga8gfn+T+89/xvz9GDjjN3EsyYE4d2/4qTOa/iorrNqGPYcLOYLHD2mI/erwtF/eDIxawFp5hSw2A9OgUfPkNZM1obNGqXwaPi+UZC+a+RrGBp2iyZhvhzqFJ4GK1+wJSub6f8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el4krPbO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f27eed98aso338505f8f.2;
        Mon, 10 Jun 2024 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718047212; x=1718652012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds39/wk1Vz6prMfj1gC31qm8pnLcqbnW8HnwNU8zLQg=;
        b=el4krPbOumDvyC9M1bKQh2oLjPIlVR0/xfL0Tvp+DhIET9QAhcdhmKTH118Yto2lnd
         +HkbJ2b7Lr7Br9D/PwyTavSeg8h8uSIszeHJuItXQMyHyXABr1iIBu5L+ePvSy+Te6X2
         gVfTbUTaFX6ArMv0MpTtQvZAM1GD6oykAZDwIuAc85tGsMZTT/Anro+x33Rw42jdltZF
         qr3BSVsAS3BEf91deqHfgukGnCIggTA2+dT/v+yxQEI0fYMH74K6YCG11vlwF7Y21IaP
         tLhAZQoaq/1mImHEoA/aIRAkHadxuYuA396ORIB64m1vfXHYiMHC+1s4FtozuCpQY1uO
         PR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047212; x=1718652012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds39/wk1Vz6prMfj1gC31qm8pnLcqbnW8HnwNU8zLQg=;
        b=dtpqOd+yp9ZPGSzchk2JrrDILAPlC6D5Rz6l7DxBZGMJkkJebKEGEsS+fHnlCcpvBs
         cTNqiVMl/zRmRXZQfm3bA/euyXaZr4C13i3BkLQ5182No3Ose7itfyyVObZ9CivGZyle
         hnYnIcFZpDXvItzLGEE9lLXACqQ2BTuERi3oAujxt2cIhVPSb5zh9/WgZQLsF73XiUC7
         ZquiGZvKOg+SRw/O5V7Bw+NcndcPyi0glh56sg3HdvwJF4QrUgoCOpb6Pk+HT0B6kcuj
         baAsTUkiPXDI+Nw0Kt0lJkkiCFIBBC9alZbw9SHZjlzzh04POdjtvN0+nGe6EiVhFuoB
         XTZA==
X-Forwarded-Encrypted: i=1; AJvYcCVU7f9FHVVmZH+K8Pri0GKi/2fQogNnqv/veYlP0xtPWoc+CvMj8z3apWndKqTEqUArzLsZgAW/Qwl2B9iEt2oNSn8pvsY7706u/KfHtX+PTcXlXx+MUkMb3Y060XCqaqS3ZtqJ/90PPqX5J1NroYX3eD8jNdsF99e8XSBj6mmGhUAR1ZEDwz5JruF3xDkjXrgKLipS5gInvNj9cpwFGsOw+JIBAONQtqVfbPwhpQvTPOHqpZJhc6AbQ0z7pH0uUyhlGoSO45wPmpMt2vD8PRDgkZFDrDcEafkXGU6SJWcXywTaCjddQCaQwLKnNDD+AAhAYpkCcv2CZIH2yqnwRQAT/gkIQKxE4+GeHEC2YsDWKy8iMaTmDQ1iE1eFTrPg9dEcqnflZDqUQWg1Oeb0JOuyP+XCCpZyvv+liI0ltRdFGW+JSdj1atOXwyif5uB3S+dnuEj+wSY1t242eDonKoBTKny0cfhQNyRfI++bXHzWf7a0fUth5qjRLYWdUNpV0heEZ4XpqA==
X-Gm-Message-State: AOJu0YzKMvJLxWzt36ilC2Oo1WIg0ZVBLWYxtyuen7s/Bf01vJlQ1M7T
	k3rgvG2UMz+LvHYI7EbrB6W7buc7WoPYl7YxIcH9b54IXGfXVdq8
X-Google-Smtp-Source: AGHT+IHtyedrk98ou29Kg6rNsqOMEn95U01t7gSYrXBTrHwwR/KGG9pYFlYAQ/YJ7hVTZ+llph15Ng==
X-Received: by 2002:a5d:4383:0:b0:35f:2af3:7843 with SMTP id ffacd0b85a97d-35f2af37959mr455787f8f.48.1718047211545;
        Mon, 10 Jun 2024 12:20:11 -0700 (PDT)
Received: from [192.168.42.64] ([148.252.129.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d512556sm8313077f8f.29.2024.06.10.12.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:20:11 -0700 (PDT)
Message-ID: <00c67cf0-2bf3-4eaf-b200-ffe00d91593b@gmail.com>
Date: Mon, 10 Jun 2024 20:20:08 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Wei <dw@davidwei.uk>, Mina Almasry <almasrymina@google.com>,
 Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 16:16, David Ahern wrote:
> On 6/10/24 6:16 AM, Jason Gunthorpe wrote:
>> On Mon, Jun 10, 2024 at 02:07:01AM +0100, Pavel Begunkov wrote:
>>> On 6/10/24 01:37, David Wei wrote:
>>>> On 2024-06-07 17:52, Jason Gunthorpe wrote:
>>>>> IMHO it seems to compose poorly if you can only use the io_uring
>>>>> lifecycle model with io_uring registered memory, and not with DMABUF
>>>>> memory registered through Mina's mechanism.
>>>>
>>>> By this, do you mean io_uring must be exclusively used to use this
>>>> feature?
>>>>
>>>> And you'd rather see the two decoupled, so userspace can register w/ say
>>>> dmabuf then pass it to io_uring?
>>>
>>> Personally, I have no clue what Jason means. You can just as
>>> well say that it's poorly composable that write(2) to a disk
>>> cannot post a completion into a XDP ring, or a netlink socket,
>>> or io_uring's main completion queue, or name any other API.
>>
>> There is no reason you shouldn't be able to use your fast io_uring
>> completion and lifecycle flow with DMABUF backed memory. Those are not
>> widly different things and there is good reason they should work
>> together.

Let's not mix up devmem TCP and dmabuf specifically, as I see it
your question was concerning the latter: "... DMABUF memory registered
through Mina's mechanism". io_uring's zcrx can trivially get dmabuf
support in future, as mentioned it's mostly the setup side. ABI,
buffer workflow and some details is a separate issue, and I don't
see how further integration aside from what we're already sharing
is beneficial, on opposite it'll complicate things.

>> Pretending they are totally different just because two different
>> people wrote them is a very siloed view.
io_uring zcrx and devmem? They are not, nobody is saying otherwise,
_very_ similar approaches if anything but with different API, which
is the reason we already use common infra.

>>> The devmem TCP callback can implement it in a way feasible to
>>> the project, but it cannot directly post events to an unrelated
>>> API like io_uring. And devmem attaches buffers to a socket,
>>> for which a ring for returning buffers might even be a nuisance.
>>
>> If you can't compose your io_uring completion mechanism with a DMABUF
>> provided backing store then I think it needs more work.

As per above, it conflates devmem TCP with dmabuf.

> exactly. io_uring, page_pool, dmabuf - all kernel building blocks for
> solutions. This why I was pushing for Mina's set not to be using the
> name `devmem` - it is but one type of memory and with dmabuf it should
> not matter if it is gpu or host (or something else later on - cxl?).

-- 
Pavel Begunkov

