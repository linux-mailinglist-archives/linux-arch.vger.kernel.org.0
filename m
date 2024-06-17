Return-Path: <linux-arch+bounces-4942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445590AF9E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 15:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7690829423C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C591B5817;
	Mon, 17 Jun 2024 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXgMU4Xp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54763198E98;
	Mon, 17 Jun 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630568; cv=none; b=lSuGGUdOWzBaslCD7gt3bFMFUWs2hE/zlv60i7Nrvw+SJCVW1+K4knuYDs5y0rSl3kFbTMw6BNZynCkIKLxHxPnQovpfOa9UrZswlPJaeirl0yhgj5XSFkcEp3zxN6DIOc6nQj8P59wQrG67hy2Uq5URbLWrfqPNy9dPCKJS7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630568; c=relaxed/simple;
	bh=PdMIx7ts4oz1uQk5eiNfGe66l/dzc3Wnxf+2+lDmu1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTjzl9/UtvXU/oUGYO7zO8qHbM/k1g+N4VgcMkKUjOya1zNSxouc5y8oULO31W47IziNFCEYQO/MuB/whgJ7tLLqlqop28xWRMPWfurRM3E1zNoEdQXprmZe4JggsPCJ+WABgA15t2safeoex1KeEvAQ4Na++cSIsZazs0k98eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXgMU4Xp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so73877366b.0;
        Mon, 17 Jun 2024 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718630564; x=1719235364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwj3Fw5B61alhB5+Nki7VXPagt0jdp377yGvLMhtmxI=;
        b=gXgMU4XpUMCQCIqHF9UK2HX1ZanWkgCER2aLmo6Dt1/EWYxFau/yN5wzHW5zHodjGl
         gsTxSl07zBxU/nxM8PqPdU1MK0ekJfdS06AH6VfokE95B/2i+bn0JrVFSXAAlodHC8xg
         zUPNKIMGeidE4wqy/BUGVdQW2s2/eo2Dvp4ZtlBmQSZwH/wy1rQuSuJIS6p3asM7Z8ui
         H35+m00AJyzuReGWpI2PyhnHroMg0GkKpw7XC9HeFjGS9xmNf8XBSfyElaGD9F6WHJ42
         6e0Jpp8KAKKYreA6TD3qz0igI5AkJTTUe3JMy1aANYiUMYFzrZWZTKxojQBZmhuJjknb
         EP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630564; x=1719235364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwj3Fw5B61alhB5+Nki7VXPagt0jdp377yGvLMhtmxI=;
        b=YrIayEOk8gNqF+4L/3lb2BGRDnv+yexjNihn1Vtjrp0YKfRGKpAeY51/Y+N+IgAY7C
         msYGt5mJoInflOdr8c7McSfHkKOURLUkD+MZuIYJY9czlIxZwfIBQishxiLRNnHVfUnw
         KWOvyUHTIGAWCFe+wCjuBW9bA/7/RXai/IlcS9amF9KrutIAqzx3li+TilMEmzHeDdSc
         akkinTdkbdKF6bFpzrvmhD5aeKHRO4HhkavzHyFR0xxXyy5sxRn5BZAdxjBsKAizJUIT
         DbPUhXu5fqGf+FFSwXImdYzz66weBI9W2J4U+RDSWZSYHZm6kQFJVdK2eIpOcVI5vv4/
         1YnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlLSlUeL1S+Z4sW93KjDIHoVg3T8YV8/iwW0XuBoLw4G0SS8gMNFIXUt9yJ48PfWOJ9aVkirv/mkqr2/wHXKCrkoWCPu/rDvfyR+OFU1gSz0CAgiMk8xbTsLusAw64koUk4/gh8Y/Tv4FjKbEH1Z4+qyJGEpopqWjJj6ncfe1OXP1G5NUzewzOL7YFDIHul/gG6kR5dWDxxjR3O23TqPJ8thhBETmxSmE+6RcHgTMUh++YT5YhMYV+H9SluoEy3h0WShi4rVAIx3L+PxH3OdwJpkDUMGcvMcQYhXLP4yF4uknAd9ubKz62KHMpNnDc3TTDvGgYRucgPISZNvhQAR2ZQdKH9W5/bGozd+JQiaDqMK7lUlHG7h6l/lJGXccfIPXL84lIba+0jCwdeEJg7AgUxAP17qofj/M3avCA3xkOFzqMT4amxKWV5zBnlIkRHJfLhYvqwL6D6sr9Xm1f9AKBQWu6qdPgYzChKw4a+pdiMFPBAsmBrVxs5i/k4pXs68byCeDz6l1haaXiHgb4DFT5a/04ZiV6NwVpBRVctNHYVaQOmgQyUwf5
X-Gm-Message-State: AOJu0YzHrTaU0H70gAqCadzr+frcm0M9HaieD6ELITSxIu2n7Rvl2Mg/
	xtClpJ9gmvpA5H37gP1fGJ7CAa8J3vJecPgZ32L94iZmEYkbVQu3
X-Google-Smtp-Source: AGHT+IEU7bSdU44tFLpRT61VrE4rRir5BezTbPl/p80FyKx5ycfOabVN7gLSnIoqzOZDAYrOc9lyjA==
X-Received: by 2002:a17:906:f851:b0:a6f:b5a:f5b9 with SMTP id a640c23a62f3a-a6f608b9addmr640674266b.32.1718630564415;
        Mon, 17 Jun 2024 06:22:44 -0700 (PDT)
Received: from [192.168.42.82] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6a1f2cb9sm383873066b.17.2024.06.17.06.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 06:22:44 -0700 (PDT)
Message-ID: <c45c5888-497b-4e95-a139-43a05279af65@gmail.com>
Date: Mon, 17 Jun 2024 14:22:45 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 03/13] netdev: support binding dma-buf to
 netdevice
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-4-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-4-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
> Add a netdev_dmabuf_binding struct which represents the
> dma-buf-to-netdevice binding. The netlink API will bind the dma-buf to
> rx queues on the netdevice. On the binding, the dma_buf_attach
> & dma_buf_map_attachment will occur. The entries in the sg_table from
> mapping will be inserted into a genpool to make it ready
> for allocation.
> 
> The chunks in the genpool are owned by a dmabuf_chunk_owner struct which
> holds the dma-buf offset of the base of the chunk and the dma_addr of
> the chunk. Both are needed to use allocations that come from this chunk.
> 
> We create a new type that represents an allocation from the genpool:
> net_iov. We setup the net_iov allocation size in the
> genpool to PAGE_SIZE for simplicity: to match the PAGE_SIZE normally
> allocated by the page pool and given to the drivers.
> 
> The user can unbind the dmabuf from the netdevice by closing the netlink
> socket that established the binding. We do this so that the binding is
> automatically unbound even if the userspace process crashes.
> 
> The binding and unbinding leaves an indicator in struct netdev_rx_queue
> that the given queue is bound, but the binding doesn't take effect until
> the driver actually reconfigures its queues, and re-initializes its page
> pool.
> 
> The netdev_dmabuf_binding struct is refcounted, and releases its
> resources only when all the refs are released.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Apart from the comment below

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com> # excluding netlink


> diff --git a/include/net/devmem.h b/include/net/devmem.h
> new file mode 100644
> index 0000000000000..eaf3fd965d7a8
...
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c361a7b69da86..84c9f96a6c9bf 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -158,6 +158,9 @@
>   #include <net/page_pool/types.h>
>   #include <net/page_pool/helpers.h>
>   #include <net/rps.h>
> +#include <linux/genalloc.h>
> +#include <linux/dma-buf.h>
> +#include <net/devmem.h>
>   
>   #include "dev.h"
>   #include "net-sysfs.h"
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> new file mode 100644
> index 0000000000000..951a06004c430
> --- /dev/null
> +++ b/net/core/devmem.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *      Devmem TCP
> + *
> + *      Authors:	Mina Almasry <almasrymina@google.com>
> + *			Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> + *			Kaiyuan Zhang <kaiyuanz@google.com
> + */
> +
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/netdevice.h>
> +#include <trace/events/page_pool.h>
> +#include <net/netdev_rx_queue.h>
> +#include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>
> +#include <linux/genalloc.h>
> +#include <linux/dma-buf.h>
> +#include <net/devmem.h>
> +#include <net/netdev_queues.h>
> +
> +/* Device memory support */
> +
> +#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATOR)
> +static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
> +					       struct gen_pool_chunk *chunk,
> +					       void *not_used)
> +{
> +	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
> +
> +	kvfree(owner->niovs);
> +	kfree(owner);
> +}
> +
> +void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
> +{
> +	size_t size, avail;
> +
> +	gen_pool_for_each_chunk(binding->chunk_pool,
> +				net_devmem_dmabuf_free_chunk_owner, NULL);
> +
> +	size = gen_pool_size(binding->chunk_pool);
> +	avail = gen_pool_avail(binding->chunk_pool);
> +
> +	if (!WARN(size != avail, "can't destroy genpool. size=%zu, avail=%zu",
> +		  size, avail))
> +		gen_pool_destroy(binding->chunk_pool);
> +
> +	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> +				 DMA_FROM_DEVICE);

It's unmapped here as DMA_FROM_DEVICE, a fail path does DMA_BIDIRECTIONAL,
dma_buf_map_attachment() passes BIDIRECTIONAL.


> +	dma_buf_detach(binding->dmabuf, binding->attachment);
> +	dma_buf_put(binding->dmabuf);
> +	xa_destroy(&binding->bound_rxq_list);
> +	kfree(binding);
> +}
> +
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
...

-- 
Pavel Begunkov

