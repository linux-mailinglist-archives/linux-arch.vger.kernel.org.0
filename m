Return-Path: <linux-arch+bounces-5362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1392DC10
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 00:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678352833A1
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8C152515;
	Wed, 10 Jul 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdjJ17+5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68D148FED
	for <linux-arch@vger.kernel.org>; Wed, 10 Jul 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651541; cv=none; b=r3e2zsifdpbHajC60h562zunyQLYFI3zTrDdzuDt28ZptQ+Rx8i1nCZaVm7i0+ifjR8NFCTVY0jh4q74JRkc1Mfsgd9oEeyb2W75wJKSCb9Xw8UWUtzxT4nBEzyqIQgwvUPXMflkP4UY5AYgkE18onwzgjBpD7UtcpJeCoEgdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651541; c=relaxed/simple;
	bh=zEZ4qa1KY5W/ArZqfvSqtxOP5I0qkz6xjUA5gKFEtjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOJHLoj2miGZy7EVjwz9uQlcc61VYPFcEQXvva+9I3ezSU2VtYEJ63HU7Fbp8qf9mOn1W1o1PQeS6L2yqIQc6D3qdnSn2QvMI2VrGQsx3ZgCHJNjibUb6q29vrO1yl9LnmEsuIYGNinHN9wnWR8nF1WW7+MTZwkNFltQSgdZdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdjJ17+5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5dd7cd945so1727056d6.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Jul 2024 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720651535; x=1721256335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewitibS3zX+WzUTqst3po2B/GkvecNeXUFCMiBjweyg=;
        b=tdjJ17+5BiKAbEvFm/bTZZzzeiiuS2bzDiid0gXaBYsG5QBdfjBTyZ10S1L+z9OmfJ
         i2b8kliyvcF2mUD5KyQmAplFOedGO69LhmT6jJWy0JP68Z7LqfmLCFJojtm7G1D6xahE
         BGELmK27tCIRvjRszqt74+slO+hb0WcuzSCNTbmccmZrVUxtZ8NzK7VoL7+HjIQ6V1ws
         9maAlusmQ8tdmc4g2j152mq/GNfVm37aQb4hCFbmvL6lnexAPE1M4CtbZry8Xy9j+Gg8
         9kNGJvyZ6yZsJV9OfllYLEj+k3aADj7IaE3Fs50CuDe6z1ztPvz33gASo+aPVafropCy
         jrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720651535; x=1721256335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewitibS3zX+WzUTqst3po2B/GkvecNeXUFCMiBjweyg=;
        b=YNfnBCrkU+MS9YP0q5MksbWwg+L7YbL9/MlOSWaEOECPERZIXdCIR7INSuwiu3x9ab
         rj3BascUqEJzPHACz9Z7UAiL3IwOBviWudoBfk7uH8yfXlRHDUX9PeWK0dRSFlZaFsgM
         W2FAP8WnE1mdpm5u5qwUxfaTYoxe4BSGJNGDmfqGfZj5R4iFk3pDPoFAoo/foU3wh4IP
         Pm5mIjnI2Go7dAmuXVOvq4kaG+x1k7nroNr5Y0mYuefP69Jnp+AtjJaP2mDqd1RLAdPC
         y4lWEy2LUlwolfujX5+vYGf7mhfy3VVNyf7BBY/MkvscZrZsDZF8gVHMdfp7efk6qPiC
         ayow==
X-Forwarded-Encrypted: i=1; AJvYcCUxq7I68VxX/JG2DZZLyDon3vRxmJlvyGH+JPONzH4Ia2Cw3V97fpNbi+UlDjz5sSXm5tbWGHC855fOkON9wXOQATTAZCWahbAlWA==
X-Gm-Message-State: AOJu0Yxna5OtoSz3XYCUsIPnrcVwj/+6RLW6CwLs2LASJkJgk0PVoByA
	0LeBqEXEnSG9gZ1fm3C9Xoy+Q6nkp7kZJLRrCdFYwEpK39qEwDPeDM3q8PNDE2O+MVCR8cX3zzE
	/H0v0koIDVY69KX5ZlH3Ea9HdPwY2jmzCTktd
X-Google-Smtp-Source: AGHT+IF5eUrWI3iGBloyaIenGjn6niXEyyaOV4S/5O4aymX7e6kogYU+UbBk/KI5YYE/pmMB4biArqXH6clq6XINtH0=
X-Received: by 2002:ad4:5c68:0:b0:6b5:d9ef:d576 with SMTP id
 6a1803df08f44-6b61bc80440mr73134066d6.12.1720651534418; Wed, 10 Jul 2024
 15:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710001749.1388631-1-almasrymina@google.com>
 <20240710001749.1388631-5-almasrymina@google.com> <20240710093624.26d22f02@kernel.org>
 <CAHS8izOoM3YfcQorLJXL4H+t2OL+oJ4fPP5ZBJRhnH5AxsUqfQ@mail.gmail.com> <20240710125533.7a14bbe7@kernel.org>
In-Reply-To: <20240710125533.7a14bbe7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 10 Jul 2024 15:45:19 -0700
Message-ID: <CAHS8izMhTKndLEYrCyNK5WcUHQB6iXefr1=TcxKNxd+ghJGp0w@mail.gmail.com>
Subject: Re: [PATCH net-next v16 04/13] netdev: netdevice devmem allocator
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Jul 2024 12:29:58 -0700 Mina Almasry wrote:
> > On Wed, Jul 10, 2024 at 9:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Wed, 10 Jul 2024 00:17:37 +0000 Mina Almasry wrote:
> > > > +     net_devmem_dmabuf_binding_get(binding);
> > >
> > > Why does every iov need to hold a ref? pp holds a ref and does its ow=
n
> > > accounting, so it won't disappear unless all the pages are returned.
> >
> > I guess it doesn't really need to, but this is the design/approach I
> > went with, and I actually prefer it a bit. The design is borrowed from
> > how struct dev_pagemap does this, IIRC. Every page allocated from the
> > pgmap holds a reference to the pgmap to ensure the pgmap doesn't go
> > away while some page that originated from it is out in the wild, and
> > similarly I did so in the binding here.
>
> Oh, you napi_pp_put_page() on the other end! I can see how that could
> be fine.
>
> > We could assume that the page_pool is accounting iovs for us, but that
> > is not always true, right? page_pool_return_page() disconnects a
> > netmem from the page_pool and AFAIU the page_pool can go away while
> > there is such a netmem still in use in the net stack. Currently this
> > can't happen with iovs because I currently don't support non-pp
> > refcounting for iovs (so they're always recyclable), but you have a
> > comment on the other patch asking why that works; depending on how we
> > converge on that conversation, the details of how the pp refcounting
> > could change.
>
> Even then - we could take the ref as the page "leaks" out of the pool,
> rather than doing it on the fast path, right? Or just BUG_ON() 'cause
> that reference ain't coming back ;)
>

OK, I'll see how the conversation on the other thread converges
vis-a-vis net_iov refcounting happens, and then look at if I can avoid
the binding_get/put per page in that framework.

> > It's nice to know that the binding refcounting will work regardless of
> > the details of how the pp refcounting works. IMHO having the binding
> > rely on the pp refcounting to ensure all the iovs are freed introduces
> > some fragility.
> >
> > Additionally IMO the net_devmem_dmabuf_binding_get/put aren't so
> > expensive to want to optimize out, right? The allocation is a slow
> > path anyway and the fast path recycles netmem.
>
> Yes, I should have read patch 10. I think it's avoidable :) but with
> recycling it can indeed perform just fine (do you happen to have
> recycling rate stats from prod runs?)

I don't to be honest. For a couple of reasons, one is that gcloud VMs
where we mainly use this, these stats are private to the VM and is not
something I can query widly. I only get access to the data when shared
with bug reports on specific issues.

In our internal test runs, I do not monitor the recycling rate to be
honest, as that is fine as long as the recycling is fast enough to
find available memory for incoming data. What I do look at very
closely is the allocation failure rate. That is when GVE tries to
alloc a new devmem but it's out of devmem (which would likely be due
to recycling not happening fast enough). The stat is `page_alloc_fail`
in ethtool -S for us and it's one of the first things I check when
things go wrong. It hasn't been the root cause for any of our issues
in reality.

--
Thanks,
Mina

