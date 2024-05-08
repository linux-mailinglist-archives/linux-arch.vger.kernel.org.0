Return-Path: <linux-arch+bounces-4273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D828C01B8
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A241D1F23EE2
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C799129E7B;
	Wed,  8 May 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAvZlWEK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348184A38;
	Wed,  8 May 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184820; cv=none; b=iOBI6jT+0x7qgRqlefPWItZGAzdQMoDV5wHts1Jhq/CM32ChJpVNnr9FAlYci4NgHtPOJ3Huuguf+sy6UzN7zjz+vzpsIaKe9n99nsm1m98F9mj8yHW/EPtNORcExh81+18U7PCJONb3fCFyycxEif606OR//2zg8i0Oq/7d9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184820; c=relaxed/simple;
	bh=KTTPfU3G93nUaSQQ03SoA08BLzmCwzGHhrMxQMHXbrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgKElpLYBQhs0SGUE+TA72SzgMC+9b3QdVzi/LdMjdf1kRmrQ0nvRlCQcLDXgEJpYyKrnUio0uwmOrD+CUUxdSG/2Tujg4uunpXZET60e93ipH7ttL6DXYIrCm1qkIeiNGaO03FhJAm9YU5YafEwOIbrvuAh4go7KU315zLmkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAvZlWEK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-520f9d559f6so3322217e87.3;
        Wed, 08 May 2024 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715184817; x=1715789617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8f/oNkLNRVDgyHz7SZX/CbDK9NIee4eeJWH9FsmJVO4=;
        b=TAvZlWEKkXb77emTrSTwOzBRHL8ug8NMAuDKE6BOic+fg2A7sA90de4JHF7Wau2xW5
         fecK+x6qcOchdMWceLOVCNtBN29n9EbLiF/VWB34UYv6uvvLtKjIh1rqTFNtKJ7/krIS
         OySf2q0HOyl5vWpjxzO1Kl3kfiRxEC+TBDnnaTDgiasl3rQkCCWzVb6KbtNa+U1XbbCL
         HEw0epDxohvWiPfAsCRtRxMpzgdkyLs+2OwCfwAO9dtE/FZKYU98hKP2pbxk4nCoRm1e
         QbNM36jsnDINHtE5tHuYRuBaLZQic0qSEvHy7zReKTHmNjOI03FvxeOJM0XHjvoTGZC6
         Us/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715184817; x=1715789617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f/oNkLNRVDgyHz7SZX/CbDK9NIee4eeJWH9FsmJVO4=;
        b=aoKtCQ1fZ40sBjZa/Tldul+O4hQjk9kqh76dKiHfAdvc0m/f73cEcMpIUnaLMRieOL
         vgwJKV8vLou8Xy3RKLXOUXgm9y1hKbtLJDaQiH/6RYZXs+B2EAgIesaIzeQXBdIIyXV7
         bgCcZ97KLpUOLBXYlQYSH0GywipVxD0StrUWqu+d90RUKzLDpKSW5kQuBkW5hzGqLAHA
         BUPvSAY+zY9nkW8HJ5mAFvMkH0x4PSVmdinpMSNKZLrAYtCohxXnsD66wBN/Hod5i5/I
         gVi2+H78MyVTHkomrYwufOaVtezIh/99zBAER8eQKoanCfEm7ntbYocYrIiO4IPP0m6B
         WFxA==
X-Forwarded-Encrypted: i=1; AJvYcCWib0r6e0Dq+xKF4iG8tjOM3ZoRl+qq4gosrqYCe6sarAjMbxGO7kDsTu13VRqaFxQBjsqR2INTArIjEKC/ferF9JfLX5ykGmfYtEfc2oEPBgY/FMG+DKPxEF4+mrEFkzm5lbP6li7VpMY3f+xEb9vwaZlMfrOccBYBPe8R8BLQpEfSL/ODPomo4ZemdQTwzXdpER4g5icdcrh+GrIMbiKRatm1vUXfC/BA+xLO6sD1AxS0TuXj0uUmi/k4Yhx0jNmqewFlTKWrS4l9bzzqWJ7CC2T/yzXpzfYSz7JWoNb9vvWNucV3YNgwMqgFkbOJSAIGi8nzATxwXXdozLXW1xGTlWMoAcONLGoJi9Ws1co7lmPBTh37DbQQ/YXdlfQ/E8U0/k9HatLt323fcx024x0ggRMghnNp/cKi25AY6t+eeieaqpAOVBmYRoJo3MNQI4Eo+C+Cg+1osmHiOLQfTm/fCaaLQzgwplxfIyQFst4xoHGXglC+byKSvoNQIAISHMw4WLrdlA==
X-Gm-Message-State: AOJu0YxeYZoGNExeJ5GWhVwEPF8RcOKIHyh0kb4oynuO3PQ+1iBopLv7
	f5FPJwETVM65Q/ruWjfHV8Yu/kAfrdWcGPs76i+FoyKHmQgop5LDe3ikSxVK
X-Google-Smtp-Source: AGHT+IGOsGKTobWTIXaEhASc0QNiWa87Ncv1n8+a1K7thxeRTWIrU67BwG7R0FIWXrNbhbARcUS18g==
X-Received: by 2002:a05:6512:3da6:b0:51b:f78d:c189 with SMTP id 2adb3069b0e04-5217c3707fdmr2707077e87.14.1715184816352;
        Wed, 08 May 2024 09:13:36 -0700 (PDT)
Received: from [192.168.42.40] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a59ae892a68sm5208655ejc.167.2024.05.08.09.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:13:35 -0700 (PDT)
Message-ID: <710dfcb5-8489-446d-a230-0e01828dfc58@gmail.com>
Date: Wed, 8 May 2024 17:13:43 +0100
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
References: <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca>
 <54830914-1ec9-4312-96ad-423ac0aeb233@gmail.com>
 <20240508142530.GR4718@ziepe.ca>
 <6f69694b-4281-45a6-92aa-d9d72b918df2@gmail.com>
 <20240508155813.GS4718@ziepe.ca>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240508155813.GS4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 16:58, Jason Gunthorpe wrote:
> On Wed, May 08, 2024 at 04:44:32PM +0100, Pavel Begunkov wrote:
> 
>>> like a weird and indirect way to get there. Why can't io_uring just be
>>> the entity that does the final free and not mess with the logic
>>> allocator?
>>
>> Then the user has to do a syscall (e.g. via io_uring) to return pages,
>> and there we'd need to care how to put the pages efficiently, i.e.
>> hitting the page pool's fast path, e.g. by hoping napi is scheduled and
>> scheduled for the CPU we're running on, or maybe transferring the pages
>> to the right CPU first.
>>
>> Compare it with userspace putting pages into a ring, and the allocator
>> taking from there when needed without any extra synchronisation and
>> hassle just because it's a sole consumer.
> 
> Wow, that sounds a bit terrifying for security, but I guess I can see
> your point.

Mind elaborating about security? "No synchronisation" is for grabbing
from the ring, it's napi exclusive, but it does refcounting to make sure
there are no previous net users left and the userspace doesn't try
anything funny like returning a page twice. And it's not even a page
but rather a separately refcounted buffer represented by an offset
from the userspace POV. It doesn't even have to be page sized, hw
benefits from smaller chunks.

> You are replacing the whole allocator logic if you are effectively
> putting the free list in userspace memory.
> 
> Jason

-- 
Pavel Begunkov

