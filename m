Return-Path: <linux-arch+bounces-2881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C7874030
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4CE280D9B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA513E7ED;
	Wed,  6 Mar 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViWF+FBv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2413E7DB;
	Wed,  6 Mar 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752464; cv=none; b=loGbv408TEa9RHBx1373figaTC8c7O6QaPjoa0gSIYEpQuBCwSYVV/ge3+UFULqA5z4aWT6PKsFQMJ2C/pP7eUVt9qJ84n7/8hFeN4dD6gFrgZhJN9EWh3af7O7+H7b+3hwRlNu87xg5/pE+7kcBoMBSZBNMTbwQSHzfXe5WxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752464; c=relaxed/simple;
	bh=rqeHAwxjnBJfSjkh66zxDx3278+2ytmY3CRS/ZATqfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFLV5EyvDJy6u9emfgK0JHs+RjibcGx/66ywUmpT32aZjdKMe/exQV7QZxpktM2bZHfd4PnkoBobh5TB+AlZjE6c/ehXFXvJGz8MyYUsCac+jrsBRU4IxSkJoZ6ZIxwkfZ+Tinve8SfZsxMmdvscm6V9p+R2V3CGUW//iDRQvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViWF+FBv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a450615d1c4so23425466b.0;
        Wed, 06 Mar 2024 11:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752461; x=1710357261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koyC+OXWaVBitynJT4B5M9yEfbXa623u0u8Rn+ueAuI=;
        b=ViWF+FBvFlvBOiv5PWd8lqtxy62GRdL5k8hrxoy9p20taYwc758/aHJZXCv2+nBCPv
         qdssh2R0rkZh1yG+/oHkP+uAPqhObdc7dtJAcfG/+JVo2mQqiHzt8/NRCDv2U0/0lSdb
         Yir14GaJjWcgTdXnrBUGNn9sr+/bBxO8CD+6AEUDeKCR/W9595868P+Oz0B0M0t0mTNM
         oXPI11DlFkqa/vfHF8NHGachH/drmTFjNI4LepEGdDRXg6juU6KcNbDadAsxpI+gasT3
         iLaOGZq9AaX8TQw9bzQtFfFgANzG2zhorb8B2tSAeR9If0aRdWFwjgoqjpjNHV+5uiMn
         Jl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752461; x=1710357261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koyC+OXWaVBitynJT4B5M9yEfbXa623u0u8Rn+ueAuI=;
        b=QNsR6mXmjyD8/QQ5C5PdNEXVD/GPAYuCjpnpqvK1d/PbT9sUZtRU5WyUGBRVY3fhqc
         lUn7CYj/DS3jwHJKzKlR5Lp7va8v/TfSiHQTQDZTXeVhmZr222Z4SoQXFTnZ5tdAU1t3
         Vt9f8lwEPbOvNra5C9P5SWwdjCzZUdGd9FuIhwB+ky0RFpeyAXys1WRahZBYnMmkwecf
         5EzQ92KMADYp0JmxpX+LBBRkT+aPLld7gkrTqGMpP1F6Mn5TZhuhZ4ljuzeyCrh54Imo
         JTMgWKczAcKAXfy2tlBrzAiknPHpcYF2E/PoDItJdg2QnlOYjzvWLrb/JaLRZwaY+7Lp
         0PYw==
X-Forwarded-Encrypted: i=1; AJvYcCVrOja2zARvneyG562nxQHrlzimwkdzbE82PK+4BZ1RToTx3C95zCrrsFaMMvT7qtQ40RNK9wHAzTJNtjC6jImSaQFcSU8/yl2snfEyEOEOSq/qHJzi9zLK4rFtMTiduFlz4QFlmNm03L6WW00aeIwf4FUKSUB9PCiFBc1/t205fvoXFZegcpVdeW2HoSueJ0FXb3dfNGlU4xOg7it6H9Jb2zq4iR7pikdM2KVhEMPIIezbJiA/X5jZwOxK9mmfBxIM3romxZji9yBiNWN4uxggMasPoi2aWERXEjv0mydV/D85z+YEw7+Xjy3FIAe/AkT90ghwcsSv8DZUVH51TQTtXvu+gXLGCIG6Pa2TZb9bxqc6yt/eFoLo2KdFCVC9LiplpZVPOvtnR5pSvGZyjJ3zKGVRXwi9AjGvOE9FWWI8+3+fYpcSSleaUi9rB/OPg8GcJV67+LgdaqiEMpZHL6Q/xS13lFswCr7JW93EAGXnw3phls+RWx6UrVZzQuuRZWBFnujYmg==
X-Gm-Message-State: AOJu0YxhSRB0qK/UuVoXCMmPC9+K8Mkr08GGN1h2Z57fdHjEF5zxwOtD
	TZ4l4iw7s7YCeweEjdvfjUZnH66L+rPwHCNQo+wLXxTJMb3/nK/G
X-Google-Smtp-Source: AGHT+IFItB8heVRezTYv3CUtiqgvQIid/hRamLnrcs20FhE6FaoKpuU57YkPC1CFMKt9DanhDiASxQ==
X-Received: by 2002:a17:906:74d:b0:a45:8b6d:42c9 with SMTP id z13-20020a170906074d00b00a458b6d42c9mr5974291ejb.23.1709752460817;
        Wed, 06 Mar 2024 11:14:20 -0800 (PST)
Received: from [192.168.8.100] ([148.252.132.18])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170906e94b00b00a455d78be5bsm3479312ejb.9.2024.03.06.11.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:14:20 -0800 (PST)
Message-ID: <772b9ab0-c6d7-4b13-8e05-44dd312b9879@gmail.com>
Date: Wed, 6 Mar 2024 19:12:58 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>
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
 <417f293a-848e-4eb2-b690-c8696079b452@gmail.com>
 <CAHS8izNPtHb2GnEMviiJTFT_dPxsxgYsNw5V9s-gSC2YnJRPRg@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNPtHb2GnEMviiJTFT_dPxsxgYsNw5V9s-gSC2YnJRPRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/6/24 17:04, Mina Almasry wrote:
> On Wed, Mar 6, 2024 at 6:30 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 3/5/24 22:36, Mina Almasry wrote:
>>> On Tue, Mar 5, 2024 at 1:55 PM David Wei <dw@davidwei.uk> wrote:
>>>>
>>>> On 2024-03-04 18:01, Mina Almasry wrote:
>>>>> +struct memory_provider_ops {
>>>>> +     int (*init)(struct page_pool *pool);
>>>>> +     void (*destroy)(struct page_pool *pool);
>>>>> +     struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
>>>>> +     bool (*release_page)(struct page_pool *pool, struct page *page);
>>>>
>>>> For ZC Rx we added a scrub() function to memory_provider_ops that is
>>>> called from page_pool_scrub(). Does TCP devmem not custom behaviour
>>>> waiting for all netmem_refs to return before destroying the page pool?
>>>> What happens if e.g. application crashes?
>>>
>>> (sorry for the long reply, but he refcounting is pretty complicated to
>>> explain and I feel like we need to agree on how things currently work)
>>>
>>> Yeah, the addition of the page_pool_scrub() function is a bit of a
>>> head scratcher for me. Here is how the (complicated) refcounting works
>>> for devmem TCP (assuming the driver is not doing its own recycling
>>> logic which complicates things further):
>>>
>>> 1. When a netmem_ref is allocated by the page_pool (from dmabuf or
>>> page), the netmem_get_pp_ref_count_ref()==1 and belongs to the page
>>> pool as long as the netmem is waiting in the pool for driver
>>> allocation.
>>>
>>> 2. When a netmem is allocated by the driver, no refcounting is
>>> changed, but the ownership of the netmem_get_pp_ref_count_ref() is
>>> implicitly transferred from the page pool to the driver. i.e. the ref
>>> now belongs to the driver until an skb is formed.
>>>
>>> 3. When the driver forms an skb using skb_rx_add_frag_netmem(), no
>>> refcounting is changed, but the ownership of the
>>> netmem_get_pp_ref_count_ref() is transferred from the driver to the
>>> TCP stack.
>>>
>>> 4. When the TCP stack hands the skb to the application, the TCP stack
>>> obtains an additional refcount, so netmem_get_pp_ref_count_ref()==2,
>>> and frees the skb using skb_frag_unref(), which drops the
>>> netmem_get_pp_ref_count_ref()==1.
>>>
>>> 5. When the user is done with the skb, the user calls the
>>> DEVMEM_DONTNEED setsockopt which calls napi_pp_put_netmem() which
>>> recycles the netmem back to the page pool. This doesn't modify any
>>> refcounting, but the refcount ownership transfers from the userspace
>>> back to the page pool, and we're back at step 1.
>>>
>>> So all in all netmem can belong either to (a) the page pool, or (b)
>>> the driver, or (c) the TCP stack, or (d) the application depending on
>>> where exactly it is in the RX path.
>>>
>>> When an application running devmem TCP crashes, the netmem that belong
>>> to the page pool or driver are not touched, because the page pool is
>>> not tied to the application in our case really. However, the TCP stack
>>> notices the devmem socket of the application close, and when it does,
>>> the TCP stack will:
>>>
>>> 1. Free all the skbs in the sockets receive queue. This is not custom
>>> behavior for devmem TCP, it's just standard for TCP to free all skbs
>>> waiting to be received by the application.
>>> 2. The TCP stack will free references that belong to the application.
>>> Since the application crashed, it will not call the DEVMEM_DONTNEED
>>> setsockopt, so we need to free those on behalf of the application.
>>> This is done in this diff:
>>>
>>> @@ -2498,6 +2498,15 @@ static void tcp_md5sig_info_free_rcu(struct
>>> rcu_head *head)
>>>    void tcp_v4_destroy_sock(struct sock *sk)
>>>    {
>>>     struct tcp_sock *tp = tcp_sk(sk);
>>> + __maybe_unused unsigned long index;
>>> + __maybe_unused void *netmem;
>>> +
>>> +#ifdef CONFIG_PAGE_POOL
>>> + xa_for_each(&sk->sk_user_frags, index, netmem)
>>> + WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem, false));
>>> +#endif
>>> +
>>> + xa_destroy(&sk->sk_user_frags);
>>>
>>>     trace_tcp_destroy_sock(sk);
>>>
>>> To be honest, I think it makes sense for the TCP stack to be
>>> responsible for putting the references that belong to it and the
>>> application. To me, it does not make much sense for the page pool to
>>> be responsible for putting the reference that belongs to the TCP stack
>>> or driver via a page_pool_scrub() function, as those references do not
>>> belong to the page pool really. I'm not sure why there is a diff
>>> between our use cases here because I'm not an io_uring expert. Why do
>>> you need to scrub all the references on page pool destruction? Don't
>>> these belong to non-page pool components like io_uring stack or TCP
>>> stack ol otherwise?
>>
>> That one is about cleaning buffers that are in b/w 4 and 5, i.e.
>> owned by the user, which devmem does at sock destruction. io_uring
>> could get by without scrub, dropping user refs while unregistering
>> ifq, but then it'd need to wait for all requests to finish so there
>> is no step 4 in the meantime. Might change, can be useful, but it
>> was much easier to hook into the pp release loop.
>>
>> Another concern is who and when can reset ifq / kill pp outside
>> of io_uring/devmem. I assume it can happen on a whim, which is
>> hard to handle gracefully.
>>
> 
> If this is about dropping application refs in step 4 & step 5, then
> from devmem TCP perspective it must be done on socket close & skb
> freeing AFAIU, and not delayed until page_pool destruction. 

Right, something in the kernel should take care of it. You temporarily
attach it to the socket, which is fine. And you could've also stored
it in the netlink socket or some other object. In case of zcrx io_uring
impl, it's bound to io_uring, io_uring is responsible for cleaning them
up. And we do it before __page_pool_destroy, otherwise there would be
a ref dependency.

A side note, attaching to netlink or some other global object sounds
conceptually better, as once you return a buffer to the user, the
socket should not have any further business with the buffer. FWIW,
that better resembles io_uring approach. For example allows to:

recv(sock);
close(sock);
process_rx_buffers();

or to return (i.e. DEVMEM_DONTNEED) buffers from different sockets
in one call. However, I don't think it's important for devmem and
perhaps more implementation dictated.

> Think
> about a stupid or malicious user that does something like:
> 
> 1. Set up dmabuf binding using netlink api.
> 2. While (100000):
> 3.   create devmem TCP socket.
> 4.   receive some devmem data on TCP socket.
> 5.   close TCP socket without calling DEVMEM_DONTNEED.
> 6. clean up dmabuf binding using netlink api.
> 
> In this case, we need to drop the references in step 5 when the socket
> is destroyed, so the memory is freed to the page pool and available
> for the next socket in step 3. We cannot delay the freeing until step
> 6 when the rx queue is recreated and the page pool is destroyed,
> otherwise the net_iovs would leak in the loop and eventually the NIC
> would fail to find available memory. The same bug would be

By "would leak" you probably mean until step 6, right? There are
always many ways to shoot yourself in the leg. Even if you clean
up in 5, the user can just leak the socket and get the same result
with pp starvation. I see it not as a requirement but rather a
uapi choice, that's assuming netlink would be cleaned as a normal
socket when the task exits.

> reproducible with io_uring unless you're creating a new page pool for
> each new io_uring socket equivalent.

Surely we don't, but it's still the user's responsibility to
return buffers back. And in case of io_uring buffers returned
to the user are not attached to a socket, so even the
scope / lifetime is a bit different.

> But even outside of this, I think it's a bit semantically off to ask
> the page_pool to drop references that belong to the application IMO,
> because those references are not the page_pool's.

Completely agree with you, which is why it was in a callback,
totally controlled by io_uring.

-- 
Pavel Begunkov

