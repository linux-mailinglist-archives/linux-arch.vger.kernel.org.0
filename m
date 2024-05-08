Return-Path: <linux-arch+bounces-4264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB08BFC31
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811221F21918
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F86824B0;
	Wed,  8 May 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVtwl2Ey"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB447F6C;
	Wed,  8 May 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168148; cv=none; b=eJjU0TsyE78ZD963yoessgBvF11SwWh0/x/rK0cRpUufsMGUsuTzHye401rZNWuGDQZ9zeEyjewMj1/RGe2rU0rd2NRkBij8yGR9576KvMPalBIrE8ulL8G7xO6hxNqNI8GB0FyuMiKne1rqb+azIjofCbJTSgdDULIU20Ztmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168148; c=relaxed/simple;
	bh=NUGzzI2KqNP1cPbp/GxrzL3VQvSocCNEihYdoADSwBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P7Nkvm7GcpAYmXb1yv4TUGjc4bdQV9BxYOZZvaVvdmxkiaJJTNsu7hyhghtAcp4SS6rtwjo3tNaIkRwnsU8K05ADAMOfgoF1Sld/FTWcx2KHPw0RySsaXFTb2forzcWP44kAkw19wiLoZy0L29zUWXqX/erg7uBhc0YgvhlGiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVtwl2Ey; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso889617966b.2;
        Wed, 08 May 2024 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168145; x=1715772945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vb7A8NDewpqVb/wyIJ0582aE2qv/3FWwkQEcmRDFW+Y=;
        b=cVtwl2EyWMN1bGdSkykbJhrDFoQpdkWU7U8Iqy5jzsqGgIvn/e6ZCNK6t48QGPTZ/x
         P70xXIi51A1Jkx7i30fX0a5dMpmqyyeTmNPyo0KzQBvmURkZDWUUCvKPBrPmzjJxqmq+
         Au3+NimpyoMB0Z74M/IOrwR6cou46Qxg8Rt946ebkk7lRvziMVXMRkxMVJusv/6DaNWu
         IEDZhsoO/i1y43oBsLpNQ6T96eMJU0Kx2k96MPJbB5sPytYv67jOqcmBixqa7TnMvlsK
         kiQ5Pr43AQKfYlO9JU6XsdJy44dMQCfMEayJ4Qj5R7tGtqFJnzDQz2cpLNpF9vqlPzHQ
         UTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168145; x=1715772945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb7A8NDewpqVb/wyIJ0582aE2qv/3FWwkQEcmRDFW+Y=;
        b=AgjGsJScNDHJqQnI6NO2doDMKlGhORuTvTqwGd7a5nhAK5hlZOowBbS6EK3x1GsZAW
         oxpBCGu/hEnuqVBaKDdzmirrQ0KDQJpVl5QASebqXLVqe776RWbI2oeHZwkwqCmnuHF3
         IB6Tvwxt4gjNYO/WHqrDbpY19rILXEkkvcVUyCENOOcNNRAyzbTv3CWz4NK8sn0jYhHE
         cAS1zCfsOFQECJyLeeypg8VKpoQABZlB+w6wUCEnTD/VWvDRoePdeW1tF7wIq2wPG4f8
         F+G4Za6ERSCi2N7c4gNkQHnc7Zt/zeY0C9JWkZBFolOsp6UUN/XnyMZw4HmbbRjaZXTk
         WpkA==
X-Forwarded-Encrypted: i=1; AJvYcCWU88OpDWbAOKdGKRMW2jpmD1p+H4YCFocqp3cT5i4CVf8rHabWNVVjXlErDKGMXBVu7ygruQDbYaQBCzHGvKGWhmDWRQ4yVA6e3EueaCUBuMsscIgViXVmvYZziF7rumzHQgTbhQB9DZhymBNt8fZyF70VxXaYEPTwv6fr/G6qLlLvQ6XizMsnVgGCGnetj5aPeEISags693A3rBN9ze3otY7SB5qAlnwby1thQL0ZDnfU/XDPQb1dIiXBzYjmdKg/pOLJ0NT7R39oD741CYEesFvQwmDJh8wJSP+IAVxdrZboU+QI80YhsL17T+DPQwpdQE8JjS/U7gA3STCtvWxSdJAgmCTXPO5CCbTtBm8lx+Y9AxYZ55B0L7PFd4bA5ZGNoIwgwdXwkiAb6zOIQimtEU9CUJcmAM5uk+QlhPZWXUKnGJPMufklnDErHVFvBdOVUnFi1LDEyvIor+jgsCk01DdZlVsDvVLZqOaGkt4PNaBbwKMc+LPXJznPCeyFAOEeerFwZw==
X-Gm-Message-State: AOJu0YzI1687RXF6xyRCrTIQN9uPWV+DevSYCa5VsGXCpQOX+qFFXMnX
	LXvIxD90PoGcaC1YBBzmXYmeCRggFEUco55LvUySgy3oWOkuDtSh
X-Google-Smtp-Source: AGHT+IFD1CFod5VQ+iswMgBuojxIC5HF11jrNe705xchAqUdklV+Hcoyl3d8HPrZmlieFNMEy7rhLQ==
X-Received: by 2002:a17:906:54c7:b0:a59:9edf:14b6 with SMTP id a640c23a62f3a-a59fb9699ccmr154863866b.45.1715168145194;
        Wed, 08 May 2024 04:35:45 -0700 (PDT)
Received: from [192.168.42.217] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906141900b00a55a5384986sm7568868ejc.24.2024.05.08.04.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 04:35:44 -0700 (PDT)
Message-ID: <1e2823db-504b-4829-856f-3f45a45ccada@gmail.com>
Date: Wed, 8 May 2024 12:35:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Jason Gunthorpe <jgg@ziepe.ca>, Mina Almasry <almasrymina@google.com>,
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
References: <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca> <Zjsm3vO6rIY_sw5A@phenom.ffwll.local>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Zjsm3vO6rIY_sw5A@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 08:16, Daniel Vetter wrote:
> On Tue, May 07, 2024 at 08:32:47PM -0300, Jason Gunthorpe wrote:
>> On Tue, May 07, 2024 at 08:35:37PM +0100, Pavel Begunkov wrote:
>>> On 5/7/24 18:56, Jason Gunthorpe wrote:
>>>> On Tue, May 07, 2024 at 06:25:52PM +0100, Pavel Begunkov wrote:
>>>>> On 5/7/24 17:48, Jason Gunthorpe wrote:
>>>>>> On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:
>>>>>>
>>>>>>> 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
>>>>>>> think in the past you said it's a uapi you don't link but in the face
>>>>>>> of this pushback you may want to reconsider.
>>>>>>
>>>>>> dmabuf does not force a uapi, you can acquire your pages however you
>>>>>> want and wrap them up in a dmabuf. No uapi at all.
>>>>>>
>>>>>> The point is that dmabuf already provides ops that do basically what
>>>>>> is needed here. We don't need ops calling ops just because dmabuf's
>>>>>> ops are not understsood or not perfect. Fixup dmabuf.
>>>>>
>>>>> Those ops, for example, are used to efficiently return used buffers
>>>>> back to the kernel, which is uapi, I don't see how dmabuf can be
>>>>> fixed up to cover it.
>>>>
>>>> Sure, but that doesn't mean you can't use dma buf for the other parts
>>>> of the flow. The per-page lifetime is a different topic than the
>>>> refcounting and access of the entire bulk of memory.
>>>
>>> Ok, so if we're leaving uapi (and ops) and keep per page/sub-buffer as
>>> is, the rest is resolving uptr -> pages, and passing it to page pool in
>>> a convenient to page pool format (net_iov).
>>
>> I'm not going to pretend to know about page pool details, but dmabuf
>> is the way to get the bulk of pages into a pool within the net stack's
>> allocator and keep that bulk properly refcounted while.
>>
>> An object like dmabuf is needed for the general case because there are
>> not going to be per-page references or otherwise available.
>>
>> What you seem to want is to alter how the actual allocation flow works
>> from that bulk of memory and delay the free. It seems like a different
>> topic to me, and honestly hacking into the allocator free function
>> seems a bit weird..
> 
> Also I don't see how it's an argument against dma-buf as the interface for

It's not, neither I said it is, but it is an argument against removing
the network's page pool ops.

> all these, because e.g. ttm internally does have a page pool because
> depending upon allocator, that's indeed beneficial. Other drm drivers have
> more buffer-based concepts for opportunistically memory around, usually
> by marking buffers that are just kept as cache as purgeable (which is a
> concept that goes all the way to opengl/vulkan).

Because in this case it solves nothing and helps with nothing, quite
the opposite. Just as well we can ask why NVMe doesn't wrap user pages
into a dmabuf while doing IO.

> But these are all internals of the dma-buf exporter, the dma-buf api users
> don't ever need to care.
> -Sima

-- 
Pavel Begunkov

