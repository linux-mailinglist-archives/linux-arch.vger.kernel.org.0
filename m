Return-Path: <linux-arch+bounces-4419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44058C64E7
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5271F24AA2
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E30604BB;
	Wed, 15 May 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DK+gEtqm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD085EE97
	for <linux-arch@vger.kernel.org>; Wed, 15 May 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768396; cv=none; b=QiAhQwzkERHulDsZDfjYG8WR52sg8TaZ79yImQvAP4urZNugrDwVFivJVy7CKNFq8WYW9U8RcVPjr6HVmx0aohKMpXW+NV9T4nhooZ6+3yL5HzEYJCVRTRkh/FGpPKrUjre1dSPGg3dJu7nSqGf3U/mMtilMI1BzCe6T5Jtpvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768396; c=relaxed/simple;
	bh=+EMK6b7qfktIFvrX/yoLCEmiPgCxTGiziO7yYK3P3rU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJCDiLE11SFh/u0xEfB/mHh7Cdpj1yFQWHRsfevt2IoBCiWsM8WG199fT9Oq5OkLKqMNNj8Fkbq5S4j3sefYM6QFVIGrmhczGG7PoftfVCrwwu99yhCzPPW3IQIr9wMb3vM8tCvEux/wXOlEPgEYrV/VRpV/l8Vwu1PdXHusGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DK+gEtqm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so1566825a12.0
        for <linux-arch@vger.kernel.org>; Wed, 15 May 2024 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715768391; x=1716373191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fdHvJkxYgHA+IRrFREj5QbL1lv8V1e57nVmevFIQbVs=;
        b=DK+gEtqmkb0jZ/CHh7UFa0VObjCqX95pEIy9AVKWg8R9+uBAQeX1wq1kySemn5w3pJ
         0k9SCtvjvzqxKGOAZKIQaSUiQlw/2yQ4e13tjG9Q+SL1gECZK5IzNkOCLLXybSi6QDmr
         yUqNDnXq7FbT9kkRg3qgpIOdVsAmgeGaSzsfm2qyrDNgDJTa1YPWz8fhKcqKqGLu5lZu
         TaTYgVSAMqtgIczhmzHNK2pu1kQqag85ESBXKoX+eVPkXy2wAFkr9UQGJRkCh8bRVbnA
         Pbz/mZLWkbtj2rebXLzLoMhm+rQiiremoorBu9eXu0nPNa7FIhkhLZ6OLaoOfcZuNqtJ
         WOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715768391; x=1716373191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdHvJkxYgHA+IRrFREj5QbL1lv8V1e57nVmevFIQbVs=;
        b=BXLXjurpV9GDXeMXXEC64bUSYszVblAk1ar6Ene5IHp2x/Ohf1Jm75D0WP+DgM1EuQ
         vZMUX9lGf6Bz9E/pYFTLeiIOD5lw9/SFKCKB6G7fg2CZoZP7bqOImsSikx41VTwci//N
         5hCW3Hsr6vFrq1d6rhJYIMzlpl+FpqBcRrupXH6UPXRM1jyfsfoFTM1QTkvlgR1V55XZ
         3IdWdq1VBfzhHaxC8j332L/acl5k+4sy4mk+Ba7FLms70bibyrdFv1xFLWqn42vaqbHU
         S4H0WLfHT5odrGKoDR5zlVKgDQeGKnPCGGTOf+w8v85kYGPvDsnLG+25hRXrrNcszNbm
         k9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhmyP0KuUqDLt3j5tM05shlNuAkur44nuWGkC0jzqAW0KtXrKTUomv0qGsG3pB6mvgXk9izc8xF9iv0XXUFf4HdfHgGIlDU2QiiA==
X-Gm-Message-State: AOJu0YxxWnq6s5gJDhQljza958CtHiPqBPqwRqqIAcP8tI2gxO1kLI2B
	dgHGM5/4UHvBgp0U0MWyMOPRsm2Bl0YmQU7dNFiAwK2dOr/62OIh3a9uZ0Rs7Ps=
X-Google-Smtp-Source: AGHT+IHWaSA/H+4L2d0rsT1ymvAysPmXQv4l8zitT6YQF2Rw+C8vn0POfuJW4lu+DIxHSNpoY53xBA==
X-Received: by 2002:a50:d59d:0:b0:572:7e7e:4296 with SMTP id 4fb4d7f45d1cf-5734d5c152dmr11481093a12.3.1715768391400;
        Wed, 15 May 2024 03:19:51 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b18dff66sm6291338a12.27.2024.05.15.03.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 03:19:50 -0700 (PDT)
Message-ID: <f9a8f912-5cb7-4184-be2d-187052c04e2e@blackwall.org>
Date: Wed, 15 May 2024 13:19:47 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 04/14] netdev: support binding dma-buf to
 netdevice
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-5-almasrymina@google.com>
 <59b1ec87-03dc-4336-8ce1-cb97e5abb7d6@blackwall.org>
Content-Language: en-US
In-Reply-To: <59b1ec87-03dc-4336-8ce1-cb97e5abb7d6@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 13:01, Nikolay Aleksandrov wrote:
> On 11/05/2024 02:21, Mina Almasry wrote:
>> Add a netdev_dmabuf_binding struct which represents the
>> dma-buf-to-netdevice binding. The netlink API will bind the dma-buf to
>> rx queues on the netdevice. On the binding, the dma_buf_attach
>> & dma_buf_map_attachment will occur. The entries in the sg_table from
>> mapping will be inserted into a genpool to make it ready
>> for allocation.
>>
>> The chunks in the genpool are owned by a dmabuf_chunk_owner struct which
>> holds the dma-buf offset of the base of the chunk and the dma_addr of
>> the chunk. Both are needed to use allocations that come from this chunk.
>>
>> We create a new type that represents an allocation from the genpool:
>> net_iov. We setup the net_iov allocation size in the
>> genpool to PAGE_SIZE for simplicity: to match the PAGE_SIZE normally
>> allocated by the page pool and given to the drivers.
>>
>> The user can unbind the dmabuf from the netdevice by closing the netlink
>> socket that established the binding. We do this so that the binding is
>> automatically unbound even if the userspace process crashes.
>>
>> The binding and unbinding leaves an indicator in struct netdev_rx_queue
>> that the given queue is bound, but the binding doesn't take effect until
>> the driver actually reconfigures its queues, and re-initializes its page
>> pool.
>>
>> The netdev_dmabuf_binding struct is refcounted, and releases its
>> resources only when all the refs are released.
>>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>
>> ---
>>
>> v9: https://lore.kernel.org/all/20240403002053.2376017-5-almasrymina@google.com/
>> - Removed net_devmem_restart_rx_queues and put it in its own patch
>>   (David).
>>
>> v8:
>> - move dmabuf_devmem_ops usage to later patch to avoid patch-by-patch
>>   build error.
>>
>> v7:
>> - Use IS_ERR() instead of IS_ERR_OR_NULL() for the dma_buf_get() return
>>   value.
>> - Changes netdev_* naming in devmem.c to net_devmem_* (Yunsheng).
>> - DMA_BIDIRECTIONAL -> DMA_FROM_DEVICE (Yunsheng).
>> - Added a comment around recovering of the old rx queue in
>>   net_devmem_restart_rx_queue(), and added freeing of old_mem if the
>>   restart of the old queue fails. (Yunsheng).
>> - Use kernel-family sock-priv (Jakub).
>> - Put pp_memory_provider_params in netdev_rx_queue instead of the
>>   dma-buf specific binding (Pavel & David).
>> - Move queue management ops to queue_mgmt_ops instead of netdev_ops
>>   (Jakub).
>> - Remove excess whitespaces (Jakub).
>> - Use genlmsg_iput (Jakub).
>>
>> v6:
>> - Validate rx queue index
>> - Refactor new functions into devmem.c (Pavel)
>>
>> v5:
>> - Renamed page_pool_iov to net_iov, and moved that support to devmem.h
>>   or netmem.h.
>>
>> v1:
>> - Introduce devmem.h instead of bloating netdevice.h (Jakub)
>> - ENOTSUPP -> EOPNOTSUPP (checkpatch.pl I think)
>> - Remove unneeded rcu protection for binding->list (rtnl protected)
>> - Removed extraneous err_binding_put: label.
>> - Removed dma_addr += len (Paolo).
>> - Don't override err on netdev_bind_dmabuf_to_queue failure.
>> - Rename devmem -> dmabuf (David).
>> - Add id to dmabuf binding (David/Stan).
>> - Fix missing xa_destroy bound_rq_list.
>> - Use queue api to reset bound RX queues (Jakub).
>> - Update netlink API for rx-queue type (tx/re) (Jakub).
>>
>> RFC v3:
>> - Support multi rx-queue binding
>>
>> ---
>>  Documentation/netlink/specs/netdev.yaml |   4 +
>>  include/net/devmem.h                    | 111 +++++++++++
>>  include/net/netdev_rx_queue.h           |   2 +
>>  include/net/netmem.h                    |  10 +
>>  include/net/page_pool/types.h           |   5 +
>>  net/core/Makefile                       |   2 +-
>>  net/core/dev.c                          |   3 +
>>  net/core/devmem.c                       | 254 ++++++++++++++++++++++++
>>  net/core/netdev-genl-gen.c              |   4 +
>>  net/core/netdev-genl-gen.h              |   4 +
>>  net/core/netdev-genl.c                  | 105 +++++++++-
>>  11 files changed, 501 insertions(+), 3 deletions(-)
>>  create mode 100644 include/net/devmem.h
>>  create mode 100644 net/core/devmem.c
>>
> [snip]
>> +/* Protected by rtnl_lock() */
>> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
>> +
>> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>> +{
>> +	struct netdev_rx_queue *rxq;
>> +	unsigned long xa_idx;
>> +	unsigned int rxq_idx;
>> +
>> +	if (!binding)
>> +		return;
>> +
>> +	if (binding->list.next)
>> +		list_del(&binding->list);
>> +
> 
> minor nit:
> In theory list.next can still be != null if it's poisoned (e.g. after del). You can
> use the list api here (!list_empty(&binding->list) -> list_del_init(&binding->list))
> if you initialize it in net_devmem_bind_dmabuf(), then you'll also get nice list
> debugging.
> 

On second thought nevermind this, sorry for the noise.

>> +	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
>> +		if (rxq->mp_params.mp_priv == binding) {
>> +			/* We hold the rtnl_lock while binding/unbinding
>> +			 * dma-buf, so we can't race with another thread that
>> +			 * is also modifying this value. However, the page_pool
>> +			 * may read this config while it's creating its
>> +			 * rx-queues. WRITE_ONCE() here to match the
>> +			 * READ_ONCE() in the page_pool.
>> +			 */
>> +			WRITE_ONCE(rxq->mp_params.mp_ops, NULL);
>> +			WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
>> +
>> +			rxq_idx = get_netdev_rx_queue_index(rxq);
>> +
>> +			netdev_rx_queue_restart(binding->dev, rxq_idx);
>> +		}
>> +	}
>> +
>> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>> +
>> +	net_devmem_dmabuf_binding_put(binding);
>> +}
> [snip]
> 
> Cheers,
>  Nik
> 


