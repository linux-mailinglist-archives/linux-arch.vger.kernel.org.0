Return-Path: <linux-arch+bounces-85-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB77E6228
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 03:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE51A2811CE
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8704C8F;
	Thu,  9 Nov 2023 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJpoGlwo"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037C10FD
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 02:26:09 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB226A4
	for <linux-arch@vger.kernel.org>; Wed,  8 Nov 2023 18:26:08 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ba6a0bada9so124497241.2
        for <linux-arch@vger.kernel.org>; Wed, 08 Nov 2023 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699496768; x=1700101568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S642ghwKa1S5u8UTGDoa5xcpqvArsmfYKLa6bCOl7fs=;
        b=OJpoGlwodyewh1cHTeZQTgqMgzXdFrmJHLGsHdWHfYCHHTJ1ei9qn0sz9cEJ4b8R0M
         1hJ2irz4Czr+19HyrwR/PNewiNjqqWTnbbcf49zq2bFdkkmcqc+KeQVlNStsRiE/i5FZ
         EdJbx+zJTyHbPlx4eeXL+56U3n5+rhAqM6ojpUxIj2BOGNhYU6C+rRJNPntpQSJ3dLvE
         gTtRb1AtPJ1CZCS7jTQ8wBhHSW1rv9kedoeZME9gZCZ6R6EisOb3dYhFnS+SvcaS6mhC
         ESKztEYev4GrH38qXAVkWukrhJdxX6tvlzJbh9/Ei3gxFsmWWoDxYviXniB2FYD8BWnw
         wzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699496768; x=1700101568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S642ghwKa1S5u8UTGDoa5xcpqvArsmfYKLa6bCOl7fs=;
        b=IKDkp2tphnylEVji4ZbvYE3GyZUDL+zOqky5KA9MuSYq04tTcTci8/6uOEYfKBYgLX
         rQ11AMZZ0CxSWBFnJTlodcksHuJJkTvSfsKR9SydH1YO7uFy9QVao5JqVtQPib8xti+4
         BY9SUmiAla6/LOfDmEfYA6ot4gV8MtDnl9HA40gvwJUvkcbbT7xCb4loKCpVwo0DuRQg
         CCo0HQI1hIB8bDvGe4ZIumRd8UpZQ67i5TmO9GVogQaN71b7UAnbMunpHYoxEmIUDxfC
         802LwkNtSCNkk2ugyo/K8N+S49LnZx60k4eGQjTMnv6iU94i6iTfIuX49iyjoOr+/zCG
         QPJA==
X-Gm-Message-State: AOJu0Yx8XqnpDa4DgkngNs6N8xkb9ZByPSb0YhmDs65VXDl76pGm2zWM
	7tBj+mrVNvpd4Neoad6ABoB4SVRlWj/iOb0I6N0W+Q==
X-Google-Smtp-Source: AGHT+IGWVTCEhd4Qj7IXYGQACJHPQykZiLCn/QCPXH0Z3KnY18PQNIz7NGmM591iuH3iex8lIc6hKQrI7QWuKqlfk20=
X-Received: by 2002:a67:b20a:0:b0:45e:9611:7b71 with SMTP id
 b10-20020a67b20a000000b0045e96117b71mr3482559vsf.27.1699496767464; Wed, 08
 Nov 2023 18:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <7769b74d-dd23-41de-8e11-434a0acabf72@davidwei.uk>
In-Reply-To: <7769b74d-dd23-41de-8e11-434a0acabf72@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 8 Nov 2023 18:25:56 -0800
Message-ID: <CAHS8izO1p==W+ppDqwEE9ugehN4OL9J3+fdrY+UJch9s8uShOg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 3:47=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2023-11-05 18:44, Mina Almasry wrote:
> > Add a netdev_dmabuf_binding struct which represents the
> > dma-buf-to-netdevice binding. The netlink API will bind the dma-buf to
> > rx queues on the netdevice. On the binding, the dma_buf_attach
> > & dma_buf_map_attachment will occur. The entries in the sg_table from
> > mapping will be inserted into a genpool to make it ready
> > for allocation.
> >
> > The chunks in the genpool are owned by a dmabuf_chunk_owner struct whic=
h
> > holds the dma-buf offset of the base of the chunk and the dma_addr of
> > the chunk. Both are needed to use allocations that come from this chunk=
.
> >
> > We create a new type that represents an allocation from the genpool:
> > page_pool_iov. We setup the page_pool_iov allocation size in the
> > genpool to PAGE_SIZE for simplicity: to match the PAGE_SIZE normally
> > allocated by the page pool and given to the drivers.
> >
> > The user can unbind the dmabuf from the netdevice by closing the netlin=
k
> > socket that established the binding. We do this so that the binding is
> > automatically unbound even if the userspace process crashes.
> >
> > The binding and unbinding leaves an indicator in struct netdev_rx_queue
> > that the given queue is bound, but the binding doesn't take effect unti=
l
> > the driver actually reconfigures its queues, and re-initializes its pag=
e
> > pool.
> >
> > The netdev_dmabuf_binding struct is refcounted, and releases its
> > resources only when all the refs are released.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > RFC v3:
> > - Support multi rx-queue binding
> >
> > ---
> >  include/linux/netdevice.h     |  80 ++++++++++++++
> >  include/net/netdev_rx_queue.h |   1 +
> >  include/net/page_pool/types.h |  27 +++++
> >  net/core/dev.c                | 203 ++++++++++++++++++++++++++++++++++
> >  net/core/netdev-genl.c        | 116 ++++++++++++++++++-
> >  5 files changed, 425 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index b8bf669212cc..eeeda849115c 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -52,6 +52,8 @@
> >  #include <net/net_trackers.h>
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> > +#include <linux/xarray.h>
> > +#include <linux/refcount.h>
> >
> >  struct netpoll_info;
> >  struct device;
> > @@ -808,6 +810,84 @@ bool rps_may_expire_flow(struct net_device *dev, u=
16 rxq_index, u32 flow_id,
> >  #endif
> >  #endif /* CONFIG_RPS */
> >
> > +struct netdev_dmabuf_binding {
> > +     struct dma_buf *dmabuf;
> > +     struct dma_buf_attachment *attachment;
> > +     struct sg_table *sgt;
> > +     struct net_device *dev;
> > +     struct gen_pool *chunk_pool;
> > +
> > +     /* The user holds a ref (via the netlink API) for as long as they=
 want
> > +      * the binding to remain alive. Each page pool using this binding=
 holds
> > +      * a ref to keep the binding alive. Each allocated page_pool_iov =
holds a
> > +      * ref.
> > +      *
> > +      * The binding undos itself and unmaps the underlying dmabuf once=
 all
> > +      * those refs are dropped and the binding is no longer desired or=
 in
> > +      * use.
> > +      */
> > +     refcount_t ref;
> > +
> > +     /* The portid of the user that owns this binding. Used for netlin=
k to
> > +      * notify us of the user dropping the bind.
> > +      */
> > +     u32 owner_nlportid;
> > +
> > +     /* The list of bindings currently active. Used for netlink to not=
ify us
> > +      * of the user dropping the bind.
> > +      */
> > +     struct list_head list;
> > +
> > +     /* rxq's this binding is active on. */
> > +     struct xarray bound_rxq_list;
> > +};
> > +
> > +#ifdef CONFIG_DMA_SHARED_BUFFER
> > +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *bindin=
g);
> > +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> > +                    struct netdev_dmabuf_binding **out);
> > +void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
> > +int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> > +                             struct netdev_dmabuf_binding *binding);
> > +#else
> > +static inline void
> > +__netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
> > +{
> > +}
> > +
> > +static inline int netdev_bind_dmabuf(struct net_device *dev,
> > +                                  unsigned int dmabuf_fd,
> > +                                  struct netdev_dmabuf_binding **out)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +static inline void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *=
binding)
> > +{
> > +}
> > +
> > +static inline int
> > +netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> > +                         struct netdev_dmabuf_binding *binding)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> > +static inline void
> > +netdev_devmem_binding_get(struct netdev_dmabuf_binding *binding)
> > +{
> > +     refcount_inc(&binding->ref);
> > +}
> > +
> > +static inline void
> > +netdev_devmem_binding_put(struct netdev_dmabuf_binding *binding)
> > +{
> > +     if (!refcount_dec_and_test(&binding->ref))
> > +             return;
> > +
> > +     __netdev_devmem_binding_free(binding);
> > +}
> > +
> >  /* XPS map type and offset of the xps map within net_device->xps_maps[=
]. */
> >  enum xps_map_type {
> >       XPS_CPUS =3D 0,
> > diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queu=
e.h
> > index cdcafb30d437..1bfcf60a145d 100644
> > --- a/include/net/netdev_rx_queue.h
> > +++ b/include/net/netdev_rx_queue.h
> > @@ -21,6 +21,7 @@ struct netdev_rx_queue {
> >  #ifdef CONFIG_XDP_SOCKETS
> >       struct xsk_buff_pool            *pool;
> >  #endif
> > +     struct netdev_dmabuf_binding *binding;
>
> @Pavel - They are using struct netdev_rx_queue to hold the binding,
> which is an object that holds the state and is mapped 1:1 to an rxq.
> This object is similar to our "interface queue". I wonder if we should
> re-visit using this generic struct, instead of driver specific structs
> e.g. bnxt_rx_ring_info?
>
> >  } ____cacheline_aligned_in_smp;
> >
> >  /*
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index d4bea053bb7e..64386325d965 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -133,6 +133,33 @@ struct pp_memory_provider_ops {
> >       bool (*release_page)(struct page_pool *pool, struct page *page);
> >  };
> >
> > +/* page_pool_iov support */
> > +
> > +/* Owner of the dma-buf chunks inserted into the gen pool. Each scatte=
rlist
> > + * entry from the dmabuf is inserted into the genpool as a chunk, and =
needs
> > + * this owner struct to keep track of some metadata necessary to creat=
e
> > + * allocations from this chunk.
> > + */
> > +struct dmabuf_genpool_chunk_owner {
> > +     /* Offset into the dma-buf where this chunk starts.  */
> > +     unsigned long base_virtual;
> > +
> > +     /* dma_addr of the start of the chunk.  */
> > +     dma_addr_t base_dma_addr;
> > +
> > +     /* Array of page_pool_iovs for this chunk. */
> > +     struct page_pool_iov *ppiovs;
> > +     size_t num_ppiovs;
> > +
> > +     struct netdev_dmabuf_binding *binding;
> > +};
> > +
> > +struct page_pool_iov {
> > +     struct dmabuf_genpool_chunk_owner *owner;
> > +
> > +     refcount_t refcount;
> > +};
> > +
> >  struct page_pool {
> >       struct page_pool_params p;
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a37a932a3e14..c8c3709d42c8 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -153,6 +153,9 @@
> >  #include <linux/prandom.h>
> >  #include <linux/once_lite.h>
> >  #include <net/netdev_rx_queue.h>
> > +#include <linux/genalloc.h>
> > +#include <linux/dma-buf.h>
> > +#include <net/page_pool/types.h>
> >
> >  #include "dev.h"
> >  #include "net-sysfs.h"
> > @@ -2040,6 +2043,206 @@ static int call_netdevice_notifiers_mtu(unsigne=
d long val,
> >       return call_netdevice_notifiers_info(val, &info.info);
> >  }
> >
> > +/* Device memory support */
> > +
> > +#ifdef CONFIG_DMA_SHARED_BUFFER
> > +static void netdev_devmem_free_chunk_owner(struct gen_pool *genpool,
> > +                                        struct gen_pool_chunk *chunk,
> > +                                        void *not_used)
> > +{
> > +     struct dmabuf_genpool_chunk_owner *owner =3D chunk->owner;
> > +
> > +     kvfree(owner->ppiovs);
> > +     kfree(owner);
> > +}
> > +
> > +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *bindin=
g)
> > +{
> > +     size_t size, avail;
> > +
> > +     gen_pool_for_each_chunk(binding->chunk_pool,
> > +                             netdev_devmem_free_chunk_owner, NULL);
> > +
> > +     size =3D gen_pool_size(binding->chunk_pool);
> > +     avail =3D gen_pool_avail(binding->chunk_pool);
> > +
> > +     if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%lu, av=
ail=3D%lu",
> > +               size, avail))
> > +             gen_pool_destroy(binding->chunk_pool);
> > +
> > +     dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> > +                              DMA_BIDIRECTIONAL);
> > +     dma_buf_detach(binding->dmabuf, binding->attachment);
> > +     dma_buf_put(binding->dmabuf);
> > +     kfree(binding);
> > +}
> > +
> > +void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
> > +{
> > +     struct netdev_rx_queue *rxq;
> > +     unsigned long xa_idx;
> > +
> > +     if (!binding)
> > +             return;
> > +
> > +     list_del_rcu(&binding->list);
> > +
> > +     xa_for_each(&binding->bound_rxq_list, xa_idx, rxq)
> > +             if (rxq->binding =3D=3D binding)
> > +                     /* We hold the rtnl_lock while binding/unbinding
> > +                      * dma-buf, so we can't race with another thread =
that
> > +                      * is also modifying this value. However, the dri=
ver
> > +                      * may read this config while it's creating its
> > +                      * rx-queues. WRITE_ONCE() here to match the
> > +                      * READ_ONCE() in the driver.
> > +                      */
> > +                     WRITE_ONCE(rxq->binding, NULL);
> > +
> > +     netdev_devmem_binding_put(binding);
> > +}
> > +
> > +int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> > +                             struct netdev_dmabuf_binding *binding)
> > +{
> > +     struct netdev_rx_queue *rxq;
> > +     u32 xa_idx;
> > +     int err;
> > +
> > +     rxq =3D __netif_get_rx_queue(dev, rxq_idx);
> > +
> > +     if (rxq->binding)
> > +             return -EEXIST;
> > +
> > +     err =3D xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_limit=
_32b,
> > +                    GFP_KERNEL);
> > +     if (err)
> > +             return err;
> > +
> > +     /*We hold the rtnl_lock while binding/unbinding dma-buf, so we ca=
n't
> > +      * race with another thread that is also modifying this value. Ho=
wever,
> > +      * the driver may read this config while it's creating its * rx-q=
ueues.
> > +      * WRITE_ONCE() here to match the READ_ONCE() in the driver.
> > +      */
> > +     WRITE_ONCE(rxq->binding, binding);
> > +
> > +     return 0;
> > +}
> > +
> > +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> > +                    struct netdev_dmabuf_binding **out)
>
> I'm not entirely familiar with the Netlink API. Mina, do you know if we
> can call into netdev_bind_dmabuf or netdev_nl_bind_rx_doit directly,
> without needing to call send/recv on a Netlink socket? We likely want
> io_uring to do the registration of a dmabuf fd and keep ownership over
> it.
>

You can likely call into netdev_bind_dmabuf(), but not
netdev_nl_bind_rx_doit. The latter is very netlink specific.

> > +{
> > +     struct netdev_dmabuf_binding *binding;
> > +     struct scatterlist *sg;
> > +     struct dma_buf *dmabuf;
> > +     unsigned int sg_idx, i;
> > +     unsigned long virtual;
> > +     int err;
> > +
> > +     if (!capable(CAP_NET_ADMIN))
> > +             return -EPERM;
> > +
> > +     dmabuf =3D dma_buf_get(dmabuf_fd);
> > +     if (IS_ERR_OR_NULL(dmabuf))
> > +             return -EBADFD;
> > +
> > +     binding =3D kzalloc_node(sizeof(*binding), GFP_KERNEL,
> > +                            dev_to_node(&dev->dev));
> > +     if (!binding) {
> > +             err =3D -ENOMEM;
> > +             goto err_put_dmabuf;
> > +     }
> > +
> > +     xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
> > +
> > +     refcount_set(&binding->ref, 1);
> > +
> > +     binding->dmabuf =3D dmabuf;
> > +
> > +     binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.=
parent);
> > +     if (IS_ERR(binding->attachment)) {
> > +             err =3D PTR_ERR(binding->attachment);
> > +             goto err_free_binding;
> > +     }
> > +
> > +     binding->sgt =3D dma_buf_map_attachment(binding->attachment,
> > +                                           DMA_BIDIRECTIONAL);
> > +     if (IS_ERR(binding->sgt)) {
> > +             err =3D PTR_ERR(binding->sgt);
> > +             goto err_detach;
> > +     }
> > +
> > +     /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> > +      * binding can be much more flexible than that. We may be able to
> > +      * allocate MTU sized chunks here. Leave that for future work...
> > +      */
> > +     binding->chunk_pool =3D gen_pool_create(PAGE_SHIFT,
> > +                                           dev_to_node(&dev->dev));
> > +     if (!binding->chunk_pool) {
> > +             err =3D -ENOMEM;
> > +             goto err_unmap;
> > +     }
> > +
> > +     virtual =3D 0;
> > +     for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
> > +             dma_addr_t dma_addr =3D sg_dma_address(sg);
> > +             struct dmabuf_genpool_chunk_owner *owner;
> > +             size_t len =3D sg_dma_len(sg);
> > +             struct page_pool_iov *ppiov;
> > +
> > +             owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> > +                                  dev_to_node(&dev->dev));
> > +             owner->base_virtual =3D virtual;
> > +             owner->base_dma_addr =3D dma_addr;
> > +             owner->num_ppiovs =3D len / PAGE_SIZE;
> > +             owner->binding =3D binding;
> > +
> > +             err =3D gen_pool_add_owner(binding->chunk_pool, dma_addr,
> > +                                      dma_addr, len, dev_to_node(&dev-=
>dev),
> > +                                      owner);
> > +             if (err) {
> > +                     err =3D -EINVAL;
> > +                     goto err_free_chunks;
> > +             }
> > +
> > +             owner->ppiovs =3D kvmalloc_array(owner->num_ppiovs,
> > +                                            sizeof(*owner->ppiovs),
> > +                                            GFP_KERNEL);
> > +             if (!owner->ppiovs) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_free_chunks;
> > +             }
> > +
> > +             for (i =3D 0; i < owner->num_ppiovs; i++) {
> > +                     ppiov =3D &owner->ppiovs[i];
> > +                     ppiov->owner =3D owner;
> > +                     refcount_set(&ppiov->refcount, 1);
> > +             }
> > +
> > +             dma_addr +=3D len;
> > +             virtual +=3D len;
> > +     }
> > +
> > +     *out =3D binding;
> > +
> > +     return 0;
> > +
> > +err_free_chunks:
> > +     gen_pool_for_each_chunk(binding->chunk_pool,
> > +                             netdev_devmem_free_chunk_owner, NULL);
> > +     gen_pool_destroy(binding->chunk_pool);
> > +err_unmap:
> > +     dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> > +                              DMA_BIDIRECTIONAL);
> > +err_detach:
> > +     dma_buf_detach(dmabuf, binding->attachment);
> > +err_free_binding:
> > +     kfree(binding);
> > +err_put_dmabuf:
> > +     dma_buf_put(dmabuf);
> > +     return err;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_NET_INGRESS
> >  static DEFINE_STATIC_KEY_FALSE(ingress_needed_key);
> >
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 59d3d512d9cc..2c2a62593217 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -129,10 +129,89 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb,=
 struct netlink_callback *cb)
> >       return skb->len;
> >  }
> >
> > -/* Stub */
> > +static LIST_HEAD(netdev_rbinding_list);
> > +
> >  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info=
)
> >  {
> > -     return 0;
> > +     struct netdev_dmabuf_binding *out_binding;
> > +     u32 ifindex, dmabuf_fd, rxq_idx;
> > +     struct net_device *netdev;
> > +     struct sk_buff *rsp;
> > +     int rem, err =3D 0;
> > +     void *hdr;
> > +     struct nlattr *attr;
> > +
> > +     if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> > +         GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_DMABUF_FD) ||
> > +         GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_QUEUES))
> > +             return -EINVAL;
> > +
> > +     ifindex =3D nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> > +     dmabuf_fd =3D nla_get_u32(info->attrs[NETDEV_A_BIND_DMABUF_DMABUF=
_FD]);
> > +
> > +     rtnl_lock();
> > +
> > +     netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> > +     if (!netdev) {
> > +             err =3D -ENODEV;
> > +             goto err_unlock;
> > +     }
> > +
> > +     err =3D netdev_bind_dmabuf(netdev, dmabuf_fd, &out_binding);
> > +     if (err)
> > +             goto err_unlock;
> > +
> > +     nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
> > +                       genlmsg_len(info->genlhdr), rem) {
> > +             switch (nla_type(attr)) {
> > +             case NETDEV_A_BIND_DMABUF_QUEUES:
> > +                     rxq_idx =3D nla_get_u32(attr);
> > +
> > +                     if (rxq_idx >=3D netdev->num_rx_queues) {
> > +                             err =3D -ERANGE;
> > +                             goto err_unbind;
> > +                     }
> > +
> > +                     err =3D netdev_bind_dmabuf_to_queue(netdev, rxq_i=
dx,
> > +                                                       out_binding);
> > +                     if (err)
> > +                             goto err_unbind;
> > +
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> > +
> > +     out_binding->owner_nlportid =3D info->snd_portid;
> > +     list_add_rcu(&out_binding->list, &netdev_rbinding_list);
> > +
> > +     rsp =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +     if (!rsp) {
> > +             err =3D -ENOMEM;
> > +             goto err_unbind;
> > +     }
> > +
> > +     hdr =3D genlmsg_put(rsp, info->snd_portid, info->snd_seq,
> > +                       &netdev_nl_family, 0, info->genlhdr->cmd);
> > +     if (!hdr) {
> > +             err =3D -EMSGSIZE;
> > +             goto err_genlmsg_free;
> > +     }
> > +
> > +     genlmsg_end(rsp, hdr);
> > +
> > +     rtnl_unlock();
> > +
> > +     return genlmsg_reply(rsp, info);
> > +
> > +err_genlmsg_free:
> > +     nlmsg_free(rsp);
> > +err_unbind:
> > +     netdev_unbind_dmabuf(out_binding);
> > +err_unlock:
> > +     rtnl_unlock();
> > +     return err;
> >  }
> >
> >  static int netdev_genl_netdevice_event(struct notifier_block *nb,
> > @@ -155,10 +234,37 @@ static int netdev_genl_netdevice_event(struct not=
ifier_block *nb,
> >       return NOTIFY_OK;
> >  }
> >
> > +static int netdev_netlink_notify(struct notifier_block *nb, unsigned l=
ong state,
> > +                              void *_notify)
> > +{
> > +     struct netlink_notify *notify =3D _notify;
> > +     struct netdev_dmabuf_binding *rbinding;
> > +
> > +     if (state !=3D NETLINK_URELEASE || notify->protocol !=3D NETLINK_=
GENERIC)
> > +             return NOTIFY_DONE;
> > +
> > +     rcu_read_lock();
> > +
> > +     list_for_each_entry_rcu(rbinding, &netdev_rbinding_list, list) {
> > +             if (rbinding->owner_nlportid =3D=3D notify->portid) {
> > +                     netdev_unbind_dmabuf(rbinding);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     rcu_read_unlock();
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> >  static struct notifier_block netdev_genl_nb =3D {
> >       .notifier_call  =3D netdev_genl_netdevice_event,
> >  };
> >
> > +static struct notifier_block netdev_netlink_notifier =3D {
> > +     .notifier_call =3D netdev_netlink_notify,
> > +};
>
> Is this mechamism what cleans up TCP devmem in case userspace crashes
> and the associated Netlink socket is closed?
>

Correct.

> > +
> >  static int __init netdev_genl_init(void)
> >  {
> >       int err;
> > @@ -171,8 +277,14 @@ static int __init netdev_genl_init(void)
> >       if (err)
> >               goto err_unreg_ntf;
> >
> > +     err =3D netlink_register_notifier(&netdev_netlink_notifier);
> > +     if (err)
> > +             goto err_unreg_family;
> > +
> >       return 0;
> >
> > +err_unreg_family:
> > +     genl_unregister_family(&netdev_nl_family);
> >  err_unreg_ntf:
> >       unregister_netdevice_notifier(&netdev_genl_nb);
> >       return err;



--=20
Thanks,
Mina

