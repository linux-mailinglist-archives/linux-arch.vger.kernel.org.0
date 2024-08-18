Return-Path: <linux-arch+bounces-6300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C2955D41
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832C4281993
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC37143759;
	Sun, 18 Aug 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apsm6WCH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378812B93;
	Sun, 18 Aug 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995884; cv=none; b=hr/iu8iqk+2I/b98zBvYaEy+Nh1arZmn97O1UFhoZJVCz2IRkLdBknHOLm/U03/56gCB7UpxirSHOfHA4sBa+/2ow7Tm8Yt5cG+gcIjqZO9qwgM3MKcD13Cvvpl8iywsWhKxu/TSVO06NPfdAPijI0hOeeJ5aR4nYbzMClVTV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995884; c=relaxed/simple;
	bh=wulQAZdk+94213wffxbBiAnrYWBsUuA7GsioaAX/HXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEbWBzHmSD6+sP8WpzUeIGklqo17p2De43fbMcGG6o7sR4A34Xo0E2McVldF6kyeEfx6pmwT/oTAYO11SuGCiJNmI5Is0n9ndtyx353xIgBbccunXp4pcGO483TsS40qdiYAOalsemRJQIm9Yq/F18rdXAx7sp9NZLfjh5933sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apsm6WCH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3b8eb3df5so35948361fa.1;
        Sun, 18 Aug 2024 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723995879; x=1724600679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUD7NE4aD5wujC41jfWWK0oqDuEWEy1Az3bPoDDoFxE=;
        b=Apsm6WCHusD6YI6yxCUD3WednVdlCBSb1vWZQrfghVtKy/k5Sm+Qn9CpRRapjzF69g
         MVfnZYkATgnM2GND9C7Ow0NvOVcuJBCG/HsfnLppD/PgfkOvkareM+IeRCoEJOOjLaCB
         ARaTtywDzHd4XURIaxlb0RuNWcfe/DI0o0ml5NlgpnKEfqZ5xvKF+WCVWXnrQLe0BrNs
         7dWDuJRXSgXX/ASuAUHdCezC99TyiZSqkBpOr02QYENluM9ka3p+Mjug3qJu2nqy69Uo
         zKQlzMPfYC2aCMcYE7LjN9/oKay4v6RclnLS9051JGRvq9aT0llqt+hOUBcfyMaBr1gO
         WFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723995879; x=1724600679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUD7NE4aD5wujC41jfWWK0oqDuEWEy1Az3bPoDDoFxE=;
        b=FrFPq5DKAN3V26lHl77oNJhFGwtKY+GwYqvcOFgt1gmRrPseaOYOBRY5Tc/Yk1xRNK
         iKugvkgkqLBMaFayiFoesG91hDCoR8VEbXaSIt1DCaMVZlojdaiF5xHijLa3LdX25ES8
         DQkR1rZE90Sd3FfxfH1DRQEVSZZrGg6PTjHTMunZfC6WBdIsEVPI2YLVi+DF3jH3czmu
         p/6MFQx2zEnOL3NqA/OWV2QGkjvuElnq85dZXYplNVNMbPuTiOMuk9GiyGggfPYG/kVC
         Gg6hhQI+4N8KfeI5lisj+LGv1B72mZr+NxUjw/sDLnGlEgZ9oDX6rKBNCP6379qGCBwu
         vH5w==
X-Forwarded-Encrypted: i=1; AJvYcCWv3AGiqApwAWuDGs4K7LHMGCHnR7i5j3WjzH1Vy0eqrp5WJI+bBueUyifPcyop++YetdfPrCDOiZvzXmCAG999mPQseuPj4GkSxijOpomkTkeZy0CbrEktDHxGwq3G5dYxj+flKVeGtJHg5hivyy13QRmiq/y0jEgfXhe1JKNe6l+jt/69vb+WvwoLgWfbMwXMmkB/hzk3m649XwWypRvhkoP8lmAtktRB2cfTRsZ/daaRHDDXM1DFo9Hk1JA/Z60RD88JxaqqrjeFZxL96TRO/8h+NfWbmEY1H2Uu/p9cKAB1AT9ZEeUxSSpwwXFAFwnUrU0sn27YB+u7c6tbywjnziPnwRJpXfII1XfQ7R7OqlOT1iCZ2HChOxI2P+pEGUaT3ZZeY6UfGGdUzD3l2nKFS7z2OCrW/+OtEBUNKwhWYadkur3ba5AiyO4uXxGgsmkjyERQhWkZdkBBw2bfJtGBe7FnqrXnGHnBUjNuRQ==
X-Gm-Message-State: AOJu0YwoGT70HWqa6XDHYLAO02oKG+75SobIvOBfsslxSxwg2vOF4Rc4
	WciBDKPpPQ5bJa5vSRdRFTr9J4wgeUisMulpOjN3e8owPjXQyWE5yqJT7coIpQj/dqsURtV1UeQ
	7jjx4nDEmSZ3umhWkPPwXHHWUgTo=
X-Google-Smtp-Source: AGHT+IEp3mu4l6TxpPIgSy5ON+DTw2Y5KT1g44CuKguvUCwzRvHLGq4P1Xx0M12nRwSRT+SC4QrQwJIjwVzmPDzScwk=
X-Received: by 2002:a2e:9a9a:0:b0:2ef:307a:9988 with SMTP id
 38308e7fff4ca-2f3be600f1emr52119011fa.35.1723995878798; Sun, 18 Aug 2024
 08:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-4-almasrymina@google.com>
In-Reply-To: <20240813211317.3381180-4-almasrymina@google.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 19 Aug 2024 00:44:27 +0900
Message-ID: <CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:13=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
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
> that the given queue is bound, and the binding is actuated by resetting
> the rx queue using the queue API.
>
> The netdev_dmabuf_binding struct is refcounted, and releases its
> resources only when all the refs are released.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com> # excluding netlink
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> ---
>
> v19:
> - Prevent deactivating queues bound to mp (Jakub).
> - disable attaching xdp to memory provider netdev (Jakub).
> - Address various nits from Jakub.
> - In the netlink API, check for presence of queue_id, queue_type and
>   that the queue_type is RX (Jakub).
>
> v17:
> - Add missing kfree(owner) (Jakub)
> - Fix issue found by Taehee, where may access an rxq that has already
>   been freed if the driver has been unloaded in the meantime (thanks!)
>
> v16:
> - Fix rtnl_lock() not being acquired on unbind path (Reported by
>   Taehee).
> - Use unlocked versions of dma_buf_[un]map_attachment (Reported by
>   Taehee).
> - Use real_num_rx_queues instead of num_rx_queues (Taehee).
> - bound_rxq_list -> bound_rxqs (Jakub).
> - Removed READ_ONCE/WRITE_ONCE infavor of rtnl_lock() sync. (Jakub).
> - Use ERR_CAST instead of out param (Jakub).
> - Add NULL Check for kzalloc_node() call (Paolo).
> - Move genl_sk_priv_get, genlmsg_new, genlmsg_input outside of the lock
>   acquisition (Jakub).
> - Add netif_device_present() check (Jakub).
> - Use nla_for_each_attr_type(Jakub).
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
> v9: https://lore.kernel.org/all/20240403002053.2376017-5-almasrymina@goog=
le.com/
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
> - Removed dma_addr +=3D len (Paolo).
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
>  include/linux/netdevice.h               |   2 +
>  include/net/devmem.h                    | 115 +++++++++++
>  include/net/netdev_rx_queue.h           |   2 +
>  include/net/netmem.h                    |  10 +
>  include/net/page_pool/types.h           |   6 +
>  net/core/Makefile                       |   2 +-
>  net/core/dev.c                          |  22 ++
>  net/core/devmem.c                       | 262 ++++++++++++++++++++++++
>  net/core/netdev-genl-gen.c              |   4 +
>  net/core/netdev-genl-gen.h              |   4 +
>  net/core/netdev-genl.c                  | 117 ++++++++++-
>  net/ethtool/common.c                    |   9 +
>  13 files changed, 556 insertions(+), 3 deletions(-)
>  create mode 100644 include/net/devmem.h
>  create mode 100644 net/core/devmem.c
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 4930e8142aa6..0c747530c275 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -667,6 +667,10 @@ operations:
>            attributes:
>              - id
>
> +kernel-family:
> +  headers: [ "linux/list.h"]
> +  sock-priv: struct list_head
> +
>  mcast-groups:
>    list:
>      -
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0ef3eaa23f4b..1c92d6a6e1fc 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3920,6 +3920,8 @@ int bpf_xdp_link_attach(const union bpf_attr *attr,=
 struct bpf_prog *prog);
>  u8 dev_xdp_prog_count(struct net_device *dev);
>  u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
>
> +int dev_get_max_mp_channel(const struct net_device *dev);
> +
>  int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
>  int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
>  int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
> diff --git a/include/net/devmem.h b/include/net/devmem.h
> new file mode 100644
> index 000000000000..c7bd6a0a6b9e
> --- /dev/null
> +++ b/include/net/devmem.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Device memory TCP support
> + *
> + * Authors:    Mina Almasry <almasrymina@google.com>
> + *             Willem de Bruijn <willemb@google.com>
> + *             Kaiyuan Zhang <kaiyuanz@google.com>
> + *
> + */
> +#ifndef _NET_DEVMEM_H
> +#define _NET_DEVMEM_H
> +
> +struct net_devmem_dmabuf_binding {
> +       struct dma_buf *dmabuf;
> +       struct dma_buf_attachment *attachment;
> +       struct sg_table *sgt;
> +       struct net_device *dev;
> +       struct gen_pool *chunk_pool;
> +
> +       /* The user holds a ref (via the netlink API) for as long as they=
 want
> +        * the binding to remain alive. Each page pool using this binding=
 holds
> +        * a ref to keep the binding alive. Each allocated net_iov holds =
a
> +        * ref.
> +        *
> +        * The binding undos itself and unmaps the underlying dmabuf once=
 all
> +        * those refs are dropped and the binding is no longer desired or=
 in
> +        * use.
> +        */
> +       refcount_t ref;
> +
> +       /* The list of bindings currently active. Used for netlink to not=
ify us
> +        * of the user dropping the bind.
> +        */
> +       struct list_head list;
> +
> +       /* rxq's this binding is active on. */
> +       struct xarray bound_rxqs;
> +
> +       /* ID of this binding. Globally unique to all bindings currently
> +        * active.
> +        */
> +       u32 id;
> +};
> +
> +/* Owner of the dma-buf chunks inserted into the gen pool. Each scatterl=
ist
> + * entry from the dmabuf is inserted into the genpool as a chunk, and ne=
eds
> + * this owner struct to keep track of some metadata necessary to create
> + * allocations from this chunk.
> + */
> +struct dmabuf_genpool_chunk_owner {
> +       /* Offset into the dma-buf where this chunk starts.  */
> +       unsigned long base_virtual;
> +
> +       /* dma_addr of the start of the chunk.  */
> +       dma_addr_t base_dma_addr;
> +
> +       /* Array of net_iovs for this chunk. */
> +       struct net_iov *niovs;
> +       size_t num_niovs;
> +
> +       struct net_devmem_dmabuf_binding *binding;
> +};
> +
> +#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATO=
R)
> +void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *=
binding);
> +struct net_devmem_dmabuf_binding *
> +net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd);
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
> +int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +                                   struct net_devmem_dmabuf_binding *bin=
ding);
> +void dev_dmabuf_uninstall(struct net_device *dev);
> +#else
> +static inline void
> +__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *bindi=
ng)
> +{
> +}
> +
> +static inline struct net_devmem_dmabuf_binding *
> +net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void
> +net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +}
> +
> +static inline int
> +net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +                               struct net_devmem_dmabuf_binding *binding=
)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void dev_dmabuf_uninstall(struct net_device *dev)
> +{
> +}
> +#endif
> +
> +static inline void
> +net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
> +{
> +       refcount_inc(&binding->ref);
> +}
> +
> +static inline void
> +net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
> +{
> +       if (!refcount_dec_and_test(&binding->ref))
> +               return;
> +
> +       __net_devmem_dmabuf_binding_free(binding);
> +}
> +
> +#endif /* _NET_DEVMEM_H */
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.=
h
> index e78ca52d67fb..ac34f5fb4f71 100644
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
>          * Readers and writers must hold RTNL
>          */
>         struct napi_struct              *napi;
> +       struct pp_memory_provider_params mp_params;
>  } ____cacheline_aligned_in_smp;
>
>  /*
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 46cc9b89ac79..41e96c2f94b5 100644
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
> +       struct dmabuf_genpool_chunk_owner *owner;
> +};
> +
> +/* netmem */
> +
>  /**
>   * typedef netmem_ref - a nonexistent type marking a reference to generi=
c
>   * network memory.
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 50569fed7868..4afd6dd56351 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -139,6 +139,10 @@ struct page_pool_stats {
>   */
>  #define PAGE_POOL_FRAG_GROUP_ALIGN     (4 * sizeof(long))
>
> +struct pp_memory_provider_params {
> +       void *mp_priv;
> +};
> +
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> @@ -197,6 +201,8 @@ struct page_pool {
>          */
>         struct ptr_ring ring;
>
> +       void *mp_priv;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* recycle stats are per-cpu to avoid locking */
>         struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/Makefile b/net/core/Makefile
> index f82232b358a2..6b43611fb4a4 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -13,7 +13,7 @@ obj-y              +=3D dev.o dev_addr_lists.o dst.o ne=
tevent.o \
>                         neighbour.o rtnetlink.o utils.o link_watch.o filt=
er.o \
>                         sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
>                         fib_notifier.o xdp.o flow_offload.o gro.o \
> -                       netdev-genl.o netdev-genl-gen.o gso.o
> +                       netdev-genl.o netdev-genl-gen.o gso.o devmem.o
>
>  obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) +=3D dev_addr_lists_test.o
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 751d9b70e6ad..0a8caf0e4c77 100644
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
> @@ -9537,6 +9540,10 @@ static int dev_xdp_attach(struct net_device *dev, =
struct netlink_ext_ack *extack
>                         NL_SET_ERR_MSG(extack, "Native and generic XDP ca=
n't be active at the same time");
>                         return -EEXIST;
>                 }
> +               if (dev_get_max_mp_channel(dev) !=3D -1) {
> +                       NL_SET_ERR_MSG(extack, "XDP can't be installed on=
 a netdev using memory providers");
> +                       return -EINVAL;
> +               }

Should we consider virtual interfaces like bonding, bridge, etc?
Virtual interfaces as an upper interface of physical interfaces can
still install XDP prog.

# ip link add bond0 type bond
# ip link set eth0 master bond0
# ip link set bond0 xdp pin /sys/fs/bpf/x/y
and
# ip link set bond0 xdpgeneric pin /sys/fs/bpf/x/y

All virtual interfaces can install generic XDP prog.
The bonding interface can install native XDP prog.

>                 if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
>                         NL_SET_ERR_MSG(extack, "Using offloaded program w=
ithout HW_MODE flag is not supported");
>                         return -EINVAL;
> @@ -9821,6 +9828,20 @@ int dev_change_xdp_fd(struct net_device *dev, stru=
ct netlink_ext_ack *extack,
>         return err;
>  }
>
> +int dev_get_max_mp_channel(const struct net_device *dev)
> +{
> +       int i, max =3D -1;
> +
> +       ASSERT_RTNL();
> +
> +       for (i =3D 0; i < dev->real_num_rx_queues; i++)
> +               if (dev->_rx[i].mp_params.mp_priv)
> +                       /* The number of queues is the idx plus 1. */
> +                       max =3D i + 1;
> +
> +       return max;
> +}
> +
>  /**
>   * dev_index_reserve() - allocate an ifindex in a namespace
>   * @net: the applicable net namespace
> @@ -11335,6 +11356,7 @@ void unregister_netdevice_many_notify(struct list=
_head *head,
>                 dev_tcx_uninstall(dev);
>                 dev_xdp_uninstall(dev);
>                 bpf_dev_bound_netdev_unregister(dev);
> +               dev_dmabuf_uninstall(dev);
>
>                 netdev_offload_xstats_disable_all(dev);
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> new file mode 100644
> index 000000000000..1b693424c17d
> --- /dev/null
> +++ b/net/core/devmem.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *      Devmem TCP
> + *
> + *      Authors:       Mina Almasry <almasrymina@google.com>
> + *                     Willem de Bruijn <willemdebruijn.kernel@gmail.com=
>
> + *                     Kaiyuan Zhang <kaiyuanz@google.com
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
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
> +#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATO=
R)
> +static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
> +                                              struct gen_pool_chunk *chu=
nk,
> +                                              void *not_used)
> +{
> +       struct dmabuf_genpool_chunk_owner *owner =3D chunk->owner;
> +
> +       kvfree(owner->niovs);
> +       kfree(owner);
> +}
> +
> +void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *=
binding)
> +{
> +       size_t size, avail;
> +
> +       gen_pool_for_each_chunk(binding->chunk_pool,
> +                               net_devmem_dmabuf_free_chunk_owner, NULL)=
;
> +
> +       size =3D gen_pool_size(binding->chunk_pool);
> +       avail =3D gen_pool_avail(binding->chunk_pool);
> +
> +       if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%zu, av=
ail=3D%zu",
> +                 size, avail))
> +               gen_pool_destroy(binding->chunk_pool);
> +
> +       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->s=
gt,
> +                                         DMA_FROM_DEVICE);
> +       dma_buf_detach(binding->dmabuf, binding->attachment);
> +       dma_buf_put(binding->dmabuf);
> +       xa_destroy(&binding->bound_rxqs);
> +       kfree(binding);
> +}
> +
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +       struct netdev_rx_queue *rxq;
> +       unsigned long xa_idx;
> +       unsigned int rxq_idx;
> +
> +       if (binding->list.next)
> +               list_del(&binding->list);
> +
> +       xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
> +               if (rxq->mp_params.mp_priv =3D=3D binding) {
> +                       rxq->mp_params.mp_priv =3D NULL;
> +
> +                       rxq_idx =3D get_netdev_rx_queue_index(rxq);
> +
> +                       WARN_ON(netdev_rx_queue_restart(binding->dev, rxq=
_idx));
> +               }
> +       }
> +
> +       xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +
> +       net_devmem_dmabuf_binding_put(binding);
> +}
> +
> +int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +                                   struct net_devmem_dmabuf_binding *bin=
ding)
> +{
> +       struct netdev_rx_queue *rxq;
> +       u32 xa_idx;
> +       int err;
> +
> +       if (rxq_idx >=3D dev->real_num_rx_queues)
> +               return -ERANGE;
> +
> +       rxq =3D __netif_get_rx_queue(dev, rxq_idx);
> +       if (rxq->mp_params.mp_priv)
> +               return -EEXIST;
> +
> +       if (dev_xdp_prog_count(dev))
> +               return -EEXIST;
> +
> +       err =3D xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b=
,
> +                      GFP_KERNEL);
> +       if (err)
> +               return err;
> +
> +       rxq->mp_params.mp_priv =3D binding;
> +
> +       err =3D netdev_rx_queue_restart(dev, rxq_idx);
> +       if (err)
> +               goto err_xa_erase;
> +
> +       return 0;
> +
> +err_xa_erase:
> +       rxq->mp_params.mp_priv =3D NULL;
> +       xa_erase(&binding->bound_rxqs, xa_idx);
> +
> +       return err;
> +}
> +
> +struct net_devmem_dmabuf_binding *net_devmem_bind_dmabuf(struct net_devi=
ce *dev,
> +                                                        unsigned int dma=
buf_fd)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       static u32 id_alloc_next;
> +       struct scatterlist *sg;
> +       struct dma_buf *dmabuf;
> +       unsigned int sg_idx, i;
> +       unsigned long virtual;
> +       int err;
> +
> +       dmabuf =3D dma_buf_get(dmabuf_fd);
> +       if (IS_ERR(dmabuf))
> +               return ERR_CAST(dmabuf);
> +
> +       binding =3D kzalloc_node(sizeof(*binding), GFP_KERNEL,
> +                              dev_to_node(&dev->dev));
> +       if (!binding) {
> +               err =3D -ENOMEM;
> +               goto err_put_dmabuf;
> +       }
> +
> +       binding->dev =3D dev;
> +
> +       err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
> +                             binding, xa_limit_32b, &id_alloc_next,
> +                             GFP_KERNEL);
> +       if (err < 0)
> +               goto err_free_binding;
> +
> +       xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> +
> +       refcount_set(&binding->ref, 1);
> +
> +       binding->dmabuf =3D dmabuf;
> +
> +       binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.=
parent);
> +       if (IS_ERR(binding->attachment)) {
> +               err =3D PTR_ERR(binding->attachment);
> +               goto err_free_id;
> +       }
> +
> +       binding->sgt =3D dma_buf_map_attachment_unlocked(binding->attachm=
ent,
> +                                                      DMA_FROM_DEVICE);
> +       if (IS_ERR(binding->sgt)) {
> +               err =3D PTR_ERR(binding->sgt);
> +               goto err_detach;
> +       }
> +
> +       /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> +        * binding can be much more flexible than that. We may be able to
> +        * allocate MTU sized chunks here. Leave that for future work...
> +        */
> +       binding->chunk_pool =3D
> +               gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> +       if (!binding->chunk_pool) {
> +               err =3D -ENOMEM;
> +               goto err_unmap;
> +       }
> +
> +       virtual =3D 0;
> +       for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
> +               dma_addr_t dma_addr =3D sg_dma_address(sg);
> +               struct dmabuf_genpool_chunk_owner *owner;
> +               size_t len =3D sg_dma_len(sg);
> +               struct net_iov *niov;
> +
> +               owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> +                                    dev_to_node(&dev->dev));
> +               if (!owner) {
> +                       err =3D -ENOMEM;
> +                       goto err_free_chunks;
> +               }
> +
> +               owner->base_virtual =3D virtual;
> +               owner->base_dma_addr =3D dma_addr;
> +               owner->num_niovs =3D len / PAGE_SIZE;
> +               owner->binding =3D binding;
> +
> +               err =3D gen_pool_add_owner(binding->chunk_pool, dma_addr,
> +                                        dma_addr, len, dev_to_node(&dev-=
>dev),
> +                                        owner);
> +               if (err) {
> +                       kfree(owner);
> +                       err =3D -EINVAL;
> +                       goto err_free_chunks;
> +               }
> +
> +               owner->niovs =3D kvmalloc_array(owner->num_niovs,
> +                                             sizeof(*owner->niovs),
> +                                             GFP_KERNEL);
> +               if (!owner->niovs) {
> +                       err =3D -ENOMEM;
> +                       goto err_free_chunks;
> +               }
> +
> +               for (i =3D 0; i < owner->num_niovs; i++) {
> +                       niov =3D &owner->niovs[i];
> +                       niov->owner =3D owner;
> +               }
> +
> +               virtual +=3D len;
> +       }
> +
> +       return binding;
> +
> +err_free_chunks:
> +       gen_pool_for_each_chunk(binding->chunk_pool,
> +                               net_devmem_dmabuf_free_chunk_owner, NULL)=
;
> +       gen_pool_destroy(binding->chunk_pool);
> +err_unmap:
> +       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->s=
gt,
> +                                         DMA_FROM_DEVICE);
> +err_detach:
> +       dma_buf_detach(dmabuf, binding->attachment);
> +err_free_id:
> +       xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +err_free_binding:
> +       kfree(binding);
> +err_put_dmabuf:
> +       dma_buf_put(dmabuf);
> +       return ERR_PTR(err);
> +}
> +
> +void dev_dmabuf_uninstall(struct net_device *dev)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct netdev_rx_queue *rxq;
> +       unsigned long xa_idx;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < dev->real_num_rx_queues; i++) {
> +               binding =3D dev->_rx[i].mp_params.mp_priv;
> +               if (!binding)
> +                       continue;
> +
> +               xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
> +                       if (rxq =3D=3D &dev->_rx[i])
> +                               xa_erase(&binding->bound_rxqs, xa_idx);
> +       }
> +}
> +#endif
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 6b7fe6035067..b28424ae06d5 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -9,6 +9,7 @@
>  #include "netdev-genl-gen.h"
>
>  #include <uapi/linux/netdev.h>
> +#include <linux/list.h>
>
>  /* Integer value ranges */
>  static const struct netlink_range_validation netdev_a_page_pool_id_range=
 =3D {
> @@ -187,4 +188,7 @@ struct genl_family netdev_nl_family __ro_after_init =
=3D {
>         .n_split_ops    =3D ARRAY_SIZE(netdev_nl_ops),
>         .mcgrps         =3D netdev_nl_mcgrps,
>         .n_mcgrps       =3D ARRAY_SIZE(netdev_nl_mcgrps),
> +       .sock_priv_size =3D sizeof(struct list_head),
> +       .sock_priv_init =3D (void *)netdev_nl_sock_priv_init,
> +       .sock_priv_destroy =3D (void *)netdev_nl_sock_priv_destroy,
>  };
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index 67c34005750c..8cda334fd042 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -10,6 +10,7 @@
>  #include <net/genetlink.h>
>
>  #include <uapi/linux/netdev.h>
> +#include <linux/list.h>
>
>  /* Common nested types */
>  extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_=
PAGE_POOL_IFINDEX + 1];
> @@ -40,4 +41,7 @@ enum {
>
>  extern struct genl_family netdev_nl_family;
>
> +void netdev_nl_sock_priv_init(struct list_head *priv);
> +void netdev_nl_sock_priv_destroy(struct list_head *priv);
> +
>  #endif /* _LINUX_NETDEV_GEN_H */
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 2d726e65211d..88017ee22d2f 100644
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
> @@ -721,10 +722,122 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *sk=
b,
>         return err;
>  }
>
> -/* Stub */
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -       return 0;
> +       struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct list_head *sock_binding_list;
> +       u32 ifindex, dmabuf_fd, rxq_idx;
> +       struct net_device *netdev;
> +       struct sk_buff *rsp;
> +       struct nlattr *attr;
> +       int rem, err =3D 0;
> +       void *hdr;
> +
> +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +           GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD) ||
> +           GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_QUEUES))
> +               return -EINVAL;
> +
> +       ifindex =3D nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +       dmabuf_fd =3D nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
> +
> +       sock_binding_list =3D genl_sk_priv_get(&netdev_nl_family,
> +                                            NETLINK_CB(skb).sk);
> +       if (IS_ERR(sock_binding_list))
> +               return PTR_ERR(sock_binding_list);
> +
> +       rsp =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +       if (!rsp)
> +               return -ENOMEM;
> +
> +       hdr =3D genlmsg_iput(rsp, info);
> +       if (!hdr) {
> +               err =3D -EMSGSIZE;
> +               goto err_genlmsg_free;
> +       }
> +
> +       rtnl_lock();
> +
> +       netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> +       if (!netdev || !netif_device_present(netdev)) {
> +               err =3D -ENODEV;
> +               goto err_unlock;
> +       }
> +
> +       binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd);
> +       if (IS_ERR(binding)) {
> +               err =3D PTR_ERR(binding);
> +               goto err_unlock;
> +       }
> +
> +       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> +                              genlmsg_data(info->genlhdr),
> +                              genlmsg_len(info->genlhdr), rem) {
> +               err =3D nla_parse_nested(
> +                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, at=
tr,
> +                       netdev_queue_id_nl_policy, info->extack);
> +               if (err < 0)
> +                       goto err_unbind;
> +
> +               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb,
> +                                     NETDEV_A_QUEUE_ID)) {
> +                       err =3D -EINVAL;
> +                       goto err_unlock;
> +               }
> +
> +               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb,
> +                                     NETDEV_A_QUEUE_TYPE)) {
> +                       err =3D -EINVAL;
> +                       goto err_unlock;
> +               }
> +
> +               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D
> +                   NETDEV_QUEUE_TYPE_RX) {
> +                       err =3D -EINVAL;
> +                       goto err_unlock;
> +               }
> +
> +               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> +
> +               err =3D net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, =
binding);
> +               if (err)
> +                       goto err_unbind;
> +       }
> +
> +       list_add(&binding->list, sock_binding_list);
> +
> +       rtnl_unlock();
> +
> +       nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +       genlmsg_end(rsp, hdr);
> +
> +       return genlmsg_reply(rsp, info);
> +
> +err_unbind:
> +       net_devmem_unbind_dmabuf(binding);
> +err_unlock:
> +       rtnl_unlock();
> +err_genlmsg_free:
> +       nlmsg_free(rsp);
> +       return err;
> +}
> +
> +void netdev_nl_sock_priv_init(struct list_head *priv)
> +{
> +       INIT_LIST_HEAD(priv);
> +}
> +
> +void netdev_nl_sock_priv_destroy(struct list_head *priv)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct net_devmem_dmabuf_binding *temp;
> +
> +       list_for_each_entry_safe(binding, temp, priv, list) {
> +               rtnl_lock();
> +               net_devmem_unbind_dmabuf(binding);
> +               rtnl_unlock();
> +       }
>  }
>
>  static int netdev_genl_netdevice_event(struct notifier_block *nb,
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 7257ae272296..84c63113951c 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -5,6 +5,7 @@
>  #include <linux/phy.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/ptp_clock_kernel.h>
> +#include <net/netdev_rx_queue.h>
>
>  #include "netlink.h"
>  #include "common.h"
> @@ -657,6 +658,7 @@ int ethtool_check_max_channel(struct net_device *dev,
>  {
>         u64 max_rxnfc_in_use;
>         u32 max_rxfh_in_use;
> +       int max_mp_in_use;
>
>         /* ensure the new Rx count fits within the configured Rx flow
>          * indirection table/rxnfc settings
> @@ -675,6 +677,13 @@ int ethtool_check_max_channel(struct net_device *dev=
,
>                 return -EINVAL;
>         }
>
> +       max_mp_in_use =3D dev_get_max_mp_channel(dev);
> +       if (channels.combined_count + channels.rx_count <=3D max_mp_in_us=
e) {
> +               if (info)
> +                       GENL_SET_ERR_MSG_FMT(info, "requested channel cou=
nts are too low for existing memory provider setting (%d)", max_mp_in_use);
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.46.0.76.ge559c4bf1a-goog
>

