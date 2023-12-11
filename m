Return-Path: <linux-arch+bounces-874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7505B80BF00
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 03:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB571F20D4B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FA11C90;
	Mon, 11 Dec 2023 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDno01d7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B6CB4
	for <linux-arch@vger.kernel.org>; Sun, 10 Dec 2023 18:19:44 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-46491d5b814so1373561137.0
        for <linux-arch@vger.kernel.org>; Sun, 10 Dec 2023 18:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702261183; x=1702865983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKXPy8iwxJNjhTZTw+LJ8Vv0y/XagWuzrwhYe/uRc+M=;
        b=KDno01d75+zS4pjfKWKOC9dAezwDOu/J7edfZ8RjonSYjckTSYHquV0lK6Mcw8WZuk
         ODYUSm58Yr5rRs4hW2FB4dXzn+zzC6MoTADOyE2d7cYFaqG3eoH+c0exuXuVhF0azbBz
         nngL8Ujwvr6JzAdblvnxQm1mN5kUfWqS2RVuhohJXSaRBAFoyZxXtArAghmTdEF6Qslo
         EEiq9cBHumbvYvnTjWOSTY9PXIwANV8orhBREH6y2i5C5cHlBXvxFBquDz4eum/rDZpH
         PTdTI7Pu0ep25NABQXrNiEMd12UzinfvSz30molHN5tK8wa+34XZcO+ZoF/EYcoeYdkh
         hurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702261183; x=1702865983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKXPy8iwxJNjhTZTw+LJ8Vv0y/XagWuzrwhYe/uRc+M=;
        b=ra7FaIYrrYxoW8RVRWQmQjieeTJjtYHN8Lk1uWeu1K8svu9CkfZ1+gYgngQCFNIGyl
         mJmA2GIRyKS3srmjUm+Ib15MvFGvBwW4JBp3mho5fDphNBWj/1W9QHIXoz2l+zLqzI8v
         NjmedqrguiNsG79/m2jV8m5BtkZ+8plcH0pwqOLD48setGqREZ26MtyprM/fqCWj8JLR
         R6xunxg6PkHeyWcSM1bwnyALABPFH1hKzLL1w2Gni9Dizew0Mbe6FJYKVSSJviy4Ch7z
         9cVJ57IJbw5tScJrhuj7UUJkqY+S4OmWEG8jGpeb+tc+xe0U+LH8RGFKuD5vx6wk2eAs
         7g1w==
X-Gm-Message-State: AOJu0YziFd7zYx3cGC/rnJDNF+HNVoYMNAuEBz9jJppeGcfvR2c+iz6W
	vGhhTgQTGz3GG48H+watOy4VDL1CwSdHLlcz80pM4A==
X-Google-Smtp-Source: AGHT+IHqLx2W8x28H6bfMYCWIzb2TuVsmrzJ0q8h3BKh//7HaVRT5Wf6V41+Foj3np3oJjncompRN0RZYYzrciFWAyY=
X-Received: by 2002:a67:ef44:0:b0:464:77f2:557 with SMTP id
 k4-20020a67ef44000000b0046477f20557mr2151093vsr.41.1702261183358; Sun, 10 Dec
 2023 18:19:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-7-almasrymina@google.com> <5752508c-f7bc-44ac-8778-c807b2ee5831@kernel.org>
 <CAHS8izPsQ2XoJy-vYWkn051Yc=D_kSprtQcG4mmPutf1G3+-aw@mail.gmail.com> <279a2999-3c0a-4839-aa2e-602864197410@kernel.org>
In-Reply-To: <279a2999-3c0a-4839-aa2e-602864197410@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 10 Dec 2023 18:19:29 -0800
Message-ID: <CAHS8izOJ4jTrq9AD5fe3ZY9veU5NP6dFkXGPRw7yz2uMCMGDTg@mail.gmail.com>
Subject: Re: [net-next v1 06/16] netdev: support binding dma-buf to netdevice
To: David Ahern <dsahern@kernel.org>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 3:29=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/8/23 12:22 PM, Mina Almasry wrote:
> > On Fri, Dec 8, 2023 at 9:48=E2=80=AFAM David Ahern <dsahern@kernel.org>=
 wrote:
> >>
> >> On 12/7/23 5:52 PM, Mina Almasry wrote:
> > ...
> >>> +
> >>> +     xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> >>> +             if (rxq->binding =3D=3D binding) {
> >>> +                     /* We hold the rtnl_lock while binding/unbindin=
g
> >>> +                      * dma-buf, so we can't race with another threa=
d that
> >>> +                      * is also modifying this value. However, the d=
river
> >>> +                      * may read this config while it's creating its
> >>> +                      * rx-queues. WRITE_ONCE() here to match the
> >>> +                      * READ_ONCE() in the driver.
> >>> +                      */
> >>> +                     WRITE_ONCE(rxq->binding, NULL);
> >>> +
> >>> +                     rxq_idx =3D get_netdev_rx_queue_index(rxq);
> >>> +
> >>> +                     netdev_restart_rx_queue(binding->dev, rxq_idx);
> >>
> >> Blindly restarting a queue when a dmabuf is heavy handed. If the dmabu=
f
> >> has no outstanding references (ie., no references in the RxQ), then no
> >> restart is needed.
> >>
> >
> > I think I need to stop the queue while binding to a dmabuf for the
> > sake of concurrency, no? I.e. the softirq thread may be delivering a
> > packet, and in parallel a separate thread holds rtnl_lock and tries to
> > bind the dma-buf. At that point the page_pool recreation will race
> > with the driver doing page_pool_alloc_page(). I don't think I can
> > insert a lock to handle this into the rx fast path, no?
>
> I think it depends on the details of how entries are added and removed
> from the pool. I am behind on the pp details at this point, so I do need
> to do some homework.
>

I think it also depends on the details of how to invalidate buffers
posted to the rx queue of a particular driver. For GVE as far as I
understands when the queue is started I believe it allocates a bunch
of buffers and posts them to the rx queue. Then it processes the
completion descriptors from the hardware and posts new buffers to
replace the ones consumed, so any started queue would have postesd
buffers in it.

As far as I know we also don't support invalidating posted buffers
without first stopping the queue, replacing the buffers, and starting
again. But I don't think these are limitations overly specific to GVE,
I believe non-RDMA NICs work similarly?

But I'd stress that what I'm proposing here should be extensible to
capabilities of specific drivers. If one has a driver that allows them
to invalidate posted buffers on the fly, I imagine they can extend the
queue API to declare that support to the netstack in a genric way, and
the net stack can invalidate buffers from the previous page pool and
supply the new one.

> >
> > Also, this sounds like it requires (lots of) more changes. The
> > page_pool + driver need to report how many pending references there
> > are (with locking so we don't race with incoming packets), and have
> > them reported via an ndo so that we can skip restarting the queue.
> > Implementing the changes in to a huge issue but handling the
> > concurrency may be a genuine blocker. Not sure it's worth the upside
> > of not restarting the single rx queue?
>
> It has to do with the usability of this overall solution. As I mentioned
> most ML use cases can (and will want to) use many memory allocations for
> receiving packets - e.g., allocations per message and receiving multiple
> messages per socket connection.
>

We support that by flow steering different flows to different RX
queues. Our NICs don't support smart choosing of which page_pool to
place the packet in (based on ntuple rule or what not). So flows that
must land on a given dmabuf are flow steered to that dmabuf, and flows
that need to land host memory and not flow steered and are RSS'd to
the non-dmabuf bound queues. This should also be extensible by folks
that have NICs with the appropriate support.

> >
> >>> +             }
> >>> +     }
> >>> +
> >>> +     xa_erase(&netdev_dmabuf_bindings, binding->id);
> >>> +
> >>> +     netdev_dmabuf_binding_put(binding);
> >>> +}
> >>> +
> >>> +int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> >>> +                             struct netdev_dmabuf_binding *binding)
> >>> +{
> >>> +     struct netdev_rx_queue *rxq;
> >>> +     u32 xa_idx;
> >>> +     int err;
> >>> +
> >>> +     rxq =3D __netif_get_rx_queue(dev, rxq_idx);
> >>> +
> >>> +     if (rxq->binding)
> >>> +             return -EEXIST;
> >>> +
> >>> +     err =3D xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_lim=
it_32b,
> >>> +                    GFP_KERNEL);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     /* We hold the rtnl_lock while binding/unbinding dma-buf, so we=
 can't
> >>> +      * race with another thread that is also modifying this value. =
However,
> >>> +      * the driver may read this config while it's creating its * rx=
-queues.
> >>> +      * WRITE_ONCE() here to match the READ_ONCE() in the driver.
> >>> +      */
> >>> +     WRITE_ONCE(rxq->binding, binding);
> >>> +
> >>> +     err =3D netdev_restart_rx_queue(dev, rxq_idx);
> >>
> >> Similarly, here binding a dmabuf to a queue. I was expecting the dmabu=
f
> >> binding to add entries to the page pool for the queue.
> >
> > To be honest, I think maybe there's a slight disconnect between how
> > you think the page_pool works, and my primitive understanding of how
> > it works. Today, I see a 1:1 mapping between rx-queue and page_pool in
> > the code. I don't see 1:many or many:1 mappings.
>
> I am not referring to 1:N or N:1 for page pool and queues. I am
> referring to entries within a single page pool for a single Rx queue.
>
>

Thanks, glad to hear that. I was afraid there is a miscommunication here.

> >
> > In theory mapping 1 rx-queue to n page_pools is trivial: the driver
> > can call page_pool_create() multiple times to generate n queues and
> > decide for incoming packets which one to use.
> >
> > However, mapping n rx-queues to 1 page_pool seems like a can of worms.
> > I see code in the page_pool that looks to me (and Willem) like it's
> > safe only because the page_pool is used from the same napi context.
> > with a n rx-queueue: 1 page_pool mapping, that is no longer true, no?
> > There is a tail end of issues to resolve to be able to map 1 page_pool
> > to n queues as I understand and even if resolved I'm not sure the
> > maintainers are interested in taking the code.
> >
> > So, per my humble understanding there is no such thing as "add entries
> > to the page pool for the (specific) queue", the page_pool is always
> > used by 1 queue.
> >
> > Note that even though this limitation exists, we still support binding
> > 1 dma-buf to multiple queues, because multiple page pools can use the
> > same netdev_dmabuf_binding. I should add that to the docs.
> >
> >> If the pool was
> >> previously empty, then maybe the queue needs to be "started" in the
> >> sense of creating with h/w or just pushing buffers into the queue and
> >> moving the pidx.
> >>
> >>
> >
> > I don't think it's enough to add buffers to the page_pool, no? The
> > existing buffers in the page_pool (host mem) must be purged. I think
> > maybe the queue needs to be stopped as well so that we don't race with
> > incoming packets and end up with skbs with devmem and non-devmem frags
> > (unless you're thinking it becomes a requirement to support that, I
> > think things are complicated as-is and it's a good simplification).
> > When we already purge the existing buffers & restart the queue, it's
> > little effort to migrate this to become in line with Jakub's queue-api
> > that he also wants to use for per-queue configuration & ndo_stop/open.
> >
>


--=20
Thanks,
Mina

