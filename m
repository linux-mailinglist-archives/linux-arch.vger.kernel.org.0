Return-Path: <linux-arch+bounces-4654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87988D8579
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD4289BE6
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3812F5A5;
	Mon,  3 Jun 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSOJ0OvT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2112D1F1;
	Mon,  3 Jun 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426353; cv=none; b=DJbMyFL2arg6hGGFdAcpSVfz4j7/npFDdEA6Toa4p+w0kuLqVIjlUxtKzMOLleRk5zbLLSh1ac986ZmVoNcc/q1EKoaWEuQKOS7AzU67BF74c3IjEqSYuiIIqHNukscmGTImHPHEj4JH1d2NRQP3f41zTFXBHywIWctx+yTLttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426353; c=relaxed/simple;
	bh=wUNte8raa3GqYXUgFYODM68puHDovUgTvfDgiRlKYMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neP7fDPI0dSpGsPQnfLvEiNjOdkO14vRz7R9q0I4rddZrcptOYk4TMss/a6lxezKa8lIyZZ8U7FoVipRtHtYB9M+lLnoZhw+nrcW6hlyMbSA0JdohO6eM0NTDrxkrg1+dmCgg4QzMxwwx0UTpQdrWFbwZwdIMrr+Cgs/88js3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSOJ0OvT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so5146942a12.2;
        Mon, 03 Jun 2024 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717426350; x=1718031150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFaFTQnu+hpbSIZgsrwPb2+pTUe1zvaznlAq9n5uYoY=;
        b=bSOJ0OvTjP8vrjy05Bk9TWU5rOdYIKgAA3ig7VgB2lctXYofvXD9c1bxyVPoIV+3ex
         CmniemwQa56LWyjGYKKxqEev8/i2KI4X6Epd3QwOaAqiyElsCM/3ttuAiSA6xkTDvlm7
         sFyrIPjMN1CKPsh3cCdqaa62i+qh+DuwZ6BoCFdFZBMsV7rRNl2s9D8epXjNXp+EFWum
         RuYDfeLJoza8KhNi2VumW9YWTOwJzDOSo853rr1tNGfGVbZwm29UWpBe/CVm5vutGWpT
         WWKzUixAtCru5hOmdWcq4PxNkis5/9lWkL1CNt+A1tG13gC7ZF55v8xOxPUqLiKOoJ/Z
         HroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426350; x=1718031150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFaFTQnu+hpbSIZgsrwPb2+pTUe1zvaznlAq9n5uYoY=;
        b=hFr5msJuZkCJXM97flLvUFYlR/dzCligi5eNTXqwH8BZdz8IvIx8FXJ1IUx/dP9zHf
         dqo/I3CI3GPU0rZbPo3sq3vQ4y1QmGtdgY0W62AortJA/1PFlTcREDlNj+1Enkz3VXMt
         ngFpmO403m+QN8HSKxVNx9d5wpXpSr5og2LuZ3kdn9oue9Bm6LM6MknTCwU2/7UEYIOh
         VQPOMgy3f722aFIP60uU+G5651KPwLJ8b9p698i+b4aZUXEtj4yGnj8uw0Vet37FRANI
         rzQVWHtpQhsMOLSB8zAhjjo82AN08KOWKKAQoyDmINyxG2TRaGGfnXfak0Ak8qxkBmRT
         TFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwFZs367fR/S68blWftiFku6Zgz/ldtFYIvA9dhqX7bdQLllfbQBjOHbeY87BfuiDg3IZX0h4ovuTfd2K2hHUtog2KVj09t0H43wYqByYLrtnhwp3RNNn258M8I12SLbk4Y7TY3Njw58f+fFweONMaZrpunRA9elSR2FDidxHJ1h3fq7VsQZFHAtncbEC4vtnbcwqNXZpT/tdZMyp3o6vS62r7rXJY2XG5pVw0mk6wOG346r5lhNKULI4uwM+uEynViK6Rsxta4aFpGAcHNaF7ytBbf1q94L7ccByU/LvsOrb5FzLloI5PrjST3CdXZmxW6K70QoqeyoliZdwf/DdOdEpUbJMM1paZi4NX5Bpn7pqXl6MG4fVN6Lec3vY+be+lN+0eQsj43/yFNlt2guzAQGm5AbeLV7y8FaTLERtaTtDfe2BSOjjp8QFHbmdJR5qnANihc6vfxY4xG8qL1cvwJqBLJGMIvl4KB4FCRw==
X-Gm-Message-State: AOJu0Yzu0MPNg6OpnKNa2z6pcQM7v570VTIv8eWfNrgV44NyuIffGEjz
	77QUCnFYUoZOEhCCEx/bzC9XIPeHJtdVJA0Ki67ByetDkLIsFogQ
X-Google-Smtp-Source: AGHT+IFgHeYMPC1F2CzjSrGxnlZt3dlTY/4mpUD7bv8LIwoX5HsdsamER8RdMH7fBsEWw3jyn6a+HQ==
X-Received: by 2002:a50:8d4f:0:b0:572:a731:dd14 with SMTP id 4fb4d7f45d1cf-57a36450a67mr5894483a12.28.1717426349978;
        Mon, 03 Jun 2024 07:52:29 -0700 (PDT)
Received: from [192.168.42.244] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be4df2sm5365768a12.47.2024.06.03.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 07:52:29 -0700 (PDT)
Message-ID: <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
Date: Mon, 3 Jun 2024 15:52:32 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
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
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/24 15:17, Mina Almasry wrote:
> On Fri, May 31, 2024 at 10:35 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Thu, May 30, 2024 at 08:16:01PM +0000, Mina Almasry wrote:
>>> I'm unsure if the discussion has been resolved yet. Sending the series
>>> anyway to get reviews/feedback on the (unrelated) rest of the series.
>>
>> As far as I'm concerned it is not.  I've not seen any convincing
>> argument for more than page/folio allocator including larger order /
>> huge page and dmabuf.
>>
> 
> Thanks Christoph, this particular patch series adds dmabuf, so I
> assume no objection there. I assume the objection is that you want the
> generic, extensible hooks removed.
> 
> To be honest, I don't think the hooks are an integral part of the
> design, and at this point I think we've argued for them enough. I
> think we can easily achieve the same thing with just raw if statements
> in a couple of places. We can always add the hooks if and only if we
> actually justify many memory providers.
> 
> Any objections to me removing the hooks and directing to memory
> allocations via simple if statements? Something like (very rough
> draft, doesn't compile):

The question for Christoph is what exactly is the objection here? Why we
would not be using well defined ops when we know there will be more
users? Repeating what I said in the last thread, for io_uring it's used
to implement the flow of buffers from userspace to the kernel, the ABI,
which is orthogonal to the issue of what memory type it is and how it
came there. And even if you mandate unnecessary dmabuf condoms for user
memory in one form or another IMHO for no clear reason, the callbacks
(or yet another if-else) would still be needed.

Sure, Mina can drop and hard code devmem path to easy the pain for
him and delay the discussion, but then shortly after I will be
re-sending same shit. So, what's the convincing argument _not_ to have
it?


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
>          else
>                  netmem = __page_pool_alloc_pages_slow(pool, gfp);
>          return netmem;
> 
> 

-- 
Pavel Begunkov

