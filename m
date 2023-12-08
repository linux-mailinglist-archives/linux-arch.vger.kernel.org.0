Return-Path: <linux-arch+bounces-825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F480ADE5
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 21:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60841C20B86
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3175732B;
	Fri,  8 Dec 2023 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT9qNTkt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864DD1732
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 12:32:34 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35da85e543eso6588355ab.0
        for <linux-arch@vger.kernel.org>; Fri, 08 Dec 2023 12:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702067554; x=1702672354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhBb1HqSAqTrwRbd+v/ErOl81Ub5hOYpEU76T44IBUo=;
        b=OT9qNTktmyhac+err3AygALM8976BIJr8UonNCPVRMCqs3h4+xubBNlTSEgTBgkxfn
         s8jGYjnLDJRxTlEccGT/09BeEKv2cOrpL7UwAy44AoFjtidczLhujT53Pidz0PD8Ode/
         ZewIA+kNlhiP1FDq4a6AbDkYKqPZgPJ8mvM5R9gGlHiZqg58xds0N7FOUaCb6Cj2pVF7
         nWDi3la8GPw7jc1SmohTpbQQ5smxCIWTw7yt+aDPR5kP4kq+UbHdoBCR6gxgrM5Jdi0I
         7VC/YNMH0+Q6RiDlyOaxr+LZr/4ejjk/+VTePwKHRBi+kp+CuGPMA6EIG7MZ84CTlpjH
         wuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067554; x=1702672354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhBb1HqSAqTrwRbd+v/ErOl81Ub5hOYpEU76T44IBUo=;
        b=jmVBMKqGY/CBHJtTuPCfRsxZmomrceAx/+7Iffri1S5QfXf1JSo/2XB0nSnt8vmDiw
         wHo+tjbA/KS0j94CkBa/OtaeKA4SJb2KOb9jU18j27TK2YsRR6aZHz8JmuRTw/Lo5V/X
         BMYwu1wGE4Th5wE1L/q7W0oQbyqI7uX8HhjvtkeXmEUVJN3z1RbkqezR4e5GJKO/UKAH
         QkIt3zyt0/oMkW/+ZcKs8Mh4zklKL6jsjDVnjcbyOnTq8fbwd9P+ZGZ7m8u/hh2VKt/D
         tpt1E4xW8kx5gQZFUM8k8I5INfwFkbHvP/cp0cFA4tmbHrZiDuUDad6sF1PMLeDXieJA
         39XA==
X-Gm-Message-State: AOJu0YyBPFHetaAV38nngHRNKQ1tzetp8KuH6DvNXoIHdfOrXssC1p+g
	2AW1FKI7KYFlR9VVdPwvkPHfDj87y6G9Gz2YJnKezw==
X-Google-Smtp-Source: AGHT+IG9JHOMDiMtvPVJkg2EdX8pFgSL5xbwUORKO76ChzHaeIYv3+ZS8mk+kxtsayRFdEIS46pfgO5uRe5PxVO24Xs=
X-Received: by 2002:a05:6e02:184b:b0:35d:51de:bae2 with SMTP id
 b11-20020a056e02184b00b0035d51debae2mr913106ilv.24.1702067553659; Fri, 08 Dec
 2023 12:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-7-almasrymina@google.com> <5752508c-f7bc-44ac-8778-c807b2ee5831@kernel.org>
 <CAHS8izPsQ2XoJy-vYWkn051Yc=D_kSprtQcG4mmPutf1G3+-aw@mail.gmail.com>
In-Reply-To: <CAHS8izPsQ2XoJy-vYWkn051Yc=D_kSprtQcG4mmPutf1G3+-aw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Dec 2023 12:32:21 -0800
Message-ID: <CAHS8izNuhFpoLVB_03i3G5-GoHqPJ5Gz_-5JzQ8UsNF=TkR9Cg@mail.gmail.com>
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

On Fri, Dec 8, 2023 at 11:22=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Fri, Dec 8, 2023 at 9:48=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
> >
> > On 12/7/23 5:52 PM, Mina Almasry wrote:
> ...
> > > +
> > > +     xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> > > +             if (rxq->binding =3D=3D binding) {
> > > +                     /* We hold the rtnl_lock while binding/unbindin=
g
> > > +                      * dma-buf, so we can't race with another threa=
d that
> > > +                      * is also modifying this value. However, the d=
river
> > > +                      * may read this config while it's creating its
> > > +                      * rx-queues. WRITE_ONCE() here to match the
> > > +                      * READ_ONCE() in the driver.
> > > +                      */
> > > +                     WRITE_ONCE(rxq->binding, NULL);
> > > +
> > > +                     rxq_idx =3D get_netdev_rx_queue_index(rxq);
> > > +
> > > +                     netdev_restart_rx_queue(binding->dev, rxq_idx);
> >
> > Blindly restarting a queue when a dmabuf is heavy handed. If the dmabuf
> > has no outstanding references (ie., no references in the RxQ), then no
> > restart is needed.
> >
>
> I think I need to stop the queue while binding to a dmabuf for the
> sake of concurrency, no? I.e. the softirq thread may be delivering a
> packet, and in parallel a separate thread holds rtnl_lock and tries to
> bind the dma-buf. At that point the page_pool recreation will race
> with the driver doing page_pool_alloc_page(). I don't think I can
> insert a lock to handle this into the rx fast path, no?
>
> Also, this sounds like it requires (lots of) more changes. The
> page_pool + driver need to report how many pending references there
> are (with locking so we don't race with incoming packets), and have
> them reported via an ndo so that we can skip restarting the queue.
> Implementing the changes in to a huge issue but handling the
> concurrency may be a genuine blocker. Not sure it's worth the upside
> of not restarting the single rx queue?
>
> > > +             }
> > > +     }
> > > +
> > > +     xa_erase(&netdev_dmabuf_bindings, binding->id);
> > > +
> > > +     netdev_dmabuf_binding_put(binding);
> > > +}
> > > +
> > > +int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> > > +                             struct netdev_dmabuf_binding *binding)
> > > +{
> > > +     struct netdev_rx_queue *rxq;
> > > +     u32 xa_idx;
> > > +     int err;
> > > +
> > > +     rxq =3D __netif_get_rx_queue(dev, rxq_idx);
> > > +
> > > +     if (rxq->binding)
> > > +             return -EEXIST;
> > > +
> > > +     err =3D xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_lim=
it_32b,
> > > +                    GFP_KERNEL);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     /* We hold the rtnl_lock while binding/unbinding dma-buf, so we=
 can't
> > > +      * race with another thread that is also modifying this value. =
However,
> > > +      * the driver may read this config while it's creating its * rx=
-queues.
> > > +      * WRITE_ONCE() here to match the READ_ONCE() in the driver.
> > > +      */
> > > +     WRITE_ONCE(rxq->binding, binding);
> > > +
> > > +     err =3D netdev_restart_rx_queue(dev, rxq_idx);
> >
> > Similarly, here binding a dmabuf to a queue. I was expecting the dmabuf
> > binding to add entries to the page pool for the queue.
>
> To be honest, I think maybe there's a slight disconnect between how
> you think the page_pool works, and my primitive understanding of how
> it works. Today, I see a 1:1 mapping between rx-queue and page_pool in
> the code. I don't see 1:many or many:1 mappings.
>
> In theory mapping 1 rx-queue to n page_pools is trivial: the driver
> can call page_pool_create() multiple times to generate n queues and
> decide for incoming packets which one to use.
>
> However, mapping n rx-queues to 1 page_pool seems like a can of worms.
> I see code in the page_pool that looks to me (and Willem) like it's
> safe only because the page_pool is used from the same napi context.
> with a n rx-queueue: 1 page_pool mapping, that is no longer true, no?
> There is a tail end of issues to resolve to be able to map 1 page_pool
> to n queues as I understand and even if resolved I'm not sure the
> maintainers are interested in taking the code.
>
> So, per my humble understanding there is no such thing as "add entries
> to the page pool for the (specific) queue", the page_pool is always
> used by 1 queue.
>
> Note that even though this limitation exists, we still support binding
> 1 dma-buf to multiple queues, because multiple page pools can use the
> same netdev_dmabuf_binding. I should add that to the docs.
>
> > If the pool was
> > previously empty, then maybe the queue needs to be "started" in the
> > sense of creating with h/w or just pushing buffers into the queue and
> > moving the pidx.
> >
> >
>
> I don't think it's enough to add buffers to the page_pool, no? The
> existing buffers in the page_pool (host mem) must be purged. I think
> maybe the queue needs to be stopped as well so that we don't race with
> incoming packets and end up with skbs with devmem and non-devmem frags
> (unless you're thinking it becomes a requirement to support that, I
> think things are complicated as-is and it's a good simplification).
> When we already purge the existing buffers & restart the queue, it's
> little effort to migrate this to become in line with Jakub's queue-api
> that he also wants to use for per-queue configuration & ndo_stop/open.
>

FWIW what i'm referring to with Jakub's queue-api is here:
https://lore.kernel.org/netdev/20230815171638.4c057dcd@kernel.org/

I made some simplifications, vis-a-vis passing the queue idx for the
driver to extract the config from rather than the 'cfg' param Jakub
outlined, and again passed the queue idx instead of the 'queue info'
(the API currently assumes RX, and can be extended later for TX use
cases).
--=20
Thanks,
Mina

