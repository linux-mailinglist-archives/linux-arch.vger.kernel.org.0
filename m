Return-Path: <linux-arch+bounces-6424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3395A178
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03C91C21AAD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8A14E2CB;
	Wed, 21 Aug 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VawqCO9A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C550149C42
	for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254609; cv=none; b=sBaiQ4q3eRfYbHq91R44dDPdEppU/jj8y7ypV/++zw94zQNsTTgQpAQHsaElnvaUeBUXcyQLOUsEouhTyRVK4yXzAQn9sEa7UtUl3pLcvJWjxgdhp4acB7lLbwqtB6wDdpgs2v+FtcwqDu0jNaRHlYZiTPB/8MYXWHTv9kTgRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254609; c=relaxed/simple;
	bh=lRtlmbjL10N9pND329duqEBS2XO74LAzcfVhekR0HYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOZYebgErHJ9fdu2BJt5QgxHkezN/yJOC+suibdx62KuE409AbisYapv5K6jYv0pvE+Shd1BvaPiSpuuwrMqUHZv10A7v8Tbb5P17dBLZGLMRWmRoFTPEtqNI9EAiqte8aiziVKzpl0SD1raWW5I3XywtE87gpES6qIE6oBibSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VawqCO9A; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4518d9fa2f4so377541cf.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724254605; x=1724859405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUZoeSiNO641pI3EuPxhZcOUo6QCsmcEaLeGMupG+Zk=;
        b=VawqCO9Ap+dfG9m5J2m0lw/Kt22zqA+IUqPCZmZb15ns7NM1w7XhIHRfB0KFAyxY8W
         vFYidURPYefAUs0AoQdCss4vjJs0hRhqr43gVHbsFiw1B9ldI0kIQS0dPYFs4nkxhRBO
         VWr9iHG8WuLjsD5se9v2lReEV4/I+6inz0ZPbW5M9F4umNk5sbLVejBxxOMS+TUrfZEO
         CONEh2i35AR7tfgTyzMzRYcMqBG/TbKMsxIKZneIW745qgGVc/CHc/VkwvNYZ3ELJxSH
         Dr/c81HgwIJYlN3IKpB4dL58faG9ZHOBRQcc1OoHLmOX2F1tfDbzZOV877FLg9cCkcPw
         8cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724254605; x=1724859405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUZoeSiNO641pI3EuPxhZcOUo6QCsmcEaLeGMupG+Zk=;
        b=uRogPEQydAWF79jLCIYBH2Pwt71psGmuCnXhajuL/8kfJc8qhYwEN1l1DI20KVilc4
         erGbxsWn2NOlKMZ5uvANUwWCP8+zwSWKAOI7BSVbZ7XzwbGIiL4oJmF5SQDU/L734wDG
         n+j+saGRaBJ5wsBp5obLc33cyZrcvfxia3Egccz7c/Wtv4tKeIZdbvjfwrj77DSqm7fM
         TNqfkNBzBBRF1+WoI9MAVsT5W8CJTgy7Pqm+In/b5S37px7ZXh5WtfpkFtxmR0KEDTss
         1OpHFR+aE1GOsgGmRh0XWdrgoc9cfVQUfkAGAo0rW5EXyJPGMH/vVjjwxQTzI6s/z9+6
         NwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCViywvGYQ3KuNwTuXmimuESjxil9wGFhv4s0bm8YWeojVhLCBwM72FmE6gzoZuPK/vfhqPZSAOxW4Op@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6lqs0mc7q1fOF4XUpIhHJ9KW8E4lZiqff32qhZULOSSexmSZ
	2TSP+96FFvw4WlPW2488EL/6vHdVSt6JcaYEq7E5An5s4K156FpD6k59qZ2PTHUHEEjwYlbdF5a
	74mgzBSH8kd+LDqtmcEqc/HrNacm5fQcj1o9a
X-Google-Smtp-Source: AGHT+IGfHATnjXtnGmfmB/4D15ItV4+y4fk90XQNkiarco8smx060mhOYYV6TW3lde4cXDjE7q2OcPZA07rGH+zC+AM=
X-Received: by 2002:a05:622a:1816:b0:447:d555:7035 with SMTP id
 d75a77b69052e-454e86e342amr6626771cf.13.1724254604541; Wed, 21 Aug 2024
 08:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-4-almasrymina@google.com>
 <CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
 <20240819155257.1148e869@kernel.org> <CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
 <CAMArcTXvccYBPZTEuW-z=uTK7W67utd9-xjPzfxEOvUWhPS7bg@mail.gmail.com>
In-Reply-To: <CAMArcTXvccYBPZTEuW-z=uTK7W67utd9-xjPzfxEOvUWhPS7bg@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Aug 2024 11:36:31 -0400
Message-ID: <CAHS8izPZ9Jiu9Gj+Kk3cQ_+t22M4n4-mbPLhx+fti_HiWzL57Q@mail.gmail.com>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to netdevice
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
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

On Wed, Aug 21, 2024 at 5:15=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > On Mon, Aug 19, 2024 at 6:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 19 Aug 2024 00:44:27 +0900 Taehee Yoo wrote:
> > > > > @@ -9537,6 +9540,10 @@ static int dev_xdp_attach(struct net_devic=
e *dev, struct netlink_ext_ack *extack
> > > > >                         NL_SET_ERR_MSG(extack, "Native and generi=
c XDP can't be active at the same time");
> > > > >                         return -EEXIST;
> > > > >                 }
> > > > > +               if (dev_get_max_mp_channel(dev) !=3D -1) {
> > > > > +                       NL_SET_ERR_MSG(extack, "XDP can't be inst=
alled on a netdev using memory providers");
> > > > > +                       return -EINVAL;
> > > > > +               }
> > > >
> > > > Should we consider virtual interfaces like bonding, bridge, etc?
> > > > Virtual interfaces as an upper interface of physical interfaces can
> > > > still install XDP prog.
> > > >
> > > > # ip link add bond0 type bond
> > > > # ip link set eth0 master bond0
> > > > # ip link set bond0 xdp pin /sys/fs/bpf/x/y
> > > > and
> > > > # ip link set bond0 xdpgeneric pin /sys/fs/bpf/x/y
> > > >
> > > > All virtual interfaces can install generic XDP prog.
> > > > The bonding interface can install native XDP prog.
> > >
> > > Good point. We may need some common helpers to place the checks for X=
DP.
> > > They are spread all over the place now.
> >
> > Took a bit of a look here. Forgive me, I'm not that familiar with XDP
> > and virtual interfaces, so I'm a bit unsure what to do here.
> >
> > For veth, it seems, the device behind the veth is stored in
> > veth_priv->peer, so it seems maybe a dev_get_max_mp_channel() check on
> > veth_priv->peer is the way to go to disable this for veth? I think we
> > need to do this check on creation of the veth and on the ndo_bpf of
> > veth.
> >
> > For bonding, it seems we need to add mp channel check in bond_xdp_set,
> > and bond_enslave?
> >
> > There are a few other drivers that define ndo_add_slave, seems a check
> > in br_add_slave is needed as well.
> >
> > This seems like a potentially deep rabbit hole with a few checks to
> > add all of the place. Is this blocking the series? AFAICT if XDP fails
> > with mp-bound queues with a benign error, that seems fine to me; I
> > don't have a use case for memory providers + xdp yet. This should only
> > be blocking if someone can repro a very serious error (kernel crash)
> > or something with this combination.
> >
> > I can try to add these checks locally and propose as a follow up
> > series. Let me know if I'm on the right track with figuring out how to
> > implement this, and, if you feel like it's blocking.
> >
> > --
> > Thanks,
> > Mina
>
> I agree with the current approach, which uses the
> dev_get_min_mp_channel_count() in the dev_xdp_attach().
> The only problem that I am concerned about is the
> dev_get_min_mp_channel_count() can't check lower interfaces.
> So, how about just making the current code to be able to check lower
> interfaces?

Thank you for the code snippet! It's very useful! I have been
wondering how to walk lower/upper devices!

To be honest, I think maybe Jakub's suggestion to refactor all the
->ndo_bpf calls needs to happen anyway. The reason is that there are
->ndo_bpf calls in the core net stack, like net/xdp/xsk_buff_pool.c
and kernel/bpf/offload.c. AFAICT we need to add checks in these places
as well, so refactoring them into one place is nice?

Note I sent the refactor for review. Sorry, I forgot to CC Taehee:
https://patchwork.kernel.org/project/netdevbpf/patch/20240821045629.2856641=
-1-almasrymina@google.com/

Additionally I'm wondering if we should disable adding mp-bound
devices as slaves completely, regardless of xdp. My concern is that if
the lower device is using unreadable memory, then the upper device may
see unreadable memory in its code paths, and will not be expecting
that, so it may break. From the look at the code, it looks like
net/batman-adv calls ndo_add_slave, and a bunch of code that touches
skb_frags:

$ ackc -i ndo_add_slave
soft-interface.c
889:    .ndo_add_slave =3D batadv_softif_slave_add,

$ ackc -i skb_frag
fragmentation.c
403:    struct sk_buff *skb_fragment;
407:    skb_fragment =3D dev_alloc_skb(ll_reserved + mtu + tailroom);
408:    if (!skb_fragment)
411:    skb_fragment->priority =3D skb->priority;
414:    skb_reserve(skb_fragment, ll_reserved + header_size);
415:    skb_split(skb, skb_fragment, skb->len - fragment_size);
418:    skb_push(skb_fragment, header_size);
419:    memcpy(skb_fragment->data, frag_head, header_size);
422:    return skb_fragment;
441:    struct sk_buff *skb_fragment;
513:            skb_fragment =3D batadv_frag_create(net_dev, skb, &frag_hea=
der,
515:            if (!skb_fragment) {
522:                               skb_fragment->len + ETH_HLEN);
523:            ret =3D batadv_send_unicast_skb(skb_fragment, neigh_node);

If we disable ndo_add_slave on mp devices, then we don't need to walk
lower or upper devices. What do you think? If we don't disable mp
lower devices entirely, then yes, we can make
dev_get_min_mp_channel_count() do a recursive check.

Note that we can add support for mp bound devices as slaves in the
future if we have a use case for it, and it's well tested to be safe
with selftests added.

If we disable adding mp devices as lower devices, then during the mp
binding we should also check if the device has upper devices.

