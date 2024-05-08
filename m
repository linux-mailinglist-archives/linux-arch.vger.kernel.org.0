Return-Path: <linux-arch+bounces-4263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8F8BFC04
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 13:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D71281721
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0476037;
	Wed,  8 May 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1xNeRSz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE064C61F;
	Wed,  8 May 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167804; cv=none; b=kUurOUyrvVMhkPgx0Vx2sU5AMAe1yC3MFevHxe2hzgjKF4SonV+hPQEFCSoI9Cp6oAUEA1geUyphKdyVjGiK8ZIqLuGwQMetPlK7kogmNL77eNq5rFGvYddxxI3r0GJrw5ZvnnlkNg5SM06i263JpSc7vxGrYVOnHmEnBMlsdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167804; c=relaxed/simple;
	bh=i1YXbT1f9p3n8QhwhLPoFD2HZIiqNikXNuPP+Cyyt3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv/lRpMxcvXS+X071yeAjW0UbLvKL1GPOYPSVSz6zxxUFq2UVgTyx1olEvbEk93zUj5aaG0bN8Nvn8sQ/Ae8g7Iu8rM7cXaydHxkvJF9Msu5YGlkUU5G6uCBRwc923dX+CZlKavu/GxpaeSrXsYtMJX4IKAtFP9jSf5WsiG6F+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1xNeRSz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59b178b75bso779737866b.0;
        Wed, 08 May 2024 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715167801; x=1715772601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OIqwzAifyFyoLgyrgDnMDOezHmps93bJkTuXZ4CdWs=;
        b=h1xNeRSzafyepxYmDP1++9rqUH17lOg6BY5IYYZKIy6/IE1vkKZ8Xz7yiNh6rfSm1c
         XIGgKxzsKV+baBdnLFU7P0dnnybBXBEeophzt68HmlzA/m8P54CIVfgNBz2YTznj58VD
         Q6oA6BVEVkZ/5RYKlFDZJrAt3aZtbUcKPBxz3zLgX7PgUAMeLFewiNouR+ANUam+C8C/
         8lg4qW5ITEVgUmrEogE2fgkpY+Rd+LaRFTV8CmMADYhvQyvR/IaL0qlxzA1NQrKyMU+v
         wGPc6XNTYYd8u96moAaUVk8P4wNMSFxj6CgECON6X2mzq2STOxFTrxAF69XZCNuNFftQ
         Jj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167801; x=1715772601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OIqwzAifyFyoLgyrgDnMDOezHmps93bJkTuXZ4CdWs=;
        b=aNRaoLQHW1BxW3FMWZAyG3s1ptWM+mSjr4TAZ9Yr/rp5Piff1eJjdfkKoJPKsMSRTk
         q0XBzvhaYWm7Q0yO4mo6TwbPkpv9JhTKtothM2JePqInUxDu/P8VxPQ6vf0w4sOr83XB
         /3X8OmtZW0WFbC1eSjFkA/83Oscj8lVxEO3yjLG+cxvuwFMrPl0mhaZJ63NpWgjgP+kT
         Scgm0oqN807bIweux6kMzrAl1usRlxM2QN2EAeqqru0Kw0fhh/MQtcXwv8c6TNZArohZ
         dIVtEQy6Pmx+/yPs+JDIWTsZjVNv2zvHvQIRcau9bk90KQhJUTb4rKbpjY//0EPtam1K
         E7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXm6w1eumq2q9EMEFyo4kNc8BR9pHrCS7tCygX2LAAYKcKouzgdFQMTPS5lAf6HJFibgduel/icX9JLTfZlq06TgC6rI4xyuOEcXDL4pIENalvxqAp0uCq1j5phhJICqgDkqsePt1bEIvIdvUtNI32jtOt8On8FNwThndFpciAiOgmgaF9/qomoYHHG/WquLicwAIWHVN4B7/Nqp2MalaWONW9Ek5G/KWTjX7B3Y4s7s4f4PA0kjabU0g8+wb6DwEfegEVxQlPeGSBmt9GoTJ/MvjN6ZeUCtvwzyozO2IUgQuzvl28XVn/Fky4SF7VV+Cn28NrJSmETpnz1E0nOCaWDyMsDLQlT6olsbEPRsxTtW9aFDzYcjBPHsPBSoeC6hGPhz++xbtf//NRFe97vRuoIRbGP1r1alatawYbxTOAflPn5lJSi7qC8dulkn6pESJOiz+BJhfLqgy7fISAXu/vGH/ghY2EiC19Qp4vWL1dp6LXRHhgctY75V7oUF9ROZsoG2p0hKQ==
X-Gm-Message-State: AOJu0YzhUcl4AehwA3nCUUxAAjhD/+r3doMZIQfZcynU/xi7awPEAfHT
	tlKafeagOWsmRTkwhFBzSWh9c5r2dW8fRzMiKGUfp+A6Q2mrY/B2
X-Google-Smtp-Source: AGHT+IEBCSS9yz2TLoxpJSv9wB1C02lZToMUPdrmRCsf8QV6Km9boW/BeDcdlJbFciMxAmm6cw9vRg==
X-Received: by 2002:a17:906:2b1b:b0:a58:a0b8:2a64 with SMTP id a640c23a62f3a-a59fb94b152mr153051866b.5.1715167800381;
        Wed, 08 May 2024 04:30:00 -0700 (PDT)
Received: from [192.168.42.217] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id kh24-20020a170906f81800b00a59bf40ba6dsm4449273ejb.7.2024.05.08.04.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 04:29:59 -0700 (PDT)
Message-ID: <54830914-1ec9-4312-96ad-423ac0aeb233@gmail.com>
Date: Wed, 8 May 2024 12:30:07 +0100
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
References: <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240507233247.GK4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 00:32, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 08:35:37PM +0100, Pavel Begunkov wrote:
>> On 5/7/24 18:56, Jason Gunthorpe wrote:
>>> On Tue, May 07, 2024 at 06:25:52PM +0100, Pavel Begunkov wrote:
>>>> On 5/7/24 17:48, Jason Gunthorpe wrote:
>>>>> On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:
>>>>>
>>>>>> 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
>>>>>> think in the past you said it's a uapi you don't link but in the face
>>>>>> of this pushback you may want to reconsider.
>>>>>
>>>>> dmabuf does not force a uapi, you can acquire your pages however you
>>>>> want and wrap them up in a dmabuf. No uapi at all.
>>>>>
>>>>> The point is that dmabuf already provides ops that do basically what
>>>>> is needed here. We don't need ops calling ops just because dmabuf's
>>>>> ops are not understsood or not perfect. Fixup dmabuf.
>>>>
>>>> Those ops, for example, are used to efficiently return used buffers
>>>> back to the kernel, which is uapi, I don't see how dmabuf can be
>>>> fixed up to cover it.
>>>
>>> Sure, but that doesn't mean you can't use dma buf for the other parts
>>> of the flow. The per-page lifetime is a different topic than the
>>> refcounting and access of the entire bulk of memory.
>>
>> Ok, so if we're leaving uapi (and ops) and keep per page/sub-buffer as
>> is, the rest is resolving uptr -> pages, and passing it to page pool in
>> a convenient to page pool format (net_iov).
> 
> I'm not going to pretend to know about page pool details, but dmabuf
> is the way to get the bulk of pages into a pool within the net stack's
> allocator and keep that bulk properly refcounted while.> 
> An object like dmabuf is needed for the general case because there are
> not going to be per-page references or otherwise available.

They are already pinned, memory is owned by the provider, io_uring
in this case, and it should not be freed circumventing io_uring,
and at this stage calling release_pages() is not such a hassle,
especially comparing to introducing an additional object.

My question is how having an intermediary dmabuf benefits the net
stack or io_uring ? For now IMO it doesn't solve anything but adds
extra complexity. Adding dmabuf for the sake of adding dmabuf is
not a great choice.

> What you seem to want is to alter how the actual allocation flow works
> from that bulk of memory and delay the free. It seems like a different
For people who jumped here without looking what this patchset is
about, that's the entire point of the io_uring zero copy approach
as well as this set. Instead of using kernel private pages that you
have no other option but to copy/mmap (and then free), it hands
buffers to the user while using memory accessible/visible in some
way by the user.

That "delay free" is taking a reference while user is reading data
(slightly different for devmem tcp). And note, it's not a page/dmabuf
reference, kernel can forcibly take it back and release pages.

> topic to me, and honestly hacking into the allocator free function
> seems a bit weird..

Do you also think that DMA_BUF_IOCTL_SYNC is a weird hack, because
it "delays free" by pinning the dmabuf object and letting the user
read memory instead of copying it? I can find many examples

-- 
Pavel Begunkov

