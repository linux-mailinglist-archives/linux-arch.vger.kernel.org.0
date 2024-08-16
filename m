Return-Path: <linux-arch+bounces-6256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0F9548A1
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E731F24322
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBCB1B3F3D;
	Fri, 16 Aug 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vepJIgQv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968341AD9F9
	for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810861; cv=none; b=iDypcpqHS60jeNI7pw+m4PkTzqZXEx3cOEUIVAuSA/LZl5wnJR7oKiUrvzS7Q5JZp/gOeQQMU5ncJnGquGM8aC3ARAjm32U0oM3S7rtw0BiBu4GKqNTm6lPCOSXAeTNPqY5Kk0BHwy5AXx1ehjhZhnIT44jYelQcnJGluWMkW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810861; c=relaxed/simple;
	bh=uDHRwF0otXkj+agrQEA0lwHEUq1GTb5X3dySo2OqWmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evI28vOPRYQvoqjKU/735H3SNKoqbi0yJhWEvbxvQLKxImyHlfa8sDQVG6FqB3yRRlru9yrDOZjaI7leW/6QmQLyEdbodwacWY1FBtl2PhUyaQ0v6nY5zGwRg2iapu7H9953B361BVAMno8sVm7E74oV2O3Plnws2amMu1SARs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vepJIgQv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a5074ebb9aso45159285a.1
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723810857; x=1724415657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60gFb7YBVOLPqGwy/Oc6xhCaH/QA9b9t6B6yBp4eA0s=;
        b=vepJIgQvm2wUGg7wPKHnb+cadQKMpOzbWijLOw8Y601NGnc5kVVQQPvwKuFuHmO9dT
         MJgiqk3ifseVfRq/1H89bggOm/n7pq2Mm8dmsp81hGSa5WPe8joH83P6y+SfpVSL5VCH
         lZLxAXq0w4X5pjPxczK8MnzECXq4GfetXQZQfQsE1q5cckXfkWtkW5TRvbSxcOYtVr4U
         /ROBZ3uaTofnbmaov+YziEU4mN5Jx1qhndecyk+dDXswFTYJQF2zRTdUbbakad1/rIsM
         DwzU5Muj2HTFtxM1/A66Nbfr3az4ejPZ29MAKl9DO+8SgPw7kWqtxMFRF8n5JpvPCqFk
         yYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810857; x=1724415657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60gFb7YBVOLPqGwy/Oc6xhCaH/QA9b9t6B6yBp4eA0s=;
        b=SZT35GYrcMTSGvyOZ7DW6LoHFekp1LC5xR/DzMrw6Y7r4JEYzEShTgj88eRUjwKEWs
         geu3CNI9zK00RWzwxwW1lNh4ddDm0OTsy14w8Qa8vEKxbKibDos3fmkRj9hxHnj+cxH7
         7N2urno61bl06thGy0rOD0BojSbmnnrjSWI+WFetIHKAuAV7ovTiHsDGoAfkS51/zlWd
         gP3JTddfI8p9N8FpxRZml1pvxUOmSx2JKucll+BFgDjQGo3Gn1vNJ3qOI7nRZ4EWtnQY
         O0r0P5g2Xy01ehWr+fZ2ufhzPYT8HTzPdSwa/Ge2X5AAj8v8Kv2MzKoGyit/8c7IfeGs
         4Otw==
X-Forwarded-Encrypted: i=1; AJvYcCXp82TYhcC3m6rCLHv9WgGMWXhNfMTGCtDkxnplCqmkJ3cOoJN7AjXAMt1OteWoqUNm6mn+HbWhpZJNzqCG/qaYOyf3aENZUErgcA==
X-Gm-Message-State: AOJu0YxpNLOpLCj5K5ZPN31TKqkxMJ+DDM8yUtO/t3bIaZPWuGjU+IIq
	rb/4/LY5vlt4lEY3Hgn+CibuwuMcazkM9NxFgg+HGjvsAL54mTp2YPdPk1qvJP6FWciIQIH6Q4W
	qf+XWvaPpWdOdoICPRR4PXb42qFKiSfVbtAz9
X-Google-Smtp-Source: AGHT+IGZmdSIKsIbNLMCWhDr7siS0fg53Dzm3mUEgRlOmZUGtYHuIW2VVl49SrIQcFwsu42Q03aJr/PwI9drpzidh7Q=
X-Received: by 2002:a05:6214:5713:b0:6bf:7c34:e419 with SMTP id
 6a1803df08f44-6bf7cdcb101mr38991616d6.5.1723810857192; Fri, 16 Aug 2024
 05:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-7-almasrymina@google.com>
 <de7daf80-a2e4-4451-b666-2a67ccc3649e@gmail.com> <CAHS8izPMC+XhXKbJOQ3ymizyKuARSOv_cO_xO+q1EG4zoy6Gig@mail.gmail.com>
 <31640ff4-25a6-4115-85e6-82092ce57393@gmail.com> <20240815182245.2b5e3f44@kernel.org>
In-Reply-To: <20240815182245.2b5e3f44@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 16 Aug 2024 08:20:44 -0400
Message-ID: <CAHS8izO9LDM9rLVnJPgp6QXb4YLW5+3ziGOHTqScy-SKOLejYA@mail.gmail.com>
Subject: Re: [PATCH net-next v19 06/13] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 14 Aug 2024 17:32:53 +0100 Pavel Begunkov wrote:
> > > This is where I get a bit confused. Jakub did mention that it is
> > > desirable for core to verify that the driver did the right thing,
> > > instead of trusting that a driver did the right thing without
> > > verifying. Relying on a flag from the driver opens the door for the
> > > driver to say "I support this" but actually not create the mp
> > > page_pool. In my mind the explicit check is superior to getting
> > > feedback from the driver.
> >
> > You can apply the same argument to anything, but not like
> > after each for example ->ndo_start_xmit we dig into the
> > interface's pending queue to make sure it was actually queued.
> >
> > And even if you check that there is a page pool, the driver
> > can just create an empty pool that it'll never use. There
> > are always ways to make it wrong.
> >
> > Yes, there is a difference, and I'm not against it as a
> > WARN_ON_ONCE after failing it in a more explicit way.
> >
> > Jakub might have a different opinion on how it should look
> > like, and we can clarify on that, but I do believe it's a
> > confusing interface that can be easily made better.
>
> My queue API RFC patches had configuration arguments, not sure if this
> is the right version but you'll get the idea:
> https://github.com/kuba-moo/linux/blob/qcfg/include/net/netdev_cfg.h#L43-=
L50
> This way we can _tell_ the driver what the config should be. That part
> got lost somewhere along the way, because perhaps in its embryonic form
> it doesn't make sense.
>
> We can bring it back, add HDS with threshold of 0, to it, and a bit for
> non-readable memory. On top of that "capability bits" in struct
> netdev_queue_mgmt_ops to mark that the driver pays attention to particula=
r
> fields of the config.
>
> Not sure if it should block the series, but that'd be the way I'd do it
> (for now?)
>

I'm not sure I want to go into a rabbit hole of adding configuration
via the queue API, blocking this series . We had discussed this months
back and figured that it's a significant undertaking on its own. I'm
not sure GVE has HDS threshold capability for example, and I'm also
not sure how to coexist header split negotiability via the queue API
when an ethtool API exists alongside it. I think this is worthy of
separating in its own follow up series.

For now detecting that the driver was able to create the page_pool
with the correct memory provider in core should be sufficient. Also
asking the driver to set a
netdev_rx_queue->unreadable_netmem_supported flag should also be
sufficient. I've implemented both locally and they work well.

> I'd keep the current check with a WARN_ON_ONCE(), tho.
> Given the absence of tests driver developers can use.
> Especially those who _aren't_ supporting the feature.
>

Yes what I have locally is the driver setting
netdev_rx_queue->unreadable_netmem_supported when header split is
turned on, and additionally a WARN_ON_ONCE around the check in core. I
was about to send that when I read your email. I'm hoping we don't
have to go through the scope creep of adding configuration via the
queue API, which I think is a very significant undertaking.

> > > and cons to each approach; I don't see a showstopping reason to go
> > > with one over the other.
> > >
> > >> And page_pool_check_memory_provider() is not that straightforward,
> > >> it doesn't walk through pools of a queue.
> > >
> > > Right, we don't save the pp of a queue, only a netdev. The outer loop
> > > checks all the pps of the netdev to find one with the correct binding=
,
> > > and the inner loop checks that this binding is attached to the correc=
t
> > > queue.
> >
> > That's the thing, I doubt about the second part.
> >
> > net_devmem_bind_dmabuf_to_queue() {
> >       err =3D xa_alloc(&binding->bound_rxqs, &xa_idx, rxq);
> >       if (err)
> >               return err;
> >
> >       netdev_rx_queue_restart();
> >
> >       // page_pool_check_memory_provider
> >       ...
> >       xa_for_each(&binding->bound_rxqs, xa_idx, binding_rxq) {
> >               if (rxq =3D=3D binding_rxq)
> >                       return success;
> > }
> >
> > Can't b4 the patches for some reason, but that's the highlight
> > from the patchset, correct me if I'm wrong. That xa_for_each
> > check is always true because you put the queue in there right
> > before it, and I don't that anyone could've erased it.
> >
> > The problem here is that it seems the ->bound_rxqs state doesn't
> > depend on what page pools were actually created and with what mp.
>
> FWIW I don't understand the point of walking the xa either.
> Just check the queue number of the pp you found matches,
> page pool params are saved in the page pool. No?
>

Yes, I changed this check to check pool->p.queue, and it works fine.

--=20
Thanks,
Mina

