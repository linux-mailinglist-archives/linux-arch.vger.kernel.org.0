Return-Path: <linux-arch+bounces-6193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE7951CB9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7FB1C210AD
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8A1B3730;
	Wed, 14 Aug 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+i3Jtcu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EB1B29C3;
	Wed, 14 Aug 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644711; cv=none; b=qObsNo0u5cswj9biRf+QBEgvk1Y6DNHNFKLC65kuUgOjcez4VRoJ8Ghtc5k4SmnJF53WQGPxXjEoXHKjq2laTfLjsQK85Szh9yhaPK4y2QzKiC+Edpa6n3katPU4HZbDBq/i9rdE+/JB9FF6Jsk/jVPqMqbgZjxYnjxy8Ebgu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644711; c=relaxed/simple;
	bh=ufkTbXrNRde7ku9ILWA6f0z/jzzMRkyg14KCdQcjT34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjuclYS0UqIp6lWBJoIShHb4i4dLMz7mxs4p5ANOUlEfEQ976UuY2lm3zKiQ4XkCkXDOv1WfbOvjV97WLYNN/D80K5zq/02I8WAoKu9p3dNIM2GH1Cke/8XqLWyeEsm8VH/W2qrE7xlzCX1cs4joTG2/nMDUYBmDl5L9doVi0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+i3Jtcu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa086b077so620306866b.0;
        Wed, 14 Aug 2024 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723644708; x=1724249508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4lEcDVn0ScVYDJNBB09gtNeZOhx/qNGY5FB/NSTnIE=;
        b=k+i3JtcuFWAPkBWE1dNXlsP4TKNuCj/fmzT6jQB47dBcYHmlLHSTyNt1gB3pXDTa27
         3VpaRWAAGYb5CzNKer+/MJJk8D+VvskdzE+0ck4Yn7OfCT/ZS+Z0owISf5DSmqMalIlA
         RGb+6a10QkLr0oWnuxrcB5MOW/SJnkTVqgOEdQz4W+zKuiT4HJPrhCKXFKpZcFRRXO4F
         Q+1dlLm5vi39+LyiOPEiYLsOi8Te1POlX510ncbOoetM4Z5ZD1dB9cdNFDxBXC0PR3uu
         esA5EjkUcH/j5ZXeN4h2EpyMMIFWSHkVYjVbXX0Aqoy10Fzc++pKsixVzr4cPWSFRttL
         JmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644708; x=1724249508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4lEcDVn0ScVYDJNBB09gtNeZOhx/qNGY5FB/NSTnIE=;
        b=EqQJfVzgjeHa4jj0W7W7K92Qqa8m5aID4omIDRdTeT0inlY8eFPfNHLTaGsSDXuUwM
         LDbj2SNTuWV/Zgr1A1i+kC8u03F4vv5H9kw2uQxuT5PJS1S4Kpm15wMi45g0xWJfW+1M
         jiFPgcLl9/aYzH7OweRdW4F9Tv1WcYoDKjPtqjTz4mUV6SeA/EjDYP3qLX24xQTEVkur
         VwCFMNooWPKXyjsumYxRUusI5H0yOF4GECXkSQUCxTdOpsupYVcutZUBZjgZjNqPyZH+
         KdxaJWxcedmdKXSYHG0ODORkkWRzVsHF8hPQOHNuTE7b70U6ZVvsqJELEpwqULINKZOc
         5C4w==
X-Forwarded-Encrypted: i=1; AJvYcCVuHGXOb69ekfbkyMt4BMITQ6M2wblrIhzK6UNqBPsQpy1/JlEO1edvV+bt+MqzMx1zvdn1cmEHHnc/u+8Y/V+TwBS7xKvjNSQpeePRyW5BkpTOLsizmCA3l92xAOOt3Kktepejvfou49nsGRt+NsK5k4E3IPvsMsp5AEeDmexGTRlLH/2179xI2y6bg0H4SBZMjWxB4wba1NJ3seU4nZhCv9JFWhLt+W3YbpM0CeL+bkIeYJh+4vkC6EpCJvrdTfo66Cg3Ay659mm2o99UeOABG1mL/wJgC1T4wSxWyOjRRz82SCUjkTgeplCQJasO7G9hZPtFyULhguJM7FEKfiASuFqa7ANxrUtjF88KYAJBt6aFgBCy2/EITCPDS012RWL4qsIrVHHzD99isaR3eASVR3TAona0uTum6zUgXNf2R9ojqeXd/nX47QWYiIAT61YX1Kn0lF1lTQpFUOHxMafmGpWWWtM4v4zfMWFakDwYyGhZOOh6j9TilQ7cOz4Nn5mWuSTEcw==
X-Gm-Message-State: AOJu0YzWKJCPa8GYS6XQv8CMqLbGbS96nzkdj8HEsN83lGySVl4rdnU+
	5eJLmpQk/84ucO46NzoHWiFoSoXd7XN04wAikDYb6QinAAruP8l3
X-Google-Smtp-Source: AGHT+IG9Udegnx6quFDnRlNaUIR9wp347Gf23kUw37RLzMtyl8o18emPPEx2i7tEi7aMsgFUqg2ZVw==
X-Received: by 2002:a17:907:e6a9:b0:a7a:a5ae:11b7 with SMTP id a640c23a62f3a-a83670893e1mr182918366b.49.1723644707787;
        Wed, 14 Aug 2024 07:11:47 -0700 (PDT)
Received: from [192.168.42.53] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f4592esm177630266b.26.2024.08.14.07.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:11:47 -0700 (PDT)
Message-ID: <de7daf80-a2e4-4451-b666-2a67ccc3649e@gmail.com>
Date: Wed, 14 Aug 2024 15:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 06/13] memory-provider: dmabuf devmem memory
 provider
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
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
 Arnd Bergmann <arnd@arndb.de>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240813211317.3381180-7-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240813211317.3381180-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 22:13, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem in the form of
> net_iov.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the net_iov.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
> the page_pool can provide the driver with the dma-addrs of the devmem.
> 
> Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity & p.order !=
> 0.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> ---
> 
> v19:
> - Add PP_FLAG_ALLOW_UNREADABLE_NETMEM flag. It serves 2 purposes, (a)
>    it guards drivers that don't support unreadable netmem (net_iov
>    backed) from accidentally getting exposed to it, and (b) drivers that
>    wish to create header pools can unset it for that pool to force
>    readable netmem.
> - Add page_pool_check_memory_provider, which verifies that the driver
>    has created a page_pool with the expected configuration. This is used
>    to report to the user if the mp configuration succeeded, and also
>    verify that the driver is doing the right thing.
> - Don't reset niov->dma_addr on allocation/free.
> 
> v17:
> - Use ASSERT_RTNL (Jakub)
> 
> v16:
> - Add DEBUG_NET_WARN_ON_ONCE(!rtnl_is_locked()), to catch cases if
>    page_pool_init without rtnl_locking when the queue is provided. In
>    this case, the queue configuration may be changed while we're initing
>    the page_pool, which could be a race.
> 
> v13:
> - Return on warning (Pavel).
> - Fixed pool->recycle_stats not being freed on error (Pavel).
> - Applied reviewed-by from Pavel.
> 
> v11:
> - Rebase to not use the ops. (Christoph)
> 
> v8:
> - Use skb_frag_size instead of frag->bv_len to fix patch-by-patch build
>    error
> 
> v6:
> - refactor new memory provider functions into net/core/devmem.c (Pavel)
> 
> v2:
> - Disable devmem for p.order != 0
> 
> v1:
> - static_branch check in page_is_page_pool_iov() (Willem & Paolo).
> - PP_DEVMEM -> PP_IOV (David).
> - Require PP_FLAG_DMA_MAP (Jakub).
> 
...
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 301f4250ca82..2f2a7f4dee4c 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -17,6 +17,7 @@
>   #include <linux/genalloc.h>
>   #include <linux/dma-buf.h>
>   #include <net/devmem.h>
> +#include <net/mp_dmabuf_devmem.h>
>   #include <net/netdev_queues.h>
>   
>   #include "page_pool_priv.h"
> @@ -153,6 +154,10 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>   	if (err)
>   		goto err_xa_erase;
>   
> +	err = page_pool_check_memory_provider(dev, rxq, binding);

Frankly, I pretty much don't like it.

1. We do it after reconfiguring the queue just to fail and reconfigure
it again.

2. It should be a part of the common path like netdev_rx_queue_restart(),
not specific to devmem TCP.

These two can be fixed by moving the check into
netdev_rx_queue_restart() just after ->ndo_queue_mem_alloc, assuming
that the callback where we init page pools.

3. That implicit check gives me bad feeling, instead of just getting
direct feedback from the driver, either it's a flag or an error
returned, we have to try to figure what exactly the driver did, with
a high chance this inference will fail us at some point.

And page_pool_check_memory_provider() is not that straightforward,
it doesn't walk through pools of a queue. Not looking too deep,
but it seems like the nested loop can be moved out with the same
effect, so it first looks for a pool in the device and the follows
with the bound_rxqs. And seems the bound_rxqs check would always turn
true, you set the binding into the map in
net_devmem_bind_dmabuf_to_queue() before the restart and it'll be there
after restart for page_pool_check_memory_provider(). Maybe I missed
something, but it's not super clear.

4. And the last thing Jakub mentioned is that we need to be prepared
to expose a flag to the userspace for whether a queue supports
netiov. Not really doable in a sane manner with such implicit
post configuration checks.

And that brings us back to the first approach I mentioned, where
we have a flag in the queue structure, drivers set it, and
netdev_rx_queue_restart() checks it before any callback. That's
where the thread with Jakub stopped, and it reads like at least
he's not against the idea.


> +	if (err)
> +		goto err_xa_erase;
> +
>   	return 0;
>   
>   err_xa_erase:
> @@ -305,4 +310,69 @@ void dev_dmabuf_uninstall(struct net_device *dev)
>   				xa_erase(&binding->bound_rxqs, xa_idx);
>   	}
>   }
> +
...
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 3a3277ba167b..cbc54ee4f670 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -344,6 +344,32 @@ void page_pool_unlist(struct page_pool *pool)
>   	mutex_unlock(&page_pools_lock);
>   }
>   
> +int page_pool_check_memory_provider(struct net_device *dev,
> +				    struct netdev_rx_queue *rxq,
> +				    struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *binding_rxq;
> +	struct page_pool *pool;
> +	struct hlist_node *n;
> +	unsigned long xa_idx;
> +
> +	mutex_lock(&page_pools_lock);
> +	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
> +		if (pool->mp_priv != binding)
> +			continue;
> +
> +		xa_for_each(&binding->bound_rxqs, xa_idx, binding_rxq) {
> +			if (rxq != binding_rxq)
> +				continue;
> +
> +			mutex_unlock(&page_pools_lock);
> +			return 0;
> +		}
> +	}
> +	mutex_unlock(&page_pools_lock);
> +	return -ENODATA;
> +}
> +
>   static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
>   {
>   	struct page_pool *pool;

-- 
Pavel Begunkov

