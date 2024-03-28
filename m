Return-Path: <linux-arch+bounces-3276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264EC890842
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 19:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9435C1F24E94
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7812FB36;
	Thu, 28 Mar 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/yG/doR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A81136E29;
	Thu, 28 Mar 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650506; cv=none; b=RWO+xypqnhY/5wo8iMzBkWKfk6+UGu83i7eq9FW3GlMpBdO9qopL/d19xWWSKdC9Lhq+INg+3hSdKkSvoFmFvoHugE4jiJrYGk8NY4JHCB/uNxhAz/+mqAxCINg4NjCVqWQtR2I0zzgpwfezrLU5OdGc8GOnv0xBXR88AfBJW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650506; c=relaxed/simple;
	bh=fCpsuqpXPx6EiIEqbV6/oK+Mco4Eg3WQcaCu8FFYxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szC01qJIyRbhFpJ2EdWWwRN8BTvKblSusZFXnbGqVAt9h9OFgkWngQ4p+w2eGOUCY3feMg5MP4zH4njT8c1LYGmNiAIa3Fu3UR5j066mxjzIUIpkwm6IucL8beqWx3rzRqGNz9tpBXr5tkJrYmpwPpMhjzpiTDf6fx/X2PtbAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/yG/doR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A2C433F1;
	Thu, 28 Mar 2024 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711650505;
	bh=fCpsuqpXPx6EiIEqbV6/oK+Mco4Eg3WQcaCu8FFYxmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/yG/doRGyXpqxmVEGZRl29Gx01ZBHRqsLyBFhmaT8mmf44tImPwfhWbq/+onqqYQ
	 Mk7belOYYdf/oaQElpAohzTOcmJEhrO4/oBdC872X4+PkuC19MXZYEObKWc8b1DXht
	 E4JJM33unaXbObP+98zU5UfutVyF0MSVFb61PFWrUjcxtA1CoRmOrTxZIvLd/2j5Xc
	 i2AR4w5A19X/edVUb5L7inWvNDxXBn2PViw3xzrRFzrBAWN5Ov77wY7xaniySz8nzx
	 dj+p8Y9PBq0IYtN+jR1hn0KR4MgR7mupP9oDLO77XhK2IZq0VluR8c5zcvoWCrB8P2
	 oprZ6oa0nyp9A==
Date: Thu, 28 Mar 2024 18:28:12 +0000
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH net-next v7 04/14] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240328182812.GJ651713@kernel.org>
References: <20240326225048.785801-1-almasrymina@google.com>
 <20240326225048.785801-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326225048.785801-5-almasrymina@google.com>

On Tue, Mar 26, 2024 at 03:50:35PM -0700, Mina Almasry wrote:
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

...

> +int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +				    struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	u32 xa_idx;
> +	int err;
> +
> +	if (rxq_idx >= dev->num_rx_queues)
> +		return -ERANGE;
> +
> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> +	if (rxq->mp_params.mp_priv)
> +		return -EEXIST;
> +
> +	err = xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	/* We hold the rtnl_lock while binding/unbinding dma-buf, so we can't
> +	 * race with another thread that is also modifying this value. However,
> +	 * the driver may read this config while it's creating its * rx-queues.
> +	 * WRITE_ONCE() here to match the READ_ONCE() in the driver.
> +	 */
> +	WRITE_ONCE(rxq->mp_params.mp_ops, &dmabuf_devmem_ops);

Hi Mina,

This causes a build failure because mabuf_devmem_ops is not added until a
subsequent patch in this series.

> +	WRITE_ONCE(rxq->mp_params.mp_priv, binding);
> +
> +	err = net_devmem_restart_rx_queue(dev, rxq_idx);
> +	if (err)
> +		goto err_xa_erase;
> +
> +	return 0;
> +
> +err_xa_erase:
> +	WRITE_ONCE(rxq->mp_params.mp_ops, NULL);
> +	WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
> +	xa_erase(&binding->bound_rxq_list, xa_idx);
> +
> +	return err;
> +}

...

