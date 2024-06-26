Return-Path: <linux-arch+bounces-5138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFB917A83
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F5B20E89
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B915FA60;
	Wed, 26 Jun 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bL1ZH4Wh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368A15F3E6
	for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389446; cv=none; b=mN+p5ZPnQY29JbNXDECm3H6la5rh3bySnq5fVgf48yddyOxYHy50isLyLXEVxexIkbZQAa1he2beWK9bkMJdbhwAAPd345vDF4Q8ua96cU9ysttLlJpA+SlkGYnCoV31OqQnvO8W76CJDMTjVqsIiRJYWahoZiHRfBjQ5BkYw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389446; c=relaxed/simple;
	bh=4bQBmelvFx0va6I0P4TH1yhUKdgdHIilOEllEVPVCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXUkz7J82RzRq+i0JUULPTGqUvP77nYcaJdV+sjv5R7Ap8VoXjbxk7N22CLKqRB3+IRgM5+2+Lav9cQA8D27C00wgsRDZ6rU/UQ+h0ylUFf2EPSW1PKPRfYOE1U2Ynof8XsAbRlpdgzdwkYK2UXPvDicHX3TmRn6LxxZHbmoshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=bL1ZH4Wh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424aa86cc79so1136065e9.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719389442; x=1719994242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTze6uQglfoQ7bd5HZF1X+Dq8LqYd9uXy2OEoqYCa+c=;
        b=bL1ZH4WhRY4FXmzOAepYDmfKf+6tdiLC76GEjwKJyNxYw+JHEA3Oe2buYZJqrute+5
         66T0oLgKF0qF5oe8PTv6OCJj+jIbX2ZjmqwNcqeYUkb4vNCujsz+D0988zA9eKf84g96
         JZU9bYF64YtpkimyL4JHdyE4rwjLwAz6XrO/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389442; x=1719994242;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTze6uQglfoQ7bd5HZF1X+Dq8LqYd9uXy2OEoqYCa+c=;
        b=nn6fLLvTmxo6UNRBF5L5sxBAm9TH1YPYXWw8aSNf6ytAyZdgx4+y5hYASfchubHi1c
         8GqGuDlqc4mUBvilqjxWsAy9aOSn4UP7esZn5bYMPZKsjEGQhQ5VL35r2V1exn/KyBDa
         lqcZ9Eh/z1iTJG+1lvBmeXs0NTTgkKWtNBm8HYqoqwBmqJbNtUz9rQu17wroD8EkXbX5
         afpj2uX6kFZdeb9EvHOp1hnJk0dGeS8p6TooAwPBbvk/n52nH8lx5Mtv0z+pfGIrW1oU
         6/RQ7/3SspR7uvhBq0jjJfvqHztz5Yz8pqZVxHXyO8+B5Rid/ZFJQVuZQ8dXDoh8ZIfg
         HHQA==
X-Forwarded-Encrypted: i=1; AJvYcCW9uj76V5GAKX3tqWIkC8hVH7Xa2LmasURIGYtXKurmKrD4JX9PMXc3PcGfA5ShfZZ9mIqhfAfhVdDmGHMYjFvIG0k0dqOlHa/6CQ==
X-Gm-Message-State: AOJu0YzXVKjUmiOTLNL5PuVRskKKG6E2qmaaSm7tvEtvuJg8cIindNcI
	hzGm9Usms7pYG9D3hxHUNEnEMnduGPIgUmZVWW8mYXrhhDniwBPlNb82fGCPO8I=
X-Google-Smtp-Source: AGHT+IG3VeRlU8nnyJudUn6Rkwkpw0MnXZ9IP0oTHce01stCgWbRGgfj/gvI1PaoMxMMBkcSEPpkSA==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d3 with SMTP id 5b1f17b1804b1-424a74b3420mr22644585e9.0.1719389441916;
        Wed, 26 Jun 2024 01:10:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8468613sm15560755e9.39.2024.06.26.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:10:41 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:10:38 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
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
Subject: Re: [PATCH net-next v14 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <ZnvM_gtscO7q9P2Y@phenom.ffwll.local>
Mail-Followup-To: Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
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
References: <20240625195407.1922912-1-almasrymina@google.com>
 <20240625195407.1922912-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625195407.1922912-4-almasrymina@google.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Tue, Jun 25, 2024 at 07:53:51PM +0000, Mina Almasry wrote:
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
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com> # excluding netlink

Absolutely no idea on the netdev side of things, and I'll leave the entire
"how much userspace do you want" up to netdev folks too. But the dma_buf
side looks fine, so for that:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Sima
> 
> ---
> 
> v13:
> - Fixed a couple of places that still listed DMA_BIDIRECTIONAL (Pavel).
> - Added reviewed-by from Pavel.
> 
> v11:
> - Fix build error with CONFIG_DMA_SHARED_BUFFER &&
>   !CONFIG_GENERIC_ALLOCATOR
> - Rebased on top of no memory provider ops.
> 
> v10:
> - Moved net_iov_dma_addr() to devmem.h and made it devmem specific
>   helper (David).
> 
> v9: https://lore.kernel.org/all/20240403002053.2376017-5-almasrymina@google.com/
> - Removed net_devmem_restart_rx_queues and put it in its own patch
>   (David).
> 
> v8:
> - move dmabuf_devmem_ops usage to later patch to avoid patch-by-patch
>   build error.
> 
> v7:
> - Use IS_ERR() instead of IS_ERR_OR_NULL() for the dma_buf_get() return
>   value.
> - Changes netdev_* naming in devmem.c to net_devmem_* (Yunsheng).
> - DMA_BIDIRECTIONAL -> DMA_FROM_DEVICE (Yunsheng).
> - Added a comment around recovering of the old rx queue in
>   net_devmem_restart_rx_queue(), and added freeing of old_mem if the
>   restart of the old queue fails. (Yunsheng).
> - Use kernel-family sock-priv (Jakub).
> - Put pp_memory_provider_params in netdev_rx_queue instead of the
>   dma-buf specific binding (Pavel & David).
> - Move queue management ops to queue_mgmt_ops instead of netdev_ops
>   (Jakub).
> - Remove excess whitespaces (Jakub).
> - Use genlmsg_iput (Jakub).
> 
> v6:
> - Validate rx queue index
> - Refactor new functions into devmem.c (Pavel)
> 
> v5:
> - Renamed page_pool_iov to net_iov, and moved that support to devmem.h
>   or netmem.h.
> 
> v1:
> - Introduce devmem.h instead of bloating netdevice.h (Jakub)
> - ENOTSUPP -> EOPNOTSUPP (checkpatch.pl I think)
> - Remove unneeded rcu protection for binding->list (rtnl protected)
> - Removed extraneous err_binding_put: label.
> - Removed dma_addr += len (Paolo).
> - Don't override err on netdev_bind_dmabuf_to_queue failure.
> - Rename devmem -> dmabuf (David).
> - Add id to dmabuf binding (David/Stan).
> - Fix missing xa_destroy bound_rq_list.
> - Use queue api to reset bound RX queues (Jakub).
> - Update netlink API for rx-queue type (tx/re) (Jakub).
> 
> RFC v3:
> - Support multi rx-queue binding
> 
> ---
>  Documentation/netlink/specs/netdev.yaml |   4 +
>  include/net/devmem.h                    | 111 +++++++++++
>  include/net/netdev_rx_queue.h           |   2 +
>  include/net/netmem.h                    |  10 +
>  include/net/page_pool/types.h           |   6 +
>  net/core/Makefile                       |   2 +-
>  net/core/dev.c                          |   3 +
>  net/core/devmem.c                       | 252 ++++++++++++++++++++++++
>  net/core/netdev-genl-gen.c              |   4 +
>  net/core/netdev-genl-gen.h              |   4 +
>  net/core/netdev-genl.c                  | 101 +++++++++-
>  11 files changed, 496 insertions(+), 3 deletions(-)
>  create mode 100644 include/net/devmem.h
>  create mode 100644 net/core/devmem.c
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 899ac0882a098..d6d7cb01c145c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -673,6 +673,10 @@ operations:
>              - tx-packets
>              - tx-bytes
>  
> +kernel-family:
> +  headers: [ "linux/list.h"]
> +  sock-priv: struct list_head
> +
>  mcast-groups:
>    list:
>      -
> diff --git a/include/net/devmem.h b/include/net/devmem.h
> new file mode 100644
> index 0000000000000..eaf3fd965d7a8
> --- /dev/null
> +++ b/include/net/devmem.h
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Device memory TCP support
> + *
> + * Authors:	Mina Almasry <almasrymina@google.com>
> + *		Willem de Bruijn <willemb@google.com>
> + *		Kaiyuan Zhang <kaiyuanz@google.com>
> + *
> + */
> +#ifndef _NET_DEVMEM_H
> +#define _NET_DEVMEM_H
> +
> +struct net_devmem_dmabuf_binding {
> +	struct dma_buf *dmabuf;
> +	struct dma_buf_attachment *attachment;
> +	struct sg_table *sgt;
> +	struct net_device *dev;
> +	struct gen_pool *chunk_pool;
> +
> +	/* The user holds a ref (via the netlink API) for as long as they want
> +	 * the binding to remain alive. Each page pool using this binding holds
> +	 * a ref to keep the binding alive. Each allocated net_iov holds a
> +	 * ref.
> +	 *
> +	 * The binding undos itself and unmaps the underlying dmabuf once all
> +	 * those refs are dropped and the binding is no longer desired or in
> +	 * use.
> +	 */
> +	refcount_t ref;
> +
> +	/* The list of bindings currently active. Used for netlink to notify us
> +	 * of the user dropping the bind.
> +	 */
> +	struct list_head list;
> +
> +	/* rxq's this binding is active on. */
> +	struct xarray bound_rxq_list;
> +
> +	/* ID of this binding. Globally unique to all bindings currently
> +	 * active.
> +	 */
> +	u32 id;
> +};
> +
> +/* Owner of the dma-buf chunks inserted into the gen pool. Each scatterlist
> + * entry from the dmabuf is inserted into the genpool as a chunk, and needs
> + * this owner struct to keep track of some metadata necessary to create
> + * allocations from this chunk.
> + */
> +struct dmabuf_genpool_chunk_owner {
> +	/* Offset into the dma-buf where this chunk starts.  */
> +	unsigned long base_virtual;
> +
> +	/* dma_addr of the start of the chunk.  */
> +	dma_addr_t base_dma_addr;
> +
> +	/* Array of net_iovs for this chunk. */
> +	struct net_iov *niovs;
> +	size_t num_niovs;
> +
> +	struct net_devmem_dmabuf_binding *binding;
> +};
> +
> +#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATOR)
> +void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
> +int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +			   struct net_devmem_dmabuf_binding **out);
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
> +int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +				    struct net_devmem_dmabuf_binding *binding);
> +#else
> +static inline void
> +__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
> +{
> +}
> +
> +static inline int net_devmem_bind_dmabuf(struct net_device *dev,
> +					 unsigned int dmabuf_fd,
> +					 struct net_devmem_dmabuf_binding **out)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline void
> +net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +}
> +
> +static inline int
> +net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +				struct net_devmem_dmabuf_binding *binding)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
> +static inline void
> +net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
> +{
> +	refcount_inc(&binding->ref);
> +}
> +
> +static inline void
> +net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
> +{
> +	if (!refcount_dec_and_test(&binding->ref))
> +		return;
> +
> +	__net_devmem_dmabuf_binding_free(binding);
> +}
> +
> +#endif /* _NET_DEVMEM_H */
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index e78ca52d67fbf..ac34f5fb4f71d 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -6,6 +6,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/sysfs.h>
>  #include <net/xdp.h>
> +#include <net/page_pool/types.h>
>  
>  /* This structure contains an instance of an RX queue. */
>  struct netdev_rx_queue {
> @@ -25,6 +26,7 @@ struct netdev_rx_queue {
>  	 * Readers and writers must hold RTNL
>  	 */
>  	struct napi_struct		*napi;
> +	struct pp_memory_provider_params mp_params;
>  } ____cacheline_aligned_in_smp;
>  
>  /*
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d8b810245c1da..72e932a1a9489 100644
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
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 7e8477057f3d1..9f3c3ee2ee755 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -128,6 +128,10 @@ struct page_pool_stats {
>  };
>  #endif
>  
> +struct pp_memory_provider_params {
> +	void *mp_priv;
> +};
> +
>  struct page_pool {
>  	struct page_pool_params_fast p;
>  
> @@ -194,6 +198,8 @@ struct page_pool {
>  	 */
>  	struct ptr_ring ring;
>  
> +	void *mp_priv;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>  	/* recycle stats are per-cpu to avoid locking */
>  	struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/Makefile b/net/core/Makefile
> index f82232b358a2c..6b43611fb4a43 100644
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
> index b94fb4e63a289..85255b8e34a45 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -158,6 +158,9 @@
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/rps.h>
> +#include <linux/genalloc.h>
> +#include <linux/dma-buf.h>
> +#include <net/devmem.h>
>  
>  #include "dev.h"
>  #include "net-sysfs.h"
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> new file mode 100644
> index 0000000000000..cfb5a2f69dcd2
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
> +	dma_buf_detach(binding->dmabuf, binding->attachment);
> +	dma_buf_put(binding->dmabuf);
> +	xa_destroy(&binding->bound_rxq_list);
> +	kfree(binding);
> +}
> +
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
> +
> +	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> +		if (rxq->mp_params.mp_priv == binding) {
> +			/* We hold the rtnl_lock while binding/unbinding
> +			 * dma-buf, so we can't race with another thread that
> +			 * is also modifying this value. However, the page_pool
> +			 * may read this config while it's creating its
> +			 * rx-queues. WRITE_ONCE() here to match the
> +			 * READ_ONCE() in the page_pool.
> +			 */
> +			WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
> +
> +			rxq_idx = get_netdev_rx_queue_index(rxq);
> +
> +			netdev_rx_queue_restart(binding->dev, rxq_idx);
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
> +	WRITE_ONCE(rxq->mp_params.mp_priv, binding);
> +
> +	err = netdev_rx_queue_restart(dev, rxq_idx);
> +	if (err)
> +		goto err_xa_erase;
> +
> +	return 0;
> +
> +err_xa_erase:
> +	WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
> +	xa_erase(&binding->bound_rxq_list, xa_idx);
> +
> +	return err;
> +}
> +
> +int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +			   struct net_devmem_dmabuf_binding **out)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	static u32 id_alloc_next;
> +	struct scatterlist *sg;
> +	struct dma_buf *dmabuf;
> +	unsigned int sg_idx, i;
> +	unsigned long virtual;
> +	int err;
> +
> +	dmabuf = dma_buf_get(dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return -EBADFD;
> +
> +	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
> +			       dev_to_node(&dev->dev));
> +	if (!binding) {
> +		err = -ENOMEM;
> +		goto err_put_dmabuf;
> +	}
> +
> +	binding->dev = dev;
> +
> +	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
> +			      binding, xa_limit_32b, &id_alloc_next,
> +			      GFP_KERNEL);
> +	if (err < 0)
> +		goto err_free_binding;
> +
> +	xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
> +
> +	refcount_set(&binding->ref, 1);
> +
> +	binding->dmabuf = dmabuf;
> +
> +	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
> +	if (IS_ERR(binding->attachment)) {
> +		err = PTR_ERR(binding->attachment);
> +		goto err_free_id;
> +	}
> +
> +	binding->sgt =
> +		dma_buf_map_attachment(binding->attachment, DMA_FROM_DEVICE);
> +	if (IS_ERR(binding->sgt)) {
> +		err = PTR_ERR(binding->sgt);
> +		goto err_detach;
> +	}
> +
> +	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> +	 * binding can be much more flexible than that. We may be able to
> +	 * allocate MTU sized chunks here. Leave that for future work...
> +	 */
> +	binding->chunk_pool =
> +		gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> +	if (!binding->chunk_pool) {
> +		err = -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	virtual = 0;
> +	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
> +		dma_addr_t dma_addr = sg_dma_address(sg);
> +		struct dmabuf_genpool_chunk_owner *owner;
> +		size_t len = sg_dma_len(sg);
> +		struct net_iov *niov;
> +
> +		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
> +				     dev_to_node(&dev->dev));
> +		owner->base_virtual = virtual;
> +		owner->base_dma_addr = dma_addr;
> +		owner->num_niovs = len / PAGE_SIZE;
> +		owner->binding = binding;
> +
> +		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
> +					 dma_addr, len, dev_to_node(&dev->dev),
> +					 owner);
> +		if (err) {
> +			err = -EINVAL;
> +			goto err_free_chunks;
> +		}
> +
> +		owner->niovs = kvmalloc_array(owner->num_niovs,
> +					      sizeof(*owner->niovs),
> +					      GFP_KERNEL);
> +		if (!owner->niovs) {
> +			err = -ENOMEM;
> +			goto err_free_chunks;
> +		}
> +
> +		for (i = 0; i < owner->num_niovs; i++) {
> +			niov = &owner->niovs[i];
> +			niov->owner = owner;
> +		}
> +
> +		virtual += len;
> +	}
> +
> +	*out = binding;
> +
> +	return 0;
> +
> +err_free_chunks:
> +	gen_pool_for_each_chunk(binding->chunk_pool,
> +				net_devmem_dmabuf_free_chunk_owner, NULL);
> +	gen_pool_destroy(binding->chunk_pool);
> +err_unmap:
> +	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> +				 DMA_FROM_DEVICE);
> +err_detach:
> +	dma_buf_detach(dmabuf, binding->attachment);
> +err_free_id:
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +err_free_binding:
> +	kfree(binding);
> +err_put_dmabuf:
> +	dma_buf_put(dmabuf);
> +	return err;
> +}
> +#endif
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 9acd0d893765a..3dcd25049e593 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -9,6 +9,7 @@
>  #include "netdev-genl-gen.h"
>  
>  #include <uapi/linux/netdev.h>
> +#include <linux/list.h>
>  
>  /* Integer value ranges */
>  static const struct netlink_range_validation netdev_a_page_pool_id_range = {
> @@ -187,4 +188,7 @@ struct genl_family netdev_nl_family __ro_after_init = {
>  	.n_split_ops	= ARRAY_SIZE(netdev_nl_ops),
>  	.mcgrps		= netdev_nl_mcgrps,
>  	.n_mcgrps	= ARRAY_SIZE(netdev_nl_mcgrps),
> +	.sock_priv_size	= sizeof(struct list_head),
> +	.sock_priv_init	= (void *)netdev_nl_sock_priv_init,
> +	.sock_priv_destroy = (void *)netdev_nl_sock_priv_destroy,
>  };
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index ca5a0983f2834..2c431b7dcbc84 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -10,6 +10,7 @@
>  #include <net/genetlink.h>
>  
>  #include <uapi/linux/netdev.h>
> +#include <linux/list.h>
>  
>  /* Common nested types */
>  extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
> @@ -40,4 +41,7 @@ enum {
>  
>  extern struct genl_family netdev_nl_family;
>  
> +void netdev_nl_sock_priv_init(struct list_head *priv);
> +void netdev_nl_sock_priv_destroy(struct list_head *priv);
> +
>  #endif /* _LINUX_NETDEV_GEN_H */
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 2d726e65211dd..133884eb13349 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -10,6 +10,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/busy_poll.h>
> +#include <net/devmem.h>
>  
>  #include "netdev-genl-gen.h"
>  #include "dev.h"
> @@ -721,10 +722,92 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  	return err;
>  }
>  
> -/* Stub */
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return 0;
> +	struct nlattr *tb[ARRAY_SIZE(netdev_queue_dmabuf_nl_policy)];
> +	struct net_devmem_dmabuf_binding *out_binding;
> +	struct list_head *sock_binding_list;
> +	u32 ifindex, dmabuf_fd, rxq_idx;
> +	struct net_device *netdev;
> +	struct sk_buff *rsp;
> +	struct nlattr *attr;
> +	int rem, err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_DMABUF_FD) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_QUEUES))
> +		return -EINVAL;
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_BIND_DMABUF_DMABUF_FD]);
> +
> +	rtnl_lock();
> +
> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	if (!netdev) {
> +		err = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	err = net_devmem_bind_dmabuf(netdev, dmabuf_fd, &out_binding);
> +	if (err)
> +		goto err_unlock;
> +
> +	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
> +			  genlmsg_len(info->genlhdr), rem) {
> +		if (nla_type(attr) != NETDEV_A_BIND_DMABUF_QUEUES)
> +			continue;
> +
> +		err = nla_parse_nested(
> +			tb, ARRAY_SIZE(netdev_queue_dmabuf_nl_policy) - 1, attr,
> +			netdev_queue_dmabuf_nl_policy, info->extack);
> +		if (err < 0)
> +			goto err_unbind;
> +
> +		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_DMABUF_IDX]);
> +
> +		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx,
> +						      out_binding);
> +		if (err)
> +			goto err_unbind;
> +	}
> +
> +	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
> +					     NETLINK_CB(skb).sk);
> +	if (IS_ERR(sock_binding_list)) {
> +		err = PTR_ERR(sock_binding_list);
> +		goto err_unbind;
> +	}
> +
> +	list_add(&out_binding->list, sock_binding_list);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp) {
> +		err = -ENOMEM;
> +		goto err_unbind;
> +	}
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}
> +
> +	nla_put_u32(rsp, NETDEV_A_BIND_DMABUF_DMABUF_ID, out_binding->id);
> +	genlmsg_end(rsp, hdr);
> +
> +	rtnl_unlock();
> +
> +	return genlmsg_reply(rsp, info);
> +
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +err_unbind:
> +	net_devmem_unbind_dmabuf(out_binding);
> +err_unlock:
> +	rtnl_unlock();
> +	return err;
>  }
>  
>  static int netdev_genl_netdevice_event(struct notifier_block *nb,
> @@ -771,3 +854,17 @@ static int __init netdev_genl_init(void)
>  }
>  
>  subsys_initcall(netdev_genl_init);
> +
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
> +	list_for_each_entry_safe(binding, temp, priv, list)
> +		net_devmem_unbind_dmabuf(binding);
> +}
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

