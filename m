Return-Path: <linux-arch+bounces-5719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45D940B1E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 10:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE50B22505
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137341922E7;
	Tue, 30 Jul 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K0SNL6uI"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868D18FDC0;
	Tue, 30 Jul 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327468; cv=none; b=hOg1EnHun6w2sxRk/sNH5oKq+3V8bWRg+3hbY3ve4Io0pAAIWMY0KhG+gMl22lNb9a+akU34KXUXi3lfZfG02akaWrJ3CaX8BenoJr8ICN6WDUUARZcoxKsUTRDva0C6i9zWdRHJz9K6co1VNn77HXRajstnSnFUQsiL1uvX+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327468; c=relaxed/simple;
	bh=SoTuAhXH8DAcGS2Zg9eo9Y+q6LWEAmfzEF5TC+h8Cco=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KrgrT3Qo+/mHbCDS077VXDGPGIE/LZkJC5b9b4hZfNWWI7J6ZhGwBn6NwFd9kihaSydUWRA1Uu5ZeTTUPu7XwotuNo6xcTcmwDURYQI2y4w7HZ54tliBtgVszYrJv66Rglbu3iPoC3TMopfw8ZSDBSIwJfbEKZRI1PfJDR21G+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K0SNL6uI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722327455; h=Message-ID:Subject:Date:From:To;
	bh=BL5MMNWBxRZiD5bwdc51aQGuezbk7sZ94pe6i1nz4Vo=;
	b=K0SNL6uIC0eITT6Ch2r7BogGPhKmMDjZy9Nxz+6Qhajjb1Vgq/5wlNA9xcpE72fmkEEE7MYawZrvsms1DS5GczCXuJHg1wM70Cz7KiIdGiCXxcAwrzA7UdmVW+UJmSxEwAkF5AoIWCTtZnkCxdajJydcKxgpmyWuYlcQLFHpbj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=53;SR=0;TI=SMTPD_---0WBexhuz_1722327451;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WBexhuz_1722327451)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 16:17:32 +0800
Message-ID: <1722327259.5659568-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v17 01/14] netdev: add netdev_rx_queue_restart()
Date: Tue, 30 Jul 2024 16:14:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Mina Almasry <almasrymina@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20240730022623.98909-1-almasrymina@google.com>
 <20240730022623.98909-2-almasrymina@google.com>
In-Reply-To: <20240730022623.98909-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

On Tue, 30 Jul 2024 02:26:05 +0000, Mina Almasry <almasrymina@google.com> wrote:
> Add netdev_rx_queue_restart() function to netdev_rx_queue.h


Can you say more? As far as I understand, we just release the buffer
submitted to the rx ring and get a new page pool.

But I personally feel that the interface here is a bit too complicated. In
particular, we also need to copy the rx struct memory, which means it is a
dangerous operation for many pointers.

Thanks.


>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> ---
>
> v17:
> - Use ASSERT_RTNL() (Jakub).
>
> v13:
> - Add reviewed-by from Pavel (thanks!)
> - Fixed comment (Pavel)
>
> v11:
> - Fix not checking dev->queue_mgmt_ops (Pavel).
> - Fix ndo_queue_mem_free call that passed the wrong pointer (David).
>
> v9: https://lore.kernel.org/all/20240502045410.3524155-4-dw@davidwei.uk/
> (submitted by David).
> - fixed SPDX license identifier (Simon).
> - Rebased on top of merged queue API definition, and changed
>   implementation to match that.
> - Replace rtnl_lock() with rtnl_is_locked() to make it useable from my
>   netlink code where rtnl is already locked.
>
> ---
>  include/net/netdev_rx_queue.h |  3 ++
>  net/core/Makefile             |  1 +
>  net/core/netdev_rx_queue.c    | 74 +++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 net/core/netdev_rx_queue.c
>
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index aa1716fb0e53c..e78ca52d67fbf 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  	return index;
>  }
>  #endif
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +
>  #endif
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 62be9aef25285..f82232b358a2c 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>
>  obj-y += net-sysfs.o
>  obj-y += hotdata.o
> +obj-y += netdev_rx_queue.o
>  obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
>  obj-$(CONFIG_PROC_FS) += net-procfs.o
>  obj-$(CONFIG_NET_PKTGEN) += pktgen.o
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> new file mode 100644
> index 0000000000000..da11720a59830
> --- /dev/null
> +++ b/net/core/netdev_rx_queue.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/netdevice.h>
> +#include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
> +{
> +	void *new_mem, *old_mem;
> +	int err;
> +
> +	if (!dev->queue_mgmt_ops || !dev->queue_mgmt_ops->ndo_queue_stop ||
> +	    !dev->queue_mgmt_ops->ndo_queue_mem_free ||
> +	    !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
> +	    !dev->queue_mgmt_ops->ndo_queue_start)
> +		return -EOPNOTSUPP;
> +
> +	ASSERT_RTNL();
> +
> +	new_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
> +	if (!new_mem)
> +		return -ENOMEM;
> +
> +	old_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
> +	if (!old_mem) {
> +		err = -ENOMEM;
> +		goto err_free_new_mem;
> +	}
> +
> +	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
> +	if (err)
> +		goto err_free_old_mem;
> +
> +	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, old_mem, rxq_idx);
> +	if (err)
> +		goto err_free_new_queue_mem;
> +
> +	err = dev->queue_mgmt_ops->ndo_queue_start(dev, new_mem, rxq_idx);
> +	if (err)
> +		goto err_start_queue;
> +
> +	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
> +
> +	kvfree(old_mem);
> +	kvfree(new_mem);
> +
> +	return 0;
> +
> +err_start_queue:
> +	/* Restarting the queue with old_mem should be successful as we haven't
> +	 * changed any of the queue configuration, and there is not much we can
> +	 * do to recover from a failure here.
> +	 *
> +	 * WARN if we fail to recover the old rx queue, and at least free
> +	 * old_mem so we don't also leak that.
> +	 */
> +	if (dev->queue_mgmt_ops->ndo_queue_start(dev, old_mem, rxq_idx)) {
> +		WARN(1,
> +		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
> +		     rxq_idx);
> +		dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
> +	}
> +
> +err_free_new_queue_mem:
> +	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
> +
> +err_free_old_mem:
> +	kvfree(old_mem);
> +
> +err_free_new_mem:
> +	kvfree(new_mem);
> +
> +	return err;
> +}
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>
>

