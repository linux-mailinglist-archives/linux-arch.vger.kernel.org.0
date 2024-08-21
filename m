Return-Path: <linux-arch+bounces-6430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42A95A376
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970DC284D1B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089C1B1D74;
	Wed, 21 Aug 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC5BghUB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609D13E022;
	Wed, 21 Aug 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259873; cv=none; b=kn3c1Wpuy26NeDA+VHkhD0yxAEugOX0Wvvcq3vPrExnO+ShZPZ3biwJw2bofm9GYocdqkgOvuzcuFEYWRiLaxNGcDxvHwUvkne3LEhIVgZDjbxpO5S9GbKkqCJumRzBMLSMYsW71sfqRcuXhVMo2HvqdK9HjM6pWWxoFXJKOlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259873; c=relaxed/simple;
	bh=15WLqFfb3kOd25SGvlFnNvjfMM7hn7Ze6cddrnJFpig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0srRoin7jjiI+9EWDtj6gzcYWdA933cQysz9LHgWedHDwGx3DFz+naT1CxegyHLvMDWPZlh5dwdTuii2sY7oAIy/rMVa8mMC9U6mP5paFECqVbK2bIBtJOKML1LGmhaDd2tniLq0sarBfF1PBNgoR1mXCmOdPevW5zzFu8QYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC5BghUB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f16767830dso72046021fa.0;
        Wed, 21 Aug 2024 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724259870; x=1724864670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5piVzblVPFAtLFSe16jLGKIEUz2rAIQiJS543JMertA=;
        b=ZC5BghUBbQynTPgyePh7Wu7W0C+KS9g39wYujox+pTXAgIb/etBs1923gDsNvu6KcT
         /QoN/D+RDXzu3NP9Gs9u3N/xCTEJlLoUoX2Bgjeyz3j7zxemzDximihKGPi3tkrDoBhv
         X+9gKlTRnrbLsiHeGmlV5ySeqzbX0Jsmu4bNksh6k1ZM0g2I6Rnu+CR0VB6b4hbqAP3x
         r8s+TGrxkNmY0qWX8cMdykCPsD1aIj+TuAbbjFngCXrDPbe0qqxobJqJ5HYDdXt6kkBN
         EJTUYGmQ6Qnkn1adG7iMvKIhVzi03p3fghPofDXp88b8LEuBQ/tHbbk6bxGmsBirbwR4
         acZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259870; x=1724864670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5piVzblVPFAtLFSe16jLGKIEUz2rAIQiJS543JMertA=;
        b=VTgSNwSXP3O0m8cyYJzrtQoMEd32xSpR7o+zj6MJtZWIzcC7tMVpN3/obY7sMviQUL
         qNo92iZWMixOt5qqcnJR87FNmwv6KSMm8UDo6Lnn/aThRG9+xOjPzQMnmpIh2jD+edbj
         IJ46sQiwy38YWiWGr4V/TnKGuMrojjrgmAUXD0pGgMvNKiys0ZkUju4OeUe28tNx/emj
         afVjTpx7UBf0osMzRKQfs6cPPyngVwrubu8X1Bv6gfnt47ZElTJpoW3QGvbjl5LgerAz
         0wmTOi3z7p3RcfmHmvU31j5LXbtIz+05XW678+47Up9aN/oVZHjueoHoJBlbKFBiMSdm
         MJZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/eVsx8Ckw2czDewohiQZZU0aA2MlGdWqEeDONbB+6/8BUENMTkHYbSE1pUTTViwYNYQybDbnNjdj9K7Q=@vger.kernel.org, AJvYcCU1jTuKWK3b10IffiyzVsA77pMO2tR6wZjMgvCXZlmau3nG+gxgwRl6mvByx48CzG+GahU7hw2sQbB1O7A=@vger.kernel.org, AJvYcCUkQpUGtyUXuOm/gaq+ZjqDAErjfpJo4pdCalhtrYyae+/KZ0j2xKqQXCGbfZKuuZciugL/48FGOa3XmA==@vger.kernel.org, AJvYcCVnH1GL7Mukvnttlotv2KBdtzPsOV02uEZYi2HXCs3D31PotwB2cTXikujlGEp8eFStmGwB8YNJ+thKk7VaKtmA@vger.kernel.org, AJvYcCVwi7dtDx/c5a14NlB2/l1oL9IM7Q6ZFWV0d99uqhw5xBGbvQr2PqnZEpKSdqvYp+tz6rVcLfl5js8d@vger.kernel.org, AJvYcCWAt/10SJIzVNsiqppld6U5QHKQMhyclXQ5lJymseJGJjUXJyXHRCboY8TrzETrIVjDD0G9Y/UaE0Hkdbcfa7YIj1+Z@vger.kernel.org, AJvYcCWT0NWIKsx8XTETiIS0gg4XxVDD5DhP9gQKUecumR0h1swIg2EocbWEZLWv9vDax9HvpiaxzDEIc5evmE4m@vger.kernel.org, AJvYcCWWqO7Cl3Q+H84MC9pcyf99vTWE6HclsDyVciWK5ytFynEDeUtezk3b3Py2tyVIWVLOxKfVd2BtML55WA==@vger.kernel.org, AJvYcCWnre+fSgPZdDkHf5ZVdmzqhSTsy2OuvCqTxEXFkmnoVaVnJBouOgCRB7tZ12BBKBF+bNTVPm4B@vger.kernel.org, AJvYcCXQ8eARy7c1
 /9Kl5OsaVa0DuuXI1g3Zt2Aq9+V4S3suMz7hunERGGzAnDBRO2Zm6aUIYYj4N0pGCvIkpZ8u@vger.kernel.org, AJvYcCXggVRhhSLCrZaRoSLLT/3l/oNKnmlBOXwHXsHCb+sw/P39QxiTznERtIff0AoBxLc9TyA=@vger.kernel.org, AJvYcCXiZkMpv++9PvWTjgELsWkpQiyZJvT35uUiUucXtcjLXwbeJ/rBCtdMnGba/23xKcKSnBpvgWe33A201Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQir4tx8NFCj3nodErOJTTy/MMbSaCuQjKGU1Yi5kVPiOJeVNA
	OApr2S5QDWNSKs0hxMvAt00IEQxTRpCZbdS0hzTJwjAiY1UG/ynCy+RPKSQX7TLub1W/7YjMuYD
	PYV0zBWCOCYlkqq/vTd/wI/+5XUE=
X-Google-Smtp-Source: AGHT+IHzZV/giO/I7s4NBO6ZU6CfBA9bjDK+AvrOdBFxdHqFSIdNI5DYOQkBjzPeLU83ZjPWGkkffh5DTbBtO3XhBTA=
X-Received: by 2002:a05:651c:1549:b0:2ef:2a2a:aaa1 with SMTP id
 38308e7fff4ca-2f3f890e224mr17047021fa.29.1724259869189; Wed, 21 Aug 2024
 10:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-4-almasrymina@google.com>
 <CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
 <20240819155257.1148e869@kernel.org> <CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
 <CAMArcTXvccYBPZTEuW-z=uTK7W67utd9-xjPzfxEOvUWhPS7bg@mail.gmail.com> <CAHS8izPZ9Jiu9Gj+Kk3cQ_+t22M4n4-mbPLhx+fti_HiWzL57Q@mail.gmail.com>
In-Reply-To: <CAHS8izPZ9Jiu9Gj+Kk3cQ_+t22M4n4-mbPLhx+fti_HiWzL57Q@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 22 Aug 2024 02:04:17 +0900
Message-ID: <CAMArcTX=TZ+nQkvDyOkiM5Mmh0V3L7bna7FjiUS7d6KermJwdA@mail.gmail.com>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>
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

On Thu, Aug 22, 2024 at 12:36=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Wed, Aug 21, 2024 at 5:15=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 6:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, 19 Aug 2024 00:44:27 +0900 Taehee Yoo wrote:
> > > > > > @@ -9537,6 +9540,10 @@ static int dev_xdp_attach(struct net_dev=
ice *dev, struct netlink_ext_ack *extack
> > > > > >                         NL_SET_ERR_MSG(extack, "Native and gene=
ric XDP can't be active at the same time");
> > > > > >                         return -EEXIST;
> > > > > >                 }
> > > > > > +               if (dev_get_max_mp_channel(dev) !=3D -1) {
> > > > > > +                       NL_SET_ERR_MSG(extack, "XDP can't be in=
stalled on a netdev using memory providers");
> > > > > > +                       return -EINVAL;
> > > > > > +               }
> > > > >
> > > > > Should we consider virtual interfaces like bonding, bridge, etc?
> > > > > Virtual interfaces as an upper interface of physical interfaces c=
an
> > > > > still install XDP prog.
> > > > >
> > > > > # ip link add bond0 type bond
> > > > > # ip link set eth0 master bond0
> > > > > # ip link set bond0 xdp pin /sys/fs/bpf/x/y
> > > > > and
> > > > > # ip link set bond0 xdpgeneric pin /sys/fs/bpf/x/y
> > > > >
> > > > > All virtual interfaces can install generic XDP prog.
> > > > > The bonding interface can install native XDP prog.
> > > >
> > > > Good point. We may need some common helpers to place the checks for=
 XDP.
> > > > They are spread all over the place now.
> > >
> > > Took a bit of a look here. Forgive me, I'm not that familiar with XDP
> > > and virtual interfaces, so I'm a bit unsure what to do here.
> > >
> > > For veth, it seems, the device behind the veth is stored in
> > > veth_priv->peer, so it seems maybe a dev_get_max_mp_channel() check o=
n
> > > veth_priv->peer is the way to go to disable this for veth? I think we
> > > need to do this check on creation of the veth and on the ndo_bpf of
> > > veth.
> > >
> > > For bonding, it seems we need to add mp channel check in bond_xdp_set=
,
> > > and bond_enslave?
> > >
> > > There are a few other drivers that define ndo_add_slave, seems a chec=
k
> > > in br_add_slave is needed as well.
> > >
> > > This seems like a potentially deep rabbit hole with a few checks to
> > > add all of the place. Is this blocking the series? AFAICT if XDP fail=
s
> > > with mp-bound queues with a benign error, that seems fine to me; I
> > > don't have a use case for memory providers + xdp yet. This should onl=
y
> > > be blocking if someone can repro a very serious error (kernel crash)
> > > or something with this combination.
> > >
> > > I can try to add these checks locally and propose as a follow up
> > > series. Let me know if I'm on the right track with figuring out how t=
o
> > > implement this, and, if you feel like it's blocking.
> > >
> > > --
> > > Thanks,
> > > Mina
> >
> > I agree with the current approach, which uses the
> > dev_get_min_mp_channel_count() in the dev_xdp_attach().
> > The only problem that I am concerned about is the
> > dev_get_min_mp_channel_count() can't check lower interfaces.
> > So, how about just making the current code to be able to check lower
> > interfaces?
>
> Thank you for the code snippet! It's very useful! I have been
> wondering how to walk lower/upper devices!
>
> To be honest, I think maybe Jakub's suggestion to refactor all the
> ->ndo_bpf calls needs to happen anyway. The reason is that there are
> ->ndo_bpf calls in the core net stack, like net/xdp/xsk_buff_pool.c
> and kernel/bpf/offload.c. AFAICT we need to add checks in these places
> as well, so refactoring them into one place is nice?
>
> Note I sent the refactor for review. Sorry, I forgot to CC Taehee:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240821045629.28566=
41-1-almasrymina@google.com/
>

I agree that it requires refactoring.
The dev_xdp_propagate() will be useful.

> Additionally I'm wondering if we should disable adding mp-bound
> devices as slaves completely, regardless of xdp. My concern is that if
> the lower device is using unreadable memory, then the upper device may
> see unreadable memory in its code paths, and will not be expecting
> that, so it may break. From the look at the code, it looks like
> net/batman-adv calls ndo_add_slave, and a bunch of code that touches
> skb_frags:
>
> $ ackc -i ndo_add_slave
> soft-interface.c
> 889:    .ndo_add_slave =3D batadv_softif_slave_add,
>
> $ ackc -i skb_frag
> fragmentation.c
> 403:    struct sk_buff *skb_fragment;
> 407:    skb_fragment =3D dev_alloc_skb(ll_reserved + mtu + tailroom);
> 408:    if (!skb_fragment)
> 411:    skb_fragment->priority =3D skb->priority;
> 414:    skb_reserve(skb_fragment, ll_reserved + header_size);
> 415:    skb_split(skb, skb_fragment, skb->len - fragment_size);
> 418:    skb_push(skb_fragment, header_size);
> 419:    memcpy(skb_fragment->data, frag_head, header_size);
> 422:    return skb_fragment;
> 441:    struct sk_buff *skb_fragment;
> 513:            skb_fragment =3D batadv_frag_create(net_dev, skb, &frag_h=
eader,
> 515:            if (!skb_fragment) {
> 522:                               skb_fragment->len + ETH_HLEN);
> 523:            ret =3D batadv_send_unicast_skb(skb_fragment, neigh_node)=
;
>
> If we disable ndo_add_slave on mp devices, then we don't need to walk
> lower or upper devices. What do you think? If we don't disable mp
> lower devices entirely, then yes, we can make
> dev_get_min_mp_channel_count() do a recursive check.
>
> Note that we can add support for mp bound devices as slaves in the
> future if we have a use case for it, and it's well tested to be safe
> with selftests added.
>
> If we disable adding mp devices as lower devices, then during the mp
> binding we should also check if the device has upper devices.

I truly agree with this idea!
Almost all virtual interfaces as an upper interface of mp_bound devices
especially tunneling interfaces will not work.
As you already know there are several reasons.
1. HDS wouldn't work due to tunneling header.
2. RSS wouldn't work due to tunneling header.
So, I agree that we disable setting up virtual interfaces as an
upper interface of mp_bound devices.
Then as you said, we can allow only confirmed interface types
in the future.

The IPsec is also not working with mp_bound devices due to the same
reason. It would be a more complex issue, unfortunately, I don't know
how to deal with it.

