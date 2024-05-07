Return-Path: <linux-arch+bounces-4254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106658BECA4
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0FB281E52
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA016DEDA;
	Tue,  7 May 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuFlJ0su"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B61607A7;
	Tue,  7 May 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110534; cv=none; b=habkOchynkxOnnxzvrE+ARJcehWMkU66aYgA5XMuTlT9/7pwBg+/3Kw/HMNGl1BpfqigvawLgdxVq3X9nDm2ijaT3SjKk8guPUvg2dKCfGMj9mx1jMIkttUsgWFHluqZImi28xWWrVHWSg5tdOB/zaH+DuvEpxfh0b4UMbKcjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110534; c=relaxed/simple;
	bh=K7koNsOotobWiysspCzAcVC3GFkF8Gu5l5G8dKp2Hak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAmh29qBxSn4VkyAw+CQOCB+/5RA/drT0+1hJA83BaZWRy8jdUiIu6zjhcFYqv5OHJQd7oTpwvcWgFrBgyZi9Bx+fBRhb5tG3ECZmDzTV+Vu7s7eye8VdD4U9/FYHGkQDWzhRFk7qtgqD9P4fIdYr88QTlGmpOfWOFfEaNpmG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuFlJ0su; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41c1b75ca31so26297875e9.2;
        Tue, 07 May 2024 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715110531; x=1715715331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MsVmwcc7IjdJ/e1qKc5IeNtKIDJim+5sn115KirsXM=;
        b=UuFlJ0suPwJAUR9NA4My7Sr82F1k55jAJas2JUPg41UEYltdHEHV2ud2/6txlmgxDy
         YKvZ/Letr2rCL08NZuYM9UnoXohx3ZIih0KyrvtucKBHXoGLo9PvYI8fHbJMIUPNHgqh
         tUWYaGnZXsdLhKdI6VYiH2xg4Ph1niwTSIuWZeNLCilDaKa0YfrGjZgJvJ4L+PI+fbfK
         2PQxFozR/WueZRSzZK6FNLafTuqos6y22WvJRtOxBRscZf4k+AZ0tQ8eZnlQ/Bd23qHO
         1e7rXg+pTAzZtjVRl5onJ6VVczBpYRT6b242KVfR+Q/u6bBVakLasqPYxmeGYWfe7A2b
         eDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715110531; x=1715715331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MsVmwcc7IjdJ/e1qKc5IeNtKIDJim+5sn115KirsXM=;
        b=YtXJMXgxu/pu7uH4kznEhGIShVKwUV5ja/yiEciIucAQLv79lnL+yV6O796uURabIl
         BthNkKeVBfiC7hUyU8AdywQ/MylR3nlo4JJaJodJweCPeWpydfBSaym2Xfw4Nd4hm2JY
         CE8UIK5DZBHJw/DK+fcl+v5PrHLJ23+l6f2bzwWaSFC6K/uNRkt3nZwp72dPmamPkcK3
         ruOM7qF8wevuRdc46Ll9OE1JvcB29+BE7M3rRyz2cGx+la3Qg6vqAeKULs6BESwsitYg
         9RFHkVhI3H0wenJDPXf4xzr6VcI9FwF2G31265zVHrOW8HrzfgN23LiyfV1hTaG6E97v
         wdjw==
X-Forwarded-Encrypted: i=1; AJvYcCVFVgyFYMcvrkM2ANpIpJbyDvBKnVMsfOyYlKgtcErJiJriNxnRwu2mgZRlmpJUaVBxvOIzpfff9SCJdYj//abMa2xfWi0VGh2Oc9b01xo1WkhvYVW362ud66c/+G85z64L2WHsmToEzT0s5Tr/z1fy1eSormgU3hPOT4mzipw6BAzmsVS3o6TS8FDrrFXoc9dRcOLd8aP5kx93YdBEZSqjWFqsHrYaDcXkC2VT2gDeX4A9r0Ks40drbK+HuZpVyq+7DkcCYIp7O9X3zKPfTTjLVd/3Czti/m1LLYbh6vIsOek+qH6xYnyHk1P7HeUyam3J4L+tk2N+BCWlUK6Y608TzJd/TN2C5FYt9fwMMngHhESJgQru5WluPAjA6Qv0Hc624tnX1EsY2IFu0eOJnJh58PMGXdw5mIXaPigUngLa5RW0npxyc98eFHM/o/sF933e1Zqk/l3BvbpNYSrrvKer/T+4CWtlj2ZWaW/g8TLRtMD2CVYWTzWyfvJOhVJKAGSvTkwG6w==
X-Gm-Message-State: AOJu0YyjcI6OSzo3UzcOA1ufPXfhtl/igDrHzHNil1Z0xD2+SZ6l+Z0n
	u7whzzC5MqGnzgc0bndbMfTRgya8NR4R2h9DNDxoo6ydchvy3F5u
X-Google-Smtp-Source: AGHT+IEykirY9gyWc0Q9cAc6TvBa0+t0xp9ehEp+M4lSOcYK9DTE6BwXpCm/3e/UtlGIJu+qNRFaFg==
X-Received: by 2002:a05:600c:3583:b0:418:ed13:302d with SMTP id 5b1f17b1804b1-41f723a1a0amr5612735e9.26.1715110531198;
        Tue, 07 May 2024 12:35:31 -0700 (PDT)
Received: from [192.168.42.69] ([85.255.235.91])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0041bd85cd3f2sm20447278wmp.19.2024.05.07.12.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 12:35:30 -0700 (PDT)
Message-ID: <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
Date: Tue, 7 May 2024 20:35:37 +0100
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
References: <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240507175644.GJ4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/24 18:56, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 06:25:52PM +0100, Pavel Begunkov wrote:
>> On 5/7/24 17:48, Jason Gunthorpe wrote:
>>> On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:
>>>
>>>> 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
>>>> think in the past you said it's a uapi you don't link but in the face
>>>> of this pushback you may want to reconsider.
>>>
>>> dmabuf does not force a uapi, you can acquire your pages however you
>>> want and wrap them up in a dmabuf. No uapi at all.
>>>
>>> The point is that dmabuf already provides ops that do basically what
>>> is needed here. We don't need ops calling ops just because dmabuf's
>>> ops are not understsood or not perfect. Fixup dmabuf.
>>
>> Those ops, for example, are used to efficiently return used buffers
>> back to the kernel, which is uapi, I don't see how dmabuf can be
>> fixed up to cover it.
> 
> Sure, but that doesn't mean you can't use dma buf for the other parts
> of the flow. The per-page lifetime is a different topic than the
> refcounting and access of the entire bulk of memory.

Ok, so if we're leaving uapi (and ops) and keep per page/sub-buffer as
is, the rest is resolving uptr -> pages, and passing it to page pool in
a convenient to page pool format (net_iov). I don't see how dmabuf would
help here. Adding dmabuf in the middle (internally wrapping pages) would
add more setup code with the same final result, that is a format that
page pool can work with. And for io_uring it's normal user memory. We'll
have to use dmabuf when we'd want to extend to peer-to-peer and all that
fun, but that's a small fraction of it, and we'll hopefully reuse some
setup helpers from devmem tcp.

-- 
Pavel Begunkov

