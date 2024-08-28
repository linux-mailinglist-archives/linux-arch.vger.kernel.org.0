Return-Path: <linux-arch+bounces-6682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AAD961BCC
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 04:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD7F1F216E8
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F844C86;
	Wed, 28 Aug 2024 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWLjs7/Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CC1B960;
	Wed, 28 Aug 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810890; cv=none; b=mC1JwX5t0/RBo5I3+qaIJ2QOkqf/iZG4v77SkRUHwazsKYPd2DFqrzSMKVMF77LJ5ao/KpgN+ATA6Y0qbAfwtPxhA1KZIzEF6VLOy219zPOeFrXlR3o+ETBr0ydp1zNBvJWSKtlrrwVKHi1RVqhLQA0MBwtvvbl+PQDn9snGepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810890; c=relaxed/simple;
	bh=pzUAQn72g2IjCrxzBepeE/qG72phh6RPMrG0ZGM/Z3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2QTCIemQhj+2uealJuHkyl57aDarnH2TAFZP1c1JE7ZTU8YPwikTvuX+V1pR4g6F/8HFiiT6VCIvLLsNwjvRbYNR4la1wqoYPd6MrNBX5nUSqRtYFRm3aADw3G8jlC3UvHvZsHSKqfIO3jtB0PJi7xFacfJaeAJXNQkX6ZimH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWLjs7/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE076C32782;
	Wed, 28 Aug 2024 02:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724810889;
	bh=pzUAQn72g2IjCrxzBepeE/qG72phh6RPMrG0ZGM/Z3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KWLjs7/Qgvmf2hi2p8A9apxAORROArPoVp+CC4l6de78ew1ocahCSwYtOVfub6hSw
	 vPEYrdncp744CrpU6P0eHg6umPCILBFhEfOek20yLDgxNYz7TmbS7lqWq+uahxCWJj
	 fr/CBLU3HGPf8eYZdcTzK3J9f9qs+KZW6Z0sgaOYwKyAQ2KuhpNZRJ/MqnDOP8hTVK
	 G5vo8CCxCGIux6ys/PLL8pJkN++SObA8lv8/4aVxr4949xzGkDMlOwh1I/CnyULmAo
	 X8mFp0iejp8u2BgRb+0Ree5w4fEztXMNrwrOZi6ZRxpL+qGbDF7rlC/AIniAyEzH2G
	 aSE1ThtR59BRA==
Date: Tue, 27 Aug 2024 19:08:05 -0700
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
 Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v22 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240827190805.7f82deb0@kernel.org>
In-Reply-To: <20240825041511.324452-4-almasrymina@google.com>
References: <20240825041511.324452-1-almasrymina@google.com>
	<20240825041511.324452-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 04:15:01 +0000 Mina Almasry wrote:
> +u32 dev_get_min_mp_channel_count(const struct net_device *dev)
> +{
> +	u32 i, max = 0;
> +
> +	ASSERT_RTNL();
> +
> +	for (i = 0; i < dev->real_num_rx_queues; i++)
> +		if (dev->_rx[i].mp_params.mp_priv)
> +			/* The channel count is the idx plus 1. */
> +			max = i + 1;

invert the loop so you're walking from highest indexes and you can

			return i + 1;
	return 0;

> +	return max;
> +}
> +
>  /**
>   * dev_index_reserve() - allocate an ifindex in a namespace
>   * @net: the applicable net namespace

> diff --git a/net/core/devmem.c b/net/core/devmem.c

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

Please sort include files alphabetically.

> +#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATOR)

Could you create a hidden Kconfig for this feature and use it to make
building this entire file conditional? Hidden Kconfig has no
description and no help, like config NET_DEVLINK, but it can have
dependencies.

> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	unsigned long xa_idx;
> +	unsigned int rxq_idx;
> +
> +	if (binding->list.next)
> +		list_del(&binding->list);
> +
> +	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
> +		if (rxq->mp_params.mp_priv == binding) {

WARN_ON(rxq->mp_params.mp_priv != binding) ?
We know we're bound to this queue, nobody should be able to replace 
the mp, right?

> +			rxq->mp_params.mp_priv = NULL;
> +
> +			rxq_idx = get_netdev_rx_queue_index(rxq);
> +
> +			WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
> +		}
> +	}
> +
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +
> +	net_devmem_dmabuf_binding_put(binding);
> +}
> +
> +int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +				    struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	u32 xa_idx;
> +	int err;
> +
> +	if (rxq_idx >= dev->real_num_rx_queues)
> +		return -ERANGE;
> +
> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> +	if (rxq->mp_params.mp_priv)
> +		return -EEXIST;
> +
> +#ifdef CONFIG_XDP_SOCKETS
> +	if (rxq->pool)
> +		return -EEXIST;

EBUSY plus extack "designated queue already in use by AF_XDP"

> +#endif
> +
> +	if (dev_xdp_prog_count(dev))
> +		return -EEXIST;

Also needs an extack, but since it's not queue-specific should 
it not live inside net_devmem_bind_dmabuf() ? Or do you anticipate
reuse of this function by non-dmabuf code?

> +void dev_dmabuf_uninstall(struct net_device *dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	struct netdev_rx_queue *rxq;
> +	unsigned long xa_idx;
> +	unsigned int i;
> +
> +	for (i = 0; i < dev->real_num_rx_queues; i++) {
> +		binding = dev->_rx[i].mp_params.mp_priv;
> +		if (!binding)
> +			continue;
> +
> +		xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
> +			if (rxq == &dev->_rx[i])
> +				xa_erase(&binding->bound_rxqs, xa_idx);

break;

I don't think we can store the same queue twice

> +	}
> +}
> +#endif

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 2d726e65211d..269faa37f84e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -10,6 +10,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/busy_poll.h>
> +#include <net/devmem.h>

include order

> +	return genlmsg_reply(rsp, info);

Should we goto err_unbind if genlmsg_reply() fails?
Shouldn't really happen unless socket is full but simple enough to fix.

