Return-Path: <linux-arch+bounces-2883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB8874282
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 23:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FFB22D58
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875681BC31;
	Wed,  6 Mar 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imSnvB/g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD21BC22
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763073; cv=none; b=J2XPY/8oTOzD5i0cFctECBr3B2M3FVsaqZ4+HeLUfw9SMeHeDRjOfvko6vP2Wh7umHm1mG3Ok57nqeZ+YdndZVaR2+26UIY+OcuFO8xtuQrPqBWbOY1dQzyI2l85U/eEpL18KGJnb62J6qk1dOB39Pn/e5XUdCz89odDmhGfLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763073; c=relaxed/simple;
	bh=e+h5g7ggIAcqtCEsjbwW8QZ4XMZUN74BvuwxvFy1dqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilLTkWErX9HnyARCQVX+5vt5sLXEoLHZ/XVZ1C2u+wzVm/kgOeLWNhoLON3yBIJ998+A70/n81Ow8InZaTtTenu9aaxwzequ1p2eoMC+b3tA8i4OoGygU7k7L6ltrCKliwL3u1f2y79MkIqX8SF8vBplIZj7Lcehjz9MzDh0Y8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imSnvB/g; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so32515666b.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709763068; x=1710367868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMaQ3cDJaF53fme3ObxORiWTrmjgHw0Qfaex1Nu2I/k=;
        b=imSnvB/glsrcOoPIl62eeq6tzX1mTcMOBOEqK11tyD8Q0h0/m3eXHCKa62zKxIl1k+
         YqDAFu8QP4A/jo0OqqO3VFfTgffsuHGIPg60Dz2Y/rpwW/z69zYX6P14tfKr3BJFm0LV
         rpolC4pkfuCAG7xI6MU71ZLwVokmsKyyEvQx9Fva5V6SFM/yuZnVjwezpSC75JLue0FE
         VqBQp4fGnzQub8hM2Mst6i0IksmKfepM49kQxm+bK49O6M2u0qiSNE5TYZKaxqhaTXVl
         pptv/cGgeHIqMbTyvqkUl4s18Xy1ph3NeNPUHutsXLXyE5u8Lh4Fy4W0+DQ39RUs8czE
         25Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709763068; x=1710367868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMaQ3cDJaF53fme3ObxORiWTrmjgHw0Qfaex1Nu2I/k=;
        b=o/ZCTcPmkwXV8+Gs0pwxoFMvJuhaLT0rd+29BkkZgRzhFiZvKa3gR0v9Jo+Lv7DB3r
         NZONWZ1joqtFQes7fv4U5IbN6N5iT4MJnWIXqcFCPLuhwhle395HTs/mR/E/cNctbPFM
         MbxH+KmoRwFLAq8LMVn1pvptU2ySjcVWGzVPf8H5r22RPInZjcArqGuvd8LgMYE3CJzd
         hOupa6DG/D/Wwirl0MURhxBdptuNlUee0cdiDwRHs7Y+agCcaM4Zc3JJKImIKlH855y9
         kISSfHXIohebWXona2ghGRVfna+KOuduCcYAG+RIxT0Gfi094M+YJTnDjivnGP+5IogT
         QauQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbNPXDJ/0aV6I7D3nLB+L/U9B0aQtlZ32KItyTBoOdJ0yIR1Up2dQqObJ9EI8vmOX4vzFuwZn5av45UQ5OC63QqTlJ0zNG4XbNkQ==
X-Gm-Message-State: AOJu0YzPQVKenGQs3swWotXm5DEYYP7JvBL2Pg85MRYry28Z6SExvfU+
	ZlV5efDPOKhG6TSlcBkjqu323ujd00+7zX8daRIxDKkSAFixE7ZM7Bx4Fa+T94c1bfXHI9lASSm
	bvxQTAx+FU0z60khMpuiDM7KBADfulvnAnC+P
X-Google-Smtp-Source: AGHT+IENXwD+VWczLj/dTM2/A1MFyK7LqUp0f5yPqTDI4m7+LrQO5mzGQIb3CxwkX+uMg5NpdLqf746V4nTchzug2EI=
X-Received: by 2002:a17:906:3442:b0:a44:3ec9:1fd3 with SMTP id
 d2-20020a170906344200b00a443ec91fd3mr9663971ejb.30.1709763067483; Wed, 06 Mar
 2024 14:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com> <da42cea9-c169-599e-f087-d38c419e3dab@huawei.com>
 <CAHS8izM7GbvWHrH=h9q0oG0DMU649EjT1udNEW_8F-hGeC15EQ@mail.gmail.com> <aa892723-7396-998d-db06-166c28fba1e0@huawei.com>
In-Reply-To: <aa892723-7396-998d-db06-166c28fba1e0@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 14:10:55 -0800
Message-ID: <CAHS8izNJFnKGn9nrJ3kRxGwhvjiDey_bfrxQNfsfj=S9hZR_UA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:38=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/3/6 5:17, Mina Almasry wrote:
> > On Tue, Mar 5, 2024 at 4:55=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/3/5 10:01, Mina Almasry wrote:
> >>
> >> ...
> >>
> >>>
> >>> The netdev_dmabuf_binding struct is refcounted, and releases its
> >>> resources only when all the refs are released.
> >>>
> >>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >>> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> >>> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>>
> >>> ---
> >>>
> >>> RFC v6:
> >>> - Validate rx queue index
> >>> - Refactor new functions into devmem.c (Pavel)
> >>
> >> It seems odd that the functions or stucts in a file called devmem.c
> >> are named after 'dmabuf' instead of 'devmem'.
> >>
> >
> > So my intention with this naming that devmem.c contains all the
> > functions for all devmem tcp specific support. Currently the only
> > devmem we support is dmabuf. In the future, other devmem may be
> > supported and it can fit nicely in devmem.c. For example, if we want
> > to extend devmem TCP to support NVMe devices, we need to add support
> > for p2pdma, maybe, and we can add that support under the devmem.c
> > umbrella rather than add new files.
> >
> > But I can rename to dmabuf.c if there is strong objection to the curren=
t name.
>
> Grepping 'dmabuf' seems to show that it may be common rename it to
> something as *_dmabuf.c.
>
> >
> >>>
> >>
> >> ...
> >>
> >>> diff --git a/include/net/netmem.h b/include/net/netmem.h
> >>> index d8b810245c1d..72e932a1a948 100644
> >>> --- a/include/net/netmem.h
> >>> +++ b/include/net/netmem.h
> >>> @@ -8,6 +8,16 @@
> >>>  #ifndef _NET_NETMEM_H
> >>>  #define _NET_NETMEM_H
> >>>
> >>> +#include <net/devmem.h>
> >>> +
> >>> +/* net_iov */
> >>> +
> >>> +struct net_iov {
> >>> +     struct dmabuf_genpool_chunk_owner *owner;
> >>> +};
> >>> +
> >>> +/* netmem */
> >>> +
> >>>  /**
> >>>   * typedef netmem_ref - a nonexistent type marking a reference to ge=
neric
> >>>   * network memory.
> >>> diff --git a/net/core/Makefile b/net/core/Makefile
> >>> index 821aec06abf1..592f955c1241 100644
> >>> --- a/net/core/Makefile
> >>> +++ b/net/core/Makefile
> >>> @@ -13,7 +13,7 @@ obj-y                    +=3D dev.o dev_addr_lists.=
o dst.o netevent.o \
> >>>                       neighbour.o rtnetlink.o utils.o link_watch.o fi=
lter.o \
> >>>                       sock_diag.o dev_ioctl.o tso.o sock_reuseport.o =
\
> >>>                       fib_notifier.o xdp.o flow_offload.o gro.o \
> >>> -                     netdev-genl.o netdev-genl-gen.o gso.o
> >>> +                     netdev-genl.o netdev-genl-gen.o gso.o devmem.o
> >>>
> >>>  obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) +=3D dev_addr_lists_test.o
> >>>
> >>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>> index fe054cbd41e9..bbea1b252529 100644
> >>> --- a/net/core/dev.c
> >>> +++ b/net/core/dev.c
> >>> @@ -155,6 +155,9 @@
> >>>  #include <net/netdev_rx_queue.h>
> >>>  #include <net/page_pool/types.h>
> >>>  #include <net/page_pool/helpers.h>
> >>> +#include <linux/genalloc.h>
> >>> +#include <linux/dma-buf.h>
> >>> +#include <net/devmem.h>
> >>>
> >>>  #include "dev.h"
> >>>  #include "net-sysfs.h"
> >>> diff --git a/net/core/devmem.c b/net/core/devmem.c
> >>> new file mode 100644
> >>> index 000000000000..779ad990971e
> >>> --- /dev/null
> >>> +++ b/net/core/devmem.c
> >>> @@ -0,0 +1,293 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later
> >>> +/*
> >>> + *      Devmem TCP
> >>> + *
> >>> + *      Authors:     Mina Almasry <almasrymina@google.com>
> >>> + *                   Willem de Bruijn <willemdebruijn.kernel@gmail.c=
om>
> >>> + *                   Kaiyuan Zhang <kaiyuanz@google.com
> >>> + */
> >>> +
> >>> +#include <linux/types.h>
> >>> +#include <linux/mm.h>
> >>> +#include <linux/netdevice.h>
> >>> +#include <trace/events/page_pool.h>
> >>> +#include <net/netdev_rx_queue.h>
> >>> +#include <net/page_pool/types.h>
> >>> +#include <net/page_pool/helpers.h>
> >>> +#include <linux/genalloc.h>
> >>> +#include <linux/dma-buf.h>
> >>> +#include <net/devmem.h>
> >>> +
> >>> +/* Device memory support */
> >>> +
> >>> +#ifdef CONFIG_DMA_SHARED_BUFFER
> >>
> >> I still think it is worth adding its own config for devmem or dma-buf
> >> for networking, thinking about the embeded system.
> >>
> >
> > FWIW Willem did weigh on this previously and said he prefers to have
> > it unguarded by a CONFIG, but I will submit to whatever the consensus
> > here. It shouldn't be a huge deal to add a CONFIG technically
> > speaking.
>
> Grepping 'CONFIG_DMA_SHARED_BUFFER' show that the API user of dmabuf
> API does not seems to reuse the CONFIG_DMA_SHARED_BUFFER, instead they
> seem to define its own config, and select CONFIG_DMA_SHARED_BUFFER
> if necessary, it that any reason it is different here?
>
> >
> >>> +static void netdev_dmabuf_free_chunk_owner(struct gen_pool *genpool,
> >>> +                                        struct gen_pool_chunk *chunk=
,
> >>> +                                        void *not_used)
> >>
> >> It seems odd to still keep the netdev_ prefix as it is not really rela=
ted
> >> to netdev, perhaps use 'net_' or something better.
> >>
> >
> > Yes, thanks for catching. I can change to net_devmem_ maybe or net_dmab=
uf_*.
>
> FWIW, net_dmabuf_* seems like a better name technically.
>
> >
> >>> +{
> >>> +     struct dmabuf_genpool_chunk_owner *owner =3D chunk->owner;
> >>> +
> >>> +     kvfree(owner->niovs);
> >>> +     kfree(owner);
> >>> +}
> >>> +
> >>> +void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *bind=
ing)
> >>> +{
> >>> +     size_t size, avail;
> >>> +
> >>> +     gen_pool_for_each_chunk(binding->chunk_pool,
> >>> +                             netdev_dmabuf_free_chunk_owner, NULL);
> >>> +
> >>> +     size =3D gen_pool_size(binding->chunk_pool);
> >>> +     avail =3D gen_pool_avail(binding->chunk_pool);
> >>> +
> >>> +     if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%lu, =
avail=3D%lu",
> >>> +               size, avail))
> >>> +             gen_pool_destroy(binding->chunk_pool);
> >>> +
> >>> +     dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> >>> +                              DMA_BIDIRECTIONAL);
> >>
> >> For now DMA_FROM_DEVICE seems enough as tx is not supported yet.
> >>
> >
> > Yes, good catch. I suspect we want to reuse this code for TX path. But
> > for now, I'll test with DMA_FROM_DEVICE and if I see no issues I'll
> > apply this change.
> >
> >>> +     dma_buf_detach(binding->dmabuf, binding->attachment);
> >>> +     dma_buf_put(binding->dmabuf);
> >>> +     xa_destroy(&binding->bound_rxq_list);
> >>> +     kfree(binding);
> >>> +}
> >>> +
> >>> +static int netdev_restart_rx_queue(struct net_device *dev, int rxq_i=
dx)
> >>> +{
> >>> +     void *new_mem;
> >>> +     void *old_mem;
> >>> +     int err;
> >>> +
> >>> +     if (!dev || !dev->netdev_ops)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (!dev->netdev_ops->ndo_queue_stop ||
> >>> +         !dev->netdev_ops->ndo_queue_mem_free ||
> >>> +         !dev->netdev_ops->ndo_queue_mem_alloc ||
> >>> +         !dev->netdev_ops->ndo_queue_start)
> >>> +             return -EOPNOTSUPP;
> >>> +
> >>> +     new_mem =3D dev->netdev_ops->ndo_queue_mem_alloc(dev, rxq_idx);
> >>> +     if (!new_mem)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     err =3D dev->netdev_ops->ndo_queue_stop(dev, rxq_idx, &old_mem)=
;
> >>> +     if (err)
> >>> +             goto err_free_new_mem;
> >>> +
> >>> +     err =3D dev->netdev_ops->ndo_queue_start(dev, rxq_idx, new_mem)=
;
> >>> +     if (err)
> >>> +             goto err_start_queue;
> >>> +
> >>> +     dev->netdev_ops->ndo_queue_mem_free(dev, old_mem);
> >>> +
> >>> +     return 0;
> >>> +
> >>> +err_start_queue:
> >>> +     dev->netdev_ops->ndo_queue_start(dev, rxq_idx, old_mem);
> >>
> >> It might worth mentioning why queue start with old_mem will always
> >> success here as the return value seems to be ignored here.
> >>
> >
> > So the old queue, we stopped it, and if we fail to bring up the new
> > queue, then we want to start the old queue back up to get the queue
> > back to a workable state.
> >
> > I don't see what we can do to recover if restarting the old queue
> > fails. Seems like it should be a requirement that the driver tries as
> > much as possible to keep the old queue restartable.
>
> Is it possible that we may have the 'old_mem' leaking if the driver
> fails to restart the old queue? how does the driver handle the
> firmware cmd failure for ndo_queue_start()? it seems a little
> tricky to implement it.
>

I'm not sure what we can do to meaningfully recover from failure to
restarting the old queue, except log it so the error is visible. In
theory because we have not modifying any queue configurations
restarting it would be straight forward, but since it's dealing with
hardware then any failures are possible.

> >
> > I can improve this by at least logging or warning if restarting the
> > old queue fails.
>
> Also the semantics of the above function seems odd that it is not
> only restarting rx queue, but also freeing and allocating memory
> despite the name only suggests 'restart', I am a litte afraid that
> it may conflict with future usecae when user only need the
> 'restart' part, perhaps rename it to a more appropriate name.
>

Oh, what we want here is just the 'restart' part. However, Jakub
mandates that if you restart a queue (or a driver), you do it like
this, hence the slightly more complicated implementation.

https://patchwork.kernel.org/project/netdevbpf/patch/20231106024413.2801438=
-13-almasrymina@google.com/#25590262
https://lore.kernel.org/netdev/20230815171638.4c057dcd@kernel.org/

> >
> >>> +
> >>> +err_free_new_mem:
> >>> +     dev->netdev_ops->ndo_queue_mem_free(dev, new_mem);
> >>> +
> >>> +     return err;
> >>> +}
> >>> +
> >>> +/* Protected by rtnl_lock() */
> >>> +static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
> >>> +
> >>> +void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
> >>> +{
> >>> +     struct netdev_rx_queue *rxq;
> >>> +     unsigned long xa_idx;
> >>> +     unsigned int rxq_idx;
> >>> +
> >>> +     if (!binding)
> >>> +             return;
> >>> +
> >>> +     if (binding->list.next)
> >>> +             list_del(&binding->list);
> >>
> >> The above does not seems to be a good pattern to delete a entry, is
> >> there any reason having a checking before the list_del()? seems like
> >> defensive programming?
> >>
> >
> > I think I needed to apply this condition to handle the case where
> > netdev_unbind_dmabuf() is called when binding->list is not initialized
> > or is empty.
> >
> > netdev_nl_bind_rx_doit() will call unbind to free a partially
> > allocated binding in error paths, so, netdev_unbind_dmabuf() may be
> > called with a partially initialized binding. This is why we check for
> > binding->list is initialized here and check that rxq->binding =3D=3D
> > binding below. The main point is that netdev_unbind_dmabuf() may be
> > asked to unbind a partially bound dmabuf due to error paths.
> >
> > Maybe a comment here will test this better. I will double confirm the
> > check is needed for the error paths in netdev_nl_bind_rx_doit().
> >
> >>> +
> >>> +     xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> >>> +             if (rxq->binding =3D=3D binding) {
> >>
> >> It seems like defensive programming here too?
> >>
>


--=20
Thanks,
Mina

