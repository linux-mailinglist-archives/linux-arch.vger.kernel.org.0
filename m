Return-Path: <linux-arch+bounces-5273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181DC927CB0
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7731C23744
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FA50A63;
	Thu,  4 Jul 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+qJ4lqz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CF39FC1;
	Thu,  4 Jul 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115835; cv=none; b=C5I2W/MCr/jv2wk3x9Z9ijkmBWaoHnFp6NzL6ApqDD9C3iQ0Inadkr+orHmhJNhfmPSrkP7pEeqgIiPsjqZG9MfUypHnoMe6wavSXRF6LeALMn7Kf9dPydV7pTZRUNffL5kh7oOqW662XyY/ptKgWBOaQkeSq1BK5ZAkdV7Ah1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115835; c=relaxed/simple;
	bh=em2+9v81jfkCr+sHI2TqSKe+25i7mx1g+7vDipuDZdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2Qe8+77HpcPFIp1P1h5ZKE9Z/sEageGKuXwOH9aWICdYl2AmiG3iTvGPZ3dpnjl4eg5ZaLXGOAuItKS5cZ9d72C6nXEBDyR35wybftlsP7LUprP5K/sgdLM7dCjFeWrn0WKqWoyyjKMc0XlvkrKIS/fenk1hp5ewi8LT3Bwhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+qJ4lqz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a725041ad74so34264066b.3;
        Thu, 04 Jul 2024 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115831; x=1720720631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdOzZnX58+GV0gn1qdGhM5tdqpEZkdc26pte1KuNfDA=;
        b=X+qJ4lqz29wQmos0K2pzqdOLl77SFPeAd4qzBE+FHtDB6bUA+yc5i2zukxTyG+U0Ug
         Y36QxLfmI0gujqhqn3Xgj86xhCEdI1NssgVIZWKhAtXSihWosXdlH3H2plcGRbZa8BuP
         FX+Snm+zDkh0tD1UbYd0L9rmvkJahuIigy8sZk9IoezA0RcpoeV6/5xRUlqMPV47s1X4
         Ctuja5D4fZW4FDNTusN5R49MXAf1H0NlOSG3EvUkoeH+2pPcA441DCd2zuPf/ewfnG4X
         S0JOFc5I++F9dSiJN+VaWLGTOjWPsqKOecsRR8Yu3tU0LVrJeLYnJfscGQtsoNInSc44
         nvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115831; x=1720720631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdOzZnX58+GV0gn1qdGhM5tdqpEZkdc26pte1KuNfDA=;
        b=dbcztIRQC8QnRR6Ul0gB86+cIPnHoCxqnn9T11MjL8m3cATaanSEN3yeh9bCMlRVdz
         DBgkBU/V7SU6s7evILwuJes8UM8pgWKIL8VCxcBRvbFvA3/yVxQBBS993/I/5kw8tDRW
         NANEL5tEa2g/gmVvetZ+WIHzrUDzUJZAtZ42eOKGeC+gGpmlysgIz8UVoXCX+AOujRaP
         zpjz92GGjFoe3bY4rTVd6Q1gffXMuC0nHo+SFfIVrNr4kiTugnvx7A3vWKK8TFKhAa0D
         b+HTSxykbh95qkAm/hAClgPyg3bCqGWvq+M9bcYBCowegJ8IxrJEAfRKhlgegqCuFrHY
         3aSw==
X-Forwarded-Encrypted: i=1; AJvYcCViH4+IflcWO9oTEZaBMPB84h7YvFj5yXYV4B3WsZPgtgRA3VJKx+2GEkP/gmb/2xGftVP0I+43Xq+O8LpM8Jy3mPVIEUFVXrtx5e1FOPg2PC0cp1xtw85pCPsa5Y9LsIY9WCclKc1cgr3JB+eqmEGvvSL0JyMbJdiprYFb1wo9EukwudFrYw3DlKZiMZV5jJdSVbfq9RUqBni7xNnFnmSezS+uPFCTZmNmpHO0HwbTGmI5j0J2Gm6LrNpTUdIsF4A6zfHRNwMBszyaOxbEMfirlznRmuzr681HVXGyrmu5bewZLdhAGOo7638grjRRi4bNO0zrUPWE+KmeZphrrYdeKyR1k75VBJAjyY0ykaSJQb6IiWNWiVfh/ARLYTUgRIhustFrTFR3QGT64CzNDAn2QRq69hzNrcvqPeaK7xU5bdaZWRoICih3FOQT/TMa52KmGhXxFirbNqbCKHnjkqSMeILnWGR15BYeu2UWAQ==
X-Gm-Message-State: AOJu0YyUVxrr6UFert0xKOuvu8qTmRK6fhYvZKgAtKMsixF72MKL5Rrg
	b4exhWkepjCQWhaXyFuYXYa/pKYQDkafjc6XFDbwTjIJzygG+kxDfXlS0z05kDRkc0bMyd6CuMK
	O0uhouRSogUCoZVdfiARp/3NekdQ=
X-Google-Smtp-Source: AGHT+IHq9EsieKUMhL+pliJNam8UFdmk8wjP+efYVxlla6Ealo/oblur3b9ZQ9qHTteJ5VRHdEgyfqJQZQ2Wgb+AvxI=
X-Received: by 2002:a05:6402:354b:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-58e5994de19mr2777264a12.3.1720115830207; Thu, 04 Jul 2024
 10:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com> <20240628003253.1694510-4-almasrymina@google.com>
In-Reply-To: <20240628003253.1694510-4-almasrymina@google.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 5 Jul 2024 02:56:58 +0900
Message-ID: <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 9:43=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,

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
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
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
> +       struct xarray bound_rxq_list;
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
> +int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_f=
d,
> +                          struct net_devmem_dmabuf_binding **out);
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
> +int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +                                   struct net_devmem_dmabuf_binding *bin=
ding);
> +#else
> +static inline void
> +__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *bindi=
ng)
> +{
> +}
> +
> +static inline int net_devmem_bind_dmabuf(struct net_device *dev,
> +                                        unsigned int dmabuf_fd,
> +                                        struct net_devmem_dmabuf_binding=
 **out)
> +{
> +       return -EOPNOTSUPP;
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
>          * Readers and writers must hold RTNL
>          */
>         struct napi_struct              *napi;
> +       struct pp_memory_provider_params mp_params;
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
> index 7e8477057f3d1..9f3c3ee2ee755 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -128,6 +128,10 @@ struct page_pool_stats {
>  };
>  #endif
>
> +struct pp_memory_provider_params {
> +       void *mp_priv;
> +};
> +
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> @@ -194,6 +198,8 @@ struct page_pool {
>          */
>         struct ptr_ring ring;
>
> +       void *mp_priv;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* recycle stats are per-cpu to avoid locking */
>         struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/Makefile b/net/core/Makefile
> index f82232b358a2c..6b43611fb4a43 100644
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
> index 0a23d7da7fbc6..5e5e2d266b83f 100644
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
> +       dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> +                                DMA_FROM_DEVICE);
> +       dma_buf_detach(binding->dmabuf, binding->attachment);
> +       dma_buf_put(binding->dmabuf);
> +       xa_destroy(&binding->bound_rxq_list);
> +       kfree(binding);
> +}
> +
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +       struct netdev_rx_queue *rxq;
> +       unsigned long xa_idx;
> +       unsigned int rxq_idx;
> +
> +       if (!binding)
> +               return;
> +
> +       if (binding->list.next)
> +               list_del(&binding->list);
> +
> +       xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> +               if (rxq->mp_params.mp_priv =3D=3D binding) {
> +                       /* We hold the rtnl_lock while binding/unbinding
> +                        * dma-buf, so we can't race with another thread =
that
> +                        * is also modifying this value. However, the pag=
e_pool
> +                        * may read this config while it's creating its
> +                        * rx-queues. WRITE_ONCE() here to match the
> +                        * READ_ONCE() in the page_pool.
> +                        */
> +                       WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
> +
> +                       rxq_idx =3D get_netdev_rx_queue_index(rxq);
> +
> +                       netdev_rx_queue_restart(binding->dev, rxq_idx);
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
> +       if (rxq_idx >=3D dev->num_rx_queues)
> +               return -ERANGE;
> +
> +       rxq =3D __netif_get_rx_queue(dev, rxq_idx);
> +       if (rxq->mp_params.mp_priv)
> +               return -EEXIST;
> +
> +       err =3D xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_limit=
_32b,
> +                      GFP_KERNEL);
> +       if (err)
> +               return err;
> +
> +       /* We hold the rtnl_lock while binding/unbinding dma-buf, so we c=
an't
> +        * race with another thread that is also modifying this value. Ho=
wever,
> +        * the driver may read this config while it's creating its * rx-q=
ueues.
> +        * WRITE_ONCE() here to match the READ_ONCE() in the driver.
> +        */
> +       WRITE_ONCE(rxq->mp_params.mp_priv, binding);
> +
> +       err =3D netdev_rx_queue_restart(dev, rxq_idx);
> +       if (err)
> +               goto err_xa_erase;
> +
> +       return 0;
> +
> +err_xa_erase:
> +       WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
> +       xa_erase(&binding->bound_rxq_list, xa_idx);
> +
> +       return err;
> +}
> +
> +int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_f=
d,
> +                          struct net_devmem_dmabuf_binding **out)
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
> +               return -EBADFD;
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
> +       xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
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
> +       binding->sgt =3D
> +               dma_buf_map_attachment(binding->attachment, DMA_FROM_DEVI=
CE);
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
> +       *out =3D binding;
> +
> +       return 0;
> +
> +err_free_chunks:
> +       gen_pool_for_each_chunk(binding->chunk_pool,
> +                               net_devmem_dmabuf_free_chunk_owner, NULL)=
;
> +       gen_pool_destroy(binding->chunk_pool);
> +err_unmap:
> +       dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> +                                DMA_FROM_DEVICE);
> +err_detach:
> +       dma_buf_detach(dmabuf, binding->attachment);
> +err_free_id:
> +       xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +err_free_binding:
> +       kfree(binding);
> +err_put_dmabuf:
> +       dma_buf_put(dmabuf);
> +       return err;
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
> @@ -721,10 +722,92 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb=
,
>         return err;
>  }
>
> -/* Stub */
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -       return 0;
> +       struct nlattr *tb[ARRAY_SIZE(netdev_queue_dmabuf_nl_policy)];
> +       struct net_devmem_dmabuf_binding *out_binding;
> +       struct list_head *sock_binding_list;
> +       u32 ifindex, dmabuf_fd, rxq_idx;
> +       struct net_device *netdev;
> +       struct sk_buff *rsp;
> +       struct nlattr *attr;
> +       int rem, err =3D 0;
> +       void *hdr;
> +
> +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +           GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_DMABUF_FD) ||
> +           GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_QUEUES))
> +               return -EINVAL;
> +
> +       ifindex =3D nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +       dmabuf_fd =3D nla_get_u32(info->attrs[NETDEV_A_BIND_DMABUF_DMABUF=
_FD]);
> +
> +       rtnl_lock();
> +
> +       netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> +       if (!netdev) {
> +               err =3D -ENODEV;
> +               goto err_unlock;
> +       }
> +
> +       err =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, &out_binding);
> +       if (err)
> +               goto err_unlock;
> +
> +       nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
> +                         genlmsg_len(info->genlhdr), rem) {
> +               if (nla_type(attr) !=3D NETDEV_A_BIND_DMABUF_QUEUES)
> +                       continue;
> +
> +               err =3D nla_parse_nested(
> +                       tb, ARRAY_SIZE(netdev_queue_dmabuf_nl_policy) - 1=
, attr,
> +                       netdev_queue_dmabuf_nl_policy, info->extack);
> +               if (err < 0)
> +                       goto err_unbind;
> +
> +               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_DMABUF_IDX]);
> +
> +               err =3D net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx,
> +                                                     out_binding);
> +               if (err)
> +                       goto err_unbind;
> +       }
> +
> +       sock_binding_list =3D genl_sk_priv_get(&netdev_nl_family,
> +                                            NETLINK_CB(skb).sk);
> +       if (IS_ERR(sock_binding_list)) {
> +               err =3D PTR_ERR(sock_binding_list);
> +               goto err_unbind;
> +       }
> +
> +       list_add(&out_binding->list, sock_binding_list);
> +
> +       rsp =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +       if (!rsp) {
> +               err =3D -ENOMEM;
> +               goto err_unbind;
> +       }
> +
> +       hdr =3D genlmsg_iput(rsp, info);
> +       if (!hdr) {
> +               err =3D -EMSGSIZE;
> +               goto err_genlmsg_free;
> +       }
> +
> +       nla_put_u32(rsp, NETDEV_A_BIND_DMABUF_DMABUF_ID, out_binding->id)=
;
> +       genlmsg_end(rsp, hdr);
> +
> +       rtnl_unlock();
> +
> +       return genlmsg_reply(rsp, info);
> +
> +err_genlmsg_free:
> +       nlmsg_free(rsp);
> +err_unbind:
> +       net_devmem_unbind_dmabuf(out_binding);
> +err_unlock:
> +       rtnl_unlock();
> +       return err;
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
> +       INIT_LIST_HEAD(priv);
> +}
> +
> +void netdev_nl_sock_priv_destroy(struct list_head *priv)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct net_devmem_dmabuf_binding *temp;
> +
> +       list_for_each_entry_safe(binding, temp, priv, list)
> +               net_devmem_unbind_dmabuf(binding);
> +}
> --
> 2.45.2.803.g4e1b14247a-goog
>
>

I found several locking warnings while testing.

[ 1135.125874] WARNING: CPU: 1 PID: 1644 at
drivers/dma-buf/dma-buf.c:1123 dma_buf_map_attachment+0x164/0x2f0
[ 1135.136255] Modules linked in: 8021q garp mrp xt_nat xt_tcpudp veth
xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf
_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xt_addrtype nft_compat nf_tables br_netfilter bri
dge stp llc qrtr crct10dif_pclmul overlay crc32_generic crc32_pclmul
crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256
_ssse3 sha1_ssse3 xts amdgpu cts wmi_bmof aesni_intel amdxcp
i2c_algo_bit crypto_simd drm_ttm_helper cryptd ttm drm_exec
bnxt_en ionic gpu_sched drm_suballoc_helper drm_buddy ptp video
drm_display_helper drm_kms_helper wmi cfg80211 drm drm_pa
nel_orientation_quirks backlight nfnetlink bpf_preload ip_tables x_tables
[ 1135.196164] CPU: 1 PID: 1644 Comm: ncdevmem Not tainted 6.10.0-rc5+
#43 6e089cf25edb5a71cabb8ab97c9dfbf7e96b1a3a
[ 1135.207060] Hardware name: ASUS System Product Name/PRIME Z690-P
D4, BIOS 0603 11/01/2021
[ 1135.215959] RIP: 0010:dma_buf_map_attachment+0x164/0x2f0
[ 1135.221996] Code: ea 03 80 3c 02 00 0f 85 4e 01 00 00 49 8b bc 24
b8 00 00 00 be ff ff ff ff 48 83 c7 70 e8 54 e6 e2 0
0 85 c0 0f 85 32 ff ff ff <0f> 0b e9 2b ff ff ff 89 ee 48 89 df e8 6b
f1 ff ff 48 85 c0 0f 84
[ 1135.241464] RSP: 0018:ffff888224c2f5d0 EFLAGS: 00010246
[ 1135.247409] RAX: 0000000000000000 RBX: ffff88821dcc65f0 RCX: 00000000000=
00001
[ 1135.255259] RDX: 0000000000000001 RSI: ffffffff86abed00 RDI: ffffffff86d=
56be0
[ 1135.263109] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed10449=
85ea0
[ 1135.270960] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88812da=
88400
[ 1135.278808] R13: ffff88821dcc65f0 R14: ffff888224c2f838 R15: 00000000000=
00005
[ 1135.286650] FS: 00007fe9b77b4740(0000) GS:ffff88881b200000(0000)
knlGS:0000000000000000
[ 1135.295447] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1135.301912] CR2: 0000556a6a61f870 CR3: 00000001094a0000 CR4: 00000000007=
506f0
[ 1135.309893] PKRU: 55555554
[ 1135.313321] Call Trace:
[ 1135.316486] <TASK>
[ 1135.319307] ? __warn+0xc8/0x2f0
[ 1135.323290] ? dma_buf_map_attachment+0x164/0x2f0
[ 1135.328907] ? report_bug+0x326/0x3c0
[ 1135.333368] ? handle_bug+0x3c/0x70
[ 1135.337568] ? exc_invalid_op+0x14/0x50
[ 1135.342202] ? asm_exc_invalid_op+0x16/0x20
[ 1135.347134] ? dma_buf_map_attachment+0x164/0x2f0
[ 1135.352686] net_devmem_bind_dmabuf+0x2af/0xab0
[ 1135.357940] ? __nla_validate_parse+0x109e/0x2830
[ 1135.363430] netdev_nl_bind_rx_doit+0x26f/0xe00
[ 1135.368675] ? __pfx___nla_validate_parse+0x10/0x10
[ 1135.374333] ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
[ 1135.380094] ? trace_kmalloc+0x2d/0xd0
[ 1135.384637] ? __kmalloc_noprof+0x1f5/0x430 [ 1135.389539] ?
__pfx_mark_lock.part.0+0x10/0x10
[ 1135.394851] ? __nla_parse+0x22/0x30
[ 1135.399139] ? genl_family_rcv_msg_attrs_parse.constprop.0+0x162/0x240
[ 1135.406403] genl_family_rcv_msg_doit+0x1d4/0x2b0
[ 1135.411872] ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[ 1135.417892] genl_rcv_msg+0x3fb/0x6c0



[ 1136.178258] WARNING: CPU: 1 PID: 1644 at
drivers/dma-buf/dma-buf.c:1226 dma_buf_unmap_attachment+0x267/0x320
[ 1136.188842] Modules linked in: 8021q garp mrp xt_nat xt_tcpudp veth
xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf
_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xt_addrtype nft_compat nf_tables br_netfilter bri
dge stp llc qrtr crct10dif_pclmul overlay crc32_generic crc32_pclmul
crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256
_ssse3 sha1_ssse3 xts amdgpu cts wmi_bmof aesni_intel amdxcp
i2c_algo_bit crypto_simd drm_ttm_helper cryptd ttm drm_exec
bnxt_en ionic gpu_sched drm_suballoc_helper drm_buddy ptp video
drm_display_helper drm_kms_helper wmi cfg80211 drm drm_pa
nel_orientation_quirks backlight nfnetlink bpf_preload ip_tables x_tables
[ 1136.248891] CPU: 1 PID: 1644 Comm: ncdevmem Tainted: G W
6.10.0-rc5+ #43 6e089cf25edb5a71cabb8ab97c9dfbf7e96b1a3a
[ 1136.261273] Hardware name: ASUS System Product Name/PRIME Z690-P
D4, BIOS 0603 11/01/2021
[ 1136.270266] RIP: 0010:dma_buf_unmap_attachment+0x267/0x320
[ 1136.276468] Code: c1 ea 03 80 3c 02 00 0f 85 c1 00 00 00 48 8b bb
b8 00 00 00 be ff ff ff ff 48 83 c7 70 e8 11 e1 e2 0
0 85 c0 0f 85 42 fe ff ff <0f> 0b e9 3b fe ff ff 48 89 cf 4c 89 44 24
10 e8 35 c8 21 ff 4c 8b
[ 1136.295967] RSP: 0018:ffff888224c2fb78 EFLAGS: 00010246
[ 1136.301930] RAX: 0000000000000000 RBX: ffff88812da88400 RCX: 00000000000=
00001
[ 1136.309804] RDX: 0000000000000001 RSI: ffffffff86abed00 RDI: ffffffff86d=
56be0
[ 1136.317810] RBP: ffff88810908e250 R08: 0000000000000001 R09: fffffbfff21=
514d8
[ 1136.325670] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88821dc=
c65f0
[ 1136.333608] R13: 0000000000010000 R14: ffffed102265e337 R15: 1ffff110449=
85f81
[ 1136.341462] FS: 00007fe9b77b4740(0000) GS:ffff88881b200000(0000)
knlGS:0000000000000000
[ 1136.350278] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1136.356766] CR2: 000055dec9867ba0 CR3: 00000001094a0000 CR4: 00000000007=
506f0
[ 1136.364640] PKRU: 55555554
[ 1136.368172] Call Trace:
[ 1136.371373] <TASK>
[ 1136.374275] ? __warn+0xc8/0x2f0
[ 1136.378230] ? dma_buf_unmap_attachment+0x267/0x320
[ 1136.383855] ? report_bug+0x326/0x3c0
[ 1136.388324] ? handle_bug+0x3c/0x70
[ 1136.392549] ? exc_invalid_op+0x14/0x50
[ 1136.397126] ? asm_exc_invalid_op+0x16/0x20
[ 1136.402126] ? dma_buf_unmap_attachment+0x267/0x320
[ 1136.407727] ? dma_buf_unmap_attachment+0x25f/0x320
[ 1136.413344] __net_devmem_dmabuf_binding_free+0x10a/0x220
[ 1136.419728] net_devmem_unbind_dmabuf+0x349/0x440
[ 1136.425146] ? __pfx_lock_release+0x10/0x10
[ 1136.430080] ? __pfx_net_devmem_unbind_dmabuf+0x10/0x10
[ 1136.436106] netdev_nl_sock_priv_destroy+0x72/0xc0
[ 1136.441611] genl_release+0xed/0x190
[ 1136.445921] ? __pfx_genl_release+0x10/0x10
[ 1136.450823] ? mark_held_locks+0xa5/0xf0
[ 1136.455490] ? __local_bh_enable_ip+0xa5/0x120
[ 1136.460790] ? __pfx_genl_release+0x10/0x10
[ 1136.465703] netlink_release+0x839/0x18f0



[ 1135.709313] WARNING: CPU: 3 PID: 1644 at
net/core/netdev_rx_queue.c:18 netdev_rx_queue_restart+0x3f4/0x5a0
[ 1135.719686] Modules linked in: 8021q garp mrp xt_nat xt_tcpudp veth
xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf
_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xt_addrtype nft_compat nf_tables br_netfilter bri
dge stp llc qrtr crct10dif_pclmul overlay crc32_generic crc32_pclmul
crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256
_ssse3 sha1_ssse3 xts amdgpu cts wmi_bmof aesni_intel amdxcp
i2c_algo_bit crypto_simd drm_ttm_helper cryptd ttm drm_exec
bnxt_en ionic gpu_sched drm_suballoc_helper drm_buddy ptp video
drm_display_helper drm_kms_helper wmi cfg80211 drm drm_pa
nel_orientation_quirks backlight nfnetlink bpf_preload ip_tables x_tables
[ 1135.779526] CPU: 3 PID: 1644 Comm: ncdevmem Tainted: G W
6.10.0-rc5+ #43 6e089cf25edb5a71cabb8ab97c9df
bf7e96b1a3a
[ 1135.791882] Hardware name: ASUS System Product Name/PRIME Z690-P
D4, BIOS 0603 11/01/2021
[ 1135.800781] RIP: 0010:netdev_rx_queue_restart+0x3f4/0x5a0
[ 1135.806905] Code: d0 0f 1f 00 48 89 df e8 9a ce a9 fe 4c 89 f7 e8
92 ce a9 fe 48 83 c4 08 44 89 e0 5b 5d 41 5c 41 5d 4
1 5e 41 5f c3 cc cc cc cc <0f> 0b e9 05 fd ff ff 44 89 fe 48 c7 c7 80
70 fc 86 e8 46 7c 38 fe
[ 1135.826382] RSP: 0018:ffff888224c2fbb0 EFLAGS: 00010246
[ 1135.832339] RAX: 0000000000000000 RBX: ffffffffc0bb5c80 RCX: ffffffff842=
d81c3
[ 1135.840185] RDX: 1ffffffff1e6fc44 RSI: 0000000000000008 RDI: ffffffff8f3=
7e220
[ 1135.848028] RBP: ffff88814b864000 R08: 0000000000000000 R09: fffffbfff1e=
6fc44
[ 1135.855875] R10: ffffffff8f37e227 R11: 0000000000000000 R12: ffff888224c=
2fc28
[ 1135.863716] R13: ffff88814b864be0 R14: ffffed102265e337 R15: 00000000000=
00001
[ 1135.871560] FS: 00007fe9b77b4740(0000) GS:ffff88881ba00000(0000)
knlGS:0000000000000000
[ 1135.880364] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1135.886824] CR2: 00007f5f22a21f50 CR3: 00000001094a0000 CR4: 00000000007=
506f0
[ 1135.894670] PKRU: 55555554
[ 1135.898090] Call Trace:
[ 1135.901255] <TASK>
[ 1135.904073] ? __warn+0xc8/0x2f0
[ 1135.908020] ? netdev_rx_queue_restart+0x3f4/0x5a0
[ 1135.913524] ? report_bug+0x326/0x3c0
[ 1135.917908] ? handle_bug+0x3c/0x70
[ 1135.922112] ? exc_invalid_op+0x14/0x50
[ 1135.926671] ? asm_exc_invalid_op+0x16/0x20
[ 1135.931591] ? mutex_is_locked+0x13/0x50
[ 1135.936238] ? netdev_rx_queue_restart+0x3f4/0x5a0
[ 1135.941748] net_devmem_unbind_dmabuf+0x2a3/0x440
[ 1135.947179] ? __pfx_lock_release+0x10/0x10
[ 1135.952081] ? __pfx_net_devmem_unbind_dmabuf+0x10/0x10
[ 1135.958040] netdev_nl_sock_priv_destroy+0x72/0xc0
[ 1135.963561] genl_release+0xed/0x190
[ 1135.967851] ? __pfx_genl_release+0x10/0x10
[ 1135.972755] ? mark_held_locks+0xa5/0xf0
[ 1135.977392] ? __local_bh_enable_ip+0xa5/0x120
[ 1135.982561] ? __pfx_genl_release+0x10/0x10
[ 1135.987464] netlink_release+0x839/0x18f0

Thanks!
Taehee Yoo

