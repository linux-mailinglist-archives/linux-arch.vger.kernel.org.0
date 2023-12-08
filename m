Return-Path: <linux-arch+bounces-835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3A80AFF7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 23:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E411C20AF1
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 22:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EB59B7E;
	Fri,  8 Dec 2023 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyEEsyaO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D410D2;
	Fri,  8 Dec 2023 14:56:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3333fbbeab9so2436427f8f.2;
        Fri, 08 Dec 2023 14:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702076180; x=1702680980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lb6bW5/0tabUFZtl8Q33e8tjxN2YuHNYvOt9IYVdZ58=;
        b=VyEEsyaOsdK3V5TsMSY8116TErO/nhbRQoPhTjLkn7QcU2yMHIDR0Vuiflo03oxlb7
         d7+4FHgEZJrxELOlgQPMIGS6dti6lRCG1+po93ZrQQerJpwk5+cyK5CTJnfrdyTVFqKh
         dlX7BRD8Judy6o9UBLw97uQ1WXGF3qOoCBB57FUMLOqun+oOVI/IY1udyKAZXwiOylRe
         Uk8vH90YhRNLwSfGR6fzzUsDO2DzLzmr37AXOesspcw9FuhFgDNl+Vam/JV1JkQVCBht
         JGsWErbI3U7TCduBKTUeJMVxEcLshIMWxpVJWH1gJ2WeH1TorkM5UGyvtAqx8xUWzFr9
         QX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076180; x=1702680980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb6bW5/0tabUFZtl8Q33e8tjxN2YuHNYvOt9IYVdZ58=;
        b=loB02cijMsUJaptJU/9pF2KshE9vdhVIcUZYlFuOfBrt4mfD0szmrJmD+khoRaHyPt
         LrBt8IrTXrhZ6rD+mB+jo5DB1Kw8+q4r45ew2iJDXq9m0NQeXn9SQJq79lhi8odkw97V
         fyyHLkvNScYtD1nlMJjJJq91cqahY6j4VyUfeRZMGI779kA5M+jo4YtyvPrWKnQdRdKV
         RS1o+kVZvIk256RwWpoQGm68U+jrMh7wBdCLfL2EqC8jGqiFXE1dr384WJgp7cy28WFw
         BAbAbCk+jd7eK5ocr3k5rvwiKqcK2chMGv8/GQ86LaAOPjY/eWSbO7es/RZbW45xX3Wg
         E5iA==
X-Gm-Message-State: AOJu0YzPtAI7WfPa2rR2v1nCigiDsSLofqg71JZ9YjVKuOax6/Q38Tr/
	BykcLrNVcd8mjFdg4FPubEE=
X-Google-Smtp-Source: AGHT+IFAmrtgnNNek+1m8q51NDmIrFuDjToi+3B5bJWseuGhKrVhDjl0ENoSpKj3SUNwgp1Op3PP5Q==
X-Received: by 2002:a5d:5255:0:b0:333:2fd2:68bb with SMTP id k21-20020a5d5255000000b003332fd268bbmr490933wrc.78.1702076179579;
        Fri, 08 Dec 2023 14:56:19 -0800 (PST)
Received: from [192.168.8.100] ([85.255.236.117])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0033326e90496sm2902430wrt.18.2023.12.08.14.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 14:56:19 -0800 (PST)
Message-ID: <b07a4eca-0c3d-4620-9f97-b1d2c76642c2@gmail.com>
Date: Fri, 8 Dec 2023 22:48:39 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory
 provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20231208005250.2910004-9-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 00:52, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem page_pool_iovs.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the page_pool_params.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
> the page_pool can provide the driver with the dma-addrs of the devmem.
> 
> Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v1:
> - static_branch check in page_is_page_pool_iov() (Willem & Paolo).
> - PP_DEVMEM -> PP_IOV (David).
> - Require PP_FLAG_DMA_MAP (Jakub).
> 
> ---
>   include/net/page_pool/helpers.h | 47 +++++++++++++++++
>   include/net/page_pool/types.h   |  9 ++++
>   net/core/page_pool.c            | 89 ++++++++++++++++++++++++++++++++-
>   3 files changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 8bfc2d43efd4..00197f14aa87 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -53,6 +53,8 @@
>   #define _NET_PAGE_POOL_HELPERS_H
>   
>   #include <net/page_pool/types.h>
> +#include <net/net_debug.h>
> +#include <net/devmem.h>
>   
>   #ifdef CONFIG_PAGE_POOL_STATS
>   /* Deprecated driver-facing API, use netlink instead */
> @@ -92,6 +94,11 @@ static inline unsigned int page_pool_iov_idx(const struct page_pool_iov *ppiov)
>   	return ppiov - page_pool_iov_owner(ppiov)->ppiovs;
>   }
>   
> +static inline u32 page_pool_iov_binding_id(const struct page_pool_iov *ppiov)
> +{
> +	return page_pool_iov_owner(ppiov)->binding->id;
> +}
> +
>   static inline dma_addr_t
>   page_pool_iov_dma_addr(const struct page_pool_iov *ppiov)
>   {
> @@ -107,6 +114,46 @@ page_pool_iov_binding(const struct page_pool_iov *ppiov)
>   	return page_pool_iov_owner(ppiov)->binding;
>   }
>   
> +static inline int page_pool_iov_refcount(const struct page_pool_iov *ppiov)
> +{
> +	return refcount_read(&ppiov->refcount);
> +}
> +
> +static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	refcount_add(count, &ppiov->refcount);
> +}
> +
> +void __page_pool_iov_free(struct page_pool_iov *ppiov);
> +
> +static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	if (!refcount_sub_and_test(count, &ppiov->refcount))
> +		return;
> +
> +	__page_pool_iov_free(ppiov);
> +}
> +
> +/* page pool mm helpers */
> +
> +DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +static inline bool page_is_page_pool_iov(const struct page *page)
> +{
> +	return static_branch_unlikely(&page_pool_mem_providers) &&
> +	       (unsigned long)page & PP_IOV;
> +}
> +
> +static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return (struct page_pool_iov *)((unsigned long)page & ~PP_IOV);
> +
> +	DEBUG_NET_WARN_ON_ONCE(true);
> +	return NULL;
> +}
> +
>   /**
>    * page_pool_dev_alloc_pages() - allocate a page.
>    * @pool:	pool from which to allocate
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 44faee7a7b02..136930a238de 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -134,8 +134,15 @@ struct memory_provider_ops {
>   	bool (*release_page)(struct page_pool *pool, struct page *page);
>   };
>   
> +extern const struct memory_provider_ops dmabuf_devmem_ops;
> +
>   /* page_pool_iov support */
>   
> +/*  We overload the LSB of the struct page pointer to indicate whether it's
> + *  a page or page_pool_iov.
> + */
> +#define PP_IOV 0x01UL
> +
>   /* Owner of the dma-buf chunks inserted into the gen pool. Each scatterlist
>    * entry from the dmabuf is inserted into the genpool as a chunk, and needs
>    * this owner struct to keep track of some metadata necessary to create
> @@ -159,6 +166,8 @@ struct page_pool_iov {
>   	struct dmabuf_genpool_chunk_owner *owner;
>   
>   	refcount_t refcount;
> +
> +	struct page_pool *pp;
>   };
>   
>   struct page_pool {
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f5c84d2a4510..423c88564a00 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -12,6 +12,7 @@
>   
>   #include <net/page_pool/helpers.h>
>   #include <net/xdp.h>
> +#include <net/netdev_rx_queue.h>
>   
>   #include <linux/dma-direction.h>
>   #include <linux/dma-mapping.h>
> @@ -20,12 +21,15 @@
>   #include <linux/poison.h>
>   #include <linux/ethtool.h>
>   #include <linux/netdevice.h>
> +#include <linux/genalloc.h>
> +#include <net/devmem.h>
>   
>   #include <trace/events/page_pool.h>
>   
>   #include "page_pool_priv.h"
>   
> -static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +EXPORT_SYMBOL(page_pool_mem_providers);
>   
>   #define DEFER_TIME (msecs_to_jiffies(1000))
>   #define DEFER_WARN_INTERVAL (60 * HZ)
> @@ -175,6 +179,7 @@ static void page_pool_producer_unlock(struct page_pool *pool,
>   static int page_pool_init(struct page_pool *pool,
>   			  const struct page_pool_params *params)
>   {
> +	struct netdev_dmabuf_binding *binding = NULL;
>   	unsigned int ring_qsize = 1024; /* Default */
>   	int err;
>   
> @@ -237,6 +242,14 @@ static int page_pool_init(struct page_pool *pool,
>   	/* Driver calling page_pool_create() also call page_pool_destroy() */
>   	refcount_set(&pool->user_cnt, 1);
>   
> +	if (pool->p.queue)
> +		binding = READ_ONCE(pool->p.queue->binding);
> +
> +	if (binding) {
> +		pool->mp_ops = &dmabuf_devmem_ops;
> +		pool->mp_priv = binding;
> +	}

Hmm, I don't understand why would we replace a nice transparent
api with page pool relying on a queue having devmem specific
pointer? It seemed more flexible and cleaner in the last RFC.

> +
>   	if (pool->mp_ops) {
>   		err = pool->mp_ops->init(pool);
>   		if (err) {
> @@ -1020,3 +1033,77 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>   	}
>   }
>   EXPORT_SYMBOL(page_pool_update_nid);
> +
> +void __page_pool_iov_free(struct page_pool_iov *ppiov)
> +{
> +	if (WARN_ON(ppiov->pp->mp_ops != &dmabuf_devmem_ops))
> +		return;
> +
> +	netdev_free_dmabuf(ppiov);
> +}
> +EXPORT_SYMBOL_GPL(__page_pool_iov_free);

I didn't look too deep but I don't think I immediately follow
the pp refcounting. It increments pages_state_hold_cnt on
allocation, but IIUC doesn't mark skbs for recycle? Then, they all
will be put down via page_pool_iov_put_many() bypassing
page_pool_return_page() and friends. That will call
netdev_free_dmabuf(), which doesn't bump pages_state_release_cnt.

At least I couldn't make it work with io_uring, and for my purposes,
I forced all puts to go through page_pool_return_page(), which calls
the ->release_page callback. The callback will put the reference and
ask its page pool to account release_cnt. It also gets rid of
__page_pool_iov_free(), as we'd need to add a hook there for
customization otherwise.

I didn't care about overhead because the hot path for me is getting
buffers from a ring, which is somewhat analogous to sock_devmem_dontneed(),
but done on pp allocations under napi, and it's done separately.

Completely untested with TCP devmem:

https://github.com/isilence/linux/commit/14bd56605183dc80b540999e8058c79ac92ae2d8

> +
> +/*** "Dmabuf devmem memory provider" ***/
> +
> +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +
> +	if (!binding)
> +		return -EINVAL;
> +
> +	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
> +		return -EOPNOTSUPP;
> +
> +	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> +		return -EOPNOTSUPP;
> +
> +	netdev_dmabuf_binding_get(binding);
> +	return 0;
> +}
> +
> +static struct page *mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
> +						 gfp_t gfp)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +	struct page_pool_iov *ppiov;
> +
> +	ppiov = netdev_alloc_dmabuf(binding);
> +	if (!ppiov)
> +		return NULL;
> +
> +	ppiov->pp = pool;
> +	pool->pages_state_hold_cnt++;
> +	trace_page_pool_state_hold(pool, (struct page *)ppiov,
> +				   pool->pages_state_hold_cnt);
> +	return (struct page *)((unsigned long)ppiov | PP_IOV);
> +}
> +
> +static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +
> +	netdev_dmabuf_binding_put(binding);
> +}
> +
> +static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
> +					  struct page *page)
> +{
> +	struct page_pool_iov *ppiov;
> +
> +	if (WARN_ON_ONCE(!page_is_page_pool_iov(page)))
> +		return false;
> +
> +	ppiov = page_to_page_pool_iov(page);
> +	page_pool_iov_put_many(ppiov, 1);
> +	/* We don't want the page pool put_page()ing our page_pool_iovs. */
> +	return false;
> +}
> +
> +const struct memory_provider_ops dmabuf_devmem_ops = {
> +	.init			= mp_dmabuf_devmem_init,
> +	.destroy		= mp_dmabuf_devmem_destroy,
> +	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
> +	.release_page		= mp_dmabuf_devmem_release_page,
> +};
> +EXPORT_SYMBOL(dmabuf_devmem_ops);

-- 
Pavel Begunkov

