Return-Path: <linux-arch+bounces-6062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC45949938
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F32829FD
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BBA14901A;
	Tue,  6 Aug 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8YxGWgP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03440875;
	Tue,  6 Aug 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976642; cv=none; b=e1UywqPh5Z+jweJs3fYBe26pJ/IfwukLn/m9ckGASEOM3LOI2fFlfHMY5HZ1YszePqpsS7xp5hjwfGYoA9OQAaz8a6/QUi97zpYr0e8cG3uL/922elDOQkdXYw4wGxe3QKRiB9DqYgn/oWmcpxFxOclUHHDa4mUGIPrMYg7bW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976642; c=relaxed/simple;
	bh=g7QmdLe9IFWfz7C77+mSFv4ErgmVpHHeVChQmimHYG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEkR2Sih9hN6YqOQJbx3rNxW2RwuyeGL+6UAKwT7b9PkKvDpFV8FtRNM2N+B9FdB/S7+8WORFnPHGop5IOtyMZ7ukzXFfEbjrSL/rYMElPBMOam3iJvmVON2y9AbaXSV6AdxiNwTjboaPQY4+/dciggFe0imMTNhZHLGLbZsr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8YxGWgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EDAC32786;
	Tue,  6 Aug 2024 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976642;
	bh=g7QmdLe9IFWfz7C77+mSFv4ErgmVpHHeVChQmimHYG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8YxGWgP2UMFZzmnwxFTZacJCBIWbq/z7d+2P/PY9Q5HIpRaRo5UUK629pTV5bU+K
	 L3ODKR2S5C8Cly3RBZpnOtbw5A5RD74DNc4Aj4LRaY63F5SOWYn6WNAABfQVNaoSB4
	 FnE3lOClziNlgKZEPEYmJBdLpHfq+tGNeTW7non+xpfZ8H3Lr3TTodHiZ+fYNm7oFa
	 r005iJn+WbIbLd0BIb+hBF88OkmE45EdIBQjJcPcfRT2D2o5UiOYQ/EiQLGXjGO1tH
	 AfKdXhSddmFMc8kSMXFn4WyrWcVQtGQCNAtdpP2AnK1qNaK4TzeqntlXV0d0ds42aS
	 r3Mb4dSi5D2ZA==
Date: Tue, 6 Aug 2024 13:37:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
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
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v18 03/14] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240806133718.71a53a4f@kernel.org>
In-Reply-To: <20240805212536.2172174-4-almasrymina@google.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 21:25:16 +0000 Mina Almasry wrote:
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);

nit: global variable declarations before any code

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
> +			rxq->mp_params.mp_priv = NULL;
> +
> +			rxq_idx = get_netdev_rx_queue_index(rxq);
> +
> +			netdev_rx_queue_restart(binding->dev, rxq_idx);

Throw in a WARN_ON() around this, hopefully we'll get to addressing it
later..

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

If we prevent binding to an inactive queue we should also prevent
deactivation.

Please take a look at the (two?) callers of
ethtool_get_max_rxnfc_channel() and ethtool_get_max_rxfh_channel().
Wrap those into a new function for reading max active channel, and
take mp binds into account as well (send the refactor separately 
from the series to avoid making it longer).

> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> +	if (rxq->mp_params.mp_priv)
> +		return -EEXIST;
> +
> +	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	rxq->mp_params.mp_priv = binding;
> +
> +	err = netdev_rx_queue_restart(dev, rxq_idx);
> +	if (err)
> +		goto err_xa_erase;
> +
> +	return 0;
> +
> +err_xa_erase:
> +	rxq->mp_params.mp_priv = NULL;
> +	xa_erase(&binding->bound_rxqs, xa_idx);
> +
> +	return err;
> +}

> +void dev_dmabuf_uninstall(struct net_device *dev)
> +{
> +	unsigned int i, count = dev->num_rx_queues;

nit: why stash the value of num_rx_queues ?

> +	struct net_devmem_dmabuf_binding *binding;
> +	struct netdev_rx_queue *rxq;
> +	unsigned long xa_idx;
> +
> +	for (i = 0; i < count; i++) {
> +		binding = dev->_rx[i].mp_params.mp_priv;
> +		if (binding)
> +			xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
> +				if (rxq == &dev->_rx[i])
> +					xa_erase(&binding->bound_rxqs, xa_idx);

nit: Please use "continue", this is too deeply indented

> +	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> +			       genlmsg_data(info->genlhdr),
> +			       genlmsg_len(info->genlhdr), rem) {
> +		err = nla_parse_nested(
> +			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
> +			netdev_queue_id_nl_policy, info->extack);
> +		if (err < 0)
> +			goto err_unbind;
> +
> +		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);

How do we know this attribute is present?  NL_REQ_ATTR_CHECK()

> +		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding);
> +		if (err)
> +			goto err_unbind;
> +	}
> +
> +	list_add(&binding->list, sock_binding_list);
> +
> +	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	genlmsg_end(rsp, hdr);
> +
> +	rtnl_unlock();

nit: for symmetry you should also unlock after list_add(),
     netlink msg alloc and prep are before rtnl_lock()

> +	return genlmsg_reply(rsp, info);
> +
> +err_unbind:
> +	net_devmem_unbind_dmabuf(binding);
> +err_unlock:
> +	rtnl_unlock();
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +	return err;
>  }

> +void netdev_nl_sock_priv_init(struct list_head *priv)
> +{
> +	INIT_LIST_HEAD(priv);
> +}
> +
> +void netdev_nl_sock_priv_destroy(struct list_head *priv)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	struct net_devmem_dmabuf_binding *temp;
> +
> +	list_for_each_entry_safe(binding, temp, priv, list) {
> +		rtnl_lock();
> +		net_devmem_unbind_dmabuf(binding);
> +		rtnl_unlock();
> +	}
> +}

nit: move these before the subsys_initcall.. and what it calls

