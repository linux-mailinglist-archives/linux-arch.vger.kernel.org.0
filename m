Return-Path: <linux-arch+bounces-2836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66191873928
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 15:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D8A1C21995
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449C7FBDC;
	Wed,  6 Mar 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkUcN0eG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394128EC;
	Wed,  6 Mar 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735461; cv=none; b=VhWEmjxD1H9bRk6B36OqaFrsrFXgwNXOtZoGgoYvgnrOgJ9UXJ/xMFCZAT3zPsw9HNHLPAD25aZ/wcCQEWBXZ+OYUN0N3kWZ01W6erU2Anbb5FP6NFb9R6SYjJIV4xEoyk3pVOVgY5fJL7voiVWDgwl8M0v9umqYmYCyZUyQ6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735461; c=relaxed/simple;
	bh=c+oW+n9OmJ9otIOsnLXK3dE6Rc448U9Z9kACrJJIO2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANbOEJFCbfmiISM1+/VwGO2IVBhwFSEVkqHSxkf37W2sUZ08WcHnvRkoWEaJsBKZHwT7kBAborYakV+wdYG5ErmPPBIkl84uiMed5DAO41+DMZzINQ6rO9g+//sYKf2nBxBAgOw4yeOeBQ2AWo17mexz0R5IlrPVVkxUZYKEcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkUcN0eG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso606411f8f.0;
        Wed, 06 Mar 2024 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709735458; x=1710340258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gPi0O1pSzLWSoH4x6QWh1/CSGMtQOXhMfU653rtclc=;
        b=BkUcN0eGswL7r3Gyb7iUrTMao72c3aWMjOp2Si5ae3bPuWcqzHEkTv8CPJlLyRm8Ox
         Sq2ELWHdupgFz7LNmbHsaqrJjZ9oTDizBZZJ67Ub3rOf/rH32S3Pa8vauD2RwT857F3h
         5dkxdK0vJFyO2hlJdBhe0CcoPixSix5k0nHmdDeuHx/pX0oD6ZwhNqDKpe3IarEQRUaP
         BznYSGgjsPd0aywg6Csa8y0esKWvbVvCNpYxixoDqoXAGcRAJpBF0Kt7aeYMpY9ZJXnE
         D/0ESEWfgBI2fVT9bwBMtCnwHbFOl/elYxTDX84+DKV5iXQ2DRYjfwSuH1jaENmY+mID
         fMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735458; x=1710340258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gPi0O1pSzLWSoH4x6QWh1/CSGMtQOXhMfU653rtclc=;
        b=mTtoXOmKXWqs/1COf/peUw78qTPEHEhGX+AVoLdUyZX6VdwHcrPKHuSg3WZpUe28vU
         TW2qO4UxRH0X9M3Hnyc2h0UujgZhwSltshU3uQZFuWU/CKJI5IuxoOMDc6OetCUif2Gx
         c28Qfem3kllF3yJdEAgVzJmyFFyYQlXJ/7g7lCDsnclJHJapvWae8LsMNY1O2ol0g9mO
         8BXWR3xycYDmq0UK/W6GC5K8g2QiMXo82IE7Os85rAITrdsvv+Ch7ujYBc6ObTUjFpEa
         rZVw0IxqU3ZfKQu5CyPFjNd2x+KnmZV7Vz79crvP1AYkFCm8LhKTIFt0CaB+kn3iMm5K
         7NmA==
X-Forwarded-Encrypted: i=1; AJvYcCXwkUMB3lKxpbyoVok6CqIHoGygaeKj2bjXT6relNWY9UUNpCwPqER1AvS4qm2OqM8azU8er/V03sn9MQ7RLmN3Ebesy5QMu4E8f/zFQgjnwLiOXGO25rHZ4+borcCt7xuaJWGu4fOzogod8fa7YobCu/neJ3F80Wm/sAJiOUsTZJK4nZu8zk6HNCX3nJynnXiZTj09PXf2OUe8h0RWclmdFn1Q/Y4ltOFhmeuI3mYN1p0jF9YA00fB3gkLitE0ktM5IlI0Mbjjd3OJzAY35lzNawgP/iqYayx5LGPC0r4o6ufkbT9Rk/zSBQtny52HDn46k61KoxOlZz2aJqCWjTKaVEKyo0ju51GHCf9cSN1SXhPJkrJWlAH1uBIP3ir6En6Am3+xs/e9yPCfCafFmlMJUaAm8lOLC8rhRpU2FlXm9596lt+HdsbZMEuSe8DV9j+N7/yhFFK+4Iy7GRWYsYMI5UT1Oyka/ErInnukVw==
X-Gm-Message-State: AOJu0YzDV2LJqTBRLrTt2NIUuJFlAwsMOPFkCIZudQzo5uSwJNOEeyqH
	wL3fG91elIx9Ki3t5eQ9OlM1GaLuxgsbKkOlk4n1SiIV9F5PNDPy
X-Google-Smtp-Source: AGHT+IEYb/zvAdaoWBUPDQ15vntU0mFqlnMjPDxyUnwJQKR8m4S+14qR/7MrevMi7+m6WnrGgoXePg==
X-Received: by 2002:adf:f389:0:b0:33e:592c:d7da with SMTP id m9-20020adff389000000b0033e592cd7damr1501141wro.9.1709735457704;
        Wed, 06 Mar 2024 06:30:57 -0800 (PST)
Received: from [192.168.8.100] ([85.255.233.174])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b0033e45e4f22bsm5982974wrb.73.2024.03.06.06.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 06:30:57 -0800 (PST)
Message-ID: <417f293a-848e-4eb2-b690-c8696079b452@gmail.com>
Date: Wed, 6 Mar 2024 14:29:56 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, shakeel.butt@linux.dev
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
 <1b57dac2-4b04-4bec-b2d7-d0edb4fcabbc@davidwei.uk>
 <CAHS8izM5O39mnTQ8mhcQE75amDT4G-3vcgozzjcYsAdd_-he1g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izM5O39mnTQ8mhcQE75amDT4G-3vcgozzjcYsAdd_-he1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/24 22:36, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 1:55 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-03-04 18:01, Mina Almasry wrote:
>>> +struct memory_provider_ops {
>>> +     int (*init)(struct page_pool *pool);
>>> +     void (*destroy)(struct page_pool *pool);
>>> +     struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
>>> +     bool (*release_page)(struct page_pool *pool, struct page *page);
>>
>> For ZC Rx we added a scrub() function to memory_provider_ops that is
>> called from page_pool_scrub(). Does TCP devmem not custom behaviour
>> waiting for all netmem_refs to return before destroying the page pool?
>> What happens if e.g. application crashes?
> 
> (sorry for the long reply, but he refcounting is pretty complicated to
> explain and I feel like we need to agree on how things currently work)
> 
> Yeah, the addition of the page_pool_scrub() function is a bit of a
> head scratcher for me. Here is how the (complicated) refcounting works
> for devmem TCP (assuming the driver is not doing its own recycling
> logic which complicates things further):
> 
> 1. When a netmem_ref is allocated by the page_pool (from dmabuf or
> page), the netmem_get_pp_ref_count_ref()==1 and belongs to the page
> pool as long as the netmem is waiting in the pool for driver
> allocation.
> 
> 2. When a netmem is allocated by the driver, no refcounting is
> changed, but the ownership of the netmem_get_pp_ref_count_ref() is
> implicitly transferred from the page pool to the driver. i.e. the ref
> now belongs to the driver until an skb is formed.
> 
> 3. When the driver forms an skb using skb_rx_add_frag_netmem(), no
> refcounting is changed, but the ownership of the
> netmem_get_pp_ref_count_ref() is transferred from the driver to the
> TCP stack.
> 
> 4. When the TCP stack hands the skb to the application, the TCP stack
> obtains an additional refcount, so netmem_get_pp_ref_count_ref()==2,
> and frees the skb using skb_frag_unref(), which drops the
> netmem_get_pp_ref_count_ref()==1.
> 
> 5. When the user is done with the skb, the user calls the
> DEVMEM_DONTNEED setsockopt which calls napi_pp_put_netmem() which
> recycles the netmem back to the page pool. This doesn't modify any
> refcounting, but the refcount ownership transfers from the userspace
> back to the page pool, and we're back at step 1.
> 
> So all in all netmem can belong either to (a) the page pool, or (b)
> the driver, or (c) the TCP stack, or (d) the application depending on
> where exactly it is in the RX path.
> 
> When an application running devmem TCP crashes, the netmem that belong
> to the page pool or driver are not touched, because the page pool is
> not tied to the application in our case really. However, the TCP stack
> notices the devmem socket of the application close, and when it does,
> the TCP stack will:
> 
> 1. Free all the skbs in the sockets receive queue. This is not custom
> behavior for devmem TCP, it's just standard for TCP to free all skbs
> waiting to be received by the application.
> 2. The TCP stack will free references that belong to the application.
> Since the application crashed, it will not call the DEVMEM_DONTNEED
> setsockopt, so we need to free those on behalf of the application.
> This is done in this diff:
> 
> @@ -2498,6 +2498,15 @@ static void tcp_md5sig_info_free_rcu(struct
> rcu_head *head)
>   void tcp_v4_destroy_sock(struct sock *sk)
>   {
>    struct tcp_sock *tp = tcp_sk(sk);
> + __maybe_unused unsigned long index;
> + __maybe_unused void *netmem;
> +
> +#ifdef CONFIG_PAGE_POOL
> + xa_for_each(&sk->sk_user_frags, index, netmem)
> + WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem, false));
> +#endif
> +
> + xa_destroy(&sk->sk_user_frags);
> 
>    trace_tcp_destroy_sock(sk);
> 
> To be honest, I think it makes sense for the TCP stack to be
> responsible for putting the references that belong to it and the
> application. To me, it does not make much sense for the page pool to
> be responsible for putting the reference that belongs to the TCP stack
> or driver via a page_pool_scrub() function, as those references do not
> belong to the page pool really. I'm not sure why there is a diff
> between our use cases here because I'm not an io_uring expert. Why do
> you need to scrub all the references on page pool destruction? Don't
> these belong to non-page pool components like io_uring stack or TCP
> stack ol otherwise?

That one is about cleaning buffers that are in b/w 4 and 5, i.e.
owned by the user, which devmem does at sock destruction. io_uring
could get by without scrub, dropping user refs while unregistering
ifq, but then it'd need to wait for all requests to finish so there
is no step 4 in the meantime. Might change, can be useful, but it
was much easier to hook into the pp release loop.

Another concern is who and when can reset ifq / kill pp outside
of io_uring/devmem. I assume it can happen on a whim, which is
hard to handle gracefully.

-- 
Pavel Begunkov

