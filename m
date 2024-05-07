Return-Path: <linux-arch+bounces-4247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC28BEA7C
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 19:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4978F1C23B10
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DA16C694;
	Tue,  7 May 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNrab5FI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722810E6;
	Tue,  7 May 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102749; cv=none; b=Ld70IFOKKs7l9nV790HoykyeKVr7QCyvG/hRbtfFkardIeD1FCh5vyRpTu489vqTsv1HjZ7/ciCVuyyoZvENyMZDIQClI94iCBXaEvyOvoanGfZxL9drVtPIc5QmRC17XpxAB9uUqoBRN3p9t4y3TRq8dy9n33fTnKr1HFcIRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102749; c=relaxed/simple;
	bh=bTTBFm34vqlakeJr0m54mbETfTUQX1eA6jXf1Rs5dOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZyHYQ8KR8h1ii7y/8iv3pP9qSxmOty9Qh+/MmUOnJGreBZDygyk5Zqq3kAbjBbtSj1i1qB5Is9504qTVJhFhPzWZGzxkkvl+UXP4j2bfxDiSi2tvDlvuYM96uVV6m+1AOErXqXBfesJSSKyFLBXatLaPTIOg7yrTgWjDA128D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNrab5FI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b2119da94so21972415e9.0;
        Tue, 07 May 2024 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102746; x=1715707546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hH2gwlX9CIjp5iuBC0nf4yhM48L0bVqOBBwTo5W8RyY=;
        b=jNrab5FIB2NnWnx4xgeTfTxwuvHlTuY3o63Nq/HzBsUb1b4ZN2+tE5ykrBLzUvNN8N
         LK8i+RgZpcUoyBx2wKixVkVq4IVh1V4fjaKrHUNyIi1EiP5cdYmXYpeXtnOGwLTYdPhz
         lJUuClphvrY6vmm0IqLgVV9KfoMA6ICMMB0yLMWiR/pOxJI+EfzQCetg5arxiBsjcC/o
         1L/PDBQhGABrFM+bviZJ1R8xuuHD9REtmQrpnOxwkXP8LQL/+V7IqMCxO1mzEx2A8Vx1
         sjg0OT+WygO5C3bPzU1YRZsC40QkmIt4fx+lyUkCnfLmZPrtwKhnvEP8ix7DLO2p+0F9
         4CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102746; x=1715707546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH2gwlX9CIjp5iuBC0nf4yhM48L0bVqOBBwTo5W8RyY=;
        b=xRaRsmAatWXjHYI7G/qsaORGiiz7aoofOsU++QEUuh5qYVr1fHmv4tof9cGvHOd1N/
         pjdIAdAiXvQxYkJU50IkRusgdXSZeTynwHpZFxIBo9M6V/yeFyltqmPz1URR+3Ljddx/
         jOJS9V2MZDmHncWWRusR9z2eFGYEIN4GVPiCeLpfYUrncsJ3NbA50upA7tZEkPXr5ZpW
         cb44Ez3dzL9dvhMGobzIohgZukCkRuig5x9JEiXPapv9E0myoDDvlGnG25lAp3rVuEAK
         0pY4vtx8VlRrU4H4uvzCQ086EbZTEGtWc+GeW5nFoeGqcAAJSvqYsgnVEq4ahgQp9wGa
         GxNw==
X-Forwarded-Encrypted: i=1; AJvYcCU2H2UqPyoMOPHuTKRTCeIFjZsZ02c7DI1b86RrQ4Su/H/a1QdMXJZFK3dPW34SkDsjxYuuegttAR02O+HM7SoOcZi1e5hzLl9RzV8yDDIbR4A04hK26X26++NtzULgRvPEKCkU6vfJz7csZwFMMTDq0PEbSJvoxF24AADgNm4uBI3f107HKa8tLnm2VnuMdqTrL3KBA+l4k8KPkHuXhysGn1zsuaKpQ4SXNiAUaSK+qKejo9iT0W83w6Kup7ctRFlEOun6yl072/i0i0FPoBVEBJDdtR0Pgd9hDB2SzKO70cirhgH6Am0osm8XPJSnRSTDCOGmDVqE4h5iWRq54saYkL4OIFuW4HnymVytma/mZZw/mMz99DsrhijgISgT9TB5pVqiSOKuea+QYjyZfN29x8OnLYyWHW54axsdxOl9XO87BqLHrpp5qLoB6u0qedyScZFmPtvH9Uz33XnEgHTpLyV+dGcLkMsViEKcJYIqByx8RkPCWRVL0N51izOniOKYIeFlVg==
X-Gm-Message-State: AOJu0YxZklsIKNn9nb42QlEnLg4q/dJoYC/3T8qGHBJt/ph0e1Y5awfp
	Hj9XEsJcvBp2U+yevY7KRBmQjUzYmov6ENqf6QXeNRBf2gzg0UP7
X-Google-Smtp-Source: AGHT+IF8VqTV1BUapN1EV+Wyp48hykZoX+S626zj6EDdX9l6sa2/8vTRY34QFeCfF+VTNplXaFTyXQ==
X-Received: by 2002:a05:600c:46ce:b0:41b:e609:bc97 with SMTP id 5b1f17b1804b1-41f71cc1512mr3537475e9.2.1715102746162;
        Tue, 07 May 2024 10:25:46 -0700 (PDT)
Received: from [192.168.42.69] ([85.255.235.91])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c4e9400b0041b5500e438sm20349790wmq.23.2024.05.07.10.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:25:45 -0700 (PDT)
Message-ID: <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
Date: Tue, 7 May 2024 18:25:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Jason Gunthorpe <jgg@ziepe.ca>, Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240507164838.GG4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/24 17:48, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:
> 
>> 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
>> think in the past you said it's a uapi you don't link but in the face
>> of this pushback you may want to reconsider.
> 
> dmabuf does not force a uapi, you can acquire your pages however you
> want and wrap them up in a dmabuf. No uapi at all.
> 
> The point is that dmabuf already provides ops that do basically what
> is needed here. We don't need ops calling ops just because dmabuf's
> ops are not understsood or not perfect. Fixup dmabuf.

Those ops, for example, are used to efficiently return used buffers
back to the kernel, which is uapi, I don't see how dmabuf can be
fixed up to cover it.

> If io_uring wants to take its existing memory pre-registration it can
> wrap that in a dmbauf, and somehow pass it to the netstack. Userspace
> doesn't need to know a dmabuf is being used in the background.

io_uring's pre-registered memory is just pages, but even that is
going to be replaced with just a normal user buffer pointer.
Regardless, io_uring can wrap pages into a dmabuf, but it's not
a direct replacement for the ops, it'd mandate uapi change in a not
desirable way.

-- 
Pavel Begunkov

