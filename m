Return-Path: <linux-arch+bounces-6972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2396A9EC
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C221B228FD
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB71EC017;
	Tue,  3 Sep 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLHdWKFK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4151EC005;
	Tue,  3 Sep 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398392; cv=none; b=IT5zv+fHxwNOMA7OG2wh0OI7JZT69GJGsGzh9zm435XMpIXLZSBOq4deXouSghosCRTKQM4mZZJ9+PWkBmx38OpvN1pXoczBq4gaSHNy5HIG2PS7D5lGqKZSTZ1S5eRrtFuWS+dc4Iz9bEXRMo0loQ+mZDAFDKmZXUcvxJ37kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398392; c=relaxed/simple;
	bh=3xUDvUxu+fBoSxRhosQcCb3KMN9DYF5vVl9RMgG5t/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8b377BfOl9+rXGLmEUE6jYK3V4Wg9buPkAfl3UjCH0O09LNlUN1WUauJywy+d2EDbMesKLDJJzycIf6Te0jex8n0dYrLsjo3UbSWg2gNZ77Faj2ociNmMtF46hy4r01fPkEgTXB8lrraD7kDQbG/F2xh28t4F2ZKEDg7LaSjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLHdWKFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E98C4CEC4;
	Tue,  3 Sep 2024 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725398392;
	bh=3xUDvUxu+fBoSxRhosQcCb3KMN9DYF5vVl9RMgG5t/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SLHdWKFKnN33srU90NZWM34zNUiyvQJlC9s0PCH4X0yJNg+V1GzZ8kErkloQvWmMk
	 Rt0nxKIjpzeFg+lQlR+EoJlYpiupKyhq08r1qj0X+VJ7OID+wMpQSebpgEKaOUG+EZ
	 02ahgJ4iTdQn5gBAl6IDoGCp50K9nOpTIX7SeMxKNOQHAL9XfJW6886BBt08oexX0c
	 dVjdSTw1+ElQNSjSj13jWDXlRXdrTvVENk1A3+SXNUO6xjbdvt6TywYipI1MWMicXt
	 uhvCBhX3kD79ci5RPR7NY9V4+t4qRZLD4wYCKzMhFLuADTklRMBcHeIGf6fa2f7rNk
	 +/Zkg1NOL6DPg==
Date: Tue, 3 Sep 2024 14:19:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, "=?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?B?bA==?=" <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v24 06/13] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240903141948.269e22bb@kernel.org>
In-Reply-To: <20240831004313.3713467-7-almasrymina@google.com>
References: <20240831004313.3713467-1-almasrymina@google.com>
	<20240831004313.3713467-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 00:43:06 +0000 Mina Almasry wrote:
> diff --git a/include/net/mp_dmabuf_devmem.h b/include/net/mp_dmabuf_devmem.h
> new file mode 100644
> index 000000000000..6d1cf2a77f6b
> --- /dev/null
> +++ b/include/net/mp_dmabuf_devmem.h

this header can live under net/core/ like netmem_priv.h right?
devmem internals should be of no interest outside of core networking.

In fact the same is true for include/net/devmem.h ?

Sorry for pushing back on all the header exports, we have had bad
experiences with people treating anything under include/ as public 
API for any subsystem to use..

> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Dmabuf device memory provider.
> + *
> + * Authors:	Mina Almasry <almasrymina@google.com>
> + *
> + */
> +#ifndef _NET_MP_DMABUF_DEVMEM_H
> +#define _NET_MP_DMABUF_DEVMEM_H
> +
> +#include <net/netmem.h>
> +
> +#if defined(CONFIG_NET_DEVMEM)
> +int mp_dmabuf_devmem_init(struct page_pool *pool);
> +
> +netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp);
> +
> +void mp_dmabuf_devmem_destroy(struct page_pool *pool);
> +
> +bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem);
> +#else
> +static inline int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool,
> +							gfp_t gfp)

Please break the lines after the return type if the line gets long:

static inline netmem_ref 
mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)

Please fix where you can (at least where it cases going over 80 chars)

> +{
> +	return 0;
> +}
> +
> +static inline void mp_dmabuf_devmem_destroy(struct page_pool *pool)
> +{
> +}
> +
> +static inline bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
> +						 netmem_ref netmem)
> +{
> +	return false;
> +}
> +#endif
> +
> +#endif /* _NET_MP_DMABUF_DEVMEM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index ac6c7945117b..61400d4b0d66 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -8,6 +8,7 @@
>  #ifndef _NET_NETMEM_H
>  #define _NET_NETMEM_H
>  
> +#include <linux/mm.h>
>  #include <net/devmem.h>
>  #include <net/net_debug.h>
>  
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 4afd6dd56351..1b4698710f25 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -20,8 +20,17 @@
>  					* device driver responsibility
>  					*/
>  #define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
> +#define PP_FLAG_ALLOW_UNREADABLE_NETMEM	BIT(3) /* Allow unreadable (net_iov
> +						* backed) netmem in this
> +						* page_pool. Drivers setting
> +						* this must be able to support
> +						* unreadable netmem, where
> +						* netmem_address() would return
> +						* NULL. This flag should not be
> +						* set for header page_pools.
> +						*/

Maybe move the comment before the define:

/* Allow unreadable (net_iov backed) netmem in this page_pool. Drivers
setting
 * this must be able to support unreadable netmem, where netmem_address() would 
 * return NULL. This flag should not be set for header page_pools.
 */
#define PP_FLAG_ALLOW_UNREADABLE_NETMEM	BIT(3)

? up to you.

>  #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
> -				 PP_FLAG_SYSTEM_POOL)
> +				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
>  
>  /*
>   * Fast allocation side cache array/stack
> @@ -57,7 +66,9 @@ struct pp_alloc_cache {
>   * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
>   * @slow:	params with slowpath access only (initialization and Netlink)
>   * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
> - * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL
> + * @queue:	struct netdev_rx_queue this page_pool is being created for.
> + * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
> + *		PP_FLAG_ALLOW_UNREADABLE_NETMEM.
>   */
>  struct page_pool_params {
>  	struct_group_tagged(page_pool_params_fast, fast,
> @@ -72,6 +83,7 @@ struct page_pool_params {
>  	);
>  	struct_group_tagged(page_pool_params_slow, slow,
>  		struct net_device *netdev;
> +		struct netdev_rx_queue *queue;

Why set a pointer? It should work but drivers don't usually deal with
netdev_rx_queue struct directly. struct xdp_rxq_info takes an integer
queue id, and it serves a somewhat similar function.

Keep in mind that there will be more drivers than core code, so
convenience for them matters more.

>  		unsigned int	flags;
>  /* private: used by test code only */
>  		void (*init_callback)(netmem_ref netmem, void *arg);
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 727e5ee39f30..c8c112360caa 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -13,6 +13,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/types.h>
>  #include <net/devmem.h>
> +#include <net/mp_dmabuf_devmem.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
> @@ -320,3 +321,68 @@ void dev_dmabuf_uninstall(struct net_device *dev)
>  			}
>  	}
>  }
> +
> +/*** "Dmabuf devmem memory provider" ***/
> +
> +int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> +
> +	if (!binding)
> +		return -EINVAL;
> +
> +	if (!pool->dma_map)
> +		return -EOPNOTSUPP;
> +
> +	if (pool->dma_sync)
> +		return -EOPNOTSUPP;
> +
> +	if (pool->p.order != 0)
> +		return -E2BIG;
> +
> +	net_devmem_dmabuf_binding_get(binding);
> +	return 0;
> +}
> +
> +netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
> +{
> +	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> +	netmem_ref netmem;
> +	struct net_iov *niov;

nit: reverse xmas tree

> +	niov = net_devmem_alloc_dmabuf(binding);
> +	if (!niov)
> +		return 0;
> +
> +	netmem = net_iov_to_netmem(niov);
> +
> +	page_pool_set_pp_info(pool, netmem);
> +
> +	pool->pages_state_hold_cnt++;
> +	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
> +	return netmem;
> +}
> +
> +void mp_dmabuf_devmem_destroy(struct page_pool *pool)
> +{
> +	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> +
> +	net_devmem_dmabuf_binding_put(binding);
> +}
> +
> +bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
> +{
> +	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> +		return false;
> +
> +	if (WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem)) !=
> +		     1))

something needs factoring out here, to make this line shorter, please..
either netmem -> net_iov conversion or at least reading of the ref
count?

> +		return false;
> +
> +	page_pool_clear_pp_info(netmem);
> +
> +	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
> +
> +	/* We don't want the page pool put_page()ing our net_iovs. */
> +	return false;
> +}
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index da11720a5983..e217a5838c87 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -4,8 +4,11 @@
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
>  
> +#include "page_pool_priv.h"
> +
>  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>  {
> +	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
>  	void *new_mem, *old_mem;
>  	int err;
>  
> @@ -31,6 +34,10 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>  	if (err)
>  		goto err_free_old_mem;
>  
> +	err = page_pool_check_memory_provider(dev, rxq);
> +	if (err)
> +		goto err_free_new_queue_mem;
> +
>  	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, old_mem, rxq_idx);
>  	if (err)
>  		goto err_free_new_queue_mem;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 52659db2d765..6e24950f2be4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -11,6 +11,8 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  
> +#include <net/mp_dmabuf_devmem.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/xdp.h>
>  
> @@ -190,6 +192,7 @@ static int page_pool_init(struct page_pool *pool,
>  			  int cpuid)
>  {
>  	unsigned int ring_qsize = 1024; /* Default */
> +	int err;
>  
>  	page_pool_struct_check();
>  
> @@ -271,7 +274,36 @@ static int page_pool_init(struct page_pool *pool,
>  	if (pool->dma_map)
>  		get_device(pool->p.dev);
>  
> +	if (pool->slow.queue &&
> +	    pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
> +		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
> +		 * configuration doesn't change while we're initializing the

nit: 'the' to next line

> +		 * page_pool.
> +		 */
> +		ASSERT_RTNL();
> +		pool->mp_priv = pool->slow.queue->mp_params.mp_priv;
> +	}

