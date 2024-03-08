Return-Path: <linux-arch+bounces-2898-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB3875CC3
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 04:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C93D1C21030
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EC2C1AA;
	Fri,  8 Mar 2024 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm4QdZGl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDC23775;
	Fri,  8 Mar 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869010; cv=none; b=KENJPlgkeWS8Jb60tO0RWZ0tYxJ/z0PNhGq5IdlPmZ+TRUwz+uwTs4Caog6Cq4D82bZSVNOlHHTAYQvQ6IlnByKtJgek8BQjrtr6btcfdlbbC56RIS05byoNcnjoAW0QDLdpZYESliC/uYjXssKGTc4mcZTs30JlMSwcCGYcesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869010; c=relaxed/simple;
	bh=vAK5UsAi1mlbmfS8eyss1ed3F+nyC6FU4MtAV8GtcKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXylPHmYZ32wBJvabKcfva9uq45q4jjmcJIspdhil3hJMZ99gSiA59f1g0xGFO92LjeQPJnh3gcLDyCe3K1pGNGUmVFCNBmZpMFwipB52v8ckwRoOCqmY1RvZpp1roXCnTTQ/g5Y07dWubhcMJ28ZsAVVJ0MuJ7f7RA6mCwlI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm4QdZGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406A1C433F1;
	Fri,  8 Mar 2024 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709869009;
	bh=vAK5UsAi1mlbmfS8eyss1ed3F+nyC6FU4MtAV8GtcKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rm4QdZGlRLCr8AAepoUDwXNJRdT/41xTmy7pgW1hC/Vkc6H2ViLXJ61BdpMlwF47t
	 wEiZLKsT0zHiG2vaTdBjyw8Yz2Jhir4s0t8rTTdInCx5QEDONETMnmxo2+grPUr68A
	 1wYgYLcJoM+s4pjo+N3FD/kjR3CM/uidkwekXtRA1OmDZpHzegKXJooc6N/abyAZ/d
	 GgwtlPgImcuZGYVCBU104HdirTzkdsXA7ah6zKSSw8gWaeFm3PGbV+wN0Ue2c0ZfvM
	 o0hGEwYCGMHnOhPGoNDMRCNboOR4rsdMIGrUcszugDtYPt5QWmNqXKb6y1C9r+LSjB
	 ENxvIiLB7g1Fg==
Date: Thu, 7 Mar 2024 19:36:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 01/15] queue_api: define queue api
Message-ID: <20240307193646.70ef5243@kernel.org>
In-Reply-To: <CAHS8izPyxn2LsOsxL98WAHse21tq3i9MCp_Xn8AA8sx5iettNQ@mail.gmail.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
	<20240305020153.2787423-2-almasrymina@google.com>
	<20240307173039.00e6fbb7@kernel.org>
	<CAHS8izPyxn2LsOsxL98WAHse21tq3i9MCp_Xn8AA8sx5iettNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 18:08:24 -0800 Mina Almasry wrote:
> On Thu, Mar 7, 2024 at 5:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Mon,  4 Mar 2024 18:01:36 -0800 Mina Almasry wrote: =20
> > > + * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
> > > + *   Allocate memory for an RX queue. The memory returned in the for=
m of
> > > + *   a void * can be passed to ndo_queue_mem_free() for freeing or to
> > > + *   ndo_queue_start to create an RX queue with this memory.
> > > + *
> > > + * void      (*ndo_queue_mem_free)(struct net_device *dev, void *);
> > > + *   Free memory from an RX queue.
> > > + *
> > > + * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
> > > + *   Start an RX queue at the specified index.
> > > + *
> > > + * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
> > > + *   Stop the RX queue at the specified index.
> > >   */
> > >  struct net_device_ops {
> > >       int                     (*ndo_init)(struct net_device *dev);
> > > @@ -1679,6 +1693,16 @@ struct net_device_ops {
> > >       int                     (*ndo_hwtstamp_set)(struct net_device *=
dev,
> > >                                                   struct kernel_hwtst=
amp_config *kernel_config,
> > >                                                   struct netlink_ext_=
ack *extack);
> > > +     void *                  (*ndo_queue_mem_alloc)(struct net_devic=
e *dev,
> > > +                                                    int idx);
> > > +     void                    (*ndo_queue_mem_free)(struct net_device=
 *dev,
> > > +                                                   void *queue_mem);
> > > +     int                     (*ndo_queue_start)(struct net_device *d=
ev,
> > > +                                                int idx,
> > > +                                                void *queue_mem);
> > > +     int                     (*ndo_queue_stop)(struct net_device *de=
v,
> > > +                                               int idx,
> > > +                                               void **out_queue_mem)=
; =20
> >
> > The queue configuration object was quite an integral part of the design,
> > I'm slightly worried that it's not here :) =20
>=20
> That was a bit of a simplification I'm making since we just want to
> restart the queue. I thought it was OK to define some minimal version
> here and extend it later with configuration? Because in this context
> all we really need is to restart the queue, yes?

Right, I think it's perfectly fine for the time being.
It works, and is internal to the kernel.

> If extending with some configuration is a must please let me know what
> configuration struct you're envisioning. Were you envisioning a stub?
> Or some real configuration struct that we just don't use at the
> moment? Or one that we use for this use case somehow?

I had some ideas about storing the configuration as rules,
instead of directly in struct netdev_rx_queue.
E.g. default queue length =3D 2000, but for select queues you may
want a different length.
But application binding to a queue would always take precedence,=20
so even if the ideas ever materialize there will be no uAPI change.

> > Also we may want to rename
> > the about-to-be-merged ops from netdev_stat_ops and netdev_queue_ops,
> > and add these there?
> >
> > https://lore.kernel.org/all/20240306195509.1502746-2-kuba@kernel.org/
>=20
> Yeah, that sounds reasonable! Thanks! We could also keep the
> netdev_stat_ops and add new netdev_queue_ops alongside them if you
> prefer.

Up to you, after some soul searching we renamed the uAPI to call these
stats qstats, I just forgot to rename the op struct. But it doesn't
matter much.

> > Very excited to hear that you made progress on this and ported GVE over=
! =20
>=20
> Actually, we're still discussing but it looks like my GVE queue API
> implementation I proposed earlier may be a no-go. Likely someone from
> the GVE team will follow up here with this piece, probably in a
> separate series.

Well, it's going to be ready when it's ready :)
Speaking of things which can be merged independently,
feel free to post patch 3, maybe it can make v6.9..

> For now I'm carrying my POC for the GVE implementation out of tree
> with the rest of the driver changes:
>=20
> https://github.com/mina/linux/commit/501b734c80186545281e9edb1bf313f5a2d8=
cbee

