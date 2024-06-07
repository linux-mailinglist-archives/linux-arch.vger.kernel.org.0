Return-Path: <linux-arch+bounces-4747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3AF900545
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 15:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F631F27593
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817BC194A53;
	Fri,  7 Jun 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCfMYz/Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0001194157;
	Fri,  7 Jun 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767775; cv=none; b=D6YM7XBeFOrfNhvC3WRT6zyS5hZZcsFw1U4o4j0SN30qARcANliUu1G+WcRB+BrPc4GoOwmAjT93OVoVF0OJXq2T+I9cxUG8MFX02Uxvs7mtBBEHBOiCLw+Z7rEUiCjBxL+EmxYV05Hvhz3FVu3DV4q5mNYpIwrqvawLQPUqpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767775; c=relaxed/simple;
	bh=SaO4qNMKQ+X9pN+adg0sAB0LFr6aV+Wq0JGv5RvFCkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv2Nce0Izrk87JtaR1DggSGqcCrfd4nySgx1RQ6LAwZ7IAfCv+lTAzpJs0YV0dy8HkVu8NhXtjJ7L9oDimw9qUi4ha7/X7GDttzo+knbGLsHA5+J13dE5F//pYYVY17BV92CYwW5idepzcQY+nhwjXUkqon0/M3GNbllDE+cgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCfMYz/Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68f1017170so276072966b.0;
        Fri, 07 Jun 2024 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767772; x=1718372572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQvJWXNRaDSMtIW4Jv2ND5NqVCptWS7FYEPyb+9ayJA=;
        b=jCfMYz/Qv7M9+TJb3zYqe4WGfvHIxc9mpJeywgshd+qsrOr3dWfobOhl9U2/AfIr2Q
         mv7osJzxDV14Va2ZngbimcgecIEHbTEZRFQNr0Mo8+0LLGKBDnHf3zpHlK+ztnxeQf0w
         pyBbBqrHXFWFBj2J0h2et5lo2Kuy5zO62y6EKHv2Ur6wvyRuAC/WCR7ZmVm5uhNO2iZx
         293IV7nN3X+He4nCOcEoAh/eI5TBurzTRlIs2SF5K2H5wnWOr+ohjeD667olPQXhkjdk
         vvwFS48FEBY+yfCihRnQ3Lm82r4C2QejhEfk/WSsBfWpL3W5ntEl4tmsRaoW72DWxntS
         LckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767772; x=1718372572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQvJWXNRaDSMtIW4Jv2ND5NqVCptWS7FYEPyb+9ayJA=;
        b=KRf+c+1v7KV/zvc7cfq5depzXaCzjy5kdmWBi+6aeKz8NxJSbKORJWbrGgHsh1d+fb
         QK73sdjTkLJ+/BegP2n/M8g/HbamvWfepdxDYpmn8fEVEcWV9lKaEmi9LQIWtsw952N3
         ELE8XABa8QK9BedEHDgoUtnMVUfdcQcH1tADJmO51xBl/ePcvWMK4kFyHqZlwGoPx395
         M63lAp2jRAH15ILv+d1ty3YfQxAsXKy4uoIWoSzyvEq0z7TIpyLo3tdWNEHX8vjao9+T
         oHVk9nCPbu/wSjVOoJniRReiKwtCAW46XG4oacxPWVVrOUZfsX4wEYkTnGX5fOGaTpW8
         18xA==
X-Forwarded-Encrypted: i=1; AJvYcCXPtDKS8sYlR76k3Q+C/Tegm8nIgNBuM8AaG6SKppK+RT1OIO30alkjJ3URPDTOCAJ+TfYbYQUg/HdmWiiftgylGHsDkpOmlE0bRwa964jKkUCo5ewnvwTNBzRNCHOkuYjWAybEbQwVFhkbxk685VyGhr/lIkl5rir1QaTdK46ud7dzhBFYzoJfarD16HJWfxF2D5agH4QCFqMlNx3UHGhINuXtHSvB99baTqMvKoFXQxq3iUGQGlvXlqcJbanWnK5qK0E0rupanaAztlKRtD3bPqXJqe3pNzfaDbvpSx3FAL6pvhb/qbjt6WmIP3vykqmPzlTwYHbRJXJ+ekvMDoAyH7sdP4ZrHAjanxJm+4d2dh6y4RaeYa1baDWajIyzFxxZKyKesj38YgA3e+aoYM/8UvOg1oQJcbNzyJ9KMk9fN19ktOZHMQwUN4brsPk9a44JoLhNYb88LNy7afG0p+dGiIs7Lc/9vwpHVx607n2TkxK1f4T8C2S0fAxzYLqDhs04UiTtsw==
X-Gm-Message-State: AOJu0YxvgTDRPm7gwp8+8vkwDqfZmafEtY3bFP/Uqlxg7N4J9kCpdSvS
	7RVoHwNF2HoCVUXsVI44j//pUnF5qIjZtLFfedHEUUClSvpFlrlfYNK0xIHj
X-Google-Smtp-Source: AGHT+IFclc2dDyjV0e9a5PXYgUTUusiUWbxIzgPbh6TUxBel8tm9M3qb2yzcyQfG8c9PwgVnd9uoBw==
X-Received: by 2002:a17:906:15c9:b0:a68:dff5:b153 with SMTP id a640c23a62f3a-a6cd75b3e98mr195015166b.33.1717767771673;
        Fri, 07 Jun 2024 06:42:51 -0700 (PDT)
Received: from [192.168.42.51] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e51c85a05sm68724866b.159.2024.06.07.06.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 06:42:51 -0700 (PDT)
Message-ID: <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
Date: Fri, 7 Jun 2024 14:42:53 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/24 16:43, Mina Almasry wrote:
> On Mon, Jun 3, 2024 at 7:52 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 6/3/24 15:17, Mina Almasry wrote:
>>> On Fri, May 31, 2024 at 10:35 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>>
>>>> On Thu, May 30, 2024 at 08:16:01PM +0000, Mina Almasry wrote:
>>>>> I'm unsure if the discussion has been resolved yet. Sending the series
>>>>> anyway to get reviews/feedback on the (unrelated) rest of the series.
>>>>
>>>> As far as I'm concerned it is not.  I've not seen any convincing
>>>> argument for more than page/folio allocator including larger order /
>>>> huge page and dmabuf.
>>>>
>>>
>>> Thanks Christoph, this particular patch series adds dmabuf, so I
>>> assume no objection there. I assume the objection is that you want the
>>> generic, extensible hooks removed.
>>>
>>> To be honest, I don't think the hooks are an integral part of the
>>> design, and at this point I think we've argued for them enough. I
>>> think we can easily achieve the same thing with just raw if statements
>>> in a couple of places. We can always add the hooks if and only if we
>>> actually justify many memory providers.
>>>
>>> Any objections to me removing the hooks and directing to memory
>>> allocations via simple if statements? Something like (very rough
>>> draft, doesn't compile):
>>
>> The question for Christoph is what exactly is the objection here? Why we
>> would not be using well defined ops when we know there will be more
>> users? Repeating what I said in the last thread, for io_uring it's used
>> to implement the flow of buffers from userspace to the kernel, the ABI,
>> which is orthogonal to the issue of what memory type it is and how it
>> came there. And even if you mandate unnecessary dmabuf condoms for user
>> memory in one form or another IMHO for no clear reason, the callbacks
>> (or yet another if-else) would still be needed.
>>
>> Sure, Mina can drop and hard code devmem path to easy the pain for
>> him and delay the discussion, but then shortly after I will be
>> re-sending same shit.
> 
> You don't need to re-send the same ops again, right? You can add io
> uring support without ops. Something like:
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 92be1aaf18ccc..2cc986455bce6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -557,8 +557,8 @@ netmem_ref page_pool_alloc_netmem(struct page_pool
> *pool, gfp_t gfp)
>                  return netmem;
> 
>          /* Slow-path: cache empty, do real allocation */
> -       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> -               netmem = pool->mp_ops->alloc_pages(pool, gfp);
> +       if (unlikely(page_pool_is_dmabuf(pool)))
> +               netmem = mp_dmabuf_devmem_alloc_pages():
> +       else if (unlikely(page_pool_is_iouring(pool)))
> +               netmem = mp_io_uring_alloc_pages():
>         else
>                  netmem = __page_pool_alloc_pages_slow(pool, gfp);
>          return netmem;
> 
> So IMO, the ops themselves, which Christoph is repeatedly nacking, are
> not that important.
> 
> I humbly think the energy should be spent convincing maintainers of
> the use case of io uring memory, not the ops. The ops are a cosmetic

I haven't seen any arguments against from the (net) maintainers so
far. Nor I see any objection against callbacks from them (considering
that either option adds an if).

And just not to confuse folks, it's just user pages, not some
weird special io_uring memory.

> change to the code, and can be added later. Christoph is nacking the
> ops because it gives people too much rope [1].

Yes, it is cosmetic, just as much as removing it is a cosmetic
change. You can apply same "too much rope" argument basically
to anything.

Take io_uring, nothing would change in the process, it'd still
be sent to net and reviewed exactly same way, while being less
clean, with poorer subsystem separation, allowing custom
formats / argument list, etc. I think it's cleaner with callbacks,
Mr. Christoph has other beliefs and keeps coercing to them,
even though from time to time it backfires for the author, just
personal experience.


> But if you disagree and think the ops themselves are important for a
> reason I missed, I'm happy waiting until agreement is reached here.
> Sorry, just voicing my 2 cents.
> 
> [1] https://lore.kernel.org/netdev/ZjjHUh1eINPg1wkn@infradead.org/
> 

-- 
Pavel Begunkov

