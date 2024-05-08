Return-Path: <linux-arch+bounces-4274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA408C027A
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E571F22B7E
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892E8828;
	Wed,  8 May 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnynkGDj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327D3D6D;
	Wed,  8 May 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187731; cv=none; b=UxH8eXHBHkuj34qgT9p99MVGWvI9rFKZIQSpHRWj2u5yGaKNOE9ALmtlXSBVUGvFHl+slDS2KsaSxQ1Pxav6CmQAfGTeMiEvnEg6oWQz67APrU6zUEqaECrcK8A9VROX+QD/V5IMkl9sC7Z6cmAQnIPWvM0arrFxqTS7I+TqFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187731; c=relaxed/simple;
	bh=RJTd0DFSkwcgQXADy0NPRv8wgTOjMh4ljQ8AnIpUJ68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2oy45pIPoxI6s7jE2GHb4Fw9dOipddjkUxShixpx5G0Yt5PhU0P3Odnpvc/w2rhN/bTnjouPGPa1ePzx27ZaEf7BbMKTsiXd0iFIxYyH7pXPjFZts52pQ2qIg6swO+0Pnan+sqU0eI0Bjz2AJ3Kc7q6AMwUMT2q7d8FP96Q7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnynkGDj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a599af16934so1168471766b.1;
        Wed, 08 May 2024 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187728; x=1715792528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w63SX1W8IWtKWaRdVmF8DRJBTDth/aiRDPCWeP/m/u8=;
        b=OnynkGDjg0vGkDGdSEon5d0xDjiqrzpioqZiHuL0Nag9NOdtNmLL3NPjDyUSxO/8Zh
         Sl+gc5S7CVBd88KtjhJXiNeDchtVDDGKv6H/SAE6+GLdMr1ysapTuwr7Pr4/78062sv7
         U1lM4WybzDoSe5R2r24p9NH3yIBvBq9+pDtp0CzFHUBmR/pJCTQiP0KU5gSlQeVFN4rX
         IZgnJ+Sil5bIFR5pjfTpMuErMJKV2AJwbjhVuPdWn6lEcT1GnlbKS3hG7EdRBqH91WIf
         QZNhxXRNenOywRA9FMky14JAU1+sR83V/REHv91nu+Q82sjYZhD1WE/rxIzMUY0c6uZX
         cirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187728; x=1715792528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w63SX1W8IWtKWaRdVmF8DRJBTDth/aiRDPCWeP/m/u8=;
        b=bmsFr1k1KAJQ7Q3VUl8EgsqIvJ4zlhHOTlJAFPNLqOfUOXUaUNjsa4FJ1cck1yIQ/E
         qgmHYmaTf3bnH7E8vdW1sX2XKBWzJwT6Vg9cgxlyaHkrDKKvC0WKN8ncxsvQz9cdkJDk
         DrragEDQ550BH3PcG5acaNQoJjjC8/zRHXiko+XZXNecX8+XWK5MOYMAqrCMjk7DxLdg
         2GCWkLgDr274wq25oI/vkS1fmr1ikW6ZzDULYq0htd5k1lSi9uQP3PDDHOAbZh1XJmzK
         KCVC7AwCLecgS/Gz+ocUG8uGMav5V7rYwdMSi4eKqqtKIpyXLTi6KsDmUWEYwIY2ZHnP
         BeZA==
X-Forwarded-Encrypted: i=1; AJvYcCVpZDVMJVxmnosHfPGBUJMOY92ouCL7Dc7PEjsoGbREL1ZbBeSsordAD3mlP+0KGUAYo+xo+Z9CsdgRakUKWjkHXcs71G8S5O568Ki8JmyxizvHh2iqX+jmRSaQzHEiORYPR1UfuO8sfXG2unlshuu/BJvLBJ8yIhZukc3/RxrWKs2sUGBjENu0x9D+3+drv9jU6aty54HCvgwcyDXEEBOqIcuvylKvAPKGT9S8upE+KcSriQ6rjbTOpn86kI3OOQEK88UemXG2lsRnLMoKd3u9+Bep3b16RXRt/hiCNxLLvG9xfuN1rAAax2y8pbjCS+inxRjmwjJUNArkS3Guza5x69y5Rm3ApBxxizEcjyOLZ1gy0ZeT8E8Xv6/4ARSX3IKjjs0Gy5vfZossSp54rsDPqP3ZMSc+rNPULtkfQ3PIg/Us2jH7h1bPsZzDGqB9brrPJ/237rk0AKogMHh80g3k+ugvK9gOGVMWetnLavzm68pQBEPoP6iaq4QQAVmu1aEpk9QdQg==
X-Gm-Message-State: AOJu0Yyj11/IJlgWqJLmmpp73awguVVf+GMiNUelEDHixyVS4C+4Of5W
	MZeZKY7W70ZMHk5kmHJiaRKhShh5qBSlDiuepajjS5JyNVNG+1JV
X-Google-Smtp-Source: AGHT+IGnIbHLe2S57apepPi+KOdstUOemuaNblSGc79A9OnsYp187XWHNbGjxYPqzEX3412l6BXKTQ==
X-Received: by 2002:a17:907:7286:b0:a59:bacc:b07f with SMTP id a640c23a62f3a-a59fb9d6452mr265356266b.52.1715187727754;
        Wed, 08 May 2024 10:02:07 -0700 (PDT)
Received: from [192.168.42.40] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906841200b00a59a8a5dd15sm5634228ejx.206.2024.05.08.10.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:02:07 -0700 (PDT)
Message-ID: <8ced4c49-d153-40fb-9e62-0a5784cfa864@gmail.com>
Date: Wed, 8 May 2024 18:02:14 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mina Almasry <almasrymina@google.com>,
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
References: <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca> <Zjsm3vO6rIY_sw5A@phenom.ffwll.local>
 <1e2823db-504b-4829-856f-3f45a45ccada@gmail.com>
 <ZjufddNVJs5Csaix@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZjufddNVJs5Csaix@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 16:51, Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 12:35:52PM +0100, Pavel Begunkov wrote:
>>> all these, because e.g. ttm internally does have a page pool because
>>> depending upon allocator, that's indeed beneficial. Other drm drivers have
>>> more buffer-based concepts for opportunistically memory around, usually
>>> by marking buffers that are just kept as cache as purgeable (which is a
>>> concept that goes all the way to opengl/vulkan).
>>
>> Because in this case it solves nothing and helps with nothing, quite
>> the opposite. Just as well we can ask why NVMe doesn't wrap user pages
>> into a dmabuf while doing IO.
> 
> You seem to confused totally unrelated things.
>
> For short-term pins, that is pin_user_pages without FOLL_LONGTERM there
> would never be any point in using a dmabuf as the pin is transient.  For
> long-term pin dmabufs in the block layer absolutely make sense, and I

Well, the example fell flat, but you don't use dmabuf when there are
no upsides from using it. For instance, when you already have pinned
pages, you're going to use pages, and there are no other refcounting
concerns. Unless there is an advantage of dmabufs over FOLL_LONGTERM
that I don't know about when used with normal user pages.

> wish io_uring would have just implemented them from the start instead of
> the current fixed buffers that are not quite as useful by not
> pre-mapping DMA and not supporting P2P.

fdget(dmabuf) would be horrible, I assume that's not the suggestion.
But then it's really about kernel internals, and theoretically can
be patched to wrap user pages into a dmabuf and pass it in. The tricky
part is how that "pass it in" should looks like. Keith tried to cover
both pre-mapping and p2p by registering dmabuf and passing the mapped
addresses in an iter IIRC.

Anyway, this discussion should better move from to block/fs lists,
if there is any interest.

-- 
Pavel Begunkov

