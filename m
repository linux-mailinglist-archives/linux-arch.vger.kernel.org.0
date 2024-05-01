Return-Path: <linux-arch+bounces-4108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951438B8B87
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89DD1C21A1C
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF512EBCC;
	Wed,  1 May 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCbrUaES"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09212C490;
	Wed,  1 May 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571957; cv=none; b=J3nv4JNhCH3zr/s7JdeCsI2Z5LuWf1arbxDg7Qyw7WRs8NW/s+Ms+ZHv1rgylDWWOPIEg7X1kQ0Ich2HQzQ+nboY35WZXfcQc7sKgsxTfa8x/5sXx2f+pVpQnKr9XRTaacybTZNig9nm+QFiRTEg5LGAeJjQFINFafgtD1bON2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571957; c=relaxed/simple;
	bh=Fi4PvMRZrF9DXNpSOwwia/BblzTiRO6iyf1z/eVq1XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbchjvG3iRoD7tZsVbSHBC2VDA1pFY2cj3SWAp5gw7+QlIJJAkkhCxOyXperwsUU5+WmLLsJDxONdC8ykFbY6y9qB9qCS+FG6ugqs8QH6pC8ieafJ/cFNzvbEp2j2Hhzi3kO26lzjrgh3dVTN/naxrWwGNw4DCa+GCEq30m/AXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCbrUaES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C7C072AA;
	Wed,  1 May 2024 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714571956;
	bh=Fi4PvMRZrF9DXNpSOwwia/BblzTiRO6iyf1z/eVq1XU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sCbrUaESax+zNwmTNdY7otL0UFOQLPT1tCLvxhS1E2UCWFKHW4CFOG8eHXGAPEzYV
	 K59HSeGnESqWuVyypeDsfjxCGIwlrkTiIB8RtlSIeODJISpG+bjrjqgUZTNnVYoXFo
	 0nAjOD3kay/wsGxmwOPaAc5VD0eUhuiBlauj3Z2WQisvO7reiDxOn7qiXguQyswbXz
	 eGzZQLUgdh76hRrtTEFJVQdEHnMA2UjgtwHVl2z9L4Tsb3ZTSE/wBE57PdTiTs8Ocp
	 FhNUI+PSuIOyAwwjpVUsbAi1uNR+QWMI+7HqtFjSwPStPFYwbkZKYGKHcbZk0YZOQW
	 CZlqUKG4oenXA==
Message-ID: <779b9542-4170-483a-af54-ca0dd471f774@kernel.org>
Date: Wed, 1 May 2024 15:58:59 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: Jens Axboe <axboe@kernel.dk>, Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
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
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>,
 Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>,
 Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com>
 <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
 <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
 <aafbbf09-a33d-4e73-99c8-9ddab5910657@kernel.dk>
 <CAHS8izMKLYATo6g3xkj_thFo3whCfq6LSoex5s0m5XZd-U7SVQ@mail.gmail.com>
 <11f52113-7b67-4b45-ba1d-29b070050cec@kernel.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <11f52113-7b67-4b45-ba1d-29b070050cec@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/04/2024 20.55, Jens Axboe wrote:
> On 4/30/24 12:29 PM, Mina Almasry wrote:
>> On Tue, Apr 30, 2024 at 6:46?AM Jens Axboe<axboe@kernel.dk>  wrote:
[...]
>>> In general, attempting to hide overhead behind config options is always
>>> a losing proposition. It merely serves to say "look, if these things
>>> aren't enabled, the overhead isn't there", while distros blindly enable
>>> pretty much everything and then you're back where you started.
>>>
>> The history there is that this check adds 1 cycle regression to the
>> page_pool fast path benchmark. The regression last I measured is 8->9
>> cycles, so in % wise it's a quite significant 12.5% (more details in
>> the cover letter[1]). I doubt I can do much better than that to be
>> honest.
>
> I'm all for cycle counting, and do it myself too, but is that even
> measurable in anything that isn't a super targeted microbenchmark? Or
> even in that?

The reason for page_pool fast path being critical is that it is used for 
the XDP_DROP use-case.
E.g on Mellanox mlx5 driver we see 24 Mpps XDP_DROP, which is approx 42 
nanosec per packet. Adding 9 nanosec will reduce this to 19.6 Mpps.

   1/(42+9)*10^9 = 19607843

--Jesper

p.s. Upstreaming my PP microbenchmark[1] is still at the bottom of my 
todo-list.
  [1] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c

