Return-Path: <linux-arch+bounces-2810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF48871FAA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058712837E7
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1F85944;
	Tue,  5 Mar 2024 12:55:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78635C61F;
	Tue,  5 Mar 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643315; cv=none; b=TxqkuYNCzJsPgeSCyd9jfu25GYwOaUIonu9/DKiyBNrVb7LjVkYf0K6EEmEYcpnsSFenu2MqgSBbcooo2dUOgp4OLONw++hRlpUog8HLd1e9s0CIE5apB2OFgjQCw1K0xiWfCe/+UVGv824ODdZzcz6DkbWRuCKELQtIUHm6Pbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643315; c=relaxed/simple;
	bh=oiVodYfXO6uYQW4w1Uil613ULlWtjgHVgcKoJPtT3uo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UO2QEz/0nM28inXLi66/Az7u58uwev6kfcmMoAARhnoecbztcqpWJnoe8hUDaf8NQJ6pgQleaPfbasddtVGKxDlLc15ODlHm/K1J1TT3aDq6h3Wza/md/HF1fErtbt2Bkl6IGzPN0SA6Kf6fiIdD+kQ+1J9yUhFdL3NUPo8wt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TpwTG1JyWz1Q9lF;
	Tue,  5 Mar 2024 20:52:50 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CFEDC1402CE;
	Tue,  5 Mar 2024 20:55:10 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 20:55:10 +0800
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to
 netdevice
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Henderson
	<richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
	<arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand
	<shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel
 Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <da42cea9-c169-599e-f087-d38c419e3dab@huawei.com>
Date: Tue, 5 Mar 2024 20:55:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305020153.2787423-6-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/5 10:01, Mina Almasry wrote:

...

> 
> The netdev_dmabuf_binding struct is refcounted, and releases its
> resources only when all the refs are released.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> RFC v6:
> - Validate rx queue index
> - Refactor new functions into devmem.c (Pavel)

It seems odd that the functions or stucts in a file called devmem.c
are named after 'dmabuf' instead of 'devmem'.

> 

...

> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d8b810245c1d..72e932a1a948 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -8,6 +8,16 @@
>  #ifndef _NET_NETMEM_H
>  #define _NET_NETMEM_H
>  
> +#include <net/devmem.h>
> +
> +/* net_iov */
> +
> +struct net_iov {
> +	struct dmabuf_genpool_chunk_owner *owner;
> +};
> +
> +/* netmem */
> +
>  /**
>   * typedef netmem_ref - a nonexistent type marking a reference to generic
>   * network memory.
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 821aec06abf1..592f955c1241 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
>  			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
>  			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
>  			fib_notifier.o xdp.o flow_offload.o gro.o \
> -			netdev-genl.o netdev-genl-gen.o gso.o
> +			netdev-genl.o netdev-genl-gen.o gso.o devmem.o
>  
>  obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fe054cbd41e9..bbea1b252529 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -155,6 +155,9 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
> +#include <linux/genalloc.h>
> +#include <linux/dma-buf.h>
> +#include <net/devmem.h>
>  
>  #include "dev.h"
>  #include "net-sysfs.h"
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> new file mode 100644
> index 000000000000..779ad990971e
> --- /dev/null
> +++ b/net/core/devmem.c
> @@ -0,0 +1,293 @@
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
> +
> +/* Device memory support */
> +
> +#ifdef CONFIG_DMA_SHARED_BUFFER

I still think it is worth adding its own config for devmem or dma-buf
for networking, thinking about the embeded system.

> +static void netdev_dmabuf_free_chunk_owner(struct gen_pool *genpool,
> +					   struct gen_pool_chunk *chunk,
> +					   void *not_used)

It seems odd to still keep the netdev_ prefix as it is not really related
to netdev, perhaps use 'net_' or something better.

> +{
> +	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
> +
> +	kvfree(owner->niovs);
> +	kfree(owner);
> +}
> +
> +void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
> +{
> +	size_t size, avail;
> +
> +	gen_pool_for_each_chunk(binding->chunk_pool,
> +				netdev_dmabuf_free_chunk_owner, NULL);
> +
> +	size = gen_pool_size(binding->chunk_pool);
> +	avail = gen_pool_avail(binding->chunk_pool);
> +
> +	if (!WARN(size != avail, "can't destroy genpool. size=%lu, avail=%lu",
> +		  size, avail))
> +		gen_pool_destroy(binding->chunk_pool);
> +
> +	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> +				 DMA_BIDIRECTIONAL);

For now DMA_FROM_DEVICE seems enough as tx is not supported yet.

> +	dma_buf_detach(binding->dmabuf, binding->attachment);
> +	dma_buf_put(binding->dmabuf);
> +	xa_destroy(&binding->bound_rxq_list);
> +	kfree(binding);
> +}
> +
> +static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
> +{
> +	void *new_mem;
> +	void *old_mem;
> +	int err;
> +
> +	if (!dev || !dev->netdev_ops)
> +		return -EINVAL;
> +
> +	if (!dev->netdev_ops->ndo_queue_stop ||
> +	    !dev->netdev_ops->ndo_queue_mem_free ||
> +	    !dev->netdev_ops->ndo_queue_mem_alloc ||
> +	    !dev->netdev_ops->ndo_queue_start)
> +		return -EOPNOTSUPP;
> +
> +	new_mem = dev->netdev_ops->ndo_queue_mem_alloc(dev, rxq_idx);
> +	if (!new_mem)
> +		return -ENOMEM;
> +
> +	err = dev->netdev_ops->ndo_queue_stop(dev, rxq_idx, &old_mem);
> +	if (err)
> +		goto err_free_new_mem;
> +
> +	err = dev->netdev_ops->ndo_queue_start(dev, rxq_idx, new_mem);
> +	if (err)
> +		goto err_start_queue;
> +
> +	dev->netdev_ops->ndo_queue_mem_free(dev, old_mem);
> +
> +	return 0;
> +
> +err_start_queue:
> +	dev->netdev_ops->ndo_queue_start(dev, rxq_idx, old_mem);

It might worth mentioning why queue start with old_mem will always
success here as the return value seems to be ignored here.

> +
> +err_free_new_mem:
> +	dev->netdev_ops->ndo_queue_mem_free(dev, new_mem);
> +
> +	return err;
> +}
> +
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
> +void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	unsigned long xa_idx;
> +	unsigned int rxq_idx;
> +
> +	if (!binding)
> +		return;
> +
> +	if (binding->list.next)
> +		list_del(&binding->list);

The above does not seems to be a good pattern to delete a entry, is
there any reason having a checking before the list_del()? seems like
defensive programming?

> +
> +	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> +		if (rxq->binding == binding) {

It seems like defensive programming here too?

> +			/* We hold the rtnl_lock while binding/unbinding
> +			 * dma-buf, so we can't race with another thread that
> +			 * is also modifying this value. However, the driver
> +			 * may read this config while it's creating its
> +			 * rx-queues. WRITE_ONCE() here to match the
> +			 * READ_ONCE() in the driver.
> +			 */
> +			WRITE_ONCE(rxq->binding, NULL);
> +
> +			rxq_idx = get_netdev_rx_queue_index(rxq);
> +
> +			netdev_restart_rx_queue(binding->dev, rxq_idx);
> +		}
> +	}
> +
> +	xa_erase(&netdev_dmabuf_bindings, binding->id);
> +
> +	netdev_dmabuf_binding_put(binding);
> +}
> +


