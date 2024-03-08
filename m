Return-Path: <linux-arch+bounces-2899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C1875CFA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 04:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE397B21C7C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC452C6A3;
	Fri,  8 Mar 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZADXQRtg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820532C190;
	Fri,  8 Mar 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709870312; cv=none; b=jE+T3TVAaPGExfSWnw0azJsuKJv6Bjo+gI36j3pWmCSKe4ARCHTLXDsgj4JP3sjbwK8SLd38XPcNSv/m2BuQducyNYDZyGxZIqXLlpcTcQHV0eD51T5mRDnSWpe85OIp17ysvLqxuQ7eE3KVPts7BGaS2Qw+ohIVEqxv59smoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709870312; c=relaxed/simple;
	bh=mF6Wbp6MtxfNFDHq0iHrXjjYNWZxisqag9vARhbWvOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKAPJFYD9DEFLLVE4606nXAd8E8OxP0B5e30PgkuP9WQk26yef/Lj4H8OIVd/PflCyZlyWEZjTE1w90LkK9HjdMXqCFyHZtOszITWqhhg0AhoR6QlXF0+tG/p8xz3o1k1FdFKCfWoCk1Y7RuhFuz2gwJu3tQ2IO6cXm9FwMgva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZADXQRtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA81C433F1;
	Fri,  8 Mar 2024 03:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709870312;
	bh=mF6Wbp6MtxfNFDHq0iHrXjjYNWZxisqag9vARhbWvOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZADXQRtggZVF7jCXRnr/Nx++UqGw2O1E+U/KttSTtzSSlM9bBjttGEo/A8hRic7ge
	 O+gDFK9MJBHmJ2YDam/9YZE3gp0xxBazL1mTi5MDwug/eJk53dwV/etCOw6KZlAWuN
	 2i1Oe8pKYSCdgSopwQohIoatN4yPvCX5Cuzbnr/d5jvVAjw1Ie2U1uJLT8OtOKVyTs
	 N5lwkQbIk4pRTkVTCTO3QA4II1m8BzPZ9ti7U330EoXvcxzor4u0v+kBt/tUSkRAKp
	 tt8z4/H4M6CWk2MTdlJfmcAQM/5mZHnYRX7fG89CTjTzKp4ec7OLIdHAisaNLAPPMH
	 kRchFPzFcbV0A==
Date: Thu, 7 Mar 2024 19:58:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf
 to netdevice
Message-ID: <20240307195828.183a76c2@kernel.org>
In-Reply-To: <20240305020153.2787423-6-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
	<20240305020153.2787423-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 18:01:40 -0800 Mina Almasry wrote:
> +	if (!dev || !dev->netdev_ops)
> +		return -EINVAL;

too defensive

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

nice :)

> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> +
> +	if (rxq->binding)

nit: a few places have an empty line between call and error check

> +		return -EEXIST;

> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;

this can be a flag on the netlink policy, no?

	flags: [ admin-perm ]

on the op

> +	dmabuf = dma_buf_get(dmabuf_fd);
> +	if (IS_ERR_OR_NULL(dmabuf))
> +		return -EBADFD;


> +	hdr = genlmsg_put(rsp, info->snd_portid, info->snd_seq,

genlmsg_iput()

> +static int netdev_netlink_notify(struct notifier_block *nb, unsigned long state,
> +				 void *_notify)
> +{
> +	struct netlink_notify *notify = _notify;
> +	struct netdev_dmabuf_binding *rbinding;
> +
> +	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
> +		return NOTIFY_DONE;
> +
> +	rtnl_lock();
> +
> +	list_for_each_entry(rbinding, &netdev_rbinding_list, list) {
> +		if (rbinding->owner_nlportid == notify->portid) {
> +			netdev_unbind_dmabuf(rbinding);
> +			break;
> +		}
> +	}
> +
> +	rtnl_unlock();
> +
> +	return NOTIFY_OK;
> +}

While you were not looking we added three new members to the netlink
family:

 * @sock_priv_size: the size of per-socket private memory
 * @sock_priv_init: the per-socket private memory initializer
 * @sock_priv_destroy: the per-socket private memory destructor

You should be able to associate state with a netlink socket
and have it auto-destroyed if the socket closes.
LMK if that doesn't work for you, I was hoping it would fit nicely.

I just realized now that the code gen doesn't know how to spit
those members out, but I'll send a patch tomorrow, you can hack
it manually until that gets in.

